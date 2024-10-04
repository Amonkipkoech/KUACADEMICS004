report 51393 "stud list new"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/stud list new.rdl';

    dataset
    {
        dataitem(DataItem6836; 18)
        {
            DataItemTableView = SORTING("No.") WHERE("Customer Posting Group" = CONST('STUDENT'), Blocked = CONST(" "));
            RequestFilterFields = "No.";
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
            column(Customer__Debit_Amount__LCY__; "Debit Amount (LCY)")
            {
            }
            column(Customer__Credit_Amount__LCY__; "Credit Amount (LCY)")
            {
            }
            column(Customer__Balance__LCY__; "Balance (LCY)")
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
            column(Customer__Debit_Amount__LCY__Caption; FIELDCAPTION("Debit Amount (LCY)"))
            {
            }
            column(Customer__Credit_Amount__LCY__Caption; FIELDCAPTION("Credit Amount (LCY)"))
            {
            }
            column(Customer__Balance__LCY__Caption; FIELDCAPTION("Balance (LCY)"))
            {
            }
            column(HS; HS)
            {
            }

            trigger OnAfterGetRecord()
            begin
                HS := HS + 1;
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
        CustomerCaptionLbl: Label 'Customer';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        HS: Integer;
}

