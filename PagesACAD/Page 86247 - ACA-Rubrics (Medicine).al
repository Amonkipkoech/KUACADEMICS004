#pragma warning disable DOC0101
page 86247 "ACA-Rubrics (Medicine)"
#pragma warning restore DOC0101
{
    Caption = 'BMED Rubrics';
    PageType = ListPart;
    SourceTable = "ACA-Results Status";
    SourceTableView = WHERE("Special Programme Class" = FILTER('Medicine & Nursing'));

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
                field("Grad. Status Msg 1"; Rec."Grad. Status Msg 1")
                {
                    ApplicationArea = All;
                }
                field("Grad. Status Msg 2"; Rec."Grad. Status Msg 2")
                {
                    ApplicationArea = All;
                }
                field("Grad. Status Msg 3"; Rec."Grad. Status Msg 3")
                {
                    ApplicationArea = All;
                }
                field("Grad. Status Msg 4"; Rec."Grad. Status Msg 4")
                {
                    ApplicationArea = All;
                }
                field("Grad. Status Msg 5"; Rec."Grad. Status Msg 5")
                {
                    ApplicationArea = All;
                }
                field("Grad. Status Msg 6"; Rec."Grad. Status Msg 6")
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
                field("Finalists Grad. Comm. Dip"; Rec."Finalists Grad. Comm. Dip")
                {
                    ApplicationArea = All;
                }
                field("Finalists Grad. Comm. Cert."; Rec."Finalists Grad. Comm. Cert.")
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
                field("Special Programme Class"; Rec."Special Programme Class")
                {
                    ApplicationArea = All;
                }
                field("Special Programme Scope"; Rec."Special Programme Scope")
                {
                    ApplicationArea = All;
                }
                field("Include no. of Repeats"; Rec."Include no. of Repeats")
                {
                    ApplicationArea = All;
                }
                field("Min. Unit Repeat Counts"; Rec."Min. Unit Repeat Counts")
                {
                    ApplicationArea = All;
                }
                field("Max. Unit Repeat Counts"; Rec."Max. Unit Repeat Counts")
                {
                    ApplicationArea = All;
                }
                field("Minimum Academic Repeats"; Rec."Minimum Academic Repeats")
                {
                    ApplicationArea = All;
                }
                field("Maximum Academic Repeat"; Rec."Maximum Academic Repeat")
                {
                    ApplicationArea = All;
                }
                field("Lead Status"; Rec."Lead Status")
                {
                    ApplicationArea = All;
                }
                field("Minimum Core Fails"; Rec."Minimum Core Fails")
                {
                    ApplicationArea = All;
                }
                field("Maximum Core Fails"; Rec."Maximum Core Fails")
                {
                    ApplicationArea = All;
                }
                field("Minimum None-Core Fails"; Rec."Minimum None-Core Fails")
                {
                    ApplicationArea = All;
                }
                field("Maximum None-Core Fails"; Rec."Maximum None-Core Fails")
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
