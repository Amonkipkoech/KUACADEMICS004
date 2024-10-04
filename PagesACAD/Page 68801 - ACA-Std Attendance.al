page 68801 "ACA-Std Attendance"
{
    PageType = Card;
    SourceTable = 61549;

    layout
    {
        area(content)
        {
            field("Programme Filter"; Rec."Programme Filter")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    Rec.SETFILTER("Stage Filter", '');
                    Rec.SETFILTER("Unit Filter", '');
                    Rec.SETFILTER("Semester Filter", '');
                    Rec.SETRANGE(Programme, Rec.GETFILTER("Programme Filter"));
                    NoStud := 0;
                    PName := '';
                    SName := '';
                    UName := '';
                    IF Prog.GET(Rec.GETFILTER("Programme Filter")) THEN
                        PName := Prog.Description;


                    ProgStages.RESET;
                    ProgStages.SETRANGE(ProgStages."Programme Code", Rec.GETFILTER("Programme Filter"));
                    IF ProgStages.FIND('-') THEN BEGIN
                        Rec.SETFILTER("Stage Filter", ProgStages.Code);
                        Rec.VALIDATE("Stage Filter");
                        Rec.SETFILTER("Unit Filter", '');
                        Rec.SETRANGE(Stage, Rec.GETFILTER("Stage Filter"));
                        NoStud := 0;
                        SName := '';
                        UName := '';

                        IF StageR.GET(Rec.GETFILTER("Programme Filter"), Rec.GETFILTER("Stage Filter")) THEN
                            SName := StageR.Description;

                    END;

                    /*
                    PSemester.RESET;
                    PSemester.SETRANGE(PSemester."Programme Code",GETFILTER("Programme Filter"));
                    PSemester.SETRANGE(PSemester.Current,TRUE);
                    IF PSemester.FIND('-') THEN BEGIN
                    SETFILTER("Semester Filter",PSemester.Semester);
                    VALIDATE("Semester Filter");
                    SETRANGE(Semester,GETFILTER("Semester Filter"));
                    
                    END;
                    */

                end;
            }
            field(PName; PName)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Unit Filter"; Rec."Unit Filter")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    Rec.SETRANGE(Unit, Rec.GETFILTER("Unit Filter"));
                    NoStud := 0;
                    CreditH := 0;
                    ACAUnitsSubjects.RESET;
                    ACAUnitsSubjects.SETRANGE(ACAUnitsSubjects."Programme Code", ACAUnitsSubjects.GETFILTER(ACAUnitsSubjects."Programme Filter"));
                    //Units.SETRANGE(Units."Stage Code",Units.GETFILTER(Units."Stage Filter"));
                    ACAUnitsSubjects.SETRANGE(ACAUnitsSubjects.Code, ACAUnitsSubjects.GETFILTER(ACAUnitsSubjects."Unit Filter"));
                    IF ACAUnitsSubjects.FIND('-') THEN BEGIN
                        ACAUnitsSubjects.CALCFIELDS(ACAUnitsSubjects."Students Registered");
                        NoStud := ACAUnitsSubjects."Students Registered";
                    END;
                    UName := '';
                    NoStud := 0;
                    UnitsR.RESET;
                    UnitsR.SETRANGE(UnitsR."Programme Code", Rec.GETFILTER("Programme Filter"));
                    UnitsR.SETRANGE(UnitsR.Code, Rec.GETFILTER("Unit Filter"));
                    IF UnitsR.FIND('-') THEN BEGIN
                        UnitsR.CALCFIELDS(UnitsR."Students Registered");
                        UName := UnitsR.Desription;
                        CreditH := UnitsR."Credit Hours";
                        //NoStud:=UnitsR."Students Registered";
                    END;
                end;
            }
            field(UName; UName)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field(Lect; Lect)
            {
                Caption = 'Lecturer';
                Editable = false;
                ApplicationArea = All;
            }
            field(CreditH; CreditH)
            {
                Caption = 'Credit Hours';
                Editable = false;
                ApplicationArea = All;
            }
            field("Semester Filter"; Rec."Semester Filter")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    Rec.SETRANGE(Semester, Rec.GETFILTER("Semester Filter"));

                    //TTable.SETRANGE(TTable.Semester,GETFILTER("Semester Filter"));
                    UnitsR.RESET;
                    UnitsR.SETRANGE(UnitsR."Programme Code", Rec.GETFILTER("Programme Filter"));
                    UnitsR.SETRANGE(UnitsR."Stage Code", Rec.GETFILTER("Stage Filter"));
                    UnitsR.SETRANGE(UnitsR.Code, Rec.GETFILTER("Unit Filter"));
                    UnitsR.SETFILTER(UnitsR."Semester Filter", Rec.GETFILTER("Semester Filter"));
                    IF UnitsR.FIND('-') THEN BEGIN
                        UnitsR.CALCFIELDS(UnitsR."Students Registered");
                        NoStud := UnitsR."Students Registered";
                    END;

                    Lect := '';

                    LecUnits.RESET;
                    LecUnits.SETRANGE(LecUnits.Programme, Rec.GETFILTER("Programme Filter"));
                    LecUnits.SETRANGE(LecUnits.Stage, Rec.GETFILTER("Stage Filter"));
                    LecUnits.SETRANGE(LecUnits.Unit, Rec.GETFILTER("Unit Filter"));
                    LecUnits.SETRANGE(LecUnits.Semester, Rec.GETFILTER("Semester Filter"));
                    IF LecUnits.FIND('-') THEN BEGIN
                        IF Employee.GET(LecUnits.Lecturer) THEN
                            Lect := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    END;
                end;
            }
            field("Stage Filter"; Rec."Stage Filter")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    Rec.SETFILTER("Unit Filter", '');
                    Rec.SETRANGE(Stage, Rec.GETFILTER("Stage Filter"));
                    NoStud := 0;
                    /*
                    CurrForm.Matrix.MatrixRec.RESET;
                    CurrForm.Matrix.MatrixRec.SETRANGE(CurrForm.Matrix.MatrixRec."Programme Code",Programme);
                    CurrForm.Matrix.MatrixRec.SETRANGE(CurrForm.Matrix.MatrixRec."Stage Code",Stage);
                    */
                    SName := '';
                    UName := '';

                    IF StageR.GET(Rec.GETFILTER("Programme Filter"), Rec.GETFILTER("Stage Filter")) THEN
                        SName := StageR.Description;

                end;
            }
            repeater(general)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    Caption = 'Names';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Attendance; Rec.Attendance)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Name := '';
        IF Students.GET(Rec."Student No.") THEN
            Name := Students.Name + ' ' + Students."Name 2"
        ELSE
            Name := '';
    end;

    trigger OnOpenPage()
    begin
        Rec.SETFILTER("Programme Filter", '');
        Rec.SETFILTER("Stage Filter", '');
        Rec.SETFILTER("Unit Filter", '');
        Rec.SETFILTER("Semester Filter", '');
        Rec.RESET;
    end;

    var
        Name: Text[250];
        Students: Record Customer;
        Sem: Text[100];
        NoStud: Integer;
        Units: Record "ACA-Units/Subjects";
        PName: Text[250];
        SName: Text[250];
        UName: Text[250];
        Prog: Record "ACA-Programme";
        StageR: Record "ACA-Programme Stages";
        UnitsR: Record "ACA-Units/Subjects";
        LUnits: Record "ACA-Lecturers Units - Old";

        Lect: Text[250];
        Employee: Record "HRM-Employee (D)";
        ExamsSetup: Record "ACA-Exams Setup";
        CreditH: Decimal;
        LecUnits: Record "ACA-Lecturers Units - Old";
        LecUnitsTaken: Record "ACA-Lecturers Units - Old";
        ProgStages: Record "ACA-Programme Stages";
        PSemester: Record "ACA-Programme Semesters";

        unit: Integer;
        ACAUnitsSubjects: Record "ACA-Units/Subjects";
}

