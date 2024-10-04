page 69026 "ACA-Marksheet Header"
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
                    IF Prog.GET(ProgrammeFilter) THEN
                        ExamCategory := Prog."Exam Category";

                    CurrPage.Marksheet.PAGE.GetExamCaption(ExamCategory);
                    CurrPage.UPDATE;

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
            field("Register For"; RegisterFor)
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    SetMatrixFilter;
                end;
            }
            field(ExamCategory; ExamCategory)
            {
                TableRelation = "ACA-Exam Category".Code;
                ApplicationArea = All;
            }
            field("Student No. Filter"; "Student No. Filter")
            {
                Caption = 'Student No. Filter';
                TableRelation = Customer;
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    SetMatrixFilter;
                end;
            }
            part(Marksheet; 69025)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        IF UserSetup.GET(USERID) THEN
            IF (UserSetup.Lecturer = FALSE) AND (UserSetup."Edit Farmer Central Setup" = FALSE) THEN ERROR('Please note that this window is only active for Deans and HODs');
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
        ExamCategory: Code[20];
        Prog: Record "ACA-Programme";
        ExamSetup: Record "ACA-Exams Setup";
        RegisterFor: Option Stage,"Unit/Subject",Supplementary;
        UserSetup: Record "User Setup";
        "Student No. Filter": Code[20];

    procedure SetMatrixFilter()
    begin
        CurrPage.Marksheet.PAGE.Load(ProgrammeFilter, StageFilter, SemesterFilter, UnitFilter, ExamCategory, RegisterFor, "Student No. Filter");
        CurrPage.UPDATE;
    end;
}

