<p>
	Our legacy style code utilizes the built-in ORM (Hibernate) functions such as entityLoadByPk() and entitySave() for data access. While we are iterating on the legacy functionality and upgrading to modern data access functionality, we do still have some ORM driven data. Demonstrating an understanding of how to construct an ORM entity and use it to create/edit and list speaker records is the goal of the legacy test. We have provided an example ORM entity and view code to create/edit and list speaker type records for you to reference.<br><br>

	ORM files are located in the models/ormDataFiles/ directory. Examples of edit.cfm and index.cfm for speaker types are located in the <a href="/legacy/speakerTypes/index.cfm">/legacy/speakerTypes/</a> directory.<br><br>

	Following the same pattern of speaker types, please add code to <a href="/legacy/speakers/index.cfm">/legacy/speakers/index.cfm</a> and edit.cfm that lists the speakers and has links to add or edit a speaker.
</p>