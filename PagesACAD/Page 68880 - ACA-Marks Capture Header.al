page 68880 "ACA-Marks Capture Header"
{

    layout
    {
        area(content)
        {
            field(lectNo; lectNo)
            {
                Caption = 'Lecturer No.';
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    lectName := '';
                    IF empl.GET(lectNo) THEN
                        lectName := empl."First Name" + ' ' + empl."Middle Name" + ' ' + empl."Last Name"
                    ELSE
                        ERROR('Lecturer Code not found');
                end;
            }
            field(Passwords; Passwords)
            {
                Caption = 'Lecturer Password';
                ExtendedDatatype = Masked;
                HideValue = true;
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    /*
                    PassOk:=FALSE;
                    IF empl.GET(lectNo) THEN BEGIN
                    IF Passwords <> empl."Portal Password" THEN
                    ERROR('Incorrect password. Passwords are case sensitive.')
                    ELSE
                    PassOk:=TRUE;
                    
                    END;
                        */

                end;
            }
            field(lectName; lectName)
            {
                Caption = 'Lecturer Name';
                Editable = false;
                ApplicationArea = All;
            }
            field(Prog; Prog)
            {
                Caption = 'Program/Course';
                TableRelation = "ACA-Programme".Code;
                ApplicationArea = All;

                trigger OnValidate()
                var
                    programme: Record "ACA-Programme";
                begin
                    validate_Password;
                    CLEAR(examCat);
                    programme.RESET;
                    programme.SETRANGE(programme.Code, Prog);
                    IF programme.FIND('-') THEN BEGIN
                        programme.TESTFIELD(programme."Exam Category");
                        examCat := programme."Exam Category";
                    END;

                    CurrPage.UPDATE;
                end;
            }
            field(examCat; examCat)
            {
                Caption = 'Exam Category';
                Editable = false;
                ApplicationArea = All;
            }
            field(Semez; Semez)
            {
                Caption = 'Semester';
                TableRelation = "ACA-Semesters".Code;
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    validate_Password;
                    CurrPage.UPDATE;
                end;
            }
            field(AcadYear; AcadYear)
            {
                Caption = 'Academic Year';
                TableRelation = "ACA-Academic Year".Code;
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    validate_Password;
                    CurrPage.UPDATE;
                end;
            }
            field(Units; Units)
            {
                Caption = 'Unit/Subject';
                TableRelation = "ACA-Units/Subjects".Code;
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    IF lectNo = '' THEN ERROR('Input a staff number.');
                    IF Passwords = '' THEN ERROR('Input your password.');
                    IF Semez = '' THEN ERROR('Specify the Semester.');
                    IF AcadYear = '' THEN ERROR('Specify the academic year');
                    validate_Password;
                    CLEAR(SubjName);
                    unitsSubj.RESET;
                    unitsSubj.SETRANGE(unitsSubj.Code, Units);
                    IF unitsSubj.FIND('-') THEN
                        SubjName := unitsSubj.Desription;

                    // Check if the lecturer can capture marks for the subject
                    lectUnits.RESET;
                    lectUnits.SETRANGE(lectUnits.Unit, Units);
                    lectUnits.SETRANGE(lectUnits.Lecturer, lectNo);
                    IF NOT (lectUnits.FIND('-')) THEN ERROR('You are not allowed to capture Marks for ' + FORMAT(SubjName));

                    CLEAR(UnitStage);
                    unitsSubj.RESET;
                    unitsSubj.SETRANGE(unitsSubj.Code, Units);
                    IF unitsSubj.FIND('-') THEN BEGIN
                        UnitStage := unitsSubj."Stage Code";
                    END;
                    //
                    // Populate the Students
                    populateStudents;

                    CurrPage.UPDATE;
                end;
            }
            field(SubjName; SubjName)
            {
                Caption = 'Unit Name';
                Editable = false;
                ApplicationArea = All;
            }
            group(Students)
            {
#pragma warning disable AL0269
                part(MC; "ACA-Marks Capture Line")
#pragma warning restore AL0269
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Post_Marks)
            {
                Caption = 'Post Marks';
                Image = PostDocument;
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF ((Prog = '') OR (AcadYear = '') OR (Semez = '') OR (Units = '')) THEN ERROR('Enter the required Filters first.');
                    validate_Password;
                    // Check if the lecturer can capture marks for the subject
                    lectUnits.RESET;
                    lectUnits.SETRANGE(lectUnits.Unit, Units);
                    lectUnits.SETRANGE(lectUnits.Lecturer, lectNo);
                    IF NOT (lectUnits.FIND('-')) THEN ERROR('You are not allowed to capture Marks for ' + FORMAT(SubjName));


                    IF CONFIRM('Post marks?', TRUE) = FALSE THEN EXIT;
                    postScores();
                    MESSAGE('Marks Posted successfully');
                end;
            }
        }
    }

    var
        Prog: Code[30];
        AcadYear: Code[20];
        Semez: Code[20];
        Units: Code[20];
        lectNo: Code[30];
        Passwords: Code[30];
        lectUnits: Record "ACA-Lecturers Units - Old";
        SubjName: Code[250];
        unitsSubj: Record "ACA-Units/Subjects";
        examCat: Code[30];
        UnitStage: Code[20];
        lectName: Code[250];
        empl: Record "HRM-Employee (D)";
        PassOk: Boolean;

    procedure validate_Password()
    var
        employee: Record "HRM-Employee (D)";
    begin
        IF ((lectNo = '') OR (Passwords = '')) THEN BEGIN
            ERROR('Please enter your no. and password.');
        END;
        CLEAR(lectName);
        employee.RESET;
        employee.SETRANGE(employee."No.", lectNo);
        employee.SETRANGE(employee."Portal Password", Passwords);
        IF NOT (employee.FIND('-')) THEN
            ERROR('The employee number or password is incorect.')
        ELSE
            lectName := employee."First Name" + ' ' + employee."Middle Name" + ' ' + employee."Last Name";
    end;

    procedure populateStudents()
    var
        CourseReg: Record "ACA-Course Registration";
        studUnits: Record "ACA-Student Units";
        MarksCapture: Record "FIN-Exam Marks Capture";
        Examres: Record "ACA-Exam Results";
    begin
        // Delete Existing Data
        MarksCapture.RESET;
        IF MarksCapture.FIND('-') THEN
            MarksCapture.DELETEALL;

        studUnits.RESET;
        studUnits.SETRANGE(studUnits.Unit, Units);
        studUnits.SETRANGE(studUnits.Semester, Semez);
        studUnits.SETRANGE(studUnits."Academic Year", AcadYear);
        IF studUnits.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                MarksCapture.RESET;
                MarksCapture.SETRANGE(MarksCapture."Student No.", studUnits."Student No.");
                MarksCapture.SETRANGE(MarksCapture."Academic Year", AcadYear);
                MarksCapture.SETRANGE(MarksCapture.Semester, Semez);
                MarksCapture.SETRANGE(MarksCapture."Unit Code", Units);
                MarksCapture.SETRANGE(MarksCapture."Programme Code", Prog);
                IF NOT (MarksCapture.FIND('-')) THEN BEGIN
                    // Insert
                    MarksCapture.INIT;
                    MarksCapture."Student No." := studUnits."Student No.";
                    MarksCapture."Academic Year" := AcadYear;
                    MarksCapture.Semester := Semez;
                    MarksCapture."Unit Code" := Units;
                    MarksCapture."Programme Code" := Prog;
                    MarksCapture."Reg. Trans Id" := studUnits."Reg. Transacton ID";
                    MarksCapture.INSERT;
                END;
            END;
            UNTIL studUnits.NEXT = 0;
        END;

        // Update Scores
        MarksCapture.RESET;
        // MarksCapture.SETRANGE(MarksCapture."Student No.",studUnits."Student No.");
        MarksCapture.SETRANGE(MarksCapture."Academic Year", AcadYear);
        MarksCapture.SETRANGE(MarksCapture.Semester, Semez);
        MarksCapture.SETRANGE(MarksCapture."Unit Code", Units);
        MarksCapture.SETRANGE(MarksCapture."Programme Code", Prog);
        IF MarksCapture.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                Examres.RESET;
                Examres.SETRANGE(Examres."Student No.", MarksCapture."Student No.");
                Examres.SETRANGE(Examres.Programmes, MarksCapture."Programme Code");
                Examres.SETRANGE(Examres.Unit, MarksCapture."Unit Code");
                Examres.SETRANGE(Examres.Semester, MarksCapture.Semester);
                Examres.SETRANGE(Examres."Reg. Transaction ID", MarksCapture."Reg. Trans Id");
                IF Examres.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        IF Examres.Exam = 'CAT1' THEN BEGIN
                            MarksCapture."CAT 1" := Examres.Score;
                            MarksCapture.MODIFY;
                        END;
                        IF Examres.Exam = 'CAT2' THEN BEGIN
                            MarksCapture."CAT 2" := Examres.Score;
                            MarksCapture.MODIFY;
                        END;
                        IF Examres.Exam = 'EXAM' THEN BEGIN
                            MarksCapture.Exam := Examres.Score;
                            MarksCapture.MODIFY;
                        END;
                    END;
                    UNTIL Examres.NEXT = 0;
                END;
            END;
            UNTIL MarksCapture.NEXT = 0;
        END;
    end;

    procedure postScores()
    var
        Examres: Record "ACA-Exam Results";
        MarksCapture: Record "FIN-Exam Marks Capture";
    begin
        MarksCapture.RESET;
        // MarksCapture.SETRANGE(MarksCapture."Student No.",studUnits."Student No.");
        MarksCapture.SETRANGE(MarksCapture."Academic Year", AcadYear);
        MarksCapture.SETRANGE(MarksCapture.Semester, Semez);
        MarksCapture.SETRANGE(MarksCapture."Unit Code", Units);
        MarksCapture.SETRANGE(MarksCapture."Programme Code", Prog);
        IF MarksCapture.FIND('-') THEN BEGIN
            REPEAT
            //  if ((MarksCapture."CAT 1"+MarksCapture."CAT 2"+MarksCapture.Exam)>0)
            BEGIN
                Examres.RESET;
                Examres.SETRANGE(Examres."Student No.", MarksCapture."Student No.");
                Examres.SETRANGE(Examres.Programmes, MarksCapture."Programme Code");
                Examres.SETRANGE(Examres.Unit, MarksCapture."Unit Code");
                Examres.SETRANGE(Examres.Semester, MarksCapture.Semester);
                Examres.SETRANGE(Examres."Reg. Transaction ID", MarksCapture."Reg. Trans Id");
                IF Examres.FIND('-') THEN Examres.DELETEALL;
                // Insert New
                Examres.INIT;
                Examres."Student No." := MarksCapture."Student No.";
                Examres.Programmes := MarksCapture."Programme Code";
                Examres.Stage := UnitStage;
                Examres.Unit := Units;
                Examres.Semester := Semez;
                Examres."Reg. Transaction ID" := MarksCapture."Reg. Trans Id";
                Examres.Score := MarksCapture.Exam;
                Examres.Exam := 'EXAM';
                Examres.ExamType := 'EXAM';
                Examres."Exam Category" := examCat;
                Examres."Admission No" := MarksCapture."Student No.";
                Examres."Lecturer Names" := lectName;
                Examres.Category := examCat;
                Examres.INSERT;

                Examres.INIT;
                Examres."Student No." := MarksCapture."Student No.";
                Examres.Programmes := MarksCapture."Programme Code";
                Examres.Stage := UnitStage;
                Examres.Unit := Units;
                Examres.Semester := Semez;
                Examres."Reg. Transaction ID" := MarksCapture."Reg. Trans Id";
                Examres.Score := MarksCapture."CAT 1";
                Examres.Exam := 'CAT1';
                Examres.ExamType := 'CAT1';
                Examres."Exam Category" := examCat;
                Examres."Admission No" := MarksCapture."Student No.";
                Examres."Lecturer Names" := lectName;
                Examres.Category := examCat;
                Examres.INSERT;

                Examres.INIT;
                Examres."Student No." := MarksCapture."Student No.";
                Examres.Programmes := MarksCapture."Programme Code";
                Examres.Stage := UnitStage;
                Examres.Unit := Units;
                Examres.Semester := Semez;
                Examres."Reg. Transaction ID" := MarksCapture."Reg. Trans Id";
                Examres.Score := MarksCapture."CAT 2";
                Examres.Exam := 'CAT2';
                Examres.ExamType := 'CAT2';
                Examres."Exam Category" := examCat;
                Examres."Admission No" := MarksCapture."Student No.";
                Examres."Lecturer Names" := lectName;
                Examres.Category := examCat;
                Examres.INSERT;


            END;
            UNTIL MarksCapture.NEXT = 0;
        END;
    end;
}

