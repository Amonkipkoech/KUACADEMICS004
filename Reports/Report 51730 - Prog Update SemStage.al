report 51730 "Prog Update Sem/Stage"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Prog Update SemStage.rdl';

    dataset
    {
        dataitem(DataItem1102755000; 61511)
        {
            column(PC; Code)
            {
            }
            column(PD; Description)
            {
            }

            trigger OnAfterGetRecord()
            begin

                IF Prog.FIND(Code) THEN BEGIN
                    //REPEAT

                    ProgStage.INIT;
                    ProgStage."Programme Code" := Prog.Code;
                    ProgStage.Code := 'Y1S1';
                    ProgStage.Description := 'Year 1 Semester1';
                    ProgStage.Remarks := 'Pass, Proceed to Second Year';
                    ProgStage.INSERT;
                    ProgStage.INIT;
                    ProgStage."Programme Code" := Prog.Code;
                    ProgStage.Code := 'Y1S2';
                    ProgStage.Description := 'Year 1 Semester2';
                    ProgStage.Remarks := 'Pass, Proceed to Second Year';
                    ProgStage.INSERT;
                    ProgStage.INIT;
                    ProgStage."Programme Code" := Prog.Code;
                    ProgStage.Code := 'Y2S1';
                    ProgStage.Description := 'Year 2 Semester1';
                    ProgStage.Remarks := 'Pass, Proceed to Third Year';
                    ProgStage.INSERT;

                    ProgStage.INIT;
                    ProgStage."Programme Code" := Prog.Code;
                    ProgStage.Code := 'Y2S2';
                    ProgStage.Description := 'Year 2 Semester2';
                    ProgStage.Remarks := 'Pass, Proceed to Third Year';
                    ProgStage.INSERT;
                    ProgStage.INIT;
                    ProgStage."Programme Code" := Prog.Code;
                    ProgStage.Code := 'Y3S1';
                    ProgStage.Description := 'Year 3 Semester1';
                    ProgStage.Remarks := 'Pass, Proceed to Forth Year';
                    ProgStage.INSERT;

                    ProgStage.INIT;
                    ProgStage."Programme Code" := Prog.Code;
                    ProgStage.Code := 'Y3S2';
                    ProgStage.Description := 'Year 3 Semester2';
                    ProgStage.Remarks := 'Pass, Proceed to Second Year';
                    ProgStage.INSERT;

                    ProgStage.INIT;
                    ProgStage."Programme Code" := Prog.Code;
                    ProgStage.Code := 'Y4S1';
                    ProgStage.Description := 'Year 4 Semester1';
                    ProgStage.Remarks := 'Pass ';
                    ProgStage.INSERT;

                    ProgStage.INIT;
                    ProgStage."Programme Code" := Prog.Code;
                    ProgStage.Code := 'Y4S2';
                    ProgStage.Description := 'Year 4 Semester2';
                    ProgStage.Remarks := 'Pass ';
                    ProgStage.INSERT;

                    ProgSem.INIT;
                    ProgSem."Programme Code" := Prog.Code;
                    ProgSem.Semester := 'Sem1 09/10';
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem.Semester := 'Sem2 09/10';
                    ProgSem."Programme Code" := Prog.Code;
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem.Semester := 'Sem1 10/11';
                    ProgSem."Programme Code" := Prog.Code;
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem.Semester := 'Sem2 10/11';
                    ProgSem."Programme Code" := Prog.Code;
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem.Semester := 'Sem1 11/12';
                    ProgSem."Programme Code" := Prog.Code;
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem.Semester := 'Sem2 11/12';
                    ProgSem."Programme Code" := Prog.Code;
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem.Semester := 'Sem1 12/13';
                    ProgSem."Programme Code" := Prog.Code;
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem.Semester := 'Sem2 12/13';
                    ProgSem."Programme Code" := Prog.Code;
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem.Semester := 'Sem1 13/14';
                    ProgSem."Programme Code" := Prog.Code;
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem.Semester := 'Sem2 13/14';
                    ProgSem."Programme Code" := Prog.Code;
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem.Semester := 'Sem1 14/15';
                    ProgSem."Programme Code" := Prog.Code;
                    ProgSem.Semester := 'Sem1 14/15';
                    ProgSem.INSERT;
                    //UNTIL Prog.NEXT=0;
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
        Prog: Record 61511;
        ProgSem: Record 61525;
        ProgStage: Record 61516;
}

