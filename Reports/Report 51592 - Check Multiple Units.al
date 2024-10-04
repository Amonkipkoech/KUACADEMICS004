report 51592 "Check Multiple Units"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Check Multiple Units.rdl';

    dataset
    {
        dataitem("ACA-Student Units"; "ACA-Student Units")
        {
            RequestFilterFields = "System Created";
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
                StudentUnits.RESET;
                StudentUnits.SETRANGE(StudentUnits."Student No.", "ACA-Student Units"."Student No.");
                StudentUnits.SETRANGE(StudentUnits.Unit, "ACA-Student Units".Unit);
                StudentUnits.SETRANGE(StudentUnits.Multiple, TRUE);
                //IF StudentUnits.COUNT > 1 THEN BEGIN
                //StudentUnits.MODIFYALL(StudentUnits.Multiple,TRUE);
                IF StudentUnits.FIND('-') THEN BEGIN

                    REPEAT
                        IF StudentUnits."Entry No." <> "ACA-Student Units"."Entry No." THEN BEGIN
                            "ACA-Student Units".DELETE;
                        END;

                    UNTIL StudentUnits.NEXT = 0;
                END;
            end;

            trigger OnPreDataItem()
            begin
                //StudentUnits.RESET;
                //StudentUnits.MODIFYALL(StudentUnits.Multiple,FALSE);
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
        StudentUnits: Record 61549;
        Student_UnitsCaptionLbl: Label 'Student Units';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

