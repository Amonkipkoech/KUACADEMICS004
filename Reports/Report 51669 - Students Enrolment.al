/// <summary>
/// Report Students Enrolment (ID 51669).
/// </summary>
report 51669 "Students Enrolment"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Students Enrolment.rdl';

    dataset
    {
        dataitem(DataItem1410; 61511)
        {
            DataItemTableView = SORTING(Category)
                                WHERE("Student Registered" = FILTER(> 0));
            RequestFilterFields = Category, "Semester Filter", "Norminal Registered";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
#pragma warning disable AL0667
            column(CurrReport_PAGENO; CurrReport.PAGENO)
#pragma warning restore AL0667
            {
            }
            column(USERID; USERID)
            {
            }
            column(YR_1_; YR[1])
            {
            }
            column(YR_2_; YR[2])
            {
            }
            column(YR_3_; YR[3])
            {
            }
            column(YR_4_; YR[4])
            {
            }
            column(YR_5_; YR[5])
            {
            }
            column(JAB__________SSP_; 'JAB          SSP')
            {
            }
            column(JAB__________SSP__Control1102755042; 'JAB          SSP')
            {
            }
            column(JAB__________SSP__Control1102755043; 'JAB          SSP')
            {
            }
            column(JAB__________SSP__Control1102755044; 'JAB          SSP')
            {
            }
            column(JAB__________SSP__Control1102755045; 'JAB          SSP')
            {
            }
            column(M_________F_; 'M         F')
            {
            }
            column(M_________F__Control1102755047; 'M         F')
            {
            }
            column(M_________F__Control1102755048; 'M         F')
            {
            }
            column(M_________F__Control1102755049; 'M         F')
            {
            }
            column(M_________F__Control1102755050; 'M         F')
            {
            }
            column(TOTALS_; 'TOTALS')
            {
            }
            column(JAB__________SSP__Control1102755027; 'JAB          SSP')
            {
            }
            column(M_________F__Control1102755028; 'M         F')
            {
            }
            column(Programme_Category; Category)
            {
            }
            column(Programme_Code; Code)
            {
            }
            column(Programme_Description; Description)
            {
            }
            column(JF_5_; JF[5])
            {
            }
            column(JF_5__Control1102755032; JF[5])
            {
            }
            column(JF_4_; JF[4])
            {
            }
            column(JF_4__Control1102755034; JF[4])
            {
            }
            column(JF_3_; JF[3])
            {
            }
            column(JF_3__Control1102755036; JF[3])
            {
            }
            column(JF_2_; JF[2])
            {
            }
            column(JF_2__Control1102755038; JF[2])
            {
            }
            column(JF_1_; JF[1])
            {
            }
            column(JM_1_; JM[1])
            {
            }
            column(JF_5__JF_4__JF_3__JF_2__JF_1_; JF[5] + JF[4] + JF[3] + JF[2] + JF[1])
            {
            }
            column(JF_5__JF_4__JF_3__JF_2__JF_1__Control1102755030; JF[5] + JF[4] + JF[3] + JF[2] + JF[1])
            {
            }
            column(JFT_5_; JFT[5])
            {
            }
            column(JFT_5__Control1102755017; JFT[5])
            {
            }
            column(JFT_4_; JFT[4])
            {
            }
            column(JFT_4__Control1102755019; JFT[4])
            {
            }
            column(JFT_3_; JFT[3])
            {
            }
            column(JFT_3__Control1102755021; JFT[3])
            {
            }
            column(JFT_2_; JFT[2])
            {
            }
            column(JFT_2__Control1102755023; JFT[2])
            {
            }
            column(JFT_1_; JFT[1])
            {
            }
            column(JMT_1_; JMT[1])
            {
            }
            column(JFT_5__JFT_4__JFT_3__JFT_2__JFT_1_; JFT[5] + JFT[4] + JFT[3] + JFT[2] + JFT[1])
            {
            }
            column(JFT_5__JFT_4__JFT_3__JFT_2__JFT_1__Control1102755052; JFT[5] + JFT[4] + JFT[3] + JFT[2] + JFT[1])
            {
            }
            column(STUDENTS_ENROLMENT_STATISTICSCaption; STUDENTS_ENROLMENT_STATISTICSCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Programme_CodeCaption; FIELDCAPTION(Code))
            {
            }
            column(Programme_DescriptionCaption; FIELDCAPTION(Description))
            {
            }

            trigger OnAfterGetRecord()
            begin
                FOR i := 1 TO 5 DO BEGIN
                    Prog.RESET;
                    Prog.SETRANGE(Prog.Code);
                    Prog.SETFILTER(Prog."Semester Filter", GETFILTER("Semester Filter"));
                    Prog.SETFILTER(Prog."Study Year Filter", YRCode[i]);
                    // Prog.setfilter(Prog."Settlement Type Filter",'JAB');
                    IF Prog.FIND('-') THEN BEGIN
                        Prog.CALCFIELDS(Prog."Total JAB Female");
                        Prog.CALCFIELDS(Prog."Total JAB Male");
                        Prog.CALCFIELDS(Prog."Total SSP Female");
                        Prog.CALCFIELDS(Prog."Total SSP Male");

                        JM[i] := Prog."Total JAB Female";
                        JF[i] := Prog."Total JAB Male";
                        SF[i] := Prog."Total SSP Female";
                        SM[i] := Prog."Total SSP Male";

                        JMT[i] := JMT[i] + Prog."Total JAB Female";
                        JFT[i] := JFT[i] + Prog."Total JAB Male";
                        SFT[i] := SFT[i] + Prog."Total SSP Female";
                        SMT[i] := SMT[i] + Prog."Total SSP Male";

                    END;
                END;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO(Category);

                StudyYear.RESET;
                //StudyYear.SETRANGE(StudyYear.Unit,TRUE);
                IF StudyYear.FIND('-') THEN BEGIN
                    REPEAT
                        i := i + 1;
                        YRCode[i] := StudyYear.Programmes;
                        YR[i] := StudyYear.Stage;
                    UNTIL StudyYear.NEXT = 0;
                END;

                Creg.RESET;
                Creg.SETFILTER(Creg.Programmes, GETFILTER(Code));
                Creg.SETFILTER(Creg.Semester, GETFILTER("Semester Filter"));
                IF Creg.FIND('-') THEN BEGIN
                    REPEAT
                        IF STRLEN(Creg."Student No.") > 1 THEN BEGIN
                            //Creg."Sem Pass Count":=COPYSTR(Creg."Student No.",(STRLEN(Creg."Student No.")-1),STRLEN(Creg."Student No."));
                            //Creg.MODIFY;
                        END;
                    UNTIL Creg.NEXT = 0;
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

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        StudyYear: Record 61548;
        YR: array[100] of Code[20];
        JM: array[100] of Integer;
        JF: array[100] of Integer;
        SM: array[100] of Integer;
        SF: array[100] of Integer;
        i: Integer;
        YRCode: array[100] of Code[20];
        Creg: Record 61532;
        Prog: Record 61511;
        JMT: array[100] of Integer;
        JFT: array[100] of Integer;
        SMT: array[100] of Integer;
        SFT: array[100] of Integer;
        STUDENTS_ENROLMENT_STATISTICSCaptionLbl: Label 'STUDENTS ENROLMENT STATISTICS';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

