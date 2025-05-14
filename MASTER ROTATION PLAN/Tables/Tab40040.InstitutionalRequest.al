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
            OptionMembers = Open,"Pending Approval",Rejected,Approved;
        }
    }

    keys
    {
        key(PK; "Request Number") { Clustered = true; }
    }



}
