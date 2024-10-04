report 60092 "ACA-Auto Register Units"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration"
)
        {
            RequestFilterFields = "Student No.", Semester;

            trigger OnAfterGetRecord()
            begin
                Customer.RESET;
                Customer.SETRANGE("No.", "ACA-Course Registration"."Student No.");
                IF Customer.FIND('-') THEN BEGIN
                    Customer.CALCFIELDS(Balance);
                    IF ((Customer.Balance < 0) OR (Customer.Balance = 0)) THEN BEGIN
                        ACAUnitsSubjects.RESET;
                        ACAUnitsSubjects.SETRANGE("Stage Code", "ACA-Course Registration".Stage);
                        ACAUnitsSubjects.SETRANGE("Programme Code", "ACA-Course Registration".Programmes);
                        ACAUnitsSubjects.SETRANGE("Old Unit", FALSE);
                        ACAUnitsSubjects.SETRANGE("Time Table", TRUE);
                        IF ACAUnitsSubjects.FIND('-') THEN BEGIN
                            REPEAT
                            BEGIN
                                ACAStudentUnits.RESET;
                                ACAStudentUnits.SETRANGE(Stage, "ACA-Course Registration".Stage);
                                ACAStudentUnits.SETRANGE(Semester, "ACA-Course Registration".Semester);
                                ACAStudentUnits.SETRANGE(Programme, "ACA-Course Registration".Programmes);
                                ACAStudentUnits.SETRANGE("Student No.", "ACA-Course Registration"."Student No.");
                                ACAStudentUnits.SETRANGE(Unit, ACAUnitsSubjects.Code);
                                IF NOT ACAStudentUnits.FIND('-') THEN BEGIN
                                    ACAStudentUnits.INIT;
                                    ACAStudentUnits.VALIDATE(Programme, "ACA-Course Registration".Programmes);
                                    ACAStudentUnits.VALIDATE(Stage, "ACA-Course Registration".Stage);
                                    ACAStudentUnits.VALIDATE(Unit, ACAUnitsSubjects.Code);
                                    ACAStudentUnits.VALIDATE(Semester, "ACA-Course Registration".Semester);
                                    ACAStudentUnits."Reg. Transacton ID" := "ACA-Course Registration"."Reg. Transacton ID";
                                    ACAStudentUnits.VALIDATE("Student No.", "ACA-Course Registration"."Student No.");
                                    ACAStudentUnits."Academic Year" := "ACA-Course Registration"."Academic Year";
                                    ACAStudentUnits.Taken := TRUE;
                                    ACAStudentUnits."Unit Stage" := ACAUnitsSubjects."Stage Code";
                                    ACAStudentUnits."No. Of Units" := ACAUnitsSubjects."Credit Hours";
                                    ACAStudentUnits.INSERT;
                                END ELSE BEGIN
                                    ACAStudentUnits.Taken := TRUE;
                                    ACAStudentUnits.MODIFY;
                                END;
                            END;
                            UNTIL ACAUnitsSubjects.NEXT = 0;
                        END;
                    END;
                END;
            end;

            trigger OnPreDataItem()
            begin
                IF "ACA-Course Registration".GETFILTER("ACA-Course Registration".Semester) = '' THEN ERROR('Specify Semester');
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
        ACAStudentUnits: Record 61549;
        ACAUnitsSubjects: Record 61517;
        Customer: Record 18;
}

