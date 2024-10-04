report 65819 "Validate  Units"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; 61549)
        {
            RequestFilterFields = Programme, Semester, Unit;

            trigger OnAfterGetRecord()
            begin
                //"ACA-Lecturers Units".VALIDATE("ACA-Lecturers Units".Programme);
                reg.VALIDATE(Unit);
                reg.MODIFY;
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
        reg: Record "ACA-Student Units";
}

