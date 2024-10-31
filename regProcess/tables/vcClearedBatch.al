table 86641 "VC cleared Batches"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Semester; code[20])
        {
            TableRelation = "ACA-Semesters";
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Created By" := UserId;
                "Created Time" := Time;
                "Created Date" := Today;
            end;

        }
        field(2; "Academic Year"; code[20])
        {
            TableRelation = "ACA-Academic Year";
        }
        field(3; "Created Time"; time)
        {

        }
        field(4; "Created By"; Code[20])
        {

        }
        field(5; "Created Date"; Date)
        {

        }
        field(6; "Clearance Batch"; Code[30])
        {
        }
        field(7; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; Semester, "Created By", "Clearance Batch")
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
    var
        GeneralSetup: Record "ACA-General Set-Up";
        NoSerMng: Codeunit NoSeriesManagement;
    begin

        IF "Clearance Batch" = '' THEN BEGIN
            GeneralSetup.Get();

            GeneralSetup.TESTFIELD(GeneralSetup."Fee Exempt Nos");
            NoSerMng.InitSeries(GeneralSetup."Fee Exempt Nos", xRec."No. Series", 0D, "Clearance Batch", "No. Series");
        END;
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