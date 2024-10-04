/// <summary>
/// Page ELECT-Voter Register LKP (ID 60021).
/// </summary>
page 60021 "ELECT-Voter Register LKP"
{
    CardPageID = "ELECT-Voter Register Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 60002;

    layout
    {
        area(content)
        {
            repeater(General)
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
                    ApplicationArea = All;
                }
                field("Voter Balance"; Rec."Voter Balance")
                {
                    ApplicationArea = All;
                }
                field("Voter Verified"; Rec."Voter Verified")
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                field("Campus Code"; Rec."Campus Code")
                {
                    ApplicationArea = All;
                }
                field("School Code"; Rec."School Code")
                {
                    ApplicationArea = All;
                }
                field("Electral District"; Rec."Electral District")
                {
                    ApplicationArea = All;
                }
                field(Eligible; Rec.Eligible)
                {
                    ApplicationArea = All;
                }
                field("Polling Center Code"; Rec."Polling Center Code")
                {
                    ApplicationArea = All;
                }
                field(Voted; Rec.Voted)
                {
                    ApplicationArea = All;
                }
                field("Ballot ID"; Rec."Ballot ID")
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

