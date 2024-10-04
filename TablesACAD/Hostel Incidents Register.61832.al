table 61832 "Hostel Incidents Register"
{

    fields
    {
        field(1; "Incident No."; Code[20])
        {

            trigger OnValidate()
            begin
                "Incident Date" := TODAY;
                "Incident Time" := TIME;
                "Report By" := USERID;
                //IF TIME IN[0659..1900] THEN BEGIN
                //  "Day/Night":="Day/Night"::Day;
                //END ELSE IF TIME IN[1859..0700] THEN BEGIN
                //"Day/Night":="Day/Night"::Night;
                //END;
            end;
        }
        field(2; "Hostel Block No."; Code[20])
        {
        }
        field(3; "Incident Date"; Date)
        {
        }
        field(4; "Incident Time"; Time)
        {
        }
        field(5; "Day/Night"; Option)
        {
            OptionMembers = " ",Day,Night;
        }
        field(6; "Report By"; Code[100])
        {
        }
        field(7; "Report Summary"; Text[100])
        {
        }
        field(8; "Report Details"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Incident No.", "Hostel Block No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        AppSetup.GET;
        AppSetup.TESTFIELD(AppSetup."Hostel Incidents");
        "Incident No." := NoSeriesMgt.GetNextNo(AppSetup."Hostel Incidents", TODAY, TRUE);
        VALIDATE("Incident No.");
        //InitSeries(AppSetup."Application Form Nos.",xRec."No. Series",0D,"Application No.","No. Series");
    end;

    var
        AppSetup: Record 61534;
        NoSeriesMgt: Codeunit 396;
}

