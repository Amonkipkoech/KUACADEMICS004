/// <summary>
/// Report Insert Rcpt Nos (ID 51684).
/// </summary>
report 51684 "Insert Rcpt Nos"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Insert Rcpt Nos.rdl';

    dataset
    {
        dataitem(DataItem4920; 271)
        {
            DataItemTableView = SORTING("Entry No.");
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
            column(Bank_Account_Ledger_Entry__Entry_No__; "Entry No.")
            {
            }
            column(Bank_Account_Ledger_Entry__Bank_Account_No__; "Bank Account No.")
            {
            }
            column(Bank_Account_Ledger_Entry__Posting_Date_; "Posting Date")
            {
            }
            column(Bank_Account_Ledger_Entry__Document_No__; "Document No.")
            {
            }
            column(Bank_Account_Ledger_Entry_Description; Description)
            {
            }
            column(Bank_Account_Ledger_Entry_Amount; Amount)
            {
            }
            column(Bank_Account_Ledger_EntryCaption; Bank_Account_Ledger_EntryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Bank_Account_Ledger_Entry__Entry_No__Caption; FIELDCAPTION("Entry No."))
            {
            }
            column(Bank_Account_Ledger_Entry__Bank_Account_No__Caption; FIELDCAPTION("Bank Account No."))
            {
            }
            column(Bank_Account_Ledger_Entry__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
            {
            }
            column(Bank_Account_Ledger_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
            {
            }
            column(Bank_Account_Ledger_Entry_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Bank_Account_Ledger_Entry_AmountCaption; FIELDCAPTION(Amount))
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF "Document No." <> 'OPENING' THEN BEGIN
                    IF Rcpt.GET("Document No.") = FALSE THEN BEGIN
                        Rcpt.INIT;
                        Rcpt."Receipt No." := "Document No." + 'N';
                        //Rcpt."Student No.":=;
                        Rcpt.Date := "Posting Date";
                        Rcpt.Amount := Amount;
                        Rcpt.Posted := TRUE;
                        Rcpt.INSERT;
                    END;

                END;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Entry No.");
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
        Bank_Account_Ledger_EntryCaptionLbl: Label 'Bank Account Ledger Entry';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

