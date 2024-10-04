report 66670 "ACA-Validate Stages"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/ACA-Validate Stages.rdl';

    dataset
    {
        dataitem(ProgStages; 61516)
        {

            trigger OnAfterGetRecord()
            begin
                ProgStages.VALIDATE(Code);
                ProgStages.MODIFY;
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

