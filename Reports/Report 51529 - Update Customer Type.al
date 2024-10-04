report 51529 "Update Customer Type"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Update Customer Type.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
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
            column(Customer__Customer_Posting_Group_; "Customer Posting Group")
            {
            }
            column(Customer__Customer_Type_; "Customer Type")
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
            column(Customer__Customer_Posting_Group_Caption; FIELDCAPTION("Customer Posting Group"))
            {
            }
            column(Customer__Customer_Type_Caption; FIELDCAPTION("Customer Type"))
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Customer."Customer Posting Group" = 'STUDENT' THEN BEGIN
                    Customer."Customer Type" := Customer."Customer Type"::Student;
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
        CustomerCaptionLbl: Label 'Customer';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

