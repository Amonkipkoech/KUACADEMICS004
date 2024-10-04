page 77205 "ACA-Results Approved Canc."
{
    Caption = 'Approved Exam Cancellations';
    CardPageID = "ACA-Results Cancellation View";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Aca-Result Cancelation Req. Hd";
    SourceTableView = WHERE(Status = FILTER(Approved));

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
            action(RevokeCancellation)
            {
                Caption = 'Revoke Cancellation';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", USERID);
                    IF UserSetup.FIND('-') THEN
                        UserSetup.TESTFIELD("Revoke Results Cancellation")
                    ELSE
                        ERROR('Access denied!');
                    Rec.CALCFIELDS("Department Code");
                    IF CONFIRM('Revoke Results Cancellation?', TRUE) = FALSE THEN ERROR('Process Stopped by user');

                    AcaResultCancelationSubject.RESET;
                    AcaResultCancelationSubject.SETRANGE("Student No.", Rec."Student No.");
                    AcaResultCancelationSubject.SETRANGE("Academic Year", Rec."Academic Year");
                    AcaResultCancelationSubject.SETRANGE("Semester Code", Rec."Semester Code");
                    AcaResultCancelationSubject.SETRANGE("Program Code", Rec."Program Code");
                    IF AcaResultCancelationSubject.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            ACAExamResultsCancelled.RESET;
                            ACAExamResultsCancelled.SETRANGE("Student No.", AcaResultCancelationSubject."Student No.");
                            ACAExamResultsCancelled.SETRANGE(Programmes, AcaResultCancelationSubject."Program Code");
                            ACAExamResultsCancelled.SETRANGE(Unit, AcaResultCancelationSubject."Unit Code");
                            IF (AcaResultCancelationSubject."Exam Type" = AcaResultCancelationSubject."Exam Type"::"Exam Only") THEN
                                ACAExamResultsCancelled.SETFILTER(ExamType, '%1|%2|%3', 'EXAM', 'MAIN EXAM', 'FINAl EXAM')
                            ELSE
                                IF (AcaResultCancelationSubject."Exam Type" = AcaResultCancelationSubject."Exam Type"::"CAT Only") THEN
                                    ACAExamResultsCancelled.SETFILTER(ExamType, '%1|%2', 'CAT', 'CATS');
                            IF ACAExamResultsCancelled.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    ACAExamResults.INIT;
                                    ACAExamResults."Student No." := ACAExamResultsCancelled."Student No.";
                                    ACAExamResults.Programmes := ACAExamResultsCancelled.Programmes;
                                    ACAExamResults.Semester := ACAExamResultsCancelled.Semester;
                                    ACAExamResults.Unit := ACAExamResultsCancelled.Unit;
                                    ACAExamResults."Academic Year" := ACAExamResultsCancelled."Academic Year";
                                    ACAExamResults.Stage := ACAExamResultsCancelled.Stage;
                                    ACAExamResults.Exam := ACAExamResultsCancelled.Exam;
                                    ACAExamResults."Exam Category" := ACAExamResultsCancelled."Exam Category";
                                    ACAExamResults.ExamType := ACAExamResultsCancelled.ExamType;
                                    ACAExamResults."Reg. Transaction ID" := ACAExamResultsCancelled."Reg. Transaction ID";
                                    ACAExamResults.VALIDATE(Score, ACAExamResultsCancelled.Score);
                                    ACAExamResults.Grade := ACAExamResultsCancelled.Grade;
                                    ACAExamResults.Percentage := ACAExamResultsCancelled.Percentage;
                                    ACAExamResults.Percentage := ACAExamResultsCancelled.Percentage;
                                    ACAExamResults.Contribution := ACAExamResultsCancelled.Contribution;
                                    ACAExamResults."Admission No" := ACAExamResultsCancelled."Admission No";
                                    ACAExamResults."Original Contribution" := ACAExamResultsCancelled."Original Contribution";
                                    ACAExamResults."Original Score" := ACAExamResultsCancelled."Original Score";
                                    ACAExamResults."Last Edited By" := ACAExamResultsCancelled."Last Edited By";
                                    ACAExamResults."Last Edited On" := ACAExamResultsCancelled."Last Edited On";
                                    ACAExamResults."User Name" := ACAExamResultsCancelled."User Name";
                                    ACAExamResults.UserID := ACAExamResultsCancelled.UserID;
                                    ACAExamResults."Lecturer Names" := ACAExamResultsCancelled."Lecturer Names";
                                    ACAExamResults.Submitted := ACAExamResultsCancelled.Submitted;
                                    ACAExamResults."Submitted By" := ACAExamResultsCancelled."Submitted By";
                                    ACAExamResults."Submitted On" := ACAExamResultsCancelled."Submitted On";
                                    ACAExamResults.INSERT;
                                    ACAExamResultsCancelled.DELETE;
                                END;
                                UNTIL ACAExamResultsCancelled.NEXT = 0;
                            END;
                        END;
                        UNTIL AcaResultCancelationSubject.NEXT = 0;
                        Rec.Status := Rec.Status::New;
                        Rec."Approved By" := '';
                        Rec.MODIFY;
                    END;
                    CurrPage.UPDATE;
                    MESSAGE('Results Cancellation Revoked!');
                end;
            }
        }
    }

    var
        UserSetup: Record "User Setup";
        ACAExamResultsCancelled: Record "ACA-Exam Results (Cancelled)";
        ACAExamResults: Record "ACA-Exam Results";
        AcaResultCancelationSubject: Record "Aca-Result Cancelation Subject";
}

