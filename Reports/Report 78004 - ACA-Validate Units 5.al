report 78004 "ACA-Validate Units 5"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(StdUnits; 61549)
        {
            RequestFilterFields = Semester, "Academic Year", Programme;

            trigger OnAfterGetRecord()
            begin
                // // "ACA-Student Units".VALIDATE("ACA-Student Units".Grade);
                // // "ACA-Student Units".VALIDATE("ACA-Student Units"."Special Exam");
                StdUnits.Units := 1;
                StdUnits.MODIFY;
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

