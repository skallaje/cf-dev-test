/**
*
* @file  DatabaseSessionManagementService.cfc
* @author  Denard Springle (denard.s@meetingplay.com)
* @description I provide database session management for the Security Service
*
*/

/* NOTE: This file has been modified for use with the fusion base code
   instead of ColdBox based applications. Please use the version of this
   file from the coldbox_base_app inside of appbuilder for ColdBox apps instead
*/

component output="false" displayname="DatabaseSessionManagementService" implements="models.interfaces.ISessionManagement" {

	/* SESSION MANAGEMENT

		Provides functions to help manage logged on user sessions.

		Functions include:
			checking if a user's session exists in the database 
			creating a new user session after authentication 
			storing, clearing, and updating a user's session object
			generating and rotating a user's session id

	*/

	public function init() {
		return this;
	}


	/**
	* @displayname	checkUserSession
	* @description	I retrieve the users session object from database, and return it if it exists, else I return a blank session object
	* @param		userType {String} required - I am the session type to check
	* @param		sessionId {String} required - I am the session id to check
	* @return		any
	*/
	public any function checkUserSession( string userType = '', required string sessionId ) {

		// get the userAuthSessionService
		var userAuthSessionService = new models.services.UserAuthSessionService();

		// try to
		try {

			// get the session object from the database
			var sessionObj = userAuthSessionService.getUserAuthSessionBySessionId( arguments.sessionId );

		// catch any errors
		} catch( any e ) {

			// return an empty session object
			return new models.beans.UserAuthSessionBean();

		}

		// ensure it is still in the database
		if( !len( sessionObj.getSessionId() ) ) {

			// it isn't, return an empty session object
			return new models.beans.UserAuthSessionBean( userRole = 'session object not in database' );

		// otherwise, ensure the session shouldn't have already expired (30 mins)
		} else if( dateDiff('n', sessionObj.getLastActionAt(), now() ) gte application.timeoutMinutes ) {

			// it should have expired, return an empty session object
			return new models.beans.UserAuthSessionBean( userRole = 'expired session' );

		// otherwise, ensure that the hmac code matches for this session
		} else if( len( sessionObj.getHmacCode() ) and dataHmac( arguments.sessionId ) neq sessionObj.getHmacCode() ) {

			// it doesn't match, return an empty session object
			return new models.beans.UserAuthSessionBean( userRole = 'missing hmac' );

		// otherwise
		} else {

			// session is valid, return the session object
			return sessionObj;

		}

	}

	/**
	* @displayname	createUserSession
	* @description	I generate and return a session object based on passed in values
	* @param		userUid {String} required - I am the user guid of the user to generate a session for
	* @return		any
	*/
	public any function createUserSession( required string userUid ) {

		// create a session object based on the passed in arguments
		var sessionObj = new models.beans.UserAuthSessionBean(
			userAuthSessionUid = getGuid(),
			sessionId = getSessionId(),
			userUid = arguments.userUid,
			lastActionAt = now()
		);

		// save the user session to the database
		setUserSession( sessionObj );

		// and return the session object
		return sessionObj;

	}

	/**
	* @displayname	setUserSession
	* @description	I store a sessio0n object in the database
	* @param		sessionObj {Any} required - I am the session object to store in the database
	* @return		void
	*/
	public void function setUserSession( required any sessionObj ) {

		// get the userAuthSessionService
		var userAuthSessionService = new models.services.UserAuthSessionService();

		userAuthSessionService.saveUserAuthSession( arguments.sessionObj );

	}

	/**
	* @displayname	clearUserSession
	* @description	I remove a sessio0n object from the database
	* @param		sessionObj {Any} required - I am the session object to clear from the database
	* @return		void
	*/
	public void function clearUserSession( required any sessionObj ) {

		// get the userAuthSessionService
		var userAuthSessionService = new models.services.UserAuthSessionService();

		// delete the user's session
		structDelete( session, 'user' );

		// remove the user's session object from the database 
		userAuthSessionService.deleteUserAuthSessionByUid( arguments.sessionObj.getUserAuthSessionUid() );

	}

	/**
	* @displayname	rotateUserSession
	* @description	I update the session id of a session object 
	* @param		sessionObj {Any} required - I am the session object to rotate the id for
	* @return		any
	*/
	public any function rotateUserSession( required any sessionObj ) {

		// assign a new session id to the session object
		arguments.sessionObj.setSessionId( getSessionId() );

		// and return the session object
		return arguments.sessionObj;

	}

	/**
	* @displayname	updateUserSession
	* @description	I update the last action at of a session object, remove the old session and save the new one 
	* @param		sessionObj {Any} required - I am the session object to update
	* @return		any
	*/
	public any function updateUserSession( required any sessionObj ) {

		// clear out the existing user's session
		// clearUserSession( arguments.sessionObj ); <-- commented out to save a round trip to the db
		// set the last action time to now
		arguments.sessionObj.setLastActionAt( now() );
		// set the hmac code for the session cookie
		arguments.sessionObj.setHmacCode( dataHmac( arguments.sessionObj.getSessionId() ) );
		// save the session to the database
		setUserSession( arguments.sessionObj );

		// and return the session object
		return arguments.sessionObj;

	}

	/**
	* @displayname	clearStaleSessions
	* @description	I clear stale sessions (sessions older than timeoutMinutes) from the database 
	* @return		void
	*/
	public void function clearStaleSessions() {

		var qClearStaleSessions = queryExecute( '
			DELETE
			FROM UserAuthSessions 
			WHERE lastActionAt < :timeoutDateAdd',
			{
				timeoutDateAdd = {
					value = dateAdd( 'n', -application.timeoutMinutes, now() ),
					cfsqltype = 'cf_sql_timestamp'
				}
			}
		);
	}
}