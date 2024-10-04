page 68736 "ACA-Semester Card"
{
    PageType = Card;
    SourceTable = 61692;
    //Editable = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(From; Rec.From)
                {
                    ApplicationArea = All;
                }
                field("To"; Rec."To")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }

                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Registration Deadline"; Rec."Registration Deadline")
                {
                    ApplicationArea = All;
                }
                field("Unit Registration Deadline"; Rec."Unit Registration Deadline")
                {
                    ApplicationArea = All;
                }
                field("Mark entry Dealine"; Rec."Mark entry Dealine")
                {
                    ApplicationArea = All;
                }
                field("Current Semester"; Rec."Current Semester")
                {
                    ApplicationArea = All;
                }
                field("SMS Results Semester"; Rec."SMS Results Semester")
                {
                    ApplicationArea = All;
                }
                field("Lock Exam Editting"; Rec."Lock Exam Editting")
                {
                    ApplicationArea = All;
                }
                field("Lock CAT Editting"; Rec."Lock CAT Editting")
                {
                    ApplicationArea = All;
                }
                field("Lock Lecturer Editing"; Rec."Lock Lecturer Editing")
                {
                    ApplicationArea = All;
                }

                field("Released Results"; Rec."Released Results")
                {
                    ApplicationArea = All;
                    Caption = 'Release Exam Results';
                }
                field("Release CAT Marks"; Rec."Release CAT Marks")
                {
                    ApplicationArea = All;
                }
                field("Marks Changeable"; Rec."Marks Changeable")
                {
                    ApplicationArea = All;
                }
                field("DownLoad Exam Card"; Rec."DownLoad Exam Card")
                {
                    ApplicationArea = All;
                }
                field("Apply For Supp"; Rec."Apply For Supp")
                {
                    Caption = 'Apply For Supp Deadline';
                    ApplicationArea = All;
                }
                field("Evaluate Lecture";Rec."Evaluate Lecture")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
    }
    trigger OnOpenPage()
    var
        usersetup: Record "User Setup";
        Nopermission: Label 'You are not allowed to do Semester Settings';
        AllowAccessSettings: boolean;
    begin
        AllowAccessSettings := true;
        if usersetup.get(UserId) then
            if (usersetup."Can Edit Semester") then begin
                AllowAccessSettings := usersetup."Can Edit Semester";
                exit
            end;
        Error(Nopermission);
    end;



}

