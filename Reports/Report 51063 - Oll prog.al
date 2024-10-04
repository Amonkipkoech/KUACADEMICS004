report 51063 "Oll prog"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Oll prog.rdl';

    dataset
    {
        dataitem("ACA-Old Programmes"; 61012)
        {

            trigger OnAfterGetRecord()
            begin
                "ACA-Old Programmes".CALCFIELDS("New Code FK");
                "ACA-Old Programmes"."New Code" := "ACA-Old Programmes"."New Code FK";
                "ACA-Old Programmes".MODIFY;
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

