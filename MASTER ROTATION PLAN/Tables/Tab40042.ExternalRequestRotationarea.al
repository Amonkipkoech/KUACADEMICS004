table 40042 "External Request Rotation area"
{
    Caption = 'External Request Rotation area';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Rotation Area Code"; Code[50])
        {
            Caption = 'Rotation Area Code';
            TableRelation = Lab."Area cODE";
            // trigger OnValidate()
            // var
            //     lb: Record Lab;
            // begin
            //     if lb.Get("Rotation Area Code") then begin
            //         "Rotation Name" := lb."Lab Name";
            //     end;
            // end;
        }
        field(2; "Rotation Name"; Text[100])
        {
            Caption = 'Rotation Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup(Lab."Lab Name" WHERE("Area cODE" = FIELD("Rotation Area Code")));
        }
        field(3; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(4; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(5; "Request Number"; Code[20])
        {
            Caption = 'Request Number';
        }

        field(6; "Institution Code"; Code[20])
        {
            Caption = 'Institution Code';
            //TableRelation = "Institute Master"."Institute Code";

        }

    }
    keys
    {
        key(PK; "Rotation Area Code", "Request Number")
        {
            Clustered = true;
        }
    }
}
