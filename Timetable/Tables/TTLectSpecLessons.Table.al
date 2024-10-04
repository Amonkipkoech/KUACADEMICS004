table 74512 "TT-Lect. Spec. Lessons"
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
        field(4; "Lesson Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "TT-Lessons"."Lesson Code";
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
        key(Key1; "Academic Year", Semester, "Lecturer Code", "Lesson Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

