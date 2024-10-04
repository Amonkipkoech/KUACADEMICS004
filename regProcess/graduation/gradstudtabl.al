table 86623 gradStudents
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; studNo; code[20])
        {
            // DataClassification = ToBeClassified;

        }
        field(2; studName; text[200])
        {

        }
        field(3; unitsCount; Decimal)
        {

        }
        field(4; GradRemark; text[200])
        {

        }
        field(5; graduationStatus; Option)
        {
            OptionMembers = Completed,Failed;
        }
        field(6; programme; code[20])
        {
            TableRelation = "ACA-Programme".Code;
        }
        field(7; "Academic Year"; Code[20])
        {
            TableRelation = "ACA-Academic Year".Code;
        }
        field(8; Semester; Code[20])
        {
            TableRelation = "ACA-Semester".Code;
        }
        field(9; "program"; code[20])
        {

        }
        field(10; "Graduating Grade"; Text[200])
        {

        }
        field(11; "Average Grade"; Decimal)
        {

        }
    }

    keys
    {
        key(Key1; studNo)
        {
            Clustered = true;
        }
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