/// <summary>
/// Table TT-Rooms (ID 74501).
/// </summary>
table 74501 "TT-Rooms"
{
    DrillDownPageID = 74521;
    LookupPageID = 74521;

    fields
    {
        field(1; "Block Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "TT-Blocks"."Block Code" WHERE("Academic Year" = FIELD("Academic year"),
                                                          Semester = FIELD(Semester));
        }
        field(2; "Room Code"; Code[20])
        {
           
            TableRelation = "ACA-Lecturer Halls Setup"."Lecture Room Code";
            trigger OnValidate()
            begin
                ttRoom.Reset();
                ttRoom.SetRange(ttRoom."Lecture Room Code", "Room Code");
                if ttRoom.Find('-') then begin
                    "Class Capacity (Max)" := ttRoom."Sitting Capacity";
                    "Exam Capacity (Max)" := ttRoom."Exam Sitting Capacity";

                end
            end;
        }
        field(3; "Room Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Class,Lab,Hall';
            OptionMembers = Class,Lab,Hall;
        }
        field(4; "Class Capacity (Min)"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Class Capacity (Max)"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Exam Capacity (Min)"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Exam Capacity (Max)"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Active,Under Maintenance,Suspended';
            OptionMembers = Active,"Under Maintenance",Suspended;
        }
        field(9; Semester; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Academic year"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Block Code","Room Code", "Academic year", Semester)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    var
        ttRoom: Record "ACA-Lecturer Halls Setup";
}

