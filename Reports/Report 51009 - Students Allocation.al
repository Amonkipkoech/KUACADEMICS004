report 51009 "Students Allocation"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(HB; 61823)
        {
            //The property 'DataItemTableView' shouldn't have an empty value.
            //DataItemTableView = '';

            trigger OnAfterGetRecord()
            begin
                VALIDATE(HB.Status);
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
        MKey: Text;
        mSign: Text;
        mMart: Text;
}

