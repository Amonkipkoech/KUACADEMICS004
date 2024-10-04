table 61843 "ACA-Deferrals"
{
    LookupPageId = "ACA-Deferrals";
    DrillDownPageId = "ACA-Deferrals";
    fields
    {
        field(1; "No."; Code[30])
        {


        }
        field(2; "Student No"; Code[30])
        {

        }
        field(3; "Academic Year"; code[30])
        {
        }
        field(4; "Semester"; code[30])
        {

        }
        field(5; "No of Deferral Years"; Integer)
        {

        }
        field(6; "Deferral Reason"; Text[250])
        {

        }
        field(7; "Status"; Option)
        {
            OptionMembers = Pending,"Pending Approval",Approved;
        }
        field(8; "Posted"; Boolean)
        {

        }
        field(30; "No. Series"; Code[30])
        {


        }


    }

    keys
    {
        key(key1; "No.", "Student No")
        {

        }
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            gensetup.Get();
            NoSeriesMgt.InitSeries(gensetup."Deferral Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

    end;

    var
        gensetup: Record "ACA-General Set-Up";
        NoSeriesMgt: Codeunit NoSeriesManagement;

}