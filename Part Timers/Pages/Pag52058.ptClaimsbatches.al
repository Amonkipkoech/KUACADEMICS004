page 52059 "PT Claim batches"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Part Time Card";
    SourceTable = partTimeHead;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(semester; Rec.semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the semester field.';
                }
                field(createdBy; Rec.createdBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the createdBy field.';
                }
                field(dateCreated; Rec.dateCreated)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the dateCreated field.';
                }

                field(academicYr; Rec.academicYr)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the academicYr field.';
                }

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

                trigger OnAction();
                begin

                end;
            }
        }
    }
}