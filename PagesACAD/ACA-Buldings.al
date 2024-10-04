page 85527 "ACA-Buildings Setup"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "ACA-Buidings Setups";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Building Code"; Rec."Building Code")
                {
                    ApplicationArea = All;
                }
                field("Building Name";Rec."Building Name")
                {
                    ApplicationArea = All;
                }
                field("Campus Code";Rec."Campus Code")
                {
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