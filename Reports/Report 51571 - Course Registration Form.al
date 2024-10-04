report 51571 "Course Registration Form"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Course Registration Form.rdl';

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {
            DataItemTableView = SORTING("Reg. Transacton ID", "Student No.", Programmes, Semester, "Register for", Stage, Unit, "Student Type");
            RequestFilterFields = "Reg. Transacton ID", "Student No.", Programmes, Semester, "Register for", Stage, Unit, "Student Type";
            column(Course_Registration__Student_No__; "Student No.")
            {
            }
            column(Course_Registration__Registration_Date_; "Registration Date")
            {
            }
            column(Course_Registration__Student_Type_; "Student Type")
            {
            }
            column(Stages_Description; Stages.Description)
            {
            }
            column(Prog_Description; Prog.Description)
            {
            }
            column(Cust_Name; Cust.Name)
            {
            }
            column(Course_Registration__Student_No__Caption; FIELDCAPTION("Student No."))
            {
            }
            column(Course_Registration__Registration_Date_Caption; FIELDCAPTION("Registration Date"))
            {
            }
            column(Course_Registration__Student_Type_Caption; FIELDCAPTION("Student Type"))
            {
            }
            column(MASENO_UNIVERSITYS_COURSE_REGISTRATION_FORMCaption; MASENO_UNIVERSITYS_COURSE_REGISTRATION_FORMCaptionLbl)
            {
            }
            column(Units_Taken_Caption; Units_Taken_CaptionLbl)
            {
            }
            column(LevelCaption; LevelCaptionLbl)
            {
            }
            column(ProgrammeCaption; ProgrammeCaptionLbl)
            {
            }
            column(NamesCaption; NamesCaptionLbl)
            {
            }
            column(Course_Registration_Reg__Transacton_ID; "Reg. Transacton ID")
            {
            }
            column(Course_Registration_Programme; Programmes)
            {
            }
            column(Course_Registration_Semester; Semester)
            {
            }
            column(Course_Registration_Register_for; "Register for")
            {
            }
            column(Course_Registration_Stage; Stage)
            {
            }
            column(Course_Registration_Unit; Unit)
            {
            }
            column(Course_Registration_Entry_No_; "Entry No.")
            {
            }
            dataitem("ACA-Student Units"; "ACA-Student Units")
            {
                DataItemLink = "Reg. Transacton ID" = FIELD("Reg. Transacton ID"),
                               "Student No." = FIELD("Student No.");
                DataItemTableView = WHERE(Taken = CONST(true));
                column(Student_Units_Unit; Unit)
                {
                }
                column(UDesc; UDesc)
                {
                }
                column(Signature_Caption; Signature_CaptionLbl)
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
                    UDesc := '';
                    UnitR.RESET;
                    UnitR.SETRANGE(UnitR."Programme Code", "ACA-Student Units".Programme);
                    UnitR.SETRANGE(UnitR.Code, Unit);
                    IF UnitR.FIND('-') THEN
                        UDesc := UnitR.Desription;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF Cust.GET("ACA-Course Registration"."Student No.") THEN
                    RFound := TRUE;
                IF Prog.GET("ACA-Course Registration".Programmes) THEN
                    RFound := TRUE;
                IF Stages.GET("ACA-Course Registration".Programmes, "ACA-Course Registration".Stage) THEN
                    RFound := TRUE;
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
        Stages: Record 61516;
        RFound: Boolean;
        UDesc: Text[200];
        UnitR: Record 61517;
        MASENO_UNIVERSITYS_COURSE_REGISTRATION_FORMCaptionLbl: Label 'MASENO UNIVERSITY COURSE REGISTRATION FORM';
        Units_Taken_CaptionLbl: Label 'Units Taken:';
        LevelCaptionLbl: Label 'Level';
        ProgrammeCaptionLbl: Label 'Programme';
        NamesCaptionLbl: Label 'Names';
        Signature_CaptionLbl: Label 'Signature:';
}

