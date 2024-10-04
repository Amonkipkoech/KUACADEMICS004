report 51344 "Resit Registration by Course"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Resit Registration by Course.rdl';

    dataset
    {
        dataitem("ACA-Student Units"; 61549)
        {
            DataItemTableView = WHERE("Repeat Unit" = filter(true));
            RequestFilterFields = "Student No.", Programme, Stage, Semester;
            column(Student_Units_Unit; Unit)
            {
            }
            column(txtUnitDesc; txtUnitDesc)
            {
            }
            column(Student_Units__Student_No__; "Student No.")
            {
            }
            column(Resit_Registration_by_CourseCaption; Resit_Registration_by_CourseCaptionLbl)
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
            column(Student_Units_ENo; ENo)
            {
            }

            trigger OnAfterGetRecord()
            begin
                recUnitSubj.SETFILTER(recUnitSubj.Code, "ACA-Student Units".Unit);

                IF recUnitSubj.FIND('-') THEN
                    txtUnitDesc := recUnitSubj.Desription;
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
        txtUnitDesc: Text[250];
        recUnitSubj: Record 61517;
        Resit_Registration_by_CourseCaptionLbl: Label 'Resit Registration by Course';
}

