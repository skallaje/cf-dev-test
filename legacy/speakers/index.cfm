<cfscript>
	// TODO - load up speaker recs to be displayed order by lastName, firstName

</cfscript>

<cfmodule template="/layouts/main.cfm">
	<cfoutput>
		<h1>Speakers</h1>
		<div class="row">
			<nav aria-label="breadcrumb">
				<ol class="breadcrumb">
					<li class="breadcrumb-item" aria-current="page"><a href="../speakerTypes/index.cfm">Back to Speaker Types</a></li>
					<li class="breadcrumb-item" aria-current="page"><a href="edit.cfm?id=0">Create New Speaker</a></li>
				</ol>
			</nav>
		</div>

		<div class="table-vertical">
			<!--- output the list of speakers on this page. fields to output in datatable speakerID, firstName, lastName, email, company and button to edit --->
			<!--- TODO - check to see if there are any speakers in the database --->
			<cfif 1 EQ 1>
				<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered datatables">
					<thead>
						<tr>
							<th>ID</th>
							<th>First Name</th>
							<th>Last Name</th>
							<th>Email</th>
							<th>Company</th>
							<th width="30%"></th>
						</tr>
					</thead>

					<tbody>
						<!--- TODO - loop through speaker recs and complete the table --->
					</tbody>
				</table>
			<cfelse>
				<p>No speakers have been setup</p>
			</cfif>
		</div>
	</cfoutput>
</cfmodule>