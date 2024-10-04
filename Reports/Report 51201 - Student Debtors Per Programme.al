report 81804 "Student Debtors Per Programme"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Student Debtors Per Programme.rdl';

    dataset
    {
        dataitem("ACA-Programme Stages"; "ACA-Programme Stages")
        {
            DataItemTableView = SORTING(Code);
            RequestFilterFields = "Date Filter", "Campus Filter", "Code";
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
            column(DEBTORS_AS_AT____Programme_Stages__GETFILTER__Date_Filter__; 'DEBTORS AS AT ' + "ACA-Programme Stages".GETFILTER("Date Filter"))
            {
            }
            column(Programme_Stages__GETFILTER__Campus_Filter__; "ACA-Programme Stages".GETFILTER("Campus Filter"))
            {
            }
            column(Programme_Stages__GETFILTER__Date_Filter__; "ACA-Programme Stages".GETFILTER("Date Filter"))
            {
            }
            column(PrevDateStr; PrevDateStr)
            {
            }
            column(Programme_Stages_Description; Description)
            {
            }
            column(Programme_Stages_Code; Code)
            {
            }
            column(TotalPrev; TotalPrev)
            {
            }
            column(TotalBal; TotalBal)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
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
                column(PrevBalance; PrevBalance)
                {
                }
                column(CurrBalance; CurrBalance)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    Prog := "ACA-Programme";
                    // Prog.SETFILTER(Prog."Date Filter",Programme.GETFILTER(Programme."Date Filter"));
                    Prog.CALCFIELDS(Prog."Total Balance");
                    CurrBalance := Prog."Total Balance";

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
                    EVALUATE(PrevDate, "ACA-Programme".GETFILTER("ACA-Programme"."Date Filter"));
                    PrevDate := PrevDate - 7;
                    PrevDateStr := FORMAT(PrevDate);
                    "ACA-Programme"."Opening Date Filter" := PrevDate;
                end;
            }

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
        Prog: Record "ACA-Programme";
        PrevDate: Date;
        PrevDateStr: Text[30];
        TotalPrev: Decimal;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        TotalCaptionLbl: Label 'Total';
}

