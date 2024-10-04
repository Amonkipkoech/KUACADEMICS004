report 51717 "Exam Card Labels4"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Exam Card Labels4.rdl';

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {
            RequestFilterFields = "Student No.", Programmes, Semester, Stage;
            column(col1StudNo; col1StudNo)
            {
            }
            column(col2StudNo; col2StudNo)
            {
            }
            column(col1Faculty; col1Faculty)
            {
            }
            column(col1Programme; col1Programme)
            {
            }
            column(col2Faculty; col2Faculty)
            {
            }
            column(col2Programme; col2Programme)
            {
            }
            column(col1Names; col1Names)
            {
            }
            column(col2Names; col2Names)
            {
            }
            column(col1Bal; col1Bal)
            {
            }
            column(col2Bal; col2Bal)
            {
            }
            column(i; i)
            {
            }
            column(j; j)
            {
            }
            column(i_Control1102760013; i)
            {
            }
            column(j_Control1102760014; j)
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
                j := j + 1;

                IF recCustomer.GET("ACA-Course Registration"."Student No.") THEN BEGIN
                    txtNames := UPPERCASE(recCustomer.Name);
                    recCustomer.CALCFIELDS(recCustomer."Balance (LCY)");
                    bal := recCustomer."Balance (LCY)";
                END;

                IF (bal > 0) AND (j < studCount) THEN BEGIN
                    CurrReport.SKIP;
                END
                ELSE BEGIN
                    i := i + 1;

                    col2StudNo := '';
                    col2Programme := '';
                    col2Faculty := '';
                    col2Names := '';
                    col2Bal := 0;

                    recProgramme.SETRANGE(recProgramme.Code, "ACA-Course Registration".Programmes);
                    IF recProgramme.FIND('-') THEN BEGIN
                        txtProgramme := recProgramme.Description;
                        FacultyCode := recProgramme.Faculty;
                    END;

                    recFaculty.SETRANGE(recFaculty.Code, FacultyCode);
                    IF recFaculty.FIND('-') THEN
                        txtFaculty := recFaculty.Description;

                    IF i MOD 2 = 1 THEN BEGIN
                        IF j = studCount THEN BEGIN
                            col1StudNo := "ACA-Course Registration"."Student No.";
                            col1Programme := txtProgramme;
                            col1Faculty := txtFaculty;
                            col1Names := txtNames;
                            col1Bal := bal;
                        END
                        ELSE BEGIN
                            col1StudNo := "ACA-Course Registration"."Student No.";
                            col1Programme := txtProgramme;
                            col1Faculty := txtFaculty;
                            col1Names := txtNames;
                            col1Bal := bal;
                            CurrReport.SKIP;
                        END;
                    END
                    ELSE BEGIN
                        IF bal <= 0 THEN BEGIN
                            col2StudNo := "ACA-Course Registration"."Student No.";
                            col2Programme := txtProgramme;
                            col2Faculty := txtFaculty;
                            col2Names := txtNames;
                            col2Bal := bal;
                        END;
                    END;
                END;
            end;

            trigger OnPreDataItem()
            begin
                studCount := "ACA-Course Registration".COUNT;
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
        col1StudNo: Code[15];
        col1Programme: Text[100];
        col1Faculty: Text[100];
        col1Names: Text[50];
        col1Bal: Decimal;
        col2StudNo: Code[15];
        col2Programme: Text[100];
        col2Faculty: Text[100];
        col2Names: Text[50];
        col2Bal: Decimal;
        i: Integer;
        j: Integer;
        studCount: Integer;
        recProgramme: Record 61511;
        txtProgramme: Text[100];
        recFaculty: Record 61587;
        txtFaculty: Text[100];
        FacultyCode: Code[10];
        txtNames: Text[50];
        recCustomer: Record 18;
        bal: Decimal;
}

