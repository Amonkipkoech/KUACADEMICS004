page 68486 "ACA-Applic. Form Batch List"
{
    PageType = List;
    SourceTable = 61358;

    layout
    {
        area(content)
        {
            repeater(__)
            {
                Editable = false;
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("First Degree Choice"; Rec."First Degree Choice")
                {
                    ApplicationArea = All;
                }
                field("Second Degree Choice"; Rec."Second Degree Choice")
                {
                    ApplicationArea = All;
                }
                field(Surname; Rec.Surname)
                {
                    ApplicationArea = All;
                }
                field("Other Names"; Rec."Other Names")
                {
                    ApplicationArea = All;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

