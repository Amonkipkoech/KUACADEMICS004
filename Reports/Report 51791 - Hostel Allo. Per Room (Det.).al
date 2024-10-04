report 51791 "Hostel Allo. Per Room (Det.)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Hostel Allo. Per Room (Det.).rdl';

    dataset
    {
        dataitem(DataItem1; 61162)
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
            // column(totRooms; totRooms)
            // {
            // }
            dataitem(DataItem22; 61823)
            {
                DataItemLink = "Hostel Code" = FIELD("Asset No");
                DataItemTableView = WHERE("Occupied Spaces" = FILTER(> 0));
                PrintOnlyIfDetail = true;
                column(rmCode; "Room Code")
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
                    column(StartDate; creg."Registration Date")
                    {
                    }
                    column(enddate; acadYShcedule."End Date")
                    {
                    }
                    column(AllocatedBy; RoomSpaces."User ID")
                    {
                    }
                    column(AllocDate; roomall."Allocation Date")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF Customer.GET(RoomSpaces."Student No") THEN BEGIN
                            Customer.CALCFIELDS(Customer."Hostel No.", Customer."Room Code", Customer."Space Booked");
                        END;

                        creg.RESET;
                        creg.SETRANGE(creg."Student No.", Customer."No.");
                        creg.SETRANGE(creg.Semester, Customer.Semester);
                        IF creg.FIND('-') THEN BEGIN
                            sems.RESET;
                            sems.SETRANGE(sems."Current Semester", TRUE);
                            IF sems.FIND('-') THEN BEGIN
                                acadYShcedule.RESET;
                                acadYShcedule.SETRANGE(acadYShcedule.Semester, sems.Code);
                                IF acadYShcedule.FIND('-') THEN BEGIN

                                END;
                            END;
                        END;
                        roomall.RESET;
                        roomall.SETRANGE(roomall.Student, RoomSpaces."Student No");
                        roomall.SETRANGE(roomall."Space No", RoomSpaces."Space No");
                        roomall.SETRANGE(roomall."Room No", RoomSpaces."Room No");
                        roomall.SETRANGE(roomall."Hostel No", RoomSpaces."Hostel No");
                        roomall.SETRANGE(roomall.Semester, Customer.Semester);
                        IF roomall.FIND('-') THEN BEGIN
                        END;

                        CALCFIELDS(RoomSpaces."User ID");
                    end;
                }
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
        Customer: Record 18;
        creg: Record 61532;
        sems: Record 61692;
        acadYShcedule: Record 61654;
        roomall: Record 61155;
}

