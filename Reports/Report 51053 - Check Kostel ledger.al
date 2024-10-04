report 51053 "Check Kostel ledger"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("ACA-Students Hostel Rooms"; 61155)
        {

            trigger OnAfterGetRecord()
            begin
                IF "ACA-Students Hostel Rooms"."Switched to Space No" <> '' THEN BEGIN
                    "ACA-Students Hostel Rooms".Switched := TRUE;
                    "ACA-Students Hostel Rooms".MODIFY;
                END;
                IF "ACA-Students Hostel Rooms"."Transfer to Space No" <> '' THEN BEGIN
                    "ACA-Students Hostel Rooms".Transfered := TRUE;
                    "ACA-Students Hostel Rooms".MODIFY;
                END;
                IF "ACA-Students Hostel Rooms".Allocated THEN BEGIN
                    "ACA-Students Hostel Rooms".Status := "ACA-Students Hostel Rooms".Status::Allocated;
                    "ACA-Students Hostel Rooms"."Invoice Printed" := TRUE;
                    "ACA-Students Hostel Rooms".MODIFY;
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
        studRooms: Record 61823;
        roomledgers: Record 61163;
}

