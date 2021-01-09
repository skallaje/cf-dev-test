component output=false entityname="Speaker" table="Speakers" persistent=true
{
	property name="speakerID" 	fieldtype="id" generator="native";
	property name="speakerUid"	fieldtype="column" generated="insert" dbdefault="newid()";
	property name="firstName" 	ormtype="string" sqltype="nvarchar(150)";
	property name="lastName" 	ormtype="string" sqltype="nvarchar(150)";
	property name="jobTitle" 	ormtype="string" sqltype="nvarchar(150)";
	property name="company" 	ormtype="string" sqltype="nvarchar(150)";
	property name="email" 		ormtype="string" length="150";
	property name="bio" 		ormtype="string" sqltype="nvarchar(max)";
	property name="hideSpeaker" ormtype="boolean" sqltype="bit"	notnull="true"	default="false";
	property name="createdOn" 	ormtype="timestamp" notnull="true"	required="true";
	property name="updatedOn" 	ormtype="timestamp" notnull="true"	required="true";
	property name="isActive" 	ormtype="boolean" notnull="true" required="true" default="true";

	property	name="SpeakerType"
				fieldtype="many-to-one"
				cfc="SpeakerType"
				fkcolumn="speakerTypeID"
				lazy="true"
				inverse="true"
				foreignkeyname="FK_Speakers_SpeakerTypes";
}