page 40048 "ConsolidateD Teaching Tbl"
{
    Caption = 'ConsolidateD Teaching Tbl';
    PageType = List;
    SourceTable = "Consolidated Teaching Tble";
    CardPageId = "Consolidated  Deprt Teach Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Academic Year"; rec."Academic Year")
                {
                    ApplicationArea = all;
                }
                field("Session Year"; rec."Session Year")
                {
                    ApplicationArea = all;
                }

                field(Campus; rec.Campus)
                {
                    ApplicationArea = all;
                }


            }

        }
    }
}

