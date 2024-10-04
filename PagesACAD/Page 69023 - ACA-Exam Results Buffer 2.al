page 69023 "ACA-Exam Results Buffer 2"
{
    DeleteAllowed = true;
    PageType = List;
    SourceTable = "ACA-Exam Results Buffer 2";
    SourceTableView = WHERE("Course Reg. Created" = FILTER(False),
                            "Units Reg. Created" = FILTER(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No."; Rec."Student No.")
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
                field("Unit Code"; Rec."Unit Code")
                {
                    ApplicationArea = All;
                }
                field("CAT Score"; Rec."CAT Score")
                {
                    ApplicationArea = All;
                }
                field("Exam Score"; Rec."Exam Score")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("User Name"; Rec."User Name")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Stage; Rec.Stage)
                {
                    //Editable = false;
                    ApplicationArea = All;
                }
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                }
                field("Unit Name"; Rec."Unit Name")
                {
                    //Editable = false;
                    ApplicationArea = All;
                }
                field(Exam; Rec.Exam)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                }
                field("Failure Reason"; Rec."Failure Reason")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Units Reg. Created"; Rec."Units Reg. Created")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Course Reg. Created"; Rec."Course Reg. Created")
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


            action(PostMks)
            {
                Caption = 'Post Marks';
                Image = ViewCheck;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Progzz: Dialog;
                    Stages: Code[20];
                    Semesters: Code[20];
                    ACAExamResultsBuffer2: Record 61746;
                    acadsYear: Code[20];
                    ACACourseRegistration15: Record 61532;
                    ACAStudentUnits: Record 61549;
                    ACASemesters: Record 61692;
                begin
                    IF CONFIRM('Post imported Marks?', TRUE) = FALSE THEN ERROR('Cancelled by ' + USERID + '!');
                    Progzz.OPEN('#1#######################################################\' +
                    '#2#######################################################\' +
                    '#3#######################################################');
                    ExamBuff2.RESET;
                    ExamBuff2.SETRANGE("User Name", USERID);
                    ExamBuff2.SETRANGE("Course Reg. Created", TRUE);
                    ExamBuff2.SETRANGE("Units Reg. Created", TRUE);
                    IF ExamBuff2.FIND('-') THEN ExamBuff2.DELETEALL;

                    ExamBuff2.RESET;
                    ExamBuff2.SETRANGE("User Name", USERID);
                    ExamBuff2.SETRANGE("Course Reg. Created", FALSE);
                    ExamBuff2.SETRANGE("Units Reg. Created", FALSE);
                    IF NOT ExamBuff2.FIND('-') THEN ERROR('Nothing to Post!');
                    BEGIN
                        REPEAT
                        BEGIN
                            Progzz.UPDATE(1, ExamBuff2."Student No.");
                            Progzz.UPDATE(2, ExamBuff2."Student Name");
                            Progzz.UPDATE(3, ExamBuff2."Unit Code");
                            CLEAR(errorReason);
                            CLEAR(yos);
                            CLEAR(Stages);
                            CLEAR(Semesters);
                            Stages := GetUnitStage(ExamBuff2."Unit Code", ExamBuff2.Programme);
                            Semesters := GetSemester(ExamBuff2."Student No.", ExamBuff2."Unit Code", ExamBuff2.Programme);
                            ;
                            ACACourseRegistration15.RESET;
                            ACACourseRegistration15.SETRANGE("Student No.", ExamBuff2."Student No.");
                            ACACourseRegistration15.SETRANGE(Semester, ExamBuff2.Semester);
                            IF ACACourseRegistration15.FIND('-') THEN BEGIN

                            END;
                            IF Stages = '' THEN Stages := ACACourseRegistration15.Stage;
                            IF Semesters = '' THEN Semesters := ExamBuff2.Semester;
                            IF Stages <> '' THEN BEGIN
                                IF EVALUATE(yos, COPYSTR(Stages, 2, 1)) THEN;
                            END ELSE BEGIN
                                errorReason := errorReason + 'Unit Stage is Missing;'
                            END;
                            IF yos = 0 THEN errorReason := errorReason + 'Invalid Stage:' + Stages + ' hence invalid Year of Study';


                            ExamBuff2."Unit Name" := (GetUnitName(ExamBuff2."Unit Code", ExamBuff2.Programme));

                            //ExamBuff2.Semester:=Semesters;
                            CLEAR(acadsYear);
                            acadsYear := ExamBuff2."Academic Year";
                            ACAStudentUnits.RESET;
                            ACAStudentUnits.SETRANGE("Student No.", ExamBuff2."Student No.");
                            ACAStudentUnits.SETRANGE(Unit, ExamBuff2."Unit Code");
                            IF NOT ACAStudentUnits.FIND('-') THEN BEGIN
                                //Register The Unit
                                ACAStudentUnits.INIT;
                                ACAStudentUnits.Programme := ExamBuff2.Programme;
                                ACAStudentUnits.Stage := Stages;
                                ACAStudentUnits.Unit := ExamBuff2."Unit Code";
                                ACAStudentUnits.Semester := ExamBuff2.Semester;
                                ACAStudentUnits."Reg. Transacton ID" := ACACourseRegistration15."Reg. Transacton ID";
                                ACAStudentUnits."Student No." := ExamBuff2."Student No.";
                                ACASemesters.RESET;
                                ACASemesters.SETRANGE(Code, ExamBuff2.Semester);
                                IF ACASemesters.FIND('-') THEN
                                    ACAStudentUnits."Academic Year" := ACASemesters."Academic Year";
                                IF ACAStudentUnits.INSERT THEN;
                            END;
                            //GetAcademicYear(ExamBuff2."Student No.",ExamBuff2.Programme,Semesters);
                            // //  IF (GetSemester(yos,ExamBuff2."Student No.",ExamBuff2."Unit Code",
                            // //    ExamBuff2.Programme)) = '' THEN   errorReason:=errorReason+'Not Registered;' ELSE BEGIN
                            // Student No.,Academic Year,Semester,Programme,Unit Code,Stage,Intake,Exam Session
                            IF ExamBuff2.RENAME(
                        ExamBuff2."Student No.", acadsYear,
                        Semesters, ExamBuff2.Programme,
                        ExamBuff2."Unit Code", Stages,
                        ExamBuff2.Intake, ExamBuff2."Exam Session") THEN
                                ;
                            // //    END;
                            // //  END;

                            CLEAR(failed);
                            // Check if student Exists
                            IF Rec.Semester = '' THEN BEGIN
                                failed := TRUE;
                                IF errorReason = '' THEN
                                    errorReason := ' No Registered Semester.;'
                                ELSE
                                    errorReason := errorReason + ' No Registered Semester.;'
                            END;

                            IF ExamBuff2.Programme = '' THEN BEGIN
                                failed := TRUE;
                                IF errorReason = '' THEN
                                    errorReason := 'No Prog.;'
                                ELSE
                                    errorReason := errorReason + 'No Prog.;'
                            END;

                            IF ExamBuff2."Unit Code" = '' THEN BEGIN
                                failed := TRUE;
                                IF errorReason = '' THEN
                                    errorReason := 'No Unit;'
                                ELSE
                                    errorReason := errorReason + 'No Unit;'
                            END;

                            IF errorReason <> '' THEN failed := TRUE;
                            //IF errorReason='' THEN BEGIN
                            cust.RESET;
                            cust.SETRANGE(cust."No.", ExamBuff2."Student No.");
                            IF cust.FIND('-') THEN BEGIN
                                progs.RESET;
                                progs.SETRANGE(progs.Code, ExamBuff2.Programme);
                                IF progs.FIND('-') THEN BEGIN
                                    // Check if the stage exists
                                    IF Stages <> '' THEN BEGIN
                                        units.RESET;
                                        units.SETRANGE(units."Programme Code", ExamBuff2.Programme);
                                        units.SETRANGE(units.Code, ExamBuff2."Unit Code");
                                        IF units.FIND('-') THEN BEGIN
                                            // Check if Course Reg Exists and Register Unit
                                            // // // //  IF CourseRegANDUnits(ExamBuff2."Student No.",ExamBuff2.Programme,
                                            // // // //  ExamBuff2.Semester,ExamBuff2."Academic Year",
                                            // // // //  ExamBuff2."Unit Code",Stages) THEN BEGIN
                                            PostExamz(
                                           ExamBuff2.Programme, Stages, ExamBuff2."Unit Code",
                                           Semesters, 'EXAM',
                                           ExamBuff2."Exam Score", ExamBuff2."CAT Score",
                                            ExamBuff2."Student No.", acadsYear
                                           );
                                            // // // // END ELSE
                                            // // // // IF errorReason='' THEN
                                            // // // // errorReason:='Unit:'+ExamBuff2."Unit Code"+' not registered '
                                            // // // // ELSE errorReason:=errorReason+'Unit:'+ExamBuff2."Unit Code"+' not registered ';
                                            // // // // END;
                                        END ELSE BEGIN
                                            failed := TRUE;
                                            IF errorReason = '' THEN
                                                errorReason := 'Unit Registration Missing'
                                            ELSE
                                                errorReason := errorReason + ' Unit Registration Missing'
                                        END;
                                    END ELSE BEGIN // end for Prog Stages
                                        failed := TRUE;
                                        IF errorReason = '' THEN
                                            errorReason := 'Stage ''' + Stages + '''Missing'
                                        ELSE
                                            errorReason := errorReason + 'Stage ''' + Stages + '''Missing'
                                    END;// end for Prog Stages


                                END ELSE BEGIN // end for programme
                                    failed := TRUE;
                                    errorReason := errorReason + 'Programme ''' + ExamBuff2.Programme + '''Missing';
                                END; // end for programme

                            END // end for cust
                            ELSE BEGIN
                                failed := TRUE;
                                errorReason := errorReason + 'Student No.:  ''' + ExamBuff2."Student No." + ': ' + ExamBuff2."Student Name" + '''  Missing';
                            END;// end for cust

                            IF failed = FALSE THEN BEGIN
                                ExamBuff2."Course Reg. Created" := TRUE;
                                ExamBuff2."Units Reg. Created" := TRUE;
                                ExamBuff2."Failure Reason" := '';

                                ExamBuff2.MODIFY;
                            END ELSE BEGIN
                                ExamBuff2."Course Reg. Created" := FALSE;
                                ExamBuff2."Units Reg. Created" := FALSE;
                                ExamBuff2."Failure Reason" := errorReason;
                                ExamBuff2.MODIFY;
                            END;
                            ExamBuff2.MODIFY;
                        END;
                        UNTIL ExamBuff2.NEXT = 0;
                    END;
                    Progzz.CLOSE;
                    MESSAGE('Posted!');
                end;
            }
            action(TestPost)
            {
                Caption = 'Test Post Marks';
                Image = ViewCheck;
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                begin

                    REPORT.RUN(Report::"Exam Buffer Processing", FALSE, FALSE);

                end;
            }
            action("My Uploads")
            {
                Image = UpdateUnitCost;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "ACA-My Uploaded Marks";
                ApplicationArea = All;
            }
            action("Import Marks")
            {
                Image = UpdateXML;
                ApplicationArea = All;
                RunObject = xmlport "Import Buffer marks";
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        HRMEmployeeC: Record "HRM-Employee (D)";
    begin
        Rec.SETFILTER("User Name", USERID);
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        IF UserSetup.FIND('-') THEN BEGIN
            // IF UserSetup."Employee No."='' THEN ERROR('Access Denied!');
            // HRMEmployeeC.RESET;
            //HRMEmployeeC.SETRANGE("No.",UserSetup."Employee No.");
            // IF NOT HRMEmployeeC.FIND('-') THEN  ERROR('Access Denied!');
            // IF NOT  HRMEmployeeC."Is HOD" THEN ERROR('Access Denied!');
            // END ELSE ERROR('Access Denied!');
        END;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."User Name" := USERID;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."User Name" := USERID;
    end;

    trigger OnOpenPage()
    var
        HRMEmployeeC: Record "HRM-Employee (D)";
    begin
        Rec.SETFILTER("User Name", USERID);
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        /*IF UserSetup.FIND('-') THEN BEGIN
         IF UserSetup."Employee No."='' THEN ERROR('Access Denied!'); HRMEmployeeC.RESET;
         HRMEmployeeC.SETRANGE("No.",UserSetup."Employee No.");
         IF NOT HRMEmployeeC.FIND('-') THEN  ERROR('Access Denied!');
        IF NOT  HRMEmployeeC."Is HOD" THEN ERROR('Access Denied!');
        END ELSE ERROR('Access Denied!');*/

    end;

    var
        UserSetup: Record "User Setup";
        ACAUnitsSubjects: Record "ACA-Units/Subjects";
        failed: Boolean;
        errorReason: Code[250];
        courseReg: Record "ACA-Course Registration";
        unitsReg: Record "ACA-Student Units";
        ProgStages: Record "ACA-Programme Stages";
        units: Record "ACA-Units/Subjects";
        progs: Record "ACA-Programme";
        examResults: Record "ACA-Exam Results";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenSetup: Record "ACA-General Set-Up";
        cust: Record Customer;
        progress: Dialog;
        ACACourseRegistration: Record "ACA-Course Registration";
        ExamBuff2: Record "ACA-Exam Results Buffer 2";
        yos: Integer;

    procedure CourseRegANDUnits(StudNos: Code[50]; Progys: Code[50]; Semz: Code[50]; AcadYear: Code[50]; UnitzCode: Code[50]; stagez: Code[50]) UnitCreated: Boolean
    var
        RegTransID: Code[20];
        ACAUnitsSubjects: Record "ACA-Units/Subjects";
        coreg2: Record "ACA-Course Registration";
        courseReg: Record "ACA-Course Registration";
        unitsReg: Record "ACA-Student Units";
        ACASemesters: Record "ACA-Semesters";
    begin
        CLEAR(RegTransID);
        CLEAR(UnitCreated);
        unitsReg.RESET;
        unitsReg.SETRANGE(unitsReg.Unit, UnitzCode);
        unitsReg.SETRANGE(unitsReg."Student No.", StudNos);
        IF NOT unitsReg.FIND('-') THEN BEGIN
            ACAUnitsSubjects.RESET;
            ACAUnitsSubjects.SETRANGE("Programme Code", Progys);
            ACAUnitsSubjects.SETRANGE(Code, UnitzCode);
            IF ACAUnitsSubjects.FIND('-') THEN BEGIN
                unitsReg.INIT;
                unitsReg.Programme := Progys;
                unitsReg.VALIDATE(Stage, stagez);
                unitsReg.Unit := UnitzCode;
                unitsReg.Semester := Semz;
                unitsReg.Units := ACAUnitsSubjects."Credit Hours";
                unitsReg."Credit Hours" := ACAUnitsSubjects."Credit Hours";
                // unitsReg."Reg. Transacton ID":=RegTransID;
                unitsReg."Student No." := StudNos;
                ACASemesters.RESET;
                ACASemesters.SETRANGE(Code, Semz);
                IF ACASemesters.FIND('-') THEN
                    unitsReg."Academic Year" := ACASemesters."Academic Year";
                unitsReg.Taken := TRUE;
                unitsReg.INSERT;
                UnitCreated := TRUE;
            END;
        END ELSE
            UnitCreated := TRUE;
    end;

    procedure CreateUnit(Progys: Code[50]; UnitzCode: Code[50]; stages: Code[50]; UnitName: Text[250])
    var
        unitsLis: Record 61517;
    begin
        /*unitsLis.RESET;
        unitsLis.SETRANGE(unitsLis.Code,UnitzCode);
        unitsLis.SETRANGE(unitsLis."Programme Code",Progys);
        unitsLis.SETRANGE(unitsLis."Stage Code",stages);
        IF NOT unitsLis.FIND('-') THEN BEGIN
        unitsLis.INIT;
        unitsLis.Code:=UnitzCode;
        unitsLis."Programme Code" :=Progys;
        unitsLis."Stage Code":=stages;
        unitsLis.Desription :=UnitName;
        unitsLis."Credit Hours":=3;
        unitsLis."No. Units":=3;
        unitsLis.INSERT;
        END;*/

    end;

    procedure PostExamz(Progy: Code[50]; stagezzzz: Code[50]; unitcode: Code[50]; semez: Code[50]; examz: Code[50]; ExamMarks: Decimal; CatMarks: Decimal; studNo: Code[50]; AcadYear: Code[20])
    var
        examRes: Record "ACA-Exam Results";
        coreg: Record "ACA-Course Registration";
        RegTransID: Code[20];
    begin
        CLEAR(RegTransID);
        RegTransID := GetRegTransactionID(studNo, Progy, semez);
        examRes.RESET;
        examRes.SETRANGE(examRes."Student No.", studNo);
        examRes.SETRANGE(examRes.Programmes, Progy);
        examRes.SETRANGE(examRes.Unit, unitcode);
        // // examRes.SETRANGE(examRes.Semester,semez);
        examRes.SETFILTER(examRes.ExamType, '%1|%2|%3|%4', 'FINAL EXAM', 'FINAL', 'EXAM', 'EXAMS');
        IF examRes.FIND('-') THEN BEGIN
            IF ExamMarks <> 0 THEN BEGIN
                examRes.DELETEALL;
                examRes.INIT;
                examRes."Student No." := studNo;
                examRes.Programmes := Progy;
                examRes.Stage := stagezzzz;
                examRes.Unit := unitcode;
                examRes.Semester := semez;
                examRes."User Name" := USERID;
                examRes.ExamType := 'FINAL EXAM';
                examRes."Reg. Transaction ID" := RegTransID;
                examRes.VALIDATE(Score, ExamMarks);
                examRes.Exam := 'FINAL EXAM';
                examRes."Admission No" := studNo;
                examRes."Academic Year" := AcadYear;
                examRes.INSERT;
            END;
        END ELSE BEGIN
            examRes.INIT;
            examRes."Student No." := studNo;
            examRes.Programmes := Progy;
            examRes.Stage := stagezzzz;
            examRes.Unit := unitcode;
            examRes.Semester := semez;
            examRes."User Name" := USERID;
            examRes.ExamType := 'FINAL EXAM';
            examRes."Reg. Transaction ID" := RegTransID;
            examRes.VALIDATE(Score, ExamMarks);
            examRes.Exam := 'FINAL EXAM';
            examRes."Admission No" := studNo;
            examRes."Academic Year" := AcadYear;
            examRes.INSERT;
        END;


        examRes.RESET;
        examRes.SETRANGE(examRes."Student No.", studNo);
        examRes.SETRANGE(examRes.Programmes, Progy);
        examRes.SETRANGE(examRes.Unit, unitcode);
        //examRes.SETRANGE(examRes.Semester,semez);
        examRes.SETFILTER(examRes.ExamType, '%1|%2|%3|%4', 'CAT', 'CATS', 'ASSIGNMENT', 'ASS');
        IF examRes.FIND('-') THEN BEGIN
            IF CatMarks <> 0 THEN BEGIN
                examRes.DELETEALL;
                examRes.INIT;
                examRes."Student No." := studNo;
                examRes.Programmes := Progy;
                examRes.Stage := stagezzzz;
                examRes.Unit := unitcode;
                examRes.Semester := semez;
                examRes."User Name" := USERID;
                examRes.ExamType := 'CAT';
                examRes."Reg. Transaction ID" := RegTransID;
                examRes.VALIDATE(Score, CatMarks);
                examRes.Exam := 'CAT';
                examRes."Admission No" := studNo;
                examRes."Academic Year" := AcadYear;
                examRes.INSERT;
            END;
        END ELSE BEGIN
            examRes.INIT;
            examRes."Student No." := studNo;
            examRes.Programmes := Progy;
            examRes.Stage := stagezzzz;
            examRes.Unit := unitcode;
            examRes.Semester := semez;
            examRes."User Name" := USERID;
            examRes.ExamType := 'CAT';
            examRes."Reg. Transaction ID" := RegTransID;
            examRes.VALIDATE(Score, CatMarks);
            examRes.Exam := 'CAT';
            examRes."Admission No" := studNo;
            examRes."Academic Year" := AcadYear;
            examRes.INSERT;
        END;
    end;

    local procedure GetSemester(StudNo: Code[20]; UnitCode: Code[20]; Prog: Code[20]) Semz: Code[20]
    var
        ACAUnitsSubjectsqqq: Record "ACA-Units/Subjects";
        ACAStudentUnits333: Record "ACA-Student Units";
        ACACourseRegistration333: Record "ACA-Course Registration";
        ACAStudentUnits3334: Record "ACA-Student Units";
    begin
        CLEAR(Semz);
        ACAUnitsSubjects.RESET;
        ACAUnitsSubjects.SETRANGE(Code, UnitCode);
        ACAUnitsSubjects.SETRANGE("Programme Code", Prog);
        IF ACAUnitsSubjects.FIND('-') THEN BEGIN
            ACACourseRegistration.RESET;
            ACACourseRegistration.SETRANGE(ACACourseRegistration."Student No.", StudNo);
            ACACourseRegistration.SETFILTER(ACACourseRegistration.Semester, '<>%1', '');
            ACACourseRegistration.SETRANGE(ACACourseRegistration.Programmes, Prog);
            ACACourseRegistration.SETRANGE(ACACourseRegistration.Stage, ACAUnitsSubjects."Stage Code");
            ACACourseRegistration.SETFILTER(Reversed, '=%1', FALSE);
            IF ACACourseRegistration.FIND('+') THEN BEGIN
                Semz := ACACourseRegistration.Semester;
            END;
        END;
        ACAStudentUnits333.RESET;
        ACAStudentUnits333.SETRANGE("Student No.", StudNo);
        ACAStudentUnits333.SETRANGE(Unit, UnitCode);
        ACAStudentUnits333.SETFILTER("Reg Reversed", '%1', FALSE);
        ACAStudentUnits333.SETFILTER(Semester, '<>%1', '');
        ACAStudentUnits333.SETCURRENTKEY(Semester);
        IF ACAStudentUnits333.FIND('-') THEN BEGIN
            IF Semz = '' THEN BEGIN
                Semz := ACAStudentUnits333.Semester;
                ACAStudentUnits3334.RESET;
                ACAStudentUnits3334.SETRANGE("Student No.", StudNo);
                ACAStudentUnits3334.SETRANGE(Unit, UnitCode);
                ACAStudentUnits3334.SETFILTER("Reg Reversed", '%1', FALSE);
                ACAStudentUnits3334.SETFILTER(Semester, '<>%1', Semz);
                IF ACAStudentUnits3334.FIND('-') THEN ACAStudentUnits3334.DELETEALL;
            END ELSE BEGIN
                //Delete and Recreate Unit ACAUnitsSubjects

                ACAStudentUnits3334.RESET;
                ACAStudentUnits3334.SETRANGE("Student No.", StudNo);
                ACAStudentUnits3334.SETRANGE(Unit, UnitCode);
                ACAStudentUnits3334.SETFILTER("Reg Reversed", '%1', FALSE);
                IF ACAStudentUnits3334.FIND('-') THEN ACAStudentUnits3334.DELETEALL;
                ACAUnitsSubjectsqqq.RESET;
                ACAUnitsSubjectsqqq.SETRANGE(Code, UnitCode);
                ACAUnitsSubjectsqqq.SETRANGE("Programme Code", Prog);
                IF ACAUnitsSubjectsqqq.FIND('-') THEN BEGIN
                    ACAStudentUnits3334.INIT;
                    ACAStudentUnits3334."Student No." := StudNo;
                    ACAStudentUnits3334.Programme := Prog;
                    ACAStudentUnits3334.Stage := ACAUnitsSubjectsqqq."Stage Code";
                    ACAStudentUnits3334.Semester := Semz;
                    ACAStudentUnits3334."Reg. Transacton ID" := ACACourseRegistration."Reg. Transacton ID";
                    ACAStudentUnits3334.VALIDATE(ACAStudentUnits3334.Unit, UnitCode);
                    ACAStudentUnits3334.VALIDATE(ACAStudentUnits3334."Credit Hours", ACAUnitsSubjectsqqq."Credit Hours");
                    ACAStudentUnits3334.INSERT;
                END;
            END;
        END ELSE BEGIN
            // Get Unit Stage
            ACACourseRegistration.RESET;
            ACACourseRegistration.SETRANGE("Student No.", StudNo);
            ACACourseRegistration.SETFILTER(Semester, '<>%1', '');
            ACACourseRegistration.SETRANGE(Programmes, Prog);
            ACACourseRegistration.SETFILTER(Reversed, '=%1', FALSE);
            ACACourseRegistration.SETFILTER(Stage, '=%1', ACAUnitsSubjects."Stage Code");
            IF ACACourseRegistration.FIND('+') THEN BEGIN
                ACAUnitsSubjects.RESET;
                ACAUnitsSubjects.SETRANGE(Code, UnitCode);
                ACAUnitsSubjects.SETRANGE("Programme Code", Prog);
                IF ACAUnitsSubjects.FIND('-') THEN BEGIN
                    ACAStudentUnits3334.INIT;
                    ACAStudentUnits3334."Student No." := StudNo;
                    ACAStudentUnits3334.Programme := Prog;
                    ACAStudentUnits3334.Stage := ACACourseRegistration.Stage;
                    ACAStudentUnits3334.Semester := ACACourseRegistration.Semester;
                    ACAStudentUnits3334."Reg. Transacton ID" := ACACourseRegistration."Reg. Transacton ID";
                    ACAStudentUnits3334.VALIDATE(ACAStudentUnits3334.Unit, UnitCode);
                    ACAStudentUnits3334.VALIDATE(ACAStudentUnits3334."Credit Hours", ACAUnitsSubjects."Credit Hours");
                    ACAStudentUnits3334.INSERT;
                    IF ACACourseRegistration.Semester <> '' THEN Semz := ACACourseRegistration.Semester;
                END;
            END;
        END;
        // // //
        // // // ACAUnitsSubjects.RESET;
        // // // ACAUnitsSubjects.SETRANGE(Code,UnitCode);
        // // // ACAUnitsSubjects.SETRANGE("Programme Code",Prog);
        // // // IF ACAUnitsSubjects.FIND('-') THEN BEGIN
        // // //    ACACourseRegistration.RESET;
        // // //   ACACourseRegistration.SETRANGE("Student No.",StudNo);
        // // //   ACACourseRegistration.SETRANGE(Stage,ACAUnitsSubjects."Stage Code");
        // // //   ACACourseRegistration.SETRANGE(Programme,Prog);
        // // //   ACACourseRegistration.SETFILTER(Reversed,'=%1',FALSE);
        // // //   IF ACACourseRegistration.FIND('-') THEN BEGIN
        // // //     IF ACACourseRegistration.Semester<>'' THEN Semz:=ACACourseRegistration.Semester;
        // // //     END ELSE BEGIN
        // // //           ACACourseRegistration.RESET;
        // // //   ACACourseRegistration.SETRANGE("Student No.",StudNo);
        // // //   ACACourseRegistration.SETRANGE(Programme,Prog);
        // // //   ACACourseRegistration.SETFILTER(Reversed,'=%1',FALSE);
        // // //   IF ACACourseRegistration.FIND('+') THEN BEGIN
        // // //      IF ACACourseRegistration.Semester<>'' THEN Semz:=ACACourseRegistration.Semester;
        // // //     END;
        // // //       END;
        // // //
        // // //  END;
        // //  IF Semz='' THEN BEGIN
        // //
        // //    ACACourseRegistration.RESET;
        // //   ACACourseRegistration.SETRANGE("Student No.",StudNo);
        // //   ACACourseRegistration.SETRANGE(Programme,Prog);
        // //   ACACourseRegistration.SETFILTER(Reversed,'=%1',FALSE);
        // //   IF ACACourseRegistration.FIND('+') THEN BEGIN
        // //      IF ACACourseRegistration.Semester<>'' THEN Semz:=ACACourseRegistration.Semester;
        // //    END;
        // //    END;
    end;

    local procedure GetUnitStage(UnitCodezz: Code[20]; Progzz: Code[20]) StageCode: Code[20]
    begin
        ACAUnitsSubjects.RESET;
        ACAUnitsSubjects.SETRANGE(Code, UnitCodezz);
        ACAUnitsSubjects.SETRANGE("Programme Code", Progzz);
        IF ACAUnitsSubjects.FIND('-') THEN BEGIN
            StageCode := ACAUnitsSubjects."Stage Code";
        END;
    end;

    local procedure GetUnitName(UnitCode: Code[20]; Prog: Code[20]) UntName: Code[150]
    begin
        ACAUnitsSubjects.RESET;
        ACAUnitsSubjects.SETRANGE(Code, UnitCode);
        ACAUnitsSubjects.SETRANGE("Programme Code", Prog);
        IF ACAUnitsSubjects.FIND('-') THEN BEGIN
            UntName := ACAUnitsSubjects.Desription;
        END;
    end;

    local procedure GetAcademicYear(StudNo: Code[20]; Prog: Code[20]; Semesterz: Code[20]) AcadYrz: Code[20]
    var

        ACAStudentUnits333: Record "ACA-Student Units";
        ACACourseRegistration333: Record "ACA-Course Registration";
        ACAStudentUnits3334: Record "ACA-Student Units";
    begin
        CLEAR(AcadYrz);
        ACACourseRegistration.RESET;
        ACACourseRegistration.SETRANGE("Student No.", StudNo);
        ACACourseRegistration.SETFILTER(Semester, '%1', Semesterz);
        ACACourseRegistration.SETRANGE(Programmes, Prog);
        ACACourseRegistration.SETFILTER(Reversed, '=%1', FALSE);
        IF ACACourseRegistration.FIND('+') THEN BEGIN
            AcadYrz := ACACourseRegistration."Academic Year";
        END;
    end;

    local procedure GetRegTransactionID(StudNo: Code[20]; Prog: Code[20]; Semesterz: Code[20]) RegTransID: Code[20]
    var
        ACAStudentUnits333: Record "ACA-Student Units";
        ACACourseRegistration333: Record "ACA-Course Registration";
        ACAStudentUnits3334: Record "ACA-Student Units";
    begin
        CLEAR(RegTransID);
        ACACourseRegistration.RESET;
        ACACourseRegistration.SETRANGE("Student No.", StudNo);
        ACACourseRegistration.SETFILTER(Semester, '%1', Semesterz);
        ACACourseRegistration.SETRANGE(Programmes, Prog);
        ACACourseRegistration.SETFILTER(Reversed, '=%1', FALSE);
        IF ACACourseRegistration.FIND('+') THEN BEGIN
            RegTransID := ACACourseRegistration."Reg. Transacton ID";
        END;
    end;
}

