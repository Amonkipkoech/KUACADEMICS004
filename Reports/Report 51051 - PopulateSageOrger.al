report 51051 PopulateSageOrger
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1; 61511)
        {
            dataitem("ACA-Programme Stages"; 61516)
            {
                DataItemLink = "Programme Code" = FIELD(Code);

                trigger OnAfterGetRecord()
                begin
                    seq := seq + 1;
                    "ACA-Programme Stages".Order := seq;
                    "ACA-Programme Stages".MODIFY;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(seq);
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
        seq: Integer;
}

