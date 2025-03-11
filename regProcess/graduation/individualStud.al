report 86626 "Process Graduation2"
{
    //UsageCategory = ReportsAndAnalysis;
    //ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(CustNo; Customer)
        {
            RequestFilterFields = "No.";
            column(No_; "No.")
            {

            }
            // dataitem(progSem; "ACA-Programme Semesters")
            // {
            //     RequestFilterFields = Semester;

            // }
            // dataitem(progs; "ACA-Programme")
            // {
            //     RequestFilterFields = "Code";
            // }
            dataitem(transcript; "Final Exam Result2")
            {

            }


            trigger OnAfterGetRecord()
            begin
                courseReg.Reset();
                courseReg.SetRange("Student No.", CustNo."No.");
                courseReg.SetFilter(courseReg.Semester, '%1|%2|%3', 'SEPT-DEC22', 'JAN-APR23', 'MAY-AUG23');
                if courseReg.FindFirst() then begin
                    //gradstud.DeleteAll();
                    transcript.Reset();
                    transcript.SetRange(StudentID, courseReg."Student No.");
                    transcript.SetFilter(transcript.MeanGrade, '%1|%2|%3|%4|%5', 'A', 'B', 'C', 'D', 'E');
                    if transcript.FindFirst() then begin
                        studUnitsCount := transcript.Count;
                        programmes.Reset();
                        programmes.SetRange(Code, transcript.ProgrammeID);
                        if programmes.Find('-') then begin
                            maxunits := programmes."Graduation Units";
                        end;
                        if studUnitsCount < maxunits then begin
                            Error('Student Has not meet Required No of Units');
                        end
                        else
                            if studUnitsCount >= maxunits then begin
                                progUnits.Reset();
                                progUnits.SetRange("Programme Code", transcript.ProgrammeID);
                                progUnits.SetRange("Unit Type", progUnits."Unit Type"::exam);
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
                                        cust.Reset();
                                        cust.SetRange("No.", courseReg."Student No.");
                                        if cust.Find('-') then begin
                                            studname := cust.Name;
                                        end;
                                        processGrades();
                                        Message(studname + ' ' + 'Has an Average of' + ' ' + Format(avGrade, 0, 2) + ' ' + 'for Programe' + ' ' + transcript.ProgrammeID + ' ' + 'and has been classified with' + ' ' + gradRemark);
                                    end else
                                        Message('Student Failed to meet Graduation creteria');

                                end;


                            end;



                    end;


                end else
                    Error('Student is outside Defined criteria');
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
        programmes: Record "ACA-Programme";
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
        maxunits: Decimal;
        unitsCounts: Decimal;
        test: decimal;
        sumGrade: Decimal;
        sumDec: Decimal;
        avGrade: Decimal;
        examCategory: code[20];
        gradSys: Record "ACA-Exam Gradding Setup";
        gradRemark: Text[100];


    procedure GetCurrentSemester() Message: Text
    begin
        CurrentSem.RESET;
        CurrentSem.SETRANGE("Current Semester", TRUE);
        IF CurrentSem.FIND('-') THEN BEGIN
            Message := CurrentSem.Code;
        END;
    end;

    procedure processGrades()
    begin

        Clear(unitsCounts);
        transcript.Reset();
        transcript.SetRange(StudentID, courseReg."Student No.");
        transcript.SetFilter(transcript.MeanGrade, '%1|%2|%3|%4|%5|%6|%7|%8', 'A', 'B', 'C', 'D', 'E', 'F', 'FF', 'F*');
        if transcript.FindFirst() then begin
            unitsCounts := transcript.Count;
            test := 0;
            sumGrade := 0;
            repeat
                Evaluate(test, transcript.MeanScore);
                sumGrade += test;
            until transcript.Next() = 0;
            //trans.CalcSums(EVALUATE(test,trans.MeanScore));
            //unitsSum := trans.MeanScore;
            //Evaluate(sumDec, unitsSum);
            avGrade := (sumGrade / unitsCounts);
            programmes.Reset();
            programmes.SetRange(Code, transcript.ProgrammeID);
            if programmes.Find('-') then begin
                examCategory := programmes."Exam Category";
            end;
            gradSys.Reset();
            gradSys.SetRange(Category, examCategory);
            gradSys.SetFilter("Lower Limit", '<=%1', avGrade);
            gradSys.SetFilter("Upper Limit", '>=%1', avGrade);
            if gradSys.FindFirst() then begin
                gradRemark := gradSys.Remarks;

            end;
            //avGrade := (unitsSum/uni)

        end;


    end;


}