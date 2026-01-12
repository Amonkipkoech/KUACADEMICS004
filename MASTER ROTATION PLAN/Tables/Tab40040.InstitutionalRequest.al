table 40040 "Institutional Request"
{
    Caption = 'Institutional Request ';
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "Request Number"; Code[20])
        {
            Caption = 'Request Number';
        }

        field(2; "Institution Code"; Code[20])
        {
            Caption = 'Institution Code';
            TableRelation = "Institute Master"."Institute Code";
            trigger OnValidate()
            var
                Inst: Record "Institute Master";
            begin


                if Inst.Get("Institution Code") then begin
                    "Institution Name" := Inst."Institute Name";
                    "Contact Email" := Inst."Contact Email";
                    "Phone Number" := Inst."Phone Number";
                end;
            end;
        }

        field(3; "Institution Name"; Text[100]) { }
        field(4; "Contact Email"; Text[100]) { }
        field(5; "Phone Number"; Text[30]) { }

        field(6; Semester; Text[30])
        {
            TableRelation = "ACA-Semesters".Code;
        }
        field(7; "Academic Year"; Text[20])
        {
            TableRelation = "ACA-Study Years";
        }

        field(8; Status; Option)
        {
            OptionMembers = Open,"Pending Approval",Rejected,Approved,"Pending Finance Approval","Finance Approved","Pending HOI Approval","HOI Approved";
        }
        field(70001; "Finance Approver ID"; Code[50]) { Caption = 'Finance Approver ID'; }
        field(70002; "Finance Approver Name"; Text[100]) { Caption = 'Finance Approver Name'; }
        field(70003; "Finance Approver Email"; Text[100]) { Caption = 'Finance Approver Email'; }

        field(70004; "HOI Approver ID"; Code[50]) { Caption = 'HOI Approver ID'; }
        field(70005; "HOI Approver Name"; Text[100]) { Caption = 'HOI Approver Name'; }
        field(70006; "HOI Approver Email"; Text[100]) { Caption = 'HOI Approver Email'; }
        field(70010; "Admin Comment"; Text[250]) { Caption = 'Admin Comment'; }
        field(70011; "Director Comment"; Text[250]) { Caption = 'Director Comment'; }
        field(70012; "HOD Comment"; Text[250]) { Caption = 'HOD Comment'; }

        field(70020; "Assigned Admin ID"; Code[50]) { }
        field(70021; "Assigned Director ID"; Code[50]) { }
        field(70022; "Assigned HOD ID"; Code[50]) { }
        field(70023; "Assigned Finance ID"; Code[50]) { }
        field(70024; "Assigned Admissions ID"; Code[50]) { }

        field(70025; "Approval Status"; Option)
        {
            OptionMembers = Open,"Pending Director Approval","Pending HOD Feedback","Director Review (Post-HOD)","Pending External Confirmation","Pending Finance","Pending Admissions",Completed,Rejected;
        }
        field(70013; "Finance Comment"; Text[250]) { Caption = 'Finance Comment'; }
        field(70014; "Admissions Comment"; Text[250]) { Caption = 'Admissions Comment'; }

    }

    keys
    {
        key(PK; "Request Number") { Clustered = true; }
    }



}
