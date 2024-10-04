page 40006 "Full Rotation Schedule"
{

    Caption = 'Full Rotation Schedule';
    PageType = List;
    SourceTable = "Rotation Group";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Group ID"; Rec."Group ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Group ID field.';
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student No. field.';
                }
                field("Lab ID"; Rec."Lab ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lab ID field.';
                }
                field("Week"; Rec."Week")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Week field.';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year field.';
                }
                field("Semester"; Rec."Semester")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester field.';
                }
            }
        }
    }
}
