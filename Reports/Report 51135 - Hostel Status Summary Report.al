report 51135 "Hostel Status Summary Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Hostel Status Summary Report.rdl';

    dataset
    {
        dataitem("ACA-Hostel Card"; 61162)
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
            column(vspaces; "ACA-Hostel Card"."Vaccant Spaces")
            {
            }
            column(OccupiedSpaces; "ACA-Hostel Card"."Occupied Spaces")
            {
            }
            column(TotalSpaces; "ACA-Hostel Card"."Room Spaces")
            {
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
}

