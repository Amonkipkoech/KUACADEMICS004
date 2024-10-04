report 51202 "Student Balance Per Stage"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Student Balance Per Stage.rdl';

    dataset
    {
        dataitem("ACA-Programme Stages"; "ACA-Programme Stages")
        {
            DataItemTableView = SORTING(Code);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Date Filter", "Semester Filter", "Campus Filter", "Code", "Intake Filter";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            /* column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            } */
            column(USERID; USERID)
            {
            }
            column(BALANCES_AS_AT____Programme_Stages__GETFILTER__Date_Filter__; 'BALANCES AS AT ' + "ACA-Programme Stages".GETFILTER("Date Filter"))
            {
            }
            column(Programme_Stages__GETFILTER__Campus_Filter__; "ACA-Programme Stages".GETFILTER("Campus Filter"))
            {
            }
            column(Balance_; 'Balance')
            {
            }
            column(Programme_Stages_Description; Description)
            {
            }
            column(Programme_Stages_Code; Code)
            {
            }
            column(GBal; GBal)
            {
            }
            column(Grand_Total_; 'Grand Total')
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Programme_Stages_Programme_Code; "Programme Code")
            {
            }
            dataitem("ACA-Programme"; "ACA-Programme")
            {
                DataItemLink = Code = FIELD("Programme Code");
                column(Programme_Code; Code)
                {
                }
                column(Programme_Description; Description)
                {
                }
                column(ProgBal; ProgBal)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    ProgBal := 0;
                    Prog := "ACA-Programme";
                    // Prog.SETFILTER(Prog."Date Filter",Programme.GETFILTER(Programme."Date Filter"));
                    Prog.CALCFIELDS(Prog."Total Balance");
                    CurrBalance := Prog."Total Balance";

                    Creg.RESET;
                    Creg.SETFILTER(Creg.Semester, "ACA-Programme Stages".GETFILTER("ACA-Programme Stages"."Semester Filter"));
                    Creg.SETRANGE(Creg.Stage, "ACA-Programme Stages".Code);
                    Creg.SETRANGE(Creg.Programmes, "ACA-Programme".Code);
                    Creg.SETRANGE(Creg.Reversed, FALSE);
                    Creg.SETFILTER(Creg.Session, "ACA-Programme Stages".GETFILTER("ACA-Programme Stages"."Intake Filter"));
                    IF Creg.FIND('-') THEN BEGIN
                        REPEAT
                            IF Cust.GET(Creg."Student No.") THEN BEGIN
                                Cust.SETFILTER(Cust."Date Filter", "ACA-Programme Stages".GETFILTER("ACA-Programme Stages"."Date Filter"));
                                Cust.CALCFIELDS(Cust.Balance);
                                ProgBal := ProgBal + Cust.Balance;
                                StageBal := StageBal + Cust.Balance;
                                GBal := GBal + Cust.Balance;
                            END;
                        UNTIL Creg.NEXT = 0;
                    END;

                    Prog.RESET;
                    Prog := "ACA-Programme";
                    Prog.SETFILTER(Prog."Date Filter", PrevDateStr);
                    Prog.CALCFIELDS(Prog."Total Balance");
                    PrevBalance := Prog."Total Balance";

                    TotalPrev := TotalPrev + PrevBalance;
                    TotalBal := TotalBal + CurrBalance;
                    //Programme.GETFILTER(Programme."Opening Date Filter")
                end;

                trigger OnPreDataItem()
                begin
                    "ACA-Programme".SETFILTER("ACA-Programme"."Date Filter", "ACA-Programme Stages".GETFILTER("ACA-Programme Stages"."Date Filter"));
                    "ACA-Programme".SETFILTER("ACA-Programme"."Campus Filter", "ACA-Programme Stages".GETFILTER("ACA-Programme Stages"."Campus Filter"));

                    // CurrBalance:=0;
                    //  EVALUATE(PrevDate,Programme.GETFILTER(Programme."Date Filter"));
                    //  ProgBal:=0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                /*
                 StageBal:=0;
                Creg.reset;
                Creg.setfilter(Creg.Semester,"Programme Stages".getfilter("Programme Stages"."Semester Filter"));
                Creg.setrange(Creg.Stage,"Programme Stages".Code);
                if Creg.find('-') then begin
                repeat
                if Cust.get(Creg."Student No.") then begin
                Cust.setfilter(Cust."Date Filter","Programme Stages".getfilter("Programme Stages"."Date Filter"));
                Cust.calcfields(Cust.Balance);
                StageBal:=StageBal+Cust.Balance;
                end;
                until Creg.next=0;
                end;
                */

            end;

            trigger OnPostDataItem()
            begin
                StageBal := 0;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO(Code);
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
        TotalBal: Decimal;
        PrevBalance: Decimal;
        CurrBalance: Decimal;
        Prog: Record 61511;
        PrevDate: Date;
        PrevDateStr: Text[30];
        TotalPrev: Decimal;
        Creg: Record 61532;
        Cust: Record 18;
        StageBal: Decimal;
        ProgBal: Decimal;
        GBal: Decimal;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

