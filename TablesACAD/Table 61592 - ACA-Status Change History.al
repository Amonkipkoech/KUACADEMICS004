table 61592 "ACA-Status Change History"
{
    // DrillDownPageID = 67163;
    // LookupPageID = 67163;

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
        field(4; "Exam Status"; Option)
        {
            OptionCaption = ' ,Setting,Typing,Proofreading,Printing,Ready,Collected';
            OptionMembers = " ",Setting,Typing,Proofreading,Printing,Ready,Collected;
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
        field(10; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; "Programme Code", "Code", "Exam Status", Date, "User ID", Semester, Remarks, "Line No")
        {
        }
    }

    fieldgroups
    {
    }
}

