page 40031 "MRP List"
{
    Caption = 'MRP List';
    PageType = List;



    SourceTable = "Master Rotation Plan2";

    CardPageId = "Master Rotation Plan Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Plan ID"; rec."Plan ID")
                {
                    ApplicationArea = All;
                }

                field("Program Code"; rec."Program Code")
                {
                    ApplicationArea = All;
                }

                field("Program Name"; rec."Program Name")
                {
                    ApplicationArea = All;
                }

                field(HOD; rec.HOD)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

