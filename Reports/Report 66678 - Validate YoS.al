report 66678 "Validate YoS"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(CREG; 61532)
        {
            DataItemTableView = WHERE("Year Of Study" = FILTER(0));

            trigger OnAfterGetRecord()
            begin
                CLEAR(YearOfStudy);
                IF EVALUATE(YearOfStudy, COPYSTR(CREG.Stage, 2, 1)) THEN BEGIN

                END;

                IF YearOfStudy <> 0 THEN BEGIN
                    CREG."Year Of Study" := YearOfStudy;
                    CREG.MODIFY;
                END ELSE BEGIN
                    CREG.DELETE;
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
        YearOfStudy: Integer;
}

