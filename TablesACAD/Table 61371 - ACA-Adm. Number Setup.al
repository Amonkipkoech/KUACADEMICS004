table 61371 "ACA-Adm. Number Setup"
{

    fields
    {
        field(1; Degree; Code[20])
        {
            Description = 'Stores the code to the degree';
            TableRelation = "ACA-Programme".Code;
        }
        field(2; "Degree Name"; Text[200])
        {
            CalcFormula = Lookup("ACA-Programme".Description WHERE(Code = FIELD(Degree)));
            Description = 'Stores the name of the degree';
            FieldClass = FlowField;
        }
        field(3; "Programme Prefix"; Code[20])
        {
            Description = 'Stores the prefix of the code in the database';
        }
        field(4; "No. Series"; Code[20])
        {
            Description = 'Stores the numbering series for the code in the database';
            TableRelation = "No. Series".Code;
        }
        field(5; Year; Code[20])
        {
            Description = 'Stores the year in the database';
        }
        field(6; "JAB Prefix"; Code[20])
        {
        }
        field(50000; "SSP Prefix"; Code[20])
        {
        }
        field(50001; "Reporting Date"; Date)
        {
        }
        field(50002; "Total Students"; Integer)
        {
            CalcFormula = Count("ACA-Applic Form PostGraduate" WHERE("Other Research Institution" = FIELD(Degree)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; Degree)
        {
        }
    }

    fieldgroups
    {
    }
}

