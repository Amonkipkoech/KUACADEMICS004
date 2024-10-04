/// <summary>
/// Table ACA-Students Hostel Inventory (ID 61826).
/// </summary>
table 61826 "ACA-Students Hostel Inventory"
{

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Space No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Room Spaces"."Space Code" WHERE("Hostel Code" = FIELD("Hostel No"),
                                                                  "Room Code" = FIELD("Room No"),
                                                                  Status = FILTER(Vaccant));
        }
        field(3; "Room No"; Code[20])
        {
            TableRelation = "ACA-Hostel Block Rooms"."Room Code" WHERE("Hostel Code" = FIELD("Hostel No"),
                                                                        Status = FILTER(Vaccant));
        }
        field(4; "Hostel No"; Code[20])
        {
            TableRelation = "ACA-Hostel Card"."Asset No" WHERE(Gender = FIELD(Gender));
        }
        field(5; "Accomodation Fee"; Decimal)
        {
        }
        field(6; "Allocation Date"; Date)
        {
        }
        field(7; "Clearance Date"; Date)
        {
        }
        field(8; Charges; Decimal)
        {
        }
        field(9; Student; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(10; Billed; Boolean)
        {
        }
        field(11; "Billed Date"; Date)
        {
        }
        field(12; Semester; Code[20])
        {
            TableRelation = "ACA-Semesters".Code;
        }
        field(13; Cleared; Boolean)
        {
        }
        field(14; "Over Paid"; Boolean)
        {
        }
        field(15; "Over Paid Amt"; Decimal)
        {
        }
        field(16; "Eviction Code"; Code[20])
        {
            //TableRelation = "HRM-Disciplinary Cases".Code;
        }
        field(17; Gender; Option)
        {
            CalcFormula = Lookup(Customer.Gender WHERE("No." = FIELD(Student)));
            FieldClass = FlowField;
            OptionCaption = ',Male,Female';
            OptionMembers = ,Male,Female;
        }
        field(18; "Hostel Assigned"; Boolean)
        {
        }
        field(19; "Hostel Name"; Text[100])
        {
            CalcFormula = Lookup("Fixed Asset".Description WHERE("No." = FIELD("Hostel No")));
            FieldClass = FlowField;
        }
        field(20; "Item Code"; Code[20])
        {
            TableRelation = Item."No.";
        }
        field(21; "Item Description"; Text[30])
        {
        }
        field(50000; "Student Name"; Text[100])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD(Student)));
            FieldClass = FlowField;
        }
        field(50001; "Academic Year"; Code[30])
        {
            TableRelation = "ACA-Academic Year".Code;
        }
        field(50002; Session; Code[10])
        {
            TableRelation = "ACA-Intake".Code;
        }
        field(50003; Allocated; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Line No", Student)
        {
        }
        key(Key2; "Hostel No")
        {
        }
        key(Key3; Student)
        {
        }
    }

    fieldgroups
    {
    }
}

