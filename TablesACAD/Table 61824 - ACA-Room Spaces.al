table 61824 "ACA-Room Spaces"
{
    DrillDownPageID = 69164;
    LookupPageID = 69164;

    fields
    {
        field(1; "Hostel Code"; Code[20])
        {
            TableRelation = "ACA-Hostel Card"."Asset No";
        }
        field(2; "Room Code"; Code[20])
        {
            TableRelation = "ACA-Hostel Block Rooms"."Room Code";
        }
        field(3; "Space Code"; Code[20])
        {
        }
        field(4; Status; Option)
        {
            OptionCaption = 'Vaccant,Partially Occupied,Fully Occupied,Black-Listed,Partially Booked,Fully Booked';
            OptionMembers = Vaccant,"Partially Occupied","Fully Occupied","Black-Listed","Partially Booked","Fully Booked";
        }
        field(9; Booked; Boolean)
        {
        }
        field(10; "Booked Students"; Code[20])
        {
        }
        field(11; "Student No"; Code[20])
        {
        }
        field(12; "Receipt No"; Code[20])
        {
        }
        field(13; "Student Name"; Text[250])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Student No")));
            FieldClass = FlowField;
        }
        field(14; "Black List reason"; Text[30])
        {
        }
        field(15; "Room Cost"; Decimal)
        {
        }
        field(16; "Current Student"; Code[30])
        {
            CalcFormula = Lookup("ACA-Hostel Ledger"."Student No" WHERE("Space No" = FIELD("Space Code"),
                                                                         "Room No" = FIELD("Room Code")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Hostel Code", "Room Code", "Space Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        ACAHostelPermissions.PermissionMan(USERID, 9);
        rmsLedger.RESET;
        //rmsLedger.SETRANGE(rmsLedger."Hostel No","Asset No");
        rmsLedger.SETRANGE(rmsLedger."Room No", "Room Code");
        rmsLedger.SETRANGE(rmsLedger."Space No", "Space Code");
        IF rmsLedger.FIND('-') THEN BEGIN
            ERROR('Allocations exists for this Space. Clear the space first.');
        END;
    end;

    trigger OnInsert()
    begin
        ACAHostelPermissions.PermissionMan(USERID, 9);
    end;

    trigger OnModify()
    begin
        ACAHostelPermissions.PermissionMan(USERID, 9);
    end;

    var
        rmsLedger: Record 61163;
        ACAHostelPermissions: Record 70007;
}

