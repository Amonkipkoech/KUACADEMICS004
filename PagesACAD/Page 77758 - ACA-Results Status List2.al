page 77758 "ACA-Results Status List2"
{
    PageType = List;
    SourceTable = "ACA-Results Status";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Status Msg1"; Rec."Status Msg1")
                {
                    ApplicationArea = All;
                }
                field("Status Msg2"; Rec."Status Msg2")
                {
                    ApplicationArea = All;
                }
                field("Status Msg3"; Rec."Status Msg3")
                {
                    ApplicationArea = All;
                }
                field("Status Msg4"; Rec."Status Msg4")
                {
                    ApplicationArea = All;
                }
                field("Status Msg5"; Rec."Status Msg5")
                {
                    ApplicationArea = All;
                }
                field("Order No"; Rec."Order No")
                {
                    ApplicationArea = All;
                }
                field("Manual Status Processing"; Rec."Manual Status Processing")
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

