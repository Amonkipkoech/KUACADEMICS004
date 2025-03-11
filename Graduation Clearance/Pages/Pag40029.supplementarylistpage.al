page 40029 "Supp Exam Registration List"
{
    PageType = List;

    SourceTable = "Supp Exam Registration Header";
    Caption = 'Supplementary Exam Registrations';
    CardPageId = "Supp Exam Registration Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No."; rec."Application No.")
                {
                    ApplicationArea = All;
                }

                field("Student Full Name"; rec."Student Full Name")
                {
                    ApplicationArea = All;
                }

                field("Student Admission No."; rec."Student Admission No.")
                {
                    ApplicationArea = All;
                }

                field("Program"; rec."Program")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

