table 52016 "partTimeHead"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; academicYr; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Academic Year";

        }
        field(2; semester; code[20])
        {
            TableRelation = "ACA-Semesters";
        }
        field(3; createdBy; code[20])
        {

        }
        field(4; dateCreated; Date)
        {

        }
    }

    keys
    {
        key(Key1; semester, academicYr)
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