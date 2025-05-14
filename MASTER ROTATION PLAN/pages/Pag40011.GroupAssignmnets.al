page 40011 "Group Assignmnets "
{
    Caption = 'Group Assignmnets';
    PageType = List;
    CardPageId = "Student Ward Header";
    SourceTable = GroupAssignments;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(GroupId; Rec.GroupId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GroupId field.', Comment = '%';
                }
                field(Block; Rec.Block)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Block field.', Comment = '%';
                }
                field(StudentNo; Rec.StudentNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the StudentNo_ field.', Comment = '%';
                }
                field(Category; rec.Category)
                {
                    ApplicationArea = all;
                }
                // field(StartDate; Rec.StartDate)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the StartDate field.', Comment = '%';
                // }
                // field(EndDate; Rec.EndDate)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the EndDate field.', Comment = '%';
                // }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department field.', Comment = '%';
                }
                field(MasterRotationNo; Rec.MasterRotationNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Master Rotation Number field.', Comment = '%';
                }
            }
        }
    }
}
