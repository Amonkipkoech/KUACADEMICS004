report 51621 "Summary Enrollment 3"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Summary Enrollment 3.rdl';

    dataset
    {
        dataitem("ACA-Programme"; "ACA-Programme")
        {
            DataItemTableView = SORTING(Code);
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
            column(Programme_Paid; Paid)
            {
            }
            column(ProgrammeCaption; ProgrammeCaptionLbl)
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
            dataitem("ACA-Programme Stages"; "ACA-Programme Stages")
            {
                DataItemLink = "Programme Code" = FIELD(Code);
                column(Programme_Stages_Paid; Paid)
                {
                }
                column(Programme_Stages_Description; Description)
                {
                }
                column(Programme_Stages_Programme_Code; "Programme Code")
                {
                }
                column(Programme_Stages_Code; Code)
                {
                }
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
        ProgrammeCaptionLbl: Label 'Programme';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

