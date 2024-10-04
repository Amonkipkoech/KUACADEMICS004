report 51421 "Student Units Registration"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Student Units Registration.rdl';

    dataset
    {
        dataitem("ACA-Programme"; 61511)
        {
            DataItemTableView = SORTING(Code);
            RequestFilterFields = Faculty, "Code", "Semester Filter";
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
            column(UnitNotReg; UnitNotReg)
            {
            }
            column(UnitReg; UnitReg)
            {
            }
            column(SemNotReg; SemNotReg)
            {
            }
            column(SemReg; SemReg)
            {
            }
            column(Programme_Description; Description)
            {
            }
            column(Programme_Code; Code)
            {
            }
            column(STUDENTS_COURSE_REGISTRATION_STATUSCaption; STUDENTS_COURSE_REGISTRATION_STATUSCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(CodeCaption; CodeCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(Semester_RegesteredCaption; Semester_RegesteredCaptionLbl)
            {
            }
            column(Semester_Not_Reg_Caption; Semester_Not_Reg_CaptionLbl)
            {
            }
            column(Course_RegisteredCaption; Course_RegisteredCaptionLbl)
            {
            }
            column(Course_Not_Reg_Caption; Course_Not_Reg_CaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SemReg := 0;
                UnitReg := 0;
                UnitNotReg := 0;
                SemNotReg := 0;


                // Check Semester Registration
                SemRegistered := FALSE;
                Customer.CALCFIELDS(Customer."Student Programme");
                Customer.SETRANGE(Customer."Student Programme", "ACA-Programme".Code);
                IF Customer.FIND('-') THEN BEGIN
                    REPEAT
                        CReg.RESET;
                        CReg.SETRANGE(CReg."Student No.", Customer."No.");
                        CReg.SETRANGE(CReg.Programmes, "ACA-Programme".Code);
                        CReg.SETFILTER(CReg.Semester, "ACA-Programme".GETFILTER("ACA-Programme"."Semester Filter"));
                        IF CReg.FIND('-') THEN BEGIN
                            SemRegistered := TRUE;
                            SemReg := SemReg + 1;
                        END ELSE BEGIN
                            SemRegistered := FALSE;
                            SemNotReg := SemNotReg + 1;
                        END;

                        // Check Course Registraion
                        IF SemRegistered THEN BEGIN
                            SUnits.RESET;
                            SUnits.SETRANGE(SUnits."Student No.", Customer."No.");
                            SUnits.SETRANGE(SUnits.Programme, "ACA-Programme".Code);
                            SUnits.SETRANGE(SUnits.Semester, "ACA-Programme".GETFILTER("Semester Filter"));
                            IF SUnits.COUNT >= 7 THEN
                                UnitReg := UnitReg + 1
                            ELSE
                                UnitNotReg := UnitNotReg + 1;
                        END;
                    UNTIL Customer.NEXT = 0;
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
        SemReg: Integer;
        UnitReg: Integer;
        UnitNotReg: Integer;
        SemNotReg: Integer;
        CReg: Record 61532;
        SUnits: Record 61549;
        SemRegistered: Boolean;
        Customer: Record 18;
        STUDENTS_COURSE_REGISTRATION_STATUSCaptionLbl: Label 'STUDENTS COURSE REGISTRATION STATUS';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        CodeCaptionLbl: Label 'Code';
        DescriptionCaptionLbl: Label 'Description';
        Semester_RegesteredCaptionLbl: Label 'Semester Regestered';
        Semester_Not_Reg_CaptionLbl: Label 'Semester Not Reg.';
        Course_RegisteredCaptionLbl: Label 'Course Registered';
        Course_Not_Reg_CaptionLbl: Label 'Course Not Reg.';
}

