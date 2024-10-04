report 51797 "Official University Resultslip"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Official University Resultslip.rdl';

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {
            DataItemTableView = WHERE("Register for" = CONST(Stage),
                                      Reversed = FILTER('No'));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Student No.", Programmes, Stage, Semester, Session;
            // column(pic;info.pic)
            // {
            // }
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
            column(CumSc; "Cumm Score")
            {
            }
            column(CurrSem; "Current Cumm Score")
            {
            }
            column(Student_Name; "Student Name")
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
            column(PassMarkLegend; 'NOTE:   Pass mark is 40%')
            {
            }
            column(DoubleLine; '===============================================================================')
            {
            }
            column(Recomm; 'Recommendation:')
            {
            }
            column(singleLine; '===============================================================================')
            {
            }
            column(signedSignature; 'Signed......................................................')
            {
            }
            // column(codSchool;'(COD, '+SchoolName+')')
            // {
            // }
            // column(CodDept;'(COD,'+Deptname+')')
            // {
            // }
            column(dateSigned; 'Date:.......................................................')
            {
            }
            column(RegAcadLabel; 'Registrar, Academic Affairs')
            {
            }
            dataitem(DataItem1000000005; 61549)
            {
                DataItemLink = "Student No." = FIELD("Student No."),
                               Semester = FIELD(Semester),
                               "Reg. Transacton ID" = FIELD("Reg. Transacton ID");
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
                column(Status; Status)
                {
                }
                column(ResultsStatus; "Result Status")
                {
                }
                column(CF; Units)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CALCFIELDS("Total Score");
                    IF "Total Score" = 0 THEN
                        Grade := 'E';
                end;
            }

            trigger OnAfterGetRecord()
            begin
                // ExamProcess.UpdateCourseReg("Course Registration"."Student No.","Course Registration".Programme,"Course Registration".Stage,"Course Registration".Semester);
                /*
                IF "Course Registration"."Academic Year"<> acadyear THEN
                CurrReport.SKIP;
                IF "Course Registration".Semester<>Sems THEN
                CurrReport.SKIP;
                */
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
                    Deptname := dimVal.Name;
                END;


                CLEAR(YearOfStudy);
                ProgrammeStages.RESET;
                ProgrammeStages.SETRANGE(ProgrammeStages."Programme Code", Programmes);
                ProgrammeStages.SETRANGE(ProgrammeStages.Code, Stage);
                IF ProgrammeStages.FIND('-') THEN
                    YearOfStudy := ProgrammeStages.Description;


                CLEAR(sName);
                CLEAR(YearOfAdmi);
                cust.RESET;
                cust.SETRANGE(cust."No.", "Student No.");
                IF cust.FIND('-') THEN BEGIN
                    sName := cust.Name;

                END;

                IntakeRec.RESET;
                IntakeRec.SETRANGE(IntakeRec.Code, Session);
                IF IntakeRec.FIND('-') THEN
                    YearOfAdmi := IntakeRec.Description;

                acadyear := "Academic Year";

            end;

            trigger OnPostDataItem()
            begin
                // ExamProcess.UpdateCourseReg("Course Registration"."Student No.","Course Registration".Programme,"Course Registration".Stage,"Course Registration".Semester);
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
        //  IF Sems='' THEN ERROR('Please specify the Semester.');

        //Info.RESET;
        // IF Info.FIND('-') THEN BEGIN
        // Info.CALCFIELDS(Picture);
        // END;
    end;

    var
        ProgrammeStages: Record 61516;
        pName: Text[250];
        units_Subjects: Record 61517;
        YearOfStudy: Code[50];
        YearOfAdmi: Code[50];
        SchoolName: Text[250];

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
        Info: Record 79;
        IntakeRec: Record 61383;
        Deptname: Text[100];
}

