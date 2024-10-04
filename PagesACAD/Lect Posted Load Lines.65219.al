page 65219 "Lect Posted Load Lines"
{
    AutoSplitKey = false;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = 65201;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                FreezeColumn = "Courses Count";
                field("Lecturer Code"; Rec."Lecturer Code")
                {
                    ApplicationArea = All;
                }
                field("Lecturer Name"; Rec."Lecturer Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Phone; Rec.Phone)
                {
                    ApplicationArea = All;
                }
                field("Courses Count"; Rec."Courses Count")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Approve; Rec.Approve)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Reject; Rec.Reject)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Reject Reason"; Rec."Reject Reason")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Appointment Later Ref. No."; Rec."Appointment Later Ref. No.")
                {
                    ApplicationArea = All;
                }
                field("Appointment Later Ref."; Rec."Appointment Later Ref.")
                {
                    ApplicationArea = All;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(cancelLoad)
            {
                Caption = 'Cancel the Load';
                Image = CancelAllLines;
                
                
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF Rec.Approve THEN ERROR('The Load is already approved!');
                    IF CONFIRM('Cancel the Load for ' + Rec."Lecturer Code" + '?', FALSE) = FALSE THEN EXIT;

                    LectLoadCustProdSource.RESET;
                    LectLoadCustProdSource.SETRANGE(LectLoadCustProdSource.Lecturer, Rec."Semester Code");
                    LectLoadCustProdSource.SETRANGE(LectLoadCustProdSource.Programme, Rec."Lecturer Code");
                    IF LectLoadCustProdSource.FIND('-') THEN BEGIN
                        LectLoadCustProdSource.DELETEALL;
                    END;

                    MESSAGE('The Load details have been deleted.');
                end;
            }
            action(PrinAppointment)
            {
                Caption = 'Print Appointment Letter';
                Image = PrintAcknowledgement;
                
                
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
                
                
                ApplicationArea = All;
                // RunObject = Report 65208;
            }
            action(AttendanceList)
            {
                Caption = 'Attendance List';
                Image = ListPage;
                
                
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

    var
        LectLoadCustProdSource: Record 65202;
}

