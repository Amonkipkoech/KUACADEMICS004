report 51535 "KCA - Summary Aging Simp."
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/KCA - Summary Aging Simp..rdl';
    Caption = 'Customer - Summary Aging Simp.';

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {
            RequestFilterFields = Programmes, Stage, Semester, "Student Type";
            column(USERID; USERID)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(STRSUBSTNO_Text001_FORMAT_StartDate__; STRSUBSTNO(Text001, FORMAT(StartDate)))
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
#pragma warning disable AL0667
            column(CurrReport_PAGENO; CurrReport.PAGENO)
#pragma warning restore AL0667
            {
            }
            column(Customer_TABLECAPTION__________CustFilter; Customer.TABLECAPTION + ': ' + CustFilter)
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
            column(All_amounts_are_in_LCYCaption; All_amounts_are_in_LCYCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Customer___Summary_Aging_Simp_Caption; Customer___Summary_Aging_Simp_CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_1__Control29Caption; CustBalanceDueLCY_1__Control29CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_2__Control28Caption; CustBalanceDueLCY_2__Control28CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_3__Control27Caption; CustBalanceDueLCY_3__Control27CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_4__Control26Caption; CustBalanceDueLCY_4__Control26CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_5__Control25Caption; CustBalanceDueLCY_5__Control25CaptionLbl)
            {
            }
            column(Customer_NameCaption; Customer.FIELDCAPTION(Name))
            {
            }
            column(Customer__No__Caption; Customer.FIELDCAPTION("No."))
            {
            }
            column(TotalCaption; TotalCaptionLbl)
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
                RequestFilterFields = "No.", "Search Name", "Customer Posting Group", "Statistics Group", "Payment Terms Code";
                column(Customer__No__; "No.")
                {
                }
                column(Customer_Name; Name)
                {
                }
                column(CustBalanceDueLCY_5__Control25; CustBalanceDueLCY[5])
                {
                    AutoFormatType = 1;
                }
                column(CustBalanceDueLCY_4__Control26; CustBalanceDueLCY[4])
                {
                    AutoFormatType = 1;
                }
                column(CustBalanceDueLCY_3__Control27; CustBalanceDueLCY[3])
                {
                    AutoFormatType = 1;
                }
                column(CustBalanceDueLCY_2__Control28; CustBalanceDueLCY[2])
                {
                    AutoFormatType = 1;
                }
                column(CustBalanceDueLCY_1__Control29; CustBalanceDueLCY[1])
                {
                    AutoFormatType = 1;
                }

                trigger OnAfterGetRecord()
                begin
                    PrintCust := FALSE;
                    FOR i := 1 TO 5 DO BEGIN
                        DtldCustLedgEntry.SETCURRENTKEY("Customer No.", "Initial Entry Due Date", "Posting Date");
                        DtldCustLedgEntry.SETRANGE("Customer No.", "No.");
                        DtldCustLedgEntry.SETRANGE("Posting Date", 0D, StartDate);
                        DtldCustLedgEntry.SETRANGE("Initial Entry Due Date", PeriodStartDate[i], PeriodStartDate[i + 1] - 1);
                        DtldCustLedgEntry.CALCSUMS("Amount (LCY)");
                        CustBalanceDueLCY[i] := CustBalanceDueLCY[i] + DtldCustLedgEntry."Amount (LCY)";
                        IF CustBalanceDueLCY[i] <> 0 THEN
                            PrintCust := TRUE;
                    END;
                    IF NOT PrintCust THEN
                        CurrReport.SKIP;
                end;

                trigger OnPreDataItem()
                begin
#pragma warning disable AL0667
                    CurrReport.CREATETOTALS(CustBalanceDueLCY);
#pragma warning restore AL0667
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
        PeriodStartDate[5] := StartDate;
        PeriodStartDate[6] := 12310909D;
        FOR i := 4 DOWNTO 2 DO
            PeriodStartDate[i] := CALCDATE('<-30D>', PeriodStartDate[i + 1]);
    end;

    var
        Text001: Label 'As of %1';
        DtldCustLedgEntry: Record 379;
        StartDate: Date;
        CustFilter: Text[250];
        PeriodStartDate: array[6] of Date;
        CustBalanceDueLCY: array[5] of Decimal;
        PrintCust: Boolean;
        i: Integer;
        All_amounts_are_in_LCYCaptionLbl: Label 'All amounts are in LCY';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Customer___Summary_Aging_Simp_CaptionLbl: Label 'Customer - Summary Aging Simp.';
        CustBalanceDueLCY_1__Control29CaptionLbl: Label 'Over 90 days';
        CustBalanceDueLCY_2__Control28CaptionLbl: Label '61-90 days';
        CustBalanceDueLCY_3__Control27CaptionLbl: Label '31-60 days';
        CustBalanceDueLCY_4__Control26CaptionLbl: Label '0-30 days';
        CustBalanceDueLCY_5__Control25CaptionLbl: Label 'Not Due';
        TotalCaptionLbl: Label 'Total';
}

