/// <summary>
/// Report Update Student Units (ID 51709).
/// </summary>
report 51709 "Update Student Units"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Update Student Units.rdl';

    dataset
    {
        dataitem(DataItem2901; 61532)
        {
            RequestFilterFields = "Student No.", Programmes, Stage, Semester;
            column(Course_Registration_Reg__Transacton_ID; "Reg. Transacton ID")
            {
            }
            column(Course_Registration_Student_No_; "Student No.")
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
            dataitem(DataItem2992; 61549)
            {
                DataItemLink = "Reg. Transacton ID" = FIELD("Reg. Transacton ID"),
                               "Student No." = FIELD("Student No.");
                RequestFilterFields = "Student No.", Semester, Programme, Stage;
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
                column(Student_Units__Reg__Transacton_ID_; "Reg. Transacton ID")
                {
                }
                column(Student_Units__Student_No__; "Student No.")
                {
                }
                column(Student_Units_Semester; Semester)
                {
                }
                column(Student_Units_Programme; Programme)
                {
                }
                column(Student_Units__Register_for_; "Register for")
                {
                }
                column(Student_Units_Stage; Stage)
                {
                }
                column(Student_Units_Unit; Unit)
                {
                }
                column(Student_UnitsCaption; Student_UnitsCaptionLbl)
                {
                }
                column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                {
                }
                column(Student_Units__Reg__Transacton_ID_Caption; FIELDCAPTION("Reg. Transacton ID"))
                {
                }
                column(Student_Units__Student_No__Caption; FIELDCAPTION("Student No."))
                {
                }
                column(Student_Units_SemesterCaption; FIELDCAPTION(Semester))
                {
                }
                column(Student_Units_ProgrammeCaption; FIELDCAPTION(Programme))
                {
                }
                column(Student_Units__Register_for_Caption; FIELDCAPTION("Register for"))
                {
                }
                column(Student_Units_StageCaption; FIELDCAPTION(Stage))
                {
                }
                column(Student_Units_UnitCaption; FIELDCAPTION(Unit))
                {
                }
                column(Student_Units_ENo; ENo)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CourseReg.RESET;
                    CourseReg.SETRANGE(CourseReg."Student No.", "Student No.");
                    CourseReg.SETRANGE(CourseReg."Reg. Transacton ID", "Reg. Transacton ID");
                    //CourseReg.setrange(CourseReg.Semester,)
                    IF CourseReg.FIND('-') THEN BEGIN
                        IF Semester <> CourseReg.Semester THEN BEGIN
                            Semester := CourseReg.Semester;
                            MODIFY;
                        END;
                    END;
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
        CourseReg: Record 61532;
        Student_UnitsCaptionLbl: Label 'Student Units';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

