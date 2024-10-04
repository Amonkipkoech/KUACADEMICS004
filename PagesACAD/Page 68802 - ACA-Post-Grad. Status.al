page 68802 "ACA-Post-Grad. Status"
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

                    /*SETFILTER("Stage Filter",'');
                    //SETFILTER("Unit Filter",'');
                    //SETFILTER("Semester Filter",'');
                    SETRANGE(Programme,GETFILTER("Programme Filter"));
                    NoStud:=0;
                    PName:='';
                    SName:='';
                    UName:='';
                    IF Prog.GET(GETFILTER("Programme Filter")) THEN
                    PName:=Prog.Description;
                    
                    
                    ProgStages.RESET;
                    ProgStages.SETRANGE(ProgStages."Programme Code",GETFILTER("Programme Filter"));
                    IF ProgStages.FIND('-') THEN BEGIN
                    SETFILTER("Stage Filter",ProgStages.Code);
                    //VALIDATE("Stage Filter");
                    SETFILTER("Unit Filter",'');
                    SETRANGE(Stage,GETFILTER("Stage Filter"));
                    NoStud:=0;
                    SName:='';
                    UName:='';
                    
                    
                    IF StageR.GET(GETFILTER("Programme Filter"),GETFILTER("Stage Filter")) THEN
                    SName:=StageR.Description;
                    
                    END;
                    
                    PSemester.RESET;
                    PSemester.SETRANGE(PSemester."Programme Code",GETFILTER("Programme Filter"));
                    PSemester.SETRANGE(PSemester.Current,TRUE);
                    IF PSemester.FIND('-') THEN BEGIN
                    SETFILTER("Semester Filter",PSemester.Semester);
                    VALIDATE("Semester Filter");
                    SETRANGE(Semester,GETFILTER("Semester Filter"));
                    
                    END;
                    */

                    Rec.SETFILTER(Semester, Rec.GETFILTER("Semester Filter"));
                    Rec.SETFILTER(Stage, Rec.GETFILTER("Stage Filter"));
                    Rec.SETFILTER(Programme, Rec.GETFILTER("Programme Filter"));
                    Rec.SETFILTER(Unit, Rec.GETFILTER("Unit Filter"));
                    IF Prog.GET(Rec.GETFILTER("Programme Filter")) THEN
                        PName := Prog.Description;

                    IF Rec.COUNT = 0 THEN ERROR('No Student found within the filters');

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
                    //RESET;
                    Rec.SETFILTER(Semester, Rec.GETFILTER("Semester Filter"));
                    Rec.SETFILTER(Stage, Rec.GETFILTER("Stage Filter"));
                    Rec.SETFILTER(Programme, Rec.GETFILTER("Programme Filter"));
                    Rec.SETFILTER(Unit, Rec.GETFILTER("Unit Filter"));


                    /*
                    SETRANGE(Unit,GETFILTER("Unit Filter"));
                    NoStud:=0;
                    CreditH:=0;
                    Units.RESET;
                    Units.SETRANGE(Units."Programme Code",Units.GETFILTER(Units."Programme Filter"));
                    //Units.SETRANGE(Units."Stage Code",Units.GETFILTER(Units."Stage Filter"));
                    Units.SETRANGE(Units.Code,Units.GETFILTER(Units."Unit Filter"));
                    IF Units.FIND('-') THEN BEGIN
                    Units.CALCFIELDS(Units."Students Registered");
                    NoStud:=Units."Students Registered";
                    END;
                    UName:='';
                    NoStud:=0;
                    UnitsR.RESET;
                    UnitsR.SETRANGE(UnitsR."Programme Code",GETFILTER("Programme Filter"));
                    UnitsR.SETRANGE(UnitsR.Code,GETFILTER("Unit Filter"));
                    IF UnitsR.FIND('-') THEN BEGIN
                    UnitsR.CALCFIELDS(UnitsR."Students Registered");
                    UName:=UnitsR.Desription;
                    CreditH:=UnitsR."Credit Hours";
                    //NoStud:=UnitsR."Students Registered";
                    END;
                    */

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
            field("Semester Filter"; Rec."Semester Filter")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    //RESET;
                    Rec.SETFILTER(Semester, Rec.GETFILTER("Semester Filter"));
                    Rec.SETFILTER(Stage, Rec.GETFILTER("Stage Filter"));
                    Rec.SETFILTER(Programme, Rec.GETFILTER("Programme Filter"));
                    Rec.SETFILTER(Unit, Rec.GETFILTER("Unit Filter"));

                    /*SETRANGE(Semester,GETFILTER("Semester Filter"));
                    
                    //TTable.SETRANGE(TTable.Semester,GETFILTER("Semester Filter"));
                    UnitsR.RESET;
                    UnitsR.SETRANGE(UnitsR."Programme Code",GETFILTER("Programme Filter"));
                    UnitsR.SETRANGE(UnitsR."Stage Code",GETFILTER("Stage Filter"));
                    UnitsR.SETRANGE(UnitsR.Code,GETFILTER("Unit Filter"));
                    UnitsR.SETFILTER(UnitsR."Semester Filter",GETFILTER("Semester Filter"));
                    IF UnitsR.FIND('-') THEN BEGIN
                    UnitsR.CALCFIELDS(UnitsR."Students Registered");
                    NoStud:=UnitsR."Students Registered";
                    END;
                    
                    {SETRANGE(Semester,GETFILTER("Semester Filter"));
                    
                    //TTable.SETRANGE(TTable.Semester,GETFILTER("Semester Filter"));
                    UnitsR.RESET;
                    UnitsR.SETRANGE(UnitsR."Programme Code",GETFILTER("Programme Filter"));
                    UnitsR.SETRANGE(UnitsR."Stage Code",GETFILTER("Stage Filter"));
                    UnitsR.SETRANGE(UnitsR.Code,GETFILTER("Unit Filter"));
                    UnitsR.SETFILTER(UnitsR."Semester Filter",GETFILTER("Semester Filter"));
                    IF UnitsR.FIND('-') THEN BEGIN
                    UnitsR.CALCFIELDS(UnitsR."Students Registered");
                    NoStud:=UnitsR."Students Registered";
                    END;
                    
                    Lect:='';
                    
                    LecUnits.RESET;
                    LecUnits.SETRANGE(LecUnits.Programme,GETFILTER("Programme Filter"));
                    LecUnits.SETRANGE(LecUnits.Stage,GETFILTER("Stage Filter"));
                    LecUnits.SETRANGE(LecUnits.Unit,GETFILTER("Unit Filter"));
                    LecUnits.SETRANGE(LecUnits.Semester,GETFILTER("Semester Filter"));
                    IF LecUnits.FIND('-') THEN BEGIN
                    IF Employee.GET(LecUnits.Lecturer) THEN
                    Lect:=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    END;
                     }
                    */

                end;
            }
            field("Stage Filter"; Rec."Stage Filter")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    //RESET;
                    Rec.SETFILTER(Semester, Rec.GETFILTER("Semester Filter"));
                    Rec.SETFILTER(Stage, Rec.GETFILTER("Stage Filter"));
                    Rec.SETFILTER(Programme, Rec.GETFILTER("Programme Filter"));
                    Rec.SETFILTER(Unit, Rec.GETFILTER("Unit Filter"));

                    /*
                    SETFILTER("Unit Filter",'');
                    SETRANGE(Stage,GETFILTER("Stage Filter"));
                    NoStud:=0;
                    {
                    CurrForm.Matrix.MatrixRec.RESET;
                    CurrForm.Matrix.MatrixRec.SETRANGE(CurrForm.Matrix.MatrixRec."Programme Code",Programme);
                    CurrForm.Matrix.MatrixRec.SETRANGE(CurrForm.Matrix.MatrixRec."Stage Code",Stage);
                    }
                    SName:='';
                    UName:='';
                    
                    IF StageR.GET(GETFILTER("Programme Filter"),GETFILTER("Stage Filter")) THEN
                    SName:=StageR.Description;
                    */

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
                field("Proposal Status"; Rec."Proposal Status")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF NOT CONFIRM('Do you really want to change the proposal status?') THEN
                            Rec."Proposal Status" := xRec."Proposal Status";
                    end;
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Thesis Status';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF NOT CONFIRM('Do you really want to change the thesis status?') THEN
                            Rec.Status := xRec.Status;
                    end;
                }
                field("Project Status"; Rec."Project Status")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF NOT CONFIRM('Do you really want to change the project status?') THEN
                            Rec."Project Status" := xRec."Project Status";
                    end;
                }
                field("Progress Report"; Rec."Progress Report")
                {
                    ApplicationArea = All;
                }
                field("Details Count"; Rec."Details Count")
                {
                    ApplicationArea = All;
                }
                field("Proposal Date"; Rec."Proposal Date")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Senate-Proposal"; Rec."Senate-Proposal")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Research; Rec.Research)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Senate-Research"; Rec."Senate-Research")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Examiners; Rec.Examiners)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Defense; Rec.Defense)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Defence OutCome"; Rec."Defence OutCome")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
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
}

