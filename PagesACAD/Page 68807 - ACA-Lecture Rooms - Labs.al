/// <summary>
/// Page ACA-Lecture Rooms - Labs (ID 68807).
/// </summary>
page 68807 "ACA-Lecture Rooms - Labs"
{
    PageType = List;
    SourceTable = 61594;

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Minimum Capacity"; Rec."Minimum Capacity")
                {
                    ApplicationArea = All;
                }
                field("Maximum Capacity"; Rec."Maximum Capacity")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field(Facilities; Rec.Facilities)
                {
                    ApplicationArea = All;
                }
                field("Reserve For"; Rec."Reserve For")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
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

