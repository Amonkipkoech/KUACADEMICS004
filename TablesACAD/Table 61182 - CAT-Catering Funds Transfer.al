table 61182 "CAT-Catering Funds Transfer"
{

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Student No"; Code[20])
        {
            TableRelation = Customer."No." WHERE("Customer Type" = FILTER(Student));

            trigger OnValidate()
            begin
                IF Cust.GET("Student No") THEN
                    Name := Cust.Name;
            end;
        }
        field(3; Name; Text[100])
        {
        }
        field(4; Date; Date)
        {
        }
        field(5; Amount; Decimal)
        {

            trigger OnValidate()
            begin
                IF "Transfer Type" = "Transfer Type"::"To Catering" THEN BEGIN
                    Cust.GET("Student No");
                    Cust.CALCFIELDS(Cust.Balance);
                    IF (Cust.Balance + Amount) > 0 THEN ERROR('Please note that the amount availlable in Students Account is ' + FORMAT(Cust.Balance));
                END;
                IF "Transfer Type" = "Transfer Type"::"To Fees" THEN BEGIN
                    Cust.GET("Student No");
                    Cust.CALCFIELDS(Cust."Catering Amount");
                    IF (Cust."Catering Amount" + Amount) > 0 THEN ERROR('Please note that the amount availlable in Catering Account is ' + FORMAT(Cust."Catering Amount"));
                END;
            end;
        }
        field(6; Posted; Boolean)
        {
        }
        field(7; "Posted By"; Code[20])
        {
        }
        field(8; "Transfer Type"; Option)
        {
            OptionCaption = 'To Catering,To Fees';
            OptionMembers = "To Catering","To Fees";
        }
    }

    keys
    {
        key(Key1; "Line No", "Student No")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Cust: Record 18;
        CatL: Record 61176;
}

