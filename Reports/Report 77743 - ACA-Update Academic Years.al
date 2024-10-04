report 77743 "ACA-Update Academic Years"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(CReg; "ACA-Course Registration")
        {

            trigger OnAfterGetRecord()
            begin
                IF CReg.Semester <> '' THEN BEGIN
                    ACASemesters.RESET;
                    ACASemesters.SETRANGE(Code, CReg.Semester);
                    IF ACASemesters.FIND('-') THEN BEGIN
                        // //    IF CReg.RENAME(CReg.Programme,CReg.Stage,CReg.Unit,CReg.Semester,
                        // //    CReg."Reg. Transacton ID",CReg."Student No.",CReg.ENo,ACASemesters."Academic Year") THEN;
                        CReg."Academic Year" := ACASemesters."Academic Year";
                        CReg.MODIFY;
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
        ACASemesters: Record 61692;
}

