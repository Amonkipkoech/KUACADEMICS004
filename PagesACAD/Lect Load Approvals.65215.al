page 65215 "Lect Load Approvals"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = 65201;
    SourceTableView = WHERE("Courses Count" = FILTER(> 0),
                            Claimed = FILTER(false),
                            Invoiced = FILTER(false));

    layout
    {
        area(content)
        {
            group("Filter")
            {
                Caption = 'Filters';
                field(DateFil; SemesterFilter)
                {
                    Caption = 'Semester Filter';
                    Enabled = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.SETFILTER("Semester Code", '=%1', SemesterFilter);
                        CurrPage.UPDATE;
                    end;
                }
            }
            repeater(Group)
            {
                field("Lecturer Code"; Rec."Lecturer Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Lecturer Name"; Rec."Lecturer Name")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Approve; Rec.Approve)
                {
                    ApplicationArea = All;
                }
                field(Reject; Rec.Reject)
                {
                    ApplicationArea = All;
                }
                field("Courses Count"; Rec."Courses Count")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Admissible; Rec.Admissible)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Campus; Rec.Campus)
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                field("Claim No."; Rec."Claim No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Created Time"; Rec."Created Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Reject Reason"; Rec."Reject Reason")
                {
                    ApplicationArea = All;
                }
                field("Additional Comments"; Rec."Additional Comments")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(CloseBatch)
            {
                Caption = 'Close Batch';
                Image = AvailableToPromise;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    LectLoadBatches.RESET;
                    LectLoadBatches.SETRANGE(LectLoadBatches."Semester Code", SemesterFilter);
                    IF LectLoadBatches.FIND('-') THEN BEGIN
                        IF LectLoadBatches.Status <> LectLoadBatches.Status::Draft THEN ERROR('');
                    END;


                    IF CONFIRM('Close Batch?', FALSE) = FALSE THEN EXIT;
                    LectLoadBatches.RESET;
                    LectLoadBatches.SETRANGE(LectLoadBatches."Semester Code", SemesterFilter);
                    IF LectLoadBatches.FIND('-') THEN BEGIN
                        LectLoadBatches.Status := LectLoadBatches.Status::Final;
                        LectLoadBatches.MODIFY;
                    END;
                end;
            }
            action(PrinAppointment)
            {
                Caption = 'Print Appointment Letter';
                Image = PrintAcknowledgement;
                Promoted = true;
                PromotedIsBig = true;
                //RunObject = Report 65201;
                ShortCutKey = 'F5';
                ApplicationArea = All;

                trigger OnAction()
                var
                    counted: Integer;
                    LectLoadBatchLines: Record 65201;
                begin
                    LectLoadBatchLines.RESET;
                    LectLoadBatchLines.SETRANGE("Semester Code", Rec."Semester Code");
                    LectLoadBatchLines.SETRANGE("Lecturer Code", Rec."Lecturer Code");
                    IF LectLoadBatchLines.FIND('-') THEN BEGIN
                        IF Rec.Approve THEN
                            REPORT.RUN(65201, TRUE, FALSE, LectLoadBatchLines);
                    END;
                end;
            }
            action(CourseLoad)
            {
                Caption = 'Course Loading Summary';
                Image = PrintAcknowledgement;
                Promoted = true;
                PromotedIsBig = true;
                ShortCutKey = 'F5';
                ApplicationArea = All;

                trigger OnAction()
                var
                    counted: Integer;
                    LectLoadBatchLines: Record 65201;
                begin
                    LectLoadBatchLines.RESET;
                    LectLoadBatchLines.SETRANGE("Semester Code", Rec."Semester Code");
                    //LectLoadBatchLines.SETRANGE("Lecturer Code",Rec."Lecturer Code");
                    IF LectLoadBatchLines.FIND('-') THEN BEGIN
                        REPORT.RUN(69270, TRUE, FALSE, LectLoadBatchLines);
                    END;
                end;
            }
            action(ClassList)
            {
                Caption = 'Class List';
                Image = List;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;
                // RunObject = Report 65208;
            }
            action(AttendanceList)
            {
                Caption = 'Attendance List';
                Image = ListPage;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ACALecturersUnits: Record 65202;
                begin
                    ACALecturersUnits.RESET;
                    ACALecturersUnits.SETRANGE(Semester, Rec."Semester Code");
                    ACALecturersUnits.SETRANGE(Lecturer, Rec."Lecturer Code");
                    IF ACALecturersUnits.FIND('-') THEN BEGIN
                        REPORT.RUN(65207, TRUE, FALSE, ACALecturersUnits);
                    END;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.SETFILTER("Semester Code", '=%1', SemesterFilter);
    end;

    trigger OnOpenPage()
    begin
        //Rec.SETFILTER("Batch Date",'=%1',DateFilter);
        ACASemesters.RESET;
        ACASemesters.SETRANGE("Current Semester", TRUE);
        IF ACASemesters.FIND('-') THEN
            SemesterFilter := ACASemesters.Code;
    end;

    var
        Customer1: Record 18;
        lineNo: Integer;
        SemesterFilter: Code[20];
        ACASemesters: Record 61692;
        LectLoadBatches: Record 65200;
        NextOderNo: Code[20];



}

