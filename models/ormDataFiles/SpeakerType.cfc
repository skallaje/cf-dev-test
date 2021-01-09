component output=false entityname="SpeakerType" table="SpeakerTypes" persistent=true
{
	property name="speakerTypeID" 		fieldtype="id" generator="native";
	property name="speakerTypeUid"		fieldtype="column" generated="insert" dbdefault="newid()";
	property name="speakerTypeName" 	ormtype="string" notnull="true" length="150";
	property name="sortOrder" 			ormtype="integer";
	property name="createdOn" 			ormtype="timestamp" notnull="true" required="true";
	property name="updatedOn" 			ormtype="timestamp" notnull="true" required="true";
	property name="isActive" 	ormtype="boolean" notnull="true" required="true" default="true";

	// one-to-many
	property	name="Speaker"
				fieldtype="one-to-many"
				cfc="Speaker"
				fkcolumn="speakerTypeID"
				inverse="true"
				lazy="true"
				cascade="delete"
				foreignkeyname="FK_Type_Speaker";
}
