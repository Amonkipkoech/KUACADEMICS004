table 65810 "ACA-Student Units 22"
{
    DrillDownPageID = 68779;
    LookupPageID = 68779;

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
        }
        field(4; Programme; Code[20])
        {
            Editable = true;
            NotBlank = false;

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
                    Semester := coreg.Semester;
                    "Academic Year" := coreg."Academic Year";
                END;
            end;
        }
        field(5; "Register for"; Option)
        {
            Editable = false;
            NotBlank = false;
            OptionCaption = 'Stage,Unit/Subject,Supplimentary,Special';
            OptionMembers = Stage,"Unit/Subject",Supplimentary,Special;
        }
        field(6; Stage; Code[20])
        {
            Editable = true;
            NotBlank = false;
        }
        field(7; Unit; Code[20])
        {
            Editable = true;
            NotBlank = false;

            trigger OnValidate()
            begin
                /*
                CourseReg.RESET;
                CourseReg.SETRANGE(CourseReg."Student No.","Student No.");
                IF CourseReg.FIND('-') THEN BEGIN
                Programme:=CourseReg.Programme;
                Stage:=CourseReg.Stage;
                Semester:=CourseReg.Semester;
                "Reg. Transacton ID":=CourseReg."Reg. Transacton ID";
                END;
                
                UnitsS.RESET;
                UnitsS.SETRANGE(UnitsS."Programme Code",Programme);
                UnitsS.SETRANGE(UnitsS.Code,Unit);
                IF UnitsS.FIND('-') THEN BEGIN
                "No. Of Units":=UnitsS."No. Units";
                Description:=UnitsS.Desription;
                {
                CReg.RESET;
                CReg.SETRANGE(CReg."Reg. Transacton ID","Reg. Transacton ID");
                IF CReg.FIND('-') THEN BEGIN
                IF CReg.Programme <> Programme THEN BEGIN
                IF UnitsS."Common Unit" = FALSE THEN
                ERROR('You cannot select a unit from another programme with is not a common unit.')
                END;
                END;
                }
                
                
                "No. Of Units":=UnitsS."No. Units";
                "Unit Stage":=UnitsS."Stage Code";
                END;
                
                "Edited By":=USERID;
                "Date Edited":=TODAY;
                 */

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
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD(Programme),
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
                UnitsS.RESET;
                UnitsS.SETRANGE(UnitsS.Code, Unit);
                IF UnitsS.FIND('-') THEN BEGIN
                    IF UnitsS."Programme Code" = '' THEN
                        UnitsS."Programme Code" := Programme;
                    IF UnitsS."Stage Code" = '' THEN
                        UnitsS."Stage Code" := Stage;
                    //UnitsS.MODIFY;
                END;

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



                UnitsS.RESET;
                //UnitsS.SETRANGE(UnitsS."Programme Code",Programme);
                UnitsS.SETRANGE(UnitsS.Code, Unit);
                IF UnitsS.FIND('-') THEN BEGIN
                    IF UnitsS.Prerequisite <> '' THEN BEGIN
                        StudUnits.RESET;
                        StudUnits.SETRANGE(StudUnits."Student No.", "Student No.");
                        StudUnits.SETRANGE(StudUnits.Unit, UnitsS.Prerequisite);
                        StudUnits.SETRANGE(StudUnits.Taken, TRUE);
                        //IF StudUnits.FIND('-') = FALSE THEN
                        //ERROR('Student must do the prerequisite unit %1.',UnitsS.Prerequisite);

                    END;
                END;

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
                                    // TTable2.SETRANGE(TTable2.Released, FALSE);
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
            TableRelation = "ACA-Course Registration"."Student Type";
        }
        field(15; "Category Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Exam Category".Code;
        }
        field(16; UnitCount; Integer)
        {
        }
        field(17; "Total Score"; Decimal)
        {
            Editable = false;
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
        }
        field(51; "Unit Stage"; Code[20])
        {
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD(Programme));
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
            OptionCaption = ' ,Intent,Submitted,Dispatch B.O.E,B.O.E Report,Schedule Defence,Defence,Cert. of Corr.,Binding,SGS Board Approval,Senate Approval';
            OptionMembers = " ",Intent,Submitted,"Dispatch B.O.E","B.O.E Report","Schedule Defence",Defence,"Cert. of Corr.",Binding,"SGS Board Approval","Senate Approval";

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

                IF Status = Status::Intent THEN
                    "Proposal Date" := TODAY;

                IF Status = Status::Submitted THEN
                    "Senate-Proposal" := TODAY;

                IF Status = Status::"Dispatch B.O.E" THEN
                    Research := TODAY;

                IF Status = Status::Submitted THEN
                    "Senate-Proposal" := TODAY;

                IF Status = Status::"Schedule Defence" THEN
                    Examiners := TODAY;

                IF Status = Status::Defence THEN
                    Defense := TODAY;
            end;
        }
        field(58; "Details Count"; Integer)
        {
            Editable = false;
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
        }
        field(90; "Student Type"; Option)
        {
            OptionCaption = 'Full Time,Part Time,Distance Learning';
            OptionMembers = "Full Time","Part Time","Distance Learning";
        }
        field(94; "Main Programme"; Code[20])
        {
        }
        field(95; "Registered Programe"; Code[20])
        {
        }
        field(96; "Semester Registered"; Boolean)
        {
        }
        field(20015; "Marks Status"; Option)
        {
            OptionCaption = ' ,Y,S,I,F,NDP';
            OptionMembers = " ",Y,S,I,F,NDP;
        }
        field(20016; "Student Name"; Text[100])
        {
        }
        field(20023; "CAT-1"; Decimal)
        {
        }
        field(20024; "CAT-2"; Decimal)
        {
        }
        field(20025; "Result Status"; Code[50])
        {
        }
        field(20026; "Registration Status"; Option)
        {
            OptionCaption = ' ,Specials,Academic Leave,WithHold,Deregister,Discontinue,Nullification';
            OptionMembers = " ",Specials,"Academic Leave",WithHold,Deregister,Discontinue,Nullification;
        }
        field(20027; "Ass Total Marks"; Decimal)
        {
        }
        field(20028; "CAT Total Marks"; Decimal)
        {
        }
        field(20029; "Exam Marks"; Decimal)
        {
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
        field(20035; Lecturer; Code[20])
        {
        }
        field(20036; Grade; Code[50])
        {
        }
        field(20037; "Supp Taken"; Boolean)
        {
        }
        field(20038; "Failed Units Count"; Integer)
        {
        }
        field(20039; "Unit Reg Count"; Integer)
        {
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
        }
        field(20042; "Actual Fees"; Decimal)
        {
        }
        field(20043; "Reg Reversed"; Boolean)
        {
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
        }
        field(50005; "Unit Description"; Text[100])
        {
        }
        field(50006; Blocked; Option)
        {
            Caption = 'Blocked';
            OptionCaption = ' ,Ship,Invoice,All';
            OptionMembers = " ",Ship,Invoice,All;
        }
        field(50007; "Session Code"; Code[20])
        {
            TableRelation = "ACA-Intake".Code;
        }
        field(50008; "Cust Exist"; Integer)
        {
        }
        field(50009; Registered; Boolean)
        {
        }
        field(50010; "CF Score"; Decimal)
        {
            Description = 'Stores CF * Score';
        }
        field(50011; "Ignore in Final Average"; Boolean)
        {
        }
        field(50012; "Ignore in Cumm  Average"; Boolean)
        {
        }
        field(50013; "Attachment Unit"; Boolean)
        {
        }
        field(50014; "Reg. Results Status"; Code[20])
        {
        }
        field(50015; "Academic Year"; Code[20])
        {
        }
        field(50017; "Student Code"; Code[20])
        {
        }
        field(50018; "Campus Code"; Code[20])
        {
        }
        field(50019; "Campus Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50020; "Reg Option"; Code[20])
        {
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
        }
        field(50067; "Credited Hours"; Decimal)
        {
        }
        field(50068; "Unit Points"; Decimal)
        {
        }
        field(50069; "Credit Hours"; Decimal)
        {
        }
        field(50070; "Cancelled Score"; Decimal)
        {
            Editable = false;
        }
        field(50071; Supervisor; Code[20])
        {
            TableRelation = "ACA-Lecturers/Examiners"."No.";
        }
        field(50072; "Released Results"; Boolean)
        {
        }
        field(50073; "Old Unit"; Boolean)
        {
        }
        field(50074; "Old Unit Lk"; Boolean)
        {
        }
        field(50075; "CATs Marks"; Decimal)
        {
        }
        field(50076; "EXAMs Marks"; Decimal)
        {
        }
        field(50077; "Year Of Study"; Integer)
        {
        }
        field(50078; "Consolidated Mark Identifier"; Code[2])
        {
        }
        field(50079; Units; Integer)
        {
        }
        field(50080; "Weighted Units"; Decimal)
        {
        }
        field(50081; "CATs Marks Exists"; Boolean)
        {
        }
        field(50082; "EXAMs Marks Exists"; Boolean)
        {
        }
        field(50083; "Consolidated Mark Pref."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50084; "Reg. Reversed"; Boolean)
        {
        }
        field(50085; "Flow Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
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
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        /*
        ExamR.RESET;
        ExamR.SETRANGE(ExamR."Student No.","Student No.");
        ExamR.SETRANGE(ExamR.Unit,Unit);
        ExamR.SETRANGE(ExamR."Reg. Transaction ID","Reg. Transacton ID");
        ExamR.SETRANGE(ExamR.Cancelled,FALSE);
        IF ExamR.FIND('-') THEN
        //ExamR.DELETEALL;
        //ERROR('Please note that you can not delete a unit with valid results');
          */

    end;

    trigger OnInsert()
    begin
        "Created by" := USERID;
        "Date created" := TODAY;

        //IF Taken=FALSE THEN
        //ERROR('The Course must be marked Taken!');
    end;

    trigger OnModify()
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
        NoSeriesMgt: Codeunit 396;
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
        UnitsS: Record 61517;
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
}

