page 40049 "Consolidated  Deprt Teach Card"
{
    Caption = 'Consolidated  Deprt Teach Card';
    PageType = Card;
    SourceTable = "Consolidated Teaching Tble";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
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
            group("Time Table Units")
            {
                part("Consolidated teaching Timetable"; "Consolidated teaching Listpart")
                {
                    SubPageLink = "Academic Year" = field("Academic Year"), Semester = field("Session Year"), Campus = field(Campus);
                    UpdatePropagation = Both
                    ;
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
}
