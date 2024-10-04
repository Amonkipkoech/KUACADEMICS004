report 51136 "Hostel Allocations Per Block"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Hostel Allocations Per Block.rdl';

    dataset
    {
        dataitem("ACA-Hostel Card"; 61162)
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
            dataitem(RoomSpaces; "ACA-Hostel Ledger")
            {
                DataItemLink = "Hostel No" = FIELD("Asset No");
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
                column(seq; seq)
                {
                }
                column(RegDate; ACAStudentsHostelRooms."Allocation Date")
                {
                }
                column(ReservID; ACAStudentsHostelRooms."Allocated By")
                {
                }
                column(Semester; ACAStudentsHostelRooms.Semester)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF Customer.GET(RoomSpaces."Student No") THEN BEGIN
                        Customer.CALCFIELDS(Customer."Hostel No.", Customer."Room Code", Customer."Space Booked");
                    END;
                    seq := seq + 1;

                    ACAStudentsHostelRooms.RESET;
                    ACAStudentsHostelRooms.SETRANGE(ACAStudentsHostelRooms.Student, RoomSpaces."Student No");
                    ACAStudentsHostelRooms.SETRANGE(ACAStudentsHostelRooms."Hostel No", RoomSpaces."Hostel No");
                    ACAStudentsHostelRooms.SETRANGE(ACAStudentsHostelRooms."Space No", RoomSpaces."Space No");
                    ACAStudentsHostelRooms.SETRANGE(ACAStudentsHostelRooms."Room No", RoomSpaces."Room No");
                    ACAStudentsHostelRooms.SETRANGE(ACAStudentsHostelRooms.Semester, RoomSpaces.Semester);
                    IF ACAStudentsHostelRooms.FIND('-') THEN BEGIN
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(totRooms);
                totRooms := "ACA-Hostel Card".Vaccant + "ACA-Hostel Card"."Fully Occupied" + "ACA-Hostel Card".Blacklisted + "ACA-Hostel Card"."Partially Occupied";


                CLEAR(seq);
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
        IF info.FIND('-') THEN info.CALCFIELDS(Picture);
        CLEAR(seq);
    end;

    var
        info: Record 79;
        totRooms: Integer;
        seq: Integer;
        Customer: Record 18;
        ACAStudentsHostelRooms: Record 61155;
}

