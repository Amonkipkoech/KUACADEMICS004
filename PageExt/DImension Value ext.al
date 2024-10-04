pageextension 50001 "Dimensioin Value Ext" extends "Dimension Values"
{
    layout
    {
        addbefore("Dimension Value Type")
        {
            field("Dean Staff ID";Rec."Dean Staff ID")
            {
                ApplicationArea = All;
                
            }
            field("HOD staff Id";Rec."HOD staff Id")
            {
                ToolTip = 'Specifies Dean Staff ID';
                ApplicationArea = All;
            }
            field(Faculty;Rec.Faculty)
            {
                ApplicationArea = All;
            }
            field("Department  Category"; Rec."Department  Category")
            {
                ToolTip = 'Specifies Department Category';
                ApplicationArea = All;
            }
            field(Location; Rec.Location)
            {
                ToolTip = 'Specifies the value of the Campus Location field.';
                ApplicationArea = All;
            }
            field("Global Dimension No."; Rec."Global Dimension No.")
            {
                ToolTip = 'Specifies the value of the Global Dimension No. field.';
                ApplicationArea = All;
            }



        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}