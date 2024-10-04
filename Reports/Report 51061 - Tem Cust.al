report 51061 "Tem Cust"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("ACA-Tem Stud"; 61015)
        {

            trigger OnAfterGetRecord()
            begin
                Nm := "ACA-Tem Stud".Nm1;
                IF "ACA-Tem Stud".Nm2 <> '' THEN
                    Nm := Nm + ' ' + "ACA-Tem Stud".Nm2;
                IF "ACA-Tem Stud".Nm3 <> '' THEN
                    Nm := Nm + ' ' + "ACA-Tem Stud".Nm3;

                IF Cust.GET("ACA-Tem Stud".No) THEN BEGIN
                    IF Nm <> '' THEN BEGIN
                        Cust.Name := Nm;
                        Cust.MODIFY;
                    END;
                END;
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
        Cust: Record 18;
        Nm: Text[100];
}

