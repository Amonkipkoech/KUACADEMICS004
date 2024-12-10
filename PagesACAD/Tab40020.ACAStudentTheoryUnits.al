table 40020 "ACA-Student Theory Units "
{
    Caption = 'ACA-Student Theory Units ';
    DataClassification = ToBeClassified;
    DrillDownPageId = "ACA-Student Theory Units";
    LookupPageId = "ACA-Student Theory Units";
    /// <summary>
    /// Table ACA-Student Units (ID 61549).
    /// </summary>


    fields
    {
        field(1; "Reg. Transacton ID"; Code[20])
        {
            Editable = true;
        }
        field(2; "Student No."; Code[20])
        {
            Editable = true;
            NotBlank = true;
        }
        field(3; Semester; Code[20])
        {
            Editable = true;
            NotBlank = false;
            TableRelation = "ACA-Semesters".Code;

            trigger OnValidate()
            begin
                IF ((xRec.Semester <> Rec.Semester)) THEN BEGIN
                    ACAExamResults.RESET;
                    ACAExamResults.SETRANGE(Unit, Rec.Unit);
                    ACAExamResults.SETRANGE(Semester, xRec.Semester);
                    ACAExamResults.SETRANGE("Student No.", Rec."Student No.");
                    ACAExamResults.SETRANGE(Stage, Rec.Stage);
                    IF ACAExamResults.FIND('-') THEN BEGIN
                        REPEAT
                            IF ACAExamResults.RENAME(ACAExamResults."Student No.", ACAExamResults.Programmes, Rec.Stage, ACAExamResults.Unit,
                              Rec.Semester, ACAExamResults.ExamType, ACAExamResults."Reg. Transaction ID", ACAExamResults."Entry No") THEN
                                ;
                        UNTIL ACAExamResults.NEXT = 0;
                    END;

                END;
            end;
        }
        field(4; Programme; Code[20])
        {
            Editable = true;
            NotBlank = false;
            TableRelation = "ACA-Programme".Code;

            trigger OnValidate()
            begin

                CReg.RESET;
                CReg.SETRANGE(CReg."Student No.", "Student No.");
                IF CReg.FIND('+') THEN BEGIN
                    "Reg. Transacton ID" := CReg."Reg. Transacton ID";
                    //Programme:=CReg.Programme;
                    //Stage:=CReg.Stage;
                    //Semester:=CReg.Semester;
                END;
                coreg.RESET;
                coreg.SETRANGE(coreg."Reg. Transacton ID", "Reg. Transacton ID");
                IF coreg.FIND('-') THEN BEGIN
                    // Semester:=coreg.Semester;
                    // "Academic Year":=coreg."Academic Year";
                END;
            end;
        }
        field(5; "Register for"; Option)
        {
            //Editable = false;
            NotBlank = false;
            OptionCaption = 'Stage,Unit/Subject,Supplimentary,Special';
            OptionMembers = Stage,"Unit/Subject",Supplimentary,Special;
        }
        field(6; Stage; Code[20])
        {
            Editable = true;
            NotBlank = false;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD(Programme));

            trigger OnValidate()
            begin
                IF ((xRec.Stage <> Rec.Stage)) THEN BEGIN
                    ACAExamResults.RESET;
                    ACAExamResults.SETRANGE(Unit, Rec.Unit);
                    ACAExamResults.SETRANGE(Semester, Rec.Semester);
                    ACAExamResults.SETRANGE("Student No.", Rec."Student No.");
                    ACAExamResults.SETRANGE(Stage, xRec.Stage);
                    IF ACAExamResults.FIND('-') THEN BEGIN
                        REPEAT
                            IF ACAExamResults.RENAME(ACAExamResults."Student No.", ACAExamResults.Programmes, Rec.Stage, ACAExamResults.Unit,
                              Rec.Semester, ACAExamResults.ExamType, ACAExamResults."Reg. Transaction ID", ACAExamResults."Entry No") THEN
                                ;
                        UNTIL ACAExamResults.NEXT = 0;
                    END;

                END;
            end;
        }
        field(7; Unit; Code[20])
        {
            Editable = true;
            NotBlank = false;
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD(Programme), "Unit Type" = filter(Clinical .. Theory));

            trigger OnValidate()
            var
                StageInteger: Integer;
            begin
                //ACASemesters.RESET;
                //ACASemesters.SETRANGE(Code,Rec.Semester);
                //IF ACASemesters.FIND('-') THEN BEGIN
                // IF ACASemesters."Registration Deadline"<>0D THEN BEGIN
                // IF ACASemesters."Registration Deadline"<TODAY THEN ERROR('Error:\You cannot register past deadline');
                // END;
                //END;
                /*
                CourseReg.RESET;
                CourseReg.SETRANGE(CourseReg."Student No.","Student No.");
                IF CourseReg.FIND('-') THEN BEGIN
                Programme:=CourseReg.Programme;
                Stage:=CourseReg.Stage;
                Semester:=CourseReg.Semester;
                "Reg. Transacton ID":=CourseReg."Reg. Transacton ID";
                END;
                */
                AllowAccessSettings := true;
                if usersetup.get(UserId) then
                    if (usersetup."Allow Add Unit") then begin
                        AllowAccessSettings := usersetup."Allow Add Unit";
                        exit
                    end;
                Error(Nopermission);
                UnitsS.RESET;
                UnitsS.SETRANGE(UnitsS."Programme Code", Rec.Programme);
                UnitsS.SETRANGE(UnitsS."Unit Code", Rec.Unit);
                IF UnitsS.FIND('-') THEN BEGIN
                    //"No. Of Units" := UnitsS."No. Units";
                    Description := UnitsS."Unit Name";
                    //"Special Programme Class" := UnitsS."Special Programme Class";

                    /*
                    CReg.RESET;
                    CReg.SETRANGE(CReg."Reg. Transacton ID","Reg. Transacton ID");
                    IF CReg.FIND('-') THEN BEGIN
                    IF CReg.Programme <> Programme THEN BEGIN
                    IF UnitsS."Common Unit" = FALSE THEN
                    ERROR('You cannot select a unit from another programme with is not a common unit.')
                    END;
                    END;
                    */


                    "No. Of Units" := UnitsS."Credit Hours";
                    //"Unit Stage":=UnitsS."Stage Code";
                    "Edited By" := USERID;
                    "Date Edited" := TODAY;
                    CLEAR(StageInteger);
                    // IF EVALUATE(StageInteger, COPYSTR(UnitsS."Stage Code", 2, 1)) THEN;
                    // IF StageInteger IN [1 .. 9] THEN
                    //     Rec."Unit Year of Study" := StageInteger;

                END;



                // UnitsS.RESET;
                // UnitsS.SETRANGE(UnitsS."Programme Code", Programme);
                // UnitsS.SETRANGE(UnitsS.Code, Unit);
                // IF UnitsS.FIND('-') THEN BEGIN
                //     "No. Of Units" := UnitsS."No. Units";
                //     Units := UnitsS."No. Units";
                //     // IF NOT (Grade IN ['A','B','C','D','E']) THEN
                //     //Grade:='X';
                // END;



                Taken := TRUE;

            end;
        }
        field(8; "Programme Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme".Code;
        }
        field(9; "Stage Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD("Programme Filter"));
        }
        field(10; "Unit Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD("Programme"),
                                                           "Stage Code" = FIELD(Stage));
            ValidateTableRelation = false;
        }
        field(11; "Semester Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme Semesters".Semester WHERE("Programme Code" = FIELD("Programme Filter"));
        }
        field(12; "Unit Type"; Option)
        {
            Editable = false;
            OptionCaption = 'Core,Elective,Required';
            OptionMembers = Core,Elective,Required;
        }
        field(13; Taken; Boolean)
        {

            trigger OnValidate()
            begin
                UTaken := 0;
                UFound := FALSE;
                IF Taken = FALSE THEN
                    EXIT;

                // Check if external unit
                // UnitsS.RESET;
                // UnitsS.SETRANGE(UnitsS."Unit Code", Unit);
                // IF UnitsS.FIND('-') THEN BEGIN
                //     IF UnitsS."Programme Code" = '' THEN
                //         UnitsS."Programme Code" := Programme;
                //         IF UnitsS."Stage Code" = '' THEN
                //             UnitsS."Stage Code" := Stage;
                //     //UnitsS.MODIFY;
                // END;

                //Check no of units
                //Check no of units
                CourseReg.RESET;
                CourseReg.SETRANGE(CourseReg."Reg. Transacton ID", "Reg. Transacton ID");
                IF CourseReg.FIND('-') THEN BEGIN
                    CourseReg.CALCFIELDS(CourseReg."Units Taken");
                    IF Prog.GET(CourseReg.Programmes) THEN BEGIN
                        IF Prog."Max No. of Courses" > 0 THEN BEGIN
                            IF CourseReg."Units Taken" > (Prog."Max No. of Courses" - 1) THEN
                                ERROR('You cannot register for more than %1 units', Prog."Max No. of Courses");

                        END;
                    END;
                END;



                // UnitsS.RESET;
                // //UnitsS.SETRANGE(UnitsS."Programme Code",Programme);
                // UnitsS.SETRANGE(UnitsS.Code, Unit);
                // IF UnitsS.FIND('-') THEN BEGIN
                //     IF UnitsS.Prerequisite <> '' THEN BEGIN
                //         StudUnits.RESET;
                //         StudUnits.SETRANGE(StudUnits."Student No.", "Student No.");
                //         StudUnits.SETRANGE(StudUnits.Unit, UnitsS.Prerequisite);
                //         StudUnits.SETRANGE(StudUnits.Taken, TRUE);
                //         //IF StudUnits.FIND('-') = FALSE THEN
                //         //ERROR('Student must do the prerequisite unit %1.',UnitsS.Prerequisite);

                //     END;
                // END;

                //Check if timetabled.
                EXIT;
                /////////////////////
                UTaken := 0;
                UFound := FALSE;
                TTable.RESET;
                TTable.SETRANGE(TTable.Programme, Programme);
                //TTable.SETRANGE(TTable.Stage,Stage);
                TTable.SETRANGE(TTable.Unit, Unit);
                TTable.SETRANGE(TTable.Semester, Semester);
                IF TTable.FIND('-') THEN BEGIN
                    //Check TT Conflict

                    Days.RESET;
                    IF Days.FIND('-') THEN BEGIN
                        REPEAT

                            Lessons.RESET;
                            IF Lessons.FIND('-') THEN BEGIN
                                REPEAT

                                    TTable2.RESET;
                                    TTable2.SETRANGE(TTable2.Released, FALSE);
                                    TTable2.SETRANGE(TTable2.Programme, Programme);
                                    //TTable2.SETRANGE(TTable2.Stage,Stage);
                                    TTable2.SETRANGE(TTable2.Semester, Semester);
                                    TTable2.SETRANGE(TTable2."Day of Week", Days.Day);
                                    TTable2.SETRANGE(TTable2.Period, Lessons.Code);
                                    IF TTable2.FIND('-') THEN BEGIN
                                        //MESSAGE('%1',TTable2.COUNT);
                                        IF TTable2.COUNT > 1 THEN BEGIN
                                            REPEAT
                                                StudUnits.RESET;
                                                StudUnits.SETRANGE(StudUnits."Student No.", "Student No.");
                                                StudUnits.SETRANGE(StudUnits.Taken, TRUE);
                                                StudUnits.SETRANGE(StudUnits."Reg. Transacton ID", "Reg. Transacton ID");
                                                StudUnits.SETRANGE(StudUnits.Unit, TTable2.Unit);
                                                IF StudUnits.FIND('-') THEN BEGIN
                                                    UTaken := UTaken + 1;

                                                END;


                                                IF TTable2.Unit = Unit THEN
                                                    UFound := TRUE;

                                            UNTIL TTable2.NEXT = 0;

                                            IF (UFound = TRUE) AND (UTaken > 0) THEN
                                                ERROR('This will cause a student time table conflict on %1 - %2', Days.Day, Lessons.Code);

                                        END;
                                    END;
                                UNTIL Lessons.NEXT = 0;
                            END;


                        UNTIL Days.NEXT = 0;
                    END;

                    Remarks := '';
                END ELSE
                    Remarks := 'Not timetabled.';
            end;
        }
        field(14; "Student Type Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = 'FULL TIME,PART TIME';
            OptionMembers = "FULL TIME","PART TIME";
            // TableRelation = "ACA-Course Registration"."Student Type";
        }
        field(15; "Category Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(16; UnitCount; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE(Programme = FIELD(Programme),
                                                           Stage = FIELD(Stage),
                                                           Semester = FIELD(Semester),
                                                           Unit = FIELD(Unit)));
            FieldClass = FlowField;
        }
        field(17; "Total Score"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Results".Score WHERE("Student No." = FIELD("Student No."),
                                                              Programmes = FIELD(Programme),
                                                              Unit = FIELD(Unit),
                                                              // Cancelled = CONST(false),
                                                              Semester = FIELD(Semester)));
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; Exempted; Boolean)
        {

            trigger OnValidate()
            begin
                Taken := FALSE;
            end;
        }
        field(19; Attendance; Decimal)
        {
        }
        field(20; "Allow Supplementary"; Boolean)
        {
        }
        field(21; "Sat Supplementary"; Boolean)
        {
        }
        field(22; "Repeat Unit"; Boolean)
        {

            trigger OnValidate()
            begin
                /*
                IF "Repeat Unit" = TRUE THEN BEGIN
                //CALCFIELDS("Total Score");
                Taken:=TRUE;
                END ELSE BEGIN
                Taken:=FALSE;
                END;
                */

            end;
        }
        field(50; Remarks; Text[200])
        {
            CalcFormula = Lookup("ACA-Exam Grading Source".Remarks WHERE("Exam Catregory" = FIELD("Exam Category"),
                                                                        CatMarksExist = field("CATs Marks Exists"),
                                                                        ExamMarksExist = field("EXAMs Marks Exists"),
                                                                        "Total Score" = field("Total Score")));
            FieldClass = FlowField;
        }
        field(51; "Unit Stage"; Code[20])
        {
            CalcFormula = Lookup("ACA-Units/Subjects"."Stage Code" WHERE("Programme Code" = FIELD(Programme),
                                                                        Code = FIELD(Unit)));
            FieldClass = FlowField;
        }
        field(52; Failed; Boolean)
        {
        }
        field(55; "Course Type"; Option)
        {
            OptionCaption = 'Core,Elective,Required';
            OptionMembers = Core,Elective,Required;
        }
        field(56; Audit; Boolean)
        {
        }
        field(57; Status; Option)
        {
            CalcFormula = Lookup(Customer.Status WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
            OptionCaption = 'Registration,Current,Alluminae,Dropped Out,Deffered,Suspended,Expulsion,Discontinued,Deferred,Deceased,Transferred,Disciplinary,Unknown,Completed not graduated,Graduated no Certificates,Graduated with Certificate,Did Not Report,Absconded,Transferred from MSN,Transferred to MSN,Resit';
            OptionMembers = Registration,Current,Alluminae,"Dropped Out",Deffered,Suspended,Expulsion,Discontinued,Deferred,Deceased,Transferred,Disciplinary,Unknown,"Completed not graduated","Graduated no Certificates","Graduated with Certificate","Did Not Report",Absconded,"Transferred from MSN","Transferred to MSN",Resit;

            trigger OnValidate()
            begin
                IF xRec.Status <> Status THEN BEGIN
                    StatusC.INIT;
                    StatusC."Student No" := "Student No.";
                    StatusC."Programme Code" := Programme;
                    StatusC."Stage Code" := Stage;
                    StatusC.Code := Unit;
                    StatusC.Status := FORMAT(Status);
                    StatusC.Date := TODAY;
                    StatusC."User ID" := USERID;
                    StatusC.Semester := GETFILTER("Semester Filter");
                    StatusC.Remarks := Remarks;
                    StatusC."Status Type" := 'Thesis';
                    StatusC.INSERT;

                END;

                IF Status = Status::Current THEN
                    "Proposal Date" := TODAY;

                IF Status = Status::Alluminae THEN
                    "Senate-Proposal" := TODAY;

                IF Status = Status::"Dropped Out" THEN
                    Research := TODAY;

                IF Status = Status::Alluminae THEN
                    "Senate-Proposal" := TODAY;

                IF Status = Status::Suspended THEN
                    Examiners := TODAY;

                IF Status = Status::Expulsion THEN
                    Defense := TODAY;
            end;
        }
        field(58; "Details Count"; Integer)
        {
            CalcFormula = Count("ACA-Post Grad Change History" WHERE("Student No" = FIELD("Student No."),
                                                                      "Programme Code" = FIELD(Programme),
                                                                      "Stage Code" = FIELD(Stage),
                                                                      Code = FIELD(Unit)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(59; "No. Of Units"; Decimal)
        {
        }
        field(60; "Project Status"; Option)
        {
            OptionCaption = '  ,Proposal,Faculty/School Approval,Research,Exam';
            OptionMembers = "  ",Proposal,"Faculty/School Approval",Research,Exam;

            trigger OnValidate()
            begin

                IF xRec."Project Status" <> "Project Status" THEN BEGIN
                    StatusC.INIT;
                    StatusC."Student No" := "Student No.";
                    StatusC."Programme Code" := Programme;
                    StatusC."Stage Code" := Stage;
                    StatusC.Code := Unit;
                    StatusC.Status := FORMAT("Project Status");
                    StatusC.Date := TODAY;
                    StatusC."User ID" := USERID;
                    StatusC.Semester := GETFILTER("Semester Filter");
                    StatusC.Remarks := Remarks;
                    StatusC."Status Type" := 'Project';
                    StatusC.INSERT;

                END;
            end;
        }
        field(61; "Final Score"; Decimal)
        {
            FieldClass = Normal;
        }
        field(62; "Created by"; Code[50])
        {
        }
        field(63; "Edited By"; Code[50])
        {
        }
        field(64; "Date created"; Date)
        {
        }
        field(65; "Date Edited"; Date)
        {
        }
        field(66; "Cummulative Year Filter"; Code[20])
        {
            Caption = 'Cummulative Year Filter';
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD("Programme Filter"));
        }
        field(67; "Total Marks"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(68; "External Unit"; Boolean)
        {
            FieldClass = FlowFilter;
        }
        field(69; "External Units"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = ' ,External';
            OptionMembers = " ",External;
        }
        field(70; "System Created"; Boolean)
        {
        }
        field(71; Multiple; Boolean)
        {
        }
        field(72; "Entry No."; Integer)
        {
        }
        field(73; "Student Class"; Code[20])
        {
            TableRelation = "ACA-Units Classes".Code WHERE(Programmes = FIELD(Programme),
                                                            Stage = FIELD(Stage),
                                                            Code = FIELD(Unit));
        }
        field(74; ENo; Integer)
        {
        }
        field(75; "System Taken"; Boolean)
        {
        }
        field(76; "Repeat Marks"; Decimal)
        {
        }
        field(77; "Re-Take"; Boolean)
        {
        }
        field(78; "Proposal Status"; Option)
        {
            OptionCaption = ' ,SGS Board Approval,Senate Approval,SGS Research Refund';
            OptionMembers = " ","SGS Board Approval","Senate Approval","SGS Research Refund";

            trigger OnValidate()
            begin

                IF xRec."Proposal Status" <> "Proposal Status" THEN BEGIN
                    StatusC.INIT;
                    StatusC."Student No" := "Student No.";
                    StatusC."Programme Code" := Programme;
                    StatusC."Stage Code" := Stage;
                    StatusC.Code := Unit;
                    StatusC.Status := FORMAT("Proposal Status");
                    StatusC.Date := TODAY;
                    StatusC."User ID" := USERID;
                    StatusC.Semester := GETFILTER("Semester Filter");
                    StatusC.Remarks := Remarks;
                    StatusC."Status Type" := 'Proposal';
                    StatusC.INSERT;

                END;
            end;
        }
        field(79; "Proposal Date"; Date)
        {
        }
        field(80; "Senate-Proposal"; Date)
        {
        }
        field(81; Research; Date)
        {
        }
        field(82; "Senate-Research"; Date)
        {
        }
        field(83; Examiners; Date)
        {
        }
        field(84; Defense; Date)
        {
        }
        field(85; "Category Code"; Code[20])
        {
            FieldClass = Normal;
            TableRelation = "ACA-Exam Category".Code;
        }
        field(86; "Progress Report"; Option)
        {
            OptionCaption = ' ,1st Progress,2nd Progress,3rd Progress,4th Progress';
            OptionMembers = " ","1st Progress","2nd Progress","3rd Progress","4th Progress";

            trigger OnValidate()
            begin
                IF xRec."Progress Report" <> "Progress Report" THEN BEGIN
                    StatusC.INIT;
                    StatusC."Student No" := "Student No.";
                    StatusC."Programme Code" := Programme;
                    StatusC."Stage Code" := Stage;
                    StatusC.Code := Unit;
                    StatusC.Status := FORMAT("Progress Report");
                    StatusC.Date := TODAY;
                    StatusC."User ID" := USERID;
                    StatusC.Semester := GETFILTER("Semester Filter");
                    StatusC.Remarks := Remarks;
                    StatusC."Status Type" := 'Progress Report';
                    StatusC.INSERT;

                END;
            end;
        }
        field(87; "Progress Date"; Date)
        {
        }
        field(88; "Defence OutCome"; Option)
        {
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
        }
        field(89; Description; Text[250])
        {
            CalcFormula = lookup("ACA-Units Master Table"."Unit Name" where("Unit Code" = field(Unit)));
            FieldClass = FlowField;
        }
        field(90; "Student Type"; Option)
        {
            OptionCaption = 'Full Time,Part Time,Distance Learning';
            OptionMembers = "Full Time","Part Time","Distance Learning";
        }
        field(94; "Main Programme"; Code[20])
        {
            CalcFormula = Lookup("ACA-Course Registration".Programmes WHERE("Student No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(95; "Registered Programe"; Code[20])
        {
            CalcFormula = Lookup("ACA-Course Registration".Programmes WHERE("Student No." = FIELD("Student No."),
                                                                            Semester = FIELD(Semester),
                                                                            Programmes = FILTER(<> '')));
            FieldClass = FlowField;
        }
        field(96; "Semester Registered"; Boolean)
        {
            CalcFormula = Lookup("ACA-Course Registration".Registered WHERE("Student No." = FIELD("Student No."),
                                                                             Semester = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(20015; "Marks Status"; Option)
        {
            OptionCaption = ' ,Y,S,I,F,NDP';
            OptionMembers = " ",Y,S,I,F,NDP;
        }
        field(20016; "Student Name"; Text[100])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(20023; "CAT-1"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Results".Score WHERE(Exam = FILTER('CAT|CAT1|CAT 1'),
                                                              Programmes = FIELD(Programme),
                                                              "Student No." = FIELD("Student No."),
                                                              Unit = FIELD(Unit),
                                                              Semester = FIELD(Semester),
                                                              ExamType = FILTER('CAT|CAT1|CAT 1')));
            //   "Both Cancelled" = FILTER(false),
            //   "Exam Cancelled" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(20024; "CAT-2"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Results".Contribution WHERE(Exam = FILTER('CAT|CAT2|CAT 2'),
                                                                     Programmes = FIELD(Programme),
                                                                     "Student No." = FIELD("Student No."),
                                                                     Unit = FIELD(Unit),
                                                                     Semester = FIELD(Semester),
                                                                     ExamType = FILTER('CAT|CAT2|CAT 2')));
            //  "Both Cancelled" = FILTER(false),
            //  "CAT Cancelled" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(20025; "Result Status"; Code[50])
        {
        }
        field(20026; "Registration Status"; Option)
        {
            CalcFormula = Lookup(Customer.Status WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
            OptionCaption = 'Registration,Current,Alluminae,Dropped Out,Deffered,Suspended,Expulsion,Discontinued,Deferred,Deceased,Transferred,Disciplinary,Unknown,Completed not graduated,Graduated no Certificates,Graduated with Certificate,Did Not Report,Absconded,Transferred from MSN,Transferred to MSN,Resit';
            OptionMembers = Registration,Current,Alluminae,"Dropped Out",Deffered,Suspended,Expulsion,Discontinued,Deferred,Deceased,Transferred,Disciplinary,Unknown,"Completed not graduated","Graduated no Certificates","Graduated with Certificate","Did Not Report",Absconded,"Transferred from MSN","Transferred to MSN",Resit;
        }
        field(20027; "Ass Total Marks"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Results".Score WHERE(Exam = CONST('ASSIGNMENT'),
                                                              Programmes = FIELD(Programme),
                                                              "Student No." = FIELD("Student No."),
                                                              Unit = FIELD(Unit),
                                                              Semester = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(20028; "CAT Total Marks"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Results".Score WHERE(Exam = FILTER('CAT|CATS'),
                                                              Programmes = FIELD(Programme),
                                                              "Student No." = FIELD("Student No."),
                                                              Unit = FIELD(Unit),
                                                              Semester = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(20029; "Exam Marks"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Results".Score WHERE(Exam = FILTER('EXAM|MAIN EXAM|FINAL EXAM'),
                                                              Programmes = FIELD(Programme),
                                                              "Student No." = FIELD("Student No."),
                                                              Unit = FIELD(Unit),
                                                              Semester = FIELD(Semester),
                                                              ExamType = FILTER('EXAM|MAIN EXAM|FINAL EXAM')));
            FieldClass = FlowField;
        }
        field(20030; Category; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Exams Setup".Category;
        }
        field(20031; "Exam Type"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Exams Setup".Code;
        }
        field(20032; "Exam Period"; Code[20])
        {
            TableRelation = "ACA-Exam Periods".Code;

            trigger OnValidate()
            begin
                // IF ExamPeriod.GET("Exam Period") THEN
                //    IF ExamPeriod.DeadLine<TODAY THEN ERROR('Please Note That you can Not Enter Marks for Expired Exams');
                // MESSAGE("Exam Period") ;
            end;
        }
        field(20033; "Exam Status"; Option)
        {
            OptionCaption = 'Lecturer,Faculty,Moderators';
            OptionMembers = Lecturer,Faculty,Moderators;
        }
        field(20034; "Staff Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "HRM-Employee (D)"."No." WHERE(Lecturer = CONST(true));
        }
        field(20035; Lecturer; Code[30])
        {
            CalcFormula = Lookup("ACA-Units Offered".Lecturer WHERE(Stream = field(Stream), ModeOfStudy = field(ModeOfStudy), "Unit Base Code" = FIELD(Unit), Semester = FIELD(Semester), Campus = field("Campus Code")));
            FieldClass = FlowField;
        }
        field(20036; Grade; Code[50])
        {
            CalcFormula = Lookup("ACA-Exam Grading Source".Grade WHERE("Exam Catregory" = FIELD("Exam Category"),
                                                                        CatMarksExist = field("CATs Marks Exists"),
                                                                        ExamMarksExist = field("EXAMs Marks Exists"),
                                                                        "Total Score" = field("Total Score")));
            FieldClass = FlowField;
            // trigger OnLookup()
            // begin
            //     if Rec.Grade = 'F' then begin
            //         if Rec."EXAMs Marks Exists" = false then
            //         Rec.Grade := 'I';
            //         Rec.Modify();
            //     end;
            // end;
            // trigger OnLookup()
            // begin
            // //     CalcFields(rec.Grade);
            // //   if Rec.Grade='F' then begin
            // //     Rec.Grade := 'I';
            // //     Rec.Modify();



            //    end
            // end;
            // trigger OnValidate()
            // var
            //     ACAAcademicYear: Record 61382;
            //     AcaSpecialExamsDetails: Record 78002;
            // begin
            //     IF ("Consolidated Mark Pref." = '^') THEN BEGIN
            //         ACAAcademicYear.RESET;
            //         ACAAcademicYear.SETRANGE(Current, TRUE);
            //         IF ACAAcademicYear.FIND('-') THEN BEGIN

            //         END ELSE
            //             ERROR('Current Academic Year has not been defined!');

            //         AcaSpecialExamsDetails.RESET;
            //         AcaSpecialExamsDetails.SETRANGE("Student No.", Rec."Student No.");
            //         AcaSpecialExamsDetails.SETFILTER(Catogory, '%1', AcaSpecialExamsDetails.Catogory::Supplementary);
            //         AcaSpecialExamsDetails.SETRANGE("Unit Code", Rec.Unit);
            //         AcaSpecialExamsDetails.SETRANGE(Semester, Rec.Semester);
            //         AcaSpecialExamsDetails.SETRANGE("Current Academic Year", ACAAcademicYear."Code");
            //         IF NOT (AcaSpecialExamsDetails.FIND('-')) THEN BEGIN
            //             //Create it
            //             AcaSpecialExamsDetails.INIT;
            //             AcaSpecialExamsDetails."Academic Year" := Rec."Academic Year";
            //             AcaSpecialExamsDetails.Semester := Rec.Semester;
            //             AcaSpecialExamsDetails."Student No." := Rec."Student No.";
            //             AcaSpecialExamsDetails.Stage := Rec.Stage;
            //             AcaSpecialExamsDetails.Programme := Rec.Programme;
            //             AcaSpecialExamsDetails."Unit Code" := Rec.Unit;
            //             AcaSpecialExamsDetails.Catogory := AcaSpecialExamsDetails.Catogory::Supplementary;
            //             AcaSpecialExamsDetails."Current Academic Year" := ACAAcademicYear."Code";
            //             AcaSpecialExamsDetails.INSERT;
            //         END ELSE BEGIN
            //             //IF found Delete & reregister if marks not exists
            //             //AcaSpecialExamsDetails.SETFILTER("Total Marks",'>%1',40);
            //             //AcaSpecialExamsDetails.SETFILTER("Marks Exists",'%1',TRUE);
            //             //IF AcaSpecialExamsDetails.FIND('-') THEN ERROR('Marks have already been posted for Supplementary exams');

            //         END;
            //     END;
            // end;
        }
        field(20037; "Supp Taken"; Boolean)
        {
        }
        field(20038; "Failed Units Count"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Unit = FIELD(Unit),
                                                           Failed = CONST(true)));
            FieldClass = FlowField;
        }
        field(20039; "Unit Reg Count"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Unit = FIELD(Unit)));
            FieldClass = FlowField;
        }
        field(20040; "Exam Period Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Exam Periods".Code;

            trigger OnValidate()
            begin
                // IF ExamPeriod.GET("Exam Period") THEN
                //    IF ExamPeriod.DeadLine<TODAY THEN ERROR('Please Note That you can Not Enter Marks for Expired Exams');
                // MESSAGE("Exam Period") ;
            end;
        }
        field(20041; "Unit Fees"; Decimal)
        {
            CalcFormula = Lookup("ACA-Fee By Stage"."Break Down" WHERE("Programme Code" = FIELD(Programme),
                                                                        "Stage Code" = FIELD(Stage),
                                                                        Semester = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(20042; "Actual Fees"; Decimal)
        {
        }
        field(20043; "Reg Reversed"; Boolean)
        {
            CalcFormula = Lookup("ACA-Course Registration".Reversed WHERE("Student No." = FIELD("Student No."),
                                                                           "Reg. Transacton ID" = FIELD("Reg. Transacton ID")));
            FieldClass = FlowField;
        }
        field(20044; "Units Reg. Status"; Option)
        {
            OptionCaption = ' ,Specials,Academic Leave,WithHold,Deregister,Discontinue,Nullification,Deffer';
            OptionMembers = " ",Specials,"Academic Leave",WithHold,Deregister,Discontinue,Nullification,Deffer;
        }
        field(50000; Reversed; Boolean)
        {
        }
        field(50001; "Unit Name"; Text[100])
        {
        }
        field(50002; "Session Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Student Types".Code;
        }
        field(50003; "Lecturer Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "HRM-Employee (D)"."No." WHERE(Lecturer = CONST(true));
        }
        field(50004; "Intake Code"; Code[20])
        {
            CalcFormula = Lookup("ACA-Course Registration"."Intake Code" WHERE("Student No." = FIELD("Student No."),
                                                                                "Reg. Transacton ID" = FIELD("Reg. Transacton ID"),
                                                                                Programmes = FIELD(Programme),
                                                                                Stage = FIELD(Stage)));
            FieldClass = FlowField;
        }
        field(50005; "Unit Description"; Text[150])
        {
            CalcFormula = Lookup("ACA-Units/Subjects".Desription WHERE("Programme Code" = FIELD(Programme), Code = FIELD(Unit)));
            // "Old Unit" = FILTER(false)));
            FieldClass = FlowField;
        }
#pragma warning disable AL0603
        field(50006; Blocked; Option)
#pragma warning restore AL0603
        {
            CalcFormula = Lookup(Customer.Blocked WHERE("No." = FIELD("Student No.")));
            Caption = 'Blocked';
            FieldClass = FlowField;
            OptionCaption = ' ,Ship,Invoice,All';
            OptionMembers = " ",Ship,Invoice,All;
        }
        field(50007; "Session Code"; Code[20])
        {
            CalcFormula = Lookup("ACA-Course Registration".Session WHERE("Student No." = FIELD("Student No."),
                                                                          "Reg. Transacton ID" = FIELD("Reg. Transacton ID")));
            FieldClass = FlowField;
            TableRelation = "ACA-Intake".Code;
        }
        field(50008; "Cust Exist"; Integer)
        {
            CalcFormula = Count(Customer WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(50009; Registered; Boolean)
        {
            CalcFormula = Lookup("ACA-Course Registration".Registered WHERE("Student No." = FIELD("Student No."),
                                                                             Programmes = FIELD(Programme),
                                                                             Semester = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(50010; "CF Score"; Decimal)
        {
            Description = 'Stores CF * Score';
        }
        field(50011; "Ignore in Final Average"; Boolean)
        {
            CalcFormula = Lookup("ACA-Units/Subjects"."Ignore in Final Average" WHERE("Programme Code" = FIELD(Programme),
                                                                                     Code = FIELD(Unit)));
            FieldClass = FlowField;
        }
        field(50012; "Ignore in Cumm  Average"; Boolean)
        {
        }
        field(50013; "Attachment Unit"; Boolean)
        {
        }
        field(50014; "Reg. Results Status"; Code[50])
        {
            CalcFormula = Lookup("ACA-Course Registration"."Exam Status" WHERE("Student No." = FIELD("Student No."),
                                                                                Programmes = FIELD(Programme),
                                                                                Semester = FIELD(Semester),
                                                                                Stage = FIELD(Stage)));
            FieldClass = FlowField;
        }
        field(50015; "Academic Year"; Code[20])
        {

            trigger OnValidate()
            begin
                IF ((xRec."Academic Year" <> Rec."Academic Year")) THEN BEGIN
                    ACAExamResults.RESET;
                    ACAExamResults.SETRANGE(Unit, Rec.Unit);
                    ACAExamResults.SETRANGE(Semester, xRec.Semester);
                    ACAExamResults.SETRANGE("Student No.", Rec."Student No.");
                    ACAExamResults.SETRANGE(Stage, xRec.Stage);
                    IF ACAExamResults.FIND('-') THEN BEGIN
                        REPEAT
                            ACAExamResults."Academic Year" := Rec."Academic Year";
                            ACAExamResults.MODIFY;
                        UNTIL ACAExamResults.NEXT = 0;
                    END;

                END;
            end;
        }
        field(50017; "Student Code"; Code[20])
        {
        }
        field(50018; "Campus Code"; Code[20])
        {
            CalcFormula = Lookup(Customer."Global Dimension 1 Code" WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(50019; "Campus Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50020; "Reg Option"; Code[20])
        {
            CalcFormula = Lookup("ACA-Course Registration".Options WHERE("Student No." = FIELD("Student No."),
                                                                          Semester = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(50021; Examiner1; Text[30])
        {
        }
        field(50022; Examiner2; Text[30])
        {
        }
        field(50023; Examiner3; Text[30])
        {
        }
        field(50024; Examiner4; Text[30])
        {
        }
        field(50025; Show; Boolean)
        {
        }
        field(50026; "Settlement Type"; Code[20])
        {

            //FieldClass = FlowField;
        }
        field(50067; "Credited Hours"; Decimal)
        {
            CalcFormula = Lookup("ACA-Units/Subjects"."Credit Hours" WHERE("Programme Code" = FIELD(Programme),
                                                                          "Stage Code" = FIELD(Stage),
                                                                          Code = FIELD(Unit)));
            FieldClass = FlowField;
        }
        field(50068; "Unit Points"; Decimal)
        {
        }
        field(50069; "Credit Hours"; Decimal)
        {
        }
        field(50070; "Cancelled Score"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Results".Contribution WHERE("Student No." = FIELD("Student No."),
                                                                     Programmes = FIELD(Programme),
                                                                     Semester = FIELD(Semester),
                                                                     Unit = FIELD(Unit),
                                                                     Semester = FIELD(Semester)));
            //Cancelled = CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50071; Supervisor; Code[20])
        {
            TableRelation = "ACA-Lecturers/Examiners"."No.";
        }
        field(50072; "Released Results"; Boolean)
        {
            CalcFormula = Lookup("ACA-Semesters"."Released Results" WHERE(Code = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(50073; "Old Unit"; Boolean)
        {
        }
        field(50074; "Old Unit Lk"; Boolean)
        {
            CalcFormula = Lookup("ACA-Units/Subjects"."Old Unit" WHERE("Programme Code" = FIELD(Programme),
                                                                      "Stage Code" = FIELD(Stage),
                                                                      Code = FIELD(Unit)));
            FieldClass = FlowField;
        }
        field(50075; "CATs Marks"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Results".Score WHERE(Exam = FILTER('CAT|CAT1|CAT 1|CAT2|CAT 2|CATS'),
                                                              Programmes = FIELD(Programme),
                                                              "Student No." = FIELD("Student No."),
                                                              Unit = FIELD(Unit),
                                                              Semester = FIELD(Semester),
                                                              ExamType = FILTER('CAT|CAT1|CAT 1|CAT2|CAT 2|CATS')));
            // "Both Cancelled" = FILTER(false),
            // "CAT Cancelled" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(50076; "EXAMs Marks"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Results".Score WHERE(Exam = FILTER('EXAM|MAIN EXAM|FINAL EXAM'),
                                                              Programmes = FIELD(Programme),
                                                              "Student No." = FIELD("Student No."),
                                                              Unit = FIELD(Unit),
                                                              Semester = FIELD(Semester),
                                                              ExamType = FILTER('EXAM|MAIN EXAM|FINAL EXAM')));
            //   Both Cancelled=FILTER(No),
            //   Exam Cancelled=FILTER(No)));
            FieldClass = FlowField;
        }
        field(50077; "Year Of Study"; Integer)
        {
            CalcFormula = Lookup("ACA-Course Registration"."Year Of Study" WHERE("Student No." = FIELD("Student No."),
                                                                                  Semester = FIELD(Semester),
                                                                                  Programmes = FIELD(Programme),
                                                                                  Reversed = FILTER(false)));
            FieldClass = FlowField;
        }
        field(50078; "Consolidated Mark Identifier"; Code[2])
        {
        }
        field(50079; Units; Integer)
        {

            trigger OnValidate()
            begin
                Units := 1;
            end;
        }
        field(50080; "Weighted Units"; Decimal)
        {
        }
        field(50081; "CATs Marks Exists"; Boolean)
        {
            CalcFormula = Exist("ACA-Exam Results" WHERE(Exam = FILTER('CAT|CAT1|CAT 1|CAT2|CAT 2'),
                                                          Programmes = FIELD(Programme),
                                                          "Student No." = FIELD("Student No."),
                                                          Unit = FIELD(Unit),
                                                          Semester = FIELD(Semester),
                                                          ExamType = FILTER('CAT|CAT1|CAT 1|CAT2|CAT 2')));
            //   Both Cancelled=FILTER(No),
            //   CAT Cancelled=FILTER(No)));
            FieldClass = FlowField;
        }
        field(50082; "EXAMs Marks Exists"; Boolean)
        {
            CalcFormula = Exist("ACA-Exam Results" WHERE(Exam = FILTER('EXAM|MAIN EXAM|FINAL EXAM'),
                                                          Programmes = FIELD(Programme),
                                                          "Student No." = FIELD("Student No."),
                                                          Unit = FIELD(Unit),
                                                          Semester = FIELD(Semester),
                                                          ExamType = FILTER('EXAM|MAIN EXAM|FINAL EXAM')));
            //   Both Cancelled=FILTER(No),
            //   Exam Cancelled=FILTER(No)));
            FieldClass = FlowField;
        }
        field(50083; "Consolidated Mark Pref."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50084; "Reg. Reversed"; Boolean)
        {
            CalcFormula = Lookup("ACA-Course Registration".Reversed WHERE(Programmes = FIELD(Programme),
                                                                           "Student No." = FIELD("Student No."),
                                                                           Semester = FIELD(Semester),
                                                                           Stage = FIELD(Stage),
                                                                          "Reg. Transacton ID" = FIELD("Reg. Transacton ID")));
            FieldClass = FlowField;
        }
        field(50085; "Special Exam"; Option)
        {
            OptionCaption = ' ,Special,Suspension,Supplementary';
            OptionMembers = " ",Special,Suspension,Supplementary;

            trigger OnValidate()
            var
                AcaSpecialExamsDetails: Record 78002;
                ACAAcademicYear: Record 61382;
            begin
                IF Rec."Special Exam" <> Rec."Special Exam"::" " THEN BEGIN
                    IF Rec."Reason for Special Exam/Susp." = '' THEN ERROR('Specify the reason for ' + FORMAT(Rec."Special Exam") + ' first.');
                END;
                IF ((Rec."Special Exam" = Rec."Special Exam"::Special) AND
                  (Rec."Supp. Registered & Passed" = FALSE)) THEN BEGIN
                    ACAAcademicYear.RESET;
                    ACAAcademicYear.SETRANGE(Current, TRUE);
                    IF ACAAcademicYear.FIND('-') THEN BEGIN

                    END ELSE
                        ERROR('Current Academic Year has not been defined!');

                    AcaSpecialExamsDetails.RESET;
                    AcaSpecialExamsDetails.SETRANGE("Student No.", Rec."Student No.");
                    AcaSpecialExamsDetails.SETFILTER(Catogory, '%1', AcaSpecialExamsDetails.Catogory::Special);
                    AcaSpecialExamsDetails.SETRANGE("Unit Code", Rec.Unit);
                    AcaSpecialExamsDetails.SETRANGE(Semester, Rec.Semester);
                    IF NOT (AcaSpecialExamsDetails.FIND('-')) THEN BEGIN
                        //Create it
                        AcaSpecialExamsDetails.INIT;
                        AcaSpecialExamsDetails."Academic Year" := Rec."Academic Year";
                        AcaSpecialExamsDetails.Semester := Rec.Semester;
                        AcaSpecialExamsDetails."Student No." := Rec."Student No.";
                        AcaSpecialExamsDetails.Stage := Rec.Stage;
                        AcaSpecialExamsDetails.Programme := Rec.Programme;
                        AcaSpecialExamsDetails."Unit Code" := Rec.Unit;
                        AcaSpecialExamsDetails.Catogory := AcaSpecialExamsDetails.Catogory::Special;
                        AcaSpecialExamsDetails."Current Academic Year" := ACAAcademicYear.Code;
                        AcaSpecialExamsDetails.INSERT;
                    END ELSE BEGIN
                        //IF found Delete & reregister if marks not exists
                        //AcaSpecialExamsDetails.SETFILTER("Total Marks",'>%1',40);
                        AcaSpecialExamsDetails.SETFILTER("Marks Exists", '%1', TRUE);
                        IF AcaSpecialExamsDetails.FIND('-') THEN ERROR('Marks have already been posted for special exams');

                    END;
                END ELSE
                    IF ((Rec."Special Exam" = Rec."Special Exam"::" ") AND
             (Rec."Supp. Registered & Passed" = FALSE)) THEN BEGIN
                        //Delete from Special if Marks are not yet posted
                        AcaSpecialExamsDetails.RESET;
                        AcaSpecialExamsDetails.SETRANGE("Student No.", Rec."Student No.");
                        AcaSpecialExamsDetails.SETFILTER(Catogory, '%1', AcaSpecialExamsDetails.Catogory::Special);
                        AcaSpecialExamsDetails.SETRANGE("Unit Code", Rec.Unit);
                        AcaSpecialExamsDetails.SETRANGE(Semester, Rec.Semester);
                        IF AcaSpecialExamsDetails.FIND('-') THEN BEGIN
                            AcaSpecialExamsDetails.SETFILTER("Marks Exists", '%1', FALSE);
                            IF AcaSpecialExamsDetails.FIND('-') THEN
                                AcaSpecialExamsDetails.DELETE
                            ELSE
                                ERROR('There exists marks for the Unit under special examinations\Modification of this status is not allowed!');
                        END;
                    END ELSE
                        IF ((Rec."Special Exam" = Rec."Special Exam"::Supplementary) AND
               (Rec."Supp. Registered & Passed" = FALSE)) THEN BEGIN
                            ACAAcademicYear.RESET;
                            ACAAcademicYear.SETRANGE(Current, TRUE);
                            IF ACAAcademicYear.FIND('-') THEN BEGIN

                            END ELSE
                                ERROR('Current Academic Year has not been defined!');

                            AcaSpecialExamsDetails.RESET;
                            AcaSpecialExamsDetails.SETRANGE("Student No.", Rec."Student No.");
                            AcaSpecialExamsDetails.SETFILTER(Catogory, '%1', AcaSpecialExamsDetails.Catogory::Supplementary);
                            AcaSpecialExamsDetails.SETRANGE("Unit Code", Rec.Unit);
                            AcaSpecialExamsDetails.SETRANGE(Semester, Rec.Semester);
                            IF NOT (AcaSpecialExamsDetails.FIND('-')) THEN BEGIN
                                //Create it
                                AcaSpecialExamsDetails.INIT;
                                AcaSpecialExamsDetails."Academic Year" := Rec."Academic Year";
                                AcaSpecialExamsDetails.Semester := Rec.Semester;
                                AcaSpecialExamsDetails."Student No." := Rec."Student No.";
                                AcaSpecialExamsDetails.Stage := Rec.Stage;
                                AcaSpecialExamsDetails.Programme := Rec.Programme;
                                AcaSpecialExamsDetails."Unit Code" := Rec.Unit;
                                AcaSpecialExamsDetails.Catogory := AcaSpecialExamsDetails.Catogory::Supplementary;
                                AcaSpecialExamsDetails."Current Academic Year" := ACAAcademicYear.Code;
                                AcaSpecialExamsDetails.INSERT;
                            END ELSE BEGIN
                                //IF found Delete & reregister if marks not exists
                                //AcaSpecialExamsDetails.SETFILTER("Total Marks",'>%1',40);
                                AcaSpecialExamsDetails.SETFILTER("Marks Exists", '%1', TRUE);
                                IF AcaSpecialExamsDetails.FIND('-') THEN ERROR('Marks have already been posted for Supplementary exams');

                            END;
                        END;
            end;
        }
        field(50086; "Reason for Special Exam/Susp."; Text[100])
        {
        }
        field(50087; "Supp. Registered & Passed"; Boolean)
        {
            CalcFormula = Exist("Aca-Special Exams Details" WHERE("Student No." = FIELD("Student No."),
                                                                   "Unit Code" = FIELD(Unit),
                                                                   "Total Marks" = FILTER(> 39.99),
                                                                   "Unit Code" = FILTER(<> '')));
            FieldClass = FlowField;
        }
        field(50088; "No of Supplementaries"; Integer)
        {
            CalcFormula = Count("Aca-Special Exams Details" WHERE("Student No." = FIELD("Student No."),
                                                                   Catogory = FILTER(Supplementary),
                                                                   "Unit Code" = FIELD(Unit)));
            FieldClass = FlowField;
        }
        field(50089; "Supp. Total Score"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(50091; "Supp. Final Score"; Decimal)
        {
        }
        field(50092; "Supp. Total Marks"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(50093; "Supp. Exam Marks"; Decimal)
        {
        }
        field(50094; "Supp. Exam Period"; Code[20])
        {
            TableRelation = "ACA-Exam Periods".Code;

            trigger OnValidate()
            begin
                // IF ExamPeriod.GET("Exam Period") THEN
                //    IF ExamPeriod.DeadLine<TODAY THEN ERROR('Please Note That you can Not Enter Marks for Expired Exams');
                // MESSAGE("Exam Period") ;
            end;
        }
        field(50095; "Supp. Grade"; Code[50])
        {
        }
        field(50096; "Supp. Academic Year"; Code[20])
        {
        }
        field(50098; "Supp. Cons. Mark Identifier"; Code[2])
        {
        }
        field(50099; "Supp. Weighted Units"; Decimal)
        {
        }
        field(50100; "Supp. Cons. Mark Pref."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50101; "Final. Total Score"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(50102; "Final. Final Score"; Decimal)
        {
        }
        field(50103; "Final. Total Marks"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(50104; "Final. Exam Marks"; Decimal)
        {
        }
        field(50105; "Final. Exam Period"; Code[20])
        {
            TableRelation = "ACA-Exam Periods".Code;

            trigger OnValidate()
            begin
                // IF ExamPeriod.GET("Exam Period") THEN
                //    IF ExamPeriod.DeadLine<TODAY THEN ERROR('Please Note That you can Not Enter Marks for Expired Exams');
                // MESSAGE("Exam Period") ;
            end;
        }
        field(50106; "Final. Grade"; Code[50])
        {
        }
        field(50107; "Final. Academic Year"; Code[20])
        {
        }
        field(50108; "Final. Cons. Mark Identifier"; Code[2])
        {
        }
        field(50109; "Final. Weighted Units"; Decimal)
        {
        }
        field(50110; "Final. Cons. Mark Pref."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50111; "Supp. Exam Score"; Decimal)
        {
            CalcFormula = Lookup("Aca-Special Exams Details"."Exam Marks" WHERE("Student No." = FIELD("Student No."),
                                                                                 "Unit Code" = FIELD(Unit),
                                                                                 Semester = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(50112; "Include in Graduation"; Boolean)
        {
        }
        field(50113; "Unit Type (Flow)"; Option)
        {
            CalcFormula = Lookup("ACA-Units/Subjects"."Unit Type" WHERE("Programme Code" = FIELD(Programme),
                                                                       Code = FIELD(Unit)));
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Core,Elective,Required';
            OptionMembers = Core,Elective,Required;
        }
        field(50114; "Has Supplementary"; Boolean)
        {
            CalcFormula = Exist("Aca-Special Exams Details" WHERE("Student No." = FIELD("Student No."),
                                                                   "Unit Code" = FIELD(Unit)));
            FieldClass = FlowField;
        }
        field(50115; "VC Cleared"; Boolean)
        {
            CalcFormula = lookup(Customer."Fee Cleared" where("No." = field("Student No.")));
            FieldClass = FlowField;
        }
        field(60166; "Balance Due"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Customer No." = FIELD("Student No."),
                                                                         "Entry Type" = FILTER("Initial Entry")));
            Caption = 'Balance Due';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60167; "School Code"; Code[20])
        {
            CalcFormula = Lookup("ACA-Programme"."School Code" WHERE(Code = FIELD(Programme)));
            FieldClass = FlowField;
        }
        field(60168; "Unit Year of Study"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(60169; "Marks Exists"; Boolean)
        {
            CalcFormula = Exist("ACA-Exam Results" WHERE(Unit = FIELD(Unit),
                                                          Semester = FIELD(Semester),
                                                         "Student No." = FIELD("Student No."),
                                                          Programmes = FIELD(Programme)));
            FieldClass = FlowField;
        }
        field(60170; "Course Evaluated"; Boolean)
        {
            CalcFormula = Exist("ACA-Lecturers Evaluation" WHERE(Programme = FIELD(Programme),
                                                                  Unit = FIELD(Unit),
                                                                  Semester = FIELD(Semester),
                                                                  "Student No" = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(60171; "Exam Catogory"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60172; "Special Programme Class"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'General,Medicine & Nursing,Engineering';
            OptionMembers = General,"Medicine & Nursing",Engineering;
        }
        field(60173; "Supp. Failed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60174; "Courses Evaluated"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60176; "Exempted in Evaluation"; Boolean)
        {
        }
        field(60177; "Final Stage"; Code[20])
        {
            CalcFormula = Lookup("ACA-Programme Stages".Code WHERE("Programme Code" = FIELD(Programme),
                                                                    "Final Stage" = FILTER(true)));
            FieldClass = FlowField;
        }
        field(60178; "Exists Final Stage"; Boolean)
        {
            CalcFormula = Exist("ACA-Course Registration" WHERE("Student No." = FIELD("Student No."),
                                                                 Programmes = FIELD(Programme),
                                                                 Stage = FIELD("Final Stage")));
            FieldClass = FlowField;
        }
        field(60179; "Unit not in Catalogue"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60180; "Program Option (Flow)"; Code[20])
        {
            CalcFormula = Lookup("ACA-Course Registration".Options WHERE("Student No." = FIELD("Student No."),
                                                                          Programmes = FIELD(Programme),
                                                                          Options = FILTER('')));
            FieldClass = FlowField;
        }
        field(60181; "Academic Year (Flow)"; Code[20])
        {
            CalcFormula = Lookup("ACA-Semesters"."Academic Year" WHERE(Code = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(60182; "Prog. Category"; Option)
        {
            CalcFormula = Lookup("ACA-Programme".Category WHERE(Code = FIELD(Programme)));
            FieldClass = FlowField;
            OptionCaption = ',Certificate ,Diploma,Undergraduate,Postgraduate,Professional,Course List';
            OptionMembers = ,"Certificate ",Diploma,Undergraduate,Postgraduate,Professional,"Course List";
        }
        field(60183; "Processed Marks"; Boolean)
        {
            CalcFormula = Exist("ACA-Exam Classification Units" WHERE("Student No." = FIELD("Student No."),
                                                                       "Unit Code" = FIELD(Unit)));
            FieldClass = FlowField;
        }
        field(60184; Passed; Boolean)
        {
            CalcFormula = Exist("ACA-Exam Classification Units" WHERE("Student No." = FIELD("Student No."),
                                                                       "Unit Code" = FIELD(Unit),
                                                                       Pass = FILTER(true)));
            FieldClass = FlowField;
        }
        field(60185; Evaluated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60186; "Evaluated semester"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(60187; "Evaluated Date"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(60188; "Results Cancelled"; Boolean)
        {
            CalcFormula = Exist("Aca-Result Cancelation Subject" WHERE("Student No." = FIELD("Student No."),
                                                                        "Academic Year" = FIELD("Academic Year (Flow)"),
                                                                        "Semester Code" = FIELD(Semester),
                                                                        "Program Code" = FILTER('ZZZZZZ'),
                                                                        "Unit Code" = FIELD(Unit),
                                                                        Status = FILTER(Approved)));
            FieldClass = FlowField;
        }
        field(60189; "Course Registration Cancelled"; Boolean)
        {
            CalcFormula = Exist("ACA-Course Registration" WHERE("Student No." = FIELD("Student No."),
                                                                 Semester = FIELD(Semester),
                                                                 Programmes = FILTER('ZZZZZZ'),
                                                                 "Academic Year" = FIELD("Academic Year")));
            // "Results Cancelled" = FILTER(true)));
            FieldClass = FlowField;
        }
        field(60190; "Passed Unit"; Boolean)
        {
            CalcFormula = Lookup("ACA-Exam Grading Source".Pass WHERE("Academic Year" = FIELD("Academic Year"),
                                                                       "Exam Catregory" = FIELD("Exam Category"),
                                                                       "Total Score" = FIELD("Total Score"),
                                                                       "Results Exists Status" = FIELD("Results Exists Status")));
            FieldClass = FlowField;
        }
        field(60191; "Grade Flow"; Code[20])
        {
            CalcFormula = Lookup("ACA-Exam Grading Source".Grade WHERE("Academic Year" = FIELD("Academic Year (Flow)"),
                                                                        "Exam Catregory" = FIELD("Exam Category"),
                                                                        "Total Score" = FIELD("Total Score"),
                                                                        "Results Exists Status" = FIELD("Results Exists Status")));
            FieldClass = FlowField;
        }
        field(60192; "Exam Category"; Code[20])
        {
            CalcFormula = Lookup("ACA-Units/Subjects"."Default Exam Category" WHERE(Code = FIELD(Unit)));
            FieldClass = FlowField;
        }
        field(60193; "Results Exists Status"; Option)
        {
            CalcFormula = Lookup("Aca-Results Exists Status Ref."."Results Exists Status" WHERE("CAT Exists" = FIELD("CATs Marks Exists"),
                                                                                                 "Exam Exists" = FIELD("EXAMs Marks Exists")));
            FieldClass = FlowField;
            OptionCaption = ' ,Both Exists,CAT Only,Exam Only,None Exists';
            OptionMembers = " ","Both Exists","CAT Only","Exam Only","None Exists";
        }
        field(60194; "Pass Exists"; Boolean)
        {
            CalcFormula = Exist("ACA-Exam Classification Units" WHERE("Student No." = FIELD("Student No."),
                                                                       Programme = FIELD(Programme),
                                                                       "Unit Code" = FIELD(Unit),
                                                                       Pass = FILTER(true)));
            FieldClass = FlowField;
        }
        field(60196; Stream; text[100])
        {

        }
        field(60197; ModeOfStudy; code[20])
        {
            //TableRelation = "ACA-Settlement Type".ModeofStudy;
            //FieldClass = FlowField;

        }
        field(60198; StudentEmail; text[200])
        {

        }
        field(60199; "Class Attendance %"; Decimal)
        {

        }
        field(60200; notDuplicate; Boolean)
        {

        }
        field(60201; Day; code[20])
        {
            TableRelation = "TT-Days"."Day Code";
        }
        field(60202; TimeSlot; code[20])
        {
            TableRelation = "TT-Daily Lessons"."Lesson Code";
        }
        field(60203; LectureHall; code[20])
        {
            TableRelation = "ACA-Lecturer Halls Setup"."Lecture Room Code";
        }
        field(60204; "LecturerName"; text[250])
        {
            CalcFormula = lookup("ACA-Exam Results"."Lecturer Names" WHERE("Student No." = FIELD("Student No."),
                                                              Programmes = FIELD(Programme),
                                                              Unit = FIELD(Unit),
                                                              // Cancelled = CONST(false),
                                                              Semester = FIELD(Semester)));
            FieldClass = FlowField;
        }


        // field(60200; faculty; code[20])
        // {

        // }
        // field(60199; UnitsExist; Boolean)
        // {
        //     CalcFormula = exist("Final Exam Result2" where (StudentID = field("Student No."),UnitCode = field(Unit)));
        //     FieldClass = FlowField;
        // }


    }

    keys
    {
        key(Key1; Programme, Stage, Unit, Semester, "Reg. Transacton ID", "Student No.", ENo, "Academic Year")
        {
            SumIndexFields = "Credit Hours", "Unit Points", "Final Score";
        }
        key(Key2; "Student No.", Unit)
        {
        }
        key(Key3; ENo, "Student No.", Programme, Stage, Unit, Semester, "Reg. Transacton ID")
        {
        }
        key(Key4; "Reg. Transacton ID", "Student No.", Programme, Stage, Unit, Semester, Reversed, "Result Status", "Ignore in Cumm  Average", "Supp Taken", "Attachment Unit")
        {
            SumIndexFields = "Final Score", "No. Of Units", "CF Score";
        }
        key(Key5; "Student No.", "Final Score")
        {
        }
        key(Key6; Stage)
        {
        }
        key(Key7; Unit, Stage)
        {
        }
        key(Key8; Unit)
        {
        }
        key(Key9; "Final Score")
        {
        }
        key(Key10; Semester)
        {
        }
        key(Key11; "Total Marks")
        {
        }
        key(Key12; "Supp. Total Marks")
        {
        }
        key(Key13; "Supp. Grade")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        // ExamR.RESET;
        // ExamR.SETRANGE(ExamR."Student No.", "Student No.");
        // ExamR.SETRANGE(ExamR.Unit, Unit);
        // ExamR.SETRANGE(ExamR."Reg. Transaction ID", "Reg. Transacton ID");
        // ExamR.SETRANGE(ExamR.Cancelled, FALSE);
        // IF ExamR.FIND('-') THEN
        //     ExamR.DELETEALL;
        if (rec."EXAMs Marks Exists" = true) or (rec."CATs Marks Exists" = true) then
            ERROR('Please note that you can not delete a unit with valid results');

    end;

    trigger OnInsert()
    begin

        ACASemesters.RESET;
        ACASemesters.SETRANGE(Code, Rec.Semester);
        IF ACASemesters.FIND('-') THEN BEGIN
            ACASemesters.TESTFIELD("Academic Year");
            "Academic Year" := ACASemesters."Academic Year";
        END;
        "Created by" := USERID;
        "Date created" := TODAY;
    end;

    trigger OnModify()
    var
        ACAExamResults: Record 61548;
    begin
        IF Prog.GET(Programme) THEN BEGIN
            IF Prog."Base Date" <> 0D THEN BEGIN
                IF TODAY > CALCDATE(Prog."Grace Period", Prog."Base Date") THEN BEGIN
                    StudentCharges.RESET;
                    StudentCharges.SETRANGE(StudentCharges."Student No.", "Student No.");
                    StudentCharges.SETRANGE(StudentCharges.Code, 'CHANGE');
                    StudentCharges.SETRANGE(StudentCharges.Recognized, FALSE);
                    IF StudentCharges.FIND('-') = FALSE THEN
                        ERROR('Changing of units after grace period not allowed.');


                END;
            END;
        END;
    end;

    var
        coreg: Record 61532;
        FeeByStage: Record 61523;
        FeeByUnit: Record 61524;
        //NoSeriesMgt: Codeunit 396;
        GenSetup: Record 61534;
        StudentCharges: Record 61535;
        TotalCost: Decimal;
        StageCharges: Record 61533;
        NewStudentCharges: Record 61543;
        RecFound: Boolean;
        CoursePrerequisite: Record 61546;
        SPrereq: Record 61547;
        Stages: Record 61516;
        CReg: Record 61532;
        UnitsS: Record "ACA-Units Master Table";
        StudUnits: Record 61549;
        StudUnits2: Record 61549;
        TTable2: Record 61540;
        Days: Record 61545;
        Lessons: Record 61542;
        TTable: Record 61540;
        UTaken: Integer;
        UFound: Boolean;
        CourseReg: Record 61532;
        Prog: Record 61511;
        ExamR: Record 61548;
        Studnits: Record 61549;
        ExamSetup: Record 61567;
        StatusC: Record 61593;
        ACAUnitsSubjects44: Record 61517;
        ACASemesters: Record 61692;
        ACAExamResults: Record 61548;
        usersetup: Record "User Setup";
        Nopermission: Label 'You Are Not Allowed to Modify Units!!';
        AllowAccessSettings: boolean;

}

