/// <summary>
/// Report Insert Rcpt Nos 1 (ID 51687).
/// </summary>
report 51687 "Insert Rcpt Nos 1"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Insert Rcpt Nos 1.rdl';

    dataset
    {
        dataitem(DataItem8503; 21)
        {
            DataItemTableView = SORTING("Entry No.")
                                WHERE(Amount = FILTER(< 0));
            RequestFilterFields = "Entry No.";
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
            column(Bank_Account_Ledger_EntryCaption; Bank_Account_Ledger_EntryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Entry_No__Caption; FIELDCAPTION("Entry No."))
            {
            }
            column(Cust__Ledger_Entry__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
            {
            }
            column(Cust__Ledger_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
            {
            }
            column(Cust__Ledger_Entry_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Cust__Ledger_Entry_AmountCaption; FIELDCAPTION(Amount))
            {
            }

            trigger OnAfterGetRecord()
            begin

                IF LastRCNo <> "Document No." THEN BEGIN
                    LastRCNo := "Document No.";
                    IF "Document No." <> 'OPENING' THEN BEGIN
                        Rcpt.RESET;
                        //MESSAGE("Cust. Ledger Entry"."Document No.");
                        Rcpt.RESET;
                        Rcpt.SETRANGE(Rcpt."Student No.", "Customer No.");
                        Rcpt.SETRANGE(Rcpt."Receipt No.", "Document No.");
                        IF Rcpt.FIND('-') = FALSE THEN BEGIN
                            Bank.RESET;
                            Bank.SETRANGE(Bank."Posting Date", "Posting Date");
                            Bank.SETRANGE(Bank."Document No.", "Document No.");
                            IF Bank.FIND('-') THEN BEGIN
                                Rcpt.INIT;
                                Rcpt."Receipt No." := "Document No." + 'N';
                                Rcpt."Student No." := "Customer No.";
                                Rcpt.Date := "Posting Date";
                                Rcpt.Amount := Bank.Amount;
                                Rcpt.Posted := TRUE;
                                //Rcpt."KCA Rcpt No":='IN';
                                Rcpt.INSERT;
                            END;
                        END;

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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Rcpt: Record 61538;
        Bank: Record 271;
        LastRCNo: Text[50];
        Bank_Account_Ledger_EntryCaptionLbl: Label 'Bank Account Ledger Entry';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

