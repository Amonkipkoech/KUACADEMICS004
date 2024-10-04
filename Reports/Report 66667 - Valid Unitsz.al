report 66667 "Valid Unitsz"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Unitsz; 61549)
        {

            trigger OnAfterGetRecord()
            begin
                Unitsz.VALIDATE(Unit);
                Unitsz.MODIFY;
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

