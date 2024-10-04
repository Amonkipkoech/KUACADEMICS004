table 61593 "ACA-Post Grad Change History"
{
    DrillDownPageID = 68804;
    LookupPageID = 68804;

    fields
    {
        field(1; "Programme Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme".Code;
        }
        field(2; "Stage Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD("Programme Code"));
        }
        field(3; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(4; Status; Code[50])
        {
        }
        field(5; Date; Date)
        {
        }
        field(6; "User ID"; Code[20])
        {
        }
        field(7; "Programme Option"; Code[20])
        {
            TableRelation = "ACA-Programme Options".Code WHERE("Programme Code" = FIELD("Programme Code"),
                                                                "Stage Code" = FIELD("Stage Code"));
        }
        field(8; Semester; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme Semesters".Semester WHERE("Programme Code" = FIELD("Programme Code"));

            trigger OnValidate()
            begin
                //"Settlement Type":='';
            end;
        }
        field(9; Remarks; Text[100])
        {
        }
        field(10; "Student No"; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(11; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(12; "Status Type"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Line No")
        {
        }
        key(Key2; "Student No")
        {
        }
        key(Key3; "Programme Code")
        {
        }
        key(Key4; "Status Type")
        {
        }
        key(Key5; Status)
        {
        }
        key(Key6; "Student No", "Programme Code", "Status Type", Status)
        {
        }
    }

    fieldgroups
    {
    }
}

