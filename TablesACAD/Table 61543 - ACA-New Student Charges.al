table 61543 "ACA-New Student Charges"
{
    DrillDownPageID = 68748;
    LookupPageID = 68748;

    fields
    {
        field(1; "Programme Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme".Code;
        }
        field(3; "Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Charge".Code;

            trigger OnValidate()
            begin
                Charges.RESET;
                Charges.SETRANGE(Charges.Code, Code);
                IF Charges.FIND('-') THEN BEGIN
                    Description := Charges.Description;
                    Amount := Charges.Amount;
                END
                ELSE BEGIN
                    Description := '';
                    Amount := 0;
                END;
            end;
        }
        field(4; Description; Text[200])
        {
        }
        field(5; Amount; Decimal)
        {
            NotBlank = true;
        }
        field(7; Remarks; Text[150])
        {
        }
        field(9; "Recovered First"; Boolean)
        {
        }
        field(10; "First Time Students"; Boolean)
        {
        }
        field(11; "Student Type"; Option)
        {
            OptionCaption = ' ,Part Time,Full Time';
            OptionMembers = " ","Part Time","Full Time";
        }
        field(12; "Recovery Priority"; Integer)
        {
        }
        field(13; "Distribution (%)"; Decimal)
        {
        }
        field(14; "Distribution Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
    }

    keys
    {
        key(Key1; "Programme Code", "Code")
        {
        }
        key(Key2; "Programme Code", "Recovery Priority")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Charges: Record "ACA-Charge";
}

