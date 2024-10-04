table 61560 "ACA-Hostel Rooms"
{
    // DrillDownPageID = 67059;
    // LookupPageID = 67059;

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[200])
        {
        }
        field(3; Capacity; Integer)
        {
        }
        field(4; Occupied; Integer)
        {
            CalcFormula = Count("ACA-Std Charges" WHERE("Room Allocation" = FIELD(Code)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; Remarks; Text[200])
        {
        }
        field(6; Building; Code[20])
        {
        }
        field(7; Floor; Option)
        {
            OptionCaption = ' ,First,Second,Third,Fourth,Fifth,Sixth';
            OptionMembers = " ",First,Second,Third,Fourth,Fifth,Sixth;
        }
    }

    keys
    {
        key(Key1; Building, "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        roomspaces.RESET;
        roomspaces.SETRANGE(roomspaces."Hostel Code", Building);
        roomspaces.SETRANGE(roomspaces."Room Code", Code);
        roomspaces.SETFILTER(roomspaces."Student No", '<>%1', '');
        IF roomspaces.FIND('-') THEN BEGIN
            ERROR('Clear the students from the rooms before deleting.');
        END;
        roomspaces.RESET;
        roomspaces.SETRANGE(roomspaces."Hostel Code", Building);
        roomspaces.SETRANGE(roomspaces."Room Code", Code);
        IF roomspaces.FIND('-') THEN DELETEALL;
    end;

    var
        roomspaces: Record "ACA-Room Spaces";
}

