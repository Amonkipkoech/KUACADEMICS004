table 69306 "Fee Payer Details"
{
    
    
     fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2;"Fee Payer Names"; Text[250])
        {
            
            
        }
        field(3;"Fee Payer Mobile No"; Integer)
        {

        }
        field(4; "Fee Payer E-mail"; Text[100])
        {

        }
        field(5; "Fee Payer R/Ship"; code[20])
        {

        }
        field(6; "Application No."; Code[20])
        {
            Description = 'Stores the reference of the application in the database';
        }
    }
    
    keys
    {
        key(Key1; "Line No.", "Application No.")
        {
            Clustered = true;
        }
    }
    
   
        
    
    
}