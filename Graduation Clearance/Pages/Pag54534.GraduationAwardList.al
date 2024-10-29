page 86013 "Graduation Award List"
{
    Caption = 'Graduation Award List';
    PageType = List;
    SourceTable = "Graduation Award List";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Admission No"; Rec."Admission No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Admission No field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field(school; Rec.school)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the school field.', Comment = '%';
                }
                field("Grad Fee Invoiced"; Rec."Grad Fee Invoiced")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Grad Fee Invoiced field.', Comment = '%';
                }
                // field( Balance; Rec.Balance)
                // {
                //     ApplicationArea = All;
                // }
            }
        }
    }
}
