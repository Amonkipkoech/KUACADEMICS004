report 78006 "ACA-Validate Supp. Marks"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Aca-Special Exams Results"; "Aca-Special Exams Results")
        {
            DataItemTableView = WHERE("Student No." = FILTER(12));

            trigger OnAfterGetRecord()
            begin
                progress.UPDATE(1, "Aca-Special Exams Results"."Student No.");
                progress.UPDATE(2, "Aca-Special Exams Results".Unit);
                "Aca-Special Exams Results".VALIDATE("Aca-Special Exams Results".Score);
                "Aca-Special Exams Results".MODIFY;
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
        progress.OPEN('Processing 5 of 7. \A minute please......\No.: #1########################################\Unit: #2########################################');
    end;

    var
        progress: Dialog;
}

