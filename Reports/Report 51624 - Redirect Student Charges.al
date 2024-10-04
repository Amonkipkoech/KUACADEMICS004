report 51624 "Redirect Student Charges"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Redirect Student Charges.rdl';

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = SORTING("Entry No.");
            RequestFilterFields = "G/L Account No.", Description;
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
            column(G_L_Entry__Entry_No__; "Entry No.")
            {
            }
            column(G_L_Entry__G_L_Account_No__; "G/L Account No.")
            {
            }
            column(G_L_Entry__Posting_Date_; "Posting Date")
            {
            }
            column(G_L_Entry__Document_Type_; "Document Type")
            {
            }
            column(G_L_Entry__Document_No__; "Document No.")
            {
            }
            column(G_L_Entry_Description; Description)
            {
            }
            column(G_L_Entry__Bal__Account_No__; "Bal. Account No.")
            {
            }
            column(G_L_Entry_Amount; Amount)
            {
            }
            column(G_L_EntryCaption; G_L_EntryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(G_L_Entry__Entry_No__Caption; FIELDCAPTION("Entry No."))
            {
            }
            column(G_L_Entry__G_L_Account_No__Caption; FIELDCAPTION("G/L Account No."))
            {
            }
            column(G_L_Entry__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
            {
            }
            column(G_L_Entry__Document_Type_Caption; FIELDCAPTION("Document Type"))
            {
            }
            column(G_L_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
            {
            }
            column(G_L_Entry_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(G_L_Entry__Bal__Account_No__Caption; FIELDCAPTION("Bal. Account No."))
            {
            }
            column(G_L_Entry_AmountCaption; FIELDCAPTION(Amount))
            {
            }

            trigger OnAfterGetRecord()
            begin
                GenJnl.INIT;
                GenJnl."Line No." := GenJnl."Line No." + 10000;
                GenJnl."Posting Date" := "G/L Entry"."Posting Date";
                GenJnl."Document No." := "G/L Entry"."Document No.";
                GenJnl.VALIDATE(GenJnl."Document No.");
                GenJnl."Journal Template Name" := 'SALES';
                GenJnl."Journal Batch Name" := 'STUD TR';
                GenJnl."Account Type" := GenJnl."Account Type"::"G/L Account";
                GenJnl."Account No." := "G/L Entry"."G/L Account No.";
                GenJnl.Amount := -"G/L Entry".Amount;
                GenJnl.VALIDATE(GenJnl."Account No.");
                GenJnl.VALIDATE(GenJnl.Amount);
                GenJnl.Description := "G/L Entry"."Source No." + ' - ' + "G/L Entry".Description;
                GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                GenJnl."Bal. Account No." := '300004';
                GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                GenJnl."Shortcut Dimension 1 Code" := "G/L Entry"."Global Dimension 1 Code";
                GenJnl."Shortcut Dimension 2 Code" := "G/L Entry"."Global Dimension 2 Code";
                GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
                GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                GenJnl.INSERT;
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
        GenJnl: Record 81;
        G_L_EntryCaptionLbl: Label 'G/L Entry';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

