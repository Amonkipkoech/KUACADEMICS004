report 70100 "ACA-Clean Repeated Exam 2"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(ExamRes; 61548)
        {

            trigger OnAfterGetRecord()
            begin
                // // // // // // // // ExamRes.Exam:='EXAM';
                // // // // // // // // IF ExamRes.RENAME(ExamRes."Student No.",ExamRes.Programme,ExamRes.Stage,ExamRes.Unit,
                // // // // // // // //  ExamRes.Semester,'EXAM',ExamRes."Reg. Transaction ID",ExamRes."Entry No") THEN;
                ACAExamResults.RESET;
                ACAExamResults.SETRANGE(Unit, ExamRes.Unit);
                //ACAExamResults.SETRANGE(Programme,"ACA-Exam Results".Programme);
                ACAExamResults.SETRANGE("Student No.", ExamRes."Student No.");
                //ACAExamResults.SETRANGE(Exam,"ACA-Exam Results".Exam);
                ACAExamResults.SETRANGE(ExamType, ExamRes.ExamType);
                ACAExamResults.SETRANGE(Semester, ExamRes.Semester);
                ACAExamResults.SETRANGE(Score, ExamRes.Score);
                IF ACAExamResults.FIND('-') THEN BEGIN
                    IF ACAExamResults.COUNT > 1 THEN BEGIN
                        // ExamRes.DELETE;
                    END;
                END;
            end;

            trigger OnPostDataItem()
            begin
                //REPORT.RUN(70095);
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

