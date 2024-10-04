page 68744 "ACA-Semesters List"
{
    PageType = List;
    DeleteAllowed = false;

    SourceTable = 61692;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    Editable = true;
                    Enabled = true;
                    ApplicationArea = All;
                    Caption = 'Semester Code';
                }
                field(Description; Rec.Description)
                {
                    Editable = true;
                    Enabled = true;
                    ApplicationArea = All;
                    Caption = 'Semester Description';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(From; Rec.From)
                {
                    ApplicationArea = All;
                }
                field("To"; Rec."To")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Current Semester"; Rec."Current Semester")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }

                field("SMS Results Semester"; Rec."SMS Results Semester")
                {
                    ApplicationArea = All;
                }
                field("Lock Exam Editting"; Rec."Lock Exam Editting")
                {
                    ApplicationArea = All;
                }
                field("Lock CAT Editting"; Rec."Lock CAT Editting")
                {
                    ApplicationArea = All;
                }
                field("Ignore Editing Rule"; Rec."Ignore Editing Rule")
                {
                    ApplicationArea = All;
                }
                field("Released Results"; Rec."Released Results")
                {
                    ApplicationArea = All;
                }
                field("Marks Changeable"; Rec."Marks Changeable")
                {
                    ApplicationArea = All;
                }
                field("Evaluate Lecture"; Rec."Evaluate Lecture")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Card)
            {
#pragma warning disable AL0482
                Image = card;
#pragma warning restore AL0482
                RunObject = Page 68736;
                RunPageLink = Code = FIELD(Code);
                ApplicationArea = All;
            }
        }
    }
}

