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
                field(Campus; rec.Campus)
                {
                    ApplicationArea = all;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                }

            }
            group("Time Table Units")
            {
                part("time table list part"; "time table list part")
                {
                    SubPageLink = "Academic Year" = field("Academic Year"), Semester = field("Session Year"), Department = field("Department "), Campus = field(Campus), Status = field(Status);
                }
            }
        }
    }
}
