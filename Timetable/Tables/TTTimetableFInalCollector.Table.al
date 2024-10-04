table 74523 "TT-Timetable FInal Collector"
{

    fields
    {
        field(1; Programme; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme".Code;
        }
        field(3; Unit; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD(Programme));
        }
        field(4; Semester; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Semesters".Code;
        }
        field(5; "Lesson Code"; Code[20])
        {
            NotBlank = true;
        }
        field(6; "Day of Week"; Code[20])
        {
        }
        field(8; "Lecture Room"; Code[10])
        {
        }
        field(12; Lecturer; Code[20])
        {
            NotBlank = true;
            TableRelation = "HRM-Employee (D)"."No.";
        }
        field(18; Department; Code[20])
        {
        }
        field(20; "Room Type"; Option)
        {
            OptionCaption = 'Room,Labs';
            OptionMembers = Room,Labs;
        }
        field(21; "Campus Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(22; "Lesson Order"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Day Order"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Lesson Category"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "School or Faculty"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Room Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Block/Building"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Record ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(29; Allocated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Lesson Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Class Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Programme, Unit, Semester, "Lesson Code", "Day of Week", "Lecture Room", Lecturer, Department, "Room Type", "Campus Code", "Room Code", "Block/Building", "School or Faculty", "Lesson Category")
        {
            Clustered = true;
        }
        key(Key2; "Lesson Order", "Day Order")
        {
        }
    }

    fieldgroups
    {
    }
}

