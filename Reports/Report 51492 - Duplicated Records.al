report 51492 "Duplicated Records"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Duplicated Records.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "Customer Type";
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
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(Customer__Debit_Amount_; "Debit Amount")
            {
            }
            column(Customer__Credit_Amount_; "Credit Amount")
            {
            }
            column(Customer_Balance; Balance)
            {
            }
            column(TBal; TBal)
            {
            }
            column(TCredits; TCredits)
            {
            }
            column(TDebit; TDebit)
            {
            }
            column(CustomerCaption; CustomerCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Customer__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Customer_NameCaption; FIELDCAPTION(Name))
            {
            }
            column(Customer__Debit_Amount_Caption; FIELDCAPTION("Debit Amount"))
            {
            }
            column(Customer__Credit_Amount_Caption; FIELDCAPTION("Credit Amount"))
            {
            }
            column(Customer_BalanceCaption; FIELDCAPTION(Balance))
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
        Cust: Record Customer;
        TBal: Decimal;
        TDebit: Decimal;
        TCredits: Decimal;
        CustomerCaptionLbl: Label 'Customer';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

