table 74560 "EXT-Lect. Spec. Campuses"
{

    fields
    {
        field(1; "Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Academic Year".Code;
        }
        field(2; Semester; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Semesters".Code;
        }
        field(3; "Lecturer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Campus Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('CAMPUS'));
        }
        field(5; "Constraint Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Preferred,Mandatory,Least Preferred,Avoid';
            OptionMembers = Preferred,Mandatory,"Least Preferred",Avoid;
        }
    }

    keys
    {
        key(Key1; "Academic Year", Semester, "Lecturer Code", "Campus Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
