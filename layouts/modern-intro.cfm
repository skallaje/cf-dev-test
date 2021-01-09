<p>
	Our modern style code utilizes singleton services and beans for data access, along with stored procedures for CRUD functionality. Stored procedures are included in the mssql_server_setup_script.sql file. Combined with a _handler.cfm handler, as well as index.cfm and edit.cfm view files for view and data management, the goal of the modern test is to utilize the bean/service and handler/views to create/edit and list speaker records. We have provided an example bean, service, handler and view code to create/edit and list speaker type records for you to reference.<br><br>

	Beans and services are located in /models/beans and /models/services/. Examples of _handler.cfm, edit.cfm and index.cfm for speaker types are located in the <a href="/modern/speakerTypes/index.cfm">/modern/speakerTypes/</a> directory.<br><br>

	Following the same pattern of speaker types, please add code to <a href="/modern/speakers/index.cfm">/modern/speakers/index.cfm</a>, edit.cfm and _handler.cfm that lists the speakers and has links to add or edit a speaker.
</p>