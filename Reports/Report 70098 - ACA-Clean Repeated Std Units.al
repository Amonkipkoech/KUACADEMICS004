report 70098 "ACA-Clean Repeated Std Units"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/ACA-Clean Repeated Std Units.rdl';

    dataset
    {
        dataitem(StudUnits; "ACA-Student Units")
        {
            DataItemTableView = WHERE(Semester = FILTER(<> 'SEM 3 18/19' & <> 'SEM 2 19/20' & <> 'SEM 1 19/20'),
                                      Programme = FILTER('BSC ECOHIM'));

            trigger OnAfterGetRecord()
            begin
                StudUnits.CALCFIELDS("Total Score");
                ACAStudentUnits.RESET;
                ACAStudentUnits.SETRANGE(Unit, StudUnits.Unit);
                ACAStudentUnits.SETRANGE(Programme, StudUnits.Programme);
                ACAStudentUnits.SETRANGE("Student No.", StudUnits."Student No.");
                ACAStudentUnits.SETRANGE(Stage, StudUnits.Stage);
                ACAStudentUnits.SETRANGE("Total Score", StudUnits."Total Score");
                //ACAStudentUnits.SETRANGE(Exam,"ACA-Exam Results".Exam);
                //ACAStudentUnits.SETRANGE(ExamType,StudUnits.ExamType);
                //ACAStudentUnits.SETRANGE(Semester,StudUnits.Semester);
                IF ACAStudentUnits.FIND('-') THEN BEGIN
                    IF ACAStudentUnits.COUNT > 1 THEN BEGIN
                        StudUnits.DELETE;
                    END;
                END;

                // // // // // // // //
                // // // // // // // // ACASemesters.RESET;
                // // // // // // // // ACASemesters.SETRANGE(ACASemesters.Code,StudUnits.Semester);
                // // // // // // // // IF ACASemesters.FIND('-') THEN BEGIN
                // // // // // // // //   // StudUnits."Academic Year":=ACASemesters."Academic Year";
                // // // // // // // //    StudUnits."Unit Description":=ACAUnitsSubjects.Desription;
                // // // // // // // //  StudUnits.RENAME(StudUnits.Programme,StudUnits.Stage,StudUnits.Unit,StudUnits.Semester,
                // // // // // // // //  StudUnits."Reg. Transacton ID",StudUnits."Student No.",StudUnits.ENo,ACASemesters."Academic Year");
                // // // // // // // //  END;
                // //  ACAUnitsSubjects.RESET;
                // //  ACAUnitsSubjects.SETRANGE(ACAUnitsSubjects.Code,StudUnits.Unit);
                // //  ACAUnitsSubjects.SETRANGE(ACAUnitsSubjects."Programme Code",StudUnits.Programme);
                // //  IF ACAUnitsSubjects.FIND('-') THEN BEGIN
                // // // StudUnits.MODIFY;
                // //    END;
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

}

