page 40058 "Student Ward Performance"
{
    Caption = 'Student Ward Rotations';
    PageType = List;
    CardPageId = "Student Ward Header";
    SourceTable = GroupAssignments;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(StudentNo; Rec.StudentNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the StudentNo_ field.', Comment = '%';
                }
                field("Student Name"; "Student Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Block field.', Comment = '%';
                }
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


                field(Category; rec.Category)
                {
                    ApplicationArea = all;
                }

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
