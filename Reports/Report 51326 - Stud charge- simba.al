report 51326 "Stud charge"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Stud charge.rdl';

    dataset
    {
        dataitem("ACA-Stage Charges"; "ACA-Stage Charges")
        {

            trigger OnAfterGetRecord()
            begin
                "ACA-Stage Charges"."Settlement Type" := 'JAB';
                "ACA-Stage Charges".MODIFY;
            end;

            trigger OnPostDataItem()
            begin
                MESSAGE('done');
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

