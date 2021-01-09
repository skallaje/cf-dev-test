<cfscript>
	// simulate request context
	if( !structKeyExists( variables, "rc" ) ){
		rc = {};
	}

	structAppend( rc, form );
	structAppend( rc, url );

	// get the speakerType bean
	rc.speakerTypeObj = new models.beans.SpeakerTypeBean();
	// set speakerTypeID of the speakerType bean from obfuscated and encrypted value passed in url
	rc.speakerTypeObj.setSpeakerTypeID( rc.speakerTypeObj.getDecUid( rc[ rc.speakerTypeObj.getUidHash( 'url' ) ], 'url' ) );
	// get a random token key for CSRF protection
	rc.tokenKey = application.securityService.generateTokenKey();
	// check if speakerTypeID is a non-zero guid
	if( rc.speakerTypeObj.getSpeakerTypeID() neq application.zeroGuid ) {
		// it is, populate the speakerType bean from the database
		rc.speakerTypeObj = application.speakerTypeService.getSpeakerTypeByID( rc.speakerTypeObj.getSpeakerTypeID() );
	}
</cfscript>

<cfmodule template="/layouts/main.cfm">
	<cfoutput>
		<div class="dashboard-content content">
			<h3 class="skinny-page-name">
				<div class="container-fluid">
					<strong>#( ( rc.speakerTypeObj.getSpeakerTypeUid() eq application.zeroGuid ) ? 'Add' : 'Edit' )# Speaker Type</strong>
				</div>
			</h3>
			<div class="container-fluid">

				<div class="text-right mb-3">
					<a href="/modern/speakerTypes/index.cfm" class="btn btn-secondary">Back To Dashboard</a>
				</div>


				<!-- form -->
				<form role="form" name="recEditFrm" id="recEditFrm" action="/modern/speakerTypes/_handler.cfm?method=update" method="post" class="form-horizontal" data-toggle="validator">
					<input type="hidden" name="#rc.speakerTypeObj.getUidHash( 'form' )#" value="#rc.speakerTypeObj.getEncUid( 'form' )#">
					<input type="hidden" name="#rc.speakerTypeObj.getTokenKeyHash()#" value="#rc.tokenKey#">
					<input type="hidden" name="#rc.speakerTypeObj.getTokenHash()#" value="#CSRFGenerateToken( rc.tokenKey, true )#">

					<div class="form-group">
						<label for="speakerTypeName" class="control-label col-sm-3 required">
							Speaker Type Name
						</label>
						<div class="col-sm-6">
							<input type="text" name="speakerTypeName" class="form-control form-control-sm" id="speakerTypeName" value="#encodeForHTML( rc.speakerTypeObj.getSpeakerTypeName() )#" placeholder="Speaker Type Name" data-error="Speaker Type Name is required" required>
						</div>
					</div>
					<div class="form-group">
						<label for="sortOrder" class="control-label col-sm-3">
							Sort Order
						</label>
						<div class="col-sm-6">
							<input type="text" name="sortOrder" class="form-control form-control-sm" id="sortOrder" value="#isNumeric( rc.speakerTypeObj.getSortOrder() ) ? encodeForHTML( rc.speakerTypeObj.getSortOrder() ) : 0#">
						</div>
					</div>
					<div class="form-group">
						<div class="card-footer text-right clearfix">
							<input type="submit" name="btnSubmit" value="#( ( rc.speakerTypeObj.getSpeakerTypeUid() eq application.zeroGuid ) ? 'Add' : 'Update' )# SpeakerType" class="btn btn-success btn-lg">
						</div>
					</div>
				</form>

				<!-- /.form -->
			</div>
		</div>
	</cfoutput>

	<script src="https://cdnjs.cloudflare.com/ajax/libs/1000hz-bootstrap-validator/0.11.5/validator.min.js"></script>

</cfmodule>