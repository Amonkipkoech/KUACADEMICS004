report 70095 "ACA-Clean Repeated Exam Result"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("ACA-Exam Results"; "ACA-Exam Results")
        {
            DataItemTableView = WHERE(Programmes = FILTER('BSC ECOHIM'));

            trigger OnAfterGetRecord()
            begin
                ACAExamResults.RESET;
                ACAExamResults.SETRANGE(Unit, "ACA-Exam Results".Unit);
                ACAExamResults.SETRANGE(Programmes, "ACA-Exam Results".Programmes);
                ACAExamResults.SETRANGE("Student No.", "ACA-Exam Results"."Student No.");
                //ACAExamResults.SETRANGE(Exam,"ACA-Exam Results".Exam);
                ACAExamResults.SETRANGE(ExamType, "ACA-Exam Results".ExamType);
                //ACAExamResults.SETRANGE(Semester,"ACA-Exam Results".Semester);
                ACAExamResults.SETRANGE(Score, "ACA-Exam Results".Score);
                IF ACAExamResults.FIND('-') THEN BEGIN
                    IF ACAExamResults.COUNT > 1 THEN BEGIN
                        //"ACA-Exam Results".DELETE;
                    END;
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
        ACAExamResults: Record 61548;
}

