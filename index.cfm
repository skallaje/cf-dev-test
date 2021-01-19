<cfmodule template="/layouts/main.cfm">

	<h1>MP Code Test</h1>

	<p>This is a standardized coding test given to ColdFusion/CFML developer applicants of MeetingPlay. Some of our code consists of both legacy ORM Model-View systems as well as modern bean/service OOP. This test encapsulates principles from both our legacy and modern code.</p>

	<h2>Install Instructions</h2>

	<ol>
		<li>Clone this code test repository to your local machine</li>
		<li>Create a database named "Meetingplay_codeTest" on a local or hosted Microsoft SQL Server and use the "mssql_server_setup_script.sql" file to generate required tables.<br> **NOTE**: If you do not have access to a MSSQL server, please contact your POC with MeetingPlay.<br>**NOTE** When using a local sql server instance, you may need to enable TCP/IP.
			You can look at this <a href="https://www.habaneroconsulting.com/stories/insights/2015/tcpip-is-disabled-by-default-in-microsoft-sql-server-2014" target="_blank">page</a> to see how that is done.
			<a href="https://blog.greglow.com/2019/03/21/sql-why-is-sql-server-configuration-manager-missing/" target="_blank">This link</a> is helpful to find SQL Server Configuration Manager. You may need to create a <a href="https://www.microfocus.com/documentation/silk-test/200/en/silktestworkbench-help-en/SILKTEST-7FFBB86A-CREATINGNEWSQLSERVERADMINUSER-TSK.html">database user</a> and add them to your local database in order to setup the datasource.
			You will also need to enable <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/change-server-authentication-mode?view=sql-server-ver15">mixed mode authentication</a> in SQL server if it's not enabled already.
		</li>
		<li>If you do not already have CommandBox installed, you can download and install the latest version from <a href="https://www.ortussolutions.com/products/commandbox" target="_blank">Ortus</a> and install it. It is required to complete this test.</li>
		<li>Open a terminal and "cd" to the directory where you stored the copy of this code test repository</li>
		<li>Type "box server start" to start a Lucee CFML server</li>
		<li>Open Lucee server admin at "/lucee/admin/server.cfm", the password to the admin is 'commandbox'.  Once you login, create a datasource named "Meetingplay_codeTest"</li>


	</ol>
	<p>At this point you should have a running version of the test code and the browser will open to the index page from where you may get started with the test. <br>**NOTE**: If you do not have a running version of the code at this point, please contact your POC with MeetingPlay.</p>

	<h2>Test Instructions</h2>
	<div>
		<p>We have two styles of code in our codebase, <a href="/legacy/index.cfm">legacy</a> (ORM) and a more <a href="/modern/index.cfm">modern</a> pattern using beans and services</p>

		<cfinclude template="/layouts/legacy-intro.cfm"/>

		<cfinclude template="/layouts/modern-intro.cfm"/>
	</div>

</cfmodule>