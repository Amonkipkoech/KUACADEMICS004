report 51149 "Validate Exam Marks"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(examRes; 61548)
        {
            DataItemTableView = WHERE(Status = FILTER(Deceased | Registration | Current));

            trigger OnAfterGetRecord()
            begin
                progress.UPDATE(1, examRes."Student No.");
                progress.UPDATE(2, examRes.Unit);
                IF examRes.Exam = '' THEN BEGIN
                    IF examRes.ExamType <> '' THEN BEGIN
                        examRes.Exam := examRes.ExamType;
                    END;
                END;
                examRes.CALCFIELDS("Number of Occurances");
                IF examRes."Number of Occurances" > 1 THEN BEGIN
                    ACAExamResults.RESET;
                    ACAExamResults.SETRANGE("Student No.", ACAExamResults."Student No.");
                    ACAExamResults.SETRANGE(ExamType, ACAExamResults.ExamType);
                    ACAExamResults.SETRANGE(Unit, ACAExamResults.Unit);
                    IF ACAExamResults.FIND('+') THEN ACAExamResults.DELETE;
                END;

                ACAStudentUnits.RESET;
                ACAStudentUnits.SETRANGE("Student No.", examRes."Student No.");
                ACAStudentUnits.SETRANGE(Unit, examRes.Unit);
                IF ACAStudentUnits.FIND('-') THEN
                    IF ACAStudentUnits.COUNT > 1 THEN BEGIN

                        ACAStudentUnits2.RESET;
                        ACAStudentUnits2.SETRANGE("Student No.", examRes."Student No.");
                        ACAStudentUnits2.SETRANGE(Unit, examRes.Unit);
                        ACAStudentUnits2.SETFILTER("Supp. Grade", '%1|%2|%3', 'X', '', ' ');
                        IF ACAStudentUnits2.FIND('-') THEN BEGIN
                            ACAStudentUnits2.DELETE;
                        END;
                    END;

                ACAStudentUnits.RESET;
                ACAStudentUnits.SETRANGE("Student No.", examRes."Student No.");
                ACAStudentUnits.SETRANGE(Unit, examRes.Unit);
                IF ACAStudentUnits.FIND('-') THEN
                    IF ACAStudentUnits.COUNT > 1 THEN BEGIN
                        ACAStudentUnits2.RESET;
                        ACAStudentUnits2.SETRANGE("Student No.", examRes."Student No.");
                        ACAStudentUnits2.SETRANGE(Unit, examRes.Unit);
                        ACAStudentUnits2.SETFILTER("Supp. Failed", '%1', TRUE);
                        IF ACAStudentUnits2.FIND('-') THEN BEGIN
                            ACAStudentUnits2.DELETE;
                        END;
                    END;

                VALIDATE(examRes.Score);
                examRes.MODIFY;
            end;

            trigger OnPreDataItem()
            begin
                //examRes.SETRANGE(examRes."User Name",UserID);
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

    trigger OnPostReport()
    begin
        progress.CLOSE;
    end;

    trigger OnPreReport()
    begin
        progress.OPEN('Processing 3 of 7.\A minute please......\No.: #1########################################\Unit.: #2########################################');
    end;

    var
        progress: Dialog;
        ACAStudentUnits: Record 61549;
        ACAStudentUnits2: Record 61549;
        ACAExamResults: Record 61548;
}

