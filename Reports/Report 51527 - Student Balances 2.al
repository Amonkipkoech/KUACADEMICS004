report 51527 "Student Balances 2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Student Balances 2.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.")
                                WHERE("Customer Type" = CONST(Student));
            RequestFilterFields = "No.", "Date Filter", "Balance (LCY)", "Debit Amount (LCY)", "Credit Amount (LCY)", "Credit Amount";
            column(COMPANYNAME; COMPANYNAME)
            {
            }
#pragma warning disable AL0667
            column(CurrReport_PAGENO; CurrReport.PAGENO)
#pragma warning restore AL0667
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Customer__Balance__LCY__; "Balance (LCY)")
            {
            }
            column(Customer__Balance__LCY___Control1000000015; "Balance (LCY)")
            {
            }
            column(Customer__Balance__LCY__Caption; FIELDCAPTION("Balance (LCY)"))
            {
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(Customer_NameCaption; FIELDCAPTION(Name))
            {
            }
            column(CustomerCaption; CustomerCaptionLbl)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(USERID; USERID)
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
        CustomerCaptionLbl: Label 'Customer';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

