component displayname="SpeakerService" accessors="true" singleton {

	public function init() {
		variables.utilService = new models.services.UtilService();

	return this;
	}

	/**
	* @displayname	createSpeaker
	* @description	I insert a new speakerObj record into the Speakers table in the database
	* @param		speakerObj {Any} I am the Speaker bean
	* @return		numeric
	*/
	public numeric function createSpeaker( required any speakerObj ) {

		cfstoredproc( procedure="mpsp_SpeakersCreate" ) {
			cfprocparam( dbVarName="@speakerUid", type="in", cfsqltype="cf_sql_idstamp", value="#arguments.speakerObj.getSpeakerUid()#" );
			cfprocparam( dbVarName="@speakerTypeID", type="in", cfsqltype="cf_sql_integer", value="#arguments.speakerObj.getSpeakerTypeID()#", null="#!len( arguments.speakerObj.getSpeakerTypeID() )#" );
			cfprocparam( dbVarName="@firstName", type="in", cfsqltype="cf_sql_varchar", value="#arguments.speakerObj.getFirstName()#", null="#!len( arguments.speakerObj.getFirstName() )#" );
			cfprocparam( dbVarName="@lastName", type="in", cfsqltype="cf_sql_varchar", value="#arguments.speakerObj.getLastName()#", null="#!len( arguments.speakerObj.getLastName() )#" );
			cfprocparam( dbVarName="@jobTitle", type="in", cfsqltype="cf_sql_varchar", value="#arguments.speakerObj.getJobTitle()#", null="#!len( arguments.speakerObj.getJobTitle() )#" );
			cfprocparam( dbVarName="@company", type="in", cfsqltype="cf_sql_varchar", value="#arguments.speakerObj.getCompany()#", null="#!len( arguments.speakerObj.getCompany() )#" );
			cfprocparam( dbVarName="@email", type="in", cfsqltype="cf_sql_varchar", value="#arguments.speakerObj.getEmail()#", null="#!len( arguments.speakerObj.getEmail() )#" );
			cfprocparam( dbVarName="@bio", type="in", cfsqltype="cf_sql_varchar", value="#arguments.speakerObj.getBio()#", null="#!len( arguments.speakerObj.getBio() )#" );
			cfprocparam( dbVarName="@hideSpeaker", type="in", cfsqltype="cf_sql_bit", value="#arguments.speakerObj.getHideSpeaker()#" );
			cfprocparam( dbVarName="@createdOn", type="in", cfsqltype="cf_sql_timestamp", value="#arguments.speakerObj.getCreatedOn()#" );
			cfprocparam( dbVarName="@updatedOn", type="in", cfsqltype="cf_sql_timestamp", value="#arguments.speakerObj.getUpdatedOn()#" );
			cfprocparam( dbVarName="@isActive", type="in", cfsqltype="cf_sql_bit", value="#arguments.speakerObj.getIsActive()#" );

			cfprocresult( name="qCreateData", resultset=1 );
		}

		return qCreateData.speakerID;

	}

	/**
	* @displayname	getSpeakerByID
	* @description	I return a Speaker bean populated with the details of a specific speakers record
	* @param		id {int} I am the ID of the speaker to return a record for
	* @return		any
	*/
	public any function getSpeakerByID( required string id ) {

		cfstoredproc( procedure="mpsp_SpeakersRead" ) {
			cfprocparam( type="in", cfsqltype="cf_sql_integer", value="#arguments.id#" );
			cfprocresult( name="local.qGetSpeaker", resultSet=1 );
		}

		if( local.qGetSpeaker.recordCount ) {

			return new models.beans.SpeakerBean(
				speakerID = local.qGetSpeaker.speakerID,
				speakerUid = local.qGetSpeaker.speakerUid,
				speakerTypeID = local.qGetSpeaker.speakerTypeID,
				firstName = local.qGetSpeaker.firstName,
				lastName = local.qGetSpeaker.lastName,
				jobTitle = local.qGetSpeaker.jobTitle,
				company = local.qGetSpeaker.company,
				email = local.qGetSpeaker.email,
				bio = local.qGetSpeaker.bio,
				hideSpeaker = local.qGetSpeaker.hideSpeaker,
				createdOn = local.qGetSpeaker.createdOn,
				updatedOn = local.qGetSpeaker.updatedOn,
				isActive = local.qGetSpeaker.isActive
			);

		} else {

			return new models.beans.SpeakerBean();

		}

	}

	/**
	* @displayname	updateSpeaker
	* @description	I update this speaker record in the Speakers table of the database
	* @param		speakerObj {Any} I am the Speaker bean
	* @return		numeric
	*/
	public numeric function updateSpeaker( required any speakerObj ) {

		cfstoredproc( procedure="mpsp_SpeakersUpdate" ) {
			cfprocparam( dbVarName="@speakerID", type="in", cfsqltype="cf_sql_integer", value="#arguments.speakerObj.getSpeakerID()#" );
			cfprocparam( dbVarName="@speakerUid", type="in", cfsqltype="cf_sql_idstamp", value="#arguments.speakerObj.getSpeakerUid()#" );
			cfprocparam( dbVarName="@speakerTypeID", type="in", cfsqltype="cf_sql_integer", value="#arguments.speakerObj.getSpeakerTypeID()#", null="#!len( arguments.speakerObj.getSpeakerTypeID() )#" );
			cfprocparam( dbVarName="@firstName", type="in", cfsqltype="cf_sql_varchar", value="#arguments.speakerObj.getFirstName()#", null="#!len( arguments.speakerObj.getFirstName() )#" );
			cfprocparam( dbVarName="@lastName", type="in", cfsqltype="cf_sql_varchar", value="#arguments.speakerObj.getLastName()#", null="#!len( arguments.speakerObj.getLastName() )#" );
			cfprocparam( dbVarName="@jobTitle", type="in", cfsqltype="cf_sql_varchar", value="#arguments.speakerObj.getJobTitle()#", null="#!len( arguments.speakerObj.getJobTitle() )#" );
			cfprocparam( dbVarName="@company", type="in", cfsqltype="cf_sql_varchar", value="#arguments.speakerObj.getCompany()#", null="#!len( arguments.speakerObj.getCompany() )#" );
			cfprocparam( dbVarName="@email", type="in", cfsqltype="cf_sql_varchar", value="#arguments.speakerObj.getEmail()#", null="#!len( arguments.speakerObj.getEmail() )#" );
			cfprocparam( dbVarName="@bio", type="in", cfsqltype="cf_sql_varchar", value="#arguments.speakerObj.getBio()#", null="#!len( arguments.speakerObj.getBio() )#" );
			cfprocparam( dbVarName="@hideSpeaker", type="in", cfsqltype="cf_sql_bit", value="#arguments.speakerObj.getHideSpeaker()#" );
			cfprocparam( dbVarName="@createdOn", type="in", cfsqltype="cf_sql_timestamp", value="#arguments.speakerObj.getCreatedOn()#" );
			cfprocparam( dbVarName="@updatedOn", type="in", cfsqltype="cf_sql_timestamp", value="#arguments.speakerObj.getUpdatedOn()#" );
			cfprocparam( dbVarName="@isActive", type="in", cfsqltype="cf_sql_bit", value="#arguments.speakerObj.getIsActive()#" );

			cfprocresult( name="qUpdateData", resultset=1 );
		}

		return qUpdateData.speakerID;

	}

	/**
	* @displayname	deleteSpeakerByUid
	* @description	I delete a speaker record from the Speakers table in the database
	* @param		guid {String} I am the GUID of the speaker to delete
	*/
	public void function deleteSpeakerByUid( required string guid ) {

		cfstoredproc( procedure="mpsp_SpeakersDelete" ) {
			cfprocparam( type="in", cfsqltype="cf_sql_integer", value="#arguments.guid#" );
		}

	}

	/**
	* @displayname	saveSpeaker
	* @description	I save a speaker record in the Speakers table in the database
	* @param		speakerObj {Any} I am the Speaker bean
	* @return		string
	*/
	public string function saveSpeaker( required any speakerObj ) {

		// check if this record exists
		if( exists( arguments.speakerObj ) ) {
			// it does, update the record
			return updateSpeaker( arguments.speakerObj );
		// otherwise
		} else {
			// it doesn't, create the record
			return createSpeaker( arguments.speakerObj );
		}

	}

	/**
	* @displayname	exists
	* @description	I check if a speaker record exists in the Speakers table in the database
	* @param		speakerObj {Any} I am the Speaker bean
	* @return		boolean
	*/
	public boolean function exists( required any speakerObj ) {

		// set sql to search for this record by speakerUid
		var sql = 'SELECT speakerID FROM Speakers WITH (NOLOCK) WHERE speakerID = :speakerID';

		// set params for this speakerUid
		var params = { 'speakerID' = { value = '#arguments.speakerObj.getSpeakerID()#', cfsqltype = 'cf_sql_integer' } };

		// check if this speaker record exists (there is a record count)
		if( queryExecute( sql, params ).recordCount ) {
			// it does, return true
			return true;
		// otherwise
		} else {
			// it doesn't, return false
			return false;
		}

	}

	/**
	* @displayname	conditionalDelete
	* @description	I run a conditional delete of records within the Speakers table in the database
	* @param		speakerUid {string} I am the value for speakerUid in the Speakers table that should be a conditional in this delete
	* @param		speakerTypeID {numeric} I am the value for speakerTypeID in the Speakers table that should be a conditional in this delete
	* @param		firstName {string} I am the value for firstName in the Speakers table that should be a conditional in this delete
	* @param		lastName {string} I am the value for lastName in the Speakers table that should be a conditional in this delete
	* @param		jobTitle {string} I am the value for jobTitle in the Speakers table that should be a conditional in this delete
	* @param		company {string} I am the value for company in the Speakers table that should be a conditional in this delete
	* @param		email {string} I am the value for email in the Speakers table that should be a conditional in this delete
	* @param		bio {string} I am the value for bio in the Speakers table that should be a conditional in this delete
	* @param		hideSpeaker {boolean} I am the value for hideSpeaker in the Speakers table that should be a conditional in this delete
	* @param		createdOn {date} I am the value for createdOn in the Speakers table that should be a conditional in this delete
	* @param		createdOnStart {date} I am the starting date value for createdOn in the Speakers table that should be a conditional in this delete
	* @param		createdOnEnd {date} I am the ending date value for createdOn in the Speakers table that should be a conditional in this delete
	* @param		updatedOn {date} I am the value for updatedOn in the Speakers table that should be a conditional in this delete
	* @param		updatedOnStart {date} I am the starting date value for updatedOn in the Speakers table that should be a conditional in this delete
	* @param		updatedOnEnd {date} I am the ending date value for updatedOn in the Speakers table that should be a conditional in this delete
	* @param		isActive {boolean} I am the value for isActive in the Speakers table that should be a conditional in this delete
	* @param		customSQL {Array} I am an array of structs of additional SQL you want to pass into the SQL query
	* @return		void
	*/
	public void function conditionalDelete(
		string speakerUid,
		numeric speakerTypeID,
		string firstName,
		string lastName,
		string jobTitle,
		string company,
		string email,
		string bio,
		boolean hideSpeaker,
		date createdOn,
		date createdOnStart,
		date createdOnEnd,
		date updatedOn,
		date updatedOnStart,
		date updatedOnEnd,
		boolean isActive,
		array customSQL = arrayNew(1)
	) {

		var sql = 'DELETE FROM Speakers WHERE 1 = 1 ';

		var params = {};

		if( structKeyExists( arguments, 'speakerUid' ) ) {
			sql &= 'AND speakerUid = :speakerUid ';
			params[ 'speakerUid' ] = { value = '#arguments.speakerUid#', cfsqltype = 'cf_sql_idstamp' };
		}

		if( structKeyExists( arguments, 'speakerTypeID' ) ) {
			sql &= 'AND speakerTypeID = :speakerTypeID ';
			params[ 'speakerTypeID' ] = { value = '#arguments.speakerTypeID#', cfsqltype = 'cf_sql_integer' };
		}

		if( structKeyExists( arguments, 'firstName' ) ) {
			sql &= 'AND firstName = :firstName ';
			params[ 'firstName' ] = { value = '#arguments.firstName#', cfsqltype = 'cf_sql_varchar' };
		}

		if( structKeyExists( arguments, 'lastName' ) ) {
			sql &= 'AND lastName = :lastName ';
			params[ 'lastName' ] = { value = '#arguments.lastName#', cfsqltype = 'cf_sql_varchar' };
		}

		if( structKeyExists( arguments, 'jobTitle' ) ) {
			sql &= 'AND jobTitle = :jobTitle ';
			params[ 'jobTitle' ] = { value = '#arguments.jobTitle#', cfsqltype = 'cf_sql_varchar' };
		}

		if( structKeyExists( arguments, 'company' ) ) {
			sql &= 'AND company = :company ';
			params[ 'company' ] = { value = '#arguments.company#', cfsqltype = 'cf_sql_varchar' };
		}

		if( structKeyExists( arguments, 'email' ) ) {
			sql &= 'AND email = :email ';
			params[ 'email' ] = { value = '#arguments.email#', cfsqltype = 'cf_sql_varchar' };
		}

		if( structKeyExists( arguments, 'bio' ) ) {
			sql &= 'AND bio = :bio ';
			params[ 'bio' ] = { value = '#arguments.bio#', cfsqltype = 'cf_sql_varchar' };
		}

		if( structKeyExists( arguments, 'hideSpeaker' ) ) {
			sql &= 'AND hideSpeaker = :hideSpeaker ';
			params[ 'hideSpeaker' ] = { value = '#arguments.hideSpeaker#', cfsqltype = 'cf_sql_bit' };
		}

		if( structKeyExists( arguments, 'createdOn' ) ) {
			sql &= 'AND createdOn = :createdOn ';
			params[ 'createdOn' ] = { value = '#arguments.createdOn#', cfsqltype = 'cf_sql_timestamp' };
		}

		if( structKeyExists( arguments, 'createdOnStart' ) and structKeyExists( arguments, 'createdOnEnd' ) ) {
			sql &= 'AND createdOn BETWEEN :createdOnStart AND :createdOnEnd ';
			params[ 'createdOnStart' ] = { value = '#arguments.createdOnStart#', cfsqltype = 'cf_sql_timestamp' };
			params[ 'createdOnEnd' ] = { value = '#arguments.createdOnEnd#', cfsqltype = 'cf_sql_timestamp' };
		}

		if( structKeyExists( arguments, 'createdOnStart' ) and !structKeyExists( arguments, 'createdOnEnd' ) ) {
			sql &= 'AND createdOn >= :createdOnStart ';
			params[ 'createdOnStart' ] = { value = '#arguments.createdOnStart#', cfsqltype = 'cf_sql_timestamp' };
		}

		if( structKeyExists( arguments, 'createdOnEnd' ) and !structKeyExists( arguments, 'createdOnStart' ) ) {
			sql &= 'AND createdOn <= :createdOnEnd ';
			params[ 'createdOnEnd' ] = { value = '#arguments.createdOnEnd#', cfsqltype = 'cf_sql_timestamp' };
		}

		if( structKeyExists( arguments, 'updatedOn' ) ) {
			sql &= 'AND updatedOn = :updatedOn ';
			params[ 'updatedOn' ] = { value = '#arguments.updatedOn#', cfsqltype = 'cf_sql_timestamp' };
		}

		if( structKeyExists( arguments, 'updatedOnStart' ) and structKeyExists( arguments, 'updatedOnEnd' ) ) {
			sql &= 'AND updatedOn BETWEEN :updatedOnStart AND :updatedOnEnd ';
			params[ 'updatedOnStart' ] = { value = '#arguments.updatedOnStart#', cfsqltype = 'cf_sql_timestamp' };
			params[ 'updatedOnEnd' ] = { value = '#arguments.updatedOnEnd#', cfsqltype = 'cf_sql_timestamp' };
		}

		if( structKeyExists( arguments, 'updatedOnStart' ) and !structKeyExists( arguments, 'updatedOnEnd' ) ) {
			sql &= 'AND updatedOn >= :updatedOnStart ';
			params[ 'updatedOnStart' ] = { value = '#arguments.updatedOnStart#', cfsqltype = 'cf_sql_timestamp' };
		}

		if( structKeyExists( arguments, 'updatedOnEnd' ) and !structKeyExists( arguments, 'updatedOnStart' ) ) {
			sql &= 'AND updatedOn <= :updatedOnEnd ';
			params[ 'updatedOnEnd' ] = { value = '#arguments.updatedOnEnd#', cfsqltype = 'cf_sql_timestamp' };
		}

		if( structKeyExists( arguments, 'isActive' ) ) {
			sql &= 'AND isActive = :isActive ';
			params[ 'isActive' ] = { value = '#arguments.isActive#', cfsqltype = 'cf_sql_bit' };
		}

		if( arrayLen( arguments.customSQL ) ) {

			for( variables.sqlStruct in arguments.customSQL ) {

				sql &= variables.sqlStruct['sql'];
				if( structKeyExists( variables.sqlStruct, 'column' ) ) {
					params[ '#variables.sqlStruct['column']#' ] = { value = '#variables.sqlStruct['value']#', list = '#variables.sqlStruct['isList']#', null = '#variables.sqlStruct['isNull']#', cfsqltype = '#variables.sqlStruct['sqlType']#' };
				}

			}

		}

		// ensure we have conditions (prevent accidental delete all)
		if( structCount( params ) ) {
			// execute the query
			queryExecute( sql, params );
		}

	}


	/**
	* @displayname	filter
	* @description	I run a filtered query of all records within the Speakers table in the database
	* @param		returnColumns {String} I am the columns in the Speakers table that should be returned in this query (default: all columns)
	* @param		speakerUid {string} I am the value for speakerUid in the Speakers table that should be returned in this query
	* @param		speakerTypeID {numeric} I am the value for speakerTypeID in the Speakers table that should be returned in this query
	* @param		firstName {string} I am the value for firstName in the Speakers table that should be returned in this query
	* @param		lastName {string} I am the value for lastName in the Speakers table that should be returned in this query
	* @param		jobTitle {string} I am the value for jobTitle in the Speakers table that should be returned in this query
	* @param		company {string} I am the value for company in the Speakers table that should be returned in this query
	* @param		email {string} I am the value for email in the Speakers table that should be returned in this query
	* @param		bio {string} I am the value for bio in the Speakers table that should be returned in this query
	* @param		hideSpeaker {boolean} I am the value for hideSpeaker in the Speakers table that should be returned in this query
	* @param		createdOn {date} I am the value for createdOn in the Speakers table that should be returned in this query
	* @param		createdOnStart {date} I am the starting date value for createdOn in the Speakers table that should be returned in this query
	* @param		createdOnEnd {date} I am the ending date value for createdOn in the Speakers table that should be returned in this query
	* @param		updatedOn {date} I am the value for updatedOn in the Speakers table that should be returned in this query
	* @param		updatedOnStart {date} I am the starting date value for updatedOn in the Speakers table that should be returned in this query
	* @param		updatedOnEnd {date} I am the ending date value for updatedOn in the Speakers table that should be returned in this query
	* @param		isActive {boolean} I am the value for isActive in the Speakers table that should be returned in this query
	* @param		groupBy {String} I am the group to return records in the Speakers table returned in this query
	* @param		orderBy {String} I am the order to return records in the Speakers table returned in this query
	* @param		pagination {Boolean} I am a flag (true/false) to determine if this query should be paginated (default: false, required: orderBy)
	* @param		returnType {String} I am the format the query should be returned in, one of blank, array or query (default: blank)
	* @param		start {Numeric} I am the record number in the Speakers table to offset to (required: pagination = true)
	* @param		length {Numeric} I am the number of paginated records to return from the Speakers table (required: pagination = true)
	* @param		search {String} I am a value to search the Speakers table for
	* @param		cache {Boolean} I am a flag (true/false) to determine if this query should be cached (default: false)
	* @param		clearCache {Boolean} I am a flag (true/false) to determine if this cached query should be cleared (default: false)
	* @param		cacheTime {Any} I am the timespan the query should be cached for (default: 1 hour)
	* @param		dirtyRead {Boolean} I am a flag (true/false) to determine if this query should use WITH (NOLOCK) (default: false)
	* @param		customSQL {Array} I am an array of structs of additional SQL you want to pass into the SQL query
	* @return		query
	*/
	public any function filter(
		string returnColumns = 'speakerID, speakerUid, speakerTypeID, firstName, lastName, jobTitle, company, email, bio, hideSpeaker, createdOn, updatedOn, isActive',
		string speakerUid,
		numeric speakerTypeID,
		string firstName,
		string lastName,
		string jobTitle,
		string company,
		string email,
		string bio,
		boolean hideSpeaker,
		date createdOn,
		date createdOnStart,
		date createdOnEnd,
		date updatedOn,
		date updatedOnStart,
		date updatedOnEnd,
		boolean isActive,
		string groupBy,
		string orderBy,
		boolean pagination = false,
		string returnType,
		numeric start,
		numeric length,
		string search = '',
		boolean cache = false,
		boolean clearCache = false,
		any cacheTime = createTimeSpan(0,1,0,0),
		boolean dirtyRead = false,
		array customSQL = arrayNew(1)
	) {

		var thisFilter = structNew();

		if( structKeyExists( arguments, 'speakerUid' ) and len( arguments.speakerUid ) ) {
			thisFilter.speakerUid = arguments.speakerUid;
		}

		if( structKeyExists( arguments, 'speakerTypeID' ) and len( arguments.speakerTypeID ) ) {
			thisFilter.speakerTypeID = arguments.speakerTypeID;
		}

		if( structKeyExists( arguments, 'firstName' ) and len( arguments.firstName ) ) {
			thisFilter.firstName = arguments.firstName;
		}

		if( structKeyExists( arguments, 'lastName' ) and len( arguments.lastName ) ) {
			thisFilter.lastName = arguments.lastName;
		}

		if( structKeyExists( arguments, 'jobTitle' ) and len( arguments.jobTitle ) ) {
			thisFilter.jobTitle = arguments.jobTitle;
		}

		if( structKeyExists( arguments, 'company' ) and len( arguments.company ) ) {
			thisFilter.company = arguments.company;
		}

		if( structKeyExists( arguments, 'email' ) and len( arguments.email ) ) {
			thisFilter.email = arguments.email;
		}

		if( structKeyExists( arguments, 'bio' ) and len( arguments.bio ) ) {
			thisFilter.bio = arguments.bio;
		}

		if( structKeyExists( arguments, 'hideSpeaker' ) and len( arguments.hideSpeaker ) ) {
			thisFilter.hideSpeaker = arguments.hideSpeaker;
		}

		if( structKeyExists( arguments, 'createdOn' ) and len( arguments.createdOn ) ) {
			thisFilter.createdOn = arguments.createdOn;
		}

		if( structKeyExists( arguments, 'createdOnStart' ) AND len( arguments.createdOnStart ) ) {
			thisFilter.createdOnStart = arguments.createdOnStart;
		}

		if( structKeyExists( arguments, 'createdOnEnd' ) AND len( arguments.createdOnEnd ) ) {
			thisFilter.createdOnEnd = arguments.createdOnEnd;
		}

		if( structKeyExists( arguments, 'updatedOn' ) and len( arguments.updatedOn ) ) {
			thisFilter.updatedOn = arguments.updatedOn;
		}

		if( structKeyExists( arguments, 'updatedOnStart' ) AND len( arguments.updatedOnStart ) ) {
			thisFilter.updatedOnStart = arguments.updatedOnStart;
		}

		if( structKeyExists( arguments, 'updatedOnEnd' ) AND len( arguments.updatedOnEnd ) ) {
			thisFilter.updatedOnEnd = arguments.updatedOnEnd;
		}

		if( structKeyExists( arguments, 'isActive' ) and len( arguments.isActive ) ) {
			thisFilter.isActive = arguments.isActive;
		}

		if( structKeyExists( arguments, 'groupBy' ) AND len( arguments.groupBy ) ) {
			thisFilter.groupBy = arguments.groupBy;

		}

		if( structKeyExists( arguments, 'orderBy' ) AND len( arguments.orderBy ) ) {
			thisFilter.orderBy = arguments.orderBy;

		}

		if( structKeyExists( arguments, 'pagination' ) and arguments.pagination ) {
			thisFilter.pagination = arguments.pagination;
			thisFilter.start = arguments.start;
			thisFilter.length = arguments.length;
		}

		if( structKeyExists( arguments, 'returnType' ) and len( arguments.returnType ) ) {
			thisFilter.returnType = arguments.returnType;
		}

		thisFilter.customSQL = arguments.customSQL;
		thisFilter.returnColumns = arguments.returnColumns;
		thisFilter.cache = arguments.cache;
		thisFilter.clearCache = structKeyExists( arguments, 'clearCache' ) ? arguments.clearCache : false;
		thisFilter.dirtyRead = arguments.dirtyRead;

		// check if we're searching the table
		if( structKeyExists( arguments, 'search' ) AND len( arguments.search ) ) {
			return searchFilteredSpeakerRecords( thisFilter, arguments.search );
		}

		// return filtered records
		return filterSpeakerRecords( thisFilter );

	}

	/**
	* @displayname	filterSpeakerRecords
	* @description	I run a query that will return all speakers records. If a filter has been applied, I will refine results based on the filter
	* @param		filter {Struct} I am the filter struct to apply to this query
	* @return		query
	*/
	private any function filterSpeakerRecords( struct filter = {} ) {

		// check if we're caching, and not clearing the cache
		if( arguments.filter.cache
			&& !arguments.filter.clearCache ) {

			// we are, get the query from the cache
			var qGetCachedQuery = getCachedSpeakerQuery( hash( serializeJSON( arguments.filter ) ) );

			// check if we have a query from the cache
			if( !isNull( qGetCachedQuery ) ) {
				// we do, return the cached query
				return qGetCachedQuery;
			}

		}

		var params = {};
		var options = {};
		var sql = 'SELECT #arguments.filter.returnColumns# FROM Speakers#( arguments.filter.dirtyRead ? ' WITH (NOLOCK)' : '' )# WHERE 1 = 1 ';

		// check if we're running lucee and requested a specific return type
		if(
			findNoCase( 'lucee', application.engine )
			&& structKeyExists( arguments.filter, 'returnType' )
		) {
			// we did, pass the return type requested in the query options
			options = { returnType = arguments.filter.returnType };
		}

		if( structKeyExists( arguments.filter, 'speakerUid' ) ) {
			sql &= 'AND speakerUid = :speakerUid ';
			params[ 'speakerUid' ] = { value = '#arguments.filter.speakerUid#', cfsqltype = 'cf_sql_idstamp' };
		}

		if( structKeyExists( arguments.filter, 'speakerTypeID' ) ) {
			sql &= 'AND speakerTypeID = :speakerTypeID ';
			params[ 'speakerTypeID' ] = { value = '#arguments.filter.speakerTypeID#', cfsqltype = 'cf_sql_integer' };
		}

		if( structKeyExists( arguments.filter, 'firstName' ) ) {
			sql &= 'AND firstName = :firstName ';
			params[ 'firstName' ] = { value = '#arguments.filter.firstName#', cfsqltype = 'cf_sql_varchar' };
		}

		if( structKeyExists( arguments.filter, 'lastName' ) ) {
			sql &= 'AND lastName = :lastName ';
			params[ 'lastName' ] = { value = '#arguments.filter.lastName#', cfsqltype = 'cf_sql_varchar' };
		}

		if( structKeyExists( arguments.filter, 'jobTitle' ) ) {
			sql &= 'AND jobTitle = :jobTitle ';
			params[ 'jobTitle' ] = { value = '#arguments.filter.jobTitle#', cfsqltype = 'cf_sql_varchar' };
		}

		if( structKeyExists( arguments.filter, 'company' ) ) {
			sql &= 'AND company = :company ';
			params[ 'company' ] = { value = '#arguments.filter.company#', cfsqltype = 'cf_sql_varchar' };
		}

		if( structKeyExists( arguments.filter, 'email' ) ) {
			sql &= 'AND email = :email ';
			params[ 'email' ] = { value = '#arguments.filter.email#', cfsqltype = 'cf_sql_varchar' };
		}

		if( structKeyExists( arguments.filter, 'bio' ) ) {
			sql &= 'AND bio = :bio ';
			params[ 'bio' ] = { value = '#arguments.filter.bio#', cfsqltype = 'cf_sql_varchar' };
		}

		if( structKeyExists( arguments.filter, 'hideSpeaker' ) ) {
			sql &= 'AND hideSpeaker = :hideSpeaker ';
			params[ 'hideSpeaker' ] = { value = '#arguments.filter.hideSpeaker#', cfsqltype = 'cf_sql_bit' };
		}

		if( structKeyExists( arguments.filter, 'createdOn' ) ) {
			sql &= 'AND createdOn = :createdOn ';
			params[ 'createdOn' ] = { value = '#arguments.filter.createdOn#', cfsqltype = 'cf_sql_timestamp' };
		}

		if( structKeyExists( arguments.filter, 'createdOnStart' ) and structKeyExists( arguments.filter, 'createdOnEnd' ) ) {
			sql &= 'AND createdOn BETWEEN :createdOnStart AND :createdOnEnd ';
			params[ 'createdOnStart' ] = { value = '#arguments.filter.createdOnStart#', cfsqltype = 'cf_sql_timestamp' };
			params[ 'createdOnEnd' ] = { value = '#arguments.filter.createdOnEnd#', cfsqltype = 'cf_sql_timestamp' };
		}

		if( structKeyExists( arguments.filter, 'createdOnStart' ) and !structKeyExists( arguments.filter, 'createdOnEnd' ) ) {
			sql &= 'AND createdOn >= :createdOnStart ';
			params[ 'createdOnStart' ] = { value = '#arguments.filter.createdOnStart#', cfsqltype = 'cf_sql_timestamp' };
		}

		if( structKeyExists( arguments.filter, 'createdOnEnd' ) and !structKeyExists( arguments.filter, 'createdOnStart' ) ) {
			sql &= 'AND createdOn <= :createdOnEnd ';
			params[ 'createdOnEnd' ] = { value = '#arguments.filter.createdOnEnd#', cfsqltype = 'cf_sql_timestamp' };
		}

		if( structKeyExists( arguments.filter, 'updatedOn' ) ) {
			sql &= 'AND updatedOn = :updatedOn ';
			params[ 'updatedOn' ] = { value = '#arguments.filter.updatedOn#', cfsqltype = 'cf_sql_timestamp' };
		}

		if( structKeyExists( arguments.filter, 'updatedOnStart' ) and structKeyExists( arguments.filter, 'updatedOnEnd' ) ) {
			sql &= 'AND updatedOn BETWEEN :updatedOnStart AND :updatedOnEnd ';
			params[ 'updatedOnStart' ] = { value = '#arguments.filter.updatedOnStart#', cfsqltype = 'cf_sql_timestamp' };
			params[ 'updatedOnEnd' ] = { value = '#arguments.filter.updatedOnEnd#', cfsqltype = 'cf_sql_timestamp' };
		}

		if( structKeyExists( arguments.filter, 'updatedOnStart' ) and !structKeyExists( arguments.filter, 'updatedOnEnd' ) ) {
			sql &= 'AND updatedOn >= :updatedOnStart ';
			params[ 'updatedOnStart' ] = { value = '#arguments.filter.updatedOnStart#', cfsqltype = 'cf_sql_timestamp' };
		}

		if( structKeyExists( arguments.filter, 'updatedOnEnd' ) and !structKeyExists( arguments.filter, 'updatedOnStart' ) ) {
			sql &= 'AND updatedOn <= :updatedOnEnd ';
			params[ 'updatedOnEnd' ] = { value = '#arguments.filter.updatedOnEnd#', cfsqltype = 'cf_sql_timestamp' };
		}

		if( structKeyExists( arguments.filter, 'isActive' ) ) {
			sql &= 'AND isActive = :isActive ';
			params[ 'isActive' ] = { value = '#arguments.filter.isActive#', cfsqltype = 'cf_sql_bit' };
		}

		if( arrayLen( arguments.filter.customSQL ) ) {

			for( variables.sqlStruct in arguments.filter.customSQL ) {

				sql &= variables.sqlStruct['sql'];
				if( structKeyExists( variables.sqlStruct, 'column' ) ) {
					params[ '#variables.sqlStruct['column']#' ] = { value = '#variables.sqlStruct['value']#', list = '#variables.sqlStruct['isList']#', null = '#variables.sqlStruct['isNull']#', cfsqltype = '#variables.sqlStruct['sqlType']#' };
				}

			}

		}

		if( structKeyExists( arguments.filter, 'groupBy' ) ) {
			sql &= 'GROUP BY #arguments.filter.groupBy#';
		}

		if( structKeyExists( arguments.filter, 'orderBy' ) ) {
			sql &= 'ORDER BY #arguments.filter.orderBy#';
		}

		if( structKeyExists( arguments.filter, 'pagination' ) AND arguments.filter.pagination ) {
			sql &= ' OFFSET #arguments.filter.start# ROWS FETCH NEXT #arguments.filter.length# ROWS ONLY;';
		}

		// execute the query
		var qGetResultsQuery = queryExecute( sql, params, options );

		// check if we're caching this query
		if( arguments.filter.cache ) {

			// we are, set the query into the cache
			setCachedSpeakerQuery(
				queryHash = hash( serializeJSON( arguments.filter ) ),
				queryData = qGetResultsQuery
			);

		}

		// check if we're *not* running lucee, have requested a specific return type and that return type is 'array'
		if(
			!findNoCase( 'lucee', application.engine )
			&& structKeyExists( arguments.filter, 'returnType' )
			&& arguments.filter.returnType eq 'array'
		) {
			// we have, return the data after running through the util service to form an array of structs
			return variables.utilService.queryToArrayOfStructures( qGetResultsQuery );
		}

		// otherwise, return the query (or array) results
		return qGetResultsQuery;

	}

	/**
	* @displayname	searchFilteredSpeakerRecords
	* @description	I run a query that will return all speakers records matching a passed in search term
	* @param		filter {Struct} I am the filter struct to apply to this query
	* @param		q {String} I am the search term to apply to this search
	* @return		query
	*/
	private any function searchFilteredSpeakerRecords( struct filter = {}, required string q ) {

		var params = {};
		var options = {};
		var sql = 'SELECT #arguments.filter.returnColumns# FROM Speakers#( arguments.filter.dirtyRead ? ' WITH (NOLOCK)' : '' )# WHERE ( 1 = 0 ';

		// check if we're running on lucee and requested a specific return type
		if(
			findNoCase( 'lucee', application.engine )
			&& structKeyExists( arguments.filter, 'returnType' )
		) {
			// we did, pass the return type requested in the query options
			options = { returnType = arguments.filter.returnType };
		}

		if( listFindNoCase( arguments.filter.returnColumns, 'firstName', ', ' ) ) {
			sql &= 'OR firstName LIKE :q ';
		}

		if( listFindNoCase( arguments.filter.returnColumns, 'lastName', ', ' ) ) {
			sql &= 'OR lastName LIKE :q ';
		}

		if( listFindNoCase( arguments.filter.returnColumns, 'jobTitle', ', ' ) ) {
			sql &= 'OR jobTitle LIKE :q ';
		}

		if( listFindNoCase( arguments.filter.returnColumns, 'company', ', ' ) ) {
			sql &= 'OR company LIKE :q ';
		}

		if( listFindNoCase( arguments.filter.returnColumns, 'email', ', ' ) ) {
			sql &= 'OR email LIKE :q ';
		}

		if( listFindNoCase( arguments.filter.returnColumns, 'bio', ', ' ) ) {
			sql &= 'OR bio LIKE :q ';
		}

		sql &= ') ';

		if( structKeyExists( arguments.filter, 'isActive' ) ) {
			sql &= 'AND isActive = :isActive ';
			params[ 'isActive' ] = { value = '#arguments.filter.isActive#', cfsqltype = 'cf_sql_bit' };
		}

		if( arrayLen( arguments.filter.customSQL ) ) {

			for( variables.sqlStruct in arguments.filter.customSQL ) {

				sql &= variables.sqlStruct['sql'];
				if( structKeyExists( variables.sqlStruct, 'column' ) ) {
					params[ '#variables.sqlStruct['column']#' ] = { value = '#variables.sqlStruct['value']#', list = '#variables.sqlStruct['isList']#', null = '#variables.sqlStruct['isNull']#', cfsqltype = '#variables.sqlStruct['sqlType']#' };
				}

			}

		}

		if( structKeyExists( arguments.filter, 'groupBy' ) ) {
			sql &= 'GROUP BY #arguments.filter.groupBy#';
		}

		if( structKeyExists( arguments.filter, 'orderBy' ) ) {
			sql &= 'ORDER BY #arguments.filter.orderBy#';
		}

		if( structKeyExists( arguments.filter, 'pagination' ) AND arguments.filter.pagination ) {
			sql &= ' OFFSET #arguments.filter.start# ROWS FETCH NEXT #arguments.filter.length# ROWS ONLY;';
		}

		params[ 'q' ] = { value = '%#arguments.q#%', cfsqltype = 'cf_sql_varchar' };

		var qGetResultsQuery = queryExecute( sql, params, options );

		// check if we're *not* running lucee, have requested a specific return type and that return type is 'array'
		if(
			!findNoCase( 'lucee', application.engine )
			&& structKeyExists( arguments.filter, 'returnType' )
			&& arguments.filter.returnType eq 'array'
		) {
			// we have, return the data after running through the util service to form an array of structs
			return variables.utilService.queryToArrayOfStructures( qGetResultsQuery );
		}

		// return the query results
		return qGetResultsQuery;

	}

	/**
	* @displayname	getSpeakerRecordCount
	* @description	I return the total number of speakers records in a table
	* @param		isActive {Boolean} I am a flag (true/false) to determine if active or inactive record counts are returned
	* @return		numeric
	*/
	public numeric function getSpeakerRecordCount() {
		return filter( argumentCollection = arguments ).recordCount;
	}

	/**
	* @displayname	getSpeakerNull
	* @description	I return a null speakers query
	* @return		query
	*/
	public query function getSpeakerNull() {

		// get the null speakers record from the cache
		var qGetNullSpeakerQuery = cacheGet( 'mpos_speakers_query_' & hash( 'nullRecord' ) );
		// check if we have a null speakers record
		if( !isNull( qGetNullSpeakerQuery ) ) {
			// we do, return the cached null speakers record
			return qGetNullSpeakerQuery;
		}

		// get the null record
		qGetNullSpeakerQuery = queryExecute( 'SELECT speakerID, speakerUid, speakerTypeID, firstName, lastName, jobTitle, company, email, bio, hideSpeaker, createdOn, updatedOn, isActive FROM Speakers WITH (NOLOCK) WHERE speakerID IS NULL' );

		// put the null query in the cache
		cachePut( 'mpos_speakers_query_' & hash( 'nullRecord' ), qGetNullSpeakerQuery, createTimeSpan( 90, 0, 0, 0 ) );

		// return the null query
		return qGetNullSpeakerQuery;

	}

	/**
	* @displayname	getCachedSpeakerQuery
	* @description	I return an object storage version of a cached query
	* @return		query
	*/
	public query function getCachedSpeakerQuery( required string queryHash ) {

		// get the requested query from cache by the hash value
		var qGetSpeakerCachedQuery = cacheGet( 'mpos_speakers_query_' & arguments.queryHash );

		// check if we have the query in the cache
		if( !isNull( qGetSpeakerCachedQuery ) ) {
			// we do, return the cached query
			return qGetSpeakerCachedQuery;
		}

		// otherwise, we don't, return a null query
		return getSpeakerNull();

	}

	/**
	* @displayname	setCachedSpeakerQuery
	* @description	I set an object storage version of a cached query
	* @return		void
	*/
	public void function setCachedSpeakerQuery(
		required string queryHash,
		required query queryData,
		ttl = createTimeSpan( 30, 0, 0, 0 ),
		idl = createTimeSpan( 15, 0, 0, 0 )
	) {

		// clear out existing cached query, if any
		clearCachedSpeakerQuery( arguments.queryHash );

		// put query in the cache by query hash
		cachePut( 'mpos_speakers_query_' & arguments.queryHash, arguments.queryData, arguments.ttl, arguments.idl );

	}

	/**
	* @displayname	clearCachedSpeakerQuery
	* @description	I remove an object storage version of a cached query
	* @return		void
	*/
	public void function clearCachedSpeakerQuery( required string queryHash ) {

		// clear out the cached query by query hash
		cacheRemove( 'mpos_speakers_query_' & arguments.queryHash );

	}

	/**
	* @displayname	clearAllCachedSpeakerQueries
	* @description	I remove all object storage versions of cached queries for this SpeakerService
	* @return		void
	*/
	public void function clearAllCachedSpeakerQueries() {

		// filter cached queries specific to this service
		var cacheItems = cacheGetAllIds().filter(
			function( _item ) {
				return findNoCase( 'mpos_speakers_query_', _item );
 			}
		);

		// loop through the filtered cached items
		for( var item in cacheItems ) {
			// remove this item from the cache
			cacheRemove( item );
		}

	}

	/**
	* @displayname	getSpeakerColumnArray
	* @description	I return all columns available for filtering in SpeakerService
	* @return		array
	*/
	public array function getSpeakerColumnArray() {

		return [
			'speakerID',
			'speakerUid',
			'speakerTypeID',
			'firstName',
			'lastName',
			'jobTitle',
			'company',
			'email',
			'bio',
			'hideSpeaker',
			'createdOn',
			'updatedOn',
			'isActive'
		];
	}

	/* CUSTOM FUNCTIONS GO HERE */

}