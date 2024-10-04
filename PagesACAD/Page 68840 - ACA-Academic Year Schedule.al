/// <summary>
/// Page ACA-Academic Year Schedule (ID 68840).
/// </summary>
page 68840 "ACA-Academic Year Schedule"
{
    Caption = 'University Calender';
    PageType = ListPart;
    SourceTable = "ACA-Academic Year Schedule";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Description of Intake/Semester"; Rec."Description of Intake/Semester")
                {
                    ApplicationArea = All;
                    Caption = 'Event Name';
                }
                field(Intake; Rec.Intake)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    Caption = 'Event start date';
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                { Caption = 'Event end date';
                    ApplicationArea = All;
                }
                field("Is Current"; Rec."Is Current")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Registration Deadline"; Rec."Registration Deadline")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                // field("Allow View of Results"; Rec."Allow View of Results")
                // {
                //     ApplicationArea = All;
                // }
                // field("Marks Caprture Begin Date"; Rec."Marks Caprture Begin Date")
                // {
                //     ApplicationArea = All;
                // }
                // field("Marks Caprture End Date"; Rec."Marks Caprture End Date")
                // {
                //     ApplicationArea = All;
                // }
            }
        }
    }

    actions
    {
    }
}

