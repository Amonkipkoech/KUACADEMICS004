report 61833 "Hostel Status Summary Graph"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Hostel Status Summary Graph.rdl';

    dataset
    {
        dataitem(DataItem1; 61162)
        {
            column(address; info.Address)
            {
            }
            column(Phone; info."Phone No.")
            {
            }
            column(pics; info.Picture)
            {
            }
            column(No; "Asset No")
            {
            }
            column(Desc; Description)
            {
            }
            column(Vaccant; Vaccant)
            {
            }
            column(fullyOccupied; "Fully Occupied")
            {
            }
            column(partiallyOccupied; "Partially Occupied")
            {
            }
            column(Blacklisted; Blacklisted)
            {
            }
            column(totRooms; totRooms)
            {
            }
            column(vspaces; "Vaccant Spaces")
            {
            }
            column(OccupiedSpaces; "Occupied Spaces")
            {
            }
            column(TotalSpaces; "Room Spaces")
            {
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(totRooms);
                totRooms := Vaccant + "Fully Occupied" + Blacklisted + "Partially Occupied";
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
        IF info.FIND('-') THEN info.CALCFIELDS(info.Picture)
    end;

    var
        info: Record 79;
        totRooms: Integer;
}

