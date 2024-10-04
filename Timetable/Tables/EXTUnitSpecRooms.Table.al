table 74565 "EXT-Unit Spec. Rooms"
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
        field(3; "Programme Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Unit Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Room Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "TT-Rooms"."Room Code";
        }
        field(6; "Constraint Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Preferred,Mandatory,Least Preferred,Avoid';
            OptionMembers = Preferred,Mandatory,"Least Preferred",Avoid;
        }
    }

    keys
    {
        key(Key1; "Academic Year", Semester, "Programme Code", "Unit Code", "Room Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

