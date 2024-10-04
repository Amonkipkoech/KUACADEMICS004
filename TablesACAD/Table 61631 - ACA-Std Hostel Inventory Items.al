table 61631 "ACA-Std Hostel Inventory Items"
{

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Editable = false;
        }
        field(2; "Student Name"; Text[150])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(3; "Hostel Block"; Code[30])
        {
            Editable = false;
        }
        field(4; "Room Code"; Code[30])
        {
            Editable = false;
        }
        field(5; "Space Code"; Code[30])
        {
            Editable = false;
        }
        field(6; "Item Code"; Code[30])
        {
            TableRelation = "ACA-Hostel Inventory".Item;
        }
        field(7; Quantity; Integer)
        {
        }
        field(8; "Fine Amount"; Decimal)
        {
        }
        field(9; Cleared; Boolean)
        {
        }
        field(10; "Academic Year"; Code[30])
        {
            Editable = false;
        }
        field(11; Semester; Code[30])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Student No.", "Hostel Block", "Room Code", "Space Code", "Item Code", "Academic Year", Semester)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Quantity := 1;
    end;
}

