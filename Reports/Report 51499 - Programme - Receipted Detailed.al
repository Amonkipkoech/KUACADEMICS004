report 51499 "Programme - Receipted Detailed"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Programme - Receipted Detailed.rdl';

    dataset
    {
        dataitem("ACA-Programme"; "ACA-Programme")
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
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(Student_NameCaption; Student_NameCaptionLbl)
            {
            }
            column(Student_No_Caption; Student_No_CaptionLbl)
            {
            }
            column(Receipt_No_Caption; Receipt_No_CaptionLbl)
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
            column(Programme_Date_Filter; "Date Filter")
            {
            }
            dataitem("ACA-Receipt Items"; "ACA-Receipt Items")
            {
                DataItemLink = Programme = FIELD(Code),
                               Date = FIELD("Date Filter");
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
                column(Receipt_Items_Programme; Programme)
                {
                }
                column(Receipt_Items_Date; Date)
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
                    //"Receipt Items".SETFILTER("Receipt Items".Date,Programme.GETFILTER(Programme."Date Filter"));
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
        Programme_Receipted_Income_CaptionLbl: Label 'Programme Receipted Income ';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        AmountCaptionLbl: Label 'Amount';
        Student_NameCaptionLbl: Label 'Student Name';
        Student_No_CaptionLbl: Label 'Student No.';
        Receipt_No_CaptionLbl: Label 'Receipt No.';
}

