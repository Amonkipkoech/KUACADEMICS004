page 68519 "ACA-Pending Admissions (JAB)"
{
    PageType = List;
    SourceTable = "ACA-Adm. Form Header";
    SourceTableView = WHERE(Status = CONST(New),
                            "Admission Type" = CONST('JAB'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Admission No."; Rec."Admission No.")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
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
                field("Faculty Admitted To"; Rec."Faculty Admitted To")
                {
                    ApplicationArea = All;
                }
                field("Degree Admitted To"; Rec."Degree Admitted To")
                {
                    ApplicationArea = All;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
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
                Image = Card;
                RunObject = Page 68496;
                RunPageLink = "Admission No." = FIELD("Admission No.");
                ApplicationArea = All;
            }
        }
    }
}

