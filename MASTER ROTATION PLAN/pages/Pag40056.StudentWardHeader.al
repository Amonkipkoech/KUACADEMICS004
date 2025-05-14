page 40056 "Student Ward Header"
{
    Caption = 'Student Ward Performance';
    PageType = Card;
    SourceTable = GroupAssignments;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'MRP General Information';

                field(GroupId; Rec.GroupId)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the GroupId field.', Comment = '%';
                }
                field(StudentNo; Rec.StudentNo)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the StudentNo_ field.', Comment = '%';
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Department field.', Comment = '%';
                }
                field(MasterRotationNo; Rec.MasterRotationNo)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Master Rotation Number field.', Comment = '%';
                }
                field(LecturerName; Rec.LecturerName)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Lecturer Name field.', Comment = '%';
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Category field.', Comment = '%';
                }
            }
            group("Student Ward Rotation")
            {
                part(WardRotation; "Student Ward ListPart")
                {
                    SubPageLink = GroupId = FIELD(GroupId), StudentNo = FIELD(StudentNo);
                    ApplicationArea = All;
                }
            }
        }
    }
}
