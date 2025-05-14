page 40059 "Consolidated Ward MRP"
{
    Caption = 'Consolidated Ward MRP';
    PageType = List;
    SourceTable = "Ward Rotation Management";
    CardPageId = "Hospital Ward Rotation";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Session; rec.Session)
                {
                    ApplicationArea = All;
                }


                field(Year; rec.Year)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

