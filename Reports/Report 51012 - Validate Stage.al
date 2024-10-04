report 51012 "Validate Stage"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(AC; 61758)
        {
            DataItemTableView = WHERE("Clearance Level Code" = FILTER('HOD'));

            trigger OnAfterGetRecord()
            begin
                clearDept.RESET;
                clearDept.SETRANGE(clearDept."Clearance Level Code", AC."Clearance Level Code");
                clearDept.SETRANGE(clearDept.Department, AC.Department); //
                IF clearDept.FIND('-') THEN BEGIN //Clearance Level Code,Department,Student ID,Clear By ID
                    REPEAT
                    BEGIN
                        IF NOT (ClearLedgers.GET(AC."Clearance Level Code", AC.Department,
                        AC."Student ID", clearDept."Clear By Id")) THEN BEGIN
                            ClearLedgers.INIT;
                            ClearLedgers."Clearance Level Code" := AC."Clearance Level Code";
                            ClearLedgers.Department := AC.Department;
                            ClearLedgers."Student ID" := AC."Student ID";
                            ClearLedgers."Clear By ID" := clearDept."Clear By Id";
                            ClearLedgers."Initiated By" := AC."Initiated By";
                            ClearLedgers."Initiated Date" := AC."Initiated Date";
                            ClearLedgers."Initiated Time" := AC."Initiated Time";
                            ClearLedgers."Last Date Modified" := AC."Last Date Modified";
                            ClearLedgers."Last Time Modified" := AC."Last Time Modified";
                            ClearLedgers."Student Intake" := AC."Student Intake";
                            ClearLedgers."Priority Level" := AC."Priority Level";
                            ClearLedgers."Academic Year" := AC."Academic Year";
                            ClearLedgers.Semester := AC.Semester;
                            ClearLedgers.Status := AC.Status;
                            ClearLedgers.INSERT();
                        END;
                    END;
                    UNTIL clearDept.NEXT = 0;
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
        ClearLedgers: Record 61758;
        clearTemps: Record 61755;
        clearDept: Record 61756;
}

