report 65818 "Validate Lecturer Units"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; 65202)
        {

            trigger OnAfterGetRecord()
            begin
                //"ACA-Lecturers Units".VALIDATE("ACA-Lecturers Units".Programme);
                reg.VALIDATE(Unit);
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
        reg: Record "ACA-Lecturers Units";
}

