report 78009 "ACA-Compute Graduation Params"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(CourseRegDetails; "ACA-Course Registration")
        {
            DataItemTableView = WHERE(Status = FILTER(Current | Registration | Deceased),
                                      "Is Final Year Student" = FILTER(true));

            trigger OnAfterGetRecord()
            var
                SuppExists: Boolean;
                ACADGradStudPresidence: Record 66600;
                ACAClassGradRubrics: Record 78011;
                ACACourseRegistration: Record 61532;
            begin
                CustCheck.RESET;
                CustCheck.SETRANGE("No.", CourseRegDetails."Student No.");
                IF CustCheck.FIND('-') THEN BEGIN
                    CustCheck.CALCFIELDS(CustCheck."Has an Irregularity");
                END;
                progress.UPDATE(1, CourseRegDetails."Student No.");
                progress.UPDATE(2, CourseRegDetails.Programmes);
                progress.UPDATE(3, CourseRegDetails.Semester);
                progress.UPDATE(4, CourseRegDetails.Stage);
                CourseRegDetails."Yearly Graduating Average" := 0;
                CourseRegDetails."Final Graduating Average" := 0;
                CourseRegDetails."Yearly Grad. W. Average" := 0;
                CourseRegDetails."Final Grad. W.Average" := 0;
                CourseRegDetails."Final Clasification" := '';
                CourseRegDetails."Reason not to Graduate" := '';
                CourseRegDetails."Yearly Passed (To Graduate)" := FALSE;

                CourseRegDetails.CALCFIELDS(
                CourseRegDetails."Yearly Passed Cores",
                CourseRegDetails."Yearly Passed Electives",
                CourseRegDetails."Final  Grad. Req. Units",
                CourseRegDetails."Yearly Grad. Req. Units");
                CLEAR(PassedCores);
                CLEAR(PassedElectives);
                CLEAR(ReasonForNotGrad);
                CLEAR(ExpectedElectives);
                CLEAR(ToGraduate);
                ////////////////////////////////////////IF CourseRegDetails."Yearly Grad. Req. Units"<>0 THEN BEGIN
                ///////////////////////////////////////////Initializa all Graduating Units for the YoS
                ACAStudentUnits.RESET;
                ACAStudentUnits.SETRANGE("Student No.", CourseRegDetails."Student No.");
                ACAStudentUnits.SETRANGE("Year Of Study", CourseRegDetails."Year Of Study");
                ACAStudentUnits.SETRANGE("Reg. Reversed", FALSE);
                IF ACAStudentUnits.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        //ACAStudentUnits.CALCFIELDS("Unit Type (Flow)");
                        ACAStudentUnits."Include in Graduation" := FALSE;
                        //  ACAStudentUnits.CALCFIELDS(ACAStudentUnits."Supp. Failed");
                        IF ACAStudentUnits."Supp. Failed" = FALSE THEN BEGIN
                            ACAStudentUnits.Failed := FALSE;
                            // //  IF ACAStudentUnits."Unit Type (Flow)"= ACAStudentUnits."Unit Type (Flow)"::Core THEN BEGIN
                            //PassedCores:=PassedCores+ACAStudentUnits."Credit Hours";
                            ACAStudentUnits."Include in Graduation" := TRUE;
                            // //    END;
                        END ELSE
                            ACAStudentUnits.Failed := TRUE;
                        ACAStudentUnits.MODIFY;
                    END;
                    UNTIL ((ACAStudentUnits.NEXT = 0))
                END;
                CourseRegDetails.CALCFIELDS("Yearly Passed Cores", "Yearly Passed Electives", "Final Failed Courses");
                PassedCores := CourseRegDetails."Yearly Passed Cores";
                PassedElectives := CourseRegDetails."Yearly Passed Electives";
                IF CourseRegDetails."Yearly Grad. Req. Units" > PassedCores THEN
                    ExpectedElectives := CourseRegDetails."Yearly Grad. Req. Units" - PassedCores;
                IF PassedElectives > ExpectedElectives THEN PassedElectives := ExpectedElectives;
                ////PassedCores:=CourseRegDetails."Yearly Passed Cores";
                //Update all Passed Cores
                ///IF ((CourseRegDetails."Student No."='SC/00002/016') AND ((CourseRegDetails.Stage='Y2S2') OR (CourseRegDetails.Stage='Y3S1')))  THEN
                ACAStudentUnits.RESET;

                IF NOT ((PassedElectives + PassedCores) < CourseRegDetails."Yearly Grad. Req. Units") THEN BEGIN
                    // The Course Registration Meets the Graduation Criteria
                    ToGraduate := TRUE;
                END;
                IF CourseRegDetails."Final Failed Courses" > 0 THEN ToGraduate := FALSE;
                CourseRegDetails."Yearly Passed (To Graduate)" := ToGraduate;

                CourseRegDetails.CALCFIELDS(
                CourseRegDetails."Yearly Graduating Units Count",
                CourseRegDetails."Yearly Graduating Core Units",
                CourseRegDetails."Yearly Graduating Electives",
                CourseRegDetails."Yearly Grad. Req. Units",
                CourseRegDetails."Final  Graduating Units Count",
                CourseRegDetails."Final  Graduating Core Units",
                CourseRegDetails."Final  Graduating Electives",
                CourseRegDetails."Final  Grad. Req. Units",
                CourseRegDetails."Is Final Year Student",
                CourseRegDetails."Yearly Graduating Marks",
                CourseRegDetails."Final Graduating Marks",
                CourseRegDetails."Yearly Graduating Courses",
                CourseRegDetails."Final Graduating Courses",
                CourseRegDetails."Yearly Grad. Weighted Units",
                CourseRegDetails."Final Grad. Weighted Units",
                CourseRegDetails."Final Graduation YoS",
                CourseRegDetails."Yearly Passed Cores",
                CourseRegDetails."Yearly Passed Electives",
                CourseRegDetails."No. of Registrations",
                CourseRegDetails."Exists Where Not Graduating");

                IF CourseRegDetails."Yearly Graduating Courses" > 0 THEN
                    CourseRegDetails."Yearly Graduating Average" := ROUND((CourseRegDetails."Yearly Graduating Marks"
                    / CourseRegDetails."Yearly Graduating Courses"), 0.01, '=');
                IF CourseRegDetails."Final Graduating Courses" > 0 THEN
                    CourseRegDetails."Final Graduating Average" := ROUND((CourseRegDetails."Final Graduating Marks"
                    / CourseRegDetails."Final Graduating Courses"), 0.01, '=');
                IF CourseRegDetails."Yearly Graduating Units Count" > 0 THEN
                    CourseRegDetails."Yearly Grad. W. Average" := ROUND((CourseRegDetails."Yearly Grad. Weighted Units"
                    / CourseRegDetails."Yearly Graduating Units Count"), 0.01, '=');
                IF CourseRegDetails."Final  Graduating Units Count" > 0 THEN
                    CourseRegDetails."Final Grad. W.Average" := ROUND((CourseRegDetails."Final Grad. Weighted Units"
                    / CourseRegDetails."Final  Graduating Units Count"), 0.01, '=');

                CourseRegDetails."To Graduate" := ToGraduate;
                ACACourseRegistration336.RESET;
                ACACourseRegistration336.SETRANGE("Student No.", CourseRegDetails."Student No.");
                ACACourseRegistration336.SETFILTER(Reversed, '%1', FALSE);
                ACACourseRegistration336.SETFILTER(Options, '<>%1', '');
                IF ACACourseRegistration336.FIND('-') THEN BEGIN
                    CourseRegDetails.Options := ACACourseRegistration336.Options;
                END;

                IF ToGraduate = FALSE THEN BEGIN
                    CourseRegDetails."Reason not to Graduate" := 'INCOMPLETE';
                    CourseRegDetails."Final Clasification" := 'INCOMPLETE';
                END ELSE BEGIN
                    CourseRegDetails."Reason not to Graduate" := '';
                    IF CourseRegDetails."Final Graduating Average" > 0 THEN
                        CourseRegDetails."Final Clasification" := GetClassification(CourseRegDetails.Programmes, CourseRegDetails."Final Graduating Average",
                        CustCheck."Has an Irregularity");
                END;
                CourseRegDetails.CALCFIELDS(CourseRegDetails."Program Option (Flow)");
                ACAClassGradRubrics.RESET;
                ACAClassGradRubrics.SETRANGE(Code, CourseRegDetails."Final Clasification");
                IF ACAClassGradRubrics.FIND('-') THEN BEGIN


                    ACADGradStudPresidence.RESET;
                    ACADGradStudPresidence.SETRANGE("Student No.", CourseRegDetails."Student No.");
                    //ACADGradStudPresidence.SETRANGE("Graduation Academic Year",CourseRegDetails."Graduation Academic Year");
                    ACADGradStudPresidence.SETCURRENTKEY(ACADGradStudPresidence."Student No.", ACADGradStudPresidence.Presidence);
                    IF NOT ACADGradStudPresidence.FIND('+') THEN BEGIN
                        ACADGradStudPresidence.INIT;
                        ACADGradStudPresidence.VALIDATE(Comments, CourseRegDetails."Final Clasification");
                        ACADGradStudPresidence."Student No." := CourseRegDetails."Student No.";
                        ACADGradStudPresidence."Graduation Academic Year" := CourseRegDetails."Graduation Academic Year";
                        ACADGradStudPresidence.Presidence := ACAClassGradRubrics."Order No";
                        ACADGradStudPresidence."Program Code" := CourseRegDetails.Programmes;
                        ACADGradStudPresidence.INSERT;
                    END ELSE BEGIN
                        IF ACADGradStudPresidence.Presidence < ACAClassGradRubrics."Order No" THEN BEGIN
                            ACADGradStudPresidence.VALIDATE(Comments, ACAClassGradRubrics.Code);
                            ACADGradStudPresidence.Presidence := ACAClassGradRubrics."Order No";
                            CourseRegDetails."Final Clasification" := ACAClassGradRubrics.Code;
                            ACADGradStudPresidence."Program Code" := CourseRegDetails.Programmes;
                            ACADGradStudPresidence.MODIFY;
                        END;
                    END;

                END;

                IF CourseRegDetails."Final Clasification" = 'INCOMPLETE' THEN
                    CourseRegDetails."Class Status" := 'INCOMPLETE'
                ELSE
                    CourseRegDetails."Class Status" := 'PASS';
                CourseRegDetails.MODIFY;


                ClassificationMarksheetCntrl.RESET;
                ClassificationMarksheetCntrl.SETRANGE("Grad. Academic Year", CourseRegDetails."Graduation Academic Year");
                ClassificationMarksheetCntrl.SETRANGE("Programme Option", CourseRegDetails."Program Option (Flow)");
                ClassificationMarksheetCntrl.SETRANGE("Programme Code", CourseRegDetails.Programmes);
                ClassificationMarksheetCntrl.SETRANGE("Academic Year", CourseRegDetails."Academic Year");
                ClassificationMarksheetCntrl.SETRANGE("Year of Study", CourseRegDetails."Year Of Study");
                IF NOT ClassificationMarksheetCntrl.FIND('-') THEN BEGIN
                    //Insert
                    ClassificationMarksheetCntrl.INIT;
                    ClassificationMarksheetCntrl."Grad. Academic Year" := CourseRegDetails."Graduation Academic Year";
                    ClassificationMarksheetCntrl."Programme Code" := CourseRegDetails.Programmes;
                    ClassificationMarksheetCntrl."Programme Option" := CourseRegDetails."Program Option (Flow)";
                    ClassificationMarksheetCntrl."Academic Year" := CourseRegDetails."Academic Year";
                    ClassificationMarksheetCntrl."Year of Study" := CourseRegDetails."Year Of Study";
                    IF CourseRegDetails."Year Of Study" <> 0 THEN
                        ClassificationMarksheetCntrl.INSERT;
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

    trigger OnPostReport()
    begin
        progress.CLOSE;
    end;

    trigger OnPreReport()
    begin
        progress.OPEN('Computing Graduation Parameters......\Stud. No: #1###############################################' +
        '\Programme: #2###############################################\Semester: #3###############################################' +
        '\Stage: #4###############################################');
    end;

    var
        ACAStudentUnits: Record 61549;

        ACAGradingSystemSetup: Record 61599;

        PassedCores: Decimal;
        PassedElectives: Decimal;
        ExpectedElectives: Decimal;
        ReasonForNotGrad: Text[100];
        ToGraduate: Boolean;
        progress: Dialog;
        ACAProgramme2: Record 61511;

        ClassificationMarksheetCntrl: Record 78007;
        CustCheck: Record 18;
        ACACourseRegistration336: Record 61532;

    local procedure GetClassification(ProgramCode: Code[100]; AverageScore: Decimal; HasIrregularity: Boolean) Classification: Code[100]
    var
        ACAClassGradRubrics: Record 78011;
    begin
        CLEAR(Classification);
        ACAProgramme2.RESET;
        ACAProgramme2.SETRANGE(Code, ProgramCode);
        IF ACAProgramme2.FIND('-') THEN BEGIN
            ACAGradingSystemSetup.RESET;
            ACAGradingSystemSetup.SETRANGE(Category, ACAProgramme2."Exam Category");
            ACAGradingSystemSetup.SETFILTER("Lower Limit", '=%1|<%2', AverageScore, AverageScore);
            ACAGradingSystemSetup.SETFILTER("Upper Limit", '>%2|=%1', AverageScore, AverageScore);
            IF ACAGradingSystemSetup.FIND('-') THEN BEGIN
                IF HasIrregularity THEN BEGIN
                    ACAClassGradRubrics.RESET;
                    ACAClassGradRubrics.SETRANGE(Code, ACAGradingSystemSetup.Remarks);
                    IF ACAClassGradRubrics.FIND('-') THEN BEGIN
                        IF ACAClassGradRubrics."Alternate Rubric" <> '' THEN BEGIN
                            Classification := ACAClassGradRubrics."Alternate Rubric";
                        END ELSE BEGIN
                            Classification := ACAGradingSystemSetup.Remarks;
                        END;
                    END ELSE BEGIN
                        Classification := ACAGradingSystemSetup.Remarks;
                    END;
                END ELSE BEGIN
                    Classification := ACAGradingSystemSetup.Remarks;
                END;
            END;
        END;
    end;
}

