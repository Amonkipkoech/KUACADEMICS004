report 65813 "Validate Units Lect"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Lect Load Batch Lines"; "Lect Load Batch Lines")
        {

            trigger OnAfterGetRecord()
            begin
                "Lect Load Batch Lines".VALIDATE("Lect Load Batch Lines"."Lecturer Code");
                "Lect Load Batch Lines".MODIFY;
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

