table 61825 "ACA-Hostel Ledger History"
{
    DrillDownPageID = 68314;
    LookupPageID = 68314;

    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = false;
        }
        field(2; "Hostel No"; Code[20])
        {
            TableRelation = "ACA-Hostel Card"."Asset No";
        }
        field(3; "Room No"; Code[20])
        {
        }
        field(4; Status; Option)
        {
            OptionCaption = 'Vaccant,Partially Occupied,Fully Occupied,Black-Listed,Partially Booked,Fully Booked';
            OptionMembers = Vaccant,"Partially Occupied","Fully Occupied","Black-Listed","Partially Booked","Fully Booked";
        }
        field(5; "Room Cost"; Decimal)
        {
        }
        field(6; "Student No"; Code[20])
        {
        }
        field(7; "Receipt No"; Code[20])
        {
        }
        field(8; "Space No"; Code[20])
        {
        }
        field(9; Booked; Boolean)
        {
        }
        field(10; "Booked Students"; Code[20])
        {
            CalcFormula = Lookup("ACA-Students Hostel Rooms".Student WHERE("Space No" = FIELD("Space No"),
                                                                            Semester = FIELD("Semester Filter")));
            FieldClass = FlowField;
        }
        field(11; "Semester Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(12; "Students Count"; Integer)
        {
            CalcFormula = Count("ACA-Students Hostel Rooms" WHERE("Space No" = FIELD("Space No"),
                                                                   Semester = FIELD("Semester Filter")));
            FieldClass = FlowField;
        }
        field(13; Gender; Option)
        {
            CalcFormula = Lookup("ACA-Hostel Card".Gender WHERE("Asset No" = FIELD("Hostel No")));
            FieldClass = FlowField;
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(14; "Reservation Remarks"; Text[100])
        {
        }
        field(15; "Reservation UserID"; Code[20])
        {
        }
        field(16; "Reservation Date"; Date)
        {
        }
        field(50000; Campus; Code[20])
        {
            CalcFormula = Lookup("ACA-Hostel Card"."Campus Code" WHERE("Asset No" = FIELD("Hostel No")));
            FieldClass = FlowField;
        }
        field(50001; "Hostel Name"; Text[100])
        {
            CalcFormula = Lookup("ACA-Hostel Card".Description WHERE("Asset No" = FIELD("Hostel No")));
            FieldClass = FlowField;
        }
        field(50002; Semester; Code[20])
        {
        }
        field(50004; "User ID"; Code[100])
        {
            CalcFormula = Lookup("ACA-Students Hostel Rooms"."Allocated By" WHERE("Space No" = FIELD("Space No"),
                                                                                   "Room No" = FIELD("Room No"),
                                                                                   "Hostel No" = FIELD("Hostel No"),
                                                                                   Semester = FIELD(Semester)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Space No", "Room No", "Hostel No", "Student No", Semester)
        {
        }
        key(Key2; "Hostel No")
        {
        }
        key(Key3; "Student No")
        {
        }
        key(Key4; "Room No", Status)
        {
        }
    }

    fieldgroups
    {
    }
}

