report 65810 "Rectify tt"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Integer; 2000000026)
        {
            DataItemTableView = WHERE(Number = FILTER(1));

            trigger OnAfterGetRecord()
            begin
                ACAStudentUnits.RESET;
                ACAStudentUnits.SETFILTER(programme, '<>%1', '');
                IF ACAStudentUnits.FIND('-') THEN BEGIN
                    REPEAT
                        ACACourseRegistration.RESET;
                        ACACourseRegistration.SETRANGE(Semester, ACAStudentUnits.Semester);
                        ACACourseRegistration.SETRANGE("Student No.", ACAStudentUnits."Student No.");
                        IF ACACourseRegistration.FIND('-') THEN BEGIN
                            //ACAStudentUnits."Academic Year":=ACACourseRegistration."Academic Year";
#pragma warning disable AL0606
#pragma warning restore AL0606
                            ACAStudentUnits.RENAME(ACAStudentUnits.Programme, ACAStudentUnits.Stage, ACAStudentUnits.Unit, ACAStudentUnits.Semester, ACAStudentUnits."Reg. Transacton ID", ACAStudentUnits."Student No.", ACAStudentUnits.ENo, ACACourseRegistration."Academic Year");
                        END;
                    UNTIL ACAStudentUnits.NEXT = 0;
                END;

                ACAExamResults.RESET;
                IF ACAExamResults.FIND('-') THEN BEGIN
                    REPEAT
                        ACACourseRegistration.RESET;
                        ACACourseRegistration.SETRANGE(Semester, ACAExamResults.Semester);
                        ACACourseRegistration.SETRANGE("Student No.", ACAExamResults."Student No.");
                        IF ACACourseRegistration.FIND('-') THEN BEGIN
                            ACAExamResults."Academic Year" := ACACourseRegistration."Academic Year";
                            ACAExamResults.MODIFY;
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
        ACAStudentUnits: Record 61549;
        ACAStudentUnits22: Record 65810;
        ACACourseRegistration: Record 61532;
        ACAExamResults: Record 61548;
}

