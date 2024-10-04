/// <summary>
/// Page ELECT-Candidates List (ID 60006).
/// </summary>
page 60006 "ELECT-Candidates List"
{
    CardPageID = "ELECT-Candidates Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 60006;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Candidate No."; Rec."Candidate No.")
                {
                    ApplicationArea = All;
                }
                field("Candidate Names"; Rec."Candidate Names")
                {
                    ApplicationArea = All;
                }
                field("Position Code"; Rec."Position Code")
                {
                    ApplicationArea = All;
                }
                field("Votes Count"; Rec."Votes Count")
                {
                    ApplicationArea = All;
                }
                field("Position Category"; Rec."Position Category")
                {
                    ApplicationArea = All;
                }
                field("Electral District Code"; Rec."Electral District Code")
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
            }
        }
    }

    actions
    {
    }

    var
        X: Integer;
}

