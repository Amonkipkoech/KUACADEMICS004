page 40052 "Consolidated Exam list"
{
    Caption = 'Consolidated Exam list';
    PageType = List;
    CardPageId = "Consolidated Exam card";
    SourceTable = "Consolidated Exam TimeTable";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year field.', Comment = '%';
                }
                field("Session Year"; Rec."Session Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Session field.', Comment = '%';
                }
                field("Department "; Rec."Department ")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department field.', Comment = '%';
                }
                field(Campus; Rec.Campus)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Campus field.', Comment = '%';
                }
            }
        }
    }
}
