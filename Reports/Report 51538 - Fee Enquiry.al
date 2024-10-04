report 51538 "Fee Enquiry"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Fee Enquiry.rdl';

    dataset
    {
        dataitem("ACA-Proforma"; "ACA-Proforma")
        {
            DataItemTableView = SORTING("Proforma No.");
            RequestFilterFields = "Proforma No.";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
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
            column(Proforma__Programme_Description_; "Programme Description")
            {
            }
            column(Proforma__Student_Type_; "Student Type")
            {
            }
            column(Proforma__Settlement_Type_; "Settlement Type")
            {
            }
            column(FEE_ENQUIRYCaption; FEE_ENQUIRYCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(MASENO_UNIVERSITYCaption; MASENO_UNIVERSITYCaptionLbl)
            {
            }
            column(P_O_Box_Private_Bag__Maseno___KenyaCaption; P_O_Box_Private_Bag__Maseno___KenyaCaptionLbl)
            {
            }
            column(Tel___254_2__750255_8___Fax___254_2__750260___E_Mail__enquiries_maseno_ac_ke___Website__www_masano_ac_ke_Caption; Tel___254_2__750255_8___Fax___254_2__750260___E_Mail__enquiries_maseno_ac_ke___Website__www_masano_ac_ke_CaptionLbl)
            {
            }
            column(Proforma_Lines_AmountCaption; "ACA-Proforma Lines".FIELDCAPTION(Amount))
            {
            }
            column(Proforma_Lines_DescriptionCaption; "ACA-Proforma Lines".FIELDCAPTION(Description))
            {
            }
            column(Proforma_Lines_CodeCaption; "ACA-Proforma Lines".FIELDCAPTION(Code))
            {
            }
            column(Proforma_Lines_StageCaption; "ACA-Proforma Lines".FIELDCAPTION(Stage))
            {
            }
            column(Proforma_Lines_QuantityCaption; "ACA-Proforma Lines".FIELDCAPTION(Quantity))
            {
            }
            column(Proforma_Proforma_No_; "Proforma No.")
            {
            }
            dataitem("ACA-Proforma Lines"; 61589)
            {
                DataItemLink = "Reg. Transacton ID" = FIELD("Proforma No.");
                column(Proforma_Lines_Code; Code)
                {
                }
                column(Proforma_Lines_Description; Description)
                {
                }
                column(Proforma_Lines_Amount; Amount)
                {
                }
                column(Proforma_Lines_Stage; Stage)
                {
                }
                column(Proforma_Lines_Quantity; Quantity)
                {
                }
                column(Proforma_Lines_Amount_Control1102760031; Amount)
                {
                }
                column(Total_Caption; Total_CaptionLbl)
                {
                }
                column(Proforma_Lines_Transacton_ID; "Transacton ID")
                {
                }
                column(Proforma_Lines_Student_No_; "Student No.")
                {
                }
                column(Proforma_Lines_Reg__Transacton_ID; "Reg. Transacton ID")
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
        FEE_ENQUIRYCaptionLbl: Label 'FEE ENQUIRY';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        MASENO_UNIVERSITYCaptionLbl: Label 'MASENO UNIVERSITY';
        P_O_Box_Private_Bag__Maseno___KenyaCaptionLbl: Label 'Private Bag MASENO - Kenya';
        Tel___254_2__750255_8___Fax___254_2__750260___E_Mail__enquiries_maseno_ac_ke___Website__www_masano_ac_ke_CaptionLbl: Label 'Tel: (254 2) 750255-8 | Fax: (254 2) 750260 | E-Mail: enquiries@kilimambogoUniversity,co.ke | Website: www.karu.ac.ke ';
        Total_CaptionLbl: Label 'Total:';
}

