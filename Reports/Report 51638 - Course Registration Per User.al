report 51638 "Course Registration Per User"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Course Registration Per User.rdl';

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {
            DataItemTableView = SORTING("Reg. Transacton ID", "Student No.", Programmes, Semester, "Register for", Stage, Unit, "Student Type");
            RequestFilterFields = Faculty, Programmes, Stage, "User ID", "Registration Date", "Units Taken";
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
            column(Course_Registration__Reg__Transacton_ID_; "Reg. Transacton ID")
            {
            }
            column(Course_Registration_Programme; Programmes)
            {
            }
            column(Course_Registration_Semester; Semester)
            {
            }
            column(Course_Registration__Register_for_; "Register for")
            {
            }
            column(Course_Registration_Stage; Stage)
            {
            }
            column(Course_Registration__Settlement_Type_; "Settlement Type")
            {
            }
            column(Course_Registration__Registration_Date_; "Registration Date")
            {
            }
            column(Course_Registration__User_ID_; "User ID")
            {
            }
            column(Course_Registration__Units_Taken_; "Units Taken")
            {
            }
            column(RecNo; RecNo)
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
            column(Course_Registration__Reg__Transacton_ID_Caption; FIELDCAPTION("Reg. Transacton ID"))
            {
            }
            column(Course_Registration_ProgrammeCaption; FIELDCAPTION(Programmes))
            {
            }
            column(Course_Registration_SemesterCaption; FIELDCAPTION(Semester))
            {
            }
            column(Course_Registration__Register_for_Caption; FIELDCAPTION("Register for"))
            {
            }
            column(Course_Registration_StageCaption; FIELDCAPTION(Stage))
            {
            }
            column(Course_Registration__Settlement_Type_Caption; FIELDCAPTION("Settlement Type"))
            {
            }
            column(Course_Registration__Registration_Date_Caption; FIELDCAPTION("Registration Date"))
            {
            }
            column(Course_Registration__User_ID_Caption; FIELDCAPTION("User ID"))
            {
            }
            column(Course_Registration__Units_Taken_Caption; FIELDCAPTION("Units Taken"))
            {
            }
            column(No_Caption; No_CaptionLbl)
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

            trigger OnAfterGetRecord()
            begin
                RecNo := RecNo + 1;
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
        RecNo: Integer;
        Course_RegistrationCaptionLbl: Label 'Course Registration';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        No_CaptionLbl: Label 'No.';
}

