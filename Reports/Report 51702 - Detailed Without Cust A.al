/// <summary>
/// Report Detailed Without Cust A (ID 51702).
/// </summary>
report 51702 "Detailed Without Cust A"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Detailed Without Cust A.rdl';

    dataset
    {
        dataitem(DataItem6942; 379)
        {
            DataItemTableView = SORTING("Entry No.");
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
            column(Detailed_Cust__Ledg__Entry__Entry_No__; "Entry No.")
            {
            }
            column(Detailed_Cust__Ledg__Entry__Cust__Ledger_Entry_No__; "Cust. Ledger Entry No.")
            {
            }
            column(Detailed_Cust__Ledg__Entry__Entry_Type_; "Entry Type")
            {
            }
            column(Detailed_Cust__Ledg__Entry__Posting_Date_; "Posting Date")
            {
            }
            column(Detailed_Cust__Ledg__Entry__Document_Type_; "Document Type")
            {
            }
            column(Detailed_Cust__Ledg__Entry__Document_No__; "Document No.")
            {
            }
            column(Detailed_Cust__Ledg__Entry_Amount; Amount)
            {
            }
            column(Detailed_Cust__Ledg__Entry__Amount__LCY__; "Amount (LCY)")
            {
            }
            column(Detailed_Cust__Ledg__Entry__Customer_No__; "Customer No.")
            {
            }
            column(Detailed_Cust__Ledg__Entry__Applied_Cust__Ledger_Entry_No__; "Applied Cust. Ledger Entry No.")
            {
            }
            column(TAmount; TAmount)
            {
            }
            column(Detailed_Cust__Ledg__EntryCaption; Detailed_Cust__Ledg__EntryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Detailed_Cust__Ledg__Entry__Entry_No__Caption; FIELDCAPTION("Entry No."))
            {
            }
            column(Detailed_Cust__Ledg__Entry__Cust__Ledger_Entry_No__Caption; FIELDCAPTION("Cust. Ledger Entry No."))
            {
            }
            column(Detailed_Cust__Ledg__Entry__Entry_Type_Caption; FIELDCAPTION("Entry Type"))
            {
            }
            column(Detailed_Cust__Ledg__Entry__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
            {
            }
            column(Detailed_Cust__Ledg__Entry__Document_Type_Caption; FIELDCAPTION("Document Type"))
            {
            }
            column(Detailed_Cust__Ledg__Entry__Document_No__Caption; FIELDCAPTION("Document No."))
            {
            }
            column(Detailed_Cust__Ledg__Entry_AmountCaption; FIELDCAPTION(Amount))
            {
            }
            column(Detailed_Cust__Ledg__Entry__Amount__LCY__Caption; FIELDCAPTION("Amount (LCY)"))
            {
            }
            column(Detailed_Cust__Ledg__Entry__Customer_No__Caption; FIELDCAPTION("Customer No."))
            {
            }
            column(Detailed_Cust__Ledg__Entry__Applied_Cust__Ledger_Entry_No__Caption; FIELDCAPTION("Applied Cust. Ledger Entry No."))
            {
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

    var
        TAmount: Decimal;
        CustL: Record 21;
        DCustL: Record 379;
        Detailed_Cust__Ledg__EntryCaptionLbl: Label 'Detailed Cust. Ledg. Entry';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

