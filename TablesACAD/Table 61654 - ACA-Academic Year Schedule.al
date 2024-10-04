table 61654 "ACA-Academic Year Schedule"
{

    fields
    {
        field(1; "Academic Year"; Code[20])
        {
        }
        field(2; Semester; Code[20])
        {
            TableRelation = "ACA-Semesters".Code;
        }
        field(3; Intake; Code[20])
        {
            TableRelation = "ACA-Intake".Code;
        }
        field(4; "Start Date"; Date)
        {
            TableRelation = Date."Period Start" WHERE("Period Type" = FILTER(Date));
        }
        field(5; "End Date"; Date)
        {
            TableRelation = Date."Period Start" WHERE("Period Type" = FILTER(Date));
        }
        field(6; "Is Current"; Boolean)
        {
        }
        field(7; "Student Type"; Code[20])
        {
            TableRelation = "ACA-Settlement Type".Code;
        }
        field(8; "Description of Intake/Semester"; Code[100])
        {
        }
        field(9; "Registration Deadline"; Date)
        {
        }
        field(10; "Marks Caprture Begin Date"; Date)
        {
            TableRelation = Date."Period Start" WHERE("Period Type" = FILTER(Date));
        }
        field(11; "Marks Caprture End Date"; Date)
        {
            TableRelation = Date."Period Start" WHERE("Period Type" = FILTER(Date));
        }
        field(12; "Allow View of Results"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Academic Year", Semester, Intake, "Student Type")
        {
        }
    }

    fieldgroups
    {
    }
}

