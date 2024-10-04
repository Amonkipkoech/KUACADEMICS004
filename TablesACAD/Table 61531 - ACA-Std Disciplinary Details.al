table 61531 "ACA-Std Disciplinary Details"
{
    Caption = 'Employee Relative';

    fields
    {
        field(1; "Student No."; Code[20])
        {
            NotBlank = true;
            TableRelation = Customer."No.";
        }
        field(2; Date; Date)
        {
            NotBlank = true;
        }
        field(3; "Disciplinary Case"; Text[250])
        {
            NotBlank = true;
        }
        field(4; "Disciplinary Action"; Text[100])
        {
        }
        field(5; Remarks; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Student No.", Date)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
    //HRCommentLine: Record "5208";
    begin
        // HRCommentLine.SETRANGE("Table Name",HRCommentLine."Table Name"::"Employee Relative");
        // HRCommentLine.SETRANGE("No.","Student No.");
        // HRCommentLine.DELETEALL;
    end;
}

