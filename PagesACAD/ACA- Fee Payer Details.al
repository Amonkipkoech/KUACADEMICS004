page 69304 "Fee Payer Details"
{
    PageType = ListPart;
    SourceTable = 69306;
    
    layout
    {
        area(Content)
        {
             repeater(___)
             {
                field("Fee Payer Names";Rec."Fee Payer Names")
                {
                    ApplicationArea = All;
        
                }
                field("Fee Payer Mobile No";Rec."Fee Payer Mobile No")
                {
                    ApplicationArea = All;
                }
                field("Fee Payer E-mail";Rec."Fee Payer E-mail")
                {
                    ApplicationArea = All;
                }
                field("Fee Payer R/Ship";"Fee Payer R/Ship")
                {
                    ApplicationArea =  All;
                }
             }
        }
    }
    
    actions
    {
       
    }
    

}