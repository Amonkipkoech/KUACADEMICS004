page 69025 "ACA-Marksheet Lines"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "ACA-Student Units";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Total Score"; Rec."Total Score")
                {
                    ApplicationArea = All;
                }
                field("Cancelled Score"; Rec."Cancelled Score")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Unit; Rec.Unit)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(EXAM; Sc[1])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[1];
                    Caption = 'Exam';
                    Visible = FieldVisible1;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        UpdateMarks(Sc[1], MATRIX_CaptionSet[1]);
                    end;
                }
                field(CAT1; Sc[2])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[2];
                    Caption = 'CAT1';
                    Visible = FieldVisible2;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        UpdateMarks(Sc[2], MATRIX_CaptionSet[2]);
                    end;
                }
                field(CAT2; Sc[3])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[3];
                    Caption = 'CAT2';
                    Visible = FieldVisible3;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        UpdateMarks(Sc[3], MATRIX_CaptionSet[3]);
                    end;
                }
                field(CAT3; Sc[4])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[4];
                    Caption = 'CAT3';
                    Visible = FieldVisible4;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        UpdateMarks(Sc[4], MATRIX_CaptionSet[4]);
                    end;
                }
                field(CAT4; Sc[5])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[5];
                    Caption = 'CAT4';
                    Visible = FieldVisible5;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        UpdateMarks(Sc[5], MATRIX_CaptionSet[5]);
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
        Rec.SETFILTER(Programme, ProgrammeFilter);
        Rec.SETFILTER(Stage, StageFilter);
        Rec.SETFILTER(Semester, SemesterFilter);
        Rec.SETFILTER(Unit, UnitFilter);
        Rec.SETFILTER("Student No.", "Student No Filter");
        Rec.CALCFIELDS("Exam Marks");
        Rec.CALCFIELDS("CAT Total Marks");

        FOR i := 1 TO 5 DO BEGIN
            IF MATRIX_CaptionSet[i] = 'EXAM' THEN
                Sc[i] := Rec."Exam Marks";
            IF MATRIX_CaptionSet[i] = 'CAT' THEN
                Sc[i] := Rec."CAT Total Marks";
        END;
        i := 0;
    end;

    var
        Sc: array[5] of Decimal;
        ProgrammeFilter: Code[20];
        StageFilter: Code[20];
        SemesterFilter: Code[20];
        UnitFilter: Code[20];
        ExamCategory: Code[20];
        "Student No Filter": Code[20];
        UnitsR: Record "ACA-Units/Subjects";
        ExamResults: Record "ACA-Exam Results";
        ProgRec: Record "ACA-Programme";
        ExamsSetup: Record "ACA-Exams Setup";
        ExamType: Option Assignment,CAT,"Final Exam",Supplementary,Special;
        GenSetup: Record "ACA-General Set-Up";
        XxScore: Decimal;
        OriginalUser: Code[20];
        EntryDate: Date;
        ExamContrib: Decimal;
        MaxScore: Decimal;
        xxContrib: Decimal;
        Captions: Integer;
        MATRIX_CaptionSet: array[5] of Code[20];
        i: Integer;
        FieldVisible1: Boolean;
        FieldVisible2: Boolean;
        FieldVisible3: Boolean;
        FieldVisible4: Boolean;
        FieldVisible5: Boolean;
        SemRec: Record "ACA-Semesters";
        LastEntry: Integer;
        RegisterFor: Option Stage,"Unit/Subject",Supplementary;

    procedure Load(_ProgrammeFilter: Code[20]; _StageFilter: Code[20]; _SemesterFilter: Code[20]; _UnitFilter: Code[20]; _ExamCategory: Code[20]; _RegisterFor: Option Stage,"Unit/Subject",Supplementary; "_Student No": Code[20])
    begin
        ProgrammeFilter := _ProgrammeFilter;
        StageFilter := _StageFilter;
        SemesterFilter := _SemesterFilter;
        UnitFilter := _UnitFilter;
        ExamCategory := _ExamCategory;
        RegisterFor := _RegisterFor;
        "Student No Filter" := "_Student No";
    end;

    procedure GetExamCaption(_ExamCategory: Code[20])
    begin
        ExamsSetup.RESET;
        ExamsSetup.SETRANGE(ExamsSetup.Category, _ExamCategory);
        IF ExamsSetup.FIND('-') THEN BEGIN
            REPEAT
                i := i + 1;
                IF i < 6 THEN
                    MATRIX_CaptionSet[i] := ExamsSetup.Code;
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

            UNTIL ExamsSetup.NEXT = 0;
        END;
    end;

    procedure UpdateMarks(Score: Decimal; MarksType: Code[20])
    begin
        IF ProgrammeFilter = '' THEN
            ERROR('You must specify the Programme filter.');

        IF StageFilter = '' THEN
            ERROR('You must specify the Stage filter');

        IF UnitFilter = '' THEN
            ERROR('You must specify the Unit filter.');


        IF SemesterFilter = '' THEN
            ERROR('You must specify the semester filter.');

        SemRec.GET(SemesterFilter);
        IF MarksType = 'EXAM' THEN
            IF SemRec."Lock CAT Editting" = TRUE THEN
                ERROR('Please note that editting of Exam Marks for the selected period has been locked')
            ELSE
                IF SemRec."Lock CAT Editting" = TRUE THEN ERROR('Please note that editting of CAT Marks for the selected period has been locked');
        IF SemRec."Lock Lecturer Editing" = TRUE THEN ERROR('Please note editing of marks can be done by HOD or the Dean');

        //IF PeriodCode='' THEN
        //ERROR('You must specify the Exam Period.');

        UnitsR.RESET;
        UnitsR.SETRANGE(UnitsR."Programme Code", ProgrammeFilter);
        UnitsR.SETRANGE(UnitsR.Code, UnitFilter);
        IF UnitsR.FIND('-') THEN BEGIN
            IF UnitsR.Submited = TRUE THEN
                ERROR('The marks have already been submited.');
        END;

        //MESSAGE(FORMAT(score));
        IF Score < 0 THEN ERROR('Marks Can Not be Less than Zero');
        ExamsSetup.RESET;
        ExamsSetup.SETFILTER(ExamsSetup.Category, Rec.GETFILTER(Category));
        ExamsSetup.SETRANGE(ExamsSetup.Code, MarksType);
        IF ExamsSetup.FIND('-') THEN BEGIN
            IF Score > ExamsSetup."Max. Score" THEN
                ERROR('You Cant Enter Score Above The Maximum Score. The Maximum Score is ' + FORMAT(ExamsSetup."Max. Score"));
            IF ExamsSetup.Type = ExamsSetup.Type::Supplementary THEN BEGIN
                IF Rec."Allow Supplementary" = FALSE THEN
                    ERROR('Student not allowed to sit supplementary.');
            END;
        END;






        /*/////////////Comment checks
        
        ExamsSetup.RESET;
        ExamsSetup.SETRANGE(ExamsSetup.Category,GETFILTER(Category));
        ExamsSetup.SETRANGE(ExamsSetup.Code,CurrForm.Matrix.MatrixRec.Code);
        IF ExamsSetup.FIND('-') THEN BEGIN
        IF ExamsSetup.Type = ExamsSetup.Type::"Final Exam" THEN BEGIN
        //Check Fee Bal
        IF Cust.GET("Student No.") THEN BEGIN
        Cust.CALCFIELDS(Cust."Balance (LCY)");
        IF Cust."Balance (LCY)" > 0 THEN
        ERROR('Student has a fee balance.');
        
        //Check if CAT done
        Exams.RESET;
        Exams.SETRANGE(Exams.Category,ExamCategory);
        Exams.SETRANGE(Exams.Type,Exams.Type::CAT);
        IF Exams.FIND('-') THEN BEGIN
        REPEAT
        EResults.RESET;
        EResults.SETRANGE(EResults."Student No.","Student No.");
        EResults.SETRANGE(EResults.Programme,Programme);
        EResults.SETRANGE(EResults.Unit,Unit);
        EResults.SETRANGE(EResults.Semester,GETFILTER("Semester Filter"));
        EResults.SETRANGE(EResults.Exam,Exams.Code);
        EResults.SETFILTER(EResults.Score,'>0');
        IF EResults.FIND('-') = FALSE THEN
        ERROR('%1 not done.',Exams.Desription);
        
        
        UNTIL Exams.NEXT = 0;
        END;
        
        
        END;
        
        UnitsR.RESET;
        UnitsR.SETRANGE(UnitsR."Programme Code",Programme);
        UnitsR.SETRANGE(UnitsR.Code,Unit);
        IF UnitsR.FIND('-') THEN BEGIN
        IF UnitsR."Credit Hours" > 0 THEN BEGIN
        IF Attendance < (0.75*UnitsR."Credit Hours") THEN
        ERROR('Student attendance less than the minimum required (75 Percent).');
        END;
        END;
        END;
        
        IF Score > ExamsSetup."Max. Score" THEN
        ERROR('You cant enter score above the maximum score.');
        IF ExamsSetup.Type = ExamsSetup.Type::Supplementary THEN BEGIN
        IF "Allow Supplementary" = FALSE THEN
        ERROR('Student not allowed to sit supplementary.');
        END;
        END;
        
        
        
        IF (GETFILTER("Exam Type") ='SPECIAL') OR (GETFILTER("Exam Type") ='SUPPLEMENTARY') THEN
        IF CurrForm.Matrix.MatrixRec.Code<> 'EXAM' THEN
        ERROR('Please note that CAT is not allowed for SPECIAL and SUPPLEMENTARY Exams ');
        */
        ProgRec.GET(Rec.Programme);
        ProgRec.TESTFIELD(ProgRec."Exam Category");
        ExamsSetup.RESET;
        ExamsSetup.SETFILTER(ExamsSetup.Category, ProgRec."Exam Category");
        ExamsSetup.SETRANGE(ExamsSetup.Code, MarksType);
        IF ExamsSetup.FIND('-') THEN BEGIN
            ExamType := ExamsSetup.Type;
            MaxScore := ExamsSetup."Max. Score";
            ExamContrib := ExamsSetup."% Contrib. Final Score";
        END;


        OriginalUser := USERID;
        ExamResults.RESET;
        //ExamResults.SETRANGE(ExamResults."Reg. Transaction ID","Reg. Transacton ID");
        ExamResults.SETRANGE(ExamResults."Student No.", Rec."Student No.");
        ExamResults.SETRANGE(ExamResults.Programmes, Rec.Programme);
        ExamResults.SETRANGE(ExamResults.Stage, Rec.Stage);
        ExamResults.SETRANGE(ExamResults.Unit, Rec.Unit);
        ExamResults.SETRANGE(ExamResults.Semester, SemesterFilter);
        ExamResults.SETRANGE(ExamResults.ExamType, MarksType);
        IF ExamResults.FIND('-') THEN BEGIN
            REPEAT
                XxScore := ExamResults.Score;
                xxContrib := (XxScore * ExamContrib) / MaxScore;
                OriginalUser := ExamResults.UserID;
                ExamResults.Cancelled := TRUE;
                ExamResults."Cancelled By" := USERID;
                ExamResults."Cancelled Date" := TODAY;
                ExamResults.MODIFY;
            UNTIL ExamResults.NEXT = 0;
        END;

        ExamResults.RESET;
        IF ExamResults.FIND('-') THEN
            LastEntry := ExamResults.COUNT;

        ExamResults.INIT;
        ExamResults."Reg. Transaction ID" := Rec."Reg. Transacton ID";
        ExamResults."Student No." := Rec."Student No.";
        ExamResults.Programmes := Rec.Programme;
        ExamResults.Stage := Rec.Stage;
        ExamResults.Unit := Rec.Unit;
        ExamResults.Semester := SemesterFilter;
        ExamResults.Score := Score;
        ExamResults.Exam := FORMAT(MarksType);
        ExamResults.ExamType := MarksType;
        ExamResults.Category := ExamCategory;
        //ExamResults.VALIDATE(ExamResults.Score);
        ExamResults.Contribution := (Score * ExamContrib) / MaxScore;
        ExamResults.UserID := OriginalUser;
        ExamResults."Last Edited By" := USERID;
        ExamResults."Last Edited On" := TODAY;
        ExamResults."Original Score" := XxScore;
        ExamResults."Original Contribution" := xxContrib;
        ExamResults."Entry No" := LastEntry + 1;
        ExamResults.INSERT;

    end;
}

