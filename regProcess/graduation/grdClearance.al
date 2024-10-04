table 86620 "Graduation Clearance"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; studNo; code[20])
        {
            TableRelation = Customer;

        }
        field(2; semester; code[20])
        {

        }
        field(3; academicYear; code[20])
        {

        }
        field(4; studentNames; Text[200])
        {

        }
        field(5; Programme; code[20])
        {

        }
        field(6; Status; Option)
        {
            OptionMembers = Open,"Pending Approval",Approved;
        }
        field(7; "No."; Code[20])
        {
           
        }
    }

    keys
    {
        key(Key1; "No.", studNo, semester)
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