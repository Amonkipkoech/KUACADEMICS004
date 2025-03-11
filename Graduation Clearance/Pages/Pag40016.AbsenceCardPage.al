page 40016 "Student Absence Request Card"

{
    PageType = Card;
    SourceTable = "Student Absence Request";
    Caption = 'Student Absence Request';

    layout
    {
        area(Content)
        {
            group("Section 1 - To be completed by the student")
            {
                field("Student Name"; rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Admission Number"; "Admission Number")
                {
                    ApplicationArea = All;
                }
                field("Program Admitted"; "Program Admitted")
                {
                    ApplicationArea = All;
                }
                // field("Year of Study"; "Year of Study")
                // {
                //     ApplicationArea = All;
                // }
                field("Date From"; "Date From")
                {
                    ApplicationArea = All;
                }
                field("Date To"; "Date To")
                {
                    ApplicationArea = All;
                }
                field("Session(s) Missed"; "Session(s) Missed")
                {
                    ApplicationArea = All;
                }
                field("Total Hours Missed"; "Total Hours Missed")
                {
                    ApplicationArea = All;
                }
                field("Reason for Absence"; "Reason for Absence")
                {
                    ApplicationArea = All;
                }
                field("Other Reason (Specify)"; "Other Reason (Specify)")
                {
                    ApplicationArea = All;
                }
                field("Student Signature Date"; "Student Signature Date")
                {
                    ApplicationArea = All;
                }
            }

            group("Section 2 - Official use by Head of Department")
            {
                field("HOD Objection"; "HOD Objection")
                {
                    ApplicationArea = All;
                }
                field("HOD Reason"; "HOD Reason")
                {
                    ApplicationArea = All;
                }
                field("HOD Signature Date"; "HOD Signature Date")
                {
                    ApplicationArea = All;
                }
            }

            group("Section 3 - Official use by Head of Institute")
            {
                field("Institute Approval"; "Institute Approval")
                {
                    ApplicationArea = All;
                }
                field("Institute Reason"; "Institute Reason")
                {
                    ApplicationArea = All;
                }
                field("Institute Signature Date"; "Institute Signature Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ApproveRequest)
            {
                ApplicationArea = All;
                Caption = 'Approve Request';
                Promoted = true;
                trigger OnAction()
                begin
                    if "Institute Approval" = "Institute Approval"::"Not Approved" then
                        Error('Cannot approve a request that is not approved by the Head of Institute.');

                    Message('Request Approved Successfully!');
                end;
            }
        }
    }
}

