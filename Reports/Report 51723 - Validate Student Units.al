report 81802 "Validate Student Units"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Validate Student Units.rdl';

    dataset
    {
        dataitem(DataItem2901; 61532)
        {
            DataItemTableView = SORTING("Reg. Transacton ID", "Student No.", Programmes, Semester, "Register for", Stage, Unit, "Student Type", "Entry No.")
                                WHERE("Exam Status" = FILTER(''));

            RequestFilterFields = Programmes, Semester, Stage;
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
            column(Course_Registration__Student_No__; "Student No.")
            {
            }
            column(Course_Registration_Semester; Semester)
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
            column(Course_Registration__Units_Taken_; "Units Taken")
            {
            }
            column(Course_RegistrationCaption; Course_RegistrationCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Course_Registration__Student_No__Caption; FIELDCAPTION("Student No."))
            {
            }
            column(Course_Registration_SemesterCaption; FIELDCAPTION(Semester))
            {
            }
            column(Course_Registration_StageCaption; FIELDCAPTION(Stage))
            {
            }
            column(Course_Registration_UnitCaption; FIELDCAPTION(Unit))
            {
            }
            column(Course_Registration__Settlement_Type_Caption; FIELDCAPTION("Settlement Type"))
            {
            }
            column(Course_Registration__Registration_Date_Caption; FIELDCAPTION("Registration Date"))
            {
            }
            column(Course_Registration__Units_Taken_Caption; FIELDCAPTION("Units Taken"))
            {
            }
            column(Course_Registration_Reg__Transacton_ID; "Reg. Transacton ID")
            {
            }
            column(Course_Registration_Programme; Programmes)
            {
            }
            column(Course_Registration_Register_for; "Register for")
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
        Course_RegistrationCaptionLbl: Label 'Course Registration';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

