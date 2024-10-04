report 70085 "Stages Coup"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("ACA-Programme Stages"; 61516)
        {

            trigger OnAfterGetRecord()
            begin
                IF "ACA-Programme Stages".Code = 'Y1S1' THEN BEGIN
                    "ACA-Programme Stages".Order := 1;
                END;

                IF "ACA-Programme Stages".Code = 'Y1S2' THEN BEGIN
                    "ACA-Programme Stages".Order := 2;
                END;

                IF "ACA-Programme Stages".Code = 'Y2S1' THEN BEGIN
                    "ACA-Programme Stages".Order := 3;
                END;

                IF "ACA-Programme Stages".Code = 'Y2S2' THEN BEGIN
                    "ACA-Programme Stages".Order := 4;
                END;

                IF "ACA-Programme Stages".Code = 'Y3S1' THEN BEGIN
                    "ACA-Programme Stages".Order := 5;
                END;

                IF "ACA-Programme Stages".Code = 'Y3S2' THEN BEGIN
                    "ACA-Programme Stages".Order := 6;
                END;

                IF "ACA-Programme Stages".Code = 'Y4S1' THEN BEGIN
                    "ACA-Programme Stages".Order := 7;
                END;

                IF "ACA-Programme Stages".Code = 'Y4S2' THEN BEGIN
                    "ACA-Programme Stages".Order := 8;
                END;

                IF "ACA-Programme Stages".Code = 'Y5S1' THEN BEGIN
                    "ACA-Programme Stages".Order := 9;
                END;

                IF "ACA-Programme Stages".Code = 'Y5S2' THEN BEGIN
                    "ACA-Programme Stages".Order := 10;
                END;

                IF "ACA-Programme Stages".Code = 'Y6S1' THEN BEGIN
                    "ACA-Programme Stages".Order := 11;
                END;

                IF "ACA-Programme Stages".Code = 'Y6S2' THEN BEGIN
                    "ACA-Programme Stages".Order := 12;
                END;

                "ACA-Programme Stages".MODIFY;
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

