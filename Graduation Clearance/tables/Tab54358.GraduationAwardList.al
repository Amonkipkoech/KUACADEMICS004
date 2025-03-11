table 86005 "Graduation Award List"
{
    Caption = 'Graduation Award List';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Admission No"; Code[20])
        {
            Caption = 'Admission No';
        }
        field(2; Name; Text[200])
        {
            Caption = 'Name';
        }
        field(3; school; Code[20])
        {
            Caption = 'school';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('FACULTY'));
        }
        field(4; "Grad Fee Invoiced"; Decimal)
        {
            Caption = 'Grad Fee Invoiced';
        }
        // field(5; Balance; Decimal)
        // {
        //     //CalcFormula = lookup(Customer.Balance where("No." = field("Admission No")));
        //     FieldClass = FlowField;
        // }
    }
    keys
    {
        key(PK; "Admission No")
        {
            Clustered = true;
        }
    }
}
