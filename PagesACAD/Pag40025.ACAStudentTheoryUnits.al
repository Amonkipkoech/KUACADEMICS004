page 40025 "ACA-Student Theory Units"
{
    Caption = 'ACA-Student Theory Units';
    PageType = List;
    SourceTable = "ACA-Student Theory Units ";
    SourceTableView = SORTING(Stage)
                      ORDER(Ascending);
    //Editable = false;

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Unit; Rec.Unit)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field(ModeOfStudy; Rec.ModeOfStudy)
                {
                    ApplicationArea = All;
                }
                // field(notDuplicate; Rec.notDuplicate)
                // {
                //     ApplicationArea = All;
                // }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Date created"; Rec."Date created")
                {
                    ApplicationArea = All;

                }
                field("Date Edited"; Rec."Date Edited")
                {
                    ApplicationArea = All;
                }
                field("Exam Category"; Rec."Exam Category")
                {

                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Academic Year (Flow)"; Rec."Academic Year (Flow)")
                {
                    ApplicationArea = All;
                }
                field(LectureHall; Rec.LectureHall)
                {
                    ApplicationArea = All;
                }
                field(Lecturer; Rec.Lecturer)
                {
                    ApplicationArea = All;
                }
                field(Stream; Rec.Stream)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stream field.';
                    //Editable = false;
                }
                field(Day; Rec.Day)
                {
                    ApplicationArea = All;
                }
                field(TimeSlot; Rec.TimeSlot)
                {
                    ApplicationArea = All;
                }
                field("Special Exam"; Rec."Special Exam")
                {
                    ApplicationArea = All;
                }
                field("Reason for Special Exam/Susp."; Rec."Reason for Special Exam/Susp.")
                {
                    ApplicationArea = All;
                }
                field("Reg. Transacton ID"; Rec."Reg. Transacton ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Register for"; Rec."Register for")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit Type"; Rec."Unit Type")
                {
                    ApplicationArea = All;
                }

                field(Taken; Rec.Taken)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //IF xRec.Taken=FALSE THEN
                        //ERROR('The Course must be marked Taken!');
                        IF Rec.Taken = TRUE THEN BEGIN
                            UnitsS.RESET;
                            //UnitsS.SETRANGE(UnitsS."Programme Code",Programme);
                            //UnitsS.SETRANGE(UnitsS."Stage Code",Stage);
                            UnitsS.SETRANGE(UnitsS.Code, Rec.Unit);
                            IF UnitsS.FIND('-') THEN BEGIN
                                Desc := UnitsS.Desription;
                                UnitStage := UnitsS."Stage Code";
                            END ELSE
                                Desc := '';
                        END;
                    end;
                }
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                }
                field("Repeat Unit"; Rec."Repeat Unit")
                {
                    Caption = 'Re-sit';
                    ApplicationArea = All;
                }
                field("Re-Take"; Rec."Re-Take")
                {
                    ApplicationArea = All;
                }
                field("Student Class"; Rec."Student Class")
                {
                    ApplicationArea = All;
                }
                field(UnitStage; UnitStage)
                {
                    Caption = 'Unit Stage';
                    ApplicationArea = All;
                }
                field(Audit; Rec.Audit)
                {
                    ApplicationArea = All;
                }
                field(Exempted; Rec.Exempted)
                {
                    ApplicationArea = All;
                }
                field("Final Score"; Rec."Final Score")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Attendance; Rec.Attendance)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Total Score"; Rec."Total Score")
                {
                    ApplicationArea = All;
                }
                field(Grade; Rec.Grade)
                {
                    Caption = 'Grade';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("CATs Marks Exists"; Rec."CATs Marks Exists")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("EXAMs Marks Exists"; Rec."EXAMs Marks Exists")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Allow Supplementary"; Rec."Allow Supplementary")
                {
                    ApplicationArea = All;
                }
                field("Sat Supplementary"; Rec."Sat Supplementary")
                {
                    ApplicationArea = All;
                }
                // field("Student No."; Rec."Student No.")
                // {
                //     ApplicationArea = All;
                // }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field(Units; Rec.Units)
                {
                    ApplicationArea = All;
                }
                field("Reg Reversed"; Rec."Reg Reversed")
                {
                    ApplicationArea = All;
                }
                field("Supp. Registered & Passed"; Rec."Supp. Registered & Passed")
                {
                    ApplicationArea = All;
                }
                field("No of Supplementaries"; Rec."No of Supplementaries")
                {
                    ApplicationArea = All;
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;
                }
                field(Failed; Rec.Failed)
                {
                    ApplicationArea = All;
                }
                field("Supp. Grade"; Rec."Supp. Grade")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Supp. Failed"; Rec."Supp. Failed")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Year Of Study"; Rec."Year Of Study")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Unit Year of Study"; Rec."Unit Year of Study")
                {
                    ApplicationArea = All;
                }
                field("Unit Type (Flow)"; Rec."Unit Type (Flow)")
                {
                    ApplicationArea = All;
                }
                field("Credit Hours"; Rec."Credit Hours")
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
            action("UnSelect All Units")
            {
                Caption = 'UnSelect All Units';
                Image = SelectLineToApply;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    StudUnits.RESET;
                    StudUnits.SETRANGE(StudUnits."Student No.", Rec."Student No.");
                    StudUnits.SETRANGE(StudUnits.Semester, Rec.Semester);
                    IF StudUnits.FIND('-') THEN BEGIN
                        REPEAT
                            IF StudUnits.Taken = TRUE THEN BEGIN
                                StudUnits.Taken := FALSE;
                                StudUnits.MODIFY;
                            END;
                        UNTIL StudUnits.NEXT = 0;
                    END;
                end;
            }
            action("Delete Untaken Units")
            {
                Caption = 'Delete Untaken Units';
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    StudUnits.RESET;
                    StudUnits.SETRANGE(StudUnits."Student No.", Rec."Student No.");
                    StudUnits.SETRANGE(StudUnits.Semester, Rec.Semester);
                    IF StudUnits.FIND('-') THEN BEGIN
                        REPEAT
                            IF StudUnits.Taken = FALSE THEN
                                StudUnits.DELETE;
                        UNTIL StudUnits.NEXT = 0;
                    END;
                end;
            }
            action(updateNames)
            {
                Image = UpdateShipment;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    updateUnitnames();
                end;
            }
            action("Print Registered Courses")
            {
                Caption = 'Print Registered Courses';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CReg.RESET;
                    CReg.SETFILTER(CReg.Semester, Rec.Semester);
                    CReg.SETFILTER(CReg."Student No.", Rec."Student No.");
                    IF CReg.FIND('-') THEN
                        REPORT.RUN(51517, TRUE, TRUE, CReg);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        status1: Option " ","Both Exists","CAT Only","Exam Only","None Exists";
    begin
        UnitStage := '';

        UnitsS.RESET;
        UnitsS.SETRANGE(UnitsS."Programme Code", Rec.Programme);
        //UnitsS.SETRANGE(UnitsS."Stage Code",Stage);
        UnitsS.SETRANGE(UnitsS.Code, Rec.Unit);
        IF UnitsS.FIND('-') THEN BEGIN
            Desc := UnitsS.Desription;
            UnitStage := UnitsS."Stage Code";
        END ELSE
            Desc := '';

        CLEAR(xxGrade);
        IF ((Rec."EXAMs Marks Exists" = FALSE) OR (Rec."CATs Marks Exists" = FALSE)) THEN BEGIN
            status1 := status1::"CAT Only";
        END ELSE
            IF ((Rec."EXAMs Marks Exists" = TRUE) AND (Rec."CATs Marks Exists" = TRUE)) THEN BEGIN
                status1 := status1::"Both Exists";
            END ELSE
                IF ((Rec."EXAMs Marks Exists" = FALSE) AND (Rec."CATs Marks Exists" = FALSE)) THEN BEGIN
                    status1 := status1::"None Exists";
                END;
        xxGrade := GetGrade(Rec."Total Score", Rec.Unit, Rec.Programme, Rec."Academic Year", status1);
    end;

    var
        UnitsS: Record "ACA-Units/Subjects";
        Desc: Text[250];
        UnitStage: Code[20];
        Prog: Record "ACA-Programme";
        ProgDesc: Text[200];
        CReg: Record "ACA-Course Registration";
        StudUnits: Record "ACA-Student Units";
        xxGrade: Code[20];

    local procedure UnitOnActivate()
    begin
        IF Rec."Reg. Transacton ID" = '' THEN BEGIN
            CReg.RESET;
            CReg.SETRANGE(CReg."Student No.", Rec."Student No.");
            IF CReg.FIND('-') THEN BEGIN
                Rec."Reg. Transacton ID" := CReg."Reg. Transacton ID";
                Rec.Programme := CReg.Programmes;
                Rec.Stage := CReg.Stage;
                Rec.Semester := CReg.Semester;
            END;
        END;

        UnitsS.RESET;
        //UnitsS.SETRANGE(UnitsS."Programme Code",Programme);
        //UnitsS.SETRANGE(UnitsS."Stage Code",Stage);
        UnitsS.SETRANGE(UnitsS.Code, Rec.Unit);
        IF UnitsS.FIND('-') THEN BEGIN
            Desc := UnitsS.Desription;
            UnitStage := UnitsS."Stage Code";
        END ELSE
            Desc := '';
    end;

    procedure GetGrade(EXAMMark: Decimal; UnitG: Code[20]; Proga: Code[20]; AcadYearz: Code[20]; MarksStatus: Option " ","Both Exists","CAT Only","Exam Only","None Exists") xGrade: Text[100]
    var
        UnitsRR: Record "ACA-Units/Subjects";
        ProgrammeRec: Record "ACA-Programme";
        LastGrade: Code[20];
        LastRemark: Code[20];
        ExitDo: Boolean;
        LastScore: Decimal;
        Gradings: Record "ACA-Exam Gradding Setup";
        Gradings2: Record "ACA-Exam Gradding Setup";
        GradeCategory: Code[20];
        GLabel: array[6] of Code[20];
        i: Integer;
        GLabel2: array[6] of Code[100];
        FStatus: Boolean;
        Grd: Code[80];
        Grade: Code[20];
        Marks: Decimal;
        ACAExamGradingSource: Record "ACA-Exam Grading Source";
    begin
        CLEAR(Marks);
        Marks := EXAMMark;
        GradeCategory := '';
        UnitsRR.RESET;
        UnitsRR.SETRANGE(UnitsRR."Programme Code", Proga);
        UnitsRR.SETRANGE(UnitsRR.Code, UnitG);
        //UnitsRR.SETRANGE(UnitsRR."Stage Code","Student Units".Stage);
        IF UnitsRR.FIND('-') THEN BEGIN
            IF UnitsRR."Default Exam Category" <> '' THEN BEGIN
                GradeCategory := UnitsRR."Default Exam Category";
            END ELSE BEGIN
                ProgrammeRec.RESET;
                IF ProgrammeRec.GET(UnitG) THEN
                    GradeCategory := ProgrammeRec."Exam Category";
                IF GradeCategory = '' THEN GradeCategory := 'DEFAULT';
            END;
        END;
        xGrade := '';
        ACAExamGradingSource.RESET;
        ACAExamGradingSource.SETRANGE("Exam Catregory", GradeCategory);
        ACAExamGradingSource.SETRANGE("Academic Year", AcadYearz);
        ACAExamGradingSource.SETRANGE("Total Score", Marks);
        ACAExamGradingSource.SETRANGE("Results Exists Status", MarksStatus);
        IF ACAExamGradingSource.FIND('-') THEN BEGIN
            xGrade := ACAExamGradingSource.Grade;
            // // xGrade:=Gradings.Grade;
            // // IF Gradings.Failed=FALSE THEN
            // // LastRemark:='PASS'
            // // ELSE
            // // LastRemark:='FAIL';
            // // ExitDo:=TRUE;
            // // END;
            // // END;
            // //
            // //
            // // END;
            // //
            // // END ELSE BEGIN
            // // Grade:='';
        END;
    end;

    local procedure updateUnitnames();
    var
        unitsMast: Record "ACA-Units Master Table";
        studUnits: Record "ACA-Student Units";
    begin
        studUnits.Reset();
        studUnits.SetRange(Semester, 'JAN-APR23');
        //studUnits.SetRange("Student No.", '1049724');
        if studUnits.Find('-') then begin
            repeat
                unitsMast.Reset();
                unitsMast.SetRange("Unit Code", studUnits.Unit);
                if unitsMast.Find('-') then begin
                    studUnits.Description := unitsMast."Unit Name";
                    studUnits.Modify();
                end;
            until studUnits.Next() = 0
        end;

    end;
}


