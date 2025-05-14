table 40037 "Student Ward Line"
{
    Caption = 'Student Ward History';
    DataClassification = ToBeClassified;

    fields
    {
        field(2; "GroupId"; Code[20]) { DataClassification = CustomerContent; }
        field(3; "StudentNo"; Code[20]) { DataClassification = CustomerContent; }
        field(4; "Rotation Ward Area"; Text[100])
        {
            DataClassification = CustomerContent;
            TableRelation = "Rotation Area Wards"."Ward Code";
            trigger OnValidate()
            var
                RaW: Record "Rotation Area Wards";
            begin
                if raw.Get("Rotation Ward Area") then begin
                    "Rotation Ward Name" := RaW."Ward Name";
                    "Rotation Area" := RaW."Rotation Area ";
                end;
            end;
        }
        field(5; "Start Date"; Date) { DataClassification = CustomerContent; }
        field(6; "End Date"; Date) { DataClassification = CustomerContent; }
        field(7; "Comment"; Text[250]) { DataClassification = CustomerContent; }
        field(8; "Semester"; Code[20]) { DataClassification = CustomerContent; }
        field(9; "Rotation Area"; Text[250]) { DataClassification = CustomerContent; }
        field(10; "Rotation Ward Name"; Text[250]) { DataClassification = CustomerContent; }
    }

    keys
    {
        key(PK; "GroupId", "StudentNo", "Rotation Ward Area")
        { Clustered = true; }
    }


}
