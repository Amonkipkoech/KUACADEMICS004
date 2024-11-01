page 40017 "Student Absence Request List"

{
    PageType = List;
    CardPageId = "Student Absence Request Card";
    SourceTable = "Student Absence Request";
    Caption = 'Student Absence Request List';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Request No."; "Request No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Displays the unique request number for each student absence request.';
                }
                field("Student Name"; "Student Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Displays the name of the student who requested an absence.';
                }
                field("Admission Number"; "Admission Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Displays the admission number of the student.';
                }
                field("Program Admitted"; "Program Admitted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Displays the program the student is admitted to.';
                }
                field("Year of Study"; "Year of Study")
                {
                    ApplicationArea = All;
                    ToolTip = 'Displays the year of study of the student.';
                }
                field("Date From"; "Date From")
                {
                    ApplicationArea = All;
                    ToolTip = 'Displays the start date of the requested absence.';
                }
                field("Date To"; "Date To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Displays the end date of the requested absence.';
                }
                field("Reason for Absence"; rec."Reason for Absence")
                {
                    ApplicationArea = All;
                    ToolTip = 'Displays the reason for the student absence';
                }
                field("Institute Approval"; "Institute Approval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Displays whether the request has been approved by the Head of Institute.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ViewDetails)
            {
                ApplicationArea = All;
                Caption = 'View Details';
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    PAGE.Run(PAGE::"Student Absence Request Card", Rec);
                end;
            }
        }
    }

    
}
                
