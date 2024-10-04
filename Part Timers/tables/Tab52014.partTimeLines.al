table 52015 "ptClaimLines"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; lecNo; code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; lecName; text[200])
        {

        }
        field(3; unitBaseCode; code[20])
        {

        }
        field(4; associateUnit; code[20])
        {

        }
        field(5; vcampus; code[20])
        {

        }
        field(6; modeofStudy; code[20])
        {

        }
        field(7; stream; code[20])
        {

        }
        field(8; studentsNum; Decimal)
        {

        }
        field(9; wlType; code[20])
        {

        }
        field(10; Level; Text[100])
        {
            //OptionMembers = " ","Proffesional Course",Certificate,Diploma,Bachelor,"Post-Graduate Diploma",Masters,PHD;
        }
        field(11; amount; Decimal)
        {

        }
        field(12; firstInstallment; Decimal)
        {

        }
        field(14; secondInstallment; Decimal)
        {

        }
        field(15; thirdInstallment; Decimal)
        {

        }
        field(16; grandTotal; Decimal)
        {

        }
        field(17; academicYr; code[20])
        {

        }
        field(18; semester; code[20])
        {

        }
        field(19; unitsCount; Decimal)
        {

        }
        field(20; entry; Integer)
        {

        }
        field(21; Day; code[20])
        {

        }
        field(22; TimeSlot; Code[20])
        {

        }

    }

    keys
    {
        key(Key1; lecNo, unitBaseCode, associateUnit, modeofStudy, stream, entry, Day, TimeSlot)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}