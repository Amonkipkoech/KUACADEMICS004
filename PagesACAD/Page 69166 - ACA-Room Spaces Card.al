page 69166 "ACA-Room Spaces Card"
{
    CardPageID = "ACA-Room Spaces list";
    PageType = Card;
    RefreshOnActivate = false;
    SourceTable = "ACA-Room Spaces";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Hostel Code"; Rec."Hostel Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Room Code"; Rec."Room Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Space Code"; Rec."Space Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Clear Space")
            {
                Caption = 'Clear Space';
                Image = ClearLog;
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Clear Space?', FALSE) = TRUE THEN BEGIN
                        clearFromRoom();
                    END;
                end;
            }
        }
    }

    var
        HstRm: Record "ACA-Hostel Block Rooms";
        RmSpcs: Record "ACA-Room Spaces";

    procedure clearFromRoom()
    var
        Rooms: Record "ACA-Hostel Block Rooms";
        spaces: Record "ACA-Room Spaces";
        hostLedger: Record "ACA-Hostel Ledger";
        HostRooms: Record "ACA-Students Hostel Rooms";
    begin
        hostLedger.RESET;
        hostLedger.SETRANGE(hostLedger."Hostel No", Rec."Hostel Code");
        hostLedger.SETRANGE(hostLedger."Room No", Rec."Room Code");
        hostLedger.SETRANGE(hostLedger."Space No", Rec."Space Code");

        IF hostLedger.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                HostRooms.RESET;
                HostRooms.SETRANGE(HostRooms.Student, hostLedger."Student No");
                HostRooms.SETRANGE(HostRooms."Academic Year", hostLedger."Academic Year");
                HostRooms.SETRANGE(HostRooms.Semester, hostLedger.Semester);
                HostRooms.SETRANGE(HostRooms."Hostel No", hostLedger."Hostel No");
                HostRooms.SETRANGE(HostRooms."Room No", hostLedger."Room No");
                HostRooms.SETRANGE(HostRooms."Space No", hostLedger."Space No");
                IF HostRooms.FIND('-') THEN BEGIN
                    HostRooms.Cleared := TRUE;
                    HostRooms."Clearance Date" := TODAY;
                    HostRooms.MODIFY;
                END;
                hostLedger.DELETE;
            END;
            UNTIL hostLedger.NEXT = 0;
        END;


        spaces.RESET;
        spaces.SETRANGE(spaces."Hostel Code", Rec."Hostel Code");
        spaces.SETRANGE(spaces."Room Code", Rec."Room Code");
        spaces.SETRANGE(spaces."Space Code", Rec."Space Code");
        IF spaces.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                spaces.Status := spaces.Status::Vaccant;
                spaces."Student No" := '';
                spaces."Receipt No" := '';
                spaces."Black List reason" := '';
                spaces.MODIFY;
            END;
            UNTIL spaces.NEXT = 0;
        END;

        Rooms.RESET;
        Rooms.SETRANGE(Rooms."Hostel Code", Rec."Hostel Code");
        Rooms.SETRANGE(Rooms."Room Code", Rec."Room Code");
        IF Rooms.FIND('-') THEN BEGIN
            REPEAT
                Rooms.VALIDATE(Rooms.Status);
            UNTIL Rooms.NEXT = 0;
        END;
    end;
}

