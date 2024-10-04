table 61382 "ACA-Academic Year"
{
    LookupPageID = 68510;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Description = 'Stores the code of the academic year in the database';
        }
        field(2; Description; Text[30])
        {
            Description = 'Stores the description of the academic year';
        }
        field(3; From; Date)
        {
            Description = 'Stores the start date of the academic year in the database';
        }
        field(4; "To"; Date)
        {
            Description = 'Stores the end of the academic year in the database';
        }
        field(5; Current; Boolean)
        {
        }
        field(6; "Allow View of Transcripts"; Boolean)
        {
        }
        field(7; "Graduation Group (PhD)"; Code[20])
        {
        }
        field(8; "Graduation Group (Masters)"; Code[20])
        {
        }
        field(9; "Graduation Group (Degree)"; Code[20])
        {
        }
        field(10; "Graduation Group (Diploma)"; Code[20])
        {
        }
        field(11; "Graduation Group (Certificate)"; Code[20])
        {
        }
        field(12; "ID Card Validity"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Graduating Group"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Graduation Date (Degree)"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Admission Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Graduation Date (Certificate)"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Graduation Date (Diploma)"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Graduation Date (Masters)"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Graduation Date (Medicine)"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Graduation Date (Engineering)"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Allow CATs Exempt"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //webportals.PermissionsManagement('ACADYEARSETUP', USERID);
    end;

    trigger OnInsert()
    begin
        //webportals.PermissionsManagement('ACADYEARSETUP', USERID);
    end;

    trigger OnModify()
    begin
        //webportals.PermissionsManagement('ACADYEARSETUP', USERID);
    end;

    trigger OnRename()
    begin
        //webportals.PermissionsManagement('ACADYEARSETUP', USERID);
    end;

    var

}

