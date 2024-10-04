report 51062 "Temp Hoste"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("ACA-Hostel Block Rooms"; 61823)
        {

            trigger OnAfterGetRecord()
            begin
                "ACA-Hostel Block Rooms".VALIDATE("ACA-Hostel Block Rooms"."Room Code");
                "ACA-Hostel Block Rooms".MODIFY;
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
}

