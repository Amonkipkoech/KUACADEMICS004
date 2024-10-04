report 63906 "ValidateLedger Entry"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(CustEntry; 21)
        {

            trigger OnAfterGetRecord()
            begin
                CustEntry.VALIDATE(Description);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }
}

