report 51642 "Process Marks"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Reports/SSR/Process Marks.rdl';

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {
            RequestFilterFields = Programmes, Stage, Semester, "Student No.";
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(USERID; USERID)
            {
            }
#pragma warning disable AL0667
            column(CurrReport_PAGENO; CurrReport.PAGENO)
#pragma warning restore AL0667
            {
            }
            column(EXAMS_PROCESSSING_; 'EXAMS PROCESSSING')
            {
            }
            column(Course_Registration__Student_No__; "Student No.")
            {
            }
            column(Course_Registration_Programme; Programmes)
            {
            }
            column(Course_Registration_Stage; Stage)
            {
            }
            column(Course_Registration__Cumm_Score_; "Cumm Score")
            {
            }
            column(Course_Registration__Current_Cumm_Score_; "Current Cumm Score")
            {
            }
            column(Course_Registration__Current_Cumm_Grade_; "Current Cumm Grade")
            {
            }
            column(Course_Registration__Cumm_Grade_; "Cumm Grade")
            {
            }
            column(Course_Registration__Exam_Status_; "Exam Status")
            {
            }
            column(Course_Registration__Cumm_Status_; "Cumm Status")
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Course_Registration__Student_No__Caption; FIELDCAPTION("Student No."))
            {
            }
            column(Course_Registration_ProgrammeCaption; FIELDCAPTION(Programmes))
            {
            }
            column(Course_Registration_StageCaption; FIELDCAPTION(Stage))
            {
            }
            column(Course_Registration__Cumm_Score_Caption; FIELDCAPTION("Cumm Score"))
            {
            }
            column(Course_Registration__Current_Cumm_Score_Caption; FIELDCAPTION("Current Cumm Score"))
            {
            }
            column(Course_Registration__Current_Cumm_Grade_Caption; FIELDCAPTION("Current Cumm Grade"))
            {
            }
            column(Course_Registration__Cumm_Grade_Caption; FIELDCAPTION("Cumm Grade"))
            {
            }
            column(Course_Registration__Exam_Status_Caption; FIELDCAPTION("Exam Status"))
            {
            }
            column(Course_Registration__Cumm_Status_Caption; FIELDCAPTION("Cumm Status"))
            {
            }
            column(Course_Registration_Reg__Transacton_ID; "Reg. Transacton ID")
            {
            }
            column(Course_Registration_Semester; Semester)
            {
            }
            column(Course_Registration_Register_for; "Register for")
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
                               Semester = FIELD(Semester),
                               Programme = FIELD(Programmes);
                DataItemTableView = SORTING(Programme, Stage, Unit, Semester, "Reg. Transacton ID", "Student No.", ENo);
                RequestFilterFields = "Student No.", Programme, Stage;
                column(Student_Units__Final_Score_; "Final Score")
                {
                }
                column(Student_Units_Grade; Grade)
                {
                }
                column(Student_Units__Result_Status_; "Result Status")
                {
                }
                column(Student_Units_Unit; Unit)
                {
                }
                column(Student_Units_Description; Description)
                {
                }
                column(Student_Units_UnitCaption; FIELDCAPTION(Unit))
                {
                }
                column(Student_Units_DescriptionCaption; FIELDCAPTION(Description))
                {
                }
                column(Student_Units__Final_Score_Caption; FIELDCAPTION("Final Score"))
                {
                }
                column(Student_Units_GradeCaption; FIELDCAPTION(Grade))
                {
                }
                column(Student_Units__Result_Status_Caption; FIELDCAPTION("Result Status"))
                {
                }
                column(Student_Units_Programme; Programme)
                {
                }
                column(Student_Units_Stage; Stage)
                {
                }
                column(Student_Units_Semester; Semester)
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

                trigger OnAfterGetRecord()
                begin
                    ExamsProcessing.UpdateStudentUnits("ACA-Course Registration"."Student No.", "ACA-Course Registration".Programmes,
                    "ACA-Course Registration".Semester, "ACA-Course Registration".Stage);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //ExamsProcessing.UpdateCourseReg("ACA-Course Registration"."Student No.","ACA-Course Registration".Programme,"ACA-Course Registration".Stage,
                //"ACA-Course Registration".Semester);



                ExamsProcessing.UpdateCourseReg("ACA-Course Registration"."Student No.", "ACA-Course Registration".Programmes,
               "ACA-Course Registration".GETFILTER("Stage Filter"), "ACA-Course Registration".GETFILTER("Semester Filter"));

                ExamsProcessing.UpdateCummStatus("ACA-Course Registration"."Student No.", "ACA-Course Registration".Programmes,
               "ACA-Course Registration".GETFILTER("Stage Filter"), "ACA-Course Registration".GETFILTER("Semester Filter"));
                // Process
                //ExamsProcessing.UpdateCummStatus("ACA-Course Registration"."Student No.","ACA-Course Registration".Programme,
                ///"ACA-Course Registration".GETFILTER("Stage Filter"),"ACA-Course Registration".GETFILTER("Semester Filter"));
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
        ExamsProcessing: Codeunit 60110;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

