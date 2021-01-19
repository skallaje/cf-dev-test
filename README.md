# cf-code-test

This is a standardized coding test given to ColdFusion/CFML developer applicants of MeetingPlay. Some of our code consists of both legacy ORM Model-View systems as well as modern bean/service OOP. This test encapsulates principles from both our legacy and modern code.

## Install Instructions

1. Clone this code test repository to your local machine
2. Create a database named `Meetingplay_codeTest` on a local or hosted Microsoft SQL Server and use the `mssql_server_setup_script.sql` file to generate required tables. 
* **NOTE**: If you do not have access to a MSSQL server, please contact your POC with MeetingPlay.
* **NOTE**: When using a local sql server instance, you may need to enable TCP/IP.  You can [look at this page](https://www.habaneroconsulting.com/stories/insights/2015/tcpip-is-disabled-by-default-in-microsoft-sql-server-2014) to see how that is done.  [This link](https://blog.greglow.com/2019/03/21/sql-why-is-sql-server-configuration-manager-missing/) is helpful to find SQL Server Configuration Manager
3. If you do not already have CommandBox installed, you can download and install the latest version from [Ortus](https://www.ortussolutions.com/products/commandbox) and install it. It is required to complete this test.
4. Open a terminal and `cd` to the directory where you stored the copy of this code test repository
5. Type `box server start` to start a Lucee CFML server
6. Open Lucee server admin at `/lucee/admin/server.cfm` and add a datasource named `Meetingplay_codeTest`

At this point you should have a running version of the test code and the browser will open to the index page from where you may get started with the test. 

* **NOTE**: If you do not have a running version of the code at this point, please contact your POC with MeetingPlay.

## Test Instructions

### Legacy

Our legacy style code utilizes the built-in ORM (Hibernate) functions such as `entityLoadByPk()` and `entitySave()` for data access. While we are iterating on the legacy functionality and upgrading to modern data access functionality, we do still have some ORM driven data. Demonstrating an understanding of how to construct an ORM entity and use it to create/edit and list speaker records is the goal of the legacy test. We have provided an example ORM entity and view code to create/edit and list speaker type records for you to reference.

ORM files are located in the `models/ormDataFiles/` directory. Examples of `edit.cfm` and `index.cfm` for speaker types are located in the `legacy/speakerTypes/` directory. Following the same pattern of speaker types, please add code to `/legacy/speakers/index.cfm` and `edit.cfm` that lists the speakers and has links to add or edit a speaker.

### Modern

Our modern style code utilizes singleton services and beans for data access, along with stored procedures for CRUD functionality. Stored procedures are included in the `mssql_server_setup_script.sql` file. Combined with a `_handler.cfm` handler, as well as `index.cfm` and `edit.cfm` view files for view and data management, the goal of the modern test is to utilize the bean/service and handler/views to create/edit and list speaker records. We have provided an example bean, service, handler and view code to create/edit and list speaker type records for you to reference.

Beans and services are located in `/models/beans` and `/models/services/`. Examples of `_handler.cfm`, `edit.cfm` and `index.cfm` for speaker types are located in the `/modern/speakerTypes/` directory.  Following the same pattern of speaker types, please add code to `/modern/speakers/_handler.cfm`, `index.cfm` and `edit.cfm `that lists the speakers and has links to add or edit a speaker.
