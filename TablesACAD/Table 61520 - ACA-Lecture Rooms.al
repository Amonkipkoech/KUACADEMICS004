table 61520 "ACA-Lecture Rooms"
{
    DrillDownPageID = 68775;
    LookupPageID = 68775;

    fields
    {
        field(1; "Building Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Building".Code;
        }
        field(2; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(3; Description; Text[150])
        {
        }
        field(4; "Minimum Capacity"; Decimal)
        {
        }
        field(5; "Maximum Capacity"; Decimal)
        {
        }
        field(6; Remarks; Text[150])
        {
        }
        field(7; Facilities; Text[200])
        {
        }
        field(8; "Reserve For"; Code[20])
        {
            TableRelation = "ACA-Programme".Code;
        }
        field(9; "User ID"; Code[20])
        {
            TableRelation = User."User Security ID";
        }
        field(10; "No."; Integer)
        {
        }
        field(11; "Room Type"; Option)
        {
            OptionCaption = 'Lecture Hall,Lab';
            OptionMembers = "Lecture Hall",Lab;
        }
        field(12; "Lab No."; Integer)
        {
        }
        field(13; "Time Table Count"; Integer)
        {
        }
        field(14; "Day Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(15; "Lesson Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(16; "Used Count"; Integer)
        {
            CalcFormula = Count("ACA-Time Table" WHERE("Day of Week" = FIELD("Day Filter"),
                                                        "Lecture Room" = FIELD(Code),
                                                        Period = FIELD("Lesson Filter")));
            FieldClass = FlowField;
        }
        field(17; "Global Dimension 1"; Code[50])
        {
        }
        field(18; Reserved; Boolean)
        {
        }
        field(19; "Reserve For Unit"; Code[20])
        {
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD("Reserve For"));

            trigger OnValidate()
            begin
                IF "Reserve For" = '' THEN Reserved := FALSE ELSE Reserved := TRUE;
                MODIFY;
            end;
        }
        field(20; "Reseverd Count"; Integer)
        {
        }
        field(21; "Semester Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Semesters".Code;
        }
    }

    keys
    {
        key(Key1; "Building Code", "Code")
        {
        }
        key(Key2; "Time Table Count")
        {
        }
    }

    fieldgroups
    {
    }
}

