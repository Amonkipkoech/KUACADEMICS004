page 60005 "ELECT-Cand. Applications Card"
{
    PageType = Card;
    SourceTable = 60005;

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Election Code"; Rec."Election Code")
                {
                    ApplicationArea = All;
                }
                field("Electraol District Code"; Rec."Electraol District Code")
                {
                    ApplicationArea = All;
                }
                field("Position Category"; Rec."Position Category")
                {
                    ApplicationArea = All;
                }
                field("Position Code"; Rec."Position Code")
                {
                    ApplicationArea = All;
                }
                field("Candidate No."; Rec."Candidate No.")
                {
                    ApplicationArea = All;
                }
                field("Candidate Names"; Rec."Candidate Names")
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                field("School Code"; Rec."School Code")
                {
                    ApplicationArea = All;
                }
                field("Campus Code"; Rec."Campus Code")
                {
                    ApplicationArea = All;
                }
                field("Campaign Slogan"; Rec."Campaign Slogan")
                {
                    ApplicationArea = All;
                }
                field("Campaign Statement"; Rec."Campaign Statement")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

