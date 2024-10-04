page 86625 "Graduation Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = gradStudents;

    layout
    {
        area(Content)
        {
            group("Graduating Class")
            {
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;

                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }

            }
            part(gradStud; "Process Graduation")
            {
                Caption = 'Graduating Students';
                SubPageLink = "Academic Year" = FIELD("Academic Year");
                UpdatePropagation = Both;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Process Graduation")
            {
                ApplicationArea = All;
                image = Process;
                RunObject = report "Process Graduation";
            }
            action("Process Graduation Individual")
            {
                ApplicationArea = All;
                image = Process;
                RunObject = report "Process Graduation2";
            }
            action("Graduation Classification")
            {
                ApplicationArea = All;
                image = Timeline;
                trigger OnAction()
                begin
                    processGrades();
                end;
            }
            action("Provisional Transcript")
            {
                ApplicationArea = All;
                image = Timeline;
                RunObject = report "Final Graduation Transcript2";

            }
        }
    }

    var
        trans: record "Final Exam Result2";
        gradstu: Record gradStudents;
        unitsCounts: Decimal;
        unitsSum: Code[10];
        sumDec: Decimal;
        avGrade: Decimal;
        progs: Record "ACA-Programme";
        examCategory: code[20];
        gradSys: Record "ACA-Exam Gradding Setup";
        test: decimal;
        sumGrade: Decimal;

    procedure processGrades()
    begin
        gradstu.Reset();
        gradstu.SetRange(graduationStatus, gradstu.graduationStatus::Completed);
        if gradstu.Find('-') then begin
            repeat
                Clear(unitsCounts);
                trans.Reset();
                trans.SetRange(StudentID, gradstu.studNo);
                trans.SetFilter(trans.MeanGrade, '%1|%2|%3|%4|%5|%6|%7|%8|%9|%10|%11|%12|%13', 'A', 'B', 'C', 'D', 'E', 'F', 'FF', 'F*', 'A*', 'B*', 'C*', 'D*', 'EX');
                if trans.FindFirst() then begin
                    unitsCounts := trans.Count;
                    test := 0;
                    sumGrade := 0;
                    repeat
                        Evaluate(test, trans.MeanScore);
                        sumGrade += test;
                    until trans.Next() = 0;
                    //trans.CalcSums(EVALUATE(test,trans.MeanScore));
                    //unitsSum := trans.MeanScore;
                    //Evaluate(sumDec, unitsSum);
                    avGrade := (sumGrade / unitsCounts);
                    progs.Reset();
                    progs.SetRange(Code, trans.ProgrammeID);
                    if progs.Find('-') then begin
                        examCategory := progs."Exam Category";
                    end;
                    gradstu."Average Grade" := avGrade;
                    gradstu.Modify();
                    gradSys.Reset();
                    gradSys.SetRange(Category, examCategory);
                    gradSys.SetFilter("Lower Limit", '<=%1', avGrade);
                    gradSys.SetFilter("Upper Limit", '>=%1', avGrade);
                    if gradSys.FindFirst() then begin
                        gradstu."Graduating Grade" := gradSys.Remarks;
                        gradstu.Modify();
                    end;
                    //avGrade := (unitsSum/uni)

                end;

            until gradstu.Next() = 0;
        end;
    end;

}