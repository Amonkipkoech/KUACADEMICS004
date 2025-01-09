page 40028 "Supp Exam Registration Card"
{
    PageType = Card;

    SourceTable = "Supp Exam Registration Header";
    Caption = 'Supplementary Exam Registration';

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Application No."; "Application No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Student Full Name"; "Student Full Name")
                {
                    ApplicationArea = All;
                }

                field("Student Admission No."; "Student Admission No.")
                {
                    ApplicationArea = All;
                }

                field("Program"; "Program")
                {
                    ApplicationArea = All;
                }
            }

            part(ListPart; "Supp Exam Reg ListPart")
            {
                ApplicationArea = All;
                SubPageLink = "Application No." = FIELD("Application No.");
            }
        }
    }
}

