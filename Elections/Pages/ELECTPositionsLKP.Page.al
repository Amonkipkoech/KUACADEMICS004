/// <summary>
/// Page ELECT-Positions LKP (ID 60016).
/// </summary>
page 60016 "ELECT-Positions LKP"
{
    CardPageID = "ELECT-Positions Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = 60001;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Position Code"; Rec."Position Code")
                {
                    ApplicationArea = All;
                }
                field("Position Description"; Rec."Position Description")
                {
                    ApplicationArea = All;
                }
                field("Position Notes"; Rec."Position Notes")
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
                field("No. Of Candidates"; Rec."No. Of Candidates")
                {
                    ApplicationArea = All;
                }
                field("Position Approved"; Rec."Position Approved")
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
                field("Position Category"; Rec."Position Category")
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

