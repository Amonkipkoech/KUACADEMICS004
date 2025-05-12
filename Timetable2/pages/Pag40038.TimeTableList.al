page 40038 "Time Table List"
{
    Caption = 'Time Table List';
    PageType = List;
    SourceTable = "Dept TimeTable List ";
    CardPageId = "Dept Timetable ";

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
                field("Department "; rec."Department ")
                {
                    ApplicationArea = all;
                }
                field(Campus; rec.Campus)
                {
                    ApplicationArea = all;
                }
                field(Status2; rec.Status2)
                {
                    Caption = 'Status';
                    ApplicationArea = all;
                }
                field("HoI Comment"; "HoI Comment")
                {
                    ApplicationArea = all;
                }

            }

        }
    }
}
