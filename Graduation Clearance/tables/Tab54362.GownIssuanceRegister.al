table 86002 "Gown Issuance Register"
{
    Caption = 'Gown Issuance Register';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            TableRelation = "Student Clerance"."Student No" where(Status = filter('Pending'));
            trigger OnValidate()
            begin
                awardList.Reset();
                awardList.SetRange("Student No", Rec."Student No.");
                if awardList.Find('-') then begin
                    "Student Name" := awardList."Student Name ";
                    School := awardList.school;
                    Department := awardList."Department Code";
                end;
            end;
        }
        field(3; "Student Name"; Text[200])
        {
            Caption = 'Student Name';
        }
        field(4; School; Code[20])
        {
            Caption = 'School';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('FACULTY'));
        }
        field(5; Department; Code[20])
        {
            Caption = 'Department';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DEPARTMENT'));
        }
        field(6; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = "Gown Issued","Gown Returned","Returned Late";
        }
        field(7; "Date Issued"; Date)
        {

        }
        field(8; "Expected Return Date"; Date)
        {

        }
        field(10; "Actual Return Date"; Date)
        {

        }
        field(11; "Issued"; Boolean)
        {

        }
        field(12; "Returned"; Boolean)
        {

        }
        field(13; "Number of Gowns Left"; Integer)
        {
            CalcFormula = sum("Gown Issuance Ledger".Quantity);
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(PK; "No.", "Student No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        genSetUp: Record "ACA-General Set-Up";
        NoSeriesMgnt: Codeunit NoSeriesManagement;
    begin
        if "No." = '' then begin
            genSetUp.Get();
            genSetUp.TestField("Allow Posting To");
            NoSeriesMgnt.InitSeries(genSetUp."Class Allocation Nos.", genSetUp."Class Allocation Nos.", Today, "No.", genSetUp."Class Allocation Nos.");
            "Date Issued" := Today;
            //UserId := UserId;
        end;
    end;

    var
        awardList: Record "Student Clerance";
}
