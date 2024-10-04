table 61772 "CAT-Cafe Emplo. Duty"
{

    fields
    {
        field(1; Date; Date)
        {
        }
        field(2; Day; Option)
        {
            OptionCaption = ' ,MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SATURDAY,SUNDAY';
            OptionMembers = " ",MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SATURDAY,SUNDAY;
        }
        field(3; "Employee No."; Code[10])
        {
            TableRelation = "CAT-Waiters"."Employee No.";

            trigger OnValidate()
            begin
                emp.RESET;
                emp.SETRANGE(emp."No.", "Employee No.");
                IF emp.FIND('-') THEN
                    "Employee Name" := emp."First Name" + ' ' + emp."Middle Name" + ' ' + emp."Last Name";
            end;
        }
        field(4; "Employee Name"; Text[50])
        {
        }
        field(5; "Duty Meals Header"; Text[100])
        {
        }
        field(6; "Discriptive Meals Header"; Text[100])
        {
        }
        field(7; "Daily Comment On Employee"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Employee No.", Date, Day)
        {
        }
        key(Key2; Date, Day)
        {
        }
    }

    fieldgroups
    {
    }

    var
        emp: Record 61188;
}

