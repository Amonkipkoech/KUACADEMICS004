page 68242 "ACA-Hostel List"
{
    CardPageID = "ACA-Hostel Card";
    Editable = false;
    PageType = List;
    SourceTable = 61162;

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("Asset No"; Rec."Asset No")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Hostel Type"; Rec."Hostel Type")
                {
                    ApplicationArea = All;
                }
                field("Provider Code"; Rec."Provider Code")
                {
                    ApplicationArea = All;
                }
                field("Rooms Generated"; Rec."Rooms Generated")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Room Spaces"; Rec."Room Spaces")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Space Per Room"; Rec."Space Per Room")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Cost Per Occupant"; Rec."Cost Per Occupant")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                }
                field("Cost per Room"; Rec."Cost per Room")
                {
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
                field("View Online"; Rec."View Online")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(RoomsGen)
            {
                Caption = 'Generate Rooms';
                Image = AddAction;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //  "Rooms Maker"();
                end;
            }
            action(Rooms)
            {
                Caption = 'Rooms';
                Image = DistributionGroup;
                Promoted = true;
                RunObject = Page "ACA-Hostel Block Rooms list";
                RunPageLink = "Hostel Code" = FIELD("Asset No");
                ApplicationArea = All;
            }
            action(ClearRooms)
            {
                Caption = 'Clear All Rooms';
                Enabled = true;
                Image = ClearLog;
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                begin

                    ACAHostelPermissions.PermissionMan(USERID, 2);
                    IF CONFIRM('Clear All Rooms in this Block?', FALSE) = FALSE THEN EXIT;
                    clearFromRoom();
                end;
            }
            action(Rec_Incidents)
            {
                Caption = 'Incidents Recording';
                Image = Capacity;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "ACA-Hostel Incidents";
                RunPageLink = "Hostel Block No." = FIELD("Asset No");
                ApplicationArea = All;
            }
            action(CopyAlloc)
            {
                Caption = 'Copy Allocations';
                Image = Import;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page 70080;
                ApplicationArea = All;
            }
            action("Hostel Permissions")
            {
                Caption = 'Hostel Permissions';
                Image = Permission;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page 70007;
                ApplicationArea = All;
            }
        }
    }

    var
        FA: Record "Fixed Asset";
        Rooms: Record "ACA-Hostel Block Rooms";
        Existing: Integer;
        Counter: Integer;
        "Last Room": Code[10];
        "Space Name": Code[20];
        Counter2: Integer;
        TotalCount: Integer;
        RoomSpaces: Record "ACA-Room Spaces";
        ACAHostelPermissions: Record "ACA-Hostel Permissions";

    procedure "Rooms Maker"()
    begin
        // Creates Rooms For The Hostel
        CLEAR(Counter2);
        Rec.TESTFIELD("Room Prefix");
        Rooms.RESET;
        Rooms.SETRANGE(Rooms."Hostel Code", Rec."Asset No");
        Existing := Rooms.COUNT;
        Rooms.RESET;
        IF Existing = 0 THEN
            Existing := 1;
        /*
      IF "Space Per Room">1 THEN
      BEGIN
        "Total Rooms":="Total Rooms"*"Space Per Room"
      END;

      IF "Space Per Room"<1 THEN
      BEGIN
        "Space Per Room":=1
      END;
      */
        TotalCount := 0;
        Rooms.RESET;
        Rooms.SETRANGE(Rooms."Hostel Code", Rec."Asset No");
        IF Rooms.FIND('-') THEN Rooms.DELETEALL;
        FOR Counter := Rec."Starting No" TO Rec."Total Rooms" DO BEGIN
            // Create Rooms Here
            Rooms.INIT();
            Rooms."Room Code" := Rec."Room Prefix" + ' ' + FORMAT(Counter);
            Rooms."Hostel Code" := Rec."Asset No";
            Rooms.Status := Rooms.Status::Vaccant;
            Rooms."Room Cost" := Rec."Cost Per Occupant";
            //Rooms."Space No":=Rooms."Room No"+'-'+FORMAT(Counter2);
            Rooms.INSERT(TRUE);
            RoomSpaces.RESET;
            RoomSpaces.SETRANGE(RoomSpaces."Hostel Code", Rec."Asset No");
            RoomSpaces.SETRANGE(RoomSpaces."Room Code", Rec."Room Prefix" + ' ' + FORMAT(Counter));
            IF RoomSpaces.FIND('-') THEN RoomSpaces.DELETEALL;
            FOR Counter2 := 1 TO Rec."Space Per Room" DO BEGIN
                //   Create Bed Spaces Here
                RoomSpaces.RESET;
                RoomSpaces."Hostel Code" := Rec."Asset No";
                RoomSpaces."Room Code" := Rec."Room Prefix" + ' ' + FORMAT(Counter);
                RoomSpaces."Space Code" := Rec."Room Prefix" + ' ' + FORMAT(Counter) + '-' + FORMAT(Counter2);
                RoomSpaces.Status := RoomSpaces.Status::Vaccant;
                RoomSpaces.Booked := FALSE;
                RoomSpaces.INSERT;
                TotalCount := TotalCount + 1;
            END;
            //end;
            //Rooms.INSERT(TRUE);
        END;
        MESSAGE(FORMAT(TotalCount) + ' Rooms Created successfully');

    end;

    procedure clearFromRoom()
    var
        Rooms: Record "ACA-Hostel Block Rooms";
        spaces: Record "ACA-Room Spaces";
        hostLedger: Record "ACA-Hostel Ledger";
        HostRooms: Record "ACA-Students Hostel Rooms";
    begin
        hostLedger.RESET;
        hostLedger.SETRANGE(hostLedger."Hostel No", Rec."Asset No");
        // hostLedger.SETRANGE(hostLedger."Room No","Room No");
        //hostLedger.SETRANGE(hostLedger."Space No","Space No");
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
        spaces.SETRANGE(spaces."Hostel Code", Rec."Asset No");
        //spaces.setrange(spaces."Room Code","Room No");
        //spaces.setrange(spaces."Space Code","Space No");
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
        Rooms.SETRANGE(Rooms."Hostel Code", Rec."Asset No");
        //Rooms.SETRANGE(Rooms."Room Code","Room No");
        IF Rooms.FIND('-') THEN BEGIN
            REPEAT
                Rooms.VALIDATE(Rooms.Status);
            UNTIL Rooms.NEXT = 0;
        END;
    end;
}

