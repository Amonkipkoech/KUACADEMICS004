report 78056 "Exams Final Cummulative Resit2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Exams Final Cummulative Resit2.rdl';

    dataset
    {
        dataitem(ExamCoregcs; 66651)
        {
            DataItemTableView = SORTING(Programme, "Programme Option", "Student Number")
                                ORDER(Ascending)
                                WHERE("Resit Exists" = FILTER(false));
            PrintOnlyIfDetail = true;
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
                column(UnitDesc; CummResits.Description)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF StudNos <> CummResits."Student No." THEN BEGIN
                        StudNos := CummResits."Student No.";
                        seq += 1;
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                ACACummResitSerial.RESET;
                ACACummResitSerial.SETRANGE("User ID", USERID);
                ACACummResitSerial.SETRANGE("Academic Year", ExamCoregcs.GETFILTER("Academic Year"));
                ACACummResitSerial.SETRANGE(YoS, FORMAT(YosInteger));
                //ACACummResitSerial.SETRANGE("School Code",ExamCoregcs.GETFILTER("School Code"));
                ACACummResitSerial.SETRANGE("Stuent No.", ExamCoregcs."Student Number");
                IF ACACummResitSerial.FIND('-') THEN;
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
                ACACummResitSerial.SETRANGE("Academic Year", ExamCoregcs.GETFILTER("Academic Year"));
                ACACummResitSerial.SETRANGE(YoS, ExamCoregcs.GETFILTER("Year of Study"));
                ACACummResitSerial.SETRANGE("School Code", ExamCoregcs.GETFILTER("School Code"));
                IF ACACummResitSerial.FIND('-') THEN ACACummResitSerial.DELETEALL;

                CLEAR(seq);
                ACAExamCourseRegistration.RESET;
                ACAExamCourseRegistration.SETRANGE("Academic Year", ExamCoregcs.GETFILTER("Academic Year"));
                ACAExamCourseRegistration.SETRANGE("School Code", ExamCoregcs.GETFILTER("School Code"));
                ACAExamCourseRegistration.SETRANGE("Year of Study", YosInteger);
                ACAExamCourseRegistration.SETRANGE("Resit Exists", TRUE);
                //ACAExamCourseRegistration.SETCURRENTKEY(Programme,"Programme Option","Student Number");
                IF ACAExamCourseRegistration.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        ACACummResitSerial.INIT;
                        ACACummResitSerial."Stuent No." := ACAExamCourseRegistration."Student Number";
                        ACACummResitSerial."School Code" := ExamCoregcs.GETFILTER("School Code");
                        ACACummResitSerial."Academic Year" := ExamCoregcs.GETFILTER("Academic Year");
                        ACACummResitSerial.YoS := FORMAT(YosInteger);
                        ACACummResitSerial.Programme := ACAExamCourseRegistration.Programme;
                        //ACACummResitSerial."Cumm. Resit Serial":=seq;
                        //
                        ACACummResitSerial."User ID" := USERID;
                        IF ACACummResitSerial.INSERT THEN;
                    END;
                    UNTIL ACAExamCourseRegistration.NEXT = 0;
                END;


                ACACummResitSerial.RESET;
                ACACummResitSerial.SETRANGE("User ID", USERID);
                ACACummResitSerial.SETRANGE("Academic Year", ExamCoregcs.GETFILTER("Academic Year"));
                ACACummResitSerial.SETRANGE(YoS, ExamCoregcs.GETFILTER("Year of Study"));
                //ACACummResitSerial.SETRANGE("School Code",ExamCoregcs.GETFILTER("School Code"));
                ACACummResitSerial.SETCURRENTKEY(Programme, YoS, "Stuent No.", "Academic Year");
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

    var
        CompanyInformation: Record 79;
        Filters: Text[1024];
        ACAExamCourseRegistration: Record 66651;
        seq: Integer;
        StudNos: Code[20];
        ACACummResitSerial: Record 66658;
        YosInteger: Integer;
}

