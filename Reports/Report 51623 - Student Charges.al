report 51623 "Student Charges"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Student Charges.rdl';

    dataset
    {
        dataitem(DataItem7069; 17)
        {
#pragma warning disable AL0254
            DataItemTableView = SORTING(Description);
#pragma warning restore AL0254
            RequestFilterFields = Description;
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
            column(G_L_Entry_Description; Description)
            {
            }
            column(G_L_Entry__G_L_Account_No__; "G/L Account No.")
            {
            }
            column(G_L_Entry_Description_Control1102760014; Description)
            {
            }
            column(G_L_Entry_Amount; Amount)
            {
            }
            column(TotalFor___FIELDCAPTION_Description_; TotalFor + FIELDCAPTION(Description))
            {
            }
            column(G_L_Entry_Amount_Control1102760020; Amount)
            {
            }
            column(G_L_EntryCaption; G_L_EntryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(G_L_Entry__G_L_Account_No__Caption; FIELDCAPTION("G/L Account No."))
            {
            }
            column(G_L_Entry_Description_Control1102760014Caption; FIELDCAPTION(Description))
            {
            }
            column(G_L_Entry_AmountCaption; FIELDCAPTION(Amount))
            {
            }
            column(G_L_Entry_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(G_L_Entry_Entry_No_; "Entry No.")
            {
            }

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO(Description);
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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total for ';
        G_L_EntryCaptionLbl: Label 'G/L Entry';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

