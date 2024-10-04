page 50063 "Evaluation Results"
{
    PageType = List;
    ApplicationArea = All;
    Editable = false;
    UsageCategory = Lists;
    SourceTable = "ACA-Lecturers Evaluation";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester field.';
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stage field.';
                }
                field("Lecturer No"; Rec."Lecturer No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lecturer No field.';
                }
                field(Unit; Rec.Unit)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit field.';
                }
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Programme field.';
                }
                field(ModeofStudy; Rec.ModeofStudy)
                {
                    ApplicationArea = All;
                    Caption = 'Settlement';

                }
                field("Question No"; Rec."Question No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Question No field.';
                }
                field(Choices; Rec.Choices)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Choices field.';
                }
                field(Response; Rec.Response)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Response field.';
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category field.';
                }
                field("Date Time"; Rec."Date Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Time field.';
                }
                field(Campus; Rec.Campus)
                {
                    ApplicationArea = All;

                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Code field.';
                }


            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}