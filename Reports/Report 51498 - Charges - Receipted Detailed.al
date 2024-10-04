report 51498 "Charges - Receipted Detailed"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Charges - Receipted Detailed.rdl';

    dataset
    {
        dataitem("ACA-Charge"; "ACA-Charge")
        {
            DataItemTableView = SORTING(Code);
            RequestFilterFields = "Code", "Date Filter";
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
            column(Charge__Date_Filter_; "Date Filter")
            {
            }
            column(Charge_Code; Code)
            {
            }
            column(Charge_Description; Description)
            {
            }
            column(Charge__G_L_Account_; "G/L Account")
            {
            }
            column(Charge__Total_Income_; "Total Income")
            {
            }
            column(Charge__Total_Income__Control1000000010; "Total Income")
            {
            }
            column(Charges___Amount_ReceiptedCaption; Charges___Amount_ReceiptedCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Charge__Date_Filter_Caption; FIELDCAPTION("Date Filter"))
            {
            }
            column(Receipt_Items_AmountCaption; "ACA-Receipt Items".FIELDCAPTION(Amount))
            {
            }
            column(Student_NameCaption; Student_NameCaptionLbl)
            {
            }
            column(Student_No_Caption; Student_No_CaptionLbl)
            {
            }
            column(Receipt_Items__Receipt_No_Caption; "ACA-Receipt Items".FIELDCAPTION("Receipt No"))
            {
            }
            column(Charge_CodeCaption; FIELDCAPTION(Code))
            {
            }
            column(Charge_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Charge__G_L_Account_Caption; FIELDCAPTION("G/L Account"))
            {
            }
            column(Charge__Total_Income_Caption; FIELDCAPTION("Total Income"))
            {
            }
            dataitem("ACA-Receipt Items"; "ACA-Receipt Items")
            {
                DataItemLink = Code = FIELD(Code);
                column(Name; Name)
                {
                }
                column(Receipt_Items_Amount; Amount)
                {
                }
                column(StudentNo; StudentNo)
                {
                }
                column(Receipt_Items__Receipt_No_; "Receipt No")
                {
                }
                column(Receipt_Items_Uniq_No_2; "Uniq No 2")
                {
                }
                column(Receipt_Items_Transaction_ID; "Transaction ID")
                {
                }
                column(Receipt_Items_Description; Description)
                {
                }
                column(Receipt_Items_Code; Code)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF Rcpt.GET("ACA-Receipt Items"."Receipt No") THEN BEGIN
                        StudentNo := Rcpt."Student No.";
                        Name := Rcpt."Student Name"
                    END ELSE BEGIN
                        Name := '';
                        StudentNo := '';
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    "ACA-Receipt Items".SETFILTER("ACA-Receipt Items".Date, "ACA-Charge".GETFILTER("ACA-Charge"."Date Filter"));
                end;
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
        Rcpt: Record 61538;
        Name: Text[250];
        StudentNo: Code[20];
        Charges___Amount_ReceiptedCaptionLbl: Label 'Charges - Amount Receipted';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Student_NameCaptionLbl: Label 'Student Name';
        Student_No_CaptionLbl: Label 'Student No.';
}

