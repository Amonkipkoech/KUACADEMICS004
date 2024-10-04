/// <summary>
/// Page ELECTPoll Agents List (ID 60025).
/// </summary>
page 60025 "ELECTPoll Agents List"
{
    PageType = List;
    SourceTable = 60014;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("National ID"; Rec."National ID")
                {
                    ApplicationArea = All;
                }
                field(Names; Rec.Names)
                {
                    ApplicationArea = All;
                }
                field("Candidate No."; Rec."Candidate No.")
                {
                    ApplicationArea = All;
                }
                field("Candidate Name"; Rec."Candidate Name")
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

