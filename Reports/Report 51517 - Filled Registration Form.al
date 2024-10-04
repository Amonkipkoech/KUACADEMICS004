report 51517 "Filled Registration Form"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Filled Registration Form.rdl';
    UseRequestPage = true;

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {
            DataItemTableView = SORTING("Reg. Transacton ID", "Student No.", Programmes, Semester, "Register for", Stage, Unit, "Student Type", "Entry No.");
            RequestFilterFields = "Student No.", "Reg. Transacton ID";
            column(Cust_Name; Cust.Name)
            {
            }
            column(Cust__No__; Cust."No.")
            {
            }
            column(Course_Registration__Course_Registration__Stage; "ACA-Course Registration".Stage)
            {
            }
            column(Course_Registration__Course_Registration__Semester; "ACA-Course Registration".Semester)
            {
            }
            column(Prog_Description; Prog.Description)
            {
            }
            column(School; School)
            {
            }
            column(UPPERCASE_COMPANYNAME_; UPPERCASE(COMPANYNAME))
            {
            }
            column(Dept; Dept)
            {
            }
            column(COURSE_REGISTRATION_FORMCaption; COURSE_REGISTRATION_FORMCaptionLbl)
            {
            }
            column(LEVEL_Caption; LEVEL_CaptionLbl)
            {
            }
            column(SEMESTER_Caption; SEMESTER_CaptionLbl)
            {
            }
            column(PROGRAMME_Caption; PROGRAMME_CaptionLbl)
            {
            }
            column(FACULTY_Caption; FACULTY_CaptionLbl)
            {
            }
            column(NAME_Caption; NAME_CaptionLbl)
            {
            }
            column(REG__NO_Caption; REG__NO_CaptionLbl)
            {
            }
            column(UNIT_CODECaption; UNIT_CODECaptionLbl)
            {
            }
            column(CFCaption; CFCaptionLbl)
            {
            }
            column(UNIT_DESCRIPTIONCaption; UNIT_DESCRIPTIONCaptionLbl)
            {
            }
            column(LECTURERCaption; LECTURERCaptionLbl)
            {
            }
            column(LECTURER_SIGNCaption; LECTURER_SIGNCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(DEPARTMENT_Caption; DEPARTMENT_CaptionLbl)
            {
            }
            column(Chairman_of_DepartmentCaption; Chairman_of_DepartmentCaptionLbl)
            {
            }
            column(SIGNED____________________________DATE_______________________Caption; SIGNED____________________________DATE_______________________CaptionLbl)
            {
            }
            column(OriginalCaption; OriginalCaptionLbl)
            {
            }
            column(Student_Signature____________________________________________Caption; Student_Signature____________________________________________CaptionLbl)
            {
            }
            column(The_Information_has_been_Certified_by_the_Undersign_Caption; The_Information_has_been_Certified_by_the_Undersign_CaptionLbl)
            {
            }
            column(Date_____________________________________________________________Caption; Date_____________________________________________________________CaptionLbl)
            {
            }
            column(Dean_of_FacultyCaption; Dean_of_FacultyCaptionLbl)
            {
            }
            column(SIGNED____________________________DATE_______________________Caption_Control1102755027; SIGNED____________________________DATE_______________________Caption_Control1102755027Lbl)
            {
            }
            column(DuplicateCaption; DuplicateCaptionLbl)
            {
            }
            column(TriplicateCaption; TriplicateCaptionLbl)
            {
            }
            column(QuadricateCaption; QuadricateCaptionLbl)
            {
            }
            column(PeatricateCaption; PeatricateCaptionLbl)
            {
            }
            column(AdmissionsCaption; AdmissionsCaptionLbl)
            {
            }
            column(FacultyCaption; FacultyCaptionLbl)
            {
            }
            column(DepartmentCaption; DepartmentCaptionLbl)
            {
            }
            column(StudentCaption; StudentCaptionLbl)
            {
            }
            column(Postgraduate_StudentCaption; Postgraduate_StudentCaptionLbl)
            {
            }
            column(DataItem1102755037; NsWR)
            {
            }
            column(NBCaption; NBCaptionLbl)
            {
            }
            column(Course_Registration_Reg__Transacton_ID; "Reg. Transacton ID")
            {
            }
            column(Course_Registration_Student_No_; "Student No.")
            {
            }
            column(Course_Registration_Programme; Programmes)
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
            dataitem("ACA-Student Units"; "ACA-Student Units")
            {
                DataItemLink = Semester = FIELD(Semester),
                               "Student No." = FIELD("Student No."),
                               "Reg. Transacton ID" = FIELD("Reg. Transacton ID");
                column(Student_Units_Unit; Unit)
                {
                }
                column(Student_Units__Student_Units___No__Of_Units_; "ACA-Student Units"."No. Of Units")
                {
                }
                column(UnitDesc; UnitDesc)
                {
                }
                column(LecName; LecName)
                {
                }
                column(Nm; Nm)
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
                column(Student_Units_Student_No_; "Student No.")
                {
                }
                column(Student_Units_ENo; ENo)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //  Unit.RESET;
                    // // Units.SETRANGE(Units."Programme Code","Student Units".Programmes);
                    // //  Units.SETRANGE(Units."Stage Code","Student Units".Stage);
                    //  Unit.SETRANGE(Units.Code,"ACA-Student Units".Unit);
                    //  IF Units.FIND('-') THEN
                    //  UnitDesc:=Units.Desription
                    //  ELSE
                    //  UnitDesc:='';
                    //  Nm:=Nm+1;
                    // "ACA-Student Units".CALCFIELDS(Lecturer);
                    // LecName:='';
                    // IF Emp.GET("ACA-Student Units".Lecturer) THEN
                    // LecName:=Emp."First Name";
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF Cust.GET("ACA-Course Registration"."Student No.") THEN
                    Cust.CALCFIELDS(Cust.Balance);

                IF Prog.GET("ACA-Course Registration".Programmes) THEN BEGIN
                    Dim.RESET;
                    Dim.SETRANGE(Dim."Dimension Code", 'FACULTY');
                    Dim.SETRANGE(Dim.Code, Prog."School Code");
                    IF Dim.FIND('-') THEN
                        School := Dim.Name;
                END;
                IF Prog.GET("ACA-Course Registration".Programmes) THEN BEGIN
                    Dim.RESET;
                    Dim.SETRANGE(Dim."Dimension Code", 'DEPARTMENT');
                    Dim.SETRANGE(Dim.Code, Prog."Department Code");
                    IF Dim.FIND('-') THEN
                        Dept := Dim.Name;
                END;

                AcademicY.RESET;
                AcademicY.SETRANGE(AcademicY.Current, TRUE);
                IF AcademicY.FIND('-') THEN
                    Nm := 0;
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
        Cust: Record 18;
        Prog: Record 61511;
        AcademicY: Record 61382;
        School: Code[100];
        Dim: Record 349;
        Unit: Record 61517;
        UnitDesc: Text[100];
        Nm: Integer;
        Dept: Code[100];
        Emp: Record 61188;
        LecName: Text[100];
        COURSE_REGISTRATION_FORMCaptionLbl: Label 'COURSE REGISTRATION FORM';
        LEVEL_CaptionLbl: Label 'LEVEL:';
        SEMESTER_CaptionLbl: Label 'SEMESTER:';
        PROGRAMME_CaptionLbl: Label 'PROGRAMME:';
        FACULTY_CaptionLbl: Label 'FACULTY:';
        NAME_CaptionLbl: Label 'NAME:';
        REG__NO_CaptionLbl: Label 'REG. NO.';
        UNIT_CODECaptionLbl: Label 'UNIT CODE';
        CFCaptionLbl: Label 'CF';
        UNIT_DESCRIPTIONCaptionLbl: Label 'UNIT DESCRIPTION';
        LECTURERCaptionLbl: Label 'LECTURER';
        LECTURER_SIGNCaptionLbl: Label 'LECTURER SIGN';
        No_CaptionLbl: Label 'No.';
        DEPARTMENT_CaptionLbl: Label 'DEPARTMENT:';
        Chairman_of_DepartmentCaptionLbl: Label 'Chairman of Department';
        SIGNED____________________________DATE_______________________CaptionLbl: Label 'SIGNED: __________________________DATE_______________________';
        OriginalCaptionLbl: Label 'Original';
        Student_Signature____________________________________________CaptionLbl: Label 'Student Signature:...........................................';
        The_Information_has_been_Certified_by_the_Undersign_CaptionLbl: Label 'The Information has been Certified by the Undersign.';
        Date_____________________________________________________________CaptionLbl: Label 'Date.............................................................';
        Dean_of_FacultyCaptionLbl: Label 'Dean of Faculty';
        SIGNED____________________________DATE_______________________Caption_Control1102755027Lbl: Label 'SIGNED: __________________________DATE_______________________';
        DuplicateCaptionLbl: Label 'Duplicate';
        TriplicateCaptionLbl: Label 'Triplicate';
        QuadricateCaptionLbl: Label 'Quadricate';
        PeatricateCaptionLbl: Label 'Peatricate';
        AdmissionsCaptionLbl: Label '-     Admissions';
        FacultyCaptionLbl: Label '-     Faculty';
        DepartmentCaptionLbl: Label '-     Department';
        StudentCaptionLbl: Label '-     Student';
        Postgraduate_StudentCaptionLbl: Label '-     Postgraduate Student';
        NsWR: Label 'No student will be allowed to sit for Exams unless they register for courses and submit this form to the relevant authorities';
        NBCaptionLbl: Label 'NB';
}

