page 69164 "ACA-Room Spaces list"
{
    PageType = List;
    SourceTable = "ACA-Room Spaces";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Room Code"; Rec."Room Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Space Code"; Rec."Space Code")
                {
                    Caption = 'Bed Spaces';
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Current Student"; Rec."Current Student")
                {
                    Caption = 'Student No.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Black List reason"; Rec."Black List reason")
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
            action(BlackList)
            {
                Caption = 'Black list';
                Image = AddAction;
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF Rec."Student No" <> '' THEN ERROR('The space is not Vaccant');
                    IF CONFIRM('Blacklist this Room-Space?', FALSE) = FALSE THEN ERROR('Cancelled by user!');
                    IF Rec."Black List reason" = '' THEN ERROR('please provide a Black list reason');
                    Rec.Status := Rec.Status::"Black-Listed";
                    Rec.MODIFY;
                    MESSAGE('The Room-Space has been successfully black-listed.');
                end;
            }
            action(UnblackList)
            {
                Caption = 'Un-Blacklist';
                Image = "Action";
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Un-blacklist this Room-Space', TRUE) = FALSE THEN ERROR('Cancelled by user!');
                    IF Rec."Student No" <> '' THEN
                        Rec.Status := Rec.Status::"Fully Occupied"
                    ELSE
                        Rec.Status := Rec.Status::Vaccant;
                    Rec."Black List reason" := '';
                    Rec.MODIFY;
                    MESSAGE('Room-Space un-blacklisted Successfully');
                end;
            }
            action(Vacate)
            {
                Caption = 'Vacate';
                Image = ClearLog;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ACAHostelPermissions.PermissionMan(USERID, 2);

                    IF CONFIRM('Clear Space?', FALSE) = TRUE THEN BEGIN
                        clearFromRoom();
                    END;
                end;
            }
        }
    }

    var
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

