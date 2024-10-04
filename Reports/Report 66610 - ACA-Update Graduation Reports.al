report 66610 "ACA-Update Graduation Reports"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(ITmCourseReg; "ACA-Course Registration")
        {
            DataItemTableView = SORTING("Year of Admission", "Student No.")
                                ORDER(Ascending)
                                WHERE("Is Final Year Student" = FILTER(true),
                                      Reversed = FILTER(false),
                                      Status = FILTER(Registration | Current | Deceased),
                                      "Final Clasification" = FILTER(<> ''),
                                      "Yearly Total Units Taken" = FILTER(> 0),
                                      "Final Stage" = FILTER(true));
            RequestFilterFields = Faculty, "Graduation Academic Year", Programmes, "Year Of Study";
            column(RegNo; RegNo)
            {
            }
            column(Names; Names)
            {
            }
            column(Compname; UPPERCASE(CompInf.Name))
            {
            }
            column(Pics; CompInf.Picture)
            {
            }
            column(StatusOrderCompiled; StatusOrder)
            {
            }
            column(statusCompiled; statusCompiled)
            {
            }
            column(StatusCode; ResultsStatus3.Code)
            {
            }
            column(StatusDesc; ResultsStatus.Description)
            {
            }
            column(SummaryPageCaption; ACAResultsStatus."Summary Page Caption")
            {
            }
            column(StatusOrder; ACAResultsStatus."Order No")
            {
            }
            column(StatCodes; ACAResultsStatus.Code)
            {
            }
            column(ApprovalsClaimer; 'Approved by the board of the Examiners of the  ' + FacDesc + ' at a meeting held on:')
            {
            }
            column(RegTrans; ITmCourseReg."Reg. Transacton ID")
            {
            }
            column(StudNo; ITmCourseReg."Student No.")
            {
            }
            column(Progs; ITmCourseReg.Programmes)
            {
            }
            column(ProgName; progName)
            {
            }
            column(Sems; ITmCourseReg.Semester)
            {
            }
            column(RegFor; ITmCourseReg."Register for")
            {
            }
            column(CourseStage; ITmCourseReg.Stage)
            {
            }
            column(Units; ITmCourseReg.Unit)
            {
            }
            column(StudType; ITmCourseReg."Student Type")
            {
            }
            column(EntryNo; ITmCourseReg."Entry No.")
            {
            }
            column(CampusCode; ITmCourseReg."Campus Code")
            {
            }
            column(ExamStatus; ITmCourseReg."Exam Status")
            {
            }
            column(FailedUnits; ITmCourseReg."Failed Unit")
            {
            }
            column(facCode; facCode)
            {
            }
            column(FacDesc; FacDesc)
            {
            }
            column(YoS; ITmCourseReg."Year Of Study")
            {
            }
            column(AcadYear; ITmCourseReg."Graduation Academic Year")
            {
            }
            column(GraduationGroup; ITmCourseReg."Graduation Group")
            {
            }
            column(YearOfStudyText; YearOfStudyText)
            {
            }
            column(NextYear; NextYear)
            {
            }
            column(SaltedExamStatusDesc; SaltedExamStatusDesc)
            {
            }
            column(SaltedExamStatus; SaltedExamStatus)
            {
            }
            column(counts; CurrNo)
            {
            }
            column(YoSTexed; YoS)
            {
            }
            column(UnitCodeLabel; UnitCodeLabel)
            {
            }
            column(UnitDescriptionLabel; UnitDescriptionLabel)
            {
            }
            column(PercentageFailedCaption; PercentageFailedCaption)
            {
            }
            column(NumberOfCoursesFailedCaption; NumberOfCoursesFailedCaption)
            {
            }
            column(PercentageFailedValue; PercentageFailedValue)
            {
            }
            column(NoOfCausesFailedValue; NoOfCausesFailedValue)
            {
            }
            column(YoA; ITmCourseReg."Year of Admission")
            {
            }
            column(SpecialUnitReg; SpecialUnitReg1)
            {
            }
            column(IsSpecialAndSupp; IsSpecialAndSupp)
            {
            }
            column(IsSpecialOnly; isSpecialOnly)
            {
            }
            column(NotSpecialNotSuppSpecial; NotSpecialNotSuppSpecial)
            {
            }

            trigger OnAfterGetRecord()
            var
                ACADGradStudPresidence: Record 66600;
            begin
                ITmCourseReg.CALCFIELDS(ITmCourseReg."Special Exam Exists");
                ITmCourseReg.CALCFIELDS(ITmCourseReg."Supp. Yearly Passed Units", ITmCourseReg."Supp. Yearly Failed Units");
                ITmCourseReg.CALCFIELDS(ITmCourseReg."Supp. Yearly Total Units Taken", ITmCourseReg."Is Final Year Student",
                ITmCourseReg."Graduation Status Count");
                //////////////////..........................................................................
                IF Cust.GET(ITmCourseReg."Student No.") THEN;
                ACAClassificationDetails.RESET;
                ACAClassificationDetails.SETRANGE("User ID", USERID);
                ACAClassificationDetails.SETRANGE("Programme Code", ITmCourseReg.Programmes);
                ACAClassificationDetails.SETRANGE("Graduation Academic Year", ITmCourseReg."Graduation Academic Year");
                ACAClassificationDetails.SETRANGE("Student No.", ITmCourseReg."Student No.");
                IF NOT ACAClassificationDetails.FIND('-') THEN BEGIN
                    ACAClassificationDetails.INIT;
                    ACAClassificationDetails."User ID" := USERID;
                    ACAClassificationDetails."Graduation Academic Year" := ITmCourseReg."Graduation Academic Year";
                    ACAClassificationDetails."Classification Code" := ITmCourseReg."Final Clasification";
                    ACAClassificationDetails."Programme Code" := ITmCourseReg.Programmes;
                    ACAClassificationDetails."Student No." := ITmCourseReg."Student No.";
                    ACAClassificationDetails."Student Name" := Cust.Name;
                    IF ITmCourseReg."Final Clasification" = 'INCOMPLETE' THEN BEGIN
                        ACAClassificationDetails."Pass Status" := 'INCOMPLETE';
                    END ELSE BEGIN
                        ACAClassificationDetails."Pass Status" := 'PASS';
                    END;
                    ACAClassificationDetails."Year of Study" := ITmCourseReg."Year Of Study";
                    ACAClassificationDetails.INSERT;
                END ELSE BEGIN
                    ACAClassificationDetails."Classification Code" := ITmCourseReg."Final Clasification";
                    IF ITmCourseReg."Final Clasification" = 'INCOMPLETE' THEN BEGIN
                        ACAClassificationDetails."Pass Status" := 'INCOMPLETE';
                    END ELSE BEGIN
                        ACAClassificationDetails."Pass Status" := 'PASS';
                    END;
                    ACAClassificationDetails."Student Name" := Cust.Name;
                    ACAClassificationDetails."Year of Study" := ITmCourseReg."Year Of Study";
                    ACAClassificationDetails.MODIFY;
                END;
            end;

            trigger OnPostDataItem()
            begin

                ACAClassificationHeader.RESET;
                ACAClassificationHeader.SETRANGE("User ID", USERID);
                ACAClassificationHeader.SETRANGE("Programme Code", ITmCourseReg.GETFILTER(Programmes));
                ACAClassificationHeader.SETRANGE("Graduation Academic Year", ITmCourseReg.GETFILTER("Graduation Academic Year"));
                IF ACAClassificationHeader.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN//Updating Graduation Numbering
                        CLEAR(incounts);
                        ACAClassificationDetails.RESET;
                        ACAClassificationDetails.SETRANGE("User ID", USERID);
                        ACAClassificationDetails.SETRANGE("Programme Code", ITmCourseReg.GETFILTER(Programmes));
                        ACAClassificationDetails.SETRANGE("Graduation Academic Year", ITmCourseReg.GETFILTER("Graduation Academic Year"));
                        ACAClassificationDetails.SETRANGE("Pass Status", ACAClassificationHeader."Pass Status");
                        ACAClassificationDetails.SETCURRENTKEY(ACAClassificationDetails."Student Name", ACAClassificationDetails."Pass Status");
                        IF ACAClassificationDetails.FIND('-') THEN BEGIN
                            CLEAR(incounts);
                            REPEAT
                            BEGIN
                                incounts += 1;
                                ACAClassificationDetails."Graduation Serial" := incounts;
                                ACAClassificationDetails.MODIFY;
                            END;
                            UNTIL ACAClassificationDetails.NEXT = 0;
                        END;
                        /// Update Classification Numbering
                        CLEAR(incounts);
                        ACAClassificationDetails.RESET;
                        ACAClassificationDetails.SETRANGE("User ID", USERID);
                        ACAClassificationDetails.SETRANGE("Programme Code", ITmCourseReg.GETFILTER(Programmes));
                        ACAClassificationDetails.SETRANGE("Graduation Academic Year", ITmCourseReg.GETFILTER("Graduation Academic Year"));
                        ACAClassificationDetails.SETRANGE("Classification Code", ACAClassificationHeader."Classification Code");
                        ACAClassificationDetails.SETCURRENTKEY(ACAClassificationDetails."Student No.", ACAClassificationDetails."Classification Code");
                        IF ACAClassificationDetails.FIND('-') THEN BEGIN
                            REPEAT
                            BEGIN
                                incounts += 1;
                                ACAClassificationDetails."Classification Serial" := incounts;
                                ACAClassificationDetails.MODIFY;
                            END;
                            UNTIL ACAClassificationDetails.NEXT = 0;
                        END;

                    END;
                    UNTIL ACAClassificationHeader.NEXT = 0;
                END;
            end;

            trigger OnPreDataItem()
            var
                ACADGradStudPresidence: Record 66600;
                ACAProgrammeStages: Record 61516;
            begin
                IF ITmCourseReg.GETFILTER(ITmCourseReg.Semester) <> '' THEN ERROR('Semester Filters are not allowed.');
                IF ITmCourseReg.GETFILTER(ITmCourseReg.Stage) <> '' THEN ERROR('Stage Filters are not allowed.');
                IF ITmCourseReg.GETFILTER(ITmCourseReg."Graduation Academic Year") = '' THEN ERROR('Specify Graduation Academic Year');
                //// Update Graduation Parameters
                Prog.RESET;
                Prog.SETRANGE(Code, ITmCourseReg.GETFILTER(Programmes));
                IF Prog.FIND('-') THEN BEGIN
                    ACAProgrammeStages.RESET;
                    ACAProgrammeStages.SETRANGE("Programme Code", Prog.Code);
                    ACAProgrammeStages.SETRANGE("Final Stage", TRUE);
                    IF ACAProgrammeStages.FIND('-') THEN BEGIN
                        IF ((COPYSTR(ACAProgrammeStages.Code, 2, 1)) IN ['1', '2', '3', '4', '5', '6', '7']) THEN
                            EVALUATE(YoSComputed, COPYSTR(ACAProgrammeStages.Code, 2, 1))
                        ELSE
                            ERROR('Final Stage of study has an invalid format!');
                    END ELSE
                        ERROR('Programme last stage is not defined!');
                END ELSE
                    ERROR('Programme not Found!');
                ACAClassificationHeader.RESET;
                ACAClassificationHeader.SETRANGE("User ID", USERID);
                ACAClassificationHeader.SETRANGE("Programme Code", ITmCourseReg.GETFILTER(Programmes));
                ACAClassificationHeader.SETRANGE("Graduation Academic Year", ITmCourseReg.GETFILTER("Graduation Academic Year"));
                IF ACAClassificationHeader.FIND('-') THEN ACAClassificationHeader.DELETEALL;
                ACAClassificationDetails.RESET;
                ACAClassificationDetails.SETRANGE("User ID", USERID);
                ACAClassificationDetails.SETRANGE("Programme Code", ITmCourseReg.GETFILTER(Programmes));
                ACAClassificationDetails.SETRANGE("Graduation Academic Year", ITmCourseReg.GETFILTER("Graduation Academic Year"));
                IF ACAClassificationDetails.FIND('-') THEN ACAClassificationDetails.DELETEALL;
                ACAClassGradRubrics.RESET;
                IF ACAClassGradRubrics.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        ACAClassificationHeader.INIT;
                        ACAClassificationHeader."User ID" := USERID;
                        ACAClassificationHeader."Graduation Academic Year" := ITmCourseReg.GETFILTER(ITmCourseReg."Graduation Academic Year");
                        ACAClassificationHeader."Classification Code" := ACAClassGradRubrics.Code;
                        ACAClassificationHeader."Classification Order" := ACAClassGradRubrics."Order No";
                        ACAClassificationHeader."Programme Code" := ITmCourseReg.GETFILTER(Programmes);
                        IF ACAClassGradRubrics.Code = 'INCOMPLETE' THEN BEGIN
                            ACAClassificationHeader."Pass Status" := 'INCOMPLETE';
                            ACAClassificationHeader."Pass Status Order" := 2;
                        END ELSE BEGIN
                            ACAClassificationHeader."Pass Status" := 'PASS';
                            ACAClassificationHeader."Pass Status Order" := 1;
                        END;
                        ACAClassificationHeader."Year of Study" := YoSComputed;
                        ACAClassificationHeader."Year of Study Text" := GetYearofStudyText(YoSComputed);
                        ACAClassificationHeader.Msg1 := ACAClassGradRubrics."Classification Msg1";
                        ACAClassificationHeader.Msg2 := ACAClassGradRubrics."Classification Msg2";
                        ACAClassificationHeader.Msg3 := ACAClassGradRubrics."Classification Msg3";
                        ACAClassificationHeader.Msg4 := ACAClassGradRubrics."Classification Msg4";
                        ACAClassificationHeader.Msg5 := ACAClassGradRubrics."Classification Msg5";
                        ACAClassificationHeader.Msg6 := ACAClassGradRubrics."Classification Msg6";
                        ACAClassificationHeader."Final Year Comment" := ACAClassGradRubrics."Final Year Comment";
                        ACAClassificationHeader.INSERT;
                    END;
                    UNTIL ACAClassGradRubrics.NEXT = 0;
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompInf.GET();
        CompInf.CALCFIELDS(CompInf.Picture);
    end;

    var
        YoSComputed: Integer;
        ACAGraduationReportPicker: Record 66610;
        ACAClassificationHeader: Record 66612;
        ACAClassificationDetails: Record 66613;
        ACAClassificationDetails2: Record 66613;
        ACAClassGradRubrics: Record 78011;
        ACACourseRegistration: Record 61532;
        SpecialReason: Text[150];
        failExists: Boolean;
        StatusOrder: Integer;
        statusCompiled: Code[50];
        NotSpecialNotSuppSpecial: Boolean;
        isSpecialOnly: Boolean;
        IsSpecialAndSupp: Boolean;
        IsaForthYear: Boolean;
        IsSpecialUnit: Boolean;
        SpecialUnitReg1: Boolean;
        SpecialUnitReg: Boolean;
        ACASenateReportCounts: Record 77720;
        NoOfStudentInText: Text[250];
        ConvertDecimalToText: Codeunit "Convert Decimal To Text ACA";
        PercentageFailedCaption: Text[100];
        NumberOfCoursesFailedCaption: Text[100];
        PercentageFailedValue: Decimal;
        NoOfCausesFailedValue: Integer;
        NoOfStudentsDecimal: Text;
        ACAStudentUnits: Record 61549;
        CountedRecs: Integer;
        UnitCodes: array[30] of Text[50];
        UnitDescs: array[30] of Text[150];
        UnitCodeLabel: Text;
        UnitDescriptionLabel: Text;
        NoOfStudents: Integer;
        StudUnits: Record 61549;
        ExamsDone: Integer;
        FailCount: Integer;
        Cust: Record 18;

        Prog: Record 61511;
        FacDesc: Code[100];

        StudentsL: Text[250];
        N: Integer;
        Grd: Code[20];
        Marks: Decimal;

        ResultsStatus: Record 78011;
        ResultsStatus3: Record 78011;

        UnitsDesc: Text[100];
        UnitsHeader: Text[50];
        FailsDesc: Text[200];
        Nx: Integer;
        RegNo: Code[20];
        Names: Text[100];
        Ucount: Integer;
        RegNox: Code[20];
        Namesx: Text[100];
        Nxx: Text[30];
        SemYear: Code[20];
        ShowSem: Boolean;
        SemDesc: Code[100];

        CompInf: Record 79;
        YearDesc: Text[30];
        MaxYear: Code[20];
        MaxSem: Code[20];
        CummScore: Decimal;
        CurrScore: Decimal;
        mDate: Date;

        IntakeDesc: Text[100];
        SemFilter: Text[100];
        StageFilter: Text[100];
        MinYear: Code[20];
        MinSem: Code[20];
        StatusNarrations: Text[1000];
        NextYear: Code[20];
        facCode: Code[20];
        progName: Code[150];
        ACAResultsStatus: Record 78011;
        Msg1: Text[250];
        Msg2: Text[250];
        Msg3: Text[250];
        Msg4: Text[250];
        Msg5: Text[250];
        Msg6: Text[250];
        YearOfStudyText: Text[30];
        SaltedExamStatus: Code[1024];
        SaltedExamStatusDesc: Text;
        ACASenateReportStatusBuff: Record 77718 temporary;
        CurrNo: Integer;
        YoS: Code[20];

        yosInt: Integer;

        incounts: Integer;

    local procedure GetYearofStudyText(Yos: Integer) YosText: Text[150]
    begin
        CLEAR(YosText);
        IF Yos = 1 THEN YosText := 'FIRST';
        IF Yos = 2 THEN YosText := 'SECOND';
        IF Yos = 3 THEN YosText := 'THIRD';
        IF Yos = 4 THEN YosText := 'FORTH';
        IF Yos = 5 THEN YosText := 'FIFTH';
        IF Yos = 6 THEN YosText := 'SIXTH';
        IF Yos = 7 THEN YosText := 'SEVENTH';
    end;
}

