report 51575 "Student Debtors"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Student Debtors.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.")
                                WHERE("Customer Type" = CONST(Student),
                                      Blocked = CONST(" "));
            RequestFilterFields = "No.", "Date Filter", "Balance (LCY)";
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
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(Customer__Balance__LCY__; "Balance (LCY)")
            {
            }
            column(CourseR; CourseR)
            {
            }
            column(CourseReg_Semester; CourseReg.Semester)
            {
            }
            column(CourseReg_Programme; CourseReg.Programmes)
            {
            }
            column(Customer__Credit_Amount__LCY__; "Credit Amount (LCY)")
            {
            }
            column(Credit_Amount__LCY___0_35; "Credit Amount (LCY)" * 0.35)
            {
            }
            column(Customer__Balance__LCY___Control1102760018; "Balance (LCY)")
            {
            }
            column(Customer__Credit_Amount__LCY___Control1102755004; "Credit Amount (LCY)")
            {
            }
            column(Credit_Amount__LCY___0_35_Control1102755005; "Credit Amount (LCY)" * 0.35)
            {
            }
            column(Student_DebtorsCaption; Student_DebtorsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Customer__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Customer_NameCaption; FIELDCAPTION(Name))
            {
            }
            column(Customer__Balance__LCY__Caption; FIELDCAPTION("Balance (LCY)"))
            {
            }
            column(CategoryCaption; CategoryCaptionLbl)
            {
            }
            column(SemesterCaption; SemesterCaptionLbl)
            {
            }
            column(ProgrammeCaption; ProgrammeCaptionLbl)
            {
            }
            column(Customer__Credit_Amount__LCY__Caption; FIELDCAPTION("Credit Amount (LCY)"))
            {
            }
            column(V35_Caption; V35_CaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CourseReg.RESET;
                CourseReg.SETRANGE(CourseReg."Student No.", Customer."No.");
                CourseReg.SETRANGE(CourseReg.Posted, TRUE);
                IF CourseReg.FINDLAST() THEN
                    CourseR := CourseReg."Settlement Type";
                IF CourseReg."Settlement Type" = 'FULL PAYMENT' THEN
                    CourseR := 'JAB';
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
        CourseReg: Record 61532;
        CourseR: Code[20];
        Student_DebtorsCaptionLbl: Label 'Student Debtors';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        CategoryCaptionLbl: Label 'Category';
        SemesterCaptionLbl: Label 'Semester';
        ProgrammeCaptionLbl: Label 'Programme';
        V35_CaptionLbl: Label '35%';
}

