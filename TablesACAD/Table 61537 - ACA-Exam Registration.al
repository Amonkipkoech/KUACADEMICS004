table 61537 "ACA-Exam Registration"
{

    fields
    {
        field(1; "Student No."; Code[30])
        {
            NotBlank = true;
            TableRelation = Customer."No.";
        }
        field(2; Semester; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme Semesters".Semester WHERE("Programme Code" = FIELD(Programme));
        }
        field(3; Programme; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme".Code;
        }
        field(4; "Register for"; Option)
        {
            NotBlank = false;
            OptionCaption = 'Stage,Unit/Subject';
            OptionMembers = Stage,"Unit/Subject";

            trigger OnValidate()
            begin
                IF "Register for" = "Register for"::Stage THEN
                    Unit := '';
            end;
        }
        field(5; Stage; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD(Programme));
        }
        field(6; Unit; Code[20])
        {
            TableRelation = IF ("Register for" = CONST("Unit/Subject")) "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD(Programme),
                                                                                                 "Stage Code" = FIELD(Stage));
        }
        field(8; "Registration Date"; Date)
        {
            NotBlank = true;
        }
        field(9; Remarks; Text[150])
        {
        }
        field(10; "Reg. Transacton ID"; Code[20])
        {
        }
        field(11; "No. Series"; Code[20])
        {

            trigger OnValidate()
            begin
                IF "Reg. Transacton ID" <> xRec."Reg. Transacton ID" THEN BEGIN
                    GenSetup.GET;
                    //NoSeriesMgt.TestManual(GenSetup."Registration Nos.");
                    "No. Series" := '';
                END;
            end;
        }
        field(12; Exam; Code[20])
        {
            TableRelation = IF ("Register for" = CONST(Stage)) "ACA-Exams".Code WHERE("Programme Code" = FIELD(Programme),
                                                                                 "Stage Code" = FIELD(Stage),
                                                                                 Semester = FIELD(Semester))
            ELSE
            IF ("Register for" = CONST("Unit/Subject")) "ACA-Exams By Units".Code WHERE("Programme Code" = FIELD(Programme),
                                                                                                                                                             "Stage Code" = FIELD(Stage),
                                                                                                                                                             "Unit Code" = FIELD(Unit),
                                                                                                                                                             Semester = FIELD(Semester));

            trigger OnValidate()
            begin
                StudentCharges.RESET;
                StudentCharges.SETRANGE(StudentCharges."Reg. Transacton ID", "Reg. Transacton ID");
                IF StudentCharges.FIND('-') THEN
                    StudentCharges.DELETEALL;

                IF Exam <> '' THEN BEGIN
                    IF "Register for" = "Register for"::Stage THEN BEGIN

                        ExamByStage.RESET;
                        ExamByStage.SETRANGE(ExamByStage."Programme Code", Programme);
                        ExamByStage.SETRANGE(ExamByStage."Stage Code", Stage);
                        ExamByStage.SETRANGE(ExamByStage.Semester, Semester);
                        ExamByStage.SETRANGE(ExamByStage.Code, Exam);

                        IF ExamByStage.FIND('-') THEN BEGIN
                            StudentCharges.INIT;
                            StudentCharges.Programme := Programme;
                            StudentCharges.Stage := Stage;
                            StudentCharges.Semester := Semester;
                            StudentCharges."Student No." := "Student No.";
                            StudentCharges."Reg. Transacton ID" := "Reg. Transacton ID";
                            StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::"Stage Exam Fees";
                            StudentCharges.Date := "Registration Date";
                            StudentCharges.Code := ExamByStage.Code;
                            StudentCharges.Description := ExamByStage.Desription;
                            StudentCharges.Amount := ExamByStage.Amount;
                            IF StudentCharges.Amount > 0 THEN
                                StudentCharges.INSERT;
                        END;

                    END ELSE BEGIN

                        ExamByUnit.RESET;
                        ExamByUnit.SETRANGE(ExamByUnit."Programme Code", Programme);
                        ExamByUnit.SETRANGE(ExamByUnit."Stage Code", Stage);
                        ExamByUnit.SETRANGE(ExamByUnit."Unit Code", Unit);
                        ExamByUnit.SETRANGE(ExamByUnit.Semester, Semester);
                        ExamByUnit.SETRANGE(ExamByUnit.Code, Exam);

                        IF ExamByUnit.FIND('-') THEN BEGIN
                            StudentCharges.INIT;
                            StudentCharges.Programme := Programme;
                            StudentCharges.Stage := Stage;
                            StudentCharges.Unit := Unit;
                            StudentCharges.Semester := Semester;
                            StudentCharges."Student No." := "Student No.";
                            StudentCharges."Reg. Transacton ID" := "Reg. Transacton ID";
                            StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::"Unit Exam Fees";
                            StudentCharges.Date := "Registration Date";
                            StudentCharges.Code := ExamByUnit.Code;
                            StudentCharges.Description := ExamByUnit.Desription;
                            StudentCharges.Amount := ExamByUnit.Amount;
                            IF StudentCharges.Amount > 0 THEN
                                StudentCharges.INSERT;
                        END;


                    END;
                END;
            end;
        }
    }

    keys
    {
        key(Key1; "Reg. Transacton ID", "Student No.", Programme, Semester, "Register for", Stage, Unit)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        StudentCharges.RESET;
        StudentCharges.SETRANGE(StudentCharges."Reg. Transacton ID", "Reg. Transacton ID");
        IF StudentCharges.FIND('-') THEN
            StudentCharges.DELETEALL;
    end;

    trigger OnInsert()
    begin
        IF "Reg. Transacton ID" = '' THEN BEGIN
            GenSetup.GET;
            GenSetup.TESTFIELD(GenSetup."Registration Nos.");
            //NoSeriesMgt.InitSeries(GenSetup."Registration Nos.", xRec."No. Series", 0D, "Reg. Transacton ID", "No. Series");
        END;
        "Registration Date" := TODAY;
    end;

    var
        ExamByStage: Record 61526;
        ExamByUnit: Record 61527;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenSetup: Record 61534;
        StudentCharges: Record 61535;
        TotalCost: Decimal;
        StageCharges: Record 61533;
}

