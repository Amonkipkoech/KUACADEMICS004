table 40012 "Fee Exemption cleared Batches"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Semester; code[20])
        {
            TableRelation = "ACA-Semesters";
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Created By" := UserId;
                "Created Time" := Time;
                "Created Date" := Today;
            end;

        }
        field(2; "Academic Year"; code[20])
        {
            TableRelation = "ACA-Academic Year";
        }
        field(3; "Created Time"; time)
        {

        }
        field(4; "Created By"; Code[20])
        {

        }
        field(5; "Created Date"; Date)
        {

        }
        field(6; "Clearance Batch"; Code[30])
        {

        }
    }

    keys
    {
        key(Key1; "Clearance Batch", Semester, "Created By")
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
