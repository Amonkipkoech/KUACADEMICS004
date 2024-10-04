report 51500 "Students Confirmed"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Students Confirmed.rdl';

    dataset
    {
        dataitem(DataItem6836; 18)
        {
            DataItemTableView = SORTING("No.")
                                WHERE("Customer Type" = CONST(Student));
            RequestFilterFields = "No.", "No. Of Receipts", "Confirmed Ok", "User ID";
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
            column(Customer__No__Of_Receipts_; "No. Of Receipts")
            {
            }
            column(Customer__Confirmed_Ok_; "Confirmed Ok")
            {
            }
            column(Customer__User_ID_; "User ID")
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
            column(Customer__No__Of_Receipts_Caption; FIELDCAPTION("No. Of Receipts"))
            {
            }
            column(Customer__Confirmed_Ok_Caption; FIELDCAPTION("Confirmed Ok"))
            {
            }
            column(Customer__User_ID_Caption; FIELDCAPTION("User ID"))
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

