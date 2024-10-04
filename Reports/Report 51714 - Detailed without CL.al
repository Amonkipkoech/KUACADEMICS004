/// <summary>
/// Report Detailed without CL (ID 51714).
/// </summary>
report 51714 "Detailed without CL"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Detailed without CL.rdl';

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
            column(Detailed_Cust__Ledg__Entry__Posting_Date_; "Posting Date")
            {
            }
            column(Detailed_Cust__Ledg__Entry__Document_No__; "Document No.")
            {
            }
            column(Detailed_Cust__Ledg__Entry_Amount; Amount)
            {
            }
            column(Detailed_Cust__Ledg__Entry__User_ID_; "User ID")
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
            column(Detailed_Cust__Ledg__Entry__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
            {
            }
            column(Detailed_Cust__Ledg__Entry__Document_No__Caption; FIELDCAPTION("Document No."))
            {
            }
            column(Detailed_Cust__Ledg__Entry_AmountCaption; FIELDCAPTION(Amount))
            {
            }
            column(Detailed_Cust__Ledg__Entry__User_ID_Caption; FIELDCAPTION("User ID"))
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
        CustL: Record 21;
        Detailed_Cust__Ledg__EntryCaptionLbl: Label 'Detailed Cust. Ledg. Entry';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

