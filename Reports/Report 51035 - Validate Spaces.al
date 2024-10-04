report 51035 "Validate Spaces"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(ARS; 61824)
        {

            trigger OnAfterGetRecord()
            begin
                blockRooms.RESET;
                blockRooms.SETRANGE(blockRooms."Hostel Code", ARS."Hostel Code");
                blockRooms.SETRANGE(blockRooms."Room Code", ARS."Room Code");
                IF NOT blockRooms.FIND('-') THEN BEGIN
                    ARS.DELETE;
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
        blockRooms: Record 61823;
}

