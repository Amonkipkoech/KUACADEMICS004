table 62200 "ACA-Raw KUCCPS Imports"
{

    fields
    {
        field(1; Counts; Integer)
        {
            AutoIncrement = true;
            NotBlank = false;
        }
        field(2; Applicant; Text[250])
        {
        }
        field(3; "A.id"; Code[100])
        {
        }
        field(4; "Fee Type"; Code[20])
        {
        }
        field(5; Email; Text[250])
        {
        }
        field(6; Cell; Code[40])
        {
        }
        field(7; "P.id"; Code[10])
        {
        }
        field(8; "Kuccps.id"; Code[20])
        {
        }
        field(9; Stream; Code[20])
        {
        }
        field(10; Faculty; Code[20])
        {
        }
        field(11; Intake; Code[20])
        {
        }
        field(12; "Academic Year"; Code[20])
        {
        }
        field(13; "Admision No."; Code[20])
        {
        }
        field(14; "Serial No."; Code[20])
        {
        }
        field(15; Posted; Boolean)
        {
        }
        field(16; "Failure Reason"; Text[250])
        {
        }
        field(17; Gender; Option)
        {
            Description = 'Stores the gender of the record in the database';
            OptionMembers = " ",Male,Female;
        }
        field(18; "Reporting Date"; Date)
        {
        }
        field(19; Exists; Boolean)
        {
            //FieldClass = FlowField;
            // CalcFormula = Exist("ACA-Applic Form PostGraduate" WHERE(Field8 = FIELD(A.id),Field17=FIELD("Admision No.")));

        }
    }

    keys
    {
        key(Key1; Counts)
        {
        }
    }

    fieldgroups
    {
    }
}

