report 51493 "Summary Enrollment - Stage"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Summary Enrollment - Stage.rdl';

    dataset
    {
        dataitem("ACA-Programme"; "ACA-Programme")
        {
            DataItemTableView = SORTING(Code)
                                WHERE(Registered = FILTER(> 0));
            RequestFilterFields = "Code", "Stage Filter", "Semester Filter", "Student Type Filter", Faculty, "School Code", "Date Filter", Status, "Total JAB Female";
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
            column(TIME; TIME)
            {
            }
            column(Sems; Sems)
            {
            }
            column(Programme_Code; Code)
            {
            }
            column(Programme_Description; Description)
            {
            }
            column(Programme__Student_Registered_; "Student Registered")
            {
            }
            column(StReg; StReg)
            {
            }
            column(Summary_Enrollment_By_ProgrammeCaption; Summary_Enrollment_By_ProgrammeCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Filters_Caption; Filters_CaptionLbl)
            {
            }
            column(Programme_CodeCaption; FIELDCAPTION(Code))
            {
            }
            column(Programme_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Programme__Student_Registered_Caption; FIELDCAPTION("Student Registered"))
            {
            }
            column(TotalsCaption; TotalsCaptionLbl)
            {
            }
            column(TotalBilled; TBilled)
            {
            }
            column(Paid; Paid1)
            {
            }
            column(Billed; Billed)
            {
            }
            column(BalancePerc; "b%")
            {
            }
            column(TotalPerc; "T%")
            {
            }
            column(Balance; Bal)
            {
            }
            column(School; "ACA-Programme"."School Code")
            {
            }
            column(Logo; CompInf.Picture)
            {
            }
            column(CompName; CompInf.Name)
            {
            }
            column(FacultyName; FacultyName)
            {
            }
            dataitem("ACA-Programme Stages"; "ACA-Programme Stages")
            {
                DataItemLink = "Programme Code" = FIELD(Code);
                column(Code_ProgrammeStages; "ACA-Programme Stages".Code)
                {
                }
                column(Description_ProgrammeStages; "ACA-Programme Stages".Description)
                {
                }
                column(StudentRegistered_ProgrammeStages; "ACA-Programme Stages"."Student Registered")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    StudT := StudT + "ACA-Programme Stages"."Student Registered";
                    StReg := StudT;
                    Billed := 0;
                    Paid := 0;
                    Paid1 := 0;
                    "T%" := 0;
                    "b%" := 0;
                    Bal := 0;
                    Creg.RESET;
                    Creg.SETFILTER(Creg.Programmes, "ACA-Programme".Code);
                    Creg.SETFILTER(Creg.Semester, "ACA-Programme".GETFILTER("ACA-Programme"."Semester Filter"));
                    Creg.SETRANGE(Creg.Stage, "ACA-Programme Stages".Code);
                    //Creg.SETFILTER(Creg."Branch Filter",Programme.GETFILTER(Programme."Branch Filter"));
                    //  Creg.SETFILTER(Creg."Programme Category",Programme.GETFILTER(Programme.Category));
                    // Creg.SETFILTER(Creg."Register for",Programme.GETFILTER(Programme."Register For Filter"));
                    Creg.SETRANGE(Creg.Posted, TRUE);
                    Creg.SETRANGE(Creg.Reversed, FALSE);

                    // IF "Filter Options"="Filter Options"::Ledgers THEN
                    //  Creg.SETFILTER(Creg."Date Filter",'%1..%2',Sem.From,Sem."To");
                    Creg.SETRANGE(Creg.Posted, TRUE);
                    Creg.SETRANGE(Creg.Reversed, FALSE);
                    IF Creg.FIND('-') THEN BEGIN
                        REPEAT
                            /*
                            // IF "Filter Options"="Filter Options"::Registration THEN BEGIN
                            // Creg.CALCFIELDS(Creg."Total Receipted");
                             Creg.CALCFIELDS(Creg."Billed Amount");
                             Creg.CALCFIELDS(Creg.Balance);
                             Billed:=Billed+Creg."Billed Amount";
                             Paid1:=Paid1+Creg."Total Receipted";
                            // Paid:=Paid1;
                             TBilled:=TBilled+Creg."Billed Amount";
                             TPaid:=TPaid+Creg."Total Receipted";

                             END ELSE BEGIN
                             */
                            Creg.CALCFIELDS(Creg."Total Billed");
                            Creg.CALCFIELDS(Creg."Total Paid");
                            Creg.CALCFIELDS(Creg.Balance);
                            Billed := Billed + Creg."Total Billed";
                            Paid1 := Paid1 + Creg."Total Paid";
                            TBilled := TBilled + Creg."Total Billed";
                            TPaid := TPaid + Creg."Total Paid";
                            // END;
                            Bal := Billed - Paid1;
                            IF (Paid1 <> 0) AND (Billed <> 0) THEN
                                "b%" := (Paid / Billed) * 100;
                        UNTIL Creg.NEXT = 0;
                    END;
                    IF (TPaid <> 0) AND (TBilled <> 0) THEN
                        "T%" := (TPaid / TBilled) * 100;

                end;
            }

            trigger OnAfterGetRecord()
            begin
                DimmRec.RESET;
                DimmRec.SETRANGE(DimmRec.Code, "ACA-Programme"."School Code");
                IF DimmRec.FIND('-') THEN BEGIN
                    FacultyName := DimmRec.Name;
                END;

                "ACA-Programme".CALCFIELDS("ACA-Programme"."Full Time Budget");
                "ACA-Programme".CALCFIELDS("ACA-Programme"."Part Time Budget");
                TotRegPartTime := TotRegPartTime + "Registered Part Time";
                TotfullTime := TotfullTime + "Registered Full Time";
                StReg := StReg + "Student Registered";
                PaidParttime := PaidParttime + "Paid Part Time";
                PaidFullTime := PaidFullTime + "Paid Full Time";
                TotPaid := TotPaid + Paid;
                TBudget := TBudget + "ACA-Programme"."Full Time Budget" + "ACA-Programme"."Part Time Budget";
                TBFull := TBFull + "ACA-Programme"."Full Time Budget";
                TBPart := TBPart + "ACA-Programme"."Part Time Budget";
            end;

            trigger OnPreDataItem()
            begin
                Sems := "ACA-Programme".GETFILTER("ACA-Programme"."Semester Filter");

                TotRegPartTime := 0;
                TotfullTime := 0;
                StReg := 0;
                PaidParttime := 0;
                PaidFullTime := 0;
                TotPaid := 0;

                CompInf.GET;
                //CompInf.CALCFIELDS(CompInf.Picture);
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
        Summary_Enrollment_By_ProgrammeCaptionLbl: Label 'Summary Enrollment By Programme';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Filters_CaptionLbl: Label 'Filters:';
        TotalsCaptionLbl: Label 'Totals';
        TotfullTime: Decimal;
        TotRegPartTime: Decimal;
        StReg: Decimal;
        PaidParttime: Decimal;
        PaidFullTime: Decimal;
        TotPaid: Decimal;
        Prog: Text[250];
        TBudget: Decimal;
        TBFull: Decimal;
        TBPart: Decimal;
        Creg: Record 61532;
        StudT: Decimal;
        TBilled: Decimal;
        TPaid: Decimal;
        Paid: Decimal;
        Billed: Decimal;
        Receipts: Record 61538;
        "b%": Decimal;
        "T%": Decimal;

        "Filter Options": Option Registration,Ledgers;
        Paid1: Decimal;
        Sems: Code[20];
        Bal: Decimal;
        CompInf: Record 79;
        DimmRec: Record 349;
        FacultyName: Text[100];
}

