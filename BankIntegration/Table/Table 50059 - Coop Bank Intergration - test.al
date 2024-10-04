table 50059 "Coop Bank Intergration - Test"
{

    fields
    {
        field(1; messageID; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; statusCode; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; statusDescription; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; transactionReferenceCode; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; transactionDate; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(6; paymentAmount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; currency; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; additionalInfo; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(9; accountNumber; code[20])
        {

        }
        field(10; accountName; text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(11; institutionCode; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; institutionName; text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(13; posted; boolean)
        {

        }

    }

    keys
    {
        key(Key1; transactionReferenceCode, messageId)
        {
            //Clustered = true;
        }
    }

    fieldgroups
    {
    }
    
    
    //Date := DT2DATE(Datetime)
}

