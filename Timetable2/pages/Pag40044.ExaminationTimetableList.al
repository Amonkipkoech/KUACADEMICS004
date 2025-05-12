page 40044 "Examination Timetable List"
{
    Caption = 'Examination Timetable List';
    PageType = List;
    SourceTable = "Exam Dept Timetable";
    CardPageId = "Exam Dept Card ";

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
