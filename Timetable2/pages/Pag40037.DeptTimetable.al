page 40037 "Dept Timetable "
{
    Caption = 'Dept Timetable ';
    PageType = Card;
    SourceTable = "Dept TimeTable List ";

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
                field("Department "; rec."Department ")
                {
                    ApplicationArea = all;

                }

            }
        }
    }
}
