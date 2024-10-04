page 84533 dataClean
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    InsertAllowed = false;
    DeleteAllowed = false;
    SourceTable = "ACA-Exam Results";
    SourceTableView = where(Semester = const('JAN-APR23'));
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Unit; Rec.Unit)
                {
                    ApplicationArea = All;
                }
                // }
                // field(Score; Rec.Score)
                // {
                //     ApplicationArea = All;
                // }
                // field(Semester; Rec.Semester)
                // {
                //     ApplicationArea = All;
                // }
                // field(Duplicate; Rec.Duplicate)
                // {
                //     ApplicationArea = All;
                // }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(update)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    updateDuplicates();
                end;
            }
            action(deleteAll)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    deleteWrong();
                end;
            }
            action(updateExa)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    updateExam();
                end;
            }
            // action(deleteExam)
            // {
            //     ApplicationArea = All;

            //     trigger OnAction()
            //     begin
            //         deleteWrongExam();
            //     end;
            // }
            action(updateCat)
            {
                ApplicationArea = All;
                trigger OnAction()
                begin
                    updateResultsCat();
                end;
            }
            action(updateExams)
            {
                ApplicationArea = All;
                trigger OnAction()
                begin
                    updateResultsExam();
                    ;
                end;
            }
            action(updateBoth)
            {
                ApplicationArea = All;
                trigger OnAction()
                begin
                    updateResultsBoth();
                end;
            }
        }
    }
    // trigger OnOpenPage()
    // var
    //     usersetup: Record "User Setup";
    //     Nopermission: Label 'You have insufficient Rights to access this page';
    // begin
    //     AllowAccessSettings := true;
    //     if usersetup.get(UserId) then
    //         if (usersetup."Allow Open Transcript") then begin
    //             AllowAccessSettings := usersetup."Allow Open Transcript";
    //             exit
    //         end;
    //     Error(Nopermission);
    // end;

    // var
    //     AllowAccessSettings: boolean;
    procedure updateDuplicates()
    var
        reg: Record "ACA-Course Registration";
        studUnits: Record "ACA-Student Units";
    begin
        reg.Reset();
        reg.SetRange(Semester, 'JAN-APR23');
        if reg.Find('-') then begin
            repeat
                studUnits.Reset();
                studUnits.SetRange(Stage, reg.Stage);
                studUnits.SetRange("Student No.", reg."Student No.");
                if studUnits.Find('-') then begin
                    repeat
                        studUnits.notDuplicate := true;
                        studUnits.Modify();
                    until studUnits.Next() = 0
                end;
            until reg.Next() = 0;
        end;
    end;

    procedure deleteWrong()
    var
        studUnit: Record "ACA-Student Units";
    begin
        studUnit.Reset();
        studUnit.SetRange(Semester, 'JAN-APR23');
        studUnit.SetRange(notDuplicate, false);
        if studUnit.Find('-') then begin
            studUnit.DeleteAll();
        end;

    end;

    procedure updateExam()
    var
        reg: Record "ACA-Course Registration";
        studRes: Record "ACA-Exam Results";
    begin
        reg.Reset();
        reg.SetRange(Semester, 'JAN-APR23');
        if reg.Find('-') then begin
            repeat
                studRes.Reset();
                studRes.SetRange(Stage, reg.Stage);
                studRes.SetRange("Student No.", reg."Student No.");
                if studRes.Find('-') then begin
                    repeat
                        studRes.Correct := true;
                        studRes.Modify();
                    until studRes.Next() = 0
                end;
            until reg.Next() = 0;
        end;
    end;

    procedure deleteWrongExam()
    var
        studResults: Record "ACA-Exam Results";
    begin
        studResults.Reset();
        studResults.SetRange(Semester, 'JAN-APR23');
        studResults.SetRange(Correct, false);
        if studResults.Find('-') then begin
            studResults.DeleteAll();
        end;

    end;

    procedure updateResultsCat()
    var
        examGrad: Record "ACA-Exam Grading Source";
    begin
        examGrad.Reset();
        examGrad.SetRange("Academic Year", '2022/2023');
        examGrad.SetRange("Results Exists Status", examGrad."Results Exists Status"::"CAT Only");
        if examGrad.Find('-') then begin
            repeat
                examGrad.CatMarksExist := true;
                examGrad.Modify();
            until examGrad.Next() = 0
        end;
    end;

    procedure updateResultsExam()
    var
        examGrad: Record "ACA-Exam Grading Source";
    begin
        examGrad.Reset();
        examGrad.SetRange("Academic Year", '2022/2023');
        examGrad.SetRange("Results Exists Status", examGrad."Results Exists Status"::"Exam Only");
        if examGrad.Find('-') then begin
            repeat
                examGrad.ExamMarksExist := true;
                examGrad.Modify();
            until examGrad.Next() = 0
        end;
    end;

    procedure updateResultsBoth()
    var
        examGrad: Record "ACA-Exam Grading Source";
    begin
        examGrad.Reset();
        examGrad.SetRange("Academic Year", '2022/2023');
        examGrad.SetRange("Results Exists Status", examGrad."Results Exists Status"::"Both Exists");
        if examGrad.Find('-') then begin
            repeat
                examGrad.ExamMarksExist := true;
                examGrad.CatMarksExist := true;
                examGrad.Modify();
            until examGrad.Next() = 0
        end;
    end;
}