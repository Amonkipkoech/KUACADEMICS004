report 51576 "Fee Analysis"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Fee Analysis.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.")
                                WHERE("Customer Type" = CONST(Student));
            RequestFilterFields = "No.", "Date Filter", "Debit Amount (LCY)";
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
            column(CourseR; CourseR)
            {
            }
            column(Customer__Payments_By_; "Payments By")
            {
            }
            column(Customer__Debit_Amount__LCY__; "Debit Amount (LCY)")
            {
            }
            column(Customer__Debit_Amount__LCY___Control1102760016; "Debit Amount (LCY)")
            {
            }
            column(Fee_AnalysisCaption; Fee_AnalysisCaptionLbl)
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
            column(CategoryCaption; CategoryCaptionLbl)
            {
            }
            column(Customer__Payments_By_Caption; FIELDCAPTION("Payments By"))
            {
            }
            column(Customer__Debit_Amount__LCY__Caption; FIELDCAPTION("Debit Amount (LCY)"))
            {
            }

            trigger OnAfterGetRecord()
            begin
                CourseReg.RESET;
                CourseReg.SETRANGE(CourseReg."Student No.", Customer."No.");
                IF CourseReg.FIND('-') THEN
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
        Fee_AnalysisCaptionLbl: Label 'Fee Analysis';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        CategoryCaptionLbl: Label 'Category';
}

