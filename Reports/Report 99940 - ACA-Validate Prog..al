report 99940 "ACA-Validate Prog."
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Unitsz; 61517)
        {

            trigger OnAfterGetRecord()
            begin
                /*IF acaProg.Category = acaProg.Category::Diploma THEN BEGIN
                    acaProg."Exam Category":='DIP';
                  END ELSE IF acaProg.Category = acaProg.Category::Undergraduate THEN BEGIN
                    acaProg."Exam Category":='DEFAULT';
                  END ELSE IF acaProg.Category = acaProg.Category::Postgraduate THEN BEGIN
                    acaProg."Exam Category":='PG';
                  END ELSE IF ((acaProg.Category = acaProg.Category::Certificate) OR
                    (acaProg.Category = acaProg.Category::"Course List") OR
                    (acaProg.Category = acaProg.Category::Professional)) THEN BEGIN
                    acaProg."Exam Category":='CERT';
                  END;
                  acaProg.MODIFY;
                acaProg.VALIDATE("Exam Category");
                */
                Unitsz.VALIDATE("Default Exam Category");
                Unitsz.MODIFY;

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

