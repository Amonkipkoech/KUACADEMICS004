report 70072 "Sync. Student Units"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Std Units Buffer"; 70073)
        {

            trigger OnAfterGetRecord()
            begin
                ACAStudentUnits.RESET;
                ACAStudentUnits.SETRANGE(ACAStudentUnits.Programme, "Std Units Buffer".Prog);
                ACAStudentUnits.SETRANGE(ACAStudentUnits.Stage, "Std Units Buffer".Stage);
                ACAStudentUnits.SETRANGE(ACAStudentUnits.Unit, "Std Units Buffer".Unit);
                ACAStudentUnits.SETRANGE(ACAStudentUnits.Semester, "Std Units Buffer".Semester);
                ACAStudentUnits.SETRANGE(ACAStudentUnits."Reg. Transacton ID", "Std Units Buffer"."Reg. Trans. Id");
                ACAStudentUnits.SETRANGE(ACAStudentUnits."Student No.", "Std Units Buffer"."Stud. No");
                ACAStudentUnits.SETRANGE(ACAStudentUnits.ENo, "Std Units Buffer".ENO);
                ACAStudentUnits.SETRANGE(ACAStudentUnits."Academic Year", "Std Units Buffer"."Academic Year");
                IF ACAStudentUnits.FIND('-') THEN BEGIN
                    ACAStudentUnits.Remarks := "Std Units Buffer".Remarks;
                    ACAStudentUnits.Status := "Std Units Buffer".Status;
                    ACAStudentUnits.Description := "Std Units Buffer".Description;
                    ACAStudentUnits.MODIFY;
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
}

