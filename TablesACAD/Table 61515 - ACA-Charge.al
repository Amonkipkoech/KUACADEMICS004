table 61515 "ACA-Charge"
{
    DrillDownPageID = 68741;
    LookupPageID = 68741;

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
        }
        field(3; Amount; Decimal)
        {
        }
        field(4; "Fixed Amount"; Boolean)
        {
        }
        field(5; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(6; Remarks; Text[150])
        {
        }
        field(7; "Total Income"; Decimal)
        {
            CalcFormula = Sum("ACA-Receipt Items".Amount WHERE(Code = FIELD(Code),
                                                                Date = FIELD("Date Filter")));
            Editable = false;
            Enabled = false;
            FieldClass = FlowField;
        }
        field(8; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(9; "Recover First"; Boolean)
        {
        }
        field(10; "Total Billing"; Decimal)
        {
            Editable = false;
        }
        field(11; "Reg. ID Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            //TableRelation = Table61703.Field10 WHERE(Field1 = FIELD("Student No. Filter"));
        }
        field(12; "Student No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = Customer."No.";
        }
        field(13; Show; Boolean)
        {
        }
        field(14; Currency; Code[20])
        {
            TableRelation = Currency.Code;
        }
        field(15; "Charged Rooms Count"; Integer)
        {
        }
        field(16; "Semester Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Semesters".Code;
        }
        field(17; "Issued Rooms"; Integer)
        {
        }
        field(18; "Vacant Rooms Count"; Integer)
        {
            CalcFormula = Count("ACA-Hostel Ledger" WHERE("Room Cost" = FIELD(Amount),
                                                           Status = CONST(Vaccant),
                                                           Gender = FIELD(Gender)));
            FieldClass = FlowField;
        }
        field(19; Gender; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(20; Hostel; Boolean)
        {
        }
        field(21; "Settlement Type"; code[30])
        {
            TableRelation = "ACA-Settlement Type"."Code";
        }
    }

    keys
    {
        key(Key1; "Code", "Settlement Type")
        {
        }
    }

    fieldgroups
    {
    }
}

