/// <summary>
/// Page Graduation Course Reg. (ID 99990).
/// </summary>
page 99990 "Graduation Course Reg."
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 66631;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Year of Study"; Rec."Year of Study")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Attained Stage Units"; Rec."Attained Stage Units")
                {
                    ApplicationArea = All;
                }
                field("Required Stage Units"; Rec."Required Stage Units")
                {
                    ApplicationArea = All;
                }
                field("Final Classification"; Rec."Final Classification")
                {
                    ApplicationArea = All;
                }
                field("Total Units"; Rec."Total Units")
                {
                    ApplicationArea = All;
                }
                field("Total Marks"; Rec."Total Marks")
                {
                    ApplicationArea = All;
                }
                field("Total Weighted Marks"; Rec."Total Weighted Marks")
                {
                    ApplicationArea = All;
                }
                field("Failed Courses"; Rec."Failed Courses")
                {
                    ApplicationArea = All;
                }
                field("Failed Cores"; Rec."Failed Cores")
                {
                    ApplicationArea = All;
                }
                field("Failed Required"; Rec."Failed Required")
                {
                    ApplicationArea = All;
                }
                field("Total Courses"; Rec."Total Courses")
                {
                    ApplicationArea = All;
                }
                field("Failed Electives"; Rec."Failed Electives")
                {
                    ApplicationArea = All;
                }
                field("Total Cores Done"; Rec."Total Cores Done")
                {
                    ApplicationArea = All;
                }
                field("Total Cores Passed"; Rec."Total Cores Passed")
                {
                    ApplicationArea = All;
                }
                field("Total Required Done"; Rec."Total Required Done")
                {
                    ApplicationArea = All;
                }
                field("Total Electives Done"; Rec."Total Electives Done")
                {
                    ApplicationArea = All;
                }
                field("Tota Electives Passed"; Rec."Tota Electives Passed")
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

