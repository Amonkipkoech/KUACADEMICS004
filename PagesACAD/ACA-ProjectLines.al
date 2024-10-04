page 86524 "Project Thesis Lines"
{
    PageType = ListPart;
    SourceTable = "Project Tracking";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Proposal Defence Status"; Rec."Proposal Defence Status")
                {
                    ApplicationArea = All;

                }
                field("Final Defense Date"; Rec."Final Defense Date")
                {
                    ApplicationArea = All;
                }
                field("Final Defense Results"; Rec."Final Defense Results")
                {
                    ApplicationArea = All;
                }
                field("Article Published"; Rec."Article Published")
                {
                    ApplicationArea = All;
                }
                field("Article  Title"; Rec."Article  Title")
                {
                    ApplicationArea = All;
                }
                field("Journal Title"; Rec."Journal Title")
                {
                    ApplicationArea = All;
                }
                field("Journal Edition"; Rec."Journal Edition")
                {
                    ApplicationArea = All;
                }
                field("Anti-Plagiarism"; Rec."Anti-Plagiarism")
                {
                    ApplicationArea = All;
                }
                field("Log book Issues to Student"; Rec."Log book Issues to Student")
                {
                    ApplicationArea = All;
                }
                field("Log Book Issued Date"; Rec."Log Book Issued Date")
                {
                    ApplicationArea = All;
                }
                field("Log Book Issued to HOD"; Rec."Log Book Issued to HOD")
                {
                    ApplicationArea = All;
                }
                field("Log book submission date"; Rec."Log book submission date")
                {
                    ApplicationArea = All;
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

    var
        myInt: Integer;
}