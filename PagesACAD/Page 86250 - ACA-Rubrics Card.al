page 86250 "ACA-Rubrics Card"
{
    PageType = Card;
    SourceTable = "ACA-Results Status";
    SourceTableView = WHERE("Special Programme Class" = FILTER(General));

    layout
    {
        area(content)
        {
            group(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Transcript Remarks"; Rec."Transcript Remarks")
                {
                    ApplicationArea = All;
                }
                field("Final Year Comment"; Rec."Final Year Comment")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Manual Status Processing"; Rec."Manual Status Processing")
                {
                    ApplicationArea = All;
                }
                field("Order No"; Rec."Order No")
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
                field("Status Msg6"; Rec."Status Msg6")
                {
                    ApplicationArea = All;
                }
                field("1st Year Grad. Comments"; Rec."1st Year Grad. Comments")
                {
                    ApplicationArea = All;
                }
                field("2nd Year Grad. Comments"; Rec."2nd Year Grad. Comments")
                {
                    ApplicationArea = All;
                }
                field("3rd Year Grad. Comments"; Rec."3rd Year Grad. Comments")
                {
                    ApplicationArea = All;
                }
                field("4th Year Grad. Comments"; Rec."4th Year Grad. Comments")
                {
                    ApplicationArea = All;
                }
                field("5th Year Grad. Comments"; Rec."5th Year Grad. Comments")
                {
                    ApplicationArea = All;
                }
                field("6th Year Grad. Comments"; Rec."6th Year Grad. Comments")
                {
                    ApplicationArea = All;
                }
                field("7th Year Grad. Comments"; Rec."7th Year Grad. Comments")
                {
                    ApplicationArea = All;
                }
                field("Finalists Grad. Comm. Degree"; Rec."Finalists Grad. Comm. Degree")
                {
                    ApplicationArea = All;
                }
                field("Minimum Units Failed"; Rec."Minimum Units Failed")
                {
                    ApplicationArea = All;
                }
                field("Maximum Units Failed"; Rec."Maximum Units Failed")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Summary Page Caption"; Rec."Summary Page Caption")
                {
                    ApplicationArea = All;
                }
                field("Include Failed Units Headers"; Rec."Include Failed Units Headers")
                {
                    ApplicationArea = All;
                }
                field("Min/Max Based on"; Rec."Min/Max Based on")
                {
                    ApplicationArea = All;
                }
                field("Include Academic Year Caption"; Rec."Include Academic Year Caption")
                {
                    ApplicationArea = All;
                }
                field("Academic Year Text"; Rec."Academic Year Text")
                {
                    ApplicationArea = All;
                }
                field(Pass; Rec.Pass)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Special Programme Class" := Rec."Special Programme Class"::General;
    end;
}

