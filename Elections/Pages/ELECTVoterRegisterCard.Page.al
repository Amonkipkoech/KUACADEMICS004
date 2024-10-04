/// <summary>
/// Page ELECT-Voter Register Card (ID 60002).
/// </summary>
page 60002 "ELECT-Voter Register Card"
{
    PageType = Card;
    SourceTable = 60002;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Voter Type"; Rec."Voter Type")
                {
                    ApplicationArea = All;
                }
                field("Voter No."; Rec."Voter No.")
                {
                    ApplicationArea = All;
                }
                field("Voter Names"; Rec."Voter Names")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Voter Balance"; Rec."Voter Balance")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Electral District"; Rec."Electral District")
                {
                    ApplicationArea = All;
                }
                field("Polling Center Code"; Rec."Polling Center Code")
                {
                    ApplicationArea = All;
                }
                field("Voter Verified"; Rec."Voter Verified")
                {
                    ApplicationArea = All;
                }
                field("Manual Eligibility to Contest"; Rec."Manual Eligibility to Contest")
                {
                    Caption = 'Cleared to Vie';
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Campus Code"; Rec."Campus Code")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("School Code"; Rec."School Code")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Eligible; Rec.Eligible)
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Ballot ID"; Rec."Ballot ID")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Voted; Rec.Voted)
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

