table 61347 "ACA-Medical Condition Setup"
{
    //LookupPageID = 68810;

    fields
    {
        field(1; "Medical Condition Code"; Code[20])
        {
            Description = 'Stores the unique medical code in the database';
        }
        field(2; "Medical Condition Name"; Text[100])
        {
            Description = 'Stores the name of the medical condition in the database';
        }
        field(3; "No. Series"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Medical Condition Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "Medical Condition Code" = '' THEN BEGIN
            GLSetup.GET;
            GLSetup.TESTFIELD("Medical Condition Nos");
            //NoSeriesMgt.InitSeries(GLSetup."Medical Condition Nos", xRec."No. Series", 0D, "Medical Condition Code", "No. Series");
        END;
    end;

    var
        GLSetup: Record 61534;
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

