report 51319 "Tuition Fees Collection"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Tuition Fees Collection.rdl';

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Date Filter";
            column(G_L_Account_No_; "No.")
            {
            }
            dataitem("G/L Entry"; "G/L Entry")
            {
                DataItemLink = "G/L Account No." = FIELD("No.");
                DataItemTableView = SORTING("G/L Account No.", "Posting Date", "Document No.")
                                    ORDER(Ascending)
                                    WHERE("G/L Account No." = CONST(),
                                          "Document No." = FILTER('TR*'),
                                          Description = FILTER('Fees for *'),
                                          Amount = FILTER(< 0));
                column(COMPANYNAME; COMPANYNAME)
                {
                }
                column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
                {
                }
                column(USERID; USERID)
                {
                }
#pragma warning disable AL0667
                column(CurrReport_PAGENO; CurrReport.PAGENO)
#pragma warning restore AL0667
                {
                }
                column(G_L_Entry__Posting_Date_; "Posting Date")
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
                column(G_L_Entry_Amount_Control1102760000; Amount)
                {
                }
                column(Tuition_Fees_CollectionsCaption; Tuition_Fees_CollectionsCaptionLbl)
                {
                }
                column(DescriptionCaption; DescriptionCaptionLbl)
                {
                }
                column(Student_No_Caption; Student_No_CaptionLbl)
                {
                }
                column(Posting_DateCaption; Posting_DateCaptionLbl)
                {
                }
                column(Receipt_NoCaption; Receipt_NoCaptionLbl)
                {
                }
                column(AmountCaption; AmountCaptionLbl)
                {
                }
                column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                {
                }
                column(Total_AmountCaption; Total_AmountCaptionLbl)
                {
                }
                column(G_L_Entry_Entry_No_; "Entry No.")
                {
                }
                column(G_L_Entry_G_L_Account_No_; "G/L Account No.")
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
        Tuition_Fees_CollectionsCaptionLbl: Label 'Tuition Fees Collections';
        DescriptionCaptionLbl: Label 'Description';
        Student_No_CaptionLbl: Label 'Student No.';
        Posting_DateCaptionLbl: Label 'Posting Date';
        Receipt_NoCaptionLbl: Label 'Receipt No';
        AmountCaptionLbl: Label 'Amount';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Total_AmountCaptionLbl: Label 'Total Amount';
}

