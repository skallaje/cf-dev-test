interface  {

	/* SESSION MANAGEMENT

		Provides functions to help manage logged on user sessions.

		Functions include:
			checking if a user's session exists in the database 
			creating a new user session after authentication 
			storing, clearing, and updating a user's session object
			generating and rotating a user's session id

	*/

	/**
	* @displayname	checkUserSession
	* @description	I retrieve the users session object from database, and return it if it exists, else I return a blank session object
	* @param		userType {String} - I am the session type to check
	* @param		sessionId {String} required - I am the session id to check
	* @return		any
	*/
	public any function checkUserSession( string userType = '', required string sessionId );

	/**
	* @displayname	createUserSession
	* @description	I generate and return a session object based on passed in values
	* @param		userUid {String} required - I am the user guid of the user to generate a session for
	* @return		any
	*/
	public any function createUserSession( required string userUid );

	/**
	* @displayname	setUserSession
	* @description	I store a sessio0n object in the database
	* @param		sessionObj {Any} required - I am the session object to store in the database
	* @return		void
	*/
	public void function setUserSession( required any sessionObj );

	/**
	* @displayname	clearUserSession
	* @description	I remove a sessio0n object from the database
	* @param		sessionObj {Any} required - I am the session object to clear from the database
	* @return		void
	*/
	public void function clearUserSession( required any sessionObj );

	/**
	* @displayname	rotateUserSession
	* @description	I update the session id of a session object 
	* @param		sessionObj {Any} required - I am the session object to rotate the id for
	* @return		any
	*/
	public any function rotateUserSession( required any sessionObj );

	/**
	* @displayname	updateUserSession
	* @description	I update the last action at of a session object, remove the old session and save the new one 
	* @param		sessionObj {Any} required - I am the session object to update
	* @return		any
	*/
	public any function updateUserSession( required any sessionObj );

}