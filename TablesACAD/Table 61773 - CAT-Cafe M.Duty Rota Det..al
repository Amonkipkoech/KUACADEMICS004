table 61773 "CAT-Cafe M.Duty Rota Det."
{

    fields
    {
        field(2; Days; Option)
        {
            OptionCaption = ' ,MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SATURDAY,SUNDAY';
            OptionMembers = " ",MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SATURDAY,SUNDAY;
        }
        field(3; Month; Code[10])
        {
        }
        field(4; Year; Code[10])
        {
        }
        field(5; "Morning Shift"; Code[10])
        {
            TableRelation = "CAT-Waiters"."Employee No.";

            trigger OnValidate()
            begin
                emp.RESET;
                emp.SETRANGE(emp."No.", "Morning Shift");
                IF emp.FIND('-') THEN
                    "Morning Shift Name" := emp."First Name" + ' ' + emp."Middle Name" + ' ' + emp."Last Name";
            end;
        }
        field(6; "Evening Shift"; Code[10])
        {
            TableRelation = "CAT-Waiters"."Employee No.";

            trigger OnValidate()
            begin
                emp.RESET;
                emp.SETRANGE(emp."No.", "Evening Shift");
                IF emp.FIND('-') THEN
                    "Evening Shift Name" := emp."First Name" + ' ' + emp."Middle Name" + ' ' + emp."Last Name";
            end;
        }
        field(7; "Day Off"; Code[10])
        {
            TableRelation = "CAT-Waiters"."Employee No.";

            trigger OnValidate()
            begin
                emp.RESET;
                emp.SETRANGE(emp."No.", "Day Off");
                IF emp.FIND('-') THEN
                    "Day Off Shift Name" := emp."First Name" + ' ' + emp."Middle Name" + ' ' + emp."Last Name";
            end;
        }
        field(8; "Morning Shift Name"; Text[100])
        {
        }
        field(9; "Evening Shift Name"; Text[100])
        {
        }
        field(10; "Day Off Shift Name"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Morning Shift", Days, Month, Year)
        {
        }
        key(Key2; "Evening Shift", Days, Month, Year)
        {
        }
        key(Key3; "Day Off", Days, Month, Year)
        {
        }
        key(Key4; Days, Month, Year)
        {
        }
    }

    fieldgroups
    {
    }

    var
        emp: Record 61188;
}

