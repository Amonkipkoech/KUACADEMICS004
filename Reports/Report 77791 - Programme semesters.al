report 77791 "Programme semesters"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Programme semesters.rdl';

    dataset
    {
        dataitem(DataItem3691; 61525)
        {
            RequestFilterFields = "Programme Code";

            trigger OnAfterGetRecord()
            begin
                //IF Prog.GET("ACA-Programme Stages"."Programme Code") THEN BEGIN
                //"ACA-Programme Stages".Department:=Prog."School Code";

                IF sem.Semester = 'SEM 2 19/20' THEN
                    sem.Current := TRUE;
                sem.MODIFY;
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
        Prog: Record 61511;
        Programme_StagesCaptionLbl: Label 'Programme Stages';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        sem: record "ACA-Programme Semesters";
}

