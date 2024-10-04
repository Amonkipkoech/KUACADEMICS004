report 51595 "Exam Card - Label"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Exam Card - Label.rdl';

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {
            DataItemTableView = SORTING("Reg. Transacton ID", "Student No.", Programmes, Semester, "Register for", Stage, Unit, "Student Type");
            RequestFilterFields = "Reg. Transacton ID", "Student No.", Programmes, Semester, "Register for", Stage, Unit, "Student Type";
            column(StudNo; StudNo)
            {
            }
            column(Names; Names)
            {
            }
            column(FacultyDesc; FacultyDesc)
            {
            }
            column(FacultyDesc2; FacultyDesc2)
            {
            }
            column(Names2; Names2)
            {
            }
            column(StudNo2; StudNo2)
            {
            }
            column(ProgCode; ProgCode)
            {
            }
            column(ProgCode2; ProgCode2)
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
            column(Course_Registration_Student_Type; "Student Type")
            {
            }
            column(Course_Registration_Entry_No_; "Entry No.")
            {
            }

            trigger OnAfterGetRecord()
            begin

                IF RegHide = FALSE THEN BEGIN
                    StudNo := '';
                    Names := '';
                    FacultyDesc := '';
                    ProgCode := '';

                    StudNo := "ACA-Course Registration"."Student No.";
                    ProgCode := "ACA-Course Registration".Programmes;
                    IF Cust.GET("ACA-Course Registration"."Student No.") THEN
                        Names := Cust.Name;
                    IF Prog.GET("ACA-Course Registration".Programmes) THEN BEGIN
                        IF FacultyR.GET(Prog.Faculty) THEN
                            FacultyDesc := FacultyR.Description;
                    END;

                END ELSE BEGIN
                    StudNo2 := '';
                    Names2 := '';
                    FacultyDesc2 := '';
                    ProgCode2 := '';

                    StudNo2 := "ACA-Course Registration"."Student No.";
                    ProgCode2 := "ACA-Course Registration".Programmes;
                    IF Cust.GET("ACA-Course Registration"."Student No.") THEN
                        Names2 := Cust.Name;
                    IF Prog.GET("ACA-Course Registration".Programmes) THEN BEGIN
                        IF FacultyR.GET(Prog.Faculty) THEN
                            FacultyDesc2 := FacultyR.Description;
                    END;


                END;


                IF RegHide = FALSE THEN
                    RegHide := TRUE
                ELSE
                    RegHide := FALSE;
            end;

            trigger OnPreDataItem()
            begin
                RegHide := FALSE;
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
        Units: Record 61517;
        St: Integer;
        StudNo: Code[20];
        Names: Text[100];
        FacultyDesc: Text[100];
        ProgCode: Code[20];
        StudNo2: Code[20];
        Names2: Text[100];
        FacultyDesc2: Text[100];
        ProgCode2: Code[20];
        FacultyR: Record 61587;
        RegHide: Boolean;
}

