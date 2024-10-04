table 50060 "M-pesa Validation"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; transactionRefNo; code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; accountNo; code[20])
        {

        }
        field(3; accountName; text[200])
        {

        }
        field(4; telephoneNo; text[100])
        {

        }
        field(5; transactionAmount; Decimal)
        {

        }
        field(6; accountBalance; Decimal)
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