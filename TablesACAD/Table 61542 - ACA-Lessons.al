table 61542 "ACA-Lessons"
{
    DrillDownPageID = 68769;
    LookupPageID = 68769;

    fields
    {
        field(1; "No."; Integer)
        {
        }
        field(2; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(3; Descrition; Text[30])
        {
        }
        field(4; "Start Time"; Time)
        {
        }
        field(5; "End Time"; Time)
        {
        }
        field(6; "No Of Hours"; Decimal)
        {
        }
        field(7; "Full Time/Part Time"; Option)
        {
            OptionCaption = 'Full Time,Part Time';
            OptionMembers = "Full Time","Part Time";
        }
        field(8; "Main Session"; Code[20])
        {
            TableRelation = "ACA-Student Types".Code;
            //This property is currently not supported
            //TestTableRelation = true;
            ValidateTableRelation = true;
        }
        field(9; "Sub Session"; Code[50])
        {
            TableRelation = "ACA-Student Types".Code;
        }
        field(10; "Session Filter"; Code[50])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Student Types".Code;
        }
        field(11; "Applicable Day"; Code[20])
        {
            TableRelation = "ACA-Day Of Week".Day;
        }
        field(12; Type; Option)
        {
            OptionCaption = 'Teaching,Exam';
            OptionMembers = Teaching,Exam;
        }
        field(13; "Used Count"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "No.", "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

