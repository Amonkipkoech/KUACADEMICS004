page 40072 "Student Rota Lines"
{
    Caption = 'All Student Rota Lines';
    PageType = List;
    Editable = false;
    SourceTable = "Student Rota Line";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Header ID"; Rec."Header ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Header ID field.', Comment = '%';
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student Name field.', Comment = '%';
                }
                field(Institution; Rec.Institution)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Institution field.', Comment = '%';
                }
                field("Program"; Rec."Program")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Program field.', Comment = '%';
                }
                field(Ward; Rec.Ward)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Ward field.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Shift Code"; Rec."Shift Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shift Code field.', Comment = '%';
                }
                field(Viewable; Rec.Viewable)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Viewable field.', Comment = '%';
                }
            }
        }
    }
}
