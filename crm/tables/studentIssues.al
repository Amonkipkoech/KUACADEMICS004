table 86635 "studentIssues"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; lineNo; Integer)
        {
            AutoIncrement = true;

        }
        field(2; Client; Code[20])
        {
            //TableRelation = Customer;
        }
        field(3; Section; code[20])
        {
            TableRelation = "ACA-crmSections";
        }
        field(4; "issue Raised"; text[300])
        {

        }
        field(5; "Resolution"; Text[300])
        {

        }
        field(6; status; Option)
        {
            OptionMembers = Submitted,"Under Review",Resolved;
        }
        field(7; "Client Type"; Option)
        {
            OptionMembers = Student,Staff;
        }
        field(8; DateRaised; DateTime)
        {

        }
        field(9; DateResolved; DateTime)
        {

        }
        field(10; Semester; code[20])
        {
            Caption = 'Block/Session';
            TableRelation = "ACA-Semester";
        }
        field(11; ClientName; Text[200])
        {

        }
        field(12; "Resolving Staff"; Code[20])
        {

        }
    }

    keys
    {
        key(Key1; lineNo, Client)
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