report 70097 "ACA-Clean Std Units"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/ACA-Clean Std Units.rdl';

    dataset
    {
        dataitem(StudUnits; "ACA-Student Units")
        {
            DataItemTableView = WHERE(Semester = FILTER(<> 'SEM 3 18/19' & <> 'SEM 2 19/20' & <> 'SEM 1 19/20'));

            trigger OnAfterGetRecord()
            begin
                StudUnits.CALCFIELDS("Marks Exists");
                IF StudUnits."Marks Exists" = FALSE THEN StudUnits.DELETE;
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

}

