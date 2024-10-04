report 51488 "Receipts Entries"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Receipts Entries.rdl';

    dataset
    {
        dataitem("ACA-Receipt"; "ACA-Receipt")
        {
            RequestFilterFields = "User ID", Date, "Settlement Type";
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
            column(StudNo; StudNo)
            {
            }
            column(Course; Course)
            {
            }
            column(Receipt_Amount_Control1000000007; Amount)
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
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(CourseCaption; CourseCaptionLbl)
            {
            }
            column(Grand_TotalsCaption; Grand_TotalsCaptionLbl)
            {
            }
            column(Receipt_User_ID; "User ID")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Cust.GET("ACA-Receipt"."Student No.") THEN
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
        MASENO_UNIVERSITYSCaptionLbl: Label 'MASENO UNIVERSITY OF TECHNOLOGY';
        No_CaptionLbl: Label 'No.';
        CourseCaptionLbl: Label 'Course';
        Grand_TotalsCaptionLbl: Label 'Grand Totals';
}

