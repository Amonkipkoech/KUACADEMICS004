/// <summary>
/// Report Validate Course Registration (ID 51693).
/// </summary>
report 51693 "Validate Course Registration"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Validate Course Registration.rdl';

    dataset
    {
        dataitem(DataItem2901; 61532)
        {
            RequestFilterFields = "Reg. Transacton ID", Semester;
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
            column(Course_Registration__Reg__Transacton_ID_; "Reg. Transacton ID")
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
            column(Course_Registration__Reg__Transacton_ID_Caption; FIELDCAPTION("Reg. Transacton ID"))
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

            trigger OnAfterGetRecord()
            begin

                studUnits.RESET;
                studUnits.SETRANGE(studUnits.Programme, Programmes);
                studUnits.SETRANGE(studUnits.Stage, Stage);
                //studUnits.SETRANGE(studUnits."Reg. Transacton ID","ACA-Course Registration"."Reg. Transacton ID");
                studUnits.SETRANGE(studUnits.Semester, Semester);
                studUnits.SETRANGE(studUnits."Student No.", "Student No.");
                IF studUnits.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        studUnits."Academic Year" := "Academic Year";
                        studUnits.MODIFY;
                    END;
                    UNTIL studUnits.NEXT = 0;
                END;
            end;

            trigger OnPostDataItem()
            begin
                //MESSAGE('done');
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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Course_RegistrationCaptionLbl: Label 'Course Registration';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        studUnits: Record 61549;
}

