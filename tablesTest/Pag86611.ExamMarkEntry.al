page 86611 "Exam Mark Entry"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "ACA-Student Units";
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(rep001)
            {
                field("Reg. Transacton ID"; "Reg. Transacton ID")
                {
                    editable = false;
                    ApplicationArea = All;

                }
                field("Academic Year"; Rec."Academic Year")
                {
                    editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year field.';
                    Visible = False;
                }
                field("Academic Year (Flow)"; Rec."Academic Year (Flow)")
                {
                    ApplicationArea = All;
                    Caption = 'Academic Year';
                }
                field("Exam Category"; Rec."Exam Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Exam Category field.';
                }
                field("CATs Marks Exists"; Rec."CATs Marks Exists")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CATs Marks Exists field.';
                }
                field("EXAMs Marks Exists"; Rec."EXAMs Marks Exists")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the EXAMs Marks Exists field.';
                }


                field(Programme; Rec.Programme)
                {
                    editable = false;
                    ApplicationArea = All;
                }


                field(Unit; Rec.Unit)
                {
                    editable = false;
                    ApplicationArea = All;
                }
                // field(UnitsExist;Rec.UnitsExist)
                // {
                //     ApplicationArea = All;
                // }
                field("Unit Description"; Rec."Unit Description")
                {
                    editable = false;
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    editable = false;
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    editable = false;
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester field.';
                }

                field("Campus Code"; Rec."Campus Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Campus Code field.';
                }
                field("CATs Marks"; Rec."CATs Marks")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CATs Marks field.';
                }
                field("EXAMs Marks"; Rec."EXAMs Marks")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Final. Exam Marks"; Rec."Final. Exam Marks")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Final. Exam Marks field.';
                    Visible = false;
                }
                field("Total Score"; Rec."Total Score")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;

                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field(LecturerName; Rec.LecturerName)
                {
                    ApplicationArea = All;
                }


            }
        }
    }


    trigger OnOpenPage()
    var
        usersetup: Record "User Setup";
        Nopermission: Label 'You have insufficient Rights to access the Transcripts';
    begin
        AllowAccessSettings := true;
        if usersetup.get(UserId) then
            if (usersetup."Allow Open Transcript") then begin
                AllowAccessSettings := usersetup."Allow Open Transcript";
                exit
            end;
        Error(Nopermission);
    end;

    var
        AllowAccessSettings: boolean;
}