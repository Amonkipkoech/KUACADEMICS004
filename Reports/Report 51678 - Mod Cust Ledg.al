/// <summary>
/// Report Mod Cust Ledg (ID 51678).
/// </summary>
report 51678 "Mod Cust Ledg"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Mod Cust Ledg.rdl';

    dataset
    {
        dataitem(DataItem8503; 271)
        {
            DataItemTableView = SORTING("Entry No.");
            RequestFilterFields = Open, "Remaining Amount";
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
            column(no; "Statement No.")
            {
            }
            column(status; "Statement Status")
            {
            }

            trigger OnAfterGetRecord()
            begin
                "Statement No." := '';
                "Statement Line No." := 0;
                "Statement Status" := "Statement Status"::Open;
                //"Bank Account Ledger Entry".MODIFY;
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
        Cust__Ledger_EntryCaptionLbl: Label 'Cust. Ledger Entry';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

