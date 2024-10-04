table 61162 "ACA-Hostel Card"
{
    DrillDownPageID = 68132;
    LookupPageID = 68132;

    fields
    {
        field(1; "Asset No"; Code[10])
        {
        }
        field(2; Description; Text[30])
        {
        }
        field(3; "Total Rooms"; Integer)
        {
        }
        field(4; "Space Per Room"; Integer)
        {
        }
        field(5; "Cost Per Occupant"; Decimal)
        {
        }
        field(6; Gender; Option)
        {
            OptionMembers = " ",Male,Female;
        }
        field(7; Location; Code[20])
        {
        }
        field(8; Programme; Code[20])
        {
        }
        field(9; "Cost per Room"; Decimal)
        {
        }
        field(10; "Room Prefix"; Code[10])
        {
        }
        field(11; "Minimum Balance"; Decimal)
        {
        }
        field(12; "Starting No"; Integer)
        {
            InitValue = 1;
        }
        field(13; "Total Rooms Created"; Integer)
        {
            CalcFormula = Count("ACA-Hostel Ledger" WHERE("Hostel No" = FIELD("Asset No")));
            FieldClass = FlowField;
        }
        field(14; "Total Vacant"; Integer)
        {
            CalcFormula = Count("ACA-Hostel Ledger" WHERE("Hostel No" = FIELD("Asset No"),
                                                           Status = FILTER(Vaccant)));
            FieldClass = FlowField;
        }
        field(15; "Total Occupied"; Integer)
        {
            CalcFormula = Count("ACA-Hostel Ledger" WHERE("Hostel No" = FIELD("Asset No"),
                                                           Status = FILTER("Partially Occupied")));
            FieldClass = FlowField;
        }
        field(16; "Total Out of Order"; Integer)
        {
            CalcFormula = Count("ACA-Hostel Ledger" WHERE("Hostel No" = FIELD("Asset No"),
                                                           Status = FILTER("Fully Occupied")));
            FieldClass = FlowField;
        }
        field(17; "Hostel Type"; Option)
        {
            OptionMembers = Internal,"Out Sourced";
        }
        field(18; "Provider Code"; Code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(50000; "Campus Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50001; Vaccant; Integer)
        {
            CalcFormula = Count("ACA-Hostel Block Rooms" WHERE("Hostel Code" = FIELD("Asset No"),
                                                                Status = FILTER(Vaccant)));
            FieldClass = FlowField;
        }
        field(50002; "Fully Occupied"; Integer)
        {
            CalcFormula = Count("ACA-Hostel Block Rooms" WHERE("Hostel Code" = FIELD("Asset No"),
                                                                Status = FILTER('Fully Occupied')));
            FieldClass = FlowField;
        }
        field(50003; Blacklisted; Integer)
        {
            CalcFormula = Count("ACA-Hostel Block Rooms" WHERE("Hostel Code" = FIELD("Asset No"),
                                                                Status = FILTER('Black-Listed')));
            FieldClass = FlowField;
        }
        field(50004; "Partially Occupied"; Integer)
        {
            CalcFormula = Count("ACA-Hostel Block Rooms" WHERE("Hostel Code" = FIELD("Asset No"),
                                                                Status = FILTER('Partially Occupied')));
            FieldClass = FlowField;
        }
        field(50005; "JAB Fees"; Decimal)
        {

            trigger OnValidate()
            begin
                validateCosts();
            end;
        }
        field(50006; "SSP Fees"; Decimal)
        {

            trigger OnValidate()
            begin
                validateCosts();
            end;
        }
        field(50007; "Special Programme"; Decimal)
        {

            trigger OnValidate()
            begin
                validateCosts();
            end;
        }
        field(50008; "Rooms Generated"; Integer)
        {
            CalcFormula = Count("ACA-Hostel Block Rooms" WHERE("Hostel Code" = FIELD("Asset No")));
            FieldClass = FlowField;
        }
        field(50009; "Room Spaces"; Integer)
        {
            CalcFormula = Count("ACA-Room Spaces" WHERE("Hostel Code" = FIELD("Asset No"),
                                                         Status = FILTER(<> 'Black-Listed')));
            FieldClass = FlowField;
        }
        field(50010; "Vaccant Spaces"; Integer)
        {
            CalcFormula = Count("ACA-Room Spaces" WHERE("Hostel Code" = FIELD("Asset No"),
                                                         Status = FILTER(Vaccant)));
            FieldClass = FlowField;
        }
        field(50011; "Occupied Spaces"; Integer)
        {
            CalcFormula = Count("ACA-Room Spaces" WHERE("Hostel Code" = FIELD("Asset No"),
                                                         Status = FILTER("Fully Occupied")));
            FieldClass = FlowField;
        }
        field(50012; "View Online"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Asset No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        ACAHostelPermissions.PermissionMan(USERID, 7);

        rmsLedger.RESET;
        rmsLedger.SETRANGE(rmsLedger."Hostel No", "Asset No");
        IF rmsLedger.FIND('-') THEN BEGIN
            ERROR('Allocations exists for this Hostel Block. Clear the rooms/spaces first.');
        END;

        rooms.RESET;
        rooms.SETRANGE(rooms."Hostel Code", "Asset No");
        IF rooms.FIND('-') THEN BEGIN
            rooms.DELETEALL;
        END;

        rmspcs.RESET;
        rmspcs.SETRANGE(rmspcs."Hostel Code", "Asset No");
        IF rmspcs.FIND('-') THEN BEGIN
            rmspcs.DELETEALL;
        END;

        rmsLedger.RESET;
        rmsLedger.SETRANGE(rmsLedger."Hostel No", "Asset No");
        IF rmsLedger.FIND('-') THEN BEGIN
            rmsLedger.DELETEALL;
        END;
    end;

    trigger OnInsert()
    begin
        ACAHostelPermissions.PermissionMan(USERID, 7);
    end;

    trigger OnModify()
    begin
        ACAHostelPermissions.PermissionMan(USERID, 7);
    end;

    var
        rooms: Record 61823;
        rmspcs: Record 61824;
        rmsLedger: Record 61163;
        ACAHostelPermissions: Record 70007;

    local procedure validateCosts()
    begin
        rooms.RESET;
        rooms.SETRANGE(rooms."Hostel Code", "Asset No");
        IF rooms.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                rooms.VALIDATE(rooms."Room Code");
            END;
            UNTIL rooms.NEXT = 0;
        END;
    end;
}

