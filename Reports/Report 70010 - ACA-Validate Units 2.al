report 70010 "ACA-Validate Units 2"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("ACA-Student Units"; "ACA-Student Units")
        {
            DataItemTableView = WHERE(Grade = FILTER('E'));
            RequestFilterFields = Semester, "Academic Year";

            trigger OnAfterGetRecord()
            begin
                "ACA-Student Units".VALIDATE("ACA-Student Units".Remarks);
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
        VarcharPart: Code[5];
        OldUnitCode: Code[10];
        NewUnitCode: Code[10];
        IntegerPart: Code[10];

        CountedValues: Integer;
}

