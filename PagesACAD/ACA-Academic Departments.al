page 70205 "ACA-Academics departments"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "ACA-Academic Departments";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                
                field("Department Code"; Rec."Department Code")
                {
                    ToolTip = 'Specifies the value of the Department Code field.';
                    ApplicationArea = All;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ToolTip = 'Specifies the value of the Department Name field.';
                    ApplicationArea = All;
                }
                field("Faculty Code"; Rec."Faculty Code")
                {
                    ToolTip = 'Specifies the value of the Faculty Code field.';
                    ApplicationArea = All;
                }
                field("HOD Staff ID"; Rec."HOD Staff ID")
                {
                    ToolTip = 'Specifies the value of the HOD Staff ID field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
           
        }
    }

    var
        myInt: Integer;
}