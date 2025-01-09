table 40022 "Supp Exam Registration Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Application No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Application No.';
        }

        field(2; "Student Full Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Student Full Name';
        }

        field(3; "Student Admission No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Student Admission No.';
        }

        field(4; "Program"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Program';
        }
        field(5; "Status"; Option)
        {
            OptionMembers = open,"Pending Approval",Approved,Rejected;
        }
        field(6; "No. Series"; code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Application No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        GeneralSetup: Record "ACA-General Set-Up";
        NoSerMng: Codeunit NoSeriesManagement;
    begin

        IF "Application No." = '' THEN BEGIN
            GeneralSetup.Get();
            GeneralSetup.TESTFIELD(GeneralSetup."Supplimentary No.");
            NoSerMng.InitSeries(GeneralSetup."Supplimentary No.", xRec."No. Series", 0D, "Application No.", "No. Series");
        END;
    end;
}

