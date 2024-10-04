report 50011 "ACA-Cummulative Halt List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/ACA-Cummulative Halt List.rdl';

    dataset
    {
        dataitem(ExamCoregcs; 66651)
        {
            DataItemTableView = SORTING(Programme, "Programme Option", "Student Number", "Category Order")
                                ORDER(Ascending)
                                WHERE(Classification = FILTER('RESIT LIST' | 'PASS LIST' | 'HALT'),
                                      "Resit Exists" = FILTER(true));
            RequestFilterFields = "Academic Year", "School Code", "Year of Study";
            column(Pic; CompanyInformation.Picture)
            {
            }
            column(CompMail; CompanyInformation."E-Mail" + '/' + CompanyInformation."Home Page")
            {
            }
            column(CompAddress; CompanyInformation.Address + ',' + CompanyInformation."Address 2" + ' ' + CompanyInformation.City)
            {
            }
            column(CompName; CompanyInformation.Name)
            {
            }
            column(Prog; ExamCoregcs.Programme)
            {
            }
            column(YoS; ExamCoregcs."Year of Study")
            {
            }
            column(AcadYear; ExamCoregcs."Academic Year")
            {
            }
            column(SchCode; ExamCoregcs."School Code")
            {
            }
            column(StudentNo; ExamCoregcs."Student Number")
            {
            }
            column(StudName; ExamCoregcs."Student Name")
            {
            }
            column(SchName; ExamCoregcs."School Name")
            {
            }
            column(Class; ExamCoregcs.Classification)
            {
            }
            column(ProgName; ExamCoregcs."Programme Name")
            {
            }
            column(Filters; Filters)
            {
            }
            column(seq; ACACummResitSerial."Cumm. Resit Serial")
            {
            }
            dataitem(CummResits; 61549)
            {
                DataItemLink = "Student No." = FIELD("Student Number");
                DataItemTableView = WHERE("Processed Marks" = FILTER(true),
                                          Passed = FILTER(false));
                column(UnitCode; CummResits.Unit)
                {
                }
                column(UnitDesc; ACAUnitsSubjects.Desription)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF StudNos <> CummResits."Student No." THEN BEGIN
                        StudNos := CummResits."Student No.";
                        seq += 1;
                    END;

                    ACAUnitsSubjects.RESET;
                    ACAUnitsSubjects.SETRANGE("Programme Code", CummResits.Programme);
                    ACAUnitsSubjects.SETRANGE(Code, CummResits.Unit);
                    ACAUnitsSubjects.SETFILTER(Desription, '<>%1', '');
                    IF ACAUnitsSubjects.FIND('-') THEN;
                end;
            }

            trigger OnAfterGetRecord()
            begin

                ExamCoregcs.CALCFIELDS("Resit Exists");
                IF (ExamCoregcs."Cumm Attained Units" < ExamCoregcs."Cumm. Required Stage Units") THEN
                    ExamCoregcs."Cummulative Fails" := ExamCoregcs."Cummulative Fails" +
                    (ExamCoregcs."Cumm. Required Stage Units" - ExamCoregcs."Cumm Attained Units");

                ACAStudentUnits.RESET;
                ACAStudentUnits.SETRANGE("Student No.", ExamCoregcs."Student Number");
                ACAStudentUnits.SETRANGE(Passed, FALSE);
                IF ACAStudentUnits.FIND('-') THEN
                    IF ACAStudentUnits.COUNT > 3 THEN BEGIN
                        ACACummResitSerial.RESET;
                        ACACummResitSerial.SETRANGE("User ID", USERID);
                        ACACummResitSerial.SETRANGE("Academic Year", ExamCoregcs.GETFILTER("Academic Year"));
                        ACACummResitSerial.SETRANGE(YoS, FORMAT(YosInteger));
                        ACACummResitSerial.SETRANGE("School Code", ExamCoregcs.GETFILTER("School Code"));
                        ACACummResitSerial.SETRANGE("Stuent No.", ExamCoregcs."Student Number");
                        IF ACACummResitSerial.FIND('-') THEN;

                        // // Customer.RESET;
                        // // Customer.SETRANGE("No.",ExamCoregcs."Student Number");
                        // // IF Customer.FIND('-') THEN
                        // // IF Customer."Cumm. Failed Courses">3 THEN BEGIN
                        // //  Customer.Status:=Customer.Status::Halt;
                        // //  Customer.MODIFY;
                        // //  END;
                    END ELSE
                        CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin
                CLEAR(Filters);
                CLEAR(YosInteger);
                CLEAR(seq);
                Filters := ExamCoregcs.GETFILTERS;
                IF EVALUATE(YosInteger, ExamCoregcs.GETFILTER("Year of Study")) THEN;
                ACACummResitSerial.RESET;
                ACACummResitSerial.SETRANGE("User ID", USERID);
                IF ACACummResitSerial.FIND('-') THEN ACACummResitSerial.DELETEALL;

                CLEAR(seq);
                ACAExamCourseRegistration.RESET;
                ACAExamCourseRegistration.SETRANGE("Academic Year", ExamCoregcs.GETFILTER("Academic Year"));
                ACAExamCourseRegistration.SETRANGE("School Code", ExamCoregcs.GETFILTER("School Code"));
                ACAExamCourseRegistration.SETRANGE("Year of Study", YosInteger);
                ACAExamCourseRegistration.SETFILTER(Classification, '%1|%2|%3', 'RESIT LIST', 'PASS LIST', 'HALT');
                ACAExamCourseRegistration.SETFILTER("Resit Exists", '=%1', TRUE);
                IF ACAExamCourseRegistration.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        ACAExamCourseRegistration.CALCFIELDS("Resit Exists");
                        IF (ACAExamCourseRegistration."Cumm Attained Units" < ACAExamCourseRegistration."Cumm. Required Stage Units") THEN
                            ACAExamCourseRegistration."Cummulative Fails" := ACAExamCourseRegistration."Cummulative Fails" +
                            (ACAExamCourseRegistration."Cumm. Required Stage Units" - ACAExamCourseRegistration."Cumm Attained Units");

                        ACAStudentUnits.RESET;
                        ACAStudentUnits.SETRANGE("Student No.", ACAExamCourseRegistration."Student Number");
                        ACAStudentUnits.SETRANGE(Passed, FALSE);
                        IF ACAStudentUnits.FIND('-') THEN
                            IF ACAStudentUnits.COUNT > 3 THEN BEGIN
                                ACACummResitSerial.INIT;
                                ACACummResitSerial."Stuent No." := ACAExamCourseRegistration."Student Number";
                                ACACummResitSerial."School Code" := ExamCoregcs.GETFILTER("School Code");
                                ACACummResitSerial."Academic Year" := ExamCoregcs.GETFILTER("Academic Year");
                                ACACummResitSerial.YoS := FORMAT(YosInteger);
                                ACACummResitSerial.Programme := ACAExamCourseRegistration.Programme;
                                ACACummResitSerial."User ID" := USERID;
                                IF ACACummResitSerial.INSERT THEN;
                            END;
                    END;
                    UNTIL ACAExamCourseRegistration.NEXT = 0;
                END;


                ACACummResitSerial.RESET;
                ACACummResitSerial.SETRANGE("User ID", USERID);
                ACACummResitSerial.SETRANGE("Academic Year", ExamCoregcs.GETFILTER("Academic Year"));
                ACACummResitSerial.SETRANGE(YoS, ExamCoregcs.GETFILTER("Year of Study"));
                ACACummResitSerial.SETRANGE("School Code", ExamCoregcs.GETFILTER("School Code"));
                ACACummResitSerial.SETCURRENTKEY(Programme, "Stuent No.");
                IF ACACummResitSerial.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        seq := seq + 1;
                        ACACummResitSerial."Cumm. Resit Serial" := seq;
                        ACACummResitSerial.MODIFY;
                    END;
                    UNTIL ACACummResitSerial.NEXT = 0;
                END;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

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
        CompanyInformation.RESET;
        IF CompanyInformation.FIND('-') THEN CompanyInformation.CALCFIELDS(Picture);
    end;

    trigger OnPostReport()
    begin
        // IF CONFIRM('Update HALT Status',FALSE)=TRUE THEN BEGIN
        //  REPORT.RUN(50012,FALSE,FALSE);
        //  END;
    end;

    var
        CompanyInformation: Record 79;
        Filters: Text[1024];
        ACAExamCourseRegistration: Record 66651;
        seq: Integer;
        StudNos: Code[20];
        ACACummResitSerial: Record 66658;
        YosInteger: Integer;
        ACAUnitsSubjects: Record 61517;
        ACAStudentUnits: Record 61549;
        Customer: Record 18;
}

