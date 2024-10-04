table 86611 PortalSetup
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; Entry; code[10])
        {

        }
        field(2; StudentPortalMessage; Text[250])
        {

        }
        field(3; staffPortalMessage; Text[250])
        {

        }
        field(5; Status; Option)
        {
            OptionMembers = Active,Inactive;
        }
    }
    
    keys
    {
        key(Key1; Entry)
        {
            Clustered = true;
        }
    }
    
    var
        myInt: Integer;
    
    
    
}