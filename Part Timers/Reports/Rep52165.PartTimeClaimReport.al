report 52165 "PartTime Claim Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Part Timers/Reports/SSR/PartTimersClaim.rdl';

    dataset
    {
        dataitem(Header; "Parttime Claim Header")
        {
            CalcFields = "Payment Amount";
            column(No_Header; "No.")
            {
            }
            column(Date_Header; "Date")
            {
            }
            column(GlobalDimension1Code_Header; "Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_Header; "Global Dimension 2 Code")
            {
            }
            column(AccountNo_Header; "Account No.")
            {
            }
            column(payee_Header; payee)
            {
            }
            column(PaymentAmount_Header; "Payment Amount")
            {
            }
            column(PayingBankAccount_Header; "Paying Bank Account")
            {
            }
            column(BankName_Header; "Bank Name")
            {
            }
            column(PayMode_Header; "Pay Mode")
            {
            }
            column(ChequeNo_Header; "Cheque No.")
            {
            }
            column(PaymentReleaseDate_Header; "Payment Release Date")
            {
            }
            column(Purpose_Header; Purpose)
            {
            }
            column(Status_Header; Status)
            {
            }
            column(Semester_Header; Semester)
            {
            }
            column(AcademicYear_Header; "Academic Year")
            {
            }
            column(SemesterStartDate_Header; "Semester Start Date")
            {
            }
            column(SemesterEndDate_Header; "Semester End Date")
            {
            }
            column(ExpenseAC_Header; "Expense AC")
            {
            }
            column(ExpenseAcName_Header; "Expense Ac Name")
            {
            }
            column(PayeeCode_Header; "Payee Code")
            {
            }
            column(PayeeAC_Header; "Payee AC")
            {
            }
            column(PayeeRates_Header; "Payee Rates")
            {
            }
            column(PayeeAmount_Header; "Payee Amount")
            {
            }
            column(BankAccountNo_Header; "Bank Account No.")
            {
            }
            column(BranchBank_Header; "Branch Bank")
            {
            }
            column(BranchBankName_Header; "Branch Bank Name")
            {
            }
            column(MainBank_Header; "Main Bank")
            {
            }
            column(MainBankName_Header; "Main Bank Name")
            {
            }
            column(Bank_Branch; "Main Bank" + "Branch Bank")
            {
            }
            column(compLogo; info.Picture)
            {
            }
            column(CompName; info.Name)
            {

            }
            column(CompAddress; info.Address)
            {

            }
            column(CompMail; info."E-Mail")
            {

            }
            column(CompPhone; info."Phone No.")
            {

            }
            column(CompUrl; info."Home Page")
            {

            }
            column(sno; sno)
            {

            }
            dataitem(Lines; "Parttime Claim Lines")
            {
                DataItemLink = "Document No." = field("No.");

                column(Unit_Lines; Unit)
                {
                }
                column(UnitDescription_Lines; "Unit Description")
                {
                }
                column(Programme_Lines; Programme)
                {
                }
                column(ProgrammeDescription_Lines; "Programme Description")
                {
                }
                column(HoursDone_Lines; "Hours Done")
                {
                }
                column(HourlyRate_Lines; "Hourly Rate")
                {
                }
                column(Stage_Lines; Stage)
                {
                }
                column(Amount_Lines; Amount)
                {
                }
                column(InvigillationDone_Lines; "Invigillation Done")
                {
                }
                column(InvigillationHours_Lines; "Invigillation Hours")
                {
                }
            }

            trigger OnPreDataItem()
            begin
                info.get;
                info.CalcFields(Picture);
                sno := 0;
            end;

            trigger OnAfterGetRecord()
            begin
                sno := sno + 1;

            end;
        }

    }

    var
        info: Record "Company Information";
        sno: Integer;

}