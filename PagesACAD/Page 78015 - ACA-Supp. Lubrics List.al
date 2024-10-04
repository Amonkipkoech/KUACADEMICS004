page 78015 "ACA-Supp. Lubrics List"
{
    CardPageID = "ACA-Supp. Lubrics Card";
    DeleteAllowed = false;
    Editable = false;
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
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Manual Status Processing"; Rec."Manual Status Processing")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Order No"; Rec."Order No")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Supp. Lubric Caption 6"; Rec."Supp. Lubric Caption 6")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field(Pass; Rec.Pass)
                {
                    ApplicationArea = All;
                }
                field("Min/Max Based on"; Rec."Min/Max Based on")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Supp. Lubric Caption"; Rec."Supp. Lubric Caption")
                {
                    ApplicationArea = All;
                }
                field("Include Academic Year Caption"; Rec."Include Academic Year Caption")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Supp. Lubric Caption 2"; Rec."Supp. Lubric Caption 2")
                {
                    ApplicationArea = All;
                }
                field("Academic Year Text"; Rec."Academic Year Text")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Supp. Lubric Caption 3"; Rec."Supp. Lubric Caption 3")
                {
                    ApplicationArea = All;
                }
                field("Faculty Filter"; Rec."Faculty Filter")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Supp. Lubric Caption 4"; Rec."Supp. Lubric Caption 4")
                {
                    ApplicationArea = All;
                }
                field("Year of Study Filter"; Rec."Year of Study Filter")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Supp. Lubric Caption 5"; Rec."Supp. Lubric Caption 5")
                {
                    ApplicationArea = All;
                }
                field("Minimum Units Failed"; Rec."Minimum Units Failed")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Maximum Units Failed"; Rec."Maximum Units Failed")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Students Count"; Rec."Students Count")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Summary Page Caption"; Rec."Summary Page Caption")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Include Failed Units Headers"; Rec."Include Failed Units Headers")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Transcript Remarks"; Rec."Transcript Remarks")
                {
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

