table 50049 "unitBasedstud"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;StudNo; code[20])
        {
            
            
        }
        field(2; settlementType; code[20])
        {

        }
    }
    
    keys
    {
        key(Key1; StudNo)
        {
            Clustered = true;
        }
    }
    
    var
        myInt: Integer;
    
    
    
}