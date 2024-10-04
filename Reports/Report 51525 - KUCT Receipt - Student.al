report 51525 "KUCT Receipt - Student"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/KUCT Receipt - Student.rdl';
    UseSystemPrinter = true;

    dataset
    {
        dataitem("ACA-Receipt"; 61538)
        {
            DataItemTableView = SORTING("Receipt No.");
            RequestFilterFields = "Receipt No.", "Auto  Receipted", "Auto  Receipt Date";
            column(Receipt_Date____FORMAT_Receipt_Date_; 'Receipt Date: ' + FORMAT("ACA-Receipt".Date))
            {
            }
            column(Reg_No______Student_No__; 'Reg No. :' + "Student No.")
            {
            }
            column(Receipt_No_____Receipt_No__; 'Receipt No. ' + "Receipt No.")
            {
            }
            column(Names____Names; 'Names: ' + Names)
            {
            }
            column(Receipt__Transaction_Time_; "Transaction Time")
            {
            }
            column(Receipt__User_ID_; "User ID")
            {
            }
            column(Receipt__Payment_Mode_; "Payment Mode")
            {
            }
            column(Desc_4_; Desc[4])
            {
            }
            column(Desc_5_; Desc[5])
            {
            }
            column(Total________________________FORMAT_Amount_; 'Total                      ' + FORMAT(Amount))
            {
            }
            column(Desc_1_; Desc[1])
            {
            }
            column(Desc_2_; Desc[2])
            {
            }
            column(Desc_3_; Desc[3])
            {
            }
            column(Amt_1_; Amt[1])
            {
            }
            column(Amt_2_; Amt[2])
            {
            }
            column(Amt_3_; Amt[3])
            {
            }
            column(Amt_4_; Amt[4])
            {
            }
            column(Amt_5_; Amt[5])
            {
            }
            column(Desc_7_; Desc[7])
            {
            }
            column(Desc_6_; Desc[6])
            {
            }
            column(Desc_12_; Desc[12])
            {
            }
            column(Desc_11_; Desc[11])
            {
            }
            column(Desc_10_; Desc[10])
            {
            }
            column(Desc_9_; Desc[9])
            {
            }
            column(Desc_8_; Desc[8])
            {
            }
            column(Amt_10_; Amt[10])
            {
            }
            column(Amt_9_; Amt[9])
            {
            }
            column(Amt_8_; Amt[8])
            {
            }
            column(Amt_7_; Amt[7])
            {
            }
            column(Amt_6_; Amt[6])
            {
            }
            column(Amt_11_; Amt[11])
            {
            }
            column(Amt_12_; Amt[12])
            {
            }
            column(Desc_13_; Desc[13])
            {
            }
            column(Amt_13_; Amt[13])
            {
            }
            column(Amt_14_; Amt[14])
            {
            }
            column(Desc_14_; Desc[14])
            {
            }
            column(NumberText_1_; NumberText[1])
            {
            }
            column(Cashier__Caption; Cashier__CaptionLbl)
            {
            }
            column(Receipt_Receipt_No_; "Receipt No.")
            {
            }
            column(Receipt_Student_No_; "Student No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                TDate := FORMAT("ACA-Receipt".Date);
                DFilter := '01/01/01..01/01/01';
                CDesc := '';
                RTotal := 0;
                i := 0;

                RAmount := "ACA-Receipt".Amount;


                RItems.RESET;
                RItems.SETRANGE(RItems."Receipt No", "ACA-Receipt"."Receipt No.");
                IF RItems.FIND('-') THEN BEGIN
                    CDesc := '';
                    CourseReg.RESET;
                    CourseReg.SETRANGE(CourseReg."Student No.", "ACA-Receipt"."Student No.");
                    CourseReg.SETRANGE(CourseReg."Reg. Transacton ID", RItems."Reg. No");
                    IF CourseReg.FIND('-') THEN BEGIN
                        IF CourseReg."Student Type" = CourseReg."Student Type"::"Full Time" THEN
                            Intake := 'Full Time'
                        ELSE
                            Intake := 'Part Time';

                        CDesc := CourseReg.Programmes + ', ' + CourseReg.Stage + ', ' + CourseReg.Semester + ', ' + Intake;
                        RegDate := FORMAT(CourseReg."Registration Date");
                        PRegDate := FORMAT(CALCDATE('-1D', CourseReg."Registration Date"));
                        DFilter2 := RegDate + '..' + TDate;
                        DFilter := '01/01/05..' + PRegDate;
                    END;
                END;

                IF CDesc = '' THEN BEGIN
                    RItems.RESET;
                    RItems.SETRANGE(RItems."Receipt No", "ACA-Receipt"."Receipt No.");
                    IF RItems.FIND('+') THEN BEGIN
                        CDesc := '';
                        CourseReg.RESET;
                        CourseReg.SETRANGE(CourseReg."Student No.", "ACA-Receipt"."Student No.");
                        CourseReg.SETRANGE(CourseReg."Reg. Transacton ID", RItems."Reg. No");
                        IF CourseReg.FIND('-') THEN BEGIN
                            IF CourseReg."Student Type" = CourseReg."Student Type"::"Full Time" THEN
                                Intake := 'Full Time'
                            ELSE
                                Intake := 'Part Time';

                            CDesc := CourseReg.Programmes + ', ' + CourseReg.Stage + ', ' + CourseReg.Semester + ', ' + Intake;
                            RegDate := FORMAT(CourseReg."Registration Date");
                            PRegDate := FORMAT(CALCDATE('-1D', CourseReg."Registration Date"));
                            DFilter2 := RegDate + '..' + TDate;
                            DFilter := '01/01/05..' + PRegDate;
                        END;
                    END;
                END;


                RItems.RESET;
                RItems.SETRANGE(RItems."Receipt No", "ACA-Receipt"."Receipt No.");
                IF RItems.FIND('+') THEN BEGIN
                    CDesc := '';
                    CourseReg.RESET;
                    CourseReg.SETRANGE(CourseReg."Student No.", "ACA-Receipt"."Student No.");
                    CourseReg.SETRANGE(CourseReg."Reg. Transacton ID", RItems."Reg. No");
                    IF CourseReg.FIND('-') THEN BEGIN
                        IF CourseReg."Student Type" = CourseReg."Student Type"::"Full Time" THEN
                            Intake := 'Full Time'
                        ELSE
                            Intake := 'Part Time';

                        CDesc := CourseReg.Programmes + ', ' + CourseReg.Stage + ', ' + CourseReg.Semester + ', ' + Intake;
                    END;
                END;


                CourseReg.RESET;
                CourseReg.SETRANGE(CourseReg."Reg. Transacton ID", RItems."Reg. No");
                IF CourseReg.FIND('-') = FALSE THEN
                    DFilter := '01/01/01..01/01/01';


                Cust.RESET;
                Cust.SETFILTER(Cust."Date Filter", DFilter);
                Cust.SETRANGE(Cust."No.", "ACA-Receipt"."Student No.");
                IF Cust.FIND('-') THEN BEGIN
                    Cust.CALCFIELDS(Cust."Balance (LCY)");
                    Names := Cust.Name;
                    BalBF := Cust."Balance (LCY)";
                END;

                Cust.RESET;
                Cust.SETFILTER(Cust."Date Filter", DFilter2);
                Cust.SETRANGE(Cust."No.", "ACA-Receipt"."Student No.");
                IF Cust.FIND('-') THEN BEGIN
                    Cust.CALCFIELDS(Cust."Debit Amount (LCY)", Cust."Credit Amount (LCY)", Cust."Balance (LCY)");
                    Names := Cust.Name;
                    Debit := Cust."Debit Amount (LCY)";
                    Credit := Cust."Credit Amount (LCY)";
                    //IF BalBF > 0 THEN
                    //OBal:=((Debit-BalBF)-Credit)
                    //ELSE
                    OBal := ((Debit + BalBF) - Credit);
                END;




                //  CheckReport.InitTextVariable;
                //CheckReport.FormatNoText(NumberText,CheckAmount,GenJnlLine."Currency Code");
                // CheckReport.FormatNoText2('', "ACA-Receipt".Amount, '');

                CustL.RESET;
                CustL.SETRANGE(CustL."Customer No.", "ACA-Receipt"."Student No.");
                CustL.SETRANGE(CustL."Document No.", "ACA-Receipt"."Receipt No.");
                IF CustL.FIND('-') THEN BEGIN
                    DLedg.RESET;
                    DLedg.SETRANGE(DLedg."Customer No.", CustL."Customer No.");
                    DLedg.SETRANGE(DLedg."Cust. Ledger Entry No.", CustL."Entry No.");
                    DLedg.SETRANGE(DLedg."Entry Type", DLedg."Entry Type"::Application);
                    IF DLedg.FIND('-') THEN BEGIN
                        REPEAT
                            i := i + 1;
                            //Desc[i]:=DLedg.Description;
                            Amt[i] := DLedg.Amount;
                        UNTIL DLedg.NEXT = 0;
                    END;
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
        Cust: Record 18;
        Names: Text[200];
        Debit: Decimal;
        Credit: Decimal;
        "Oustanding Bal": Decimal;
        CourseReg: Record 61532;
        Course: Text[250];
        Intake: Text[50];
        GenJnlLine: Record 81;
        Vend: Record 23;
        BankAcc: Record 270;
        CompanyInfo: Record 79;
        CheckReport: Report 1401;
        FormatAddr: Codeunit 365;
        CheckToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        NumberText: array[2] of Text[1024];
        CheckStatusText: Text[30];
        CheckAmount: Decimal;
        MCount: Integer;
        CDesc: Text[200];
        RItems: Record 61539;
        IBal: Decimal;
        OBal: Decimal;
        TDate: Text[50];
        DFilter: Text[150];
        DFilter2: Text[150];
        RegDate: Text[50];
        PRegDate: Text[50];
        BalBF: Decimal;
        Desc: array[20] of Text[100];
        Amt: array[20] of Decimal;
        i: Integer;
        CustL: Record 21;
        RTotal: Decimal;
        RAmount: Decimal;
        PrepaymentExist: Boolean;
        Cashier__CaptionLbl: Label 'Cashier: ';
        DLedg: Record 379;
        mDesc: Text[200];
}

