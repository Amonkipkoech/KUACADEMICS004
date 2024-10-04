table 52018 "ptRates"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ProgrammeLevel; Option)
        {
            OptionMembers = " ","Proffesional Course",Certificate,Diploma,Bachelor,"Post-Graduate Diploma",Masters,PHD;

        }
        field(2; modeofStudy; code[20])
        {
            //TableRelation = "ACA-Settlement Type".ModeofStudy;
            TableRelation = "ACA-Student Types".Code;
        }
        field(3; designation; option)
        {
            OptionMembers = proffessor,others;
        }
        field(4; quorum; Decimal)
        {

        }
        field(5; Amount; Decimal)
        {

        }
    }

    keys
    {
        key(Key1; modeofStudy, ProgrammeLevel, designation)
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