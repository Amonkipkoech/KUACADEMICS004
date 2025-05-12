page 40053 "Consolidated Exam card"
{
    Caption = 'Consolidated Exam Card';
    PageType = Card;

    SourceTable = "Consolidated Exam TimeTable";

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
                part("Consolidated  Exan Timetable"; "Consolidated  Exam Timetable")
                {
                    SubPageLink = "Academic Year" = field("Academic Year"), Semester = field("Session Year"), Campus = field(Campus);

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
