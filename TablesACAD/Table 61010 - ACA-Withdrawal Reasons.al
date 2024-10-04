table 61010 "ACA-Withdrawal Reasons"
{

    fields
    {
        field(1; "Withdraw Reason"; Code[150])
        {
        }
        field(2; "Counted Students"; Integer)
        {
            CalcFormula = Count("CAT-Std Status Data" WHERE("Withdrawal Reason" = FIELD("Withdraw Reason")));
            FieldClass = FlowField;
        }
        field(3; Status; Option)
        {
            OptionCaption = 'Registration,Current,Alluminae,Dropped Out,Deffered,Suspended,Expelled,Discontinued,Withdrawn,Deceased,Transferred,Academic Leave,Completed';
            OptionMembers = Registration,Current,Alluminae,"Dropped Out",Deffered,Suspended,Expelled,Discontinued,Withdrawn,Deceased,Transferred,"Academic Leave",Completed;
        }
    }

    keys
    {
        key(Key1; "Withdraw Reason")
        {
        }
    }

    fieldgroups
    {
    }
}

