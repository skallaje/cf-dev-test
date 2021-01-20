<cfscript>
	// TODO -load up speaker rec or create new one based on url.id
	rec = url.id ? EntityLoadByPK( "Speaker", url.id ) : EntityNew( "Speaker" );

	// process form submission
	if( !structIsEmpty( form ) ) {
		// TODO -load speaker if it's an edit, or create a new speaker. use coldfusion ORM functions entityNew or entityLoadByPK

		// TODO -populate orm object with values from form field

		// TODO -save orm object using EntitySave

		fields = listToArray( form.fieldnames );
		//writeDump(rec);
		//writeDump(fields);abort;
		structDelete( form, "fieldnames" );

		/*
		for( i in fields ) {
			if(i neq lcase("speakerType"))
				evaluate("rec.set#lcase(i)#(form.#lcase(i)#)");
			else{
				stype = int(evaluate("form.#lcase(i)#"));
				//writeDump(stype);abort;
				evaluate("rec.set#lcase(i)#(stype)");
			}


			//writeDump(#i#);
		}
		*/

		for( i in fields ) {
			if(i neq lcase("speakerType")){
				evaluate("rec.set#lcase(i)#(form.#lcase(i)#)");
			}else{
				if (len(form.speakerType)){
					speakerTypeRec = EntityLoadByPK("SpeakerType",form.speakerType);
					rec.setSpeakerType(speakerTypeRec);
				}
				
			}	
		}
		
		try {
			EntitySave( rec );
		} catch ( any e ) {
			writeDump( e );abort;
		}
		

		location( "./", false );
	}

	// TODO -load up speaker types via ORM to populate a dropdown on the form
	speakerTypes = EntityLoad("SpeakerType");

</cfscript>

<cfmodule template="/layouts/main.cfm">
	<cfoutput>
		<form name="recEditFrm" id="recEditFrm" action="/legacy/speakers/edit.cfm?id=#url.id#" method="post" class="simple-validation form-horizontal">
			<!-- build a select box for speaker types on this form -->
			<legend>Speaker Details</legend>

			<div class="form-group">
				<label for="speakerType" class="required control-label col-sm-3">Speaker Type</label>
				<div class="col-sm-6">
					<select name="speakerType">
						<option value="">Choose Speaker Type</option>
						<!--- TODO -output speakerTypes by looping through speaker types that you loaded in the cfscript block --->
						<cfloop array="#speakerTypes#" item="itm">
							<option value="#itm.getSpeakerTypeID()#" <cfif NOT isNull(rec.getSpeakerType()) AND (itm.getSpeakerTypeID() eq rec.getSpeakerType().getSpeakerTypeID())>selected</cfif>>#itm.getSpeakerTypeName()#</option>
						</cfloop>
					</select>
				</div>
			</div>

			<div class="form-group">
				<label for="firstname" class="required control-label col-sm-3">First Name</label>
				<div class="col-sm-6">
					<input type="text" class="form-control required " name="firstname" id="firstname" value="#rec.getFirstName()#" title="First name required" />
				</div>
			</div>
			<div class="form-group">
				<label for="lastname" class="required control-label col-sm-3">Last Name</label>
				<div class="col-sm-6">
					<input type="text" class="form-control required" name="lastname" id="lastname" value="#rec.getLastName()#" title="Last name required" />
				</div>
			</div>
			<div class="form-group">
				<label for="email" class="control-label col-sm-3">Email</label>
				<div class="col-sm-6">
					<input type="text" class="form-control email" name="email" id="email" value="#rec.getEmail()#" />
				</div>
			</div>
			<div class="form-group">
				<label for="company" class="control-label col-sm-3">Company Name</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" name="company" id="company" value="#rec.getCompany()#"/>
				</div>
			</div>
			<div class="form-group">
				<label for="jobTitle" class="control-label col-sm-3">Job Title</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" name="jobTitle" id="jobTitle" value="#rec.getJobTitle()#" />
				</div>
			</div>
			<div class="form-group">
				<label for="" class="control-label col-sm-3">Hide Speaker</label>
				<div class="col-sm-6">
					<div class="checkbox">
						<label>
							<input type="checkbox" name="hideSpeaker" id="hideSpeaker" value="1" <cfif  rec.getHideSpeaker()>checked</cfif>>
							Hide on Speakers Listing?
						</label>
					</div>
				</div>
			</div>
			<legend>Bio</legend>
			<div class="form-group">
				<div class="col-sm-12">
					<textarea name="bio" id="bio" class="wysiwyg">#rec.getBio()#</textarea>
				</div>
			</div>

			<div class="form-group">
				<div class="col-sm-12">
					<button type="submit" class="btn btn-lg btn-success pull-right col-sm-3">Apply Changes</button>
				</div>
			</div>
		</form>
	</cfoutput>
</cfmodule>