report 51059 "UpdateStud Dept"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; 18)
        {
            RequestFilterFields = "Global Dimension 2 Code";

            trigger OnAfterGetRecord()
            begin
                IF Customer."Global Dimension 1 Code" = 'KISUMU' THEN
                    CurrReport.SKIP ELSE
                    Customer."Global Dimension 1 Code" := 'MAIN';
                Customer.MODIFY;
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

    var
        Prog: Record 61511;
}

