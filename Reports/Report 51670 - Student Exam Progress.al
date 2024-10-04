report 51670 "Student Exam Progress"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Student Exam Progress.rdl';

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {
            column(Course_Registration__Course_Registration___Student_No__; "ACA-Course Registration"."Student No.")
            {
            }
            column(Course_Registration_Reg__Transacton_ID; "Reg. Transacton ID")
            {
            }
            column(Course_Registration_Programme; Programmes)
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
            dataitem("ACA-Student Units"; "ACA-Student Units")
            {
                DataItemLink = "Student No." = FIELD("Student No."),
                               Programme = FIELD(Programmes),
                               Stage = FIELD(Stage),
                               Semester = FIELD(Semester);
                DataItemTableView = SORTING(Programme, Stage, Unit, Semester, "Reg. Transacton ID", "Student No.");
                RequestFilterFields = Programme, Stage;
                column(Student_Units_Programme; Programme)
                {
                }
                column(Student_Units_Stage; Stage)
                {
                }
                column(Student_Units_Programme_Control1000000017; Programme)
                {
                }
                column(Student_Units_Stage_Control1000000020; Stage)
                {
                }
                column(Student_Units_Semester; Semester)
                {
                }
                column(Student_Units_Unit; Unit)
                {
                }
                column(Student_Units_Programme_Control1000000017Caption; FIELDCAPTION(Programme))
                {
                }
                column(Student_Units_Stage_Control1000000020Caption; FIELDCAPTION(Stage))
                {
                }
                column(Student_Units_SemesterCaption; FIELDCAPTION(Semester))
                {
                }
                column(Student_Units_UnitCaption; FIELDCAPTION(Unit))
                {
                }
                column(Student_Units_ProgrammeCaption; FIELDCAPTION(Programme))
                {
                }
                column(Student_Units_StageCaption; FIELDCAPTION(Stage))
                {
                }
                column(Student_Units_Reg__Transacton_ID; "Reg. Transacton ID")
                {
                }
                column(Student_Units_Student_No_; "Student No.")
                {
                }
                column(Student_Units_ENo; ENo)
                {
                }

                trigger OnPreDataItem()
                begin
                    LastFieldNo := FIELDNO(Stage);
                end;
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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
}

