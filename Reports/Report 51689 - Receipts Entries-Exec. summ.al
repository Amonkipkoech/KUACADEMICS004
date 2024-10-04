/// <summary>
/// Report Receipts Entries-Exec. summ (ID 51689).
/// </summary>
report 51689 "Receipts Entries-Exec. summ"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Receipts Entries-Exec. summ.rdl';

    dataset
    {
        dataitem(DataItem5672; 61538)
        {
            DataItemTableView = SORTING("Payment Mode")
                                ORDER(Ascending);
            RequestFilterFields = "Bank Account", Date, "Payment Mode", "User ID";
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
            column(Receipt__Student_No__; "Student No.")
            {
            }
            column(Receipt__Receipt_No__; "Receipt No.")
            {
            }
            column(Receipt_Date; Date)
            {
            }
            column(Receipt_Amount; Amount)
            {
            }
            column(SName; SName)
            {
            }
            column(Course; Course)
            {
            }
            column(Receipt__Payment_Mode_; "Payment Mode")
            {
            }
            column(Receipt_Amount_Control1000000039; Amount)
            {
            }
            column(Receipt_Amount_Control1000000007; Amount)
            {
            }
            column(Receipt_Receipt_Date; Date)
            {
            }
            column(Income_Analysis_Cash_RegisterCaption; Income_Analysis_Cash_RegisterCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Receipt__Receipt_No__Caption; FIELDCAPTION("Receipt No."))
            {
            }
            column(Receipt__Student_No__Caption; FIELDCAPTION("Student No."))
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Receipt_DateCaption; FIELDCAPTION(Date))
            {
            }
            column(Receipt_AmountCaption; FIELDCAPTION(Amount))
            {
            }
            column(MASENO_UNIVERSITYSCaption; MASENO_UNIVERSITYSCaptionLbl)
            {
            }
            column(CourseCaption; CourseCaptionLbl)
            {
            }
            column(Receipt__Payment_Mode_Caption; FIELDCAPTION("Payment Mode"))
            {
            }
            column(DAILY_RECEIPTS_EXECUTIVE_SUMMARYCaption; DAILY_RECEIPTS_EXECUTIVE_SUMMARYCaptionLbl)
            {
            }
            column(Group_TotalsCaption; Group_TotalsCaptionLbl)
            {
            }
            column(Grand_Totals_ForCaption; Grand_Totals_ForCaptionLbl)
            {
            }
            column(BankSlipChequeNo_Receipt; "Bank Slip/Cheque No")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Cust.GET("Student No.") THEN
                    SName := Cust.Name
                ELSE
                    SName := '';
                StudNo := StudNo + 1;
                CourseReg.RESET;
                CourseReg.SETRANGE(CourseReg."Student No.", "Student No.");
                IF CourseReg.FIND('-') THEN BEGIN
                    Course := CourseReg.Programmes;
                END;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("User ID");
                StudNo := 0;
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
        Cust: Record 18;
        SName: Text[200];
        StudNo: Integer;
        Course: Code[20];
        CourseReg: Record 61532;
        Income_Analysis_Cash_RegisterCaptionLbl: Label 'Income Analysis-Cash Register';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        NameCaptionLbl: Label 'Name';
        MASENO_UNIVERSITYSCaptionLbl: Label 'MASENO UNIVERSITY';
        CourseCaptionLbl: Label 'Course';
        DAILY_RECEIPTS_EXECUTIVE_SUMMARYCaptionLbl: Label 'DAILY RECEIPTS EXECUTIVE SUMMARY';
        Group_TotalsCaptionLbl: Label 'Group Totals';
        Grand_Totals_ForCaptionLbl: Label 'Grand Totals For';
}

