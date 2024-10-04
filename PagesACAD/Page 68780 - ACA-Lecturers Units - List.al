page 68780 "ACA-Lecturers Units - List"
{
    PageType = List;
    SourceTable = "ACA-Lecturers Units";

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("Engagement Terms"; Rec."Engagement Terms")
                {
                    ApplicationArea = All;
                }
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;
                }
                field(Unit; Rec.Unit)
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("No. Of Hours"; Rec."No. Of Hours")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Lectures)
            {
                Caption = 'Lectures';
                action(Attendace)
                {
                    Caption = 'Attendace';
                    ApplicationArea = All;
                    //RunObject = Page "ACA-Attendance";

                }
            }
        }
    }
}

