report 51154 "Validate Exam Marks2"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("ACA-Exam Results"; "ACA-Exam Results")
        {
            column(No; "ACA-Exam Results"."Student No.")
            {
            }
            column(Prog; "ACA-Exam Results".Programmes)
            {
            }
            column(Stage; "ACA-Exam Results".Stage)
            {
            }
            column(Unit; "ACA-Exam Results".Unit)
            {
            }
            column(Semester; "ACA-Exam Results".Semester)
            {
            }
            column(Trans; "ACA-Exam Results"."Reg. Transaction ID")
            {
            }
            column(Score; "ACA-Exam Results".Score)
            {
            }
            column(Contrib; "ACA-Exam Results".Contribution)
            {
            }
            column(Grade; "ACA-Exam Results".Grade)
            {
            }

            trigger OnAfterGetRecord()
            begin
                progress.UPDATE(1, "ACA-Exam Results"."Student No.");
                progress.UPDATE(2, "ACA-Exam Results".Unit);
                IF "ACA-Exam Results".Exam = '' THEN BEGIN
                    IF "ACA-Exam Results".ExamType <> '' THEN BEGIN
                        "ACA-Exam Results".Exam := "ACA-Exam Results".ExamType;
                    END;
                END;

                // //    IF "ACA-Exam Results".Exam='' THEN BEGIN
                // //      IF "ACA-Exam Results".ExamType<>'' THEN BEGIN
                // //        "ACA-Exam Results".Exam:="ACA-Exam Results".ExamType;
                // //        END;
                // //      END;
                VALIDATE("ACA-Exam Results".Score);
                //"ACA-Exam Results".MODIFY;
            end;

            trigger OnPreDataItem()
            begin
                //"ACA-Exam Results".SETRANGE("ACA-Exam Results"."User Name",UserID);
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
}

