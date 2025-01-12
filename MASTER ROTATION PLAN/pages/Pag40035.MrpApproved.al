page 40035 "Mrp Approved "
{

    Caption = 'MRP List';
    PageType = List;



    SourceTable = "Master Rotation Plan2";
    SourceTableView = where(Status = filter(Approved));


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
                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

