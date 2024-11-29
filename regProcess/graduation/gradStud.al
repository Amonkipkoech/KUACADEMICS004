report 86623 "Process Graduation"
{
    //UsageCategory = ReportsAndAnalysis;
    //ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(progs; "ACA-Programme")
        {
            RequestFilterFields = Code;
            column(progCode; code)
            {

            }
            dataitem(progSem; "ACA-Programme Semesters")
            {
                RequestFilterFields = Semester;

            }
            dataitem(transcript; "Final Exam Result2")
            {

            }


            trigger OnAfterGetRecord()
            begin
                courseReg.Reset();
                courseReg.SetRange(Programmes, progs.Code);
                courseReg.SetFilter(courseReg.Semester, '%1|%2|%3', 'SEPT-DEC22', 'JAN-APR23', 'MAY-AUG23');
                if courseReg.FindFirst() then begin
                    //gradstud.DeleteAll();
                    TotalRecs := courseReg.Count;
                    RemeiningRecs := TotalRecs;
                    Progressbar.Open('#1#####################################################\' +
                       '#2############################################################\' +
                       '#3###########################################################\' +
                       '#4############################################################\' +
                       '#5###########################################################\' +
                       '#6############################################################');
                    Progressbar.Update(1, 'Processing Graduation values....');
                    Progressbar.Update(2, 'Total Recs.: ' + Format(TotalRecs));
                    repeat
                        CountedRecs := CountedRecs + 1;
                        RemeiningRecs := RemeiningRecs - 1;
                        // Create Registration Unit entry if Not Exists
                        Progressbar.Update(3, '.....................................................');
                        Progressbar.Update(4, 'Processed: ' + Format(CountedRecs));
                        Progressbar.Update(5, 'Remaining: ' + Format(RemeiningRecs));
                        Progressbar.Update(6, '----------------------------------------------------');
                        transcript.Reset();
                        transcript.SetRange(StudentID, courseReg."Student No.");
                        transcript.SetFilter(transcript.MeanGrade, '%1|%2|%3|%4|%5', 'A', 'B', 'C', 'D', 'E');
                        if transcript.FindFirst() then begin
                            studUnitsCount := transcript.Count;
                            if studUnitsCount < progs."Graduation Units" then begin
                                
                            end
                            else
                                if studUnitsCount >= progs."Graduation Units" then begin
                                    progUnits.Reset();
                                    progUnits.SetRange("Programme Code", progs.Code);
                                    progUnits.SetRange("Unit Type", progUnits."Unit Type"::Exam);
                                    if progUnits.Find('-') then begin
                                        Clear(passed);
                                        repeat
                                            transcript.Reset();
                                            transcript.SetRange(StudentID, courseReg."Student No.");
                                            transcript.SetRange(UnitCode, progUnits."Code");
                                            transcript.SetFilter(transcript.MeanGrade, '%1|%2|%3|%4|%5', 'A', 'B', 'C', 'D', 'E');
                                            if transcript.FindFirst() then begin
                                                passed := true
                                            end else
                                                passed := false;
                                        until progUnits.Next() = 0;
                                        if passed = true then begin
                                            gradstud.Reset();
                                            gradstud.SetRange(studNo, courseReg."Student No.");
                                            if not gradstud.Find('-') then begin
                                                cust.Reset();
                                                cust.SetRange("No.", courseReg."Student No.");
                                                if cust.Find('-') then begin
                                                    studname := cust.Name;
                                                end;
                                                gradstud.Init();
                                                gradstud.studNo := transcript.StudentID;
                                                gradstud.programme := transcript.ProgrammeID;
                                                gradstud.studName := studname;
                                                gradstud.unitsCount := studUnitsCount;
                                                gradstud.GradRemark := 'Meets All Core Requirements';
                                                gradstud.graduationStatus := gradstud.graduationStatus::Completed;
                                                gradstud.Semester := 'SEPT-DEC23';
                                                gradstud."Academic Year" := '2022/2023';
                                                gradstud.Insert()
                                            end
                                        end

                                    end;


                                end;



                        end;

                    until courseReg.Next() = 0;
                end;
            end;

        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field(Name; SourceExpression)
                    // {
                    //     ApplicationArea = All;

                    // }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }



    var
        courseReg: Record "ACA-Course Registration";
        CurrentSem: Record "ACA-Semester";
        studUnitsCount: Decimal;
        programme: Record "ACA-Programme";
        definGrdUnits: Decimal;
        gradstud: Record gradStudents;
        progUnits: Record "ACA-Units/Subjects";
        passed: Boolean;
        cust: Record Customer;
        studname: text[200];
        TotalRecs: Integer;
        CountedRecs: Integer;
        RemeiningRecs: Integer;
        Progressbar: Dialog;


    procedure GetCurrentSemester() Message: Text
    begin
        CurrentSem.RESET;
        CurrentSem.SETRANGE("Current Semester", TRUE);
        IF CurrentSem.FIND('-') THEN BEGIN
            Message := CurrentSem.Code;
        END;
    end;

    procedure processOne()
    begin
        courseReg.Reset();
        courseReg.SetRange(Programmes, progs.Code);
        courseReg.SetFilter(courseReg.Semester, '%1|%2|%3', 'SEPT-DEC22', 'JAN-APR23', 'MAY-AUG23');
        if courseReg.FindFirst() then begin
            //gradstud.DeleteAll();
            TotalRecs := courseReg.Count;
            RemeiningRecs := TotalRecs;
            Progressbar.Open('#1#####################################################\' +
               '#2############################################################\' +
               '#3###########################################################\' +
               '#4############################################################\' +
               '#5###########################################################\' +
               '#6############################################################');
            Progressbar.Update(1, 'Processing Graduation values....');
            Progressbar.Update(2, 'Total Recs.: ' + Format(TotalRecs));
            repeat
                CountedRecs := CountedRecs + 1;
                RemeiningRecs := RemeiningRecs - 1;
                // Create Registration Unit entry if Not Exists
                Progressbar.Update(3, '.....................................................');
                Progressbar.Update(4, 'Processed: ' + Format(CountedRecs));
                Progressbar.Update(5, 'Remaining: ' + Format(RemeiningRecs));
                Progressbar.Update(6, '----------------------------------------------------');
                transcript.Reset();
                transcript.SetRange(StudentID, courseReg."Student No.");
                transcript.SetFilter(transcript.MeanGrade, '%1|%2|%3|%4|%5', 'A', 'B', 'C', 'D', 'E');
                if transcript.FindFirst() then begin
                    studUnitsCount := transcript.Count;
                    if studUnitsCount < progs."Graduation Units" then begin
                    end
                    else
                        if studUnitsCount >= progs."Graduation Units" then begin
                            progUnits.Reset();
                            progUnits.SetRange("Programme Code", progs.Code);
                            progUnits.SetRange("Unit Type", progUnits."Unit Type"::Exam);
                            if progUnits.Find('-') then begin
                                Clear(passed);
                                repeat
                                    transcript.Reset();
                                    transcript.SetRange(StudentID, courseReg."Student No.");
                                    transcript.SetRange(UnitCode, progUnits."Code");
                                    transcript.SetFilter(transcript.MeanGrade, '%1|%2|%3|%4|%5', 'A', 'B', 'C', 'D', 'E');
                                    if transcript.FindFirst() then begin
                                        passed := true
                                    end else
                                        passed := false;
                                until progUnits.Next() = 0;
                                if passed = true then begin
                                    gradstud.Reset();
                                    gradstud.SetRange(studNo, courseReg."Student No.");
                                    if not gradstud.Find('-') then begin
                                        cust.Reset();
                                        cust.SetRange("No.", courseReg."Student No.");
                                        if cust.Find('-') then begin
                                            studname := cust.Name;
                                        end;
                                        gradstud.Init();
                                        gradstud.studNo := transcript.StudentID;
                                        gradstud.programme := transcript.ProgrammeID;
                                        gradstud.studName := studname;
                                        gradstud.unitsCount := studUnitsCount;
                                        gradstud.GradRemark := 'Meets All Core Requirements';
                                        gradstud.graduationStatus := gradstud.graduationStatus::Completed;
                                        gradstud.Semester := 'SEPT-DEC23';
                                        gradstud."Academic Year" := '2022/2023';
                                        gradstud.Insert()
                                    end
                                end

                            end;


                        end;



                end;

            until courseReg.Next() = 0;
        end;
    end;
}