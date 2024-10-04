report 51536 "KCA - Summary Aging"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/KCA - Summary Aging.rdl';
    Caption = 'Customer - Summary Aging';

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {
            RequestFilterFields = Programmes, Stage, Semester;
            column(Customer_TABLECAPTION__________CustFilter; Customer.TABLECAPTION + ': ' + CustFilter)
            {
            }
            column(EmptyString; '')
            {
            }
            column(PeriodStartDate_5____1; PeriodStartDate[5] - 1)
            {
            }
            column(PeriodStartDate_4_; PeriodStartDate[4])
            {
            }
            column(USERID; USERID)
            {
            }
            column(PeriodStartDate_4____1; PeriodStartDate[4] - 1)
            {
            }
            column(PeriodStartDate_3_; PeriodStartDate[3])
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(PeriodStartDate_2_; PeriodStartDate[2])
            {
            }
            column(PeriodStartDate_3____1; PeriodStartDate[3] - 1)
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
            column(CustBalanceDueLCY_1_; CustBalanceDueLCY[1])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_2_; CustBalanceDueLCY[2])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_3_; CustBalanceDueLCY[3])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_4_; CustBalanceDueLCY[4])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_5_; CustBalanceDueLCY[5])
            {
                AutoFormatType = 1;
            }
            column(TotalCustBalanceLCY; TotalCustBalanceLCY)
            {
                AutoFormatType = 1;
            }
            column(LineTotalCustBalanceCaption; LineTotalCustBalanceCaptionLbl)
            {
            }
            column(CustBalanceDue_5_Caption; CustBalanceDue_5_CaptionLbl)
            {
            }
            column(Balance_DueCaption; Balance_DueCaptionLbl)
            {
            }
            column(CustBalanceDue_1_Caption; CustBalanceDue_1_CaptionLbl)
            {
            }
            column(Customer___Summary_AgingCaption; Customer___Summary_AgingCaptionLbl)
            {
            }
            column(All_amounts_are_in_LCYCaption; All_amounts_are_in_LCYCaptionLbl)
            {
            }
            column(Customer_NameCaption; Customer.FIELDCAPTION(Name))
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Customer__No__Caption; Customer.FIELDCAPTION("No."))
            {
            }
            column(Total__LCY_Caption; Total__LCY_CaptionLbl)
            {
            }
            column(Course_Registration_Reg__Transacton_ID; "Reg. Transacton ID")
            {
            }
            column(Course_Registration_Student_No_; "Student No.")
            {
            }
            column(Course_Registration_Programme; Programmes)
            {
            }
            column(Course_Registration_Semester; Semester)
            {
            }
            column(Course_Registration_Register_for; "Register for")
            {
            }
            column(Course_Registration_Stage; Stage)
            {
            }
            column(Course_Registration_Unit; Unit)
            {
            }
            column(Course_Registration_Student_Type; "Student Type")
            {
            }
            column(Course_Registration_Entry_No_; "Entry No.")
            {
            }
            dataitem(Customer; Customer)
            {
                DataItemLink = "No." = FIELD("Student No.");
                DataItemTableView = SORTING("No.");
                RequestFilterFields = "No.", "Search Name", "Customer Posting Group", "Currency Filter";
                column(CustBalanceDueLCY_1__Control23; CustBalanceDueLCY[1])
                {
                    AutoFormatType = 1;
                }
                column(CustBalanceDueLCY_2__Control24; CustBalanceDueLCY[2])
                {
                    AutoFormatType = 1;
                }
                column(CustBalanceDueLCY_3__Control25; CustBalanceDueLCY[3])
                {
                    AutoFormatType = 1;
                }
                column(CustBalanceDueLCY_4__Control26; CustBalanceDueLCY[4])
                {
                    AutoFormatType = 1;
                }
                column(CustBalanceDueLCY_5__Control27; CustBalanceDueLCY[5])
                {
                    AutoFormatType = 1;
                }
                column(TotalCustBalanceLCY_Control28; TotalCustBalanceLCY)
                {
                    AutoFormatType = 1;
                }
                column(LineTotalCustBalance; LineTotalCustBalance)
                {
                    AutoFormatType = 1;
                }
                column(CustBalanceDue_5_; CustBalanceDue[5])
                {
                    AutoFormatType = 1;
                }
                column(CustBalanceDue_4_; CustBalanceDue[4])
                {
                    AutoFormatType = 1;
                }
                column(CustBalanceDue_3_; CustBalanceDue[3])
                {
                    AutoFormatType = 1;
                }
                column(CustBalanceDue_2_; CustBalanceDue[2])
                {
                    AutoFormatType = 1;
                }
                column(CustBalanceDue_1_; CustBalanceDue[1])
                {
                    AutoFormatType = 1;
                }
                column(Customer_Name; Name)
                {
                }
                column(Customer__No__; "No.")
                {
                }
                column(CustBalanceDueLCY_1__Control39; CustBalanceDueLCY[1])
                {
                    AutoFormatType = 1;
                }
                column(CustBalanceDueLCY_2__Control40; CustBalanceDueLCY[2])
                {
                    AutoFormatType = 1;
                }
                column(CustBalanceDueLCY_3__Control41; CustBalanceDueLCY[3])
                {
                    AutoFormatType = 1;
                }
                column(CustBalanceDueLCY_4__Control42; CustBalanceDueLCY[4])
                {
                    AutoFormatType = 1;
                }
                column(CustBalanceDueLCY_5__Control43; CustBalanceDueLCY[5])
                {
                    AutoFormatType = 1;
                }
                column(TotalCustBalanceLCY_Control44; TotalCustBalanceLCY)
                {
                    AutoFormatType = 1;
                }
                column(CustBalanceDueLCY_1__Control23Caption; CustBalanceDueLCY_1__Control23CaptionLbl)
                {
                }
                column(CustBalanceDueLCY_1__Control39Caption; CustBalanceDueLCY_1__Control39CaptionLbl)
                {
                }
                dataitem(DataItem5444; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = FILTER(1 ..));
                    column(LineTotalCustBalance_Control67; LineTotalCustBalance)
                    {
                        AutoFormatExpression = Currency2.Code;
                        AutoFormatType = 1;
                    }
                    column(CustBalanceDue_5__Control68; CustBalanceDue[5])
                    {
                        AutoFormatExpression = Currency2.Code;
                        AutoFormatType = 1;
                    }
                    column(CustBalanceDue_4__Control69; CustBalanceDue[4])
                    {
                        AutoFormatExpression = Currency2.Code;
                        AutoFormatType = 1;
                    }
                    column(CustBalanceDue_3__Control70; CustBalanceDue[3])
                    {
                        AutoFormatExpression = Currency2.Code;
                        AutoFormatType = 1;
                    }
                    column(CustBalanceDue_2__Control71; CustBalanceDue[2])
                    {
                        AutoFormatExpression = Currency2.Code;
                        AutoFormatType = 1;
                    }
                    column(CustBalanceDue_1__Control72; CustBalanceDue[1])
                    {
                        AutoFormatExpression = Currency2.Code;
                        AutoFormatType = 1;
                    }
                    column(Currency2_Code; Currency2.Code)
                    {
                    }
                    column(Customer_Name_Control74; Customer.Name)
                    {
                    }
                    column(Customer__No___Control75; Customer."No.")
                    {
                    }
                    column(Integer_Number; Number)
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        DtldCustLedgEntry: Record 379;
                    begin
                        IF Number = 1 THEN
                            Currency2.FIND('-')
                        ELSE
                            IF Currency2.NEXT = 0 THEN
                                CurrReport.BREAK;
                        Currency2.CALCFIELDS("Cust. Ledg. Entries in Filter");
                        IF NOT Currency2."Cust. Ledg. Entries in Filter" THEN
                            CurrReport.SKIP;

                        PrintLine := FALSE;
                        LineTotalCustBalance := 0;
                        FOR i := 1 TO 5 DO BEGIN
                            DtldCustLedgEntry.SETCURRENTKEY("Customer No.", "Initial Entry Due Date");
                            DtldCustLedgEntry.SETRANGE("Customer No.", Customer."No.");
                            DtldCustLedgEntry.SETRANGE("Initial Entry Due Date", PeriodStartDate[i], PeriodStartDate[i + 1] - 1);
                            DtldCustLedgEntry.SETRANGE("Currency Code", Currency2.Code);
                            DtldCustLedgEntry.CALCSUMS(Amount);
                            CustBalanceDue[i] := DtldCustLedgEntry.Amount;
                            IF CustBalanceDue[i] <> 0 THEN
                                PrintLine := TRUE;
                            LineTotalCustBalance := LineTotalCustBalance + CustBalanceDue[i];
                        END;
                    end;

                    trigger OnPreDataItem()
                    begin
                        IF PrintAmountsInLCY OR NOT PrintLine THEN
                            CurrReport.BREAK;
                        Currency2.RESET;
                        Currency2.SETRANGE("Customer Filter", Customer."No.");
                        Customer.COPYFILTER("Currency Filter", Currency2.Code);
                        IF (Customer.GETFILTER("Global Dimension 1 Filter") <> '') OR
                           (Customer.GETFILTER("Global Dimension 2 Filter") <> '')
                        THEN BEGIN
                            Customer.COPYFILTER("Global Dimension 1 Filter", Currency2."Global Dimension 1 Filter");
                            Customer.COPYFILTER("Global Dimension 2 Filter", Currency2."Global Dimension 2 Filter");
                        END;
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    DtldCustLedgEntry: Record 379;
                begin
                    PrintLine := FALSE;
                    LineTotalCustBalance := 0;
                    FOR i := 1 TO 5 DO BEGIN
                        DtldCustLedgEntry.SETCURRENTKEY("Customer No.", "Initial Entry Due Date");
                        DtldCustLedgEntry.SETRANGE("Customer No.", "No.");
                        DtldCustLedgEntry.SETRANGE("Initial Entry Due Date", PeriodStartDate[i], PeriodStartDate[i + 1] - 1);
                        DtldCustLedgEntry.CALCSUMS("Amount (LCY)");
                        CustBalanceDue[i] := CustBalanceDueLCY[i] + DtldCustLedgEntry."Amount (LCY)";
                        CustBalanceDueLCY[i] := CustBalanceDueLCY[i] + DtldCustLedgEntry."Amount (LCY)";
                        IF CustBalanceDue[i] <> 0 THEN
                            PrintLine := TRUE;
                        LineTotalCustBalance := LineTotalCustBalance + CustBalanceDueLCY[i];
                        TotalCustBalanceLCY := TotalCustBalanceLCY + CustBalanceDueLCY[i];
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    // CurrReport.CREATETOTALS(CustBalanceDue, CustBalanceDueLCY, TotalCustBalanceLCY);
                    Currency2.RESET;
                    Currency2.SETRANGE(Currency2.Code, '');
                    IF Currency2.FIND('-') = FALSE THEN BEGIN
                        Currency2.Code := '';
                        Currency2.INSERT;
                    END;

                    IF Currency.FIND('-') THEN
                        REPEAT
                            Currency2.RESET;
                            Currency2.SETRANGE(Currency2.Code, Currency.Code);
                            IF Currency2.FIND('-') = FALSE THEN BEGIN

                                Currency2 := Currency;
                                Currency2.INSERT;
                            END;
                        UNTIL Currency.NEXT = 0;
                end;
            }
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

    trigger OnPreReport()
    begin
        CustFilter := Customer.GETFILTERS;
        FOR i := 3 TO 5 DO
            PeriodStartDate[i] := CALCDATE(PeriodLength, PeriodStartDate[i - 1]);
        PeriodStartDate[6] := 12310909D;
    end;

    var
        Currency: Record 4;
        Currency2: Record 4 temporary;
        CustFilter: Text[250];
        PrintAmountsInLCY: Boolean;
        PeriodLength: DateFormula;
        PeriodStartDate: array[6] of Date;
        CustBalanceDue: array[5] of Decimal;
        CustBalanceDueLCY: array[5] of Decimal;
        LineTotalCustBalance: Decimal;
        TotalCustBalanceLCY: Decimal;
        PrintLine: Boolean;
        i: Integer;
        LineTotalCustBalanceCaptionLbl: Label 'Balance';
        CustBalanceDue_5_CaptionLbl: Label 'after...';
        Balance_DueCaptionLbl: Label 'Balance Due';
        CustBalanceDue_1_CaptionLbl: Label '...before';
        Customer___Summary_AgingCaptionLbl: Label 'Customer - Summary Aging';
        All_amounts_are_in_LCYCaptionLbl: Label 'All amounts are in LCY';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Total__LCY_CaptionLbl: Label 'Total (LCY)';
        CustBalanceDueLCY_1__Control23CaptionLbl: Label 'Continued (LCY)';
        CustBalanceDueLCY_1__Control39CaptionLbl: Label 'Continued (LCY)';
}

