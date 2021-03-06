<cfscript>
	// simulate request context
	if( !structKeyExists( variables, "rc" ) ){
		rc = {};
	}

	structAppend( rc, form );
	structAppend( rc, url );

	// TODO - get the speaker bean

	// TODO - set speakerID of the speaker bean from obfuscated and encrypted value passed in url

	// get a random token key for CSRF protection
	rc.tokenKey = application.securityService.generateTokenKey();

	// TODO - check if speakerID is a non-zero guid
	if( 1 == 1 ) {
		// TODO - it is, populate the speaker bean from the database

	}

	// TODO - get the speaker types to populate the select box, use the filter function in speakerTypeService

</cfscript>

<cfoutput>
	<cfmodule template="/layouts/main.cfm">
	<div class="dashboard-content content">
		<h3 class="skinny-page-name">
			<div class="container-fluid">
				<strong>Speaker Details</strong>
			</div>
		</h3>
		<div class="container-fluid">

			<div class="text-right mb-3">
				<a href="/modern/" class="btn btn-secondary">Back To Dashboard</a>
			</div>


		<!-- form -->
		<form role="form" name="recEditFrm" id="recEditFrm" action="/modern/speakers/_handler.cfm?method=update" method="post" class="form-horizontal" data-toggle="validator">
			<!--- TODO - uncomment once you have the speaker bean in rc.speakerObj
			<input type="hidden" name="#rc.speakerObj.getUidHash( 'form' )#" value="#rc.speakerObj.getEncUid( 'form' )#">
			<input type="hidden" name="#rc.speakerObj.getTokenKeyHash()#" value="#rc.tokenKey#">
			<input type="hidden" name="#rc.speakerObj.getTokenHash()#" value="#CSRFGenerateToken( rc.tokenKey, true )#">
			--->

			<div class="form-group row">
				<label for="speakerTypeID" class="col-sm-2 col-form-label col-form-label-sm">
					Speaker Type
				</label>
				<div class="col-sm-10">
					<select name="speakerTypeID" class="form-control form-control-sm" id="speakerTypeID" data-error="Please choose a speakerType.">
						<option value="">Select speakerType</option>
						<!-- build option list using values from a speaker type query -->
					</select>
				</div>
			</div>
			<div class="form-group row">
				<label for="firstName" class="col-sm-2 col-form-label col-form-label-sm">
					First Name
				</label>
				<div class="col-sm-10">
					<input type="text" name="firstName" class="form-control form-control-sm" id="firstName" value="" placeholder="First Name">
				</div>
			</div>
			<div class="form-group row">
				<label for="lastName" class="col-sm-2 col-form-label col-form-label-sm">
					Last Name
				</label>
				<div class="col-sm-10">
					<input type="text" name="lastName" class="form-control form-control-sm" id="lastName" value="" placeholder="Last Name">
				</div>
			</div>
			<div class="form-group row">
				<label for="jobTitle" class="col-sm-2 col-form-label col-form-label-sm">
					Job Title
				</label>
				<div class="col-sm-10">
					<input type="text" name="jobTitle" class="form-control form-control-sm" id="jobTitle" value="" placeholder="Job title">
				</div>
			</div>
			<div class="form-group row">
				<label for="company" class="col-sm-2 col-form-label col-form-label-sm">
					Company
				</label>
				<div class="col-sm-10">
					<input type="text" name="company" class="form-control form-control-sm" id="company" value="" placeholder="Company">
				</div>
			</div>
			<div class="form-group row">
				<label for="email" class="col-sm-2 col-form-label col-form-label-sm">
					Email
				</label>
				<div class="col-sm-10">
					<input type="text" name="email" class="form-control form-control-sm" id="email" value="" placeholder="Email" data-error="Email is required">
				</div>
			</div>
			<div class="form-group row">
				<label for="bio" class="col-sm-2 col-form-label col-form-label-sm">
					Bio
				</label>
				<div class="col-sm-10">
					<textarea name="bio"></textarea>
				</div>
			</div>
			<div class="form-group row">
				<label for="hideSpeaker" class="col-sm-2 col-form-label col-form-label-sm required">
					Hide Speaker
				</label>
				<div class="col-sm-10">
					<select name="hideSpeaker" class="form-control form-control-sm" id="hideSpeaker" data-error="Please choose a hideSpeaker." required>
						<option value="false">No</option>
						<option value="true">Yes</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div class="card-footer text-right clearfix">
					<input type="submit" name="btnSubmit" value="Save Speaker" class="btn btn-success btn-lg">
				</div>
			</div>
		</form>

		<!-- /.form -->
		</div>
	</div>
	</cfmodule>
</cfoutput>

<cfsavecontent variable="rc.js">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/1000hz-bootstrap-validator/0.11.5/validator.min.js"></script>
</cfsavecontent>
