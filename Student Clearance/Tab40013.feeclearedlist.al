table 40013 "VcCleraedList"

{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; lineNo; Integer)
        {
            AutoIncrement = true;

        }
        field(2; studentNo; code[20])
        {
            TableRelation = Customer;
        }
        field(3; "Reason For Clerance"; text[200])
        {

        }
        field(4; "Academic Year"; code[20])
        {
            TableRelation = "ACA-Academic Year";
        }
        field(5; "Semester"; code[20])
        {
            TableRelation = "ACA-Semesters";
        }
        field(6; Approved; Boolean)
        {

        }
        field(7; UserId; code[20])
        {

        }
        field(9; "Clearance batch"; Code[20])
        {

        }
    }

    keys
    {
        key(Key1; "Clearance batch", lineNo, studentNo, Semester)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}