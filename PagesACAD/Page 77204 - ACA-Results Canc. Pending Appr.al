page 77204 "ACA-Results Canc. Pending Appr"
{
    Caption = 'Results Cancellations (Pending Approvals)';
    CardPageID = "ACA-Results Cancellation View";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Aca-Result Cancelation Req. Hd";
    SourceTableView = WHERE(Status = FILTER("Pending Approval"));

    layout
    {
        area(content)
        {
            repeater(General)
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
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(ApproveDoc)
            {
                Caption = 'Approve Results Cancellation';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", USERID);
                    IF UserSetup.FIND('-') THEN
                        UserSetup.TESTFIELD("Approve Results Cancellation")
                    ELSE
                        ERROR('Access denied!');
                    Rec.CALCFIELDS("Department Code");
                    IF CONFIRM('Approve Results Cancellation?', TRUE) = FALSE THEN ERROR('Process Stopped by user');
                    Rec.Status := Rec.Status::Approved;
                    Rec."Approved By" := USERID;
                    Rec."Approved Date" := TODAY;
                    Rec."Approved Time" := TIME;
                    Rec.MODIFY;
                    // Post Approvals
                    AcaResultCancelationSubject.RESET;
                    AcaResultCancelationSubject.SETRANGE("Student No.", Rec."Student No.");
                    AcaResultCancelationSubject.SETRANGE("Academic Year", Rec."Academic Year");
                    AcaResultCancelationSubject.SETRANGE("Semester Code", Rec."Semester Code");
                    AcaResultCancelationSubject.SETRANGE("Program Code", Rec."Program Code");
                    IF AcaResultCancelationSubject.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            ACAExamResults.RESET;
                            ACAExamResults.SETRANGE("Student No.", AcaResultCancelationSubject."Student No.");
                            ACAExamResults.SETRANGE(Programmes, AcaResultCancelationSubject."Program Code");
                            ACAExamResults.SETRANGE(Unit, AcaResultCancelationSubject."Unit Code");
                            IF (AcaResultCancelationSubject."Exam Type" = AcaResultCancelationSubject."Exam Type"::"Exam Only") THEN
                                ACAExamResults.SETFILTER(ExamType, '%1|%2|%3', 'EXAM', 'MAIN EXAM', 'FINAl EXAM')
                            ELSE
                                IF (AcaResultCancelationSubject."Exam Type" = AcaResultCancelationSubject."Exam Type"::"CAT Only") THEN
                                    ACAExamResults.SETFILTER(ExamType, '%1|%2', 'CAT', 'CATS');
                            IF ACAExamResults.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    ACAExamResultsCancelled.INIT;
                                    ACAExamResultsCancelled."Student No." := ACAExamResults."Student No.";
                                    ACAExamResultsCancelled.Programmes := ACAExamResults.Programmes;
                                    ACAExamResultsCancelled.Semester := ACAExamResults.Semester;
                                    ACAExamResultsCancelled.Unit := ACAExamResults.Unit;
                                    ACAExamResultsCancelled."Academic Year" := ACAExamResults."Academic Year";
                                    ACAExamResultsCancelled.Stage := ACAExamResults.Stage;
                                    ACAExamResultsCancelled.Exam := ACAExamResults.Exam;
                                    ACAExamResultsCancelled."Exam Category" := ACAExamResults."Exam Category";
                                    ACAExamResultsCancelled.ExamType := ACAExamResults.ExamType;
                                    ACAExamResultsCancelled."Reg. Transaction ID" := ACAExamResults."Reg. Transaction ID";
                                    ACAExamResultsCancelled.Score := ACAExamResults.Score;
                                    ACAExamResultsCancelled.Grade := ACAExamResults.Grade;
                                    ACAExamResultsCancelled.Percentage := ACAExamResults.Percentage;
                                    ACAExamResultsCancelled.Percentage := ACAExamResults.Percentage;
                                    ACAExamResultsCancelled.Contribution := ACAExamResults.Contribution;
                                    ACAExamResultsCancelled."Admission No" := ACAExamResults."Admission No";
                                    ACAExamResultsCancelled."Original Contribution" := ACAExamResults."Original Contribution";
                                    ACAExamResultsCancelled."Original Score" := ACAExamResults."Original Score";
                                    ACAExamResultsCancelled."Last Edited By" := ACAExamResults."Last Edited By";
                                    ACAExamResultsCancelled."Last Edited On" := ACAExamResults."Last Edited On";
                                    ACAExamResultsCancelled."User Name" := ACAExamResults."User Name";
                                    ACAExamResultsCancelled.UserID := ACAExamResults.UserID;
                                    ACAExamResultsCancelled."Lecturer Names" := ACAExamResults."Lecturer Names";
                                    ACAExamResultsCancelled.Submitted := ACAExamResults.Submitted;
                                    ACAExamResultsCancelled."Submitted By" := ACAExamResults."Submitted By";
                                    ACAExamResultsCancelled."Submitted On" := ACAExamResults."Submitted On";
                                    IF ACAExamResultsCancelled.INSERT THEN;
                                    ACAExamResults.DELETE;
                                END;
                                UNTIL ACAExamResults.NEXT = 0;
                            END;
                        END;
                        UNTIL AcaResultCancelationSubject.NEXT = 0;
                    END;
                    CurrPage.UPDATE;
                    MESSAGE('Cancellation approved!');
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //SETFILTER("Department Code",'=%1',UserSetup.Department);
    end;

    trigger OnOpenPage()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        IF UserSetup.FIND('-') THEN
            UserSetup.TESTFIELD("Approve Results Cancellation")
        ELSE
            ERROR('Access denied!');
        //SETFILTER("Department Code",'=%1',UserSetup.Department);
    end;

    var
        UserSetup: Record "User Setup";
        ACAExamResultsCancelled: Record "ACA-Exam Results (Cancelled)";
        ACAExamResults: Record "ACA-Exam Results";
        AcaResultCancelationSubject: Record "Aca-Result Cancelation Subject";
}

