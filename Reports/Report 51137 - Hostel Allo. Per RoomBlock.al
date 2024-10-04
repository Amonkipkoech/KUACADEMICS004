report 51137 "Hostel Allo. Per Room/Block"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Hostel Allo. Per RoomBlock.rdl';

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
            dataitem("ACA-Hostel Block Rooms"; "ACA-Hostel Block Rooms")
            {
                DataItemLink = "Hostel Code" = FIELD("Asset No");
                DataItemTableView = WHERE("Occupied Spaces" = FILTER(> 0));
                PrintOnlyIfDetail = true;
                column(rmCode; "ACA-Hostel Block Rooms"."Room Code")
                {
                }
                dataitem(RoomSpaces; 61163)
                {
                    DataItemLink = "Hostel No" = FIELD("Hostel Code"),
                                   "Room No" = FIELD("Room Code");
                    DataItemTableView = WHERE("Student No" = FILTER(<> ''));
                    column(stdNo; Customer."No.")
                    {
                    }
                    column(stdName; Customer.Name)
                    {
                    }
                    column(stdaddress; Customer.Address + ', ' + Customer.City)
                    {
                    }
                    column(stdphone; Customer."Phone No.")
                    {
                    }
                    column(host; Customer."Hostel No.")
                    {
                    }
                    column(rm; Customer."Room Code")
                    {
                    }
                    column(spc; Customer."Space Booked")
                    {
                    }
                    column(years; Customer."Academic Year")
                    {
                    }
                    column(sems; Customer.Semester)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF Customer.GET(RoomSpaces."Student No") THEN BEGIN
                            Customer.CALCFIELDS(Customer."Hostel No.", Customer."Room Code", Customer."Space Booked");
                        END;
                    end;
                }
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

