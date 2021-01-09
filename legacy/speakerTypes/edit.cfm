<cfscript>
	rec = url.id ? EntityLoadByPK( "SpeakerType", url.id ) : EntityNew( "SpeakerType" );

	if( !structIsEmpty( form ) ) {

		fields = listToArray( form.fieldnames );

		structDelete( form, "fieldnames" );

		for( i in fields ) {
			evaluate("rec.set#lcase(i)#(form.#lcase(i)#)");
		}

		try {
			EntitySave( rec );
		} catch ( any e ) {
			writeDump( e );abort;
		}


		location( "./", false );
	}
</cfscript>

<cfmodule template="/layouts/main.cfm">
	<cfoutput>
		<form name="recEditFrm" id="recEditFrm" action="/legacy/speakerTypes/edit.cfm?id=#url.id#" method="post" class="simple-validation form-horizontal">
			<legend>Type Details</legend>

			<div class="form-group">
				<label for="speakerTypeName" class="required control-label col-sm-3">Name</label>
				<div class="col-sm-6">
					<input type="text" class="form-control required" name="speakerTypeName" id="speakerTypeName" value="#rec.getSpeakerTypeName()#" title="Speaker Type Name is required" />
				</div>
			</div>

			<div class="form-group">
				<label for="sortOrder" class="required control-label col-sm-3">Sort Order</label>
				<div class="col-sm-6">
					<input type="number" class="form-control required" name="sortOrder" id="sortOrder" value="#val(rec.getSortOrder())#" step="1" title="Sort Order is required" />
				</div>
			</div>

			<div class="form-group">
				<div class="col-sm-12">
					<button type="submit" class="btn btn-lg btn-success pull-right col-sm-3"><cfif isNull(rec.getSpeakerTypeID())>Create Type<cfelse>Apply Changes</cfif></button>
				</div>
			</div>

			<div style="height:100px;"></div>
		</form>
	</cfoutput>
</cfmodule>