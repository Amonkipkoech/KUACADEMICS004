table 61345 "ACA-Futher Info Setup"
{
    // LookupPageID = 68000;

    fields
    {
        field(1; "Further Info Code"; Code[20])
        {
            Description = 'Stores the unique reference code of the further information in the database';
        }
        field(2; "Further Info Name"; Text[50])
        {
            Description = 'Stores the description of the further information in the database';
        }
        field(3; "No. Series"; Code[20])
        {
            Description = 'Stores the last no series';
            TableRelation = "No. Series".Code;
        }
    }

    keys
    {
        key(Key1; "Further Info Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "Further Info Code" = '' THEN BEGIN
            GLSetup.GET;
            GLSetup.TESTFIELD("Further Info Nos");
            // NoSeriesMgt.InitSeries(GLSetup."Further Info Nos", xRec."No. Series", 0D, "Further Info Code", "No. Series");
        END;
    end;

    var
        GLSetup: Record 61534;
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

