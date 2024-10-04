table 69264 "ACA-Consolidated Mks Counts"
{

    fields
    {
        field(1; "Student No."; Code[20])
        {
        }
        field(2; "Year of Study"; Code[20])
        {
        }
        field(3; Programme; Code[20])
        {
        }
        field(4; Option; Code[20])
        {
        }
        field(5; "Academic Year"; Code[20])
        {
        }
        field(6; Serial; Integer)
        {
        }
        field(7; "User Id"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Student No.", "Year of Study", Programme, Option, "Academic Year", "User Id")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "User Id" := USERID;
    end;
}

