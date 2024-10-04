report 51496 "Programme - Income (Reg)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Programme - Income (Reg).rdl';

    dataset
    {
        dataitem(DataItem1410; 61511)
        {
            DataItemTableView = SORTING(Code);
            RequestFilterFields = "Code", "Semester Filter", "School Code", "Date Filter", Status;
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
            column(Programme_Code; Code)
            {
            }
            column(Programme_Description; Description)
            {
            }
            column(Programme__Total_Income__Rcpt__; "Total Income (Rcpt)")
            {
            }
            column(Programme__Total_Income__Rcpt___Control1000000010; "Total Income (Rcpt)")
            {
            }
            column(Programme_Receipted_Income_Caption; Programme_Receipted_Income_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Programme_CodeCaption; FIELDCAPTION(Code))
            {
            }
            column(Programme_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Programme__Total_Income__Rcpt__Caption; FIELDCAPTION("Total Income (Rcpt)"))
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
        Programme_Receipted_Income_CaptionLbl: Label 'Programme Receipted Income ';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

