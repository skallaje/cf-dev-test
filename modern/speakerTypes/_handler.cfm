<cfscript>
	// simulate request context
	if( !structKeyExists( variables, "rc" ) ){
		rc = {};
	}

	structAppend( rc, form );
	structAppend( rc, url );

	if( !structKeyExists( rc, 'method' ) ) {
		// and redirect back to the list view
		location( '/modern/speakerTypes//', false );
	}

	// switch on the passed in method
	switch( rc.method ) {

		// *** UPDATE ***
		case 'update':
			// get the speakerType bean
			rc.speakerTypeObj = new models.beans.SpeakerTypeBean();
			// set speakerTypeID of the speakerType bean from obfuscated and encrypted value passed in form
			rc.speakerTypeObj.setSpeakerTypeID( rc.speakerTypeObj.getDecUid( rc[ rc.speakerTypeObj.getUidHash( 'form' ) ], 'form' ) );
			// get the CSRF token key and token passed in the form
			rc.token = {
				key = rc[ rc.speakerTypeObj.getTokenKeyHash() ],
				value = rc[ rc.speakerTypeObj.getTokenHash() ]
			};
			// verify the CSRF token is valid
			if( !CSRFVerifyToken( rc.token.value, rc.token.key ) ) {
				// it isn't, force the user to login again
				location( '/modern/', false );
			}

			// check if the speakerTypeID is a zero guid
			if( rc.speakerTypeObj.getSpeakerTypeUid() eq application.zeroGuid ) {
				// it is, set it to a new generated guid value
				rc.speakerTypeObj.setSpeakerTypeUid( application.securityService.getGUID() );
				// set createdOn to now()
				rc.speakerTypeObj.setCreatedOn( now() );
			} else {
				// it isn't, populate the speakerType bean from the database
				rc.speakerTypeObj = application.speakerTypeService.getSpeakerTypeByID( rc.speakerTypeObj.getSpeakerTypeID() );
			}
			// set the value of speakerTypeName passed in the form
			rc.speakerTypeObj.setSpeakerTypeName( trim( rc.speakerTypeName ) );
			// set the value of sortOrder passed in the form
			rc.speakerTypeObj.setSortOrder( trim( rc.sortOrder ) );
			// set the value of updatedOn to now()
			rc.speakerTypeObj.setUpdatedOn( now() );
			// set isActive to true
			rc.speakerTypeObj.setIsActive( true );

			// save the speakerType bean to the database
			application.speakerTypeService.saveSpeakerType( rc.speakerTypeObj );

			// clear all cached query data
			application.speakerTypeService.clearAllCachedSpeakerTypeQueries();

			// and redirect back to the list view
			location( '/modern/speakerTypes/', false );

		break;

		// *** DEACTIVATE ***
		case 'deactivate':
			// get the speakerType bean
			rc.speakerTypeObj = new models.beans.SpeakerTypeBean();
			// set speakerTypeID of the speakerType bean from obfuscated and encrypted value passed in url
			rc.speakerTypeObj.setSpeakerTypeID( rc.speakerTypeObj.getDecUid( rc[ rc.speakerTypeObj.getUidHash( 'url' ) ], 'url' ) );
			// populate the speakerType from the database
			rc.speakerTypeObj = application.speakerTypeService.getSpeakerTypeByID( rc.speakerTypeObj.getSpeakerTypeID() );
			// set isActive to false
			rc.speakerTypeObj.setIsActive( false );
			// save the speakerType bean to the database
			application.speakerTypeService.saveSpeakerType( rc.speakerTypeObj );
			// and redirect back to the list view
			location( '/modern/speakerTypes/', false );
		break;

		// *** REACTIVATE ***
		case 'reactivate':
			// get the speakerType bean
			rc.speakerTypeObj = new models.beans.SpeakerTypeBean();
			// set speakerTypeID of the speakerType bean from obfuscated and encrypted value passed in url
			rc.speakerTypeObj.setSpeakerTypeID( rc.speakerTypeObj.getDecUid( rc[ rc.speakerTypeObj.getUidHash( 'url' ) ], 'url' ) );
			// populate the speakerType from the database
			rc.speakerTypeObj = application.speakerTypeService.getSpeakerTypeByID( rc.speakerTypeObj.getSpeakerTypeID() );
			// set isActive to true
			rc.speakerTypeObj.setIsActive( true );
			// save the speakerType bean to the database
			application.speakerTypeService.saveSpeakerType( rc.speakerTypeObj );
			// and redirect back to the list view
			location( '/modern/speakerTypes/', false );
		break;

		// *** DATATABLE ***
		case 'datatable':

			// disable debug output
			setting showdebugoutput=false;

			// get the speakerType bean
			rc.speakerTypeObj = new models.beans.SpeakerTypeBean();

			// setup variables for looping through the query
			rc.returnStruct = {};
			rc.speakerTypeArr = [];
			rc.orderBy = '';
			rc.orderByArr = [];
			// check if we have a valid isActive passed in
			if( !structKeyExists( rc, 'isActive')
				|| !isBoolean( rc.isActive )
			) {
				// we don't, set it to true to show only active records
				rc.isActive = true;
			}

			// set the columns to return in this query
			rc.returnColumns = 'speakerTypeID, speakerTypeUid, speakerTypeName, sortOrder';

			// set the columns that will be sortable in the datatable
			rc.sortableColumns = 'speakerTypeID,speakerTypeName,sortOrder';

			// ensure a search value was passed from the datatable
			if( !structKeyExists( rc, 'search[value]') ) {
				// it wasn't, set it to blank
				rc[ 'search[value]' ] = '';
			}

			// loop through the total sortable columns in the datatable
			for( rc.idx = 0; rc.idx < listLen( rc.sortableColumns ); rc.idx++ ) {

				// ensure an order value was passed from the datatable
				if( !structKeyExists( rc, 'order[#rc.idx#][dir]' ) ) {
					// it wasn't, set it to asc order
					rc[ 'order[#rc.idx#][dir]' ] = 'asc';
				}

				// ensure an order column was passed from the datatable
				if( structKeyExists( rc, 'order[#rc.idx#][column]' ) ) {
					rc.orderByArr.append( listGetAt( rc.sortableColumns, rc[ 'order[#rc.idx#][column]' ] + 1 ) );

				}
			}

			// check if our sort array has length
			if( arrayLen( rc.orderByArr ) ) {

				// it does, loop through the sort array
				for( rc.idx = 1; rc.idx <= arrayLen( rc.orderByArr ); rc.idx++ ) {

					// add this column and sort order to the order by clause
					rc.orderBy &= rc.orderByArr[ rc.idx ] & ' ' & rc[ 'order[#rc.idx - 1#][dir]' ];
					if( !rc.idx eq arrayLen( rc.orderByArr ) ) {
						rc.orderBy &= ', ';
					}

				}

			// otherwise
			} else {

				// set the default order by clause column
				rc.orderBy = '#listFirst( rc.sortableColumns )# asc';

			}

			// get the total SpeakerType records
			rc.totalRecords = application.speakerTypeService.getSpeakerTypeRecordCount( isActive = rc.isActive );

			// get a query of SpeakerType records
			rc.qGetSpeakerTypes = application.speakerTypeService.filter(
				isActive = rc.isActive,
				orderBy = rc.orderBy,
				returnColumns = rc.returnColumns,
				pagination = true,
				start = rc.start,
				length = rc.length,
				search = rc[ 'search[value]' ],
				cache = false, // TBD: Set this to true in production
				clearCache = structKeyExists( rc, 'clearCache' ) ? rc.clearCache : false
			);

			// loop through the SpeakerType records
			for( rc.speakerType in rc.qGetSpeakerTypes ) {

				// set up a struct to hold this row of data
				rc.speakerTypeStruct = {};

				// encrypt the speakerTypeID value for this row
				rc.encId = application.securityService.dataEnc( rc.speakerType.speakerTypeID, 'url' );

				// add the speakerTypeID column to the datatable
				rc.speakerTypeStruct['speakerTypeID'] = rc.speakerType.speakerTypeID;
				// add the speakerTypeName column to the datatable
				rc.speakerTypeStruct['speakerTypeName'] = rc.speakerType.speakerTypeName;
				// add the sortOrder column to the datatable
				rc.speakerTypeStruct['sortOrder'] = rc.speakerType.sortOrder;

				// build the edit anchor for this row
				rc.speakerTypeStruct['actions'] = '<a href="/modern/speakerTypes/edit.cfm?#rc.speakerTypeObj.getUidHash( 'url' )#=#rc.encId#" class="btn btn-primary btn-sm" data-toggle="tooltip" data-placement="top" title="Edit">Edit</a>';

				// check if we're displaying active records
				if( rc.isActive ) {

					// we are, build the deactivate modal anchor for this row
					rc.speakerTypeStruct['actions'] &= '<span data-id="#rc.encId#" data-toggle="modal" data-target="##speakerTypeModal" data-entity="[PLACEHOLDER]"><a href="##speakerTypeModal" class="btn btn-danger btn-sm" data-toggle="tooltip" data-placement="top" title="Delete">Delete</a></span>';

				// otherwise
				} else {

					// we're not, build the reactivate anchor for this row
					rc.speakerTypeStruct['actions'] &= '<a href="/modern/speakerTypes/_handler.cfm?method=reactivate&#rc.speakerTypeObj.getUidHash( 'url' )#=#rc.encId#" class="btn btn-primary" data-toggle="tooltip" data-placement="top" title="Reactivate">Reactivate</a>';
				}

				// add this row to the array
				rc.speakerTypeArr.append( rc.speakerTypeStruct );

			}

			// set datatable required values
			rc.returnStruct[ 'draw' ] = rc.draw;
			rc.returnStruct[ 'recordsTotal' ] = rc.totalRecords;
			rc.returnStruct[ 'recordsFiltered' ] = len( rc[ 'search[value]' ] ) ? rc.qGetSpeakerTypes.recordCount : rc.totalRecords;
			rc.returnStruct[ 'data' ] = rc.speakerTypeArr;

			// render as JSON to the datatable
			writeOutput( serializeJSON( rc.returnStruct ) ) ;
		break;
	}

</cfscript>