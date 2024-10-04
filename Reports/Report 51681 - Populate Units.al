/// <summary>
/// Report Populate Units (ID 51681).
/// </summary>
report 51681 "Populate Units"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Populate Units.rdl';

    dataset
    {
        dataitem(DataItem2901; 61532)
        {
            DataItemTableView = SORTING("Reg. Transacton ID", "Student No.", Programmes, Semester, "Register for", Stage, Unit, "Student Type");
            RequestFilterFields = Programmes, Stage;
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
                StageUnits.RESET;
                StageUnits.SETRANGE(StageUnits."Programme Code", Programmes);
                StageUnits.SETRANGE(StageUnits."Stage Code", Stage);
                IF StageUnits.FIND('-') THEN BEGIN
                    REPEAT
                        StudentUnits.INIT;
                        StudentUnits."Reg. Transacton ID" := "Reg. Transacton ID";
                        StudentUnits."Student No." := "Student No.";
                        StudentUnits.Programme := Programmes;
                        StudentUnits.Stage := Stage;
                        StudentUnits.Unit := StageUnits.Code;
                        StudentUnits.Semester := Semester;
                        StudentUnits."Register for" := "Register for";
                        StudentUnits."Unit Type" := StageUnits."Unit Type";
                        //IF Stages."Modules Registration" = FALSE THEN
                        StudentUnits.Taken := TRUE;
                        StudentUnits.INSERT;

                    UNTIL StageUnits.NEXT = 0
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
        StageUnits: Record 61517;
        StudentUnits: Record 61549;
        Course_RegistrationCaptionLbl: Label 'Course Registration';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

