table 61528 "ACA-Student Kin"
{
    Caption = 'Employee Relative';

    fields
    {
        field(1; "Student No"; Code[20])
        {
            NotBlank = true;
            TableRelation = Customer."No.";
        }
        field(2; Relationship; Code[20])
        {
            NotBlank = true;
        }
        field(3; Name; Text[100])
        {
            NotBlank = true;
        }
        field(4; "Other Names"; Text[100])
        {
            NotBlank = true;
        }
        field(5; "ID No/Passport No"; Text[50])
        {
        }
        field(6; "Date Of Birth"; Date)
        {
        }
        field(7; Occupation; Text[100])
        {
        }
        field(8; Address; Text[250])
        {
        }
        field(9; "Office Tel No"; Text[100])
        {
        }
        field(10; "Home Tel No"; Text[50])
        {
        }
        field(11; Remarks; Text[250])
        {
        }
        field(12; Names; Text[250])
        {
        }
        field(13; Email; text[100])
        {

        }
    }

    keys
    {
        key(Key1; "Student No", Relationship, Name, "Other Names")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
    // HRCommentLine: Record "Relatives";
    begin
        // HRCommentLine.SETRANGE("Table Name",HRCommentLine."Table Name"::"Employee Relative");
        // HRCommentLine.SETRANGE("No.","Student No");
        // HRCommentLine.DELETEALL;
    end;
}

