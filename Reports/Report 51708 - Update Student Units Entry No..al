/// <summary>
/// Report Update Student Units Entry No. (ID 51708).
/// </summary>
report 51708 "Update Student Units Entry No."
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Update Student Units Entry No..rdl';

    dataset
    {
        dataitem(DataItem2992; 61549)
        {
            RequestFilterFields = Programme, Stage;
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
            column(Students_UnitsCaption; Students_UnitsCaptionLbl)
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
                //ENo:=ENo+1;

                //"Entry No.":=ENo;
                Taken := TRUE;
                MODIFY;
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
        Students_UnitsCaptionLbl: Label 'Students Units';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

