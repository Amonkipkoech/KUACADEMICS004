page 86622 "Graduation Clearance List"
{
    PageType = List;
    CardPageId = "Graduation Clearance Card";
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Graduation Clearance";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(studNo; Rec.studNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the studNo field.';
                }
                field(studentNames; Rec.studentNames)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the studentNames field.';
                }
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Programme field.';
                }
                field(semester; Rec.semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the semester field.';
                }
                field(academicYear; Rec.academicYear)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the academicYear field.';
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