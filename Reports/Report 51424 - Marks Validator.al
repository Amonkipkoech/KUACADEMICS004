report 51424 "Marks Validator"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Marks Validator.rdl';

    dataset
    {
        dataitem("ACA-Student Units"; 61549)
        {
            DataItemTableView = SORTING(Programme, Stage, Unit, Semester, "Reg. Transacton ID", "Student No.");
            RequestFilterFields = "Total Score";
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
            column(Student_Units__Student_No__; "Student No.")
            {
            }
            column(Student_Units__Total_Marks_; "Total Marks")
            {
            }
            column(Student_Units__Total_Score_; "Total Score")
            {
            }
            column(Student_UnitsCaption; Student_UnitsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Student_Units__Student_No__Caption; FIELDCAPTION("Student No."))
            {
            }
            column(Student_Units__Total_Marks_Caption; FIELDCAPTION("Total Marks"))
            {
            }
            column(Student_Units__Total_Score_Caption; FIELDCAPTION("Total Score"))
            {
            }
            column(Student_Units_Programme; Programme)
            {
            }
            column(Student_Units_Stage; Stage)
            {
            }
            column(Student_Units_Unit; Unit)
            {
            }
            column(Student_Units_Semester; Semester)
            {
            }
            column(Student_Units_Reg__Transacton_ID; "Reg. Transacton ID")
            {
            }
            column(Student_Units_ENo; ENo)
            {
            }

            trigger OnAfterGetRecord()
            begin
                // "Student Units".calcfields("Student Units"."Total Score");
                "ACA-Student Units"."Total Marks" := "ACA-Student Units"."Total Score";
                "ACA-Student Units".MODIFY;
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
        Student_UnitsCaptionLbl: Label 'Student Units';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

