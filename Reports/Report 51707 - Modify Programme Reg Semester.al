/// <summary>
/// Report Modify Programme Reg Semester (ID 51707).
/// </summary>
report 51707 "Modify Programme Reg Semester"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Modify Programme Reg Semester.rdl';

    dataset
    {
        dataitem(DataItem2901; 61532)
        {
            RequestFilterFields = "Student No.", Programmes, Stage, Semester, "Semester Filter";
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
            column(Course_Registration_ProgrammeCaption; FIELDCAPTION(Programmes))
            {
            }
            column(Course_Registration__Register_for_Caption; FIELDCAPTION("Register for"))
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
            column(Course_Registration_Reg__Transacton_ID; "Reg. Transacton ID")
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
                ENo := ENo + 1;


                /*"Course Registration".Semester:=Sem;
                "Course Registration".MODIFY;*/

                RENAME("Reg. Transacton ID", "Student No.",
                 Programmes, Sem, "Register for", Stage, Unit, "Student Type", "Entry No.");

                /**** UPDATE SETTLEMENT TYPE ****/

                /*"Course Registration"."Settlement Type":='DIRECTBONDO';
                "Course Registration".MODIFY;*/

            end;

            trigger OnPreDataItem()
            begin

                Sem := GETFILTER("Semester Filter");

                IF Sem = '' THEN
                    ERROR('You must specify the semmester')

                /**** UPDATE SETTLEMENT TYPE ****/

                /*IF "Course Registration".GETFILTER("Course Registration"."Student No.")='' THEN
                ERROR('You Must Specify a Student No. Filter!');*/

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
        ENo: Integer;
        Sem: Code[20];
        Course_RegistrationCaptionLbl: Label 'Course Registration';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

