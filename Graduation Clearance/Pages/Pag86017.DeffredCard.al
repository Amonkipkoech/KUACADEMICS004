page 86017 "Deffered Students Card"

{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = defferedStudents;

    layout
    {
        area(Content)
        {
            group("Student Details")
            {
                Caption = 'Section One';
                field("Request No"; "Request No")
                {
                    ApplicationArea = All;
                }
                field(studentNo; Rec.studentNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the studentNo field.';
                }
                field(studentName; Rec.studentName)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the studentName field.';
                }
                field(Semster; Rec.Semeter)
                {
                    ApplicationArea = All;
                }
                field("Request Type"; Rec."Request Type")
                {
                    ApplicationArea = All;
                }
                field(stage; Rec.stage)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the stage field.';
                }
                field(programme; Rec.programme)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the programme field.';
                }
                field(Department; Rec.Department)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("School Code"; Rec."School Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("E-mail"; Rec."E-mail")
                {
                    Editable = false;
                    ApplicationArea = All;
                }


            }
            group("Deferment/Discontinuation")
            {
                field("Reason for Calling off"; Rec."Reason for Calling off")
                {
                    ApplicationArea = All;

                }
                field(deffermentReason; Rec.deffermentReason)
                {
                    Caption = 'If Other please specify';
                    ApplicationArea = All;
                }
                field("Deferment  Starting Date"; rec."Deferment  Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Deferment  End Date"; rec."Deferment  End Date")
                {
                    ApplicationArea = All;
                }
            }
            group("Recommendation By The Relevant COD")
            {

                Caption = 'Head Of Department';
                field("Recommendation COD"; Rec."Recommendation COD")
                {
                    ApplicationArea = All;
                }
                field("Hod Date"; rec."Hod Date")
                {
                    ApplicationArea = All;
                }
                field("Hod cleared"; rec."Hod cleared")
                {
                    ApplicationArea = All;
                }

            }
            group("Head Of Institute'")
            {

                Caption = 'Head Of Institute';

                field("Hoi Approval Date"; rec."Hoi Date")
                {
                    Caption = 'Hoi Approval Date';
                    ApplicationArea = All;
                }
                field("HoI Cleared"; rec."HoI Cleared")
                {
                    Caption = 'Hoi Cleared';
                    ApplicationArea = All;
                }

            }
            group("Head Of Clinical Rotation")
            {

                Caption = 'Head Of Clinical Rotation';

                field("HcR Approval Date"; rec."Head Of Clinical Rotation")
                {
                    ApplicationArea = All;
                }
                field("HcR Cleared"; rec."HCR Cleared")
                {
                    ApplicationArea = All;
                }

            }
            group("Head Of Library")
            {

                Caption = 'Head Of Library';

                field("Hol Approval Date"; rec.HoL)
                {
                    ApplicationArea = All;
                }
                field("HoL cleared"; "HoL cleared")
                {
                    ApplicationArea = All;
                }

            }
            group("Head Of Finance")
            {

                Caption = 'Head Of Finance';

                field("HoF Approval Date"; rec."HoF Approval Date")
                {
                    ApplicationArea = All;
                }
                field("HoF cleared"; rec."HoF cleared")
                {
                    ApplicationArea = All;
                }

            }
            group("Recommendation By The Relevant Dean")
            {
                Caption = ' Directorate of Training, Research and Innovation';
                field("Recommendation Dean"; Rec."Recommendation Dean")
                {
                    Caption = 'Director TRI Comment';
                    ApplicationArea = All;
                }
                field("DTRI Ratification Date"; rec."DTRI Ratification Date")
                {
                    Caption = 'Director Approval Date';
                    ApplicationArea = All;
                }
            }
        }
    }


    actions
    {
        area(Processing)
        {
            action(Approve)
            {
                ApplicationArea = All;
                Visible = rec.status = rec.status::Pending;

                trigger OnAction();
                begin
                    if Rec.Get() then
                        if Confirm('Do you want to Accept the Application?', true) = false then exit;
                    Rec.status := Rec.status::Approved;
                    Rec.Modify();
                end;
            }
            action(Reject)
            {
                ApplicationArea = All;
                Visible = rec.status = rec.status::Pending;

                trigger OnAction();
                begin
                    if Rec.Get() then
                        if Confirm('Do you want to Reject the Application?', true) = false then exit;
                    Rec.status := Rec.status::Cancelled;
                    Rec.Modify();
                end;
            }
            action("Re-admission")
            {
                ApplicationArea = All;
                Visible = rec.status = rec.status::Approved;

                trigger OnAction();
                begin
                    if Rec.Get() then
                        if Confirm('Do you want to be re-admitted ?', true) = false then exit;
                    Rec.status := Rec.status::ReAdmission;
                    Rec.Modify();
                end;
            }
            action("Reject Admission")
            {
                ApplicationArea = All;
                Visible = rec.status = rec.status::ReAdmission;

                trigger OnAction();
                begin
                    if Rec.Get() then
                        if Confirm('Do you want to be re-admitted ?', true) = false then exit;
                    Rec.status := Rec.status::Rejected;
                    Rec.Modify();
                end;
            }
            action("Admit")
            {
                ApplicationArea = All;
                Visible = rec.status = rec.status::ReAdmission;

                trigger OnAction();
                begin
                    if Rec.Get() then
                        if Confirm('Do you want to be re-admitted ?', true) = false then exit;
                    Rec.status := Rec.status::readmitted;
                    Rec.Modify();
                end;
            }
        }
    }

}
