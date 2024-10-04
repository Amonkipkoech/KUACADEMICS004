page 69163 "ACA-Hostel Block Rooms list"
{
    DeleteAllowed = false;
    Editable = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "ACA-Hostel Block Rooms";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Room Code"; Rec."Room Code")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("BedSpaces"; Rec."Bed Spaces")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Occupied Spaces"; Rec."Occupied Spaces")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Black List reason"; Rec."Black List reason")
                {
                    Caption = 'Reason for Reservation';
                    Editable = true;
                    ApplicationArea = All;
                }
                field("JAB Fees"; Rec."JAB Fees")
                {
                    ApplicationArea = All;
                }
                field("SSP Fees"; Rec."SSP Fees")
                {
                    ApplicationArea = All;
                }
                field("Special Programme"; Rec."Special Programme")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Bed Spaces")
            {
                Caption = 'Bed Spaces';
                Image = List;
                Promoted = true;
                RunObject = Page "ACA-Room Spaces list";
                RunPageLink = "Hostel Code" = FIELD("Hostel Code"),
                              "Room Code" = FIELD("Room Code");
                ApplicationArea = All;
            }
            action("Reserve Room")
            {
                Caption = 'Reserve Room';
                Image = AddAction;
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF Rec.Status <> Rec.Status::Vaccant THEN ERROR('The room is not vacant!');
                    IF CONFIRM('Reserve this room?', FALSE) = FALSE THEN ERROR('Cancelled by user!');
                    IF Rec."Black List reason" = '' THEN ERROR('please provide a reason for reservation');
                    Rec.Status := Rec.Status::"Black-Listed";
                    Rec.MODIFY;
                    roomspaces.RESET;
                    roomspaces.SETRANGE(roomspaces."Room Code", Rec."Room Code");
                    IF roomspaces.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            IF roomspaces.Status <> roomspaces.Status::Vaccant THEN ERROR('A Space that is not vaccant exists for this room!');
                            roomspaces.Status := roomspaces.Status::"Black-Listed";
                            roomspaces."Black List reason" := Rec."Black List reason";
                            roomspaces.MODIFY;
                        END;
                        UNTIL roomspaces.NEXT = 0;
                    END;
                    MESSAGE('The room has been successfully Reserved.');
                end;
            }
            action("Un-Blacklist")
            {
                Caption = 'Un-Blacklist';
                Image = "Action";
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Activate this room?', TRUE) = FALSE THEN ERROR('Cancelled by user!');
                    Rec.Status := Rec.Status::Vaccant;
                    Rec."Black List reason" := '';
                    Rec.MODIFY;
                    roomspaces.RESET;
                    roomspaces.SETRANGE(roomspaces."Room Code", Rec."Room Code");
                    IF roomspaces.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            roomspaces.Status := roomspaces.Status::Vaccant;
                            roomspaces."Black List reason" := '';
                            roomspaces.MODIFY;
                        END;
                        UNTIL roomspaces.NEXT = 0;
                    END;

                    MESSAGE('Room Activated Successfully');
                end;
            }
            action("Clear Space")
            {
                Caption = 'Clear Space';
                Enabled = true;
                Image = ClearLog;
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ACAHostelPermissions.PermissionMan(USERID, 2);

                    IF CONFIRM('Clear Space?', FALSE) = TRUE THEN BEGIN
                        clearFromRoom();
                    END;
                end;
            }
            action("Update Status")
            {
                Caption = 'Update Status';
                Image = "Action";
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ACAHostelBlockRooms.RESET;
                    //ACAHostelBlockRooms.COPYFILTERS(Rec);
                    IF ACAHostelBlockRooms.FIND('-') THEN BEGIN
                        REPEAT
                            ACAHostelBlockRooms.VALIDATE(Status);
                        UNTIL ACAHostelBlockRooms.NEXT = 0;
                    END;
                end;
            }
        }
    }

    var
        roomspaces: Record "ACA-Room Spaces";
        clearFromRoom1: Integer;
        ACAHostelBlockRooms: Record "ACA-Hostel Block Rooms";
        ACAHostelPermissions: Record "ACA-Hostel Permissions";

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
        // hostLedger.SETRANGE(hostLedger."Space No","Space Code");

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
        //spaces.SETRANGE(spaces."Space Code","Space Code");
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

