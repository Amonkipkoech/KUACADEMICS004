report 70096 "Update Student Course Units"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Update Student Course Units.rdl';

    dataset
    {
        dataitem("ACA-Units/Subjects"; 61517)
        {
            dataitem("ACA-Student Units"; 61549)
            {
                DataItemLink = Programme = FIELD("Programme Code"),
                               Unit = FIELD(Code);

                trigger OnAfterGetRecord()
                begin
                    IF "ACA-Student Units".Units = 0 THEN BEGIN
                        "ACA-Student Units".Units := "ACA-Units/Subjects"."No. Units";
                        "ACA-Student Units".MODIFY;
                    END;
                end;
            }
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

