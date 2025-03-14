/// <summary>
/// Report Update no of units (ID 51646).
/// </summary>
report 51646 "Update no of units"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Update no of units.rdl';

    dataset
    {
        dataitem(DataItem2992; 61549)
        {
            RequestFilterFields = Semester;
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
            column(Student_Units_Semester; Semester)
            {
            }
            column(Student_Units_ENo; ENo)
            {
            }

            trigger OnAfterGetRecord()
            begin
                UnitsR.RESET;
                UnitsR.SETRANGE(UnitsR.Programmes);
                UnitsR.SETRANGE("Reg. Transacton ID");
                UnitsR.SETRANGE(UnitsR.Semester);
                UnitsR.SETRANGE(UnitsR."Student No.");
                //UnitsR.SETRANGE(UnitsR.Stage,"ACA-Student Units".Stage);
                IF UnitsR.FIND('-') THEN BEGIN
                    "Academic Year" := UnitsR."Academic Year";
                    //"Student Units".MODIFY;

                END;
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
        UnitsR: Record 61532;
        Student_UnitsCaptionLbl: Label 'Student Units';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

