page 85623 "ACA-Project Thesis"
{
    PageType = Card;
    SourceTable = "Project Tracking";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Thesis Code"; Rec."Thesis Code")
                {
                    ApplicationArea = All;

                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Student Id"; Rec."Student Id")
                {
                    ApplicationArea = All;
                }
                field("Program ID"; Rec."Program ID")
                {
                    ApplicationArea = all;
                }
                field("Project/Thesis Title"; Rec."Project/Thesis Title")
                {
                    ApplicationArea = All;
                }
                field("Supervisor Staff ID"; Rec."Supervisor Staff ID")
                {
                    ApplicationArea = All;
                }
                field("Secondary Supervisor Name"; Rec."Secondary Supervisor Name")
                {
                    ApplicationArea = All;
                }
                field("Supervisor Allocation Date"; Rec."Supervisor Allocation Date")
                {
                    ApplicationArea = All;
                }
                field("Proposal Defense Date"; Rec."Proposal Defense Date")
                {
                    ApplicationArea = All;
                }
                field("Allocated Internal Examiner 1"; Rec."Allocated Internal Examiner 1")
                {
                    ApplicationArea = All;
                }
                field("Allocated Internal Examiner 2"; Rec."Allocated Internal Examiner 2")
                {
                    ApplicationArea = All;
                }
                field("Allocated External Examiner"; Rec."Allocated External Examiner")
                {
                    ApplicationArea = All;
                }

            }
            part("Project Thesis Lines"; "Project Thesis Lines")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {

        }
    }

    var
        myInt: Integer;
}