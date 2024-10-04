report 51052 "Validate Rooms"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("ACA-Hostel Block Rooms"; 61823)
        {
            DataItemTableView = WHERE(Status = FILTER(<> "Black-Listed"));

            trigger OnAfterGetRecord()
            begin
                CALCFIELDS("ACA-Hostel Block Rooms"."Occupied Spaces", "ACA-Hostel Block Rooms"."Bed Spaces");
                IF (("ACA-Hostel Block Rooms"."Occupied Spaces" > 0) AND ("ACA-Hostel Block Rooms"."Occupied Spaces" < "ACA-Hostel Block Rooms"."Bed Spaces")) THEN BEGIN
                    "ACA-Hostel Block Rooms".Status := "ACA-Hostel Block Rooms".Status::"Partially Occupied";
                    "ACA-Hostel Block Rooms".MODIFY;
                END ELSE
                    IF ("ACA-Hostel Block Rooms"."Occupied Spaces" = "ACA-Hostel Block Rooms"."Bed Spaces") THEN BEGIN
                        "ACA-Hostel Block Rooms".Status := "ACA-Hostel Block Rooms".Status::"Fully Occupied";
                        "ACA-Hostel Block Rooms".MODIFY;
                    END ELSE
                        IF ("ACA-Hostel Block Rooms"."Occupied Spaces" = 0) THEN BEGIN
                            "ACA-Hostel Block Rooms".Status := "ACA-Hostel Block Rooms".Status::Vaccant;
                            "ACA-Hostel Block Rooms".MODIFY;
                        END;
                /* CALCFIELDS("Room Spaces"."Current Student");
                 IF  "Room Spaces"."Current Student"='' THEN BEGIN
                  "Room Spaces".Status:="Room Spaces".Status::Vaccant;
                  "Room Spaces".MODIFY;
                 END;*/

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
        hostLed: Record 61163;
}

