table 61530 "ACA-Student Sponsors Details"
{
    Caption = 'Employee Relative';

    fields
    {
        field(1; "Student No."; Code[20])
        {
            NotBlank = true;
            TableRelation = Customer."No.";
        }
        field(2; Names; Text[50])
        {
            NotBlank = true;
        }
        field(3; Address; Text[250])
        {
        }
        field(4; "Telephone No"; Text[100])
        {
        }
        field(5; "E-Mail Address"; Text[50])
        {
        }
        field(6; "Contact Person"; Text[100])
        {
        }
        field(7; Remarks; Text[250])
        {
        }
        field(8; "Relationship"; code[30])
        {

        }
    }

    keys
    {
        key(Key1; "Student No.", Names)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
    // HRCommentLine: Record "5208";
    begin
        // HRCommentLine.SETRANGE("Table Name",HRCommentLine."Table Name"::"Employee Relative");
        // HRCommentLine.SETRANGE("No.","Student No.");
        // HRCommentLine.DELETEALL;
    end;
}

