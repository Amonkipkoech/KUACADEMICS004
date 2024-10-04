report 51861 "ACA-Units/Subjects proc"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("ACA-Units/Subjects"; "ACA-Units/Subjects")
        {
            DataItemTableView = WHERE("Credit Hours" = FILTER(0));

            trigger OnAfterGetRecord()
            begin
                // // CLEAR(strLenths);
                // // CLEAR(CurrPos);
                // // CLEAR(NewStr);
                // // IF "ACA-Units/Subjects".Desription<>'' THEN BEGIN
                // //  strLenths:=STRLEN("ACA-Units/Subjects".Desription);
                // //  REPEAT
                // //    BEGIN
                // //    CurrPos:=CurrPos+1;
                // //    IF (COPYSTR("ACA-Units/Subjects".Desription,CurrPos,1))<>',' THEN NewStr:=NewStr+(COPYSTR("ACA-Units/Subjects".Desription,CurrPos,1));
                // //    END;
                // //    UNTIL CurrPos=strLenths;
                // // END;
                "ACA-Units/Subjects"."Credit Hours" := 1;
                "ACA-Units/Subjects".MODIFY;
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
        strLenths: Integer;
        CurrPos: Integer;
        NewStr: Code[150];
}

