component displayname="SpeakerTypeService" accessors="true" singleton {

	public function init() {
		variables.utilService = new models.services.UtilService();

	return this;
	}

	/**
	* @displayname	createSpeakerType
	* @description	I insert a new speakerTypeObj record into the SpeakerTypes table in the database
	* @param		speakerTypeObj {Any} I am the SpeakerType bean
	* @return		numeric
	*/
	public numeric function createSpeakerType( required any speakerTypeObj ) {

		cfstoredproc( procedure="mpsp_SpeakerTypesCreate" ) {
			cfprocparam( dbVarName="@speakerTypeUid", type="in", cfsqltype="cf_sql_idstamp", value="#arguments.speakerTypeObj.getSpeakerTypeUid()#" );
			cfprocparam( dbVarName="@speakerTypeName", type="in", cfsqltype="cf_sql_varchar", value="#arguments.speakerTypeObj.getSpeakerTypeName()#" );
			cfprocparam( dbVarName="@sortOrder", type="in", cfsqltype="cf_sql_integer", value="#arguments.speakerTypeObj.getSortOrder()#", null="#!len( arguments.speakerTypeObj.getSortOrder() )#" );
			cfprocparam( dbVarName="@createdOn", type="in", cfsqltype="cf_sql_timestamp", value="#arguments.speakerTypeObj.getCreatedOn()#" );
			cfprocparam( dbVarName="@updatedOn", type="in", cfsqltype="cf_sql_timestamp", value="#arguments.speakerTypeObj.getUpdatedOn()#" );
			cfprocparam( dbVarName="@isActive", type="in", cfsqltype="cf_sql_bit", value="#arguments.speakerTypeObj.getIsActive()#" );

			cfprocresult( name="qCreateData", resultset=1 );
		}

		return qCreateData.speakerTypeID;

	}

	/**
	* @displayname	getSpeakerTypeByID
	* @description	I return a SpeakerType bean populated with the details of a specific speakerTypes record
	* @param		id {int} I am the int ID of the speakerType to return a record for
	* @return		any
	*/
	public any function getSpeakerTypeByID( required string id ) {

		cfstoredproc( procedure="mpsp_SpeakerTypesRead" ) {
			cfprocparam( type="in", cfsqltype="cf_sql_integer", value="#arguments.id#" );
			cfprocresult( name="local.qGetSpeakerType", resultSet=1 );
		}

		if( local.qGetSpeakerType.recordCount ) {

			return new models.beans.SpeakerTypeBean(
				speakerTypeID = local.qGetSpeakerType.speakerTypeID,
				speakerTypeUid = local.qGetSpeakerType.speakerTypeUid,
				speakerTypeName = local.qGetSpeakerType.speakerTypeName,
				sortOrder = local.qGetSpeakerType.sortOrder,
				createdOn = local.qGetSpeakerType.createdOn,
				updatedOn = local.qGetSpeakerType.updatedOn,
				isActive = local.qGetSpeakerType.isActive
			);

		} else {

			return new models.beans.SpeakerTypeBean();

		}

	}

	/**
	* @displayname	updateSpeakerType
	* @description	I update this speakerType record in the SpeakerTypes table of the database
	* @param		speakerTypeObj {Any} I am the SpeakerType bean
	* @return		numeric
	*/
	public numeric function updateSpeakerType( required any speakerTypeObj ) {

		cfstoredproc( procedure="mpsp_SpeakerTypesUpdate" ) {
			cfprocparam( dbVarName="@speakerTypeID", type="in", cfsqltype="cf_sql_integer", value="#arguments.speakerTypeObj.getSpeakerTypeID()#" );
			cfprocparam( dbVarName="@speakerTypeUid", type="in", cfsqltype="cf_sql_idstamp", value="#arguments.speakerTypeObj.getSpeakerTypeUid()#" );
			cfprocparam( dbVarName="@speakerTypeName", type="in", cfsqltype="cf_sql_varchar", value="#arguments.speakerTypeObj.getSpeakerTypeName()#" );
			cfprocparam( dbVarName="@sortOrder", type="in", cfsqltype="cf_sql_integer", value="#arguments.speakerTypeObj.getSortOrder()#", null="#!len( arguments.speakerTypeObj.getSortOrder() )#" );
			cfprocparam( dbVarName="@createdOn", type="in", cfsqltype="cf_sql_timestamp", value="#arguments.speakerTypeObj.getCreatedOn()#" );
			cfprocparam( dbVarName="@updatedOn", type="in", cfsqltype="cf_sql_timestamp", value="#arguments.speakerTypeObj.getUpdatedOn()#" );
			cfprocparam( dbVarName="@isActive", type="in", cfsqltype="cf_sql_bit", value="#arguments.speakerTypeObj.getIsActive()#" );

			cfprocresult( name="qUpdateData", resultset=1 );
		}

		return qUpdateData.speakerTypeID;

	}

	/**
	* @displayname	deleteSpeakerTypeByUid
	* @description	I delete a speakerType record from the SpeakerTypes table in the database
	* @param		guid {String} I am the GUID of the speakerType to delete
	*/
	public void function deleteSpeakerTypeByUid( required string guid ) {

		cfstoredproc( procedure="mpsp_SpeakerTypesDelete" ) {
			cfprocparam( type="in", cfsqltype="cf_sql_integer", value="#arguments.guid#" );
		}

	}

	/**
	* @displayname	saveSpeakerType
	* @description	I save a speakerType record in the SpeakerTypes table in the database
	* @param		speakerTypeObj {Any} I am the SpeakerType bean
	* @return		string
	*/
	public string function saveSpeakerType( required any speakerTypeObj ) {

		// check if this record exists
		if( exists( arguments.speakerTypeObj ) ) {
			// it does, update the record
			return updateSpeakerType( arguments.speakerTypeObj );
		// otherwise
		} else {
			// it doesn't, create the record
			return createSpeakerType( arguments.speakerTypeObj );
		}

	}

	/**
	* @displayname	exists
	* @description	I check if a speakerType record exists in the SpeakerTypes table in the database
	* @param		speakerTypeObj {Any} I am the SpeakerType bean
	* @return		boolean
	*/
	public boolean function exists( required any speakerTypeObj ) {

		// set sql to search for this record by speakerTypeUid
		var sql = 'SELECT speakerTypeID FROM SpeakerTypes WITH (NOLOCK) WHERE speakerTypeID = :speakerTypeID';

		// set params for this speakerTypeUid
		var params = { 'speakerTypeID' = { value = '#arguments.speakerTypeObj.getSpeakerTypeID()#', cfsqltype = 'cf_sql_integer' } };

		// check if this speakerType record exists (there is a record count)
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
	* @description	I run a conditional delete of records within the SpeakerTypes table in the database
	* @param		speakerTypeUid {string} I am the value for speakerTypeUid in the SpeakerTypes table that should be a conditional in this delete
	* @param		speakerTypeName {string} I am the value for speakerTypeName in the SpeakerTypes table that should be a conditional in this delete
	* @param		sortOrder {numeric} I am the value for sortOrder in the SpeakerTypes table that should be a conditional in this delete
	* @param		createdOn {date} I am the value for createdOn in the SpeakerTypes table that should be a conditional in this delete
	* @param		createdOnStart {date} I am the starting date value for createdOn in the SpeakerTypes table that should be a conditional in this delete
	* @param		createdOnEnd {date} I am the ending date value for createdOn in the SpeakerTypes table that should be a conditional in this delete
	* @param		updatedOn {date} I am the value for updatedOn in the SpeakerTypes table that should be a conditional in this delete
	* @param		updatedOnStart {date} I am the starting date value for updatedOn in the SpeakerTypes table that should be a conditional in this delete
	* @param		updatedOnEnd {date} I am the ending date value for updatedOn in the SpeakerTypes table that should be a conditional in this delete
	* @param		isActive {boolean} I am the value for isActive in the SpeakerTypes table that should be a conditional in this delete
	* @param		customSQL {Array} I am an array of structs of additional SQL you want to pass into the SQL query
	* @return		void
	*/
	public void function conditionalDelete(
		string speakerTypeUid,
		string speakerTypeName,
		numeric sortOrder,
		date createdOn,
		date createdOnStart,
		date createdOnEnd,
		date updatedOn,
		date updatedOnStart,
		date updatedOnEnd,
		boolean isActive,
		array customSQL = arrayNew(1)
	) {

		var sql = 'DELETE FROM SpeakerTypes WHERE 1 = 1 ';

		var params = {};

		if( structKeyExists( arguments, 'speakerTypeUid' ) ) {
			sql &= 'AND speakerTypeUid = :speakerTypeUid ';
			params[ 'speakerTypeUid' ] = { value = '#arguments.speakerTypeUid#', cfsqltype = 'cf_sql_idstamp' };
		}

		if( structKeyExists( arguments, 'speakerTypeName' ) ) {
			sql &= 'AND speakerTypeName = :speakerTypeName ';
			params[ 'speakerTypeName' ] = { value = '#arguments.speakerTypeName#', cfsqltype = 'cf_sql_varchar' };
		}

		if( structKeyExists( arguments, 'sortOrder' ) ) {
			sql &= 'AND sortOrder = :sortOrder ';
			params[ 'sortOrder' ] = { value = '#arguments.sortOrder#', cfsqltype = 'cf_sql_integer' };
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
	* @description	I run a filtered query of all records within the SpeakerTypes table in the database
	* @param		returnColumns {String} I am the columns in the SpeakerTypes table that should be returned in this query (default: all columns)
	* @param		speakerTypeUid {string} I am the value for speakerTypeUid in the SpeakerTypes table that should be returned in this query
	* @param		speakerTypeName {string} I am the value for speakerTypeName in the SpeakerTypes table that should be returned in this query
	* @param		sortOrder {numeric} I am the value for sortOrder in the SpeakerTypes table that should be returned in this query
	* @param		createdOn {date} I am the value for createdOn in the SpeakerTypes table that should be returned in this query
	* @param		createdOnStart {date} I am the starting date value for createdOn in the SpeakerTypes table that should be returned in this query
	* @param		createdOnEnd {date} I am the ending date value for createdOn in the SpeakerTypes table that should be returned in this query
	* @param		updatedOn {date} I am the value for updatedOn in the SpeakerTypes table that should be returned in this query
	* @param		updatedOnStart {date} I am the starting date value for updatedOn in the SpeakerTypes table that should be returned in this query
	* @param		updatedOnEnd {date} I am the ending date value for updatedOn in the SpeakerTypes table that should be returned in this query
	* @param		isActive {boolean} I am the value for isActive in the SpeakerTypes table that should be returned in this query
	* @param		groupBy {String} I am the group to return records in the SpeakerTypes table returned in this query
	* @param		orderBy {String} I am the order to return records in the SpeakerTypes table returned in this query
	* @param		pagination {Boolean} I am a flag (true/false) to determine if this query should be paginated (default: false, required: orderBy)
	* @param		returnType {String} I am the format the query should be returned in, one of blank, array or query (default: blank)
	* @param		start {Numeric} I am the record number in the SpeakerTypes table to offset to (required: pagination = true)
	* @param		length {Numeric} I am the number of paginated records to return from the SpeakerTypes table (required: pagination = true)
	* @param		search {String} I am a value to search the SpeakerTypes table for
	* @param		cache {Boolean} I am a flag (true/false) to determine if this query should be cached (default: false)
	* @param		clearCache {Boolean} I am a flag (true/false) to determine if this cached query should be cleared (default: false)
	* @param		cacheTime {Any} I am the timespan the query should be cached for (default: 1 hour)
	* @param		dirtyRead {Boolean} I am a flag (true/false) to determine if this query should use WITH (NOLOCK) (default: false)
	* @param		customSQL {Array} I am an array of structs of additional SQL you want to pass into the SQL query
	* @return		query
	*/
	public any function filter(
		string returnColumns = 'speakerTypeID, speakerTypeUid, speakerTypeName, sortOrder, createdOn, updatedOn, isActive',
		string speakerTypeUid,
		string speakerTypeName,
		numeric sortOrder,
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

		if( structKeyExists( arguments, 'speakerTypeUid' ) and len( arguments.speakerTypeUid ) ) {
			thisFilter.speakerTypeUid = arguments.speakerTypeUid;
		}

		if( structKeyExists( arguments, 'speakerTypeName' ) and len( arguments.speakerTypeName ) ) {
			thisFilter.speakerTypeName = arguments.speakerTypeName;
		}

		if( structKeyExists( arguments, 'sortOrder' ) and len( arguments.sortOrder ) ) {
			thisFilter.sortOrder = arguments.sortOrder;
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
			return searchFilteredSpeakerTypeRecords( thisFilter, arguments.search );
		}

		// return filtered records
		return filterSpeakerTypeRecords( thisFilter );

	}

	/**
	* @displayname	filterSpeakerTypeRecords
	* @description	I run a query that will return all speakerTypes records. If a filter has been applied, I will refine results based on the filter
	* @param		filter {Struct} I am the filter struct to apply to this query
	* @return		query
	*/
	private any function filterSpeakerTypeRecords( struct filter = {} ) {

		// check if we're caching, and not clearing the cache
		if( arguments.filter.cache
			&& !arguments.filter.clearCache ) {

			// we are, get the query from the cache
			var qGetCachedQuery = getCachedSpeakerTypeQuery( hash( serializeJSON( arguments.filter ) ) );

			// check if we have a query from the cache
			if( !isNull( qGetCachedQuery ) ) {
				// we do, return the cached query
				return qGetCachedQuery;
			}

		}

		var params = {};
		var options = {};
		var sql = 'SELECT #arguments.filter.returnColumns# FROM SpeakerTypes#( arguments.filter.dirtyRead ? ' WITH (NOLOCK)' : '' )# WHERE 1 = 1 ';

		// check if we're running lucee and requested a specific return type
		if(
			findNoCase( 'lucee', application.engine )
			&& structKeyExists( arguments.filter, 'returnType' )
		) {
			// we did, pass the return type requested in the query options
			options = { returnType = arguments.filter.returnType };
		}

		if( structKeyExists( arguments.filter, 'speakerTypeUid' ) ) {
			sql &= 'AND speakerTypeUid = :speakerTypeUid ';
			params[ 'speakerTypeUid' ] = { value = '#arguments.filter.speakerTypeUid#', cfsqltype = 'cf_sql_idstamp' };
		}

		if( structKeyExists( arguments.filter, 'speakerTypeName' ) ) {
			sql &= 'AND speakerTypeName = :speakerTypeName ';
			params[ 'speakerTypeName' ] = { value = '#arguments.filter.speakerTypeName#', cfsqltype = 'cf_sql_varchar' };
		}

		if( structKeyExists( arguments.filter, 'sortOrder' ) ) {
			sql &= 'AND sortOrder = :sortOrder ';
			params[ 'sortOrder' ] = { value = '#arguments.filter.sortOrder#', cfsqltype = 'cf_sql_integer' };
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
			setCachedSpeakerTypeQuery(
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
	* @displayname	searchFilteredSpeakerTypeRecords
	* @description	I run a query that will return all speakerTypes records matching a passed in search term
	* @param		filter {Struct} I am the filter struct to apply to this query
	* @param		q {String} I am the search term to apply to this search
	* @return		query
	*/
	private any function searchFilteredSpeakerTypeRecords( struct filter = {}, required string q ) {

		var params = {};
		var options = {};
		var sql = 'SELECT #arguments.filter.returnColumns# FROM SpeakerTypes#( arguments.filter.dirtyRead ? ' WITH (NOLOCK)' : '' )# WHERE ( 1 = 0 ';

		// check if we're running on lucee and requested a specific return type
		if(
			findNoCase( 'lucee', application.engine )
			&& structKeyExists( arguments.filter, 'returnType' )
		) {
			// we did, pass the return type requested in the query options
			options = { returnType = arguments.filter.returnType };
		}

		if( listFindNoCase( arguments.filter.returnColumns, 'speakerTypeName', ', ' ) ) {
			sql &= 'OR speakerTypeName LIKE :q ';
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
	* @displayname	getSpeakerTypeRecordCount
	* @description	I return the total number of speakerTypes records in a table
	* @param		isActive {Boolean} I am a flag (true/false) to determine if active or inactive record counts are returned
	* @return		numeric
	*/
	public numeric function getSpeakerTypeRecordCount() {
		return filter( argumentCollection = arguments ).recordCount;
	}

	/**
	* @displayname	getSpeakerTypeNull
	* @description	I return a null speakerTypes query
	* @return		query
	*/
	public query function getSpeakerTypeNull() {

		// get the null speakerTypes record from the cache
		var qGetNullSpeakerTypeQuery = cacheGet( 'mpos_speakerTypes_query_' & hash( 'nullRecord' ) );
		// check if we have a null speakerTypes record
		if( !isNull( qGetNullSpeakerTypeQuery ) ) {
			// we do, return the cached null speakerTypes record
			return qGetNullSpeakerTypeQuery;
		}

		// get the null record
		qGetNullSpeakerTypeQuery = queryExecute( 'SELECT speakerTypeID, speakerTypeUid, speakerTypeName, sortOrder, createdOn, updatedOn, isActive FROM SpeakerTypes WITH (NOLOCK) WHERE speakerTypeID IS NULL' );

		// put the null query in the cache
		cachePut( 'mpos_speakerTypes_query_' & hash( 'nullRecord' ), qGetNullSpeakerTypeQuery, createTimeSpan( 90, 0, 0, 0 ) );

		// return the null query
		return qGetNullSpeakerTypeQuery;

	}

	/**
	* @displayname	getCachedSpeakerTypeQuery
	* @description	I return an object storage version of a cached query
	* @return		query
	*/
	public query function getCachedSpeakerTypeQuery( required string queryHash ) {

		// get the requested query from cache by the hash value
		var qGetSpeakerTypeCachedQuery = cacheGet( 'mpos_speakerTypes_query_' & arguments.queryHash );

		// check if we have the query in the cache
		if( !isNull( qGetSpeakerTypeCachedQuery ) ) {
			// we do, return the cached query
			return qGetSpeakerTypeCachedQuery;
		}

		// otherwise, we don't, return a null query
		return getSpeakerTypeNull();

	}

	/**
	* @displayname	setCachedSpeakerTypeQuery
	* @description	I set an object storage version of a cached query
	* @return		void
	*/
	public void function setCachedSpeakerTypeQuery(
		required string queryHash,
		required query queryData,
		ttl = createTimeSpan( 30, 0, 0, 0 ),
		idl = createTimeSpan( 15, 0, 0, 0 )
	) {

		// clear out existing cached query, if any
		clearCachedSpeakerTypeQuery( arguments.queryHash );

		// put query in the cache by query hash
		cachePut( 'mpos_speakerTypes_query_' & arguments.queryHash, arguments.queryData, arguments.ttl, arguments.idl );

	}

	/**
	* @displayname	clearCachedSpeakerTypeQuery
	* @description	I remove an object storage version of a cached query
	* @return		void
	*/
	public void function clearCachedSpeakerTypeQuery( required string queryHash ) {

		// clear out the cached query by query hash
		cacheRemove( 'mpos_speakerTypes_query_' & arguments.queryHash );

	}

	/**
	* @displayname	clearAllCachedSpeakerTypeQueries
	* @description	I remove all object storage versions of cached queries for this SpeakerTypeService
	* @return		void
	*/
	public void function clearAllCachedSpeakerTypeQueries() {

		// filter cached queries specific to this service
		var cacheItems = cacheGetAllIds().filter(
			function( _item ) {
				return findNoCase( 'mpos_speakerTypes_query_', _item );
 			}
		);

		// loop through the filtered cached items
		for( var item in cacheItems ) {
			// remove this item from the cache
			cacheRemove( item );
		}

	}

	/**
	* @displayname	getSpeakerTypeColumnArray
	* @description	I return all columns available for filtering in SpeakerTypeService
	* @return		array
	*/
	public array function getSpeakerTypeColumnArray() {

		return [
			'speakerTypeID',
			'speakerTypeUid',
			'speakerTypeName',
			'sortOrder',
			'createdOn',
			'updatedOn',
			'isActive'
		];
	}

	/* CUSTOM FUNCTIONS GO HERE */

}