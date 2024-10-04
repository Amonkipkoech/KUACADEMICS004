report 51469 TUITION
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/TUITION.rdl';

    dataset
    {
        dataitem(DataItem2901; 61532)
        {
            column(Course_Registration_Programme; Programmes)
            {
            }
            column(Course_Registration__Total_Paid_; "Total Paid")
            {
            }
            column(Course_Registration__Total_Paid_Caption; FIELDCAPTION("Total Paid"))
            {
            }
            column(Course_Registration_ProgrammeCaption; FIELDCAPTION(Programmes))
            {
            }
            column(Course_Registration_Reg__Transacton_ID; "Reg. Transacton ID")
            {
            }
            column(Course_Registration_Student_No_; "Student No.")
            {
            }
            column(Course_Registration_Semester; Semester)
            {
            }
            column(Course_Registration_Register_for; "Register for")
            {
            }
            column(Course_Registration_Stage; Stage)
            {
            }
            column(Course_Registration_Unit; Unit)
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
}

