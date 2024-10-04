page 60007 "ELECT-Ballot Register List"
{
    PageType = List;
    SourceTable = 60007;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Ballot ID"; Rec."Ballot ID")
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
                field("Votting Date"; Rec."Votting Date")
                {
                    ApplicationArea = All;
                }
                field("Voting Time"; Rec."Voting Time")
                {
                    ApplicationArea = All;
                }
                field("Electral District"; Rec."Electral District")
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
                field("Polling Center"; Rec."Polling Center")
                {
                    ApplicationArea = All;
                }
                field("Polling Booth"; Rec."Polling Booth")
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

