report 65814 "Validate Reg"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; 61549)
        {

            trigger OnAfterGetRecord()
            begin
                Reg.VALIDATE(Unit);
                reg.MODIFY;
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
    var
        reg: Record "ACA-Student Units";
}

