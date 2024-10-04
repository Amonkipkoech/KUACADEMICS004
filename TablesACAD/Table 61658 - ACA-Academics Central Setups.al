table 61658 "ACA-Academics Central Setups"
{
    DrillDownPageID = 61658;
    LookupPageID = 61658;

    fields
    {
        field(1; "Title Code"; Code[10])
        {
        }
        field(2; Description; Text[30])
        {
        }
        field(3; Category; Option)
        {
            OptionCaption = ' ,Titles,Religions,Denominations,Relationships,Counties,Countries,Nationality,Districts,Positions';
            OptionMembers = " ",Titles,Religions,Denominations,Relationships,Counties,Countries,Nationality,Districts,Positions;
        }
    }

    keys
    {
        key(Key1; Category, "Title Code")
        {
        }
    }

    fieldgroups
    {
    }
}

