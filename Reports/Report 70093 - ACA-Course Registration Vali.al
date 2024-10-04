report 70093 "ACA-Course Registration Vali"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Creg; 61532)
        {

            trigger OnAfterGetRecord()
            begin
                ACASemesters.RESET;
                ACASemesters.SETRANGE(ACASemesters.Code, Creg.Semester);
                IF ACASemesters.FIND('-') THEN
                    Creg."Academic Year" := ACASemesters."Academic Year";
                Creg.VALIDATE(Creg.Stage);
                Creg.MODIFY;
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
        ACASemesters: Record 61692;
}

