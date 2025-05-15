table 40037 "Student Ward Line"
{
    Caption = 'Student Ward History';
    DataClassification = ToBeClassified;

    fields
    {
        field(2; "GroupId"; Code[20]) { DataClassification = CustomerContent; }
        field(3; "StudentNo"; Code[20])
        {
            TableRelation = Customer."No.";
            DataClassification = CustomerContent;
        }
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
        field(8; "Semester"; Code[20])
        {
            TableRelation = "ACA-Semesters".Code;
            DataClassification = CustomerContent;
        }
        field(9; "Rotation Area"; Text[250]) { DataClassification = CustomerContent; }
        field(10; "Rotation Ward Name"; Text[250]) { DataClassification = CustomerContent; }
        field(11; "Attendance"; Option)
        {
            OptionMembers = Present,Absent;
            DataClassification = CustomerContent;
        }
        field(12; "Achievements"; Text[250])
        {

            DataClassification = CustomerContent;
        }
        field(22; "Student Name"; Text[30])
        {
            Caption = 'Student Name';
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD(StudentNo)));
        }
        field(13; "Student Program "; Text[30])
        {
            Caption = 'Student Program';
            FieldClass = FlowField;
            CalcFormula = Lookup("ACA-Course Registration".ProgramName WHERE("Student No." = FIELD(StudentNo)));// 
        }
        field(14; "Student Phone Number"; Text[30])
        {
            Caption = 'Student Phone Number';
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer."Mobile Phone No." WHERE("No." = FIELD(StudentNo)));//ACA-Course Registration 
        }
    }

    keys
    {
        key(PK; "GroupId", "StudentNo", "Rotation Ward Area", Semester, "Start Date")
        { Clustered = true; }
    }


}
