/// <summary>
/// Report Provisional Transcript (ID 51666).
/// </summary>
report 51666 "Provisional Transcript"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Provisional Transcript.rdl';

    dataset
    {
        dataitem(DataItem1000000000; 61532)
        {
            DataItemTableView = WHERE(session = filter(''));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Student No.", Programmes, Stage, Semester, Session;
            column(TranscriptRemarks; "Transcript Remarks")
            {
            }
            column(StudNo; "Student No.")
            {
            }
            column(Prog; Programmes)
            {
            }
            column(Sem; Semester)
            {
            }
            column(Stag; Stage)
            {
            }
            column(CumSc; "Cumm Status")
            {
            }
            column(SemesterFilter_CourseRegistration; "Semester Filter")
            {
            }
            column(CurrSem; "Current Cumm Score")
            {
            }
            column(Names; Names)
            {
            }

            column(Year_Of_Study; "Year Of Study")
            {
            }
            column(Year_of_Admission; "Year of Admission")
            {
            }

            column(Academic_Year; "Academic Year")
            {
            }
            column(From100Legend; 'A (70% - 100%)        - Excellent         B (60% - 69%)      - Good       C (50% - 59%)     -Satisfactory ')
            {
            }
            column(From40Legend; 'D (40% - 49%)                - Fair                 E (39% and Below)   - Fail')
            {
            }
            column(PassMarkLegend; 'NOTE:   Pass mark is ' + FORMAT('') + '%')
            {
            }
            column(DoubleLine; '=======================================================================')
            {
            }
            column(Recomm; 'Recommendation:')
            {
            }
            column(singleLine; '======================================================================')
            {
            }
            column(signedSignature; 'Signed......................................................')
            {
            }
            column(codSchool; 'COD, ' + CompanyName)
            {
            }
            column(codDept; 'COD,' + "Department Code")
            {
            }
            column(dateSigned; 'Date:.......................................................')
            {
            }
            // column(PassRemark;)
            // {
            // }
            // column(Label1; GLabel[1])
            // {
            // }
            // column(Label2; GLabel[2])
            // {
            // }
            // column(Label3; GLabel[3])
            // {
            // }
            // column(Label4; GLabel[4])
            // {
            // }
            // column(Label5; GLabel[5])
            // {
            // }
            // column(BLabel1; GLabel2[1])
            // {
            // }
            // column(BLabel2; GLabel2[2])
            // {
            // }
            // column(BLabel3; GLabel2[3])
            // {
            // }
            // column(BLabel4; GLabel2[4])
            // {
            // }
            // column(BLabel5; GLabel2[5])
            // {
            // }
            column(RegAcadLabel; 'Dean, ' + CompanyName)
            {
            }
            column(Cum_Units_Count; "Cum Units Count")
            {
            }
            // column(SelectedStages; SelectedStages)
            // {
            // }
            dataitem(DataItem1000000005; 61549)
            {
                DataItemLink = "Student No." = FIELD("Student No."),
                               Semester = FIELD(Semester);
                DataItemTableView = WHERE(Unit = FILTER(> 0));
                column(Unit; Unit)
                {
                }
                column(Desc; Description)
                {
                }
                column(Score; "Total Score")
                {
                }
                column(Final; "Final Score")
                {
                }
                column(Grade; Grade)
                {
                }
                column(Status; "Exam Status")
                {
                }
                column(CF; "No. Of Units")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CALCFIELDS("Total Score");
                    IF "Total Score" = 0 THEN
                        Grade := '-';




                    UnitsCount := UnitsCount + 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                // ExamProcess.UpdateCourseReg("Course Registration"."Student No.","Course Registration".Programme,"Course Registration".Stage,"Course Registration".Semester);
                // IF "Course Registration"."Academic Year"<> acadyear THEN
                // CurrReport.SKIP;

                CLEAR(SchoolName);
                IF prog.GET(Programmes) THEN BEGIN
                    pName := prog.Description;
                    dimVal.RESET;
                    dimVal.SETRANGE(dimVal."Dimension Code", 'School');
                    dimVal.SETRANGE(dimVal.Code, prog."School Code");
                    IF dimVal.FIND('-') THEN BEGIN
                        SchoolName := dimVal.Name;
                    END;
                END;
                dimVal.RESET;
                dimVal.SETRANGE(dimVal."Dimension Code", 'Department');
                dimVal.SETRANGE(dimVal.Code, prog."Department Code");
                IF dimVal.FIND('-') THEN BEGIN
                    DeptName := dimVal.Name;
                END;

                CLEAR(YearOfStudy);

                YearOfStudy := COPYSTR(Stage, 2, 1);
                SelectedStages := GETFILTER("Stage Filter");

                CLEAR(sName);
                CLEAR(YearOfAdmi);
                cust.RESET;
                cust.SETRANGE(cust."No.", "Student No.");
                IF cust.FIND('-') THEN BEGIN
                    sName := cust.Name;
                    PassRemark := '';
                END;

                SETFILTER("Semester Filter", GETFILTER(Semester));
                SETFILTER("Stage Filter", GETFILTER(Stage));
                CALCFIELDS("Cum Units Failed");
                ProgStages.RESET;
                ProgStages.SETRANGE(ProgStages."Programme Code", Programmes);
                ProgStages.SETRANGE(ProgStages.Code, Stage);
                IF ProgStages.FIND('-') THEN BEGIN
                    PassRemark := ProgStages.Remarks//'Recommendation: '+ProgStages.Remarks;
                END ELSE
                    IF ProgStages."Final Stage" = TRUE THEN BEGIN
                        PassRemark := Award;//'Recommendation: '+"ACA-Course Registration".Award;
                    END;
                IF "Cum Units Failed" > 0 THEN BEGIN
                    PassRemark := "Exam Status";//'Recommendation: '+"ACA-Course Registration"."Exam Status";
                END;
                //MESSAGE('%1',PassRemark);
                IntakeRec.RESET;
                IntakeRec.SETRANGE(IntakeRec.Code, Session);
                IF IntakeRec.FIND('-') THEN
                    YearOfAdmi := IntakeRec.Description;

                Sem.RESET;
                Sem.SETRANGE(Sem.Code, semester);
                IF Sem.FIND('-') THEN
                    acadyear := Sem."Academic Year";

                IF prog.GET(Programmes) THEN BEGIN
                    i := 1;
                    Gradings.RESET;
                    Gradings.SETRANGE(Gradings.Category, prog."Exam Category");
                    Gradings.ASCENDING := FALSE;
                    IF Gradings.FIND('-') THEN BEGIN
                        REPEAT
                            GLabel[i] := Gradings.Grade + '   (' + Gradings.Range + ') - ' + Gradings.Description;
                            GLabel2[i] := ' - ' + Gradings.Description;
                            IF Gradings.Failed = TRUE THEN
                                Passmark := ROUND(Gradings."Up to", 1);
                            i := i + 1;
                        UNTIL Gradings.NEXT = 0;
                    END;
                END;
            end;

            trigger OnPostDataItem()
            begin
                // ExamProcess.UpdateCourseReg("Course Registration"."Student No.","Course Registration".Programme,"Course Registration".Stage,"Course Registration".Semester);
            end;

            trigger OnPreDataItem()
            begin

                UnitsCount := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        //  IF acadyear='' THEN ERROR('Please specify the academic year.');
    end;

    var
        pName: Text[250];
        units_Subjects: Record 61517;
        YearOfStudy: Code[10];
        YearOfAdmi: Code[50];
        SchoolName: Text[250];
        ExamProcess: Codeunit 60276;
        EResults: Record 61548;
        UnitsR: Record 61517;
        "Units/Subj": Record 61517;
        Sem: Record 61692;
        StudUnits: Record 61549;
        stduntz: Record 61549;
        TotalCatMarks: Decimal;
        TotalCatContributions: Decimal;
        TotalMainExamContributions: Decimal;
        TotalExamMark: Decimal;
        FinalExamMark: Decimal;
        FinalCATMarks: Decimal;
        Gradez: Code[10];
        TotalMarks: Decimal;
        Gradings: Record 61599;
        LastGrade: Code[20];
        LastScore: Decimal;
        ExitDo: Boolean;
        Gradings2: Record 61599;
        Gradeaqq2: Code[10];
        TotMarks: Decimal;
        sName: Code[250];
        cust: Record 18;
        acadyear: Code[20];
        Sems: Code[20];
        prog: Record 61511;
        dimVal: Record 349;
        ProgStages: Record 61516;
        PassRemark: Text[200];
        SemRec: Record 61692;
        Creg: Record 61532;
        IntakeRec: Record 61383;
        DeptName: Text[100];
        i: Integer;
        GLabel: array[10] of Text[200];
        GLabel2: array[10] of Text[200];
        Passmark: Decimal;
        SelectedStages: Text[100];
        UnitsCount: Integer;
}

