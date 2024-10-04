table 86614 coaUpdate
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; erpCode; Code[20])
        {
        

        }
        field(2; desc; text[300])
        {

        }
    }

    keys
    {
        key(Key1; erpCode)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    

}