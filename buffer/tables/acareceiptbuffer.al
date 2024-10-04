table 84528 "Receipts Buffer"
{
    DrillDownPageId = "Receipt Buffer List";
    LookupPageId = "Receipt Buffer List";
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;

            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; "Document Date"; Date)
        {
            //Editable = false;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                genSetUp.Get();
                genSetUp.TestField("Receipt Buffer Nos");
                "No." := noseries.GetNextNo(genSetUp."Receipt Buffer Nos", TODAY, TRUE);
                "User Id" := UserId;
            end;
        }

        field(3; "No. of Students "; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Batch No."; Code[20])
        {
            NotBlank = true;
            DataClassification = ToBeClassified;
        }
        field(5; "Batch Date"; Date)
        {
            DataClassification = ToBeClassified;
        }


        field(6; "Academic Year"; Code[20])
        {
            TableRelation = "ACA-Academic Year".Code;
        }
        field(7; "Semester"; Code[20])
        {
            TableRelation = "ACA-Semesters".Code;
        }

        field(8; "Bank Code"; Code[20])
        {
            Caption = 'Allocating Bank Account';
            TableRelation = "Bank Account";
        }
        field(9; "G/L Account"; Code[20])
        {
            Caption = 'G/L Account';
            TableRelation = "G/L Account";
        }

        field(10; Posted; Boolean)
        {

        }
        field(11; "User Id"; code[20])
        {
            Editable = false;
        }
        field(12; "Transaction Type"; Option)
        {
           OptionMembers = " ","M-pesa",Cheque,"Direct Bank Deposit",HELB,Bursary,CDF,Scholarship;
        }
    }


    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    var
        genSetUp: Record "ACA-General Set-Up";
        noseries: Codeunit NoSeriesManagement;

}