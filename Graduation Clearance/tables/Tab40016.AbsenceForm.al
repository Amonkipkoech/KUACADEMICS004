table 40016 "Student Absence Request"
{

    DataClassification = ToBeClassified;
    Caption = 'Student Absence Request';

    fields
    {
        field(1; "Request No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Request No.';
        }
        field(2; "Student Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Name of Student (Full)';
        }
        field(3; "Admission Number"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Admission Number';
            TableRelation = Customer."No.";
            trigger OnValidate()
            var
                CMS: Record Customer;
            begin
                "Student Name" := CMS.Name;
                "Program Admitted" := CMS."Current Programme";


            end;
        }

        field(4; "Program Admitted"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Program Admitted To';
        }
        // field(5; "Year of Study"; Integer)
        // {
        //     DataClassification = ToBeClassified;
        //     Caption = 'Year of Study';
        // }
        field(6; "Date From"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date From';
        }
        field(7; "Date To"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date To';
        }
        field(8; "Session(s) Missed"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Session(s) to be Missed';
        }
        field(9; "Total Hours Missed"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Number of Hours';
        }
        field(10; "Reason for Absence"; Option)
        {
            OptionMembers = "Medical Reasons","Work Related","Family Emergency","Personal","Others";
            DataClassification = ToBeClassified;
            Caption = 'Reason for Absence';
        }
        field(11; "Other Reason (Specify)"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Other Reason (Specify)';
        }
        field(12; "Student Signature Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date of Application';
        }
        field(13; "HOD Objection"; Option)
        {
            OptionMembers = "I Object","I Do Not Object";
            DataClassification = ToBeClassified;
            Caption = 'HOD Objection';
        }
        field(14; "HOD Reason"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'HOD Reason (If Objected)';
        }
        field(15; "HOD Signature Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'HOD Signature Date';
        }
        field(16; "Institute Approval"; Option)
        {
            OptionMembers = "Approved","Not Approved";
            DataClassification = ToBeClassified;
            Caption = 'Institute Approval';
        }
        field(17; "Institute Reason"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Institute Reason (If Not Approved)';
        }
        field(18; "Institute Signature Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Institute Signature Date';
        }
        field(19; "No. Series"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Request No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        GeneralSetup: Record "ACA-General Set-Up";
        NoSerMng: Codeunit NoSeriesManagement;
    begin

        IF "Request No." = '' THEN BEGIN
            GeneralSetup.Get();
            GeneralSetup.TESTFIELD(GeneralSetup."Clinical request");
            NoSerMng.InitSeries(GeneralSetup."Clinical request", xRec."No. Series", 0D, "Request No.", "No. Series");
        END;
    end;
}
