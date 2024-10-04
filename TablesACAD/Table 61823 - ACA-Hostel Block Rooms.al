table 61823 "ACA-Hostel Block Rooms"
{

    fields
    {
        field(1; "Hostel Code"; Code[20])
        {
            TableRelation = "ACA-Hostel Card"."Asset No";
        }
        field(2; "Room Code"; Code[20])
        {

            trigger OnValidate()
            begin
                hostel.RESET;
                hostel.SETRANGE(hostel."Asset No", "Hostel Code");
                IF hostel.FIND('-') THEN BEGIN
                    // "JAB Fees" := hostel."JAB Fees";
                    // "SSP Fees" := hostel."SSP Fees";
                    // "Special Programme" := hostel."Special Programme";
                END;
            end;
        }
        field(3; "Bed Spaces"; Integer)
        {
            CalcFormula = Count("ACA-Room Spaces" WHERE("Hostel Code" = FIELD("Hostel Code"),
                                                         "Room Code" = FIELD("Room Code"),
                                                         Status = FILTER(<> 'Black-Listed')));
            FieldClass = FlowField;
        }
        field(4; Status; Option)
        {
            OptionCaption = 'Vaccant,Partially Occupied,Fully Occupied,Black-Listed,Partially Booked,Fully Booked,Out of Order,Over-Allocated';
            OptionMembers = Vaccant,"Partially Occupied","Fully Occupied","Black-Listed","Partially Booked","Fully Booked","Out of Order","Over-Allocated";

            trigger OnValidate()
            begin
                CALCFIELDS("Bed Spaces", "Occupied Spaces");
                IF "Occupied Spaces" = 0 THEN BEGIN
                    Status := Status::Vaccant;
                    MODIFY;
                END ELSE
                    IF "Occupied Spaces" < "Bed Spaces" THEN BEGIN
                        Status := Status::"Partially Occupied";
                        MODIFY;
                    END ELSE
                        IF "Occupied Spaces" = "Bed Spaces" THEN BEGIN
                            Status := Status::"Fully Occupied";
                            MODIFY;
                        END ELSE BEGIN
                            Status := Status::"Over-Allocated";
                            MODIFY;
                        END;
                // ELSE IF "Occupied Spaces">"Bed Spaces" THEN  ERROR('You can not allocate more than the available spaces!');
            end;
        }
        field(5; "Room Cost"; Decimal)
        {
        }
        field(14; "Reservation Remarks"; Text[100])
        {
        }
        field(15; "Reservation UserID"; Code[20])
        {
        }
        field(16; "Reservation Date"; Date)
        {
        }
        field(17; "Black List reason"; Text[30])
        {
        }
        field(18; "Occupied Spaces"; Integer)
        {
            CalcFormula = Count("ACA-Hostel Ledger" WHERE("Hostel No" = FIELD("Hostel Code"),
                                                           "Room No" = FIELD("Room Code"),
                                                           Status = FILTER('Fully Occupied')));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                /* CALCFIELDS("Bed Spaces","Occupied Spaces");
                  IF "Occupied Spaces"=0 THEN BEGIN
                  Status:=Status::Vaccant;
                  MODIFY;
                 END ELSE  IF "Occupied Spaces"<"Bed Spaces" THEN BEGIN
                  Status:=Status::"Partially Occupied";
                  MODIFY;
                  END ELSE IF "Occupied Spaces"="Bed Spaces" THEN BEGIN
                  Status:=Status::"Fully Occupied";
                  MODIFY;
                 END ELSE IF "Occupied Spaces">"Bed Spaces" THEN  ERROR('You can not allocate more than the available spaces!'); */

            end;
        }
        field(50005; "JAB Fees"; Decimal)
        {
        }
        field(50006; "SSP Fees"; Decimal)
        {
        }
        field(50007; "Special Programme"; Decimal)
        {
        }
        field(50008; "Total Spaces"; Integer)
        {
            CalcFormula = Count("ACA-Room Spaces" WHERE("Hostel Code" = FIELD("Hostel Code"),
                                                         "Room Code" = FIELD("Room Code"),
                                                         Status = FILTER(<> "Black-Listed")));
            FieldClass = FlowField;
        }
        field(50010; "Vacant Spaces"; Integer)
        {
            CalcFormula = Count("ACA-Room Spaces" WHERE("Hostel Code" = FIELD("Hostel Code"),
                                                         "Room Code" = FIELD("Room Code"),
                                                         Status = FILTER(Vaccant)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Hostel Code", "Room Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        ACAHostelPermissions.PermissionMan(USERID, 8);
        rmsLedger.RESET;
        //rmsLedger.SETRANGE(rmsLedger."Hostel No","Asset No");
        rmsLedger.SETRANGE(rmsLedger."Room No", "Room Code");
        IF rmsLedger.FIND('-') THEN BEGIN
            ERROR('Allocations exists for this Room. Clear the room/spaces first.');
        END;

        roomspaces.RESET;
        roomspaces.SETRANGE(roomspaces."Room Code", "Room Code");
        roomspaces.SETFILTER(roomspaces.Status, '<>%1', roomspaces.Status::Vaccant);
        IF roomspaces.FIND('-') THEN BEGIN
            ERROR('There are some occupied spaces in the room');
        END;

        roomspaces.RESET;
        roomspaces.SETRANGE(roomspaces."Room Code", "Room Code");
        IF roomspaces.FIND('-') THEN BEGIN
            roomspaces.DELETEALL;
        END;// error('There are some occupied spaces in the room');
    end;

    trigger OnInsert()
    begin
        ACAHostelPermissions.PermissionMan(USERID, 8);
    end;

    trigger OnModify()
    begin
        //ACAHostelPermissions.PermissionMan(USERID,8);
    end;

    var
        hostel: Record 61162;
        roomspaces: Record 61824;
        rmsLedger: Record 61163;
        ACAHostelPermissions: Record 70007;
}

