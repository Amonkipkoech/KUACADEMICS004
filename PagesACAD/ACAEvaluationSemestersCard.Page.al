page 65253 "ACA-Evaluation Semesters Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Card;
    SourceTable = "ACA-Semesters";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {
                    Editable = true;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
            }
            part("Evaluation Questions"; "ACA-Lecture Eval. Questions")
            {
                SubPageLink = Semester = FIELD(Code);
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Rep)
            {
                Caption = 'Evaluation Report';
                Image = Statistics1099;
                Promoted = true;
                ApplicationArea = All;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    ACALecturersEvaluation.RESET;
                    ACALecturersEvaluation.SETRANGE(Semester, Rec.Code);
                    IF ACALecturersEvaluation.FIND('-') THEN BEGIN
                        REPORT.RUN(65251, TRUE, FALSE, ACALecturersEvaluation);
                    END;
                end;
            }
            action(EvSumm)
            {
                Caption = 'Evaluation Summary';
                Image = Aging;
                Promoted = true;
                ApplicationArea = All;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    ACALecturersEvaluation.RESET;
                    ACALecturersEvaluation.SETRANGE(Semester, Rec.Code);
                    IF ACALecturersEvaluation.FIND('-') THEN BEGIN
                        REPORT.RUN(65252, TRUE, FALSE, ACALecturersEvaluation);
                    END;
                end;
            }
        }
    }

    var
        ACALecturersEvaluation: Record "ACA-Lecturers Evaluation";
}

