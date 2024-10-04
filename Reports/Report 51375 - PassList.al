report 51375 PassList
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/PassList.rdl';

    dataset
    {
        dataitem(Customer; 18)
        {
            RequestFilterFields = "Programme Filter", "Stage Filter";
            column(Customer__No__; "No.")
            {
            }
            column(Ref; Ref)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Pass := 'True';
                TotalUnits := 0;
                UnitsRec.SETFILTER(UnitsRec."Student No.", Customer."No.");
                UnitsRec.SETFILTER(UnitsRec.Stage, Customer.GETFILTER(Customer."Stage Filter"));
                IF UnitsRec.FIND('-') THEN BEGIN
                    REPEAT
                        TotalUnits := TotalUnits + 1;
                    //IF UnitsRec."Total Marks"<40 THEN Pass:='False';
                    UNTIL UnitsRec.NEXT = 0;
                END
                ELSE
                    Pass := 'False';
                IF TotalUnits < 14 THEN Pass := 'False';
                IF Pass = 'True' THEN Ref := Ref + 1 ELSE CurrReport.SKIP;

                //IF Pass='true' THEN
                //BEGIN
                //UnitsRec.RESET;
                //UnitsRec.SETFILTER(UnitsRec."Student No.",Customer."No.");
                //UnitsRec.SETFILTER(UnitsRec.Stage,"Course Registration".GETFILTER("Course Registration".Stage));
                IF UnitsRec.FIND('-') THEN
                    REPEAT
                        //Units:=Units+UnitsRec.Unit;
                        IF UnitsRec."Total Marks" < 40 THEN;//PassFail:=PassFail+'Fail' ELSE PassFail:=PassFail+'Pass';
                    UNTIL UnitsRec.NEXT = 0;
                //END;
            end;

            trigger OnPreDataItem()
            begin
                Units := '';
                PassFail := '';
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
        Ref: Integer;
        UnitsRec: Record 61549;
        Units: Text[250];
        PassFail: Text[30];
        Pass: Text[30];
        TotalUnits: Integer;
}

