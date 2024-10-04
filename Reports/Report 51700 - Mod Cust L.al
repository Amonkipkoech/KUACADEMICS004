/// <summary>
/// Report Mod Cust L (ID 51700).
/// </summary>
report 51700 "Mod Cust L"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Mod Cust L.rdl';

    dataset
    {
        dataitem(DataItem8503; 21)
        {
            DataItemTableView = SORTING("Entry No.")
                                      // WHERE(Open = CONST(No),
                                      //"Remaining Amt. (LCY)"=FILTER(<>0))
                                      ;


            RequestFilterFields = "Customer No.";
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
            column(Cust__Ledger_Entry__Remaining_Amt___LCY__; "Remaining Amt. (LCY)")
            {
            }
            column(Cust__Ledger_Entry__Customer_No__; "Customer No.")
            {
            }
            column(Cust__Ledger_Entry__Posting_Date_; "Posting Date")
            {
            }
            column(Cust__Ledger_Entry__Document_Type_; "Document Type")
            {
            }
            column(Cust__Ledger_Entry__Document_No__; "Document No.")
            {
            }
            column(Cust__Ledger_Entry_Description; Description)
            {
            }
            column(Cust__Ledger_Entry__Currency_Code_; "Currency Code")
            {
            }
            column(Cust__Ledger_Entry_Amount; Amount)
            {
            }
            column(Cust__Ledger_EntryCaption; Cust__Ledger_EntryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Entry_No__Caption; FIELDCAPTION("Entry No."))
            {
            }
            column(Cust__Ledger_Entry__Remaining_Amt___LCY__Caption; FIELDCAPTION("Remaining Amt. (LCY)"))
            {
            }
            column(Cust__Ledger_Entry__Customer_No__Caption; FIELDCAPTION("Customer No."))
            {
            }
            column(Cust__Ledger_Entry__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
            {
            }
            column(Cust__Ledger_Entry__Document_Type_Caption; FIELDCAPTION("Document Type"))
            {
            }
            column(Cust__Ledger_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
            {
            }
            column(Cust__Ledger_Entry_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Cust__Ledger_Entry__Currency_Code_Caption; FIELDCAPTION("Currency Code"))
            {
            }
            column(Cust__Ledger_Entry_AmountCaption; FIELDCAPTION(Amount))
            {
            }

            trigger OnAfterGetRecord()
            begin
                "Closed by Entry No." := 0;
                "Closed at Date" := 0D;
                "Closed by Amount" := 0;
                "Closed by Amount (LCY)" := 0;
                "Closed by Currency Code" := '';
                "Closed by Currency Amount" := 0;
                Open := TRUE;
                MODIFY;
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
        Cust__Ledger_EntryCaptionLbl: Label 'Cust. Ledger Entry';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

