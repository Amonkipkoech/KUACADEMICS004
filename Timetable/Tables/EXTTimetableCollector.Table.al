table 74557 "EXT-Timetable Collector"
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
        field(6; "Date Code"; Date)
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
        field(30; "Programme Campus Priority"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Programme Room Priority"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Programme Day Priority"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Lecturer Campus Priority"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Lecturer Day Priority"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Lecturer Lesson Priority"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Unit Campus Priority"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Unit Room Priority"; Integer)
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
        key(Key1; "Record ID")
        {
        }
        key(Key2; Programme, Unit, Semester, "Lesson Code", "Date Code", Lecturer, "Room Code", "Lesson Category", "Record ID")
        {
            Clustered = true;
        }
        key(Key3; "Day Order", "Lesson Order", "Programme Campus Priority", "Programme Room Priority", "Programme Day Priority", "Lecturer Campus Priority", "Lecturer Day Priority", "Lecturer Lesson Priority", "Unit Campus Priority", "Unit Room Priority")
        {
        }
    }

    fieldgroups
    {
    }
}

