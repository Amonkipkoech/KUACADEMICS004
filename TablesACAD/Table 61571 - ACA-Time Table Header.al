table 61571 "ACA-Time Table Header"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Programme; Code[20])
        {
            TableRelation = "ACA-Programme".Code;
        }
        field(3; Stage; Code[20])
        {
            TableRelation = "ACA-Programme Stages".Code;
        }
        field(4; Semester; Code[20])
        {
            TableRelation = "ACA-Semesters".Code;
        }
        field(5; Campus; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(6; Day; Code[20])
        {
            TableRelation = "ACA-Day Of Week".Day;
        }
        field(7; Lecturer; Code[20])
        {
            TableRelation = "HRM-Employee (D)"."No." WHERE(Lecturer = FILTER(true));
        }
        field(8; "Lecturer Room"; Code[20])
        {
            TableRelation = "ACA-Lecture Rooms".Code;
        }
        field(20; "Max Hours Continiously"; Decimal)
        {
        }
        field(21; "Max Hours Weekly"; Decimal)
        {
        }
        field(22; "Max Days Per Week"; Integer)
        {
        }
        field(23; "Max Lecturer Hours Daily"; Decimal)
        {
        }
        field(24; "Max Lecturer Days Per Week"; Decimal)
        {
        }
        field(25; "Max Class Capacity"; Integer)
        {
        }
        field(26; "Max Class Weekly"; Integer)
        {
        }
        field(27; Released; Boolean)
        {
            Editable = false;
        }
        field(28; "Released By"; Code[20])
        {
            Editable = false;
        }
        field(29; "Released On"; Date)
        {
            Editable = false;
        }
        field(30; "Last Opened By"; Code[20])
        {
            Editable = false;
        }
        field(31; "Last Opened On"; Date)
        {
            Editable = false;
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

    trigger OnInsert()
    begin
        IF GenSetup.GET() THEN BEGIN
            GenSetup."Current TT Code" := Code;
            GenSetup.MODIFY;
        END;
    end;

    trigger OnModify()
    begin
        IF GenSetup.GET() THEN BEGIN
            GenSetup."Current TT Code" := Code;
            GenSetup.MODIFY;
        END;
    end;

    trigger OnRename()
    begin
        IF GenSetup.GET() THEN BEGIN
            GenSetup."Current TT Code" := Code;
            GenSetup.MODIFY;
        END;
    end;

    var
        GenSetup: Record "ACA-General Set-Up";
}

