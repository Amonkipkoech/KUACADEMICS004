page 69027 "ACA-Timetable Lines"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "ACA-Units/Subjects";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Desription; Rec.Desription)
                {
                    ApplicationArea = All;
                }
                field(T1; Sc[1])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[1];
                    Visible = FieldVisible1;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // UpdateMarks(Sc[1],MATRIX_CaptionSet[1]);
                    end;
                }
                field(T2; Sc[2])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[2];
                    Visible = FieldVisible2;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // UpdateMarks(Sc[2],MATRIX_CaptionSet[2]);
                    end;
                }
                field(T3; Sc[3])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[3];
                    Visible = FieldVisible3;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //UpdateMarks(Sc[3],MATRIX_CaptionSet[3]);
                    end;
                }
                field(T4; Sc[4])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[4];
                    Visible = FieldVisible4;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // UpdateMarks(Sc[4],MATRIX_CaptionSet[4]);
                    end;
                }
                field(T5; Sc[5])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[5];
                    Visible = FieldVisible5;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //  UpdateMarks(Sc[5],MATRIX_CaptionSet[5]);
                    end;
                }
                field(T6; Sc[6])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[1];
                    Visible = FieldVisible1;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // UpdateMarks(Sc[1],MATRIX_CaptionSet[1]);
                    end;
                }
                field(T7; Sc[6])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[2];
                    Visible = FieldVisible2;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // UpdateMarks(Sc[2],MATRIX_CaptionSet[2]);
                    end;
                }
                field(T8; Sc[7])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[3];
                    Visible = FieldVisible3;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //UpdateMarks(Sc[3],MATRIX_CaptionSet[3]);
                    end;
                }
                field(T9; Sc[9])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[4];
                    Visible = FieldVisible4;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // UpdateMarks(Sc[4],MATRIX_CaptionSet[4]);
                    end;
                }
                field(T10; Sc[10])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[5];
                    Visible = FieldVisible5;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //  UpdateMarks(Sc[5],MATRIX_CaptionSet[5]);
                    end;
                }
                field(T11; Sc[11])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[1];
                    Visible = FieldVisible1;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // UpdateMarks(Sc[1],MATRIX_CaptionSet[1]);
                    end;
                }
                field(T12; Sc[12])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[2];
                    Visible = FieldVisible2;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // UpdateMarks(Sc[2],MATRIX_CaptionSet[2]);
                    end;
                }
                field(T13; Sc[13])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[3];
                    Visible = FieldVisible3;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //UpdateMarks(Sc[3],MATRIX_CaptionSet[3]);
                    end;
                }
                field(T14; Sc[14])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[4];
                    Visible = FieldVisible4;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // UpdateMarks(Sc[4],MATRIX_CaptionSet[4]);
                    end;
                }
                field(T15; Sc[15])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[5];
                    Visible = FieldVisible5;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // UpdateMarks(Sc[5],MATRIX_CaptionSet[5]);
                    end;
                }
                field(T16; Sc[16])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[1];
                    Visible = FieldVisible1;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // UpdateMarks(Sc[1],MATRIX_CaptionSet[1]);
                    end;
                }
                field(T17; Sc[17])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[2];
                    Visible = FieldVisible2;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // UpdateMarks(Sc[2],MATRIX_CaptionSet[2]);
                    end;
                }
                field(T18; Sc[18])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[3];
                    Visible = FieldVisible3;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //UpdateMarks(Sc[3],MATRIX_CaptionSet[3]);
                    end;
                }
                field(T19; Sc[19])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[4];
                    Visible = FieldVisible4;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // UpdateMarks(Sc[4],MATRIX_CaptionSet[4]);
                    end;
                }
                field(T20; Sc[20])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[5];
                    Visible = FieldVisible5;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //s UpdateMarks(Sc[5],MATRIX_CaptionSet[5]);
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        // GetExamCaption;
        Rec.RESET;
        Rec.SETFILTER("Programme Code", ProgrammeFilter);
        Rec.SETFILTER("Stage Code", StageFilter);
        Rec.SETFILTER(Code, UnitFilter);

        GetTT(Rec.Code);
        i := 0;
    end;

    var
        Sc: array[20] of Boolean;
        ProgrammeFilter: Code[20];
        StageFilter: Code[20];
        SemesterFilter: Code[20];
        UnitFilter: Code[20];
        DayFilter: Code[20];
        Type: Option Teaching,Exam;
        UnitsR: Record "ACA-Units/Subjects";
        ExamResults: Record "ACA-Exam Results";
        ProgRec: Record "ACA-Programme";
        LessonSetup: Record "ACA-Lessons";
        ExamType: Option Assignment,CAT,"Final Exam",Supplementary,Special;
        GenSetup: Record "ACA-General Set-Up";
        XxScore: Decimal;
        OriginalUser: Code[20];
        EntryDate: Date;
        ExamContrib: Decimal;
        MaxScore: Decimal;
        xxContrib: Decimal;
        Captions: Integer;
        MATRIX_CaptionSet: array[20] of Code[20];
        i: Integer;
        FieldVisible1: Boolean;
        FieldVisible2: Boolean;
        FieldVisible3: Boolean;
        FieldVisible4: Boolean;
        FieldVisible5: Boolean;
        FieldVisible6: Boolean;
        FieldVisible7: Boolean;
        FieldVisible8: Boolean;
        FieldVisible9: Boolean;
        FieldVisible10: Boolean;
        SemRec: Record "ACA-Semesters";
        LastEntry: Integer;
        TT: Record "ACA-Time Table";

    procedure Load(_ProgrammeFilter: Code[20]; _StageFilter: Code[20]; _SemesterFilter: Code[20]; _UnitFilter: Code[20]; _DayFilter: Code[20]; _Type: Option Teaching,Exam)
    begin
        ProgrammeFilter := _ProgrammeFilter;
        StageFilter := _StageFilter;
        SemesterFilter := _SemesterFilter;
        UnitFilter := _UnitFilter;
        DayFilter := _DayFilter;
        Type := _Type;
    end;

    procedure GetExamCaption(_Type: Option Teaching,Exam)
    begin
        LessonSetup.RESET;
        LessonSetup.SETRANGE(LessonSetup.Type, _Type);
        IF LessonSetup.FIND('-') THEN BEGIN
            REPEAT
                i := i + 1;
                IF i < 6 THEN
                    MATRIX_CaptionSet[i] := LessonSetup.Code;
                IF i = 1 THEN
                    FieldVisible1 := TRUE;
                IF i = 2 THEN
                    FieldVisible2 := TRUE;
                IF i = 3 THEN
                    FieldVisible3 := TRUE;
                IF i = 4 THEN
                    FieldVisible4 := TRUE;
                IF i = 5 THEN
                    FieldVisible5 := TRUE;
                IF i = 6 THEN
                    FieldVisible6 := TRUE;
                IF i = 7 THEN
                    FieldVisible7 := TRUE;
                IF i = 8 THEN
                    FieldVisible8 := TRUE;
                IF i = 9 THEN
                    FieldVisible9 := TRUE;
                IF i = 10 THEN
                    FieldVisible10 := TRUE;


            UNTIL LessonSetup.NEXT = 0;
        END;
    end;

    procedure UpdateMarks(Allocate: Boolean; UnitCode: Code[20]; LessonCode: Code[20]; ProgCode: Code[20]; StagCode: Code[20]; SemCode: Code[20]; CampusCode: Code[20]; TypeCode: Option Teaching,Exam)
    begin
        IF ProgrammeFilter = '' THEN
            ERROR('You must specify the Programme filter.');

        IF StageFilter = '' THEN
            ERROR('You must specify the Stage filter');

        IF UnitFilter = '' THEN
            ERROR('You must specify the Unit filter.');

        IF SemesterFilter = '' THEN
            ERROR('You must specify the semester filter.');
    end;

    procedure GetTT(UnitCode: Code[20])
    begin

        FOR i := 1 TO 20 DO BEGIN
            // Sc[i]:=FALSE;
            TT.RESET;
            TT.SETRANGE(TT.Programme, ProgrammeFilter);
            TT.SETRANGE(TT.Stage, StageFilter);
            TT.SETRANGE(TT.Semester, SemesterFilter);
            TT.SETRANGE(TT.Unit, UnitCode);
            TT.SETRANGE(TT."Day of Week", DayFilter);
            TT.SETRANGE(TT.Period, MATRIX_CaptionSet[i]);
            IF TT.FIND('-') THEN
                // error(UnitCode+','+MATRIX_CaptionSet[i])
                Sc[i] := TRUE
            ELSE
                Sc[i] := FALSE;

        END;
    end;
}

