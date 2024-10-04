/// <summary>
/// Report 2R KCA Generate Application 2 (ID 51617).
/// </summary>
report 51617 "2R KCA Generate Application 2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/2R KCA Generate Application 2.rdl';

    dataset
    {
        dataitem("ACA-Receipt"; "ACA-Receipt")
        {
            DataItemTableView = SORTING("Receipt No.");
            RequestFilterFields = "Receipt No.", Date;
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
            column(Receipt__Receipt_No__; "Receipt No.")
            {
            }
            column(Receipt__Student_No__; "Student No.")
            {
            }
            column(Receipt__Student_Name_; "Student Name")
            {
            }
            column(Receipt_Amount; Amount)
            {
            }
            column(Receipt__Amount_Applied_; "Amount Applied")
            {
            }
            column(ReceiptCaption; ReceiptCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Receipt__Receipt_No__Caption; FIELDCAPTION("Receipt No."))
            {
            }
            column(Receipt__Amount_Applied_Caption; FIELDCAPTION("Amount Applied"))
            {
            }
            column(Receipt_AmountCaption; FIELDCAPTION(Amount))
            {
            }
            column(Receipt__Student_Name_Caption; FIELDCAPTION("Student Name"))
            {
            }
            column(Receipt__Student_No__Caption; FIELDCAPTION("Student No."))
            {
            }
            column(Cust__Ledger_Entry__Posting_Date_Caption; "Cust. Ledger Entry".FIELDCAPTION("Posting Date"))
            {
            }
            column(Cust__Ledger_Entry__Document_No__Caption; "Cust. Ledger Entry".FIELDCAPTION("Document No."))
            {
            }
            column(Cust__Ledger_Entry_DescriptionCaption; "Cust. Ledger Entry".FIELDCAPTION(Description))
            {
            }
            column(Cust__Ledger_Entry_AmountCaption; "Cust. Ledger Entry".FIELDCAPTION(Amount))
            {
            }
            column(Cust__Ledger_Entry__Remaining_Amount_Caption; "Cust. Ledger Entry".FIELDCAPTION("Remaining Amount"))
            {
            }
            column(Cust__Ledger_Entry__Entry_No__Caption; "Cust. Ledger Entry".FIELDCAPTION("Entry No."))
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("Student No.");
                DataItemTableView = WHERE(Open = CONST(false),
                                          "Remaining Amount" = FILTER(> 0));
                column(Cust__Ledger_Entry__Entry_No__; "Entry No.")
                {
                }
                column(Cust__Ledger_Entry__Posting_Date_; "Posting Date")
                {
                }
                column(Cust__Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(Cust__Ledger_Entry_Description; Description)
                {
                }
                column(Cust__Ledger_Entry_Amount; Amount)
                {
                }
                column(Cust__Ledger_Entry__Remaining_Amount_; "Remaining Amount")
                {
                }
                column(Cust__Ledger_Entry_Customer_No_; "Customer No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF AmApply > 0 THEN BEGIN
                        "Cust. Ledger Entry".CALCFIELDS("Cust. Ledger Entry"."Amount Receipted");
                        ReqAmount := "Cust. Ledger Entry"."Remaining Amount" - "Cust. Ledger Entry"."Amount Receipted";
                        IF AmApply > ReqAmount THEN
                            AppliedAmount := ReqAmount
                        ELSE
                            AppliedAmount := AmApply;

                        UniqNo := UniqNo + 1;
                        ReceiptItems.INIT;
                        ReceiptItems."Receipt No" := "ACA-Receipt"."Receipt No.";
                        ReceiptItems.Code := StudCharges.Code;
                        ReceiptItems.Description := "Cust. Ledger Entry".Description;
                        ReceiptItems.Amount := AppliedAmount;
                        ReceiptItems."Transaction ID" := "Cust. Ledger Entry"."Document No.";
                        ReceiptItems."Student No." := "Cust. Ledger Entry"."Customer No.";
                        ReceiptItems."Uniq No 2" := UniqNo;
                        ReceiptItems.Date := "ACA-Receipt".Date;
                        ReceiptItems.Campus := "Cust. Ledger Entry"."Global Dimension 1 Code";
                        ReceiptItems.Course := "Cust. Ledger Entry"."Global Dimension 2 Code";
                        ReceiptItems.Upposted := TRUE;
                        IF ReceiptItems.Amount > 0 THEN
                            ReceiptItems.INSERT;
                        AmApply := AmApply - AppliedAmount;

                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                AmApply := 0;
                "ACA-Receipt".CALCFIELDS("ACA-Receipt"."Amount Applied");
                IF "ACA-Receipt".Amount > "ACA-Receipt"."Amount Applied" THEN
                    AmApply := "ACA-Receipt".Amount - "ACA-Receipt"."Amount Applied";

                AmApply := "ACA-Receipt".Amount;

                /*
                StudCharges.RESET;
                StudCharges.SETRANGE(StudCharges."Student No.",Receipt."Student No.");
                StudCharges.SETRANGE(StudCharges."Recovered First",TRUE);
                StudCharges.SETRANGE(StudCharges."Fully Paid",FALSE);
                IF StudCharges.FIND('-') THEN BEGIN
                REPEAT
                StudCharges.CALCFIELDS(StudCharges."Total Paid");
                ChargeDesc:=StudCharges.Description;
                TotalPaid:=StudCharges."Total Paid";
                IF StudCharges."Total Paid" < StudCharges.Amount THEN BEGIN
                IF AmApply > 0 THEN BEGIN
                IF AmApply > (StudCharges.Amount - StudCharges."Total Paid") THEN
                AppliedAmount:=(StudCharges.Amount - StudCharges."Total Paid")
                ELSE
                AppliedAmount:=AmApply;
                
                IF StudCharges."Total Paid" > 0 THEN BEGIN
                RItem.RESET;
                RItem.SETRANGE(RItem."Receipt No",Receipt."Receipt No.");
                RItem.SETRANGE(RItem."Transaction ID",StudCharges."Transacton ID");
                IF RItem.FIND('-') THEN BEGIN
                RItem.Amount:=RItem.Amount+AppliedAmount;
                RItem."Student No.":=StudCharges."Student No.";
                RItem.MODIFY;
                
                AmApply:=AmApply-AppliedAmount;
                END ELSE BEGIN
                UniqNo:=UniqNo+1;
                ReceiptItems.INIT;
                ReceiptItems."Receipt No":=Receipt."Receipt No.";
                ReceiptItems.Code:=StudCharges.Code;
                ReceiptItems.Description:=StudCharges.Description;
                ReceiptItems.Amount:=AppliedAmount;
                ReceiptItems."Transaction ID":=StudCharges."Transacton ID";
                ReceiptItems."Student No.":=StudCharges."Student No.";
                ReceiptItems."Uniq No 2":=UniqNo;
                ReceiptItems.Date:=Receipt.Date;
                ReceiptItems.Programme:=StudCharges.Programme;
                ReceiptItems.Stage:=StudCharges.Stage;
                ReceiptItems.Unit:=StudCharges.Unit;
                ReceiptItems.Semester:=StudCharges.Semester;
                ReceiptItems.INSERT;
                AmApply:=AmApply-AppliedAmount;
                END;
                
                END ELSE BEGIN
                UniqNo:=UniqNo+1;
                ReceiptItems.INIT;
                ReceiptItems."Receipt No":=Receipt."Receipt No.";
                ReceiptItems.Code:=StudCharges.Code;
                ReceiptItems.Description:=StudCharges.Description;
                ReceiptItems.Amount:=AppliedAmount;
                ReceiptItems."Transaction ID":=StudCharges."Transacton ID";
                ReceiptItems."Student No.":=StudCharges."Student No.";
                ReceiptItems."Uniq No 2":=UniqNo;
                ReceiptItems.Date:=Receipt.Date;
                ReceiptItems.Programme:=StudCharges.Programme;
                ReceiptItems.Stage:=StudCharges.Stage;
                ReceiptItems.Unit:=StudCharges.Unit;
                ReceiptItems.Semester:=StudCharges.Semester;
                ReceiptItems.INSERT;
                AmApply:=AmApply-AppliedAmount;
                END;
                
                END;
                END;
                UNTIL StudCharges.NEXT = 0;
                END;
                
                //Rest of trans
                IF AmApply > 0 THEN BEGIN
                StudCharges.RESET;
                StudCharges.SETRANGE(StudCharges."Student No.",Receipt."Student No.");
                StudCharges.SETRANGE(StudCharges."Recovered First",FALSE);
                StudCharges.SETRANGE(StudCharges."Fully Paid",FALSE);
                IF StudCharges.FIND('-') THEN BEGIN
                REPEAT
                StudCharges.CALCFIELDS(StudCharges."Total Paid");
                IF StudCharges."Total Paid" < StudCharges.Amount THEN BEGIN
                IF AmApply > 0 THEN BEGIN
                IF AmApply > (StudCharges.Amount - StudCharges."Total Paid") THEN
                AppliedAmount:=(StudCharges.Amount - StudCharges."Total Paid")
                ELSE
                AppliedAmount:=AmApply;
                
                IF StudCharges."Total Paid" > 0 THEN BEGIN
                RItem.RESET;
                RItem.SETRANGE(RItem."Receipt No",Receipt."Receipt No.");
                RItem.SETRANGE(RItem."Transaction ID",StudCharges."Transacton ID");
                IF RItem.FIND('-') THEN BEGIN
                RItem.Amount:=RItem.Amount+AppliedAmount;
                RItem.MODIFY;
                
                AmApply:=AmApply-AppliedAmount;
                END ELSE BEGIN
                UniqNo:=UniqNo+1;
                ReceiptItems.INIT;
                ReceiptItems."Receipt No":=Receipt."Receipt No.";
                ReceiptItems.Code:=StudCharges.Code;
                ReceiptItems.Description:=StudCharges.Description;
                ReceiptItems.Amount:=AppliedAmount;
                ReceiptItems."Transaction ID":=StudCharges."Transacton ID";
                ReceiptItems."Student No.":=StudCharges."Student No.";
                ReceiptItems."Uniq No 2":=UniqNo;
                ReceiptItems.Date:=Receipt.Date;
                ReceiptItems.Programme:=StudCharges.Programme;
                ReceiptItems.Stage:=StudCharges.Stage;
                ReceiptItems.Unit:=StudCharges.Unit;
                ReceiptItems.Semester:=StudCharges.Semester;
                ReceiptItems.INSERT;
                
                AmApply:=AmApply-AppliedAmount;
                
                END;
                
                END ELSE BEGIN
                UniqNo:=UniqNo+1;
                ReceiptItems.INIT;
                ReceiptItems."Receipt No":=Receipt."Receipt No.";
                ReceiptItems.Code:=StudCharges.Code;
                ReceiptItems.Description:=StudCharges.Description;
                ReceiptItems.Amount:=AppliedAmount;
                ReceiptItems."Transaction ID":=StudCharges."Transacton ID";
                ReceiptItems."Student No.":=StudCharges."Student No.";
                ReceiptItems."Uniq No 2":=UniqNo;
                ReceiptItems.Date:=Receipt.Date;
                ReceiptItems.Programme:=StudCharges.Programme;
                ReceiptItems.Stage:=StudCharges.Stage;
                ReceiptItems.Unit:=StudCharges.Unit;
                ReceiptItems.Semester:=StudCharges.Semester;
                ReceiptItems.INSERT;
                
                AmApply:=AmApply-AppliedAmount;
                END;
                
                END;
                END;
                UNTIL StudCharges.NEXT = 0;
                END;
                END;
                //end rest
                
                IF AmApply > 0 THEN BEGIN
                UniqNo:=UniqNo+1;
                ReceiptItems.INIT;
                ReceiptItems."Receipt No":=Receipt."Receipt No.";
                ReceiptItems.Code:='OP';
                ReceiptItems.Description:='Over Payment';
                ReceiptItems.Amount:=AmApply;
                ReceiptItems.Date:=Receipt.Date;
                ReceiptItems."Transaction ID":='';
                ReceiptItems."Student No.":=Receipt."Student No.";
                ReceiptItems."Uniq No 2":=UniqNo;
                ReceiptItems.INSERT;
                
                END;
                END;
                */

            end;

            trigger OnPostDataItem()
            begin
                /*
                IF AmApply > 0 THEN BEGIN
                UniqNo:=UniqNo+1;
                ReceiptItems.INIT;
                ReceiptItems."Receipt No":=Receipt."Receipt No.";
                ReceiptItems.Code:='OP';
                ReceiptItems.Description:='Over Payment';
                ReceiptItems.Amount:=AmApply;
                ReceiptItems.Date:=Receipt.Date;
                ReceiptItems."Transaction ID":='';
                ReceiptItems."Student No.":=Receipt."Student No.";
                ReceiptItems."Uniq No 2":=UniqNo;
                ReceiptItems.INSERT;
                
                END;
                */

            end;

            trigger OnPreDataItem()
            begin
                UniqNo := 75000;
                RItem.RESET;
                //RItem.SETFILTER(RItem.Date,'01/02/06..28/02/06');
                RItem.SETRANGE(RItem.Upposted, TRUE);
                IF RItem.FIND('-') THEN
                    RItem.MODIFYALL(RItem.Upposted, FALSE);
                //RItem.DELETEALL;
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
        StudCharges: Record 61535;
        AmApply: Decimal;
        ReceiptItems: Record 61539;
        AppliedAmount: Decimal;
        RItem: Record 61539;
        UniqNo: Integer;
        ChargeDesc: Text[200];
        TotalPaid: Decimal;
        CustLe: Integer;
        ReqAmount: Decimal;
        ReceiptCaptionLbl: Label 'Receipt';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

