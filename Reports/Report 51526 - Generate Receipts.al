report 51526 "Generate Receipts"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Generate Receipts.rdl';

    dataset
    {
        dataitem("ACA-Imp. Receipts Buffer"; "ACA-Imp. Receipts Buffer")
        {
            DataItemTableView = SORTING("Transaction Code")
                                WHERE(Posted = CONST(false));
            RequestFilterFields = Date, "Student No.", "Transaction Code";
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
            column(Imported_Receipts_Buffer__Transaction_Code_; "Transaction Code")
            {
            }
            column(Imported_Receipts_Buffer__Student_No__; "Student No.")
            {
            }
            column(Imported_Receipts_Buffer_Date; Date)
            {
            }
            column(Imported_Receipts_Buffer_Description; Description)
            {
            }
            column(Imported_Receipts_Buffer_Amount; Amount)
            {
            }
            column(Imported_Receipts_Buffer_Posted; Posted)
            {
            }
            column(Imported_Receipts_Buffer_Amount_Control1102760000; Amount)
            {
            }
            column(Imported_Receipts_BufferCaption; Imported_Receipts_BufferCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Imported_Receipts_Buffer__Transaction_Code_Caption; FIELDCAPTION("Transaction Code"))
            {
            }
            column(Imported_Receipts_Buffer__Student_No__Caption; FIELDCAPTION("Student No."))
            {
            }
            column(Imported_Receipts_Buffer_DateCaption; FIELDCAPTION(Date))
            {
            }
            column(Imported_Receipts_Buffer_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Imported_Receipts_Buffer_AmountCaption; FIELDCAPTION(Amount))
            {
            }
            column(Imported_Receipts_Buffer_PostedCaption; FIELDCAPTION(Posted))
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                StudentNo := '';
                currUser := UserId; 
                recBuffer.Reset();
                recBuffer.SetRange(recBuffer."User ID", currUser);
                if recBuffer.Find('-') then begin



                    IF Stud.GET("ACA-Imp. Receipts Buffer"."Student No.") THEN BEGIN
                        StudentNo := Stud."No.";
                    END ELSE
                        EXIT;
                    /*
                    IF StudentNo = '' THEN BEGIN
                    Stud.RESET;
                    Stud.SETRANGE(Stud."Old Student Code","ACA-Imp. Receipts Buffer"."Student No.");
                    IF Stud.FIND('-') THEN
                    StudentNo:=Stud."No.";

                    END;

                    IF StudentNo = '' THEN BEGIN
                    CReg.RESET;
                    CReg.SETRANGE(CReg."OLD No.","ACA-Imp. Receipts Buffer"."Student No.");
                    IF CReg.FIND('-') THEN
                    StudentNo:=CReg."Student No.";

                    END;
                    */
                    IF StudentNo = '' THEN BEGIN
                        Stud.RESET;
                        Stud.SETRANGE(Stud."Application No.", "ACA-Imp. Receipts Buffer"."Student No.");
                        IF Stud.FIND('-') THEN
                            StudentNo := Stud."No.";
                    END;
                    //END;


                    IF StudentNo = '' THEN
                        StudentNo := "ACA-Imp. Receipts Buffer"."Student No.";

                    IF StudentNo = '' THEN
                        StudentNo := 'N/A';




                    IF Cust.GET(StudentNo) THEN BEGIN
                        IF Cust.Blocked = Cust.Blocked::All THEN BEGIN

                            //Unallocated Receipts
                            /*
                            GenJnl.RESET;
                            GenJnl.SETRANGE("Journal Template Name",'SALES');
                            GenJnl.SETRANGE("Journal Batch Name",'STUD TR');
                            GenJnl.DELETEALL;
                            */

                            GenSetup.GET();

                            LineNo := LineNo + 10000;
                            GenJnl.INIT;
                            GenJnl."Line No." := LineNo;
                            GenJnl."Posting Date" := "ACA-Imp. Receipts Buffer".Date;
                            GenJnl."Document No." := "ACA-Imp. Receipts Buffer"."Transaction Code";
                            GenJnl."External Document No." := "ACA-Imp. Receipts Buffer"."Student No.";
                            GenJnl.VALIDATE(GenJnl."Document No.");
                            GenJnl."Journal Template Name" := 'SALES';
                            GenJnl."Journal Batch Name" := 'STUD TR';
                            GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                            GenJnl."Account No." := StudentNo;
                            GenJnl.VALIDATE(GenJnl."Account No.");
                            GenJnl.Amount := "ACA-Imp. Receipts Buffer".Amount;
                            GenJnl.VALIDATE(GenJnl.Amount);
                            GenJnl.Description := "ACA-Imp. Receipts Buffer".Description;
                            //GenJnl."Bal. Account Type":=GenJnl."Bal. Account Type"::"Bank Account";
                            //GenJnl."Bal. Account No.":='10';
                            IF TransType = TransType::Cheque THEN BEGIN
                                GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"Bank Account";
                                GenJnl."Bal. Account No." := TransBank;
                            end else
                                IF TransType = TransType::"M-pesa" THEN BEGIN
                                    GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"Bank Account";
                                    GenJnl."Bal. Account No." := TransBank;
                                END ELSE
                                    IF TransType = TransType::"Direct Bank Deposit" THEN BEGIN
                                        GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"Bank Account";
                                        GenJnl."Bal. Account No." := TransBank;
                                    END ELSE
                                        IF TransType = TransType::HELB THEN BEGIN
                                            GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                                            GenSetup.TESTFIELD(GenSetup."Helb Account");
                                            GenJnl."Bal. Account No." := GenSetup."Helb Account";
                                        END ELSE
                                            IF TransType = TransType::Bursary THEN BEGIN
                                                GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                                                GenSetup.TESTFIELD(GenSetup."CDF Account");
                                                GenJnl."Bal. Account No." := GenSetup."CDF Account";
                                            END ELSE
                                                IF TransType = TransType::CDF THEN BEGIN
                                                    GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                                                    GenSetup.TESTFIELD(GenSetup."CDF Account");
                                                    GenJnl."Bal. Account No." := GenSetup."CDF Account";
                                                END;

                            GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                            IF GenJnl.Amount <> 0 THEN
                                GenJnl.INSERT;

                            /*
                            GenJnl.SETRANGE("Journal Template Name",'SALES');
                            GenJnl.SETRANGE("Journal Batch Name",'STUD TR');
                            IF GenJnl.FIND('-') THEN BEGIN
                            REPEAT
                            GLPosting.RUN(GenJnl);
                            UNTIL GenJnl.NEXT = 0;
                            END;

                            GenJnl.RESET;
                            GenJnl.SETRANGE("Journal Template Name",'SALES');
                            GenJnl.SETRANGE("Journal Batch Name",'STUD TR');
                            GenJnl.DELETEALL;
                            */


                            "ACA-Imp. Receipts Buffer".Unallocated := TRUE;
                            //"ACA-Imp. Receipts Buffer".Posted:=TRUE;
                            "ACA-Imp. Receipts Buffer".MODIFY;

                        END ELSE BEGIN

                            StudPay.RESET;
                            StudPay.SETRANGE(StudPay."Student No.", StudentNo);
                            //StudPay.SetRange("User ID", UserId);
                            IF not StudPay.IsEmpty THEN
                                StudPay.DELETEALL;


                            StudPay.INIT;
                            StudPay."Student No." := StudentNo;
                            StudPay."User ID" := USERID;
                            //StudPay."Payment Mode":=StudPay."Payment Mode"::"Direct Bank Deposit";
                            IF TransType = TransType::Cheque THEN BEGIN
                                StudPay."Payment Mode" := StudPay."Payment Mode"::Cheque;
                            end else
                                IF TransType = TransType::"M-pesa" THEN BEGIN
                                    StudPay."Payment Mode" := StudPay."Payment Mode"::"M-Pesa";
                                end else
                                    IF TransType = TransType::"Direct Bank Deposit" THEN BEGIN
                                        StudPay."Payment Mode" := StudPay."Payment Mode"::"Direct Bank Deposit";
                                    END ELSE
                                        IF TransType = TransType::HELB THEN BEGIN
                                            StudPay."Payment Mode" := StudPay."Payment Mode"::HELB;
                                        END ELSE
                                            IF TransType = TransType::Bursary THEN BEGIN
                                                StudPay."Payment Mode" := StudPay."Payment Mode"::CDF;
                                            END ELSE
                                                IF TransType = TransType::CDF THEN BEGIN
                                                    StudPay."Payment Mode" := StudPay."Payment Mode"::CDF;
                                                END;
                            StudPay."Cheque No" := "ACA-Imp. Receipts Buffer"."Transaction Code";
                            StudPay."Drawer Name" := "ACA-Imp. Receipts Buffer".Description;
                            StudPay."Payment By" := "ACA-Imp. Receipts Buffer".Description;
                            StudPay."Bank No." := TransBank;
                            StudPay."Amount to pay" := "ACA-Imp. Receipts Buffer".Amount;
                            StudPay."Cheque No" := "ACA-Imp. Receipts Buffer"."Cheque No";
                            StudPay.VALIDATE(StudPay."Amount to pay");
                            StudPay."Transaction Date" := "ACA-Imp. Receipts Buffer".Date;
                            //StudPay.VALIDATE(StudPay."Auto Bill");
                            StudPay.VALIDATE(StudPay."Auto Post Final");

                            StudPay.INSERT;
                            /*
                            GenSetup.GET();

                            LineNo:=LineNo+10000;
                            GenJnl.INIT;
                            GenJnl."Line No." := LineNo;
                            GenJnl."Posting Date":="ACA-Imp. Receipts Buffer".Date;
                            GenJnl."Document No.":="ACA-Imp. Receipts Buffer"."Transaction Code";
                            GenJnl."External Document No.":="ACA-Imp. Receipts Buffer"."Student No.";
                            GenJnl.VALIDATE(GenJnl."Document No.");
                            GenJnl."Journal Template Name":='SALES';
                            GenJnl."Journal Batch Name":='STUD TR';
                            GenJnl."Account Type":=GenJnl."Account Type"::Customer;
                            GenJnl."Account No.":=StudentNo;//GenSetup."Unallocated Rcpts Account";
                            GenJnl.VALIDATE(GenJnl."Account No.");
                            GenJnl.Amount:="ACA-Imp. Receipts Buffer".Amount * -1;
                            GenJnl.VALIDATE(GenJnl.Amount);
                            GenJnl.Description:="ACA-Imp. Receipts Buffer".Description;
                            //GenJnl."Bal. Account Type":=GenJnl."Bal. Account Type"::"Bank Account";
                            //GenJnl."Bal. Account No.":='10';
                            IF TransType = TransType::"Direct Bank Deposit" THEN BEGIN
                            GenJnl."Bal. Account Type":=GenJnl."Bal. Account Type"::"Bank Account";
                            GenJnl."Bal. Account No.":=TransBank;
                            END ELSE IF TransType = TransType::HELB THEN BEGIN
                            GenJnl."Bal. Account Type":=GenJnl."Bal. Account Type"::"G/L Account";
                            GenSetup.TESTFIELD(GenSetup."Helb Account");
                            GenJnl."Bal. Account No.":=GenSetup."Helb Account";
                            END ELSE IF TransType = TransType::Bursary THEN BEGIN
                            GenJnl."Bal. Account Type":=GenJnl."Bal. Account Type"::"G/L Account";
                            GenSetup.TESTFIELD(GenSetup."CDF Account");
                            GenJnl."Bal. Account No.":=GenSetup."CDF Account";
                            END ELSE IF TransType = TransType::CDF THEN BEGIN
                            GenJnl."Bal. Account Type":=GenJnl."Bal. Account Type"::"G/L Account";
                            GenSetup.TESTFIELD(GenSetup."CDF Account");
                            GenJnl."Bal. Account No.":=GenSetup."CDF Account";
                            END;
                            GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                            IF GenJnl.Amount <> 0 THEN
                            GenJnl.INSERT;

                            */
                            "ACA-Imp. Receipts Buffer".Unallocated := TRUE;
                            "ACA-Imp. Receipts Buffer".Posted := TRUE;
                            "ACA-Imp. Receipts Buffer".MODIFY;
                        END;

                    END ELSE BEGIN
                        //Unallocated Receipts
                        /*
                        GenJnl.RESET;
                        GenJnl.SETRANGE("Journal Template Name",'SALES');
                        GenJnl.SETRANGE("Journal Batch Name",'STUD TR');
                        GenJnl.DELETEALL;
                        */

                        GenSetup.GET();

                        LineNo := LineNo + 10000;
                        GenJnl.INIT;
                        GenJnl."Line No." := LineNo;
                        GenJnl."Posting Date" := "ACA-Imp. Receipts Buffer".Date;
                        GenJnl."Document No." := "ACA-Imp. Receipts Buffer"."Transaction Code";

                        GenJnl."External Document No." := "ACA-Imp. Receipts Buffer"."Student No.";
                        GenJnl.VALIDATE(GenJnl."Document No.");
                        GenJnl."Journal Template Name" := 'SALES';
                        GenJnl."Journal Batch Name" := 'STUD TR';
                        GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                        GenJnl."Account No." := GenSetup."Unallocated Rcpts Account";
                        GenJnl.VALIDATE(GenJnl."Account No.");
                        GenJnl.Amount := "ACA-Imp. Receipts Buffer".Amount * -1;
                        GenJnl.VALIDATE(GenJnl.Amount);
                        GenJnl.Description := "ACA-Imp. Receipts Buffer".Description;
                        //GenJnl."Bal. Account Type":=GenJnl."Bal. Account Type"::"Bank Account";
                        //GenJnl."Bal. Account No.":='10';
                        IF TransType = TransType::"M-pesa" THEN BEGIN
                            GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"Bank Account";
                            GenJnl."Bal. Account No." := TransBank;
                        END ELSE
                            IF TransType = TransType::"Direct Bank Deposit" THEN BEGIN
                                GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"Bank Account";
                                GenJnl."Bal. Account No." := TransBank;
                            END ELSE
                                IF TransType = TransType::HELB THEN BEGIN
                                    GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                                    GenSetup.TESTFIELD(GenSetup."Helb Account");
                                    GenJnl."Bal. Account No." := GenSetup."Helb Account";
                                END ELSE
                                    IF TransType = TransType::Bursary THEN BEGIN
                                        GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                                        GenSetup.TESTFIELD(GenSetup."CDF Account");
                                        GenJnl."Bal. Account No." := GenSetup."CDF Account";
                                    END ELSE
                                        IF TransType = TransType::CDF THEN BEGIN
                                            GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                                            GenSetup.TESTFIELD(GenSetup."CDF Account");
                                            GenJnl."Bal. Account No." := GenSetup."CDF Account";
                                        END;
                        GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                        IF GenJnl.Amount <> 0 THEN
                            GenJnl.INSERT;

                        "ACA-Imp. Receipts Buffer".Unallocated := TRUE;
                        //"ACA-Imp. Receipts Buffer".Posted:=TRUE;
                        "ACA-Imp. Receipts Buffer".MODIFY;


                    END;
                end;

                //END;
            end;

            trigger OnPostDataItem()
            begin


                GenJnl.SETRANGE("Journal Template Name", 'SALES');
                GenJnl.SETRANGE("Journal Batch Name", 'STUD TR');
                IF GenJnl.FIND('-') THEN BEGIN
                    REPEAT
                    //GLPosting.RUN(GenJnl);
                    UNTIL GenJnl.NEXT = 0;
                END;
                /*
                GenJnl.RESET;
                GenJnl.SETRANGE("Journal Template Name",'SALES');
                GenJnl.SETRANGE("Journal Batch Name",'STUD TR');
                GenJnl.DELETEALL;
                */

            end;

            trigger OnPreDataItem()
            begin

                IF TransType = TransType::" " THEN
                    ERROR('You must specify the trasaction type.');


                LineNo := 0;
                GenJnl.RESET;
                GenJnl.SETRANGE("Journal Template Name", 'SALES');
                GenJnl.SETRANGE("Journal Batch Name", 'STUD TR');
                GenJnl.DELETEALL;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(TransType; TransType)
                {
                    Caption = 'Transaction Type';
                    ApplicationArea = All;
                }
                field(TransBank; TransBank)
                {
                    Caption = 'Transaction Bank';
                    TableRelation = "Bank Account";
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        StudPay: Record 61536;
        Cust: Record 18;
        GenJnl: Record 81;
        GenSetup: Record 61534;
        GLPosting: Codeunit 12;
        Stud: Record 18;
        StudentNo: Code[20];
        CReg: Record 61532;
        LineNo: Integer;
        TransType: Option " ","M-pesa",Cheque,"Direct Bank Deposit",HELB,Bursary,CDF,Scholarship;
        Imported_Receipts_BufferCaptionLbl: Label 'Imported Receipts Buffer';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        TotalCaptionLbl: Label 'Total';
        TransBank: Code[20];
        recBuffer: Record "ACA-Imp. Receipts Buffer";
        currUser: code[20];
}

