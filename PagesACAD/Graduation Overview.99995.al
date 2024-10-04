/// <summary>
/// Page Graduation Overview (ID 99995).
/// </summary>
page 99995 "Graduation Overview"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "ACA-Classification Students";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student Number"; Rec."Student Number")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("School Code"; Rec."School Code")
                {
                    ApplicationArea = All;
                }
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                }
                field("Graduation Academic Year"; Rec."Graduation Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Final Classification"; Rec."Final Classification")
                {
                    ApplicationArea = All;
                }
                field("Classified Average"; Rec."Classified Average")
                {
                    ApplicationArea = All;
                }
                field("Required Stage Units"; Rec."Required Stage Units")
                {
                    ApplicationArea = All;
                }
                field("Attained Stage Units"; Rec."Attained Stage Units")
                {
                    ApplicationArea = All;
                }
                field(Graduating; Rec.Graduating)
                {
                    ApplicationArea = All;
                }
                field(Classification; Rec.Classification)
                {
                    ApplicationArea = All;
                }
                field("Total Courses"; Rec."Total Courses")
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
                field("Normal Average"; Rec."Normal Average")
                {
                    ApplicationArea = All;
                }
                field("Weighted Average"; Rec."Weighted Average")
                {
                    ApplicationArea = All;
                }
                field("Total Failed Courses"; Rec."Total Failed Courses")
                {
                    ApplicationArea = All;
                }
                field("Total Failed Units"; Rec."Total Failed Units")
                {
                    ApplicationArea = All;
                }
                field("Failed Courses"; Rec."Failed Courses")
                {
                    ApplicationArea = All;
                }
                field("Failed Units"; Rec."Failed Units")
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
        area(creation)
        {
            action("Graduation Semester Registration")
            {
                Image = CustomerCode;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page 99990;
                RunPageLink = "Student Number" = FIELD("Student Number"),
                              Programme = FIELD(Programme),
                              "Graduation Academic Year" = FIELD("Graduation Academic Year");
                ApplicationArea = All;
            }
            action("Graduation Units")
            {
                Image = ApplicationWorksheet;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page 99991;
                RunPageLink = "Student No." = FIELD("Student Number"),
                              Programme = FIELD(Programme),
                              "Graduation Academic Year" = FIELD("Graduation Academic Year");
                ApplicationArea = All;
            }
            action("Not Graduating Reasons")
            {
                Image = DocInBrowser;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page 99992;
                RunPageLink = "Student No." = FIELD("Student Number"),
                              "Graduation Academic Year" = FIELD("Graduation Academic Year");
                ApplicationArea = All;
            }
        }
    }
}

