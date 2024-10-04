table 86522 "Program Durations Setup"
{
    
    
    fields
    {
        field(1; "Duration Code"; code[20])
        {
            
            
        }
        field(2; "Duration"; Text[100])
        {
            
        }
    }
    
    keys
    {
        key(Key1; "Duration Code")
        {
            Clustered = true;
        }
    }
    
    var
        myInt: Integer;
    
    
    
}