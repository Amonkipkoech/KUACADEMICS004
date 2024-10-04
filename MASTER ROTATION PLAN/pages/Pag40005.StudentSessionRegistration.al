page 40005 "Student Session Registration"
{
    Caption = 'Student Session Registration';
    PageType = List;
    SourceTable = "ACA-Course Registration";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Session; Rec."Reg. Transacton ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Session field.', Comment = '%';
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student No. field.', Comment = '%';
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student Name field.', Comment = '%';
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester field.', Comment = '%';
                }
                field(Programmes; Rec.Programmes)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Programmes field.', Comment = '%';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year field.', Comment = '%';
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cohort Stage field.', Comment = '%';
                }
                field(ProgramName; Rec.ProgramName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ProgramName field.', Comment = '%';
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gender field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(GenerateAllocations)
            {
                Caption = 'Generate Allocations';
                Image = New; // You can choose an appropriate image for the action
                ApplicationArea = All;
                trigger OnAction()
                var
                    RotationManagement: Codeunit "Rotation Management";
                begin
                    RotationManagement.GenerateRotationSchedule();
                    Message('Rotation schedule has been generated.');
                end;
            }
        }

    }

}
