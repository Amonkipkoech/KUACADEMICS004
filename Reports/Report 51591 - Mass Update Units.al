report 51591 "Mass Update Units"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Mass Update Units.rdl';

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration"
)
        {
            DataItemTableView = SORTING("Reg. Transacton ID", "Student No.", Programmes, Semester, "Register for", Stage, Unit, "Student Type");
            RequestFilterFields = Programmes, Stage, Semester, "Student No.", "Programme Filter", "Stage Filter", "Unit Filter";
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
            column(Course_Registration__Reg__Transacton_ID_; "Reg. Transacton ID")
            {
            }
            column(Course_Registration_Programme; Programmes)
            {
            }
            column(Course_Registration_Stage; Stage)
            {
            }
            column(Course_Registration_Semester; Semester)
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
            column(Course_Registration__Reg__Transacton_ID_Caption; FIELDCAPTION("Reg. Transacton ID"))
            {
            }
            column(Course_Registration_ProgrammeCaption; FIELDCAPTION(Programmes))
            {
            }
            column(Course_Registration_StageCaption; FIELDCAPTION(Stage))
            {
            }
            column(Course_Registration_SemesterCaption; FIELDCAPTION(Semester))
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

            trigger OnAfterGetRecord()
            begin
                StudentUnits2.RESET;
                StudentUnits2.SETRANGE(StudentUnits2."Student No.", "ACA-Course Registration"."Student No.");
                StudentUnits2.SETRANGE(StudentUnits2."Reg. Transacton ID", "ACA-Course Registration"."Reg. Transacton ID");
                StudentUnits2.SETRANGE(StudentUnits2.Unit, Units.Code);
                IF StudentUnits2.FIND('-') = FALSE THEN BEGIN

                    StudentUnits.INIT;
                    StudentUnits."Reg. Transacton ID" := "Reg. Transacton ID";
                    StudentUnits."Student No." := "Student No.";
                    StudentUnits.Programme := GETFILTER("ACA-Course Registration"."Programme Filter");
                    StudentUnits.Stage := GETFILTER("ACA-Course Registration"."Stage Filter");
                    StudentUnits."Unit Stage" := GETFILTER("ACA-Course Registration"."Stage Filter");
                    StudentUnits.Unit := Units.Code;
                    StudentUnits.Semester := Semester;
                    StudentUnits."Register for" := "Register for";
                    StudentUnits."No. Of Units" := Units."No. Units";
                    StudentUnits."Unit Type" := Units."Unit Type"::Required;
                    StudentUnits.Taken := TRUE;
                    StudentUnits."System Created" := TRUE;
                    StudentUnits.INSERT;

                END;
            end;

            trigger OnPreDataItem()
            begin
                Units.RESET;
                Units.SETRANGE(Units."Programme Code", "ACA-Course Registration".GETFILTER("ACA-Course Registration"."Programme Filter"));
                Units.SETRANGE(Units."Stage Code", "ACA-Course Registration".GETFILTER("ACA-Course Registration"."Stage Filter"));
                Units.SETRANGE(Units.Code, "ACA-Course Registration".GETFILTER("ACA-Course Registration"."Unit Filter"));
                IF Units.FIND('-') = FALSE THEN
                    ERROR('Unit not found.');
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
        StudentUnits2: Record 61549;
        UnitCode: Code[20];
        Units: Record 61517;
        StageUnits: Integer;
        Course_RegistrationCaptionLbl: Label 'Course Registration';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

