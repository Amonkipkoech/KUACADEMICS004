report 69275 "Val Units"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("ACA-Student Units"; 61549)
        {
            RequestFilterFields = Semester;

            trigger OnAfterGetRecord()
            begin
                "ACA-Student Units".Taken := TRUE;
                "ACA-Student Units".MODIFY;
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

