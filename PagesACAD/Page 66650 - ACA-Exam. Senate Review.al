page 66650 "ACA-Exam. Senate Review"
{
    Caption = 'Senate Report Preview';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 66651;

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
                field(Classification; Rec.Classification)
                {
                    ApplicationArea = All;
                }
                field("Year of Study"; Rec."Year of Study")
                {
                    ApplicationArea = All;
                }
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field("School Code"; Rec."School Code")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
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
                field("Total Required Passed"; Rec."Total Required Passed")
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
                field("Required Stage Units"; Rec."Required Stage Units")
                {
                    ApplicationArea = All;
                }
                field("Attained Stage Units"; Rec."Attained Stage Units")
                {
                    ApplicationArea = All;
                }
                field("Units Deficit"; Rec."Units Deficit")
                {
                    ApplicationArea = All;
                }
                field("Cummulative Fails"; Rec."Cummulative Fails")
                {
                    ApplicationArea = All;
                }
                field("Cumm. Required Stage Units"; Rec."Cumm. Required Stage Units")
                {
                    ApplicationArea = All;
                }
                field("Cumm Attained Units"; Rec."Cumm Attained Units")
                {
                    ApplicationArea = All;
                }
                field("Deficit Core Courses"; Rec."Deficit Core Courses")
                {
                    ApplicationArea = All;
                }
                field("Deficit Core Units"; Rec."Deficit Core Units")
                {
                    ApplicationArea = All;
                }
                field("Deficit Required Courses"; Rec."Deficit Required Courses")
                {
                    ApplicationArea = All;
                }
                field("Deficit Required Units"; Rec."Deficit Required Units")
                {
                    ApplicationArea = All;
                }
                field("Deficit Electives Courses"; Rec."Deficit Electives Courses")
                {
                    ApplicationArea = All;
                }
                field("Deficit Electives Units"; Rec."Deficit Electives Units")
                {
                    ApplicationArea = All;
                }
                field("Multiple Programe Reg. Exists"; Rec."Multiple Programe Reg. Exists")
                {
                    ApplicationArea = All;
                }
                field("Programme Option"; Rec."Programme Option")
                {
                    ApplicationArea = All;
                }
                field("% Total Failed Courses"; Rec."% Total Failed Courses")
                {
                    ApplicationArea = All;
                }
                field("% Total Failed Units"; Rec."% Total Failed Units")
                {
                    ApplicationArea = All;
                }
                field("% Failed Courses"; Rec."% Failed Courses")
                {
                    ApplicationArea = All;
                }
                field("% Failed Units"; Rec."% Failed Units")
                {
                    ApplicationArea = All;
                }
                field("% Failed Cores"; Rec."% Failed Cores")
                {
                    ApplicationArea = All;
                }
                field("% Failed Required"; Rec."% Failed Required")
                {
                    ApplicationArea = All;
                }
                field("% Failed Electives"; Rec."% Failed Electives")
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
            action("Student Units")
            {
                Caption = 'Student Units';
                Image = ApplicationWorksheet;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page 66651;
                RunPageLink = "Student No." = FIELD("Student Number"),
                              Programme = FIELD(Programme),
                              "Year of Study" = FIELD("Year of Study"),
                              "Academic Year" = FIELD("Academic Year");
                ApplicationArea = All;
            }
        }
    }
}

