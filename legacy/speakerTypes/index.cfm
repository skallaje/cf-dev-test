<cfscript>
	// get the speaker types
	recs = entityLoad( "SpeakerType", {}, "speakerTypeID" );
</cfscript>

<cfmodule template="/layouts/main.cfm">
	<cfoutput>
		<h1>Speaker Types</h1>

		<div class="row">
			<nav aria-label="breadcrumb">
				<ol class="breadcrumb">
					<li class="breadcrumb-item" aria-current="page"><a href="../speakers/index.cfm">Back to Speakers</a></li>
					<li class="breadcrumb-item" aria-current="page"><a href="edit.cfm?id=0">Create New Speaker Type</a></li>
				</ol>
			</nav>
		</div>

		<div class="table-vertical">
			<cfif arrayLen( recs )>
				<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered datatables">
					<thead>
						<tr>
							<th>ID</th>
							<th>Type Name</th>
							<th>Sort Order</th>
							<th width="30%"></th>
						</tr>
					</thead>

					<tbody>
						<cfloop array="#recs#" index="i">
							<tr>
								<td data-title="ID">#i.getSpeakerTypeID()#</td>
								<td data-title="Tier Name">#i.getSpeakerTypeName()#</td>
								<td data-title="Sort Order">#i.getSortOrder()#</td>
								<td data-title="Actions">
									<div class="row options">
										<div class="col-lg-4 col-md-6">
											<a href="./edit.cfm?id=#i.getSpeakerTypeID()#" class="btn btn-sm btn-primary">edit</a>
										</div>
									</div>
								</td>
							</tr>
						</cfloop>
					</tbody>
				</table>
			<cfelse>
				<p>No speaker types have been setup</p>
			</cfif>
		</div>
	</cfoutput>
</cfmodule>