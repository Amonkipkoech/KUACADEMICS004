table 61346 "ACA-Attachments Setup"
{
    //LookupPageID = 68001;

    fields
    {
        field(1; "Attachment Code"; Code[20])
        {
            Description = 'Stores the unique reference number of the attachment in the database';
        }
        field(2; "Attachment Name"; Text[50])
        {
            Description = 'Stores the name of the attachment in the database';
        }
        field(3; "No. Series"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Attachment Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "Attachment Code" = '' THEN BEGIN
            GLSetup.GET;
            GLSetup.TESTFIELD("Attachment Nos");
            //NoSeriesMgt.InitSeries(GLSetup."Attachment Nos", xRec."No. Series", 0D, "Attachment Code", "No. Series");
        END;
    end;

    var
        GLSetup: Record 61534;
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

