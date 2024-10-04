/// <summary>
/// Report Ecohim Buffer Process (ID 69269).
/// </summary>
report 69269 "Ecohim Buffer Process"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(EcoBuff; 69269)
        {

            trigger OnAfterGetRecord()
            begin
                ACACourseRegistration.RESET;
                ACACourseRegistration.SETRANGE(ACACourseRegistration."Student No.", EcoBuff."Student No.");
                IF ACACourseRegistration.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        IF ACACourseRegistration.RENAME(ACACourseRegistration."Reg. Transacton ID",
                          ACACourseRegistration."Student No.", 'BSC ECOHIM2', ACACourseRegistration.Semester,
                          ACACourseRegistration."Register for", ACACourseRegistration.Stage,
                          ACACourseRegistration."Student Type", ACACourseRegistration."Entry No.") THEN
                            ;
                    END;
                    UNTIL ACACourseRegistration.NEXT = 0;
                END;

                ACAStudentUnits.RESET;
                ACAStudentUnits.SETRANGE(ACAStudentUnits."Student No.", EcoBuff."Student No.");
                ACAStudentUnits.SETCURRENTKEY(ACAStudentUnits.Programme, ACAStudentUnits.Stage, ACAStudentUnits.Unit, ACAStudentUnits.Semester,
                      ACAStudentUnits."Reg. Transacton ID", ACAStudentUnits."Student No.", ACAStudentUnits.ENo, ACAStudentUnits."Academic Year");
                IF ACAStudentUnits.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        IF ACAStudentUnits.RENAME('BSC ECOHIM2', ACAStudentUnits.Stage, ACAStudentUnits.Unit, ACAStudentUnits.Semester,
                          ACAStudentUnits."Reg. Transacton ID", ACAStudentUnits."Student No.", ACAStudentUnits.ENo, ACAStudentUnits."Academic Year") THEN
                            ;
                    END;
                    UNTIL ACAStudentUnits.NEXT = 0;
                END;

                ACAExamResults.RESET;
                ACAExamResults.SETRANGE(ACAExamResults."Student No.", EcoBuff."Student No.");
                ACAExamResults.SETCURRENTKEY(ACAExamResults."Student No.", ACAExamResults.Programmes, ACAExamResults.Stage, ACAExamResults.Unit,
                    ACAExamResults.Semester, ACAExamResults.ExamType, ACAExamResults."Reg. Transaction ID", ACAExamResults."Entry No");
                IF ACAExamResults.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        IF ACAExamResults.RENAME(ACAExamResults."Student No.", 'BSC ECOHIM2', ACAExamResults.Stage, ACAExamResults.Unit,
                        ACAExamResults.Semester, ACAExamResults.ExamType, ACAExamResults."Reg. Transaction ID", ACAExamResults."Entry No") THEN
                            ;
                    END;
                    UNTIL ACAExamResults.NEXT = 0;
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
        ACACourseRegistration: Record 61532;
        ACAStudentUnits: Record 61549;
        ACAExamResults: Record 61548;
}

