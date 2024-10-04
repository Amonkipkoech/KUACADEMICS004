/// <summary>
/// Report Update Student Units Reg ID (ID 51712).
/// </summary>
report 51712 "Update Student Units Reg ID"
{
    ProcessingOnly = true;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Update Student Units Reg ID.rdl';

    dataset
    {
        dataitem(StudUnits; 61549)
        {
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
                /*CourseReg.RESET;
                CourseReg.SETRANGE(CourseReg."Student No.","Student Units"."Student No.");
                CourseReg.SETRANGE(CourseReg.Stage,"Student Units".Stage);
                IF CourseReg.FIND('-') THEN BEGIN
                IF "Student Units"."Reg. Transacton ID" <> CourseReg."Reg. Transacton ID" THEN BEGIN
                "Student Units"."Reg. Transacton ID":=CourseReg."Reg. Transacton ID";
                "Student Units".MODIFY;
                END;
                END;*/
                /*
                "ACA-Student Units".LOCKTABLE;
                
                
                IF "ACA-Student Units".Programme<>'EDUMGT' THEN
                BEGIN
                "ACA-Student Units".Programme:='EDUMGT';
                "ACA-Student Units".MODIFY;
                END;*/
                //"ACA-Student Units".SETRANGE("ACA-Student Units".Programme,'p100');
                //"ACA-Student Units".SETRANGE("ACA-Student Units".Semester,'SEM1 18/19');
                //IF "ACA-Student Units".FINDFIRST THEN
                StudUnits.VALIDATE(Unit);
                StudUnits.MODIFY;

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
        CourseReg: Record 61532;
        Student_UnitsCaptionLbl: Label 'Student Units';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

