table 61169 "CAT-Daily Menu"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Menu Date"; Date)
        {
        }
        field(3; Menu; Code[20])
        {
            TableRelation = "CAT-Food Menu".Code;
        }
        field(4; Description; Text[30])
        {
        }
        field(5; Units; Text[30])
        {
        }
        field(6; "Menu Qty"; Integer)
        {
        }
        field(7; "Prod Qty"; Integer)
        {
        }
        field(8; "Total Qty"; Integer)
        {
        }
        field(9; "Unit Cost"; Decimal)
        {
        }
        field(10; "Total Cost"; Decimal)
        {
        }
        field(11; "produced By"; Code[10])
        {
        }
        field(12; Remarks; Text[30])
        {
        }
        field(13; "Remaining Qty"; Decimal)
        {
        }
        field(14; Type; Option)
        {
            OptionCaption = ' ,Student,Staff,Meal Booking';
            OptionMembers = " ",Student,Staff,"Meal Booking";
        }
        field(15; Posted; Boolean)
        {
        }
        field(16; "Posted Date"; Date)
        {
        }
        field(17; Yield; Decimal)
        {

            trigger OnValidate()
            begin
                "Prod Qty" := Yield * "Menu Qty";
                "Remaining Qty" := Yield;
                // MODIFY;
            end;
        }
        field(50000; "Campus Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50001; "Department Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
    }

    keys
    {
        key(Key1; "Entry No", Menu)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Menu Date" := TODAY;
    end;
}

