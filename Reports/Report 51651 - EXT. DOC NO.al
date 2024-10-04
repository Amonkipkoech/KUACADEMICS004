/// <summary>
/// Report EXT. DOC NO (ID 51651).
/// </summary>
report 51651 "EXT. DOC NO"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/EXT. DOC NO.rdl';

    dataset
    {
        dataitem(DataItem7024; 81)
        {
            DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Line No.");
            RequestFilterFields = "Journal Template Name", "Journal Batch Name";
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
            column(Gen__Journal_Line__Journal_Template_Name_; "Journal Template Name")
            {
            }
            column(Gen__Journal_Line__Line_No__; "Line No.")
            {
            }
            column(Gen__Journal_Line__Account_No__; "Account No.")
            {
            }
            column(Gen__Journal_Line__Posting_Date_; "Posting Date")
            {
            }
            column(Gen__Journal_Line__External_Document_No__; "External Document No.")
            {
            }
            column(Gen__Journal_LineCaption; Gen__Journal_LineCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Gen__Journal_Line__Journal_Template_Name_Caption; FIELDCAPTION("Journal Template Name"))
            {
            }
            column(Gen__Journal_Line__Line_No__Caption; FIELDCAPTION("Line No."))
            {
            }
            column(Gen__Journal_Line__Account_No__Caption; FIELDCAPTION("Account No."))
            {
            }
            column(Gen__Journal_Line__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
            {
            }
            column(Gen__Journal_Line__External_Document_No__Caption; FIELDCAPTION("External Document No."))
            {
            }
            column(Gen__Journal_Line_Journal_Batch_Name; "Journal Batch Name")
            {
            }

            trigger OnAfterGetRecord()
            begin
                // "External Document No." := COPYSTR("Gen.Journal Line"."External Document No.", 1, 19);
                //"Gen. Journal Line".MODIFY;
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
        Gen__Journal_LineCaptionLbl: Label 'Gen. Journal Line';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

