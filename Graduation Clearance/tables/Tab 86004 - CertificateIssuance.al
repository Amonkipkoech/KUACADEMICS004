table 86004 "Certificate Issuance"
{
    Caption = 'Certificate Issuance';
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
            TableRelation = "Student Clerance"."Student No";
            trigger OnValidate()
            begin
                awardList.Reset();
                awardList.SetRange("Student No", Rec."Student No.");
                if awardList.Find('-') then begin
                    "Student Name" := awardList."Student Name ";
                    School := awardList.school;
                    Department := awardList."Department Code";
                end;
                cust.Reset();
                cust.SetRange("No.", "Student No.");
                if cust.Find('-') then begin
                    if cust."E-Mail" <> '' then begin
                        "Student Email" := cust."E-Mail"
                    end else
                        Error('Student Email does not have a value, Please enter Mannually!');
                end;
                gownIssue.Reset();
                gownIssue.SetRange("Student No.", "Student No.");
                gownIssue.SetRange(Returned, true);
                if not gownIssue.Find('-') then begin
                    Error('Student Must have Returned Gown First');
                end;

            end;
        }
        field(3; "Student Name"; Text[200])
        {
            Caption = 'Student Name';

        }
        field(4; Department; Code[20])
        {
            Caption = 'Department';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DEPARTMENT'));
        }
        field(5; School; Code[20])
        {
            Caption = 'School';
        }
        field(6; "Certificate No"; Code[20])
        {
            Caption = 'Certificate No';
        }
        field(7; "Certificate Issued Date"; DateTime)
        {
            Caption = 'Certificate Issued Date';
        }
        field(8; "Certficate issued By"; Code[20])
        {
            Caption = 'Certficate issued By';
        }
        field(9; Issued; Boolean)
        {
            Caption = 'Issued';
        }
        field(10; "Date Issued"; Date)
        {

        }
        field(11; "Student Email"; text[50])
        {

        }
    }
    keys
    {
        key(PK; "No.")
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
            NoSeriesMgnt.InitSeries(genSetUp."Clearance Nos", genSetUp."Clearance Nos", Today, "No.", genSetUp."Clearance Nos");
            "Date Issued" := Today;
            //UserId := UserId;
        end;
    end;

    var
        awardList: Record "Student Clerance";
        gownIssue: Record "Gown Issuance Register";
        cust: Record Customer;
}
