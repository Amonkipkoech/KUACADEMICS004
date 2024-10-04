/// <summary>
/// Report Yearly Fee Statement (ID 77706).
/// </summary>
report 77706 "Yearly Fee Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Yearly Fee Statement.rdl';
    Caption = 'Customer - Statement';

    dataset
    {
        dataitem(DataItem6836; 18)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(UPPERCASE_COMPANYNAME_; UPPERCASE(COMPANYNAME))
            {
            }
            column(pic; info.Picture)
            {
            }
            column(Reg_No; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(compEmail; info."E-Mail")
            {
            }
            column(add1; info.Address)
            {
            }
            column(add3; info."Address 2")
            {
            }
            column(compHomePage; info."Home Page")
            {
            }
            column(progName; progName)
            {
            }
            column(StartBalAdjLCY; StartBalAdjLCY)
            {
                AutoFormatType = 1;
            }
            column(CustBalanceLCY; CustBalanceLCY)
            {
                AutoFormatType = 1;
            }
            column(Customer__Debit_Amount_; "Debit Amount")
            {
            }
            column(StartBalanceLCY___StartBalAdjLCY____Cust__Ledger_Entry___Amount__LCY_____Correction___ApplicationRounding; StartBalanceLCY + StartBalAdjLCY + ledge."Amount (LCY)" + Correction + ApplicationRounding)
            {
                AutoFormatType = 1;
            }
            column(StartBalanceLCY; StartBalanceLCY)
            {
                AutoFormatType = 1;
            }
            column(Cust__Ledger_Entry___Amount__LCY_____Correction___ApplicationRounding; ledge."Amount (LCY)" + Correction + ApplicationRounding)
            {
                AutoFormatType = 1;
            }
            column(StartBalAdjLCY_Control67; StartBalAdjLCY)
            {
                AutoFormatType = 1;
            }
            column(StartBalanceLCY___StartBalAdjLCY; StartBalanceLCY + StartBalAdjLCY)
            {
                AutoFormatType = 1;
            }
            column(STUDENT_STATEMENT_______Caption; STUDENT_STATEMENT_______CaptionLbl)
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(Ref_No_Caption; Ref_No_CaptionLbl)
            {
            }
            column(Cust__Ledger_Entry_DescriptionCaption; ledge.FIELDCAPTION(Description))
            {
            }
            column(Bal__KES__Caption; Bal__KES__CaptionLbl)
            {
            }
            column(CUSTOMER_NAME_Caption; CUSTOMER_NAME_CaptionLbl)
            {
            }
            column(OUR_NO_Caption; OUR_NO_CaptionLbl)
            {
            }
            column(PAYMENT_TODATE_Caption; PAYMENT_TODATE_CaptionLbl)
            {
            }
            column(INVOICED_AMOUNT_Caption; INVOICED_AMOUNT_CaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(TypeCaption; TypeCaptionLbl)
            {
            }
            column(Adj__of_Opening_BalanceCaption; Adj__of_Opening_BalanceCaptionLbl)
            {
            }
            column(Total__LCY__Before_PeriodCaption; Total__LCY__Before_PeriodCaptionLbl)
            {
            }
            column(Total__LCY_Caption; Total__LCY_CaptionLbl)
            {
            }
            column(Customer_Date_Filter; "Date Filter")
            {
            }
            column(Customer_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
            {
            }
            column(CustBal; Customer.Balance)
            {
            }
            column(Customer_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
            {
            }
            column(Faculty; Faculty)
            {
            }
            column(Stage; Stage)
            {
            }
            column(Campus; Customer."Global Dimension 1 Code")
            {
            }
            dataitem(DataItem8503; 21)
            {
                DataItemLink = "Customer No." = FIELD("No."),
                               "Posting Date" = FIELD("Date Filter");
                DataItemTableView = SORTING("Customer No.", "Posting Date")
                                    WHERE(Reversed = FILTER('No'));
                column(Cust__Ledger_Entry_Description; Description)
                {
                }
                column(CustBalanceLCY_Control56; CustBalanceLCY)
                {
                    AutoFormatType = 1;
                }
                column(Cust__Ledger_Entry__Credit_Amount_; "Credit Amount")
                {
                }
                column(Cust__Ledger_Entry__Debit_Amount_; "Debit Amount")
                {
                }
                column(Cust__Ledger_Entry__External_Document_No__; "External Document No.")
                {
                }
                column(Cust__Ledger_Entry__Posting_Date_; "Posting Date")
                {
                }
                column(Cust__Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(Cust__Ledger_Entry_Entry_No_; "Entry No.")
                {
                }
                column(Cust__Ledger_Entry_Customer_No_; "Customer No.")
                {
                }
                column(Cust__Ledger_Entry_Global_Dimension_2_Code; "Global Dimension 2 Code")
                {
                }
                column(Cust__Ledger_Entry_Global_Dimension_1_Code; "Global Dimension 1 Code")
                {
                }
                column(Cust__Ledger_Entry_Date_Filter; "Date Filter")
                {
                }
                column(AcadYear; AcademicYear)
                {
                }
                dataitem(DataItem6942; 379)
                {
                    DataItemLink = "Cust. Ledger Entry No." = FIELD("Entry No.");
                    DataItemTableView = SORTING("Cust. Ledger Entry No.", "Entry Type", "Posting Date")
                                        WHERE("Entry Type" = CONST("Correction of Remaining Amount"));

                    trigger OnAfterGetRecord()
                    begin
                        Correction := Correction + "Amount (LCY)";
                        CustBalanceLCY := CustBalanceLCY + "Amount (LCY)";
                    end;

                    trigger OnPreDataItem()
                    begin
                        SETFILTER("Posting Date", CustDateFilter);
                    end;
                }
                dataitem("Detailed Cust. Ledg. Entry2"; 379)
                {
                    DataItemLink = "Cust. Ledger Entry No." = FIELD("Entry No.");
                    DataItemTableView = SORTING("Cust. Ledger Entry No.", "Entry Type", "Posting Date")
                                        WHERE("Entry Type" = CONST("Appln. Rounding"));

                    trigger OnAfterGetRecord()
                    begin
                        ApplicationRounding := ApplicationRounding + "Amount (LCY)";
                        CustBalanceLCY := CustBalanceLCY + "Amount (LCY)";
                        IF CONFIRM('%1 %2', TRUE, Text001, ApplicationRounding) THEN;
                    end;

                    trigger OnPreDataItem()
                    begin
                        SETFILTER("Posting Date", CustDateFilter);
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CALCFIELDS(Amount, "Remaining Amount", "Amount (LCY)", "Remaining Amt. (LCY)");
                    //IF "Cust. Ledger Entry".Amount=0 THEN CurrReport.SKIP;

                    CLEAR(AcademicYear);
                    AcademicYears.RESET;
                    AcademicYears.SETFILTER(AcademicYears.From, '=%1|<%2', ledge."Posting Date", ledge."Posting Date");
                    AcademicYears.SETFILTER(AcademicYears."To", '=%1|>%2', ledge."Posting Date", ledge."Posting Date");
                    IF AcademicYears.FIND('-') THEN BEGIN
                        AcademicYear := AcademicYears.Code;
                    END;

                    CustLedgEntryExists := TRUE;
                    IF PrintAmountsInLCY THEN BEGIN
                        CustAmount := "Amount (LCY)";
                        CustRemainAmount := "Remaining Amt. (LCY)";
                        CustCurrencyCode := '';
                    END ELSE BEGIN
                        CustAmount := Amount;
                        CustRemainAmount := "Remaining Amount";
                        CustCurrencyCode := "Currency Code";
                    END;
                    //CustBalanceLCY := CustBalanceLCY + "Amount (LCY)";
                    CustBalanceLCY := CustBalanceLCY + ledge."Debit Amount" + (ledge."Credit Amount" * -1);
                    IF ("Document Type" = "Document Type"::Payment) OR ("Document Type" = "Document Type"::Refund) THEN
                        CustEntryDueDate := 0D
                    ELSE
                        CustEntryDueDate := "Due Date";

                    /*
                    "Cust. Ledger Entry".CALCFIELDS("Cust. Ledger Entry".Amount);
                    clear(totals1);
                    detCustLedEntry.RESET;
                    detCustLedEntry.SETRANGE(detCustLedEntry."Document No.","Cust. Ledger Entry"."Document No.");
                    detCustLedEntry.SETRANGE(detCustLedEntry."Customer No.","Cust. Ledger Entry"."Customer No.");
                    detCustLedEntry.SETRANGE(detCustLedEntry."Posting Date","Cust. Ledger Entry"."Posting Date");
                    IF detCustLedEntry.FIND('-') THEN BEGIN
                    IF detCustLedEntry.COUNT<2 THEN BEGIN
                    CALCFIELDS(Amount,"Remaining Amount","Amount (LCY)","Remaining Amt. (LCY)");
                    
                    CustLedgEntryExists := TRUE;
                    IF PrintAmountsInLCY THEN BEGIN
                      CustAmount := "Amount (LCY)";
                      CustRemainAmount := "Remaining Amt. (LCY)";
                      CustCurrencyCode := '';
                    END ELSE BEGIN
                      CustAmount := Amount;
                      CustRemainAmount := "Remaining Amount";
                      CustCurrencyCode := "Currency Code";
                    END;
                    CustBalanceLCY := CustBalanceLCY + "Amount (LCY)";
                    IF ("Document Type" = "Document Type"::Payment) OR ("Document Type" = "Document Type"::Refund) THEN
                      CustEntryDueDate := 0D
                    ELSE
                      CustEntryDueDate := "Due Date";
                      END ELSE begin
                        repeat
                        totals1:=totals1+"Amount (LCY)";
                        until detCustLedEntry.next = 0;
                    
                    if totals1=0 THEN
                          CurrReport.SKIP
                    
                          ELSE BEGIN
                    CustLedgEntryExists := TRUE;
                    IF PrintAmountsInLCY THEN BEGIN
                      CustAmount := "Amount (LCY)";
                      CustRemainAmount := "Remaining Amt. (LCY)";
                      CustCurrencyCode := '';
                    END ELSE BEGIN
                      CustAmount := Amount;
                      CustRemainAmount := "Remaining Amount";
                      CustCurrencyCode := "Currency Code";
                    END;
                    CustBalanceLCY := CustBalanceLCY + "Amount (LCY)";
                    IF ("Document Type" = "Document Type"::Payment) OR ("Document Type" = "Document Type"::Refund) THEN
                      CustEntryDueDate := 0D
                    ELSE
                      CustEntryDueDate := "Due Date";
                    
                          END;
                      end;
                    END ELSE CurrReport.SKIP;
                    
                    */

                end;

                trigger OnPreDataItem()
                begin
                    CustLedgEntryExists := FALSE;
#pragma warning disable AL0667
                    CurrReport.CREATETOTALS(CustAmount, "Amount (LCY)");
#pragma warning restore AL0667
                end;
            }
            dataitem(DataItem5444; 2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                column(CustBalanceLCY_Control1102760012; CustBalanceLCY)
                {
                    AutoFormatType = 1;
                }
                column(USERID; USERID)
                {
                }
                column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
                {
                }
                column(TIME; TIME)
                {
                }
                column(Customer__Credit_Amount__LCY__; Customer."Credit Amount (LCY)")
                {
                }
                column(Customer__Debit_Amount__LCY__; Customer."Debit Amount (LCY)")
                {
                }
                column(Totals___________________________________________________________Caption; Totals___________________________________________________________CaptionLbl)
                {
                }
                column(Statement_Issued_By_Caption; Statement_Issued_By_CaptionLbl)
                {
                }
                column(On_Caption; On_CaptionLbl)
                {
                }
                column(END_______________________________________________Caption; END_______________________________________________CaptionLbl)
                {
                }
                // column(DataItem1102755005;There_will_be_no_refunds_until_completion_of_your_course_and_classification__Any_queries_to_be_addressed_to_Finance_OfficerCaLbl)
                // {
                // }
                column(Integer_Number; Number)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF NOT CustLedgEntryExists AND ((StartBalanceLCY = 0) OR ExcludeBalanceOnly) THEN BEGIN
                        StartBalanceLCY := 0;
                        CurrReport.SKIP;
                    END;
                    Customer.CALCFIELDS(Customer."Credit Amount (LCY)");
                    Customer.CALCFIELDS(Customer."Debit Amount (LCY)");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                courseReg.RESET;
                CLEAR(progName);
                courseReg.SETRANGE(courseReg."Student No.", Customer."No.");
                courseReg.SETFILTER(courseReg.Programmes, '<>%1', '');
                IF courseReg.FIND('+') THEN BEGIN
                    Prog.RESET;
                    Prog.SETRANGE(Prog.Code, courseReg.Programmes);
                    IF Prog.FIND('-') THEN BEGIN
                        progName := Prog.Description;
                    END;
                END;

                StartBalanceLCY := 0;
                StartBalAdjLCY := 0;
                IF CustDateFilter <> '' THEN BEGIN
                    IF GETRANGEMIN("Date Filter") <> 0D THEN BEGIN
                        SETRANGE("Date Filter", 0D, GETRANGEMIN("Date Filter") - 1);
                        CALCFIELDS("Net Change (LCY)");
                        CALCFIELDS(Balance);
                        StartBalanceLCY := "Net Change (LCY)";
                    END;
                    SETFILTER("Date Filter", CustDateFilter);
                    CALCFIELDS("Net Change (LCY)");
                    CALCFIELDS(Balance);
                    StartBalAdjLCY := "Net Change (LCY)";
                    CustLedgEntry.SETCURRENTKEY("Customer No.", "Posting Date");
                    CustLedgEntry.SETRANGE("Customer No.", Customer."No.");
                    CustLedgEntry.SETFILTER("Posting Date", CustDateFilter);
                    IF CustLedgEntry.FIND('-') THEN
                        REPEAT
                            CustLedgEntry.SETFILTER("Date Filter", CustDateFilter);
                            CustLedgEntry.CALCFIELDS("Amount (LCY)");
                            StartBalAdjLCY := StartBalAdjLCY - CustLedgEntry."Amount (LCY)";
                            entry.SETCURRENTKEY("Cust. Ledger Entry No.", "Entry Type", "Posting Date");
                            entry.SETRANGE("Cust. Ledger Entry No.", CustLedgEntry."Entry No.");
                            entry.SETFILTER("Entry Type", '%1|%2',
                              entry."Entry Type"::"Correction of Remaining Amount",
                              entry."Entry Type"::"Appln. Rounding");
                            entry.SETFILTER("Posting Date", CustDateFilter);
                            IF entry.FIND('-') THEN
                                REPEAT
                                    StartBalAdjLCY := StartBalAdjLCY - entry."Amount (LCY)";
                                UNTIL entry.NEXT = 0;
                            entry.RESET;
                        UNTIL CustLedgEntry.NEXT = 0;
                END;
                //CurrReport.PRINTONLYIFDETAIL := ExcludeBalanceOnly OR (StartBalanceLCY = 0);
                //CustBalanceLCY := StartBalanceLCY + StartBalAdjLCY;
                //CustBalanceLCY := StartBalanceLCY + StartBalAdjLCY;
                //MESSAGE('%',CustBalanceLCY);
                CLEAR(Faculty);
                CLEAR(Stage);
                CALCFIELDS("Student Programme");
                Prog.RESET;
                Prog.SETRANGE(Prog.Code, "Student Programme");
                IF Prog.FIND('-') THEN BEGIN
                    DimVal.RESET;
                    DimVal.SETRANGE(DimVal.Code, Prog."School Code");
                    IF DimVal.FIND('-') THEN BEGIN
                        Faculty := UPPERCASE(DimVal.Name);
                    END;
                END;

                //CALCFIELDS("Current Stage");
                ProgStages.RESET;
                ProgStages.SETRANGE(ProgStages.Code, "Current Semester");
                IF ProgStages.FIND('-') THEN BEGIN
                    Stage := ProgStages.Description;
                END;
            end;

            trigger OnPreDataItem()
            begin
#pragma warning disable AL0667
                CurrReport.NEWPAGEPERRECORD := PrintOnlyOnePerPage;
#pragma warning restore AL0667
#pragma warning disable AL0667
                CurrReport.CREATETOTALS(ledge."Amount (LCY)", StartBalanceLCY, StartBalAdjLCY, Correction, ApplicationRounding);
#pragma warning restore AL0667
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

    trigger OnPreReport()
    begin
        IF info.GET() THEN BEGIN
            info.CALCFIELDS(Picture);
        END;

        CustFilter := Customer.GETFILTERS;
        CustDateFilter := Customer.GETFILTER("Date Filter");
#pragma warning disable AL0606
#pragma warning restore AL0606
        IF PrintAmountsInLCY THEN BEGIN
            AmountCaption := ledge.FIELDCAPTION("Amount (LCY)");
            RemainingAmtCaption := ledge.FIELDCAPTION("Remaining Amt. (LCY)");
        END ELSE BEGIN
            AmountCaption := ledge.FIELDCAPTION(Amount);
            RemainingAmtCaption := ledge.FIELDCAPTION("Remaining Amount");
        END;
    end;

    var
        Text000: Label 'Period: %1';
        totals1: Decimal;
        CustLedgEntry: Record 21;
        PrintAmountsInLCY: Boolean;
        PrintOnlyOnePerPage: Boolean;
        ExcludeBalanceOnly: Boolean;
        CustFilter: Text[250];
        CustDateFilter: Text[30];
        AmountCaption: Text[30];
        RemainingAmtCaption: Text[30];
        CustAmount: Decimal;
        CustRemainAmount: Decimal;
        CustBalanceLCY: Decimal;
        CustCurrencyCode: Code[10];
        CustEntryDueDate: Date;
        StartBalanceLCY: Decimal;
        StartBalAdjLCY: Decimal;
        Correction: Decimal;
        ApplicationRounding: Decimal;
        CustLedgEntryExists: Boolean;
        Text001: Label 'Appln Rounding:';
        STUDENT_STATEMENT_______CaptionLbl: Label '***** STUDENT STATEMENT*******';
        Date_CaptionLbl: Label 'Date:';
        Ref_No_CaptionLbl: Label 'Ref No.';
        Bal__KES__CaptionLbl: Label 'Bal (KES:)';
        CUSTOMER_NAME_CaptionLbl: Label 'CUSTOMER NAME:';
        OUR_NO_CaptionLbl: Label 'OUR NO:';
        PAYMENT_TODATE_CaptionLbl: Label 'PAYMENT TODATE:';
        INVOICED_AMOUNT_CaptionLbl: Label 'INVOICED AMOUNT:';
        EmptyStringCaptionLbl: Label '_______________________________________________________________________________________________________________________________________________________________';
        TypeCaptionLbl: Label 'Type';
        Adj__of_Opening_BalanceCaptionLbl: Label 'Adj. of Opening Balance';
        Total__LCY__Before_PeriodCaptionLbl: Label 'Total (LCY) Before Period';
        Total__LCY_CaptionLbl: Label 'Total (LCY)';
        Totals___________________________________________________________CaptionLbl: Label 'Totals:**********************************************************';
        Statement_Issued_By_CaptionLbl: Label 'Statement Issued By:';
        On_CaptionLbl: Label 'On:';
        END_______________________________________________CaptionLbl: Label '************************************END***********************************************';
        //There_will_be_no_refunds_until_completion_of_your_course_and_classification__Any_queries_to_be_addressed_to_Finance_OfficerCaLbl: Label 'There will be no refunds until completion of your course and classification. Any queries to be addressed to Finance Officer';
        Faculty: Text[100];
        Prog: Record 61511;
        DimVal: Record 349;
        Stage: Code[50];
        ProgStages: Record 61516;
        detCustLedEntry: Record 21;
        courseReg: Record 61532;
        progName: Text[250];
        info: Record 79;
        AcademicYear: Code[100];
        AcademicYears: Record 61382;
        customer: Record customer;
        ledge: Record "Cust. Ledger Entry";
        entry: Record "Detailed Cust. Ledg. Entry";
}

