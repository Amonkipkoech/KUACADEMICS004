/// <summary>
/// Page ACA Prov. Transcript Comments (ID 88853).
/// </summary>
page 88853 "ACA Prov. Transcript Comments"
{
    DeleteAllowed = false;
    InsertAllowed = true;
    PageType = List;
    SourceTable = "Provisional Transcript Comment";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Special Programme Class"; Rec."Special Programme Class")
                {
                    ApplicationArea = All;
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("1st Year Trans. Comments"; Rec."1st Year Trans. Comments")
                {
                    ApplicationArea = All;
                }
                field("2nd Year  Trans. Comments"; Rec."2nd Year  Trans. Comments")
                {
                    ApplicationArea = All;
                }
                field("3rd Year  Trans. Comments"; Rec."3rd Year  Trans. Comments")
                {
                    ApplicationArea = All;
                }
                field("4th Year  Trans. Comments"; Rec."4th Year  Trans. Comments")
                {
                    ApplicationArea = All;
                }
                field("5th Year  Trans. Comments"; Rec."5th Year  Trans. Comments")
                {
                    ApplicationArea = All;
                }
                field("6th Year  Trans. Comments"; Rec."6th Year  Trans. Comments")
                {
                    ApplicationArea = All;
                }
                field("7th Year  Trans. Comments"; Rec."7th Year  Trans. Comments")
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

