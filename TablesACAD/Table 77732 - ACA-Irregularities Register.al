table 77732 "ACA-Irregularities Register"
{

    fields
    {
        field(1; Counts; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "Student No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Student Name"; Text[150])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(4; "Transaction Date/Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Captured By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Irregularity Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Exam Irregularity,Others';
            OptionMembers = " ","Exam Irregularity",Others;
        }
        field(7; Essay; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Counts, "Student No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Captured By" := USERID;
        "Transaction Date/Time" := CREATEDATETIME(TODAY, TIME);
    end;

    trigger OnModify()
    begin
        "Captured By" := USERID;
    end;

    trigger OnRename()
    begin
        ERROR('Not Allowed');
    end;
}

