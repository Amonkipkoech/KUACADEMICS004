table 61590 "ACA-Tranfer Student"
{

    fields
    {
        field(1; "Student No."; Code[20])
        {
            NotBlank = true;
            TableRelation = Customer."No.";
        }
        field(2; "Form Reg."; Code[20])
        {
            TableRelation = "ACA-Course Registration".Programmes WHERE("Student No." = FIELD("Student No."),
                                                                       Transfered = CONST(false));

            trigger OnValidate()
            begin
                IF "Form Reg." <> '' THEN BEGIN
                    IF "Form Reg." = "To Reg." THEN
                        ERROR('Registration IDs can not be the same.');
                END;
            end;
        }
        field(3; "To Reg."; Code[20])
        {
            TableRelation = "ACA-Course Registration".Programmes WHERE("Student No." = FIELD("Student No."),
                                                                       Transfered = CONST(false));

            trigger OnValidate()
            begin
                IF "To Reg." <> '' THEN BEGIN
                    IF "Form Reg." = "To Reg." THEN
                        ERROR('Registration IDs can not be the same.');
                END;
            end;
        }
    }

    keys
    {
        key(Key1; "Student No.")
        {
        }
    }

    fieldgroups
    {
    }
}

