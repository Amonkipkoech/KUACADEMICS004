table 61187 "ACA-Cummulative Temp"
{

    fields
    {
        field(1; Unit; Code[20])
        {
        }
        field(2; "Unit Type"; Option)
        {
            OptionCaption = 'Core,Elective,Required';
            OptionMembers = Core,Elective,Required;
        }
        field(3; Score; Decimal)
        {
        }
        field(4; Student; Code[20])
        {
        }
        field(5; Audit; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; Unit)
        {
        }
        key(Key2; "Unit Type", Score)
        {
        }
        key(Key3; Score)
        {
        }
        key(Key4; "Unit Type")
        {
        }
    }

    fieldgroups
    {
    }
}

