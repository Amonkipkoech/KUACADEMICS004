report 51321 "Hostel Vaccant Per Room/Block"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Hostel Vaccant Per RoomBlock.rdl';

    dataset
    {
        dataitem("ACA-Hostel Card"; "ACA-Hostel Card")
        {
            PrintOnlyIfDetail = true;
            column(address; info.Address)
            {
            }
            column(Phone; info."Phone No.")
            {
            }
            column(pics; info.Picture)
            {
            }
            column(No; "ACA-Hostel Card"."Asset No")
            {
            }
            column(Desc; "ACA-Hostel Card".Description)
            {
            }
            column(Vaccant; "ACA-Hostel Card".Vaccant)
            {
            }
            column(fullyOccupied; "ACA-Hostel Card"."Fully Occupied")
            {
            }
            column(partiallyOccupied; "ACA-Hostel Card"."Partially Occupied")
            {
            }
            column(Blacklisted; "ACA-Hostel Card".Blacklisted)
            {
            }
            column(totRooms; totRooms)
            {
            }
            column(HostCode; "ACA-Hostel Card"."Asset No")
            {
            }
            column(HostelName; "ACA-Hostel Card".Description)
            {
            }
            dataitem("ACA-Hostel Block Rooms"; "ACA-Hostel Block Rooms")
            {
                DataItemLink = "Hostel Code" = FIELD("Asset No");
                DataItemTableView = WHERE("Occupied Spaces" = FILTER(> 0));
                PrintOnlyIfDetail = false;
                column(rmCode; "ACA-Hostel Block Rooms"."Room Code")
                {
                }
                column(TotSpaces; "ACA-Hostel Block Rooms"."Total Spaces")
                {
                }
                column(OccupiedSpaces; "ACA-Hostel Block Rooms"."Occupied Spaces")
                {
                }
                column(VacantSpaces; "ACA-Hostel Block Rooms"."Vacant Spaces")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CALCFIELDS("ACA-Hostel Block Rooms"."Total Spaces", "ACA-Hostel Block Rooms"."Bed Spaces", "ACA-Hostel Block Rooms"."Occupied Spaces", "ACA-Hostel Block Rooms"."Vacant Spaces");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(totRooms);
                totRooms := "ACA-Hostel Card".Vaccant + "ACA-Hostel Card"."Fully Occupied" + "ACA-Hostel Card".Blacklisted + "ACA-Hostel Card"."Partially Occupied";
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
        info.RESET;
        IF info.FIND('-') THEN info.CALCFIELDS(Picture)
    end;

    var
        info: Record 79;
        totRooms: Integer;
        Customer: Record 18;
}

