page 86610 "suppExam"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = suppExams;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(entryNo; Rec.entryNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the regno field.';
                }
                field(regno; Rec.regno)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the regno field.';
                }
                field(campus; Rec.campus)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the campus field.';
                }
                field(unitCode; Rec.unitCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the unitCode field.';
                }
                field(examtype; Rec.examtype)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the examtype field.';
                }
                field("Stage FiLTER"; Rec."Stage FiLTER")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the stage filter field.';

                }
                field(programCode; Rec.programCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the program filter field.';
                }
                field(regID; Rec.regID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the program filter field.';
                }
                field(unitDesc; Rec.unitDesc)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the program filter field.';
                }
                // field("Stage FiLTER"; Rec."Stage FiLTER")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the stage field.';
                // }
                // field(programCode; Rec.programCode)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the examtype field.';
                // }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}