page 40021 "XY form Card"
{
    Caption = 'XY form Card';
    PageType = Card;
    SourceTable = "ACA-XY-FORM";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Form Id"; Rec."Form Id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Form Id field.', Comment = '%';
                }
                field(StudentNo; Rec.StudentNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the StudentNo field.', Comment = '%';
                }
                field(UnitCode; Rec.UnitCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the UnitCode field.', Comment = '%';
                }
                field("Group Name"; rec."Group Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the UnitCode field.', Comment = '%';
                }

                field("Unit Description"; Rec."Unit Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Description field.', Comment = '%';
                }
                field(LecturerNo; Rec.LecturerNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the LecturerNo field.', Comment = '%';
                }
                field("Lecturer Name"; Rec."Lecturer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lecturer Name field.', Comment = '%';
                }


                field(HoD; Rec.HoD)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HoD field.', Comment = '%';
                }
                field("Hod Name"; Rec."Hod Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Hod Name field.', Comment = '%';
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student Name field.', Comment = '%';
                }

                field(AcademicYr; Rec.AcademicYr)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic year field.', Comment = '%';
                }

                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Programme field.', Comment = '%';
                }
            }
            group("Content Coverage@")
            {
                Caption = 'Content Coverage';
                part("Content Coverage"; xylist)
                {
                    ApplicationArea = All;
                    SubPageLink = "Form Id" = field("Form Id");
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Approved)
            {
                Visible = rec.Status = rec.Status::Pending;
                trigger OnAction()
                begin
                    rec.Status := rec.Status::Approved;
                end;
            }
            action(Reject)
            {

                trigger OnAction()
                begin
                    rec.Status := rec.Status::Rejected;
                end;
            }
        }
    }
}
