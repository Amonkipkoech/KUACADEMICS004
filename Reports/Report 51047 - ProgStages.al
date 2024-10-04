report 51047 ProgStages
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(AP; 61511)
        {

            trigger OnAfterGetRecord()
            begin
                buff.RESET;
                IF buff.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        Progstages.INIT;
                        Progstages."Programme Code" := AP.Code;
                        Progstages.Code := buff.Code;
                        Progstages.Description := buff.Desc;
                        Progstages.INSERT();
                    END;
                    UNTIL buff.NEXT = 0;
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

    trigger OnPreReport()
    begin
        Progstages.RESET;
        IF Progstages.FIND('-') THEN BEGIN
            Progstages.DELETEALL;
        END;
    end;

    var
        buff: Record 61009;
        Progstages: Record 61516;
}

