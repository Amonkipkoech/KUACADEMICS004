report 51524 "Student Fee Receipts"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Student Fee Receipts.rdl';
    UseSystemPrinter = true;

    dataset
    {
        dataitem("ACA-Receipt"; "ACA-Receipt")
        {
            DataItemTableView = SORTING("Receipt No.");
            RequestFilterFields = "Receipt No.", "Auto  Receipted", "Auto  Receipt Date";
            column(pic; CompanyInfo.Picture)
            {
            }
            column(compName; CompanyInfo.Name)
            {
            }
            column(compAddress; CompanyInfo.Address)
            {
            }
            column(compCity; CompanyInfo.City)
            {
            }
            column(compPhone; CompanyInfo."Phone No.")
            {
            }
            column(compEmail; CompanyInfo."E-Mail")
            {
            }
            column(compHomePage; CompanyInfo."Home Page")
            {
            }
            column(Receipt__Student_No__; "Student No.")
            {
            }
            column(Receipt__Receipt_No__; "Receipt No.")
            {
            }
            column(UserName; 'You were served by: ' + UserName)
            {
            }
            column(Names; Names)
            {
            }
            column(Receipt__Transaction_Date_; "Transaction Date")
            {
            }
            column(Receipt__Transaction_Time_; "Transaction Time")
            {
            }
            column(Receipt__User_ID_; "User ID")
            {
            }
            column(Intake; Intake)
            {
            }
            column(RecAmount; "ACA-Receipt".Amount)
            {
            }
            column(paymode; FORMAT("ACA-Receipt"."Payment Mode"))
            {
            }
            column(transno; "ACA-Receipt"."Bank Slip/Cheque No")
            {
            }
            column(CurrBalance; CurrBalance)
            {
            }
            column(Pname; Pname)
            {
            }
            column(Mode____FORMAT__Payment_Mode_______Transaction_No_____Bank_Slip_Cheque_No_; 'Mode: ' + FORMAT("Payment Mode") + ',  Transaction No: ' + "Bank Slip/Cheque No")
            {
            }
            column(NumberText_1_; NumberText[1])
            {
            }
            column(Desc_4_; Desc[4])
            {
            }
            column(Desc_5_; Desc[5])
            {
            }
            column(Receipt_Amount; Amount)
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
            column(Cashier__Caption; Cashier__CaptionLbl)
            {
            }
            column(Room; RoomNo)
            {
            }
            column(HostelName; HostelName)
            {
            }
            column(RoomNo_Receipt; "ACA-Receipt"."Room No")
            {
            }
            dataitem(CustL_1; 21)
            {
                DataItemLink = "Document No." = FIELD("Receipt No."),
                               "Customer No." = FIELD("Student No.");
                dataitem(DCustL; 379)
                {
                    DataItemLink = "Customer No." = FIELD("Customer No."),
                                   "Cust. Ledger Entry No." = FIELD("Entry No.");
                    DataItemTableView = WHERE("Entry Type" = FILTER(Application));
                    column(ItemDesc; CustL_1.Description)
                    {
                    }
                    column(ItemAmount; CustL_1.Amount)
                    {
                    }
                }
            }

            trigger OnAfterGetRecord()
            begin
                TDate := FORMAT("ACA-Receipt".Date);
                DFilter := '01/01/01..01/01/01';
                CDesc := '';
                RTotal := 0;
                i := 0;
                CLEAR(Pname);

                CLEAR(UserName);
                usersTable.RESET;
                usersTable.SETRANGE(usersTable."User Name", "ACA-Receipt"."User ID");
                IF usersTable.FIND('-') THEN BEGIN
                    IF usersTable."Full Name" <> '' THEN
                        UserName := usersTable."Full Name"
                    ELSE
                        UserName := "ACA-Receipt"."User ID";
                END ELSE
                    UserName := "ACA-Receipt"."User ID";

                RAmount := "ACA-Receipt".Amount;


                RItems.RESET;
                RItems.SETRANGE(RItems."Receipt No", "ACA-Receipt"."Receipt No.");
                IF RItems.FIND('-') THEN BEGIN
                    CDesc := '';
                    CourseReg.RESET;
                    CourseReg.SETRANGE(CourseReg."Student No.", "ACA-Receipt"."Student No.");
                    CourseReg.SETRANGE(CourseReg."Reg. Transacton ID", RItems."Reg. No");
                    IF CourseReg.FIND('-') THEN BEGIN
                        prog.RESET;
                        prog.SETRANGE(prog.Code, CourseReg.Programmes);
                        IF prog.FIND('-') THEN BEGIN
                            Pname := prog.Description;
                        END;
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




                //CheckReport.InitTextVariable;
                //CheckReport.FormatNoText(NumberText,CheckAmount,GenJnlLine."Currency Code");
                // CheckReport.FormatNoText2('', "ACA-Receipt".Amount, '');

                RoomNo := '';
                HLedger.RESET;
                HLedger.SETRANGE(HLedger."Space No", "ACA-Receipt"."Room No");
                IF HLedger.FIND('-') THEN BEGIN
                    IF Hostel.GET(HLedger."Hostel No") THEN
                        HostelName := Hostel.Description;
                END;

                StudHost.RESET;
                StudHost.SETRANGE(StudHost.Student, "ACA-Receipt"."Student No.");
                IF StudHost.FIND('-') THEN BEGIN
                    StudHost.CALCFIELDS("Hostel Name");
                    HostelName := StudHost."Hostel Name";
                    RoomNo := StudHost."Space No";
                END;

                i := 0;
                CustL.RESET;
                CustL.SETRANGE(CustL."Customer No.", "ACA-Receipt"."Student No.");
                CustL.SETRANGE(CustL."Document No.", "ACA-Receipt"."Receipt No.");
                IF CustL.FIND('-') THEN BEGIN
                    DLedg.RESET;
                    DLedg.SETRANGE(DLedg."Customer No.", CustL."Customer No.");
                    DLedg.SETRANGE(DLedg."Applied Cust. Ledger Entry No.", CustL."Entry No.");
                    DLedg.SETRANGE(DLedg."Entry Type", DLedg."Entry Type"::Application);
                    IF DLedg.FIND('-') THEN BEGIN
                        REPEAT
                            IF DLedg.Amount < 0 THEN BEGIN
                                i := i + 1;
                                IF CustL2.GET(DLedg."Cust. Ledger Entry No.") THEN
                                    Desc[i] := CustL2.Description;
                                Amt[i] := DLedg.Amount;
                            END;
                        UNTIL DLedg.NEXT = 0;
                    END;
                END;



                CLEAR(amountBilled);
                CLEAR(amountPaid);
                CLEAR(CurrBalance);
                //CLEAR("balB/F");

                // populate Billed & Paid
                Cust.RESET;
                Cust.SETRANGE(Cust."No.", "ACA-Receipt"."Student No.");
                IF Cust.FIND('-') THEN BEGIN
                    Cust.CALCFIELDS(Cust."Balance (LCY)");
                    CurrBalance := Cust."Balance (LCY)";
                END;
                /*
                 Cust.RESET;
                 Cust.SETRANGE(Cust."No.",Receipt."Student No.");
                 Cust.SETFILTER(Cust."Date Filter",'%1..%2',finCalender."Start Date",finCalender."End Date");
                 IF Cust.FIND('-') THEN BEGIN
                 Cust.CALCFIELDS(Cust."Credit Amount (LCY)",Cust."Imported Rcpt",Cust."Debit Amount (LCY)");
                    amountBilled:=Cust."Debit Amount (LCY)";
                    amountPaid:=Cust."Credit Amount (LCY)"+Cust."Imported Rcpt";
                 END;*/

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
        CompanyInfo.RESET;
        IF CompanyInfo.FIND('-') THEN BEGIN
            CompanyInfo.CALCFIELDS(Picture);
        END;
    end;

    var
        UserName: Text[250];
        usersTable: Record 2000000120;
        amountPaid: Decimal;
        amountBilled: Decimal;
        prog: Record 61511;
        Hostel: Record 61162;
        HLedger: Record 61163;
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
        CDesc: Text[250];
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
        RoomNo: Code[20];
        HostelName: Text[100];
        DLedg: Record 379;
        StudHost: Record 61155;
        CustL2: Record 21;
        Pname: Text[150];
        CurrBalance: Decimal;
        studType: Code[30];
}

