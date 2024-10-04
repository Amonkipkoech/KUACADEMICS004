table 61361 "ACA-Applic. Form Qualification"
{

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Application No."; Code[20])
        {
        }
        field(3; "Where Obtained"; Text[100])
        {
        }
        field(4; "From Date"; Date)
        {
        }
        field(5; "To Date"; Date)
        {
        }
        field(6; Qualification; Text[50])
        {
        }
        field(7; Award; Text[50])
        {
        }
        field(8; "Date Awarded"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Line No.", "Application No.")
        {
        }
    }

    fieldgroups
    {
    }
}

