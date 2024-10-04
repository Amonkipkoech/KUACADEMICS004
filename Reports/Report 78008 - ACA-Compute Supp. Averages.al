report 78008 "ACA-Compute Supp. Averages"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(CRegs1; "ACA-Course Registration")
        {
            DataItemTableView = WHERE(Reversed = FILTER(false),
                                      Status = FILTER(Deceased | Registration | Current));

            trigger OnAfterGetRecord()
            var
                SuppExists: Boolean;
            begin
                // CRegs1."Supp. Yearly Remarks":='';

                progress.UPDATE(1, CRegs1."Student No.");
                progress.UPDATE(2, CRegs1.Programmes);
                progress.UPDATE(3, CRegs1.Semester);
                progress.UPDATE(4, CRegs1.Stage);
                CLEAR(YearlyReMarks);
                CLEAR(TotalYearlyMarks);
                CLEAR(YearlyAverage);
                CLEAR(YearlyGrade);
                CLEAR(YearlyFailedUnits);
                CLEAR(YearlyTotalUnits);
                CLEAR(SemesterReMarks);
                CLEAR(TotalSemesterMarks);
                CLEAR(SemesterAverage);
                CLEAR(SemesterGrade);
                CLEAR(SemesterFailedUnits);
                CLEAR(SemesterTotalUnits);
                CLEAR(CummulativeReMarks);
                CLEAR(TotalCummulativeMarks);
                CLEAR(CummulativeAverage);
                CLEAR(CummulativeGrade);
                CLEAR(CummulativeFailedUnits);
                CLEAR(CummulativeTotalUnits);
                CLEAR(FailedUnits);
                CLEAR(StatusRemarks);

                CRegs1.CALCFIELDS(CRegs1."Supp. Total Yearly Marks",
                CRegs1."Supp. Yearly Failed Units", CRegs1."Supp. Yearly Total Units Taken",
                CRegs1."Supp. Total Semester Marks",
                CRegs1."Supp. Semester Failed Units", CRegs1."Supp. Semester Tot Units Taken",
                CRegs1."Cummulative Marks", CRegs1."Cummulative Units", CRegs1."Supp. Yearly Weighted Total",
                CRegs1."Semester Weighted Total", CRegs1."Special Exam Exists", CRegs1."Supp. Registered", CRegs1."Supp. Yearly Failed Courses",
                CRegs1."Supp. Yearly Passed Units", CRegs1."Supp. Cummulative Units",
                CRegs1."Supp. Cummulative Marks", CRegs1."Supp. Total Number of courses",
                CRegs1."Supp. Yearly Total Courses");
                CRegs1.CALCFIELDS(CRegs1."Supp. Yearly Failed Cores", CRegs1."Supp. Yearly Failed Electives", CRegs1."Supp. Yearly Total Cores", CRegs1."Supp. Yearly Total Electives");//

                //Year Computations
                YearlyFailedUnits := CRegs1."Supp. Yearly Failed Units";
                YearlyTotalUnits := CRegs1."Supp. Yearly Total Units Taken";
                CLEAR(YearlyCfFail);
                CLEAR(SemesterCfFail);
                CLEAR(CummCFFauil);
                IF YearlyTotalUnits <> 0 THEN BEGIN
                    YearlyCfFail := (YearlyFailedUnits / YearlyTotalUnits) * 100;
                    //YearlyFailedUnits:=(YearlyFailedUnits/YearlyTotalUnits)*100;
                END;// ELSE YearlyFailedUnits:=0;
                //YearlyCfFail:=ROUND(YearlyCfFail,0.01,'=');
                CLEAR(SuppCummAverage);
                SuppCummAverage := CRegs1."Supp. Cummulative Units" * CRegs1."Supp. Cummulative Marks";
                CRegs1."Supp. Cummulative Average" := 0;
                //CRegs1."Supp. Cummulative Grade":=g
                IF SuppCummAverage <> 0 THEN BEGIN
                    IF CRegs1."Supp. Total Number of courses" <> 0 THEN SuppCummAverage := SuppCummAverage / CRegs1."Supp. Total Number of courses";
                    CRegs1."Supp. Cummulative Average" := SuppCummAverage;
                END;


                CRegs1."Supp. Yearly CF% Failed" := YearlyCfFail;
                IF YearlyTotalUnits <> 0 THEN
                    //CRegs1."Supp. Yearly Curr. Average":=(CRegs1."Supp. Total Yearly Marks"/CRegs1."Supp. Yearly Total Courses");
                    CRegs1."Supp. Yearly Curr. Average" := (CRegs1."Supp. Total Yearly Marks" / CRegs1."Supp. Yearly Total Units Taken");
                IF YearlyTotalUnits = 0 THEN CurrReport.SKIP;
                TotalYearlyMarks := CRegs1."Supp. Total Yearly Marks";

                IF ((TotalYearlyMarks > 0) AND (YearlyTotalUnits > 0)) THEN BEGIN
                    YearlyAverage := ROUND(TotalYearlyMarks / YearlyTotalUnits, 0.01, '=');
                END;
                ACAProgramme.RESET;
                ACAProgramme.SETRANGE(Code, CRegs1.Programmes);
                IF ACAProgramme.FIND('-') THEN BEGIN
                    ACAGradingSystemSetup.RESET;
                    IF ACAProgramme."Exam Category" = '' THEN
                        ACAGradingSystemSetup.SETRANGE(Category, 'DEFAULT')
                    ELSE
                        ACAGradingSystemSetup.SETRANGE(Category, ACAProgramme."Exam Category");
                    ACAGradingSystemSetup.SETFILTER("Lower Limit", '=%1|<%2', YearlyAverage, YearlyAverage);
                    ACAGradingSystemSetup.SETFILTER("Upper Limit", '=%1|>%2', YearlyAverage, YearlyAverage);
                    IF ACAGradingSystemSetup.FIND('-') THEN BEGIN
                        YearlyGrade := ACAGradingSystemSetup.Grade;
                    END;
                END;
                IF YearlyGrade = '' THEN YearlyReMarks := 'No marks captured';
                CLEAR(LubricIdentified);
                CLEAR(YearlyReMarks);
                Customer.RESET;
                Customer.SETRANGE("No.", CRegs1."Student No.");
                IF Customer.FIND('-') THEN BEGIN
                    IF ((Customer.Status = Customer.Status::Current) OR (Customer.Status = Customer.Status::Current)) THEN BEGIN
                        CLEAR(LubricIdentified);
                        CRegs1.CALCFIELDS("Yearly Failed Cores", "Yearly Failed Electives", "Yearly Total Cores", "Yearly Total Electives",
                        "Yearly Failed Units", "Yearly Total Units Taken");
                        IF CRegs1."Supp. Yearly Total Cores" > 0 THEN
                            CRegs1."Supp. Yearly Failed Cores %" := (CRegs1."Supp. Yearly Failed Cores" / CRegs1."Supp. Yearly Total Cores") * 100;
                        IF CRegs1."Supp. Yearly Total Electives" > 0 THEN
                            CRegs1."SuppYearly Failed Electives %" := (CRegs1."Supp. Yearly Failed Electives" / CRegs1."Supp. Yearly Total Electives") * 100;
                        IF ((CRegs1."Supp. Yearly Total Electives" + CRegs1."Supp. Yearly Total Cores") > 0) THEN
                            CRegs1."Supp. Yearly Failed Units %" := ((CRegs1."Supp. Yearly Failed Electives" + CRegs1."Supp. Yearly Failed Cores") /
                          (CRegs1."Supp. Yearly Total Electives" + CRegs1."Supp. Yearly Total Cores")) * 100;

                        ACAResultsStatus.RESET;
                        ACAResultsStatus.SETFILTER("Manual Status Processing", '%1', FALSE);
                        ACAResultsStatus.SETRANGE("Academic Year", CRegs1."Academic Year");
                        ACAResultsStatus.SETRANGE("Special Programme Class", ACAProgramme."Special Programme Class");
                        // ACAResultsStatus.SETFILTER("Min. Unit Repeat Counts",'=%1|<%2',CRegs1."Highest Yearly Repeats",CRegs1."Highest Yearly Repeats");
                        // ACAResultsStatus.SETFILTER("Max. Unit Repeat Counts",'=%1|>%2',CRegs1."Highest Yearly Repeats",CRegs1."Highest Yearly Repeats");
                        ACAResultsStatus.SETFILTER("Minimum Units Failed", '=%1|<%2', YearlyFailedUnits, YearlyFailedUnits);
                        ACAResultsStatus.SETFILTER("Maximum Units Failed", '=%1|>%2', YearlyFailedUnits, YearlyFailedUnits);
                        // // ACAResultsStatus.SETFILTER("Minimum Units Failed",'=%1|<%2',CRegs1."Supp. Yearly Failed Units %",CRegs1."Supp. Yearly Failed Units %");
                        // // ACAResultsStatus.SETFILTER("Maximum Units Failed",'=%1|>%2',CRegs1."Supp. Yearly Failed Units %",CRegs1."Supp. Yearly Failed Units %");
                        IF ACAProgramme."Special Programme Class" = ACAProgramme."Special Programme Class"::"Medicine & Nursing" THEN BEGIN
                            ACAResultsStatus.SETFILTER("Minimum Core Fails", '=%1|<%2', CRegs1."Supp. Yearly Failed Cores %", CRegs1."Supp. Yearly Failed Cores %");
                            ACAResultsStatus.SETFILTER("Maximum Core Fails", '=%1|>%2', CRegs1."Supp. Yearly Failed Cores %", CRegs1."Supp. Yearly Failed Cores %");
                            ACAResultsStatus.SETFILTER("Minimum None-Core Fails", '=%1|<%2', CRegs1."SuppYearly Failed Electives %", CRegs1."SuppYearly Failed Electives %");
                            ACAResultsStatus.SETFILTER("Maximum None-Core Fails", '=%1|>%2', CRegs1."SuppYearly Failed Electives %", CRegs1."SuppYearly Failed Electives %");
                        END ELSE BEGIN
                            ACAResultsStatus.SETFILTER("Minimum Units Failed", '=%1|<%2', YearlyFailedUnits, YearlyFailedUnits);
                            ACAResultsStatus.SETFILTER("Maximum Units Failed", '=%1|>%2', YearlyFailedUnits, YearlyFailedUnits);
                        END;
                        // // ACAResultsStatus.SETFILTER("Special Programme Class",'=%1',ACAProgramme."Special Programme Class");
                        IF ACAResultsStatus.FIND('-') THEN BEGIN
                            REPEAT
                            BEGIN
                                //  IF (((YearlyCfFail>ACAResultsStatus."Minimum Units Failed") OR (YearlyCfFail=ACAResultsStatus."Minimum Units Failed")) AND
                                //    (YearlyCfFail<ACAResultsStatus."Maximum Units Failed") OR (YearlyCfFail=ACAResultsStatus."Maximum Units Failed")) THEN BEGIN
                                StatusRemarks := ACAResultsStatus.Code;
                                YearlyReMarks := ACAResultsStatus."Transcript Remarks";
                                LubricIdentified := TRUE;
                                //   END;
                            END;
                            UNTIL ((ACAResultsStatus.NEXT = 0) OR (LubricIdentified = TRUE))
                        END;
                    END ELSE BEGIN

                        ACAResultsStatus.RESET;
                        ACAResultsStatus.SETRANGE(Status, Customer.Status);
                        IF ACAResultsStatus.FIND('-') THEN BEGIN
                            IF ((Customer.Status <> Customer.Status::Current) AND (Customer.Status <> Customer.Status::Registration)) THEN
                                StatusRemarks := ACAResultsStatus.Code;
                            YearlyReMarks := ACAResultsStatus."Transcript Remarks";
                        END;
                    END;
                END;
                //    IF YearlyGrade='E' THEN YearlyReMarks:='NOT TO PROCEED TO THE NEXT YEAR OF STUDY UNTIL (S)HE CLEARS FAILED UNITS';

                //CRegs1."Supp. Transcript Remarks":=YearlyReMarks;
                IF CRegs1."Supp. Registered" THEN BEGIN
                    CRegs1."Supp. Yearly Average" := YearlyAverage;
                    CRegs1."Supp. Yearly Grade" := YearlyGrade;
                    CRegs1."Supp. Yearly Remarks" := StatusRemarks;
                    CRegs1."Exam Status" := StatusRemarks;
                END ELSE BEGIN
                    CRegs1."Supp. Yearly Average" := CRegs1."Yearly Average";
                    CRegs1."Supp. Yearly Grade" := CRegs1."Yearly Grade";
                    CRegs1."Supp. Yearly Remarks" := CRegs1."Yearly Remarks";
                    //CRegs1."Exam Status":=CRegs1;
                END;
                CRegs1."Supp. Year Of Study" := CRegs1."Year Of Study";
                // // // //    IF CRegs1."Student No."='CI/00136/018' THEN
                // // // //      CLEAR(LubricIdentified);
                IF YearlyReMarks = 'PASS' THEN BEGIN
                    ACAProgCatTranscriptComm.RESET;
                    ACAProgCatTranscriptComm.SETRANGE("Exam Catogory", ACAProgramme."Exam Category");
                    ACAProgCatTranscriptComm.SETRANGE("Year of Study", CRegs1."Year Of Study");
                    IF ACAProgCatTranscriptComm.FIND('-') THEN BEGIN
                        IF ACAProgCatTranscriptComm."Include Programme Name" THEN
                            CRegs1."Supp. Transcript Remarks" := ACAProgCatTranscriptComm."Pass Comment" + ' ' + UPPERCASE(ACAProgramme.Description)
                        ELSE
                            CRegs1."Supp. Transcript Remarks" := ACAProgCatTranscriptComm."Pass Comment";
                    END;
                END ELSE BEGIN
                    // // // // // // // // // // // // // // // // //    ACAProgCatTranscriptComm.RESET;
                    // // // // // // // // // // // // // // // // //    ACAProgCatTranscriptComm.SETRANGE("Exam Catogory",ACAProgramme."Exam Category");
                    // // // // // // // // // // // // // // // // //    ACAProgCatTranscriptComm.SETRANGE("Year of Study",CRegs1."Year Of Study");
                    // // // // // // // // // // // // // // // // //    IF ACAProgCatTranscriptComm.FIND('-') THEN BEGIN
                    CRegs1."Supp. Transcript Remarks" := 'INCOMPLETE';
                    // // // // // // // // // // // // // // // // //      END;
                END;
                /*ACAStudentUnits2.RESET;
                ACAStudentUnits2.SETRANGE("Student No.",CRegs1."Student No.");
                ACAStudentUnits2.SETRANGE("Year Of Study",CRegs1."Year Of Study");
                ACAStudentUnits2.SETRANGE(Grade,'E');
                IF ACAStudentUnits2.FIND('-') THEN BEGIN
                  REPEAT
                    BEGIN
                      IF FailedUnits='' THEN FailedUnits:=ACAStudentUnits2.Unit
                      ELSE FailedUnits:=FailedUnits+';'+ACAStudentUnits2.Unit;
                    END;
                    UNTIL ACAStudentUnits2.NEXT=0;
                  END;*/

                //CRegs1."Failed Unit":=FailedUnits;

                //Semester Computations
                SemesterFailedUnits := CRegs1."Supp. Semester Failed Units";
                SemesterTotalUnits := CRegs1."Supp. Semester Tot Units Taken";
                TotalSemesterMarks := CRegs1."Supp. Total Semester Marks";
                IF SemesterTotalUnits <> 0 THEN
                    SemesterCfFail := (SemesterFailedUnits / SemesterTotalUnits) * 100;
                CRegs1."Supp. Semester CF% Failed" := SemesterCfFail;
                IF SemesterTotalUnits <> 0 THEN
                    CRegs1."Supp. Semester Curr. Average" := (CRegs1."Supp. Semester Weighted Total" / SemesterTotalUnits);
                IF ((TotalSemesterMarks > 0) AND (SemesterTotalUnits > 0)) THEN BEGIN
                    SemesterAverage := ROUND(TotalSemesterMarks / SemesterTotalUnits, 0.01, '=');
                END;
                ACAProgramme.RESET;
                ACAProgramme.SETRANGE(Code, CRegs1.Programmes);
                IF ACAProgramme.FIND('-') THEN BEGIN
                    ACAGradingSystemSetup.RESET;
                    IF ACAProgramme."Exam Category" = '' THEN
                        ACAGradingSystemSetup.SETRANGE(Category, 'DEFAULT')
                    ELSE
                        ACAGradingSystemSetup.SETRANGE(Category, ACAProgramme."Exam Category");
                    ACAGradingSystemSetup.SETFILTER("Lower Limit", '=%1|<%2', SemesterAverage, SemesterAverage);
                    ACAGradingSystemSetup.SETFILTER("Upper Limit", '=%1|>%2', SemesterAverage, SemesterAverage);
                    IF ACAGradingSystemSetup.FIND('-') THEN BEGIN
                        SemesterGrade := ACAGradingSystemSetup.Grade;
                    END;
                END;
                IF SemesterGrade = '' THEN SemesterReMarks := 'No marks captured';
                IF ((SemesterFailedUnits > 0) AND (SemesterFailedUnits < 5)) THEN SemesterReMarks := 'TO  PROCEED  TO NEXT YEAR OF STUDY  BUT RESIT COURSE(S) FAILED WHEN NEXT OFFERED';
                IF ((SemesterFailedUnits > 0) AND (SemesterFailedUnits > 5)) THEN SemesterReMarks := 'REPEAT ' + FORMAT(CRegs1."Year Of Study");
                IF (SemesterFailedUnits = 0) THEN SemesterReMarks := 'TO  PROCEED TO NEXT YEAR OF STUDY';
                IF SemesterGrade = 'E' THEN
                    SemesterReMarks := 'FAIL'
                ELSE
                    SemesterReMarks := 'PASS';

                // LubricIdentified:=FALSE;
                //    ACAResultsStatus.RESET;
                // ACAResultsStatus.SETFILTER("Manual Status Processing",'%1',FALSE);
                // IF ACAResultsStatus.FIND('-') THEN BEGIN
                //  REPEAT
                //  BEGIN
                //  IF (((SemesterFailedUnits>ACAResultsStatus."Minimum Units Failed") OR (SemesterFailedUnits=ACAResultsStatus."Minimum Units Failed")) AND
                //    (SemesterFailedUnits<ACAResultsStatus."Maximum Units Failed") OR (SemesterFailedUnits=ACAResultsStatus."Maximum Units Failed")) THEN BEGIN
                //      StatusRemarks:=ACAResultsStatus.Code;
                //      LubricIdentified:=TRUE;
                //    END;
                //  END;
                //  UNTIL ((ACAResultsStatus.NEXT=0) OR (LubricIdentified=TRUE))
                // END;

                CRegs1."Supp. Semester Curr. Average" := SemesterAverage;
                //CRegs1.supp. sem:=SemesterGrade;
                CRegs1."Supp. Semester Remarks" := StatusRemarks;


                //Cummulative Computations
                CummulativeTotalUnits := CRegs1."Supp. Cummulative Units";
                TotalCummulativeMarks := CRegs1."Supp. Cummulative Marks";

                IF ((TotalCummulativeMarks > 0) AND (CummulativeTotalUnits > 0)) THEN BEGIN
                    CummulativeAverage := ROUND(TotalCummulativeMarks / CummulativeTotalUnits, 0.01, '=');
                END;
                ACAProgramme.RESET;
                ACAProgramme.SETRANGE(Code, CRegs1.Programmes);
                IF ACAProgramme.FIND('-') THEN BEGIN
                    ACAGradingSystemSetup.RESET;
                    IF ACAProgramme."Exam Category" = '' THEN
                        ACAGradingSystemSetup.SETRANGE(Category, 'DEFAULT')
                    ELSE
                        ACAGradingSystemSetup.SETRANGE(Category, ACAProgramme."Exam Category");
                    ACAGradingSystemSetup.SETFILTER("Lower Limit", '=%1|<%2', CummulativeAverage, CummulativeAverage);
                    ACAGradingSystemSetup.SETFILTER("Upper Limit", '=%1|>%2', CummulativeAverage, CummulativeAverage);
                    IF ACAGradingSystemSetup.FIND('-') THEN BEGIN
                        CummulativeGrade := ACAGradingSystemSetup.Grade;
                        CummulativeReMarks := ACAGradingSystemSetup.Award;
                    END;
                END;

                CLEAR(incompleteExists);
                CLEAR(SuppExists);

                ACAStudentUnits2.RESET;
                ACAStudentUnits2.SETRANGE("Student No.", CRegs1."Student No.");
                ACAStudentUnits2.SETRANGE("Year Of Study", CRegs1."Year Of Study");
                ACAStudentUnits2.SETRANGE(Reversed, FALSE);
                ACAStudentUnits2.SETFILTER("Supp. Cons. Mark Pref.", '%1', '^');
                IF ACAStudentUnits2.FIND('-') THEN BEGIN
                    SuppExists := TRUE;
                END;
                /*
                ACAStudentUnits2.RESET;
                ACAStudentUnits2.SETRANGE("Student No.",CRegs1."Student No.");
                //CAStudentUnits2.SETRANGE(Semester,CRegs1.Semester);
                ACAStudentUnits2.SETRANGE("Year Of Study",CRegs1."Year Of Study");
                ACAStudentUnits2.SETRANGE(Reversed,FALSE);
                ACAStudentUnits2.SETRANGE("CATs Marks Exists",FALSE);
                ACAStudentUnits2.SETRANGE("EXAMs Marks Exists",FALSE);
                IF ACAStudentUnits2.FIND('-') THEN BEGIN
                CRegs1."Semester Remarks"  :='SUPP';
                  END;
                
                //IF NOT CRegs1.Reversed THEN BEGIN
                ACAStudentUnitsz.RESET;
                ACAStudentUnitsz.SETRANGE(Reversed,FALSE);
                ACAStudentUnitsz.SETRANGE("Student No.",CRegs1."Student No.");
                //ACAStudentUnitsz.SETRANGE(Programme,CRegs1.Programme);
                ACAStudentUnitsz.SETRANGE("Year Of Study",CRegs1."Year Of Study");
                //ACAStudentUnitsz.SETRANGE("Academic Year",CRegs1."Academic Year");
                ACAStudentUnitsz.SETFILTER("Supp. Cons. Mark Pref.",'%1|%2|%3','e','c','x');
                IF ACAStudentUnitsz.FIND('-') THEN BEGIN
                  CRegs1."Supp. Yearly Remarks":='DTSC';
                  END;
                
                
                ACAStudentUnits2.RESET;
                ACAStudentUnits2.SETRANGE("Student No.",CRegs1."Student No.");
                ACAStudentUnits2.SETRANGE("Year Of Study",CRegs1."Year Of Study");
                ACAStudentUnits2.SETRANGE(Reversed,FALSE);
                ACAStudentUnits2.SETRANGE("CATs Marks Exists",FALSE);
                //ACAStudentUnits2.SETRANGE("EXAMs Marks Exists",FALSE);
                IF ACAStudentUnits2.FIND('-') THEN BEGIN
                CRegs1."Supp. Yearly Remarks"  :='DTSC';
                  END;
                
                ACAStudentUnits2.RESET;
                ACAStudentUnits2.SETRANGE("Student No.",CRegs1."Student No.");
                ACAStudentUnits2.SETRANGE("Year Of Study",CRegs1."Year Of Study");
                ACAStudentUnits2.SETRANGE(Reversed,FALSE);
                //ACAStudentUnits2.SETRANGE("CATs Marks Exists",FALSE);
                ACAStudentUnits2.SETRANGE("EXAMs Marks Exists",FALSE);
                IF ACAStudentUnits2.FIND('-') THEN BEGIN
                CRegs1."Supp. Yearly Remarks"  :='DTSC';
                  END;
                  */
                // // // // // // ACAStudentUnitsz.RESET;
                // // // // // // ACAStudentUnitsz.SETRANGE(Reversed,FALSE);
                // // // // // // ACAStudentUnitsz.SETRANGE("Student No.",CRegs1."Student No.");
                // // // // // // ACAStudentUnitsz.SETRANGE("Year Of Study",CRegs1."Year Of Study");
                // // // // // // ACAStudentUnitsz.SETFILTER("Supp. Cons. Mark Pref.",'%1','x');
                // // // // // // IF NOT ACAStudentUnitsz.FIND('-') THEN BEGIN
                // // // // // // ACAStudentUnitsz.RESET;
                // // // // // // ACAStudentUnitsz.SETRANGE(Reversed,FALSE);
                // // // // // // ACAStudentUnitsz.SETRANGE("Student No.",CRegs1."Student No.");
                // // // // // // ACAStudentUnitsz.SETRANGE("Year Of Study",CRegs1."Year Of Study");
                // // // // // // ACAStudentUnitsz.SETFILTER("Supp. Cons. Mark Pref.",'%1','c');
                // // // // // // ACAStudentUnitsz.SETFILTER("Special Exam",'<>%1',ACAStudentUnitsz."Special Exam"::" ");
                // // // // // // IF ACAStudentUnitsz.FIND('-') THEN BEGIN
                // // // // // //  IF ACAStudentUnitsz."Special Exam"=ACAStudentUnitsz."Special Exam"::Special THEN
                // // // // // //  CRegs1."Supp. Yearly Remarks":='SPECIAL';
                // // // // // //  IF ACAStudentUnitsz."Special Exam"=ACAStudentUnitsz."Special Exam"::Suspension THEN
                // // // // // //  CRegs1."Supp. Yearly Remarks":='SUSPENDED';
                // // // // // //  END;
                // // // // // //  END;


                //END;

                //IF (CRegs1."Supp. Yearly Remarks" IN ['PASS','SUPP']) THEN BEGIN
                // // IF CRegs1."Special Exam Exists"=TRUE THEN BEGIN
                // //  IF ((CRegs1."Supp. Yearly Remarks"='SUPP')) THEN
                // //    CRegs1."Supp. Yearly Remarks":=CRegs1."Supp. Yearly Remarks"+'/SPECIAL'
                // //  ELSE IF NOT ((CRegs1."Supp. Yearly Remarks"='DTSC')) THEN  CRegs1."Supp. Yearly Remarks":='SPECIAL';
                // //  END;
                //END;

                // // // // // IF CRegs1."Supp. Yearly Remarks"='SPECIAL' THEN BEGIN
                // // // // //  IF SuppExists THEN
                // // // // //    CRegs1."Supp. Yearly Remarks":='SUPP/SPECIAL';
                // // // // // // ELSE IF NOT ((CRegs1."Supp. Yearly Remarks"='DTSC')) THEN  CRegs1."Supp. Yearly Remarks":='SPECIAL';
                // // // // //  END;

                // // // // // //  ACAStudentUnitsz.RESET;
                // // // // // // ACAStudentUnitsz.SETRANGE(Reversed,FALSE);
                // // // // // // ACAStudentUnitsz.SETRANGE("Student No.",CRegs1."Student No.");
                // // // // // // ACAStudentUnitsz.SETRANGE("Year Of Study",CRegs1."Year Of Study");
                // // // // // // ACAStudentUnitsz.SETFILTER("Supp. Cons. Mark Pref.",'%1|%2','e','x');
                // // // // // // IF ACAStudentUnitsz.FIND('-') THEN BEGIN
                // // // // // // // // ACAStudentUnitsz.RESET;
                // // // // // // // // ACAStudentUnitsz.SETRANGE(Reversed,FALSE);
                // // // // // // // // ACAStudentUnitsz.SETRANGE("Student No.",CRegs1."Student No.");
                // // // // // // // // ACAStudentUnitsz.SETRANGE("Year Of Study",CRegs1."Year Of Study");
                // // // // // // // // ACAStudentUnitsz.SETFILTER("Supp. Cons. Mark Pref.",'%1','e');
                // // // // // // // // IF ACAStudentUnitsz.FIND('-') THEN BEGIN
                // // // // // //  CRegs1."Supp. Yearly Remarks":='DTSC';
                // // // // // // // END;
                // // // // // //  END;

                // // // ACAStudentUnitsz.RESET;
                // // // ACAStudentUnitsz.SETRANGE(Reversed,FALSE);
                // // // ACAStudentUnitsz.SETRANGE("Student No.",CRegs1."Student No.");
                // // // ACAStudentUnitsz.SETRANGE("Year Of Study",CRegs1."Year Of Study");
                // // // ACAStudentUnitsz.SETFILTER("Supp. Cons. Mark Pref.",'%1','x');
                // // // IF ACAStudentUnitsz.FIND('-') THEN BEGIN
                // // //  CRegs1."Supp. Yearly Remarks":='DTSC';
                // // //  END;


                Customer2.RESET;
                Customer2.SETRANGE("No.", CRegs1."Student No.");
                IF Customer2.FIND('-') THEN BEGIN
                    IF NOT ((Customer2.Status = Customer2.Status::Registration)) THEN
                        IF NOT ((Customer2.Status = Customer2.Status::Current)) THEN BEGIN
                            // IF ((Customer2.Status<>Customer2.Status::Current) AND  (Customer2.Status<>Customer2.Status::Registration)) THEN
                            CRegs1."Supp. Yearly Remarks" := FORMAT(Customer2.Status);
                        END;
                END;

                CRegs1."Supp. Cummulative Average" := CummulativeAverage;
                CRegs1."Supp. Cummulative Grade" := CummulativeGrade;
                CRegs1.Award := CummulativeReMarks;

                ACAStudentUnits2.RESET;
                ACAStudentUnits2.SETRANGE("Student No.", CRegs1."Student No.");
                ACAStudentUnits2.SETRANGE(Reversed, FALSE);
                ACAStudentUnits2.SETRANGE("Year Of Study", CRegs1."Year Of Study");
                ACAStudentUnits2.SETRANGE("CATs Marks Exists", FALSE);
                ACAStudentUnits2.SETRANGE("EXAMs Marks Exists", FALSE);
                IF ACAStudentUnits2.FIND('-') THEN BEGIN
                    //CRegs1."Supp. Yearly Remarks":='SUPP';
                END;

                CRegs1.MODIFY;

                // CRegs1.VALIDATE(CRegs1.Stage);

            end;

            trigger OnPreDataItem()
            begin
                //"ACA-Exam Results".SETRANGE("ACA-Exam Results"."User Name",UserID);

                //Reset Exam Status
                ACACourseRegistration.RESET;
                ACACourseRegistration.COPYFILTERS(CRegs1);
                //IF (CRegs1.GETFILTER(CRegs1."Academic Year"))<>'' THEN
                //  ACACourseRegistration.SETRANGE("Academic Year",(CRegs1.GETFILTER(CRegs1."Academic Year")));
                IF ACACourseRegistration.FIND('-') THEN
                    REPEAT
                        ACACourseRegistration."Supp. Yearly Remarks" := '';
                        ACACourseRegistration.MODIFY;
                    UNTIL ACACourseRegistration.NEXT = 0;
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

    trigger OnPostReport()
    begin
        progress.CLOSE;
    end;

    trigger OnPreReport()
    begin
        progress.OPEN('Processing 7 of 7.\Computing Final Averages......\No.: #1########################################\Prog.: #2########################################' +
        '\Sem.: #3########################################\Stage: #4########################################');
    end;

    var
        incompleteExists: Boolean;

        progress: Dialog;
        TotalYearlyMarks: Decimal;
        YearlyAverage: Decimal;
        YearlyGrade: Code[2];
        YearlyFailedUnits: Integer;
        YearlyTotalUnits: Integer;
        YearlyReMarks: Code[250];
        ACAGradingSystemSetup: Record 61599;
        ACAProgramme: Record 61511;
        TotalSemesterMarks: Decimal;
        SemesterFailedUnits: Integer;
        SemesterTotalUnits: Integer;
        SemesterAverage: Decimal;
        SemesterGrade: Code[2];
        SemesterReMarks: Code[250];
        TotalCummulativeMarks: Decimal;
        CummulativeFailedUnits: Integer;
        CummulativeTotalUnits: Integer;
        CummulativeAverage: Decimal;
        CummulativeGrade: Code[2];
        CummulativeReMarks: Code[250];
        FailedUnits: Text[250];
        StatusRemarks: Text[20];
        ACAStudentUnits2: Record 61549;
        ACAResultsStatus: Record 61739;
        Customer: Record 18;
        LubricIdentified: Boolean;
        ACACourseRegistration: Record 61532;
        YearlyCfFail: Decimal;
        SemesterCfFail: Decimal;
        CummCFFauil: Decimal;
        Customer2: Record 18;
        SuppCummAverage: Decimal;
        ACAProgCatTranscriptComm: Record 78020;
}

