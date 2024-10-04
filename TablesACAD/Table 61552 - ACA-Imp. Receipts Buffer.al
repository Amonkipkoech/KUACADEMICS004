table 61552 "ACA-Imp. Receipts Buffer"
{

    fields
    {
        field(1; "Transaction Code"; Code[20])
        {
            NotBlank = true;
            trigger OnValidate()
            begin
                scholarship.Reset();
                scholarship.SetRange("No.", "Transaction Code");
                if scholarship.FindFirst() then begin

                    "Batch No." := scholarship."Batch No.";

                end;

            end;
        }
        field(2; Date; Date)
        {
            NotBlank = true;
        }
        field(3; Description; Text[150])
        {
        }
        field(4; Amount; Decimal)
        {
            NotBlank = true;
        }
        field(5; Posted; Boolean)
        {
            
        }
        field(6; "Receipt No"; Code[20])
        {
        }
        field(7; "Student No."; Code[20])
        {
            TableRelation = Customer;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Validate("Transaction Code");
            end;
        }
        field(8; Unallocated; Boolean)
        {
        }
        field(9; "Cheque No"; Code[20])
        {
        }
        field(10; "Stud Exist"; Integer)
        {
            CalcFormula = Count(Customer WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(11; Stage; Code[20])
        {
            CalcFormula = Lookup("ACA-Course Registration".Stage WHERE("Student No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(12; Name; Text[100])
        {
        }
        field(13; IDNo; Code[30])
        {
        }
        field(14; "F Name"; Text[50])
        {
        }
        field(15; "M Name"; Text[50])
        {
        }
        field(16; "L Name"; Text[50])
        {
        }
        field(17; SN; Code[20])
        {
        }
        field(18; Semester; Code[20])
        {
        }
        field(20; "Batch No."; Code[20])
        {
        }
        field(21; "User ID"; Code[30])
        {
        }
    }

    keys
    {
        key(Key1; "Transaction Code", "Student No.", Semester,Description)
        {
        }
        key(Key2; Posted, Date, "Student No.")
        {
            SumIndexFields = Amount;
        }
        key(Key3; "Batch No.")
        {

        }
    }

    fieldgroups
    {
    }
    trigger OnInsert()
    BEGIN
        "User ID" := UserId;
    end;

    var
        scholarship: Record "ACA-Scholarship Batches";
}

