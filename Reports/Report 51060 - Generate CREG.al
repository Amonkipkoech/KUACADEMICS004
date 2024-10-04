report 51060 "Generate CREG"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("ACA-Temp Stud Prog"; 61014)
        {
            RequestFilterFields = Prog, "Code";
            column(Code_TempStudProg; "ACA-Temp Stud Prog".Code)
            {
            }
            column(Prog_TempStudProg; "ACA-Temp Stud Prog".Prog)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF OldProg.GET("ACA-Temp Stud Prog".Prog) THEN BEGIN
                    OldProg.CALCFIELDS(OldProg."New Code FK");
                    IF TempStage.GET("ACA-Temp Stud Prog".Prog) THEN BEGIN
                        Creg.INIT;
                        Creg."Reg. Transacton ID" := 'A0001';
                        Creg."Student No." := "ACA-Temp Stud Prog".Code;
                        Creg.Programmes := OldProg."New Code";
                        Creg.Semester := 'SEM1 15/16';
                        Creg.Stage := TempStage.Stage;
                        Creg."Settlement Type" := 'SSP';
                        Creg."Registration Date" := TODAY;
                        Creg.Remarks := TempStage.Remarks;
                        Creg."General Remark" := TempStage.Remarks;
                        Creg.INSERT;
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
        Creg: Record 61532;
        OldProg: Record 61012;
        TempStage: Record 61013;
}

