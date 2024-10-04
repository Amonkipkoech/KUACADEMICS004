page 77206 "ACA-Results Cancellation View"
{
    Caption = 'Results Cancellation View Only';
    DeleteAllowed = false;
    Description = 'View Exam Results Cancellation. No editing Allowed';
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Aca-Result Cancelation Req. Hd";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Semester Code"; Rec."Semester Code")
                {
                    ApplicationArea = All;
                }
                field("Program Code"; Rec."Program Code")
                {
                    ApplicationArea = All;
                }
                field("Stage Code"; Rec."Stage Code")
                {
                    ApplicationArea = All;
                }
                field(Scope; Rec.Scope)
                {
                    ApplicationArea = All;
                }
                field("Cancelllation Notes"; Rec."Cancelllation Notes")
                {
                    ApplicationArea = All;
                }
                field("No. of Units Cancelled"; Rec."No. of Units Cancelled")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Initiated By"; Rec."Initiated By")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Approved By"; Rec."Approved By")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Initiated Date"; Rec."Initiated Date")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Initiated Time"; Rec."Initiated Time")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Approved Time"; Rec."Approved Time")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                part(Rcancellation; 77200)
                {
                    SubPageLink = "Student No." = FIELD("Student No."),
                                  "Academic Year" = FIELD("Academic Year"),
                                  "Semester Code" = FIELD("Semester Code"),
                                  "Program Code" = FIELD("Program Code"),
                                  "Stage Code" = FIELD("Stage Code");
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    var
        UserSetup: Record "User Setup";
        ACAExamResultsCancelled: Record "ACA-Exam Results (Cancelled)";
        ACAExamResults: Record "ACA-Exam Results";
        AcaResultCancelationSubject: Record "Aca-Result Cancelation Subject";
}

