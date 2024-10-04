page 69028 "ACA-Timetable Header"
{

    layout
    {
        area(content)
        {
            field(ProgrammeFilter; ProgrammeFilter)
            {
                Caption = 'Programme Filter';
                TableRelation = "ACA-Programme".Code;
                ApplicationArea = All;

                trigger OnValidate()
                begin


                    SetMatrixFilter;
                end;
            }
            field(StageFilter; StageFilter)
            {
                Caption = 'Stage Filter';
                TableRelation = "ACA-Programme Stages".Code;
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    SetMatrixFilter;
                end;
            }
            field(SemesterFilter; SemesterFilter)
            {
                Caption = 'Semester Filter';
                TableRelation = "ACA-Programme Semesters".Semester;
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    SetMatrixFilter;
                end;
            }
            field(UnitFilter; UnitFilter)
            {
                Caption = 'Unit Filter';
                TableRelation = "ACA-Units/Subjects".Code;
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    SetMatrixFilter;
                end;
            }
            field("Day Filter"; DayFilter)
            {
                TableRelation = "ACA-Day Of Week".Day;
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    SetMatrixFilter;
                end;
            }
            field(Type; Type)
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    CurrPage.Marksheet.PAGE.GetExamCaption(Type);
                    CurrPage.UPDATE;
                end;
            }
            part(Marksheet; 69027)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.Marksheet.PAGE.GetExamCaption(Type);
        CurrPage.UPDATE;
    end;

    trigger OnOpenPage()
    begin
        SetMatrixFilter;
    end;

    var
        ExamHeader: Integer;
        ProgrammeFilter: Code[20];
        StageFilter: Code[20];
        SemesterFilter: Code[20];
        UnitFilter: Code[20];
        StudUnits: Record "ACA-Student Units";
        DayFilter: Code[20];
        Type: Option Teaching,Exam;
        Prog: Record "ACA-Programme";
        ExamSetup: Record "ACA-Exams Setup";

    procedure SetMatrixFilter()
    begin
        CurrPage.Marksheet.PAGE.Load(ProgrammeFilter, StageFilter, SemesterFilter, UnitFilter, DayFilter, Type);
        CurrPage.UPDATE;
    end;
}

