report 51799 "ACA-Class Roster Grade Sheet"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/ACA-Class Roster Grade Sheet.rdl';

    dataset
    {
        dataitem("ACA-Units/Subjects"; "ACA-Units/Subjects")
        {
            DataItemTableView = SORTING(Code, "Programme Code", "Stage Code", "Entry No")
                                ORDER(Ascending);
            PrintOnlyIfDetail = true;
            dataitem("ACA-Student Units"; "ACA-Student Units")
            {
                DataItemLink = Programme = FIELD("Programme Code"),
                               Unit = FIELD(Code);
                RequestFilterFields = Programme, Stage, Unit, "Student No.";
                column(Lect; "ACA-Student Units".Lecturer)
                {
                }
                column(UName; "ACA-Student Units"."Unit Description")
                {
                }
                column(UCode; "ACA-Student Units".Unit)
                {
                }
                column(acadY; acadyear)
                {
                }
                column(semz; Sems)
                {
                }
                column(CHours; "ACA-Student Units"."Credit Hours")
                {
                }
                column(Dept; Dept)
                {
                }
                column(PName; PName)
                {
                }
                column(sCount; SCount)
                {
                }
                column(sNo; "ACA-Student Units"."Student No.")
                {
                }
                column(sName; "ACA-Student Units"."Student Name")
                {
                }
                column(ASS1; "ACA-Student Units"."CAT-1")
                {
                }
                column(ASS2; "ACA-Student Units"."CAT-2")
                {
                }
                column(CAT1; "ACA-Student Units"."CAT-1")
                {
                }
                column(CAT2; "ACA-Student Units"."CAT-2")
                {
                }
                column(TTCATS; "ACA-Student Units"."CAT-1" + "ACA-Student Units"."CAT-2")
                {
                }
                column(TTExam; "ACA-Student Units"."EXAMs Marks")
                {
                }
                column(TTCATS_Exam; "ACA-Student Units"."EXAMs Marks" + "ACA-Student Units"."CAT-1" + "ACA-Student Units"."CAT-2")
                {
                }
                column(Grade; "ACA-Student Units".Grade)
                {
                }
                column(Remarks; "ACA-Student Units".Remarks)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(PName);
                    CLEAR(FDesc);
                    CLEAR(Dept);
                    SCount := SCount + 1;
                    IF Prog.GET("ACA-Student Units".Programme) THEN BEGIN
                        PName := Prog.Description;
                        IF FacultyR.GET(Prog.Faculty) THEN
                            FDesc := FacultyR.Description;

                        DValue.RESET;
                        DValue.SETRANGE(DValue.Code, Prog.Department);
                        IF DValue.FIND('-') THEN
                            Dept := DValue.Name;

                    END;

                    // Pick the Units Names Here
                    IF NOT headerDone_1 THEN BEGIN
                        CLEAR(Column_H);
                        CLEAR(TColumn_V);
                        CLEAR(uColumn_V);
                        CLEAR(i);
                        studentsUnits.RESET;
                        studentsUnits.SETRANGE(studentsUnits."Student No.", "ACA-Student Units"."Student No.");
                        studentsUnits.SETRANGE(studentsUnits.Semester, Sems);
                        //studentsUnits.SETRANGE(studentsUnits."Academic Year",acadyear);
                        studentsUnits.SETRANGE(studentsUnits.Unit, "ACA-Student Units".Unit);
                        IF studentsUnits.FIND('-') THEN BEGIN
                            REPEAT
                            BEGIN
                                CLEAR(UnitHeaderSet_1);
                                counts := 0;
                                REPEAT
                                BEGIN
                                    counts := counts + 1;
                                    IF Column_H[counts] = studentsUnits.Unit THEN UnitHeaderSet_1 := TRUE;
                                END;
                                UNTIL counts = ARRAYLEN(Column_H);
                                i := i + 1;
                                IF UnitHeaderSet_1 = FALSE THEN BEGIN
                                    Column_H[i] := studentsUnits.Unit;

                                    // Lecturer Name Here
                                    lectUnits.RESET;
                                    lectUnits.SETRANGE(lectUnits.Programme, "ACA-Student Units".Programme);
                                    lectUnits.SETRANGE(lectUnits.Unit, "ACA-Student Units".Unit);
                                    IF lectUnits.FIND('-') THEN BEGIN
                                        uColumn_V[i] := lectUnits.Lecturer;
                                        IF uColumn_V[i] <> '' THEN BEGIN
                                            IF employee.GET(uColumn_V[i]) THEN BEGIN
                                                uColumn_V[i] := '';
                                                IF employee."First Name" <> '' THEN uColumn_V[i] := employee."First Name";
                                                IF uColumn_V[i] <> '' THEN BEGIN
                                                    IF employee."Middle Name" <> '' THEN uColumn_V[i] := uColumn_V[i] + ' ' + employee."Middle Name";
                                                END
                                                ELSE BEGIN
                                                    IF employee."Middle Name" <> '' THEN uColumn_V[i] := employee."Middle Name";
                                                END;

                                                IF uColumn_V[i] <> '' THEN BEGIN
                                                    IF employee."Last Name" <> '' THEN uColumn_V[i] := uColumn_V[i] + ' ' + employee."Last Name";
                                                END
                                                ELSE BEGIN
                                                    IF employee."Last Name" <> '' THEN uColumn_V[i] := employee."Last Name";
                                                END;

                                            END;
                                        END;
                                    END;
                                    // Calculate the UnitMean and MeanGrade Here
                                    //  Tcolumn_V[i]:=ROUND(Tcolumn_V[i],0.01,'=');
                                    //  ucolumn_V[i]:=GetGrade(totalMarks,"Course Registration".Programme);
                                END;
                            END;
                            UNTIL studentsUnits.NEXT = 0;
                        END;
                    END; // Not headerDone
                end;

                trigger OnPreDataItem()
                begin
                    // "ACA-Student Units".SETRANGE("ACA-Student Units"."Academic Year",acadyear);
                    "ACA-Student Units".SETRANGE("ACA-Student Units".Semester, Sems);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(SCount)
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(acadYears; acadyear)
                {
                    Caption = 'Academic Year';
                    TableRelation = "ACA-Academic Year".Code;
                    ApplicationArea = All;
                }
                field(semsz; Sems)
                {
                    Caption = 'Semester';
                    TableRelation = "ACA-Semesters".Code;
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        //IF acadyear='' THEN ERROR('Specify the Academic Year on the Options Tab.');
        IF Sems = '' THEN ERROR('Specify the Semester on the Options Tab.');
    end;

    var
        headerDone_1: Boolean;
        UnitHeaderSet_1: Boolean;
        employee: Record 61188;
        lectUnits: Record 61541;
        Column_H: array[300] of Text[100];
        Column_V: array[300] of Text[30];
        TColumn_V: array[300] of Text;
        uColumn_V: array[300] of Text[30];
        sColumn_V: array[300] of Text[30];
        totalMarks: Decimal;
        totStudents: Integer;
        stdUnits: Record 61549;
        counts: Integer;
        headerDone: Boolean;
        UnitHeaderSet: Boolean;
        sName: Text[200];
        cummAverage: Decimal;
        SemAverage: Decimal;
        semGrade: Code[2];
        semGPA2: Decimal;
        PastSemPoints: Decimal;
        PastSemHours: Decimal;
        CummGPA2: Decimal;
        intK: Integer;
        studentsUnits: Record 61549;
        scores: array[50] of Code[20];
        headerPrinted: Boolean;
        COUTZS: Integer;
        acadyear: Code[20];
        Sems: Code[20];
        cummGPA: Decimal;
        SemGPA: Decimal;

        ColumnH: array[300] of Text[100];
        ColumnV: array[300] of Text[30];
        i: Integer;
        TColumnV: array[300] of Decimal;
        SCount: Integer;

        uColumnV: array[300] of Text[30];
        sColumnV: array[300] of Text[30];
        Prog: Record 61511;

        RFound: Boolean;
        UDesc: Text[200];

        Result: Decimal;
        Grade: Text[150];
        Remarks: Text[150];

        TotalScore: Decimal;
        LastGrade: Code[20];
        LastScore: Decimal;
        ExitDo: Boolean;
        Desc: Text[200];
        OScore: Decimal;
        OUnits: Integer;
        MeanScore: Decimal;
        MeanGrade: Code[20];
        LastRemark: Text[200];
        CCat: Text[30];
        TScore: Decimal;
        RUnits: Decimal;
        SkipCount: Integer;
        MissingM: Boolean;
        DValue: Record 349;
        FacultyR: Record 61649;
        FDesc: Text[200];
        Dept: Text[200];
        PName: Text[200];
        SDesc: Text[200];
        Comb: Text[200];

        DMarks: Boolean;
        DSummary: Boolean;
        USkip: Boolean;

        UTaken: Integer;
        UPassed: Integer;
        UFailed: Integer;
        MCourse: Boolean;
        ExportToExcel: Boolean;
        constLine: Text[250];

}

