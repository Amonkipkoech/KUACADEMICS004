report 51274 "HTL Old Customers"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/HTL Old Customers.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = WHERE("HTL Status" = CONST(Old));
            RequestFilterFields = "No.";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            /* column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            } */
            column(USERID; USERID)
            {
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(Customer_Address; Address)
            {
            }
            column(Customer__Address_2_; "Address 2")
            {
            }
            column(Customer_Balance; Balance)
            {
            }
            column(Customer__Arrival_Date_; "Arrival Date")
            {
            }
            column(Customer__Check_Out_Date_; "Check Out Date")
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
            column(Customer_AddressCaption; FIELDCAPTION(Address))
            {
            }
            column(Customer__Address_2_Caption; FIELDCAPTION("Address 2"))
            {
            }
            column(Customer_BalanceCaption; FIELDCAPTION(Balance))
            {
            }
            column(Customer__Arrival_Date_Caption; FIELDCAPTION("Arrival Date"))
            {
            }
            column(Customer__Check_Out_Date_Caption; FIELDCAPTION("Check Out Date"))
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

