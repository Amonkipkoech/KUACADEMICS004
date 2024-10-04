table 50061 "confirmedMpesaTransaction"
{


    fields
    {
        field(1; transactionRefNo; code[20])
        {

        }
        field(2; accountNo; text[100])
        {

        }
        field(3; accountName; text[200])
        {

        }
        field(4; telephoneNo; code[20])
        { 

        }
        field(5; transactionAmount; Decimal)
        {

        }
        field(6; accountBalance; Decimal)
        {

        }
        field(7; paybillNo; code[20])
        {

        }
        field(8; confirmed; Boolean)
        {
            
        }

    }

    keys
    {
        key(Key1; transactionRefNo)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}