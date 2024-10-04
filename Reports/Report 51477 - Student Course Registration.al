report 51477 "Student Course Registration"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Student Course Registration.rdl';

    dataset
    {
        dataitem(Customer; 18)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Customer Type", "Semester Filter", "Date Registered", Status;
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
            column(Students_Course_RegistrationCaption; Students_Course_RegistrationCaptionLbl)
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
            column(Course_Registration__Settlement_Type_Caption; "ACA-Course Registration".FIELDCAPTION("Settlement Type"))
            {
            }
            column(Course_Registration_SemesterCaption; "ACA-Course Registration".FIELDCAPTION(Semester))
            {
            }
            column(Course_Registration_UnitCaption; "ACA-Course Registration".FIELDCAPTION(Unit))
            {
            }
            column(Course_Registration_StageCaption; "ACA-Course Registration".FIELDCAPTION(Stage))
            {
            }
            column(Course_Registration__Register_for_Caption; "ACA-Course Registration".FIELDCAPTION("Register for"))
            {
            }
            column(Course_Registration_ProgrammeCaption; "ACA-Course Registration".FIELDCAPTION(Programmes))
            {
            }
            column(Course_Registration__Registration_Date_Caption; "ACA-Course Registration".FIELDCAPTION("Registration Date"))
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(Total_PaidCaption; Total_PaidCaptionLbl)
            {
            }
            column(Total_BilledCaption; Total_BilledCaptionLbl)
            {
            }
            column(Customer_Semester_Filter; "Semester Filter")
            {
            }
            dataitem("ACA-Course Registration"; "ACA-Course Registration")
            {
                DataItemLink = "Student No." = FIELD("No."),
                               Semester = FIELD("Semester Filter");
                DataItemTableView = WHERE(Reversed = CONST(false));
                column(Course_Registration_Semester; Semester)
                {
                }
                column(Course_Registration_Programme; Programmes)
                {
                }
                column(Course_Registration__Register_for_; "Register for")
                {
                }
                column(Course_Registration_Stage; Stage)
                {
                }
                column(Course_Registration_Unit; Unit)
                {
                }
                column(Course_Registration__Settlement_Type_; "Settlement Type")
                {
                }
                column(Course_Registration__Registration_Date_; "Registration Date")
                {
                }
                column(Total_Billed___Total_Paid_; "Total Billed" - "Total Paid")
                {
                }
                column(Course_Registration__Total_Paid_; "Total Paid")
                {
                }
                column(Course_Registration__Total_Billed_; "Total Billed")
                {
                }
                column(Course_Registration_Reg__Transacton_ID; "Reg. Transacton ID")
                {
                }
                column(Course_Registration_Student_No_; "Student No.")
                {
                }
                column(Course_Registration_Student_Type; "Student Type")
                {
                }
                column(Course_Registration_Entry_No_; "Entry No.")
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
        Students_Course_RegistrationCaptionLbl: Label 'Students Course Registration';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        BalanceCaptionLbl: Label 'Balance';
        Total_PaidCaptionLbl: Label 'Total Paid';
        Total_BilledCaptionLbl: Label 'Total Billed';
}

