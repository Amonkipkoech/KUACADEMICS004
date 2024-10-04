report 61548 "Aca- TT Programmes"
{

    dataset
    {
        dataitem(ACAProgramme1; "ACA-Programme")
        {

            column(Code_ACAProgramme; "Code")
            {
            }
            column(Description_ACAProgramme; Description)
            {
            }
            column(Registered_ACAProgramme; Registered)
            {
            }
            column(SchoolCode_ACAProgramme; "School Code")
            {
            }

            trigger OnAfterGetRecord()
            begin
                acaProgrammes.Reset();
                acaProgrammes.SetRange("Code", ACAProgramme1."Code");
                acaProgrammes.SetRange("Time Table", true);
                if acaProgrammes.Find('-') then begin
                    repeat
                        ACASemesters.Reset();
                        ACASemesters.SetRange("Current Semester", true);
                        if ACASemesters.FindFirst() then begin
                            TTprogrammes.Reset();
                            TTprogrammes.SetRange(semester, ACASemesters."Code");
                            TTprogrammes.SetRange("Academic Year", ACASemesters."Academic Year");
                            TTprogrammes.SetRange("Programme Code", acaProgrammes."Code");
                            if not TTprogrammes.Find('-') then begin
                                TTprogrammes.Init();
                                TTprogrammes."Programme Code" := acaProgrammes."Code";
                                TTprogrammes."Prog. Name" := acaProgrammes.Description;
                                TTprogrammes.Insert(true);
                            end;
                        end;

                    until acaProgrammes.Next() = 0;
                end;
            end;
        }
    }

    var
        acaProgrammes: Record "ACA-Programme";
        TTprogrammes: Record "TT-Programmes";
        ACASemesters: Record "ACA-Semester";
}