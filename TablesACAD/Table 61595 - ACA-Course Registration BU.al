table 61595 "ACA-Course Registration BU"
{
    DrillDownPageID = 68773;
    LookupPageID = 68773;

    fields
    {
        field(1; "Student No."; Code[20])
        {
            NotBlank = true;
            TableRelation = Customer."No.";
        }
        field(2; Semester; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme Semesters".Semester WHERE("Programme Code" = FIELD(Programmes));

            trigger OnValidate()
            begin
                //"Settlement Type":='';
            end;
        }
        field(3; Programmes; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme".Code;

            trigger OnValidate()
            begin
                "Settlement Type" := '';

                Found := FALSE;
                //Library Code
                CourseReg.RESET;
                CourseReg.SETRANGE(CourseReg."Student No.", Rec."Student No.");
                IF CourseReg.FIND('-') THEN BEGIN
                    REPEAT
                        Programmz.RESET;
                        Programmz.SETRANGE(Programmz.Code, CourseReg.Programmes);
                        IF Programmz.Priority = 1 THEN BEGIN
                            Found := TRUE;
                            LibCode := Programmz.Code;
                        END;
                    UNTIL CourseReg.NEXT = 0;
                END;
                IF Found = FALSE THEN
                    LibCode := CourseReg.Programmes;
                Custs.RESET;
                Custs.SETRANGE(Custs."No.", "Student No.");
                IF Custs.FIND('-') THEN BEGIN
                    LibRefCodes.RESET;
                    LibRefCodes.SETRANGE(LibRefCodes.Course, LibCode);
                    IF LibRefCodes.FIND('-') THEN BEGIN
                        Custs."Lib Membership" := LibRefCodes.LibCode;
                        Custs.MODIFY;
                    END;
                END;
                //VALIDATE(Programme);
            end;
        }
        field(4; "Register for"; Option)
        {
            NotBlank = false;
            OptionCaption = 'Stage,Unit/Subject';
            OptionMembers = Stage,"Unit/Subject";

            trigger OnValidate()
            begin
                "Settlement Type" := '';
                IF "Register for" = "Register for"::Stage THEN
                    Unit := '';
            end;
        }
        field(5; Stage; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD(Programmes));

            trigger OnValidate()
            begin
                "Settlement Type" := '';

                SPrereq.RESET;
                SPrereq.SETRANGE(SPrereq."Reg. Transaction ID", "Reg. Transacton ID");
                IF SPrereq.FIND('-') THEN
                    SPrereq.DELETEALL;

                CoursePrerequisite.RESET;
                CoursePrerequisite.SETRANGE(CoursePrerequisite.Programmes, Programmes);
                CoursePrerequisite.SETRANGE(CoursePrerequisite.Stage, Stage);
                IF CoursePrerequisite.FIND('-') THEN BEGIN
                    REPEAT
                        SPrereq.INIT;
                        SPrereq."Reg. Transaction ID" := "Reg. Transacton ID";
                        SPrereq."Student No." := "Student No.";
                        SPrereq.Programme := Programmes;
                        SPrereq.Stage := Stage;
                        SPrereq.Prerequisite := CoursePrerequisite.Requirement;
                        SPrereq.Mandatory := CoursePrerequisite.Mandatory;
                        SPrereq.Approved := FALSE;
                        SPrereq.INSERT;

                    UNTIL CoursePrerequisite.NEXT = 0;

                END
            end;
        }
        field(6; Unit; Code[20])
        {
            TableRelation = IF ("Register for" = CONST("Unit/Subject")) "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD(Programmes),
                                                                                                 "Stage Code" = FIELD(Stage));

            trigger OnValidate()
            begin
                "Settlement Type" := '';
            end;
        }
        field(7; "Settlement Type"; Code[20])
        {
            NotBlank = false;
            TableRelation = "ACA-Settlement Type".Code;

            trigger OnValidate()
            begin
                TESTFIELD("Reg. Transacton ID");
                TESTFIELD("Registration Date");
                "User ID" := USERID;
                MODIFY;

                SPrereq.RESET;
                SPrereq.SETRANGE(SPrereq."Reg. Transaction ID", "Reg. Transacton ID");
                SPrereq.SETRANGE(SPrereq.Mandatory, TRUE);
                SPrereq.SETRANGE(SPrereq.Approved, FALSE);
                IF SPrereq.FIND('-') THEN
                    ERROR('Student has not meet the requirements of this course.');

                IF "Register for" = "Register for"::Stage THEN BEGIN
                    Stages.RESET;
                    Stages.SETRANGE(Stages."Programme Code", Programmes);
                    Stages.SETRANGE(Stages.Code, Stage);
                    IF Stages.FIND('-') THEN BEGIN
                        IF Stages."Modules Registration" = TRUE THEN BEGIN
                            IF Modules < 1 THEN
                                ERROR('You must specify the number of modules being taken.');
                        END ELSE
                            Modules := 0;
                    END;
                END;


                StudentCharges.RESET;
                StudentCharges.SETRANGE(StudentCharges."Student No.", "Student No.");
                StudentCharges.SETRANGE(StudentCharges."Reg. Transacton ID", "Reg. Transacton ID");
                IF StudentCharges.FIND('-') THEN
                    StudentCharges.DELETEALL;

                StudentUnits.RESET;
                StudentUnits.SETRANGE(StudentUnits."Student No.", "Student No.");
                StudentUnits.SETRANGE(StudentUnits."Reg. Transacton ID", "Reg. Transacton ID");
                IF StudentUnits.FIND('-') THEN
                    StudentUnits.DELETEALL;




                StudentCharges.RESET;
                StudentCharges.SETRANGE(StudentCharges."Student No.", "Student No.");
                IF NOT StudentCharges.FIND('-') THEN BEGIN
                    NewStudentCharges.RESET;
                    NewStudentCharges.SETRANGE(NewStudentCharges."Programme Code", Programmes);
                    NewStudentCharges.SETRANGE(NewStudentCharges."First Time Students", TRUE);

                    IF NewStudentCharges.FIND('-') THEN BEGIN
                        REPEAT
                            StudentCharges.INIT;
                            StudentCharges.Programme := Programmes;
                            StudentCharges.Stage := Stage;
                            StudentCharges.Semester := Semester;
                            StudentCharges."Student No." := "Student No.";
                            StudentCharges."Reg. Transacton ID" := "Reg. Transacton ID";
                            StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::"Stage Fees";
                            StudentCharges.Date := "Registration Date";
                            StudentCharges.Code := NewStudentCharges.Code;
                            StudentCharges.Description := NewStudentCharges.Description;
                            StudentCharges.Amount := NewStudentCharges.Amount;
                            StudentCharges."Recovered First" := NewStudentCharges."Recovered First";
                            StudentCharges.Charge := TRUE;
                            StudentCharges."Transacton ID" := '';
                            StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                            StudentCharges.INSERT;

                        UNTIL NewStudentCharges.NEXT = 0
                    END;
                END;


                NewStudentCharges.RESET;
                NewStudentCharges.SETRANGE(NewStudentCharges."Programme Code", Programmes);
                NewStudentCharges.SETRANGE(NewStudentCharges."First Time Students", FALSE);
                IF NewStudentCharges.FIND('-') THEN BEGIN
                    REPEAT
                        StudentCharges.INIT;
                        StudentCharges.Programme := Programmes;
                        StudentCharges.Stage := Stage;
                        StudentCharges.Semester := Semester;
                        StudentCharges."Student No." := "Student No.";
                        StudentCharges."Reg. Transacton ID" := "Reg. Transacton ID";
                        StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::"Stage Fees";
                        StudentCharges.Date := "Registration Date";
                        StudentCharges.Code := NewStudentCharges.Code;
                        StudentCharges.Description := NewStudentCharges.Description;
                        StudentCharges.Amount := NewStudentCharges.Amount;
                        StudentCharges."Recovered First" := NewStudentCharges."Recovered First";
                        StudentCharges.Charge := TRUE;
                        StudentCharges."Transacton ID" := '';
                        StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                        StudentCharges.INSERT;

                    UNTIL NewStudentCharges.NEXT = 0
                END;




                IF "Settlement Type" <> '' THEN BEGIN
                    IF "Register for" = "Register for"::Stage THEN BEGIN
                        FeeByStage.RESET;
                        FeeByStage.SETRANGE(FeeByStage."Programme Code", Programmes);
                        FeeByStage.SETRANGE(FeeByStage."Stage Code", Stage);
                        FeeByStage.SETRANGE(FeeByStage."Settlemet Type", "Settlement Type");
                        FeeByStage.SETRANGE(FeeByStage.Semester, Semester);
                        FeeByStage.SETRANGE(FeeByStage."Student Type", "Student Type");
                        IF NOT FeeByStage.FIND('-') THEN BEGIN
                            ERROR('No fees structure defined for the settlement type.');
                            "Settlement Type" := '';
                        END
                        ELSE BEGIN

                            //Insert Students Units
                            StageUnits.RESET;
                            StageUnits.SETRANGE(StageUnits."Programme Code", Programmes);
                            StageUnits.SETRANGE(StageUnits."Stage Code", Stage);
                            StageUnits.SETRANGE(StageUnits."Student Type", StageUnits."Student Type"::" ");
                            IF StageUnits.FIND('-') THEN BEGIN
                                REPEAT
                                    StudentUnits.INIT;
                                    StudentUnits."Reg. Transacton ID" := "Reg. Transacton ID";
                                    StudentUnits."Student No." := "Student No.";
                                    StudentUnits.Programme := Programmes;
                                    StudentUnits.Stage := Stage;
                                    StudentUnits.Unit := StageUnits.Code;
                                    StudentUnits.Semester := Semester;
                                    StudentUnits."Register for" := "Register for";
                                    StudentUnits."Unit Type" := StageUnits."Unit Type";
                                    IF Stages."Modules Registration" = FALSE THEN
                                        StudentUnits.Taken := TRUE;
                                    StudentUnits.INSERT;

                                UNTIL StageUnits.NEXT = 0
                            END;

                            //MESSAGE('%1',"Student Type");
                            /*
                            StageUnits.RESET;
                            StageUnits.SETRANGE(StageUnits."Programme Code",Programme);
                            StageUnits.SETRANGE(StageUnits."Stage Code",Stage);
                            StageUnits.SETRANGE(StageUnits."Student Type","Student Type");
                            IF StageUnits.FIND('-') THEN BEGIN
                            REPEAT
                            MESSAGE('%1',StageUnits."Student Type");
                            IF StageUnits."Student Type" = "Student Type" THEN BEGIN
                            StudentUnits.INIT;
                            StudentUnits."Reg. Transacton ID":="Reg. Transacton ID";
                            StudentUnits."Student No.":="Student No.";
                            StudentUnits.Programme:=Programme;
                            StudentUnits.Stage:=Stage;
                            StudentUnits.Unit:=StageUnits.Code;
                            StudentUnits.Semester:=Semester;
                            StudentUnits."Register for":="Register for";
                            StudentUnits."Unit Type":=StageUnits."Unit Type";
                            IF Stages."Modules Registration" = FALSE THEN
                            StudentUnits.Taken:=TRUE;
                            StudentUnits.INSERT;
                            END;
                            UNTIL StageUnits.NEXT = 0
                            END;
                            */


                            //TotalCost:=0;
                            REPEAT
                                TotalCost := 0;
                                TotalCost := TotalCost + FeeByStage."Break Down";
                                IF Modules > 0 THEN
                                    TotalCost := TotalCost * Modules;

                                StudentCharges.INIT;
                                StudentCharges.Programme := Programmes;
                                StudentCharges.Stage := Stage;
                                StudentCharges.Semester := Semester;
                                StudentCharges."Student No." := "Student No.";
                                StudentCharges."Reg. Transacton ID" := "Reg. Transacton ID";
                                StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::"Stage Fees";
                                StudentCharges.Date := "Registration Date";
                                StudentCharges.Code := Stage;
                                IF SettlementType.GET("Settlement Type") THEN BEGIN
                                    IF SettlementType.Installments = TRUE THEN BEGIN
                                        IF FeeByStage."Seq." = 0 THEN
                                            StudentCharges.Description := 'Fees for' + ' ' + Programmes + '-' + Stage + '-' + 'Inst 0'
                                        ELSE
                                            IF FeeByStage."Seq." = 1 THEN
                                                StudentCharges.Description := 'Fees for' + ' ' + Programmes + '-' + Stage + '-' + 'Inst 1'
                                            ELSE
                                                IF FeeByStage."Seq." = 2 THEN
                                                    StudentCharges.Description := 'Fees for' + ' ' + Programmes + '-' + Stage + '-' + 'Inst 2'
                                                ELSE
                                                    IF FeeByStage."Seq." = 3 THEN
                                                        StudentCharges.Description := 'Fees for' + ' ' + Programmes + '-' + Stage + '-' + 'Inst 3'
                                                    ELSE
                                                        IF FeeByStage."Seq." = 4 THEN
                                                            StudentCharges.Description := 'Fees for' + ' ' + Programmes + '-' + Stage + '-' + 'Inst 4'
                                                        ELSE
                                                            StudentCharges.Description := 'Fees for' + ' ' + Programmes + '-' + Stage + '-' + 'Inst';

                                        StudentCharges.Distribution := Stages."Distribution Part Time (%)";
                                    END ELSE BEGIN
                                        StudentCharges.Description := 'Fees for' + ' ' + Programmes + '-' + Stage;
                                        StudentCharges.Distribution := Stages."Distribution Full Time (%)";
                                    END;
                                END ELSE BEGIN
                                    StudentCharges.Description := 'Fees for' + ' ' + Programmes + '-' + Stage;
                                END;

                                StudentCharges.Amount := TotalCost;
                                StudentCharges."Tuition Fee" := TRUE;
                                StudentCharges."Transacton ID" := '';
                                StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                                StudentCharges.INSERT;

                            UNTIL FeeByStage.NEXT = 0;


                            StageCharges.RESET;
                            StageCharges.SETRANGE(StageCharges."Programme Code", Programmes);
                            StageCharges.SETRANGE(StageCharges."Stage Code", Stage);
                            StageCharges.SETRANGE(StageCharges."Student Type", StageCharges."Student Type"::" ");
                            IF StageCharges.FIND('-') THEN BEGIN
                                REPEAT
                                    IF StageCharges.Semester = '' THEN BEGIN
                                        StudentCharges.INIT;
                                        StudentCharges.Programme := Programmes;
                                        StudentCharges.Stage := Stage;
                                        StudentCharges.Semester := Semester;
                                        StudentCharges."Student No." := "Student No.";
                                        StudentCharges."Reg. Transacton ID" := "Reg. Transacton ID";
                                        StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::"Stage Fees";
                                        StudentCharges.Date := "Registration Date";
                                        StudentCharges.Code := StageCharges.Code;
                                        StudentCharges.Description := StageCharges.Description;
                                        StudentCharges.Amount := StageCharges.Amount;
                                        StudentCharges."Recovered First" := StageCharges."Recovered First";
                                        StudentCharges."Transacton ID" := '';
                                        StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                                        StudentCharges.INSERT;

                                    END ELSE BEGIN
                                        IF StageCharges.Semester = Semester THEN BEGIN
                                            StudentCharges.INIT;
                                            StudentCharges.Programme := Programmes;
                                            StudentCharges.Stage := Stage;
                                            StudentCharges.Semester := Semester;
                                            StudentCharges."Student No." := "Student No.";
                                            StudentCharges."Reg. Transacton ID" := "Reg. Transacton ID";
                                            StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::"Stage Fees";
                                            StudentCharges.Date := "Registration Date";
                                            StudentCharges.Code := StageCharges.Code;
                                            StudentCharges.Description := StageCharges.Description;
                                            StudentCharges.Amount := StageCharges.Amount;
                                            StudentCharges."Recovered First" := StageCharges."Recovered First";
                                            StudentCharges."Transacton ID" := '';
                                            StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                                            StudentCharges.INSERT;
                                        END;
                                    END;

                                UNTIL StageCharges.NEXT = 0;

                            END;

                            IF "Student Type" = "Student Type"::"Full Time" THEN BEGIN
                                ///////Charges by student type - Full Time
                                StageCharges.RESET;
                                StageCharges.SETRANGE(StageCharges."Programme Code", Programmes);
                                StageCharges.SETRANGE(StageCharges."Stage Code", Stage);
                                StageCharges.SETRANGE(StageCharges."Student Type", StageCharges."Student Type"::"Full Time");
                                IF StageCharges.FIND('-') THEN BEGIN
                                    REPEAT
                                        IF StageCharges.Semester = '' THEN BEGIN
                                            StudentCharges.INIT;
                                            StudentCharges.Programme := Programmes;
                                            StudentCharges.Stage := Stage;
                                            StudentCharges.Semester := Semester;
                                            StudentCharges."Student No." := "Student No.";
                                            StudentCharges."Reg. Transacton ID" := "Reg. Transacton ID";
                                            StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::"Stage Fees";
                                            StudentCharges.Date := "Registration Date";
                                            StudentCharges.Code := StageCharges.Code;
                                            StudentCharges.Description := StageCharges.Description;
                                            StudentCharges.Amount := StageCharges.Amount;
                                            StudentCharges."Recovered First" := StageCharges."Recovered First";
                                            StudentCharges."Transacton ID" := '';
                                            StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                                            StudentCharges.INSERT;

                                        END ELSE BEGIN
                                            IF StageCharges.Semester = Semester THEN BEGIN
                                                StudentCharges.INIT;
                                                StudentCharges.Programme := Programmes;
                                                StudentCharges.Stage := Stage;
                                                StudentCharges.Semester := Semester;
                                                StudentCharges."Student No." := "Student No.";
                                                StudentCharges."Reg. Transacton ID" := "Reg. Transacton ID";
                                                StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::"Stage Fees";
                                                StudentCharges.Date := "Registration Date";
                                                StudentCharges.Code := StageCharges.Code;
                                                StudentCharges.Description := StageCharges.Description;
                                                StudentCharges.Amount := StageCharges.Amount;
                                                StudentCharges."Recovered First" := StageCharges."Recovered First";
                                                StudentCharges."Transacton ID" := '';
                                                StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                                                StudentCharges.INSERT;
                                            END;
                                        END;

                                    UNTIL StageCharges.NEXT = 0;

                                END;

                            END ELSE BEGIN
                                ///////Charges by student type - Part Time
                                StageCharges.RESET;
                                StageCharges.SETRANGE(StageCharges."Programme Code", Programmes);
                                StageCharges.SETRANGE(StageCharges."Stage Code", Stage);
                                StageCharges.SETRANGE(StageCharges."Student Type", StageCharges."Student Type"::"Part Time");
                                IF StageCharges.FIND('-') THEN BEGIN
                                    REPEAT
                                        IF StageCharges.Semester = '' THEN BEGIN
                                            StudentCharges.INIT;
                                            StudentCharges.Programme := Programmes;
                                            StudentCharges.Stage := Stage;
                                            StudentCharges.Semester := Semester;
                                            StudentCharges."Student No." := "Student No.";
                                            StudentCharges."Reg. Transacton ID" := "Reg. Transacton ID";
                                            StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::"Stage Fees";
                                            StudentCharges.Date := "Registration Date";
                                            StudentCharges.Code := StageCharges.Code;
                                            StudentCharges.Description := StageCharges.Description;
                                            StudentCharges.Amount := StageCharges.Amount;
                                            StudentCharges."Recovered First" := StageCharges."Recovered First";
                                            StudentCharges."Transacton ID" := '';
                                            StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                                            StudentCharges.INSERT;

                                        END ELSE BEGIN
                                            IF StageCharges.Semester = Semester THEN BEGIN
                                                StudentCharges.INIT;
                                                StudentCharges.Programme := Programmes;
                                                StudentCharges.Stage := Stage;
                                                StudentCharges.Semester := Semester;
                                                StudentCharges."Student No." := "Student No.";
                                                StudentCharges."Reg. Transacton ID" := "Reg. Transacton ID";
                                                StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::"Stage Fees";
                                                StudentCharges.Date := "Registration Date";
                                                StudentCharges.Code := StageCharges.Code;
                                                StudentCharges.Description := StageCharges.Description;
                                                StudentCharges.Amount := StageCharges.Amount;
                                                StudentCharges."Recovered First" := StageCharges."Recovered First";
                                                StudentCharges."Transacton ID" := '';
                                                StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                                                StudentCharges.INSERT;
                                            END;
                                        END;

                                    UNTIL StageCharges.NEXT = 0;

                                END;
                            END;


                        END;

                    END
                    ELSE BEGIN
                        FeeByUnit.RESET;
                        FeeByUnit.SETRANGE(FeeByUnit."Programme Code", Programmes);
                        FeeByUnit.SETRANGE(FeeByUnit."Stage Code", Stage);
                        FeeByUnit.SETRANGE(FeeByUnit."Unit Code", Unit);
                        FeeByUnit.SETRANGE(FeeByUnit.Semester, Semester);
                        FeeByUnit.SETRANGE(FeeByUnit."Settlemet Type", "Settlement Type");
                        FeeByUnit.SETRANGE(FeeByUnit."Student Type", "Student Type");
                        IF NOT FeeByUnit.FIND('-') THEN BEGIN
                            ERROR('No fees structure defined for the settlement type.');
                            "Settlement Type" := '';
                        END
                        ELSE BEGIN
                            //Insert Units
                            StudentUnits.INIT;
                            StudentUnits."Reg. Transacton ID" := "Reg. Transacton ID";
                            StudentUnits."Student No." := "Student No.";
                            StudentUnits.Programme := Programmes;
                            StudentUnits.Stage := Stage;
                            StudentUnits.Unit := Unit;
                            StudentUnits.Semester := Semester;
                            StudentUnits."Register for" := "Register for";
                            //IF Stages."Modules Registration" = FALSE THEN
                            StudentUnits.Taken := TRUE;
                            StudentUnits.INSERT;

                            TotalCost := 0;
                            REPEAT
                                TotalCost := TotalCost + FeeByUnit."Break Down";
                            UNTIL FeeByUnit.NEXT = 0;

                            StudentCharges.INIT;
                            StudentCharges.Programme := Programmes;
                            StudentCharges.Stage := Stage;
                            StudentCharges.Unit := Unit;
                            StudentCharges.Semester := Semester;
                            StudentCharges."Student No." := "Student No.";
                            StudentCharges."Reg. Transacton ID" := "Reg. Transacton ID";
                            StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::"Unit Fees";
                            StudentCharges.Date := "Registration Date";
                            StudentCharges.Code := Unit;
                            StudentCharges.Description := 'Fees for' + ' ' + Programmes + '-' + Stage + '-' + Unit;
                            StudentCharges.Amount := TotalCost;
                            StudentCharges."Tuition Fee" := TRUE;
                            StudentCharges."Transacton ID" := '';
                            StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                            StudentCharges.INSERT;


                        END;
                    END;
                END;

                /*
               //library
               Found:=FALSE;
               CourseReg.RESET;
               CourseReg.SETRANGE(CourseReg."Student No.",Rec."Student No.");
               IF CourseReg.FIND('-') THEN BEGIN
               REPEAT
               Programmes.RESET;
               Programmes.SETRANGE(Programmes.Code,CourseReg.Programme);
               IF Programmes.Priority= 1 THEN BEGIN
               Found:=TRUE;
               LibCode:=Programmes.Code;
               END;
               UNTIL CourseReg.NEXT=0;
               END;
               IF Found=FALSE THEN
               LibCode:=CourseReg.Programme;
               Custs.RESET;
               Custs.SETRANGE(Custs."No.","Student No.");
               IF Custs.FIND('-') THEN BEGIN
               LibRefCodes.RESET;
               LibRefCodes.SETRANGE(LibRefCodes.Course,LibCode);
               IF LibRefCodes.FIND('-') THEN BEGIN
               Custs."Lib Membership":=LibRefCodes.LibCode;
               Custs.MODIFY;
               END;
               END;
               */

            end;
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
        field(12; Modules; Integer)
        {

            trigger OnValidate()
            begin
                "Settlement Type" := '';
            end;
        }
        field(13; "Programme Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme".Code;
        }
        field(14; "Stage Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD("Programme Filter"));
        }
        field(15; "Unit Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD("Programme Filter"),
                                                           "Stage Code" = FIELD("Stage Filter"));
        }
        field(16; "Semester Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme Semesters".Semester WHERE("Programme Code" = FIELD("Programme Filter"));
        }
        field(17; "Lecture Room Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Lecture Rooms".Code;
        }
        field(18; "Attending Classes"; Boolean)
        {

            trigger OnValidate()
            begin
                TESTFIELD("Settlement Type");

                IF xRec."Attending Classes" = TRUE THEN
                    ERROR('Entries have already been posted. Please reverse posted entries.');

                IF "Register for" = "Register for"::Stage THEN BEGIN
                    Stages.RESET;
                    Stages.SETRANGE(Stages."Programme Code", Programmes);
                    Stages.SETRANGE(Stages.Code, Stage);
                    IF Stages.FIND('-') THEN BEGIN
                        IF Stages."Modules Registration" = TRUE THEN BEGIN
                            IF Modules <> "Units Taken" THEN
                                ERROR('Units Taken must be equal to the no of modules registered for.');

                        END;
                    END;
                END;



                /*
                IF CONFIRM('Do you want to post the transaction?',TRUE) = FALSE THEN BEGIN
                "Attending Classes":=FALSE;
                MODIFY;
                EXIT;
                END;
                */

                GenSetup.GET();

                IF "Attending Classes" = TRUE THEN BEGIN
                    //BILLING

                    StudentCharges.RESET;
                    StudentCharges.SETRANGE(StudentCharges."Student No.", "Student No.");
                    StudentCharges.SETRANGE(StudentCharges.Recognized, FALSE);
                    IF StudentCharges.FIND('-') THEN BEGIN
                        IF CONFIRM('Un-billed charges will be posted. Do you wish to continue?', TRUE) = FALSE THEN BEGIN
                            "Attending Classes" := FALSE;
                            MODIFY;
                            EXIT;
                        END;
                    END;


                    IF Cust.GET("Student No.") THEN BEGIN
                        //Cust.Status:=Cust.Status::Current;
                        //Cust.MODIFY;
                    END;


                    GenJnl.RESET;
                    GenJnl.SETRANGE("Journal Template Name", 'SALES');
                    GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                    GenJnl.DELETEALL;

                    GenSetup.GET();

                    //Charge Student if not charged
                    StudentCharges.RESET;
                    StudentCharges.SETRANGE(StudentCharges."Student No.", "Student No.");
                    StudentCharges.SETRANGE(StudentCharges.Recognized, FALSE);
                    IF StudentCharges.FIND('-') THEN BEGIN

                        REPEAT

                            DueDate := StudentCharges.Date;
                            IF Sems.GET(StudentCharges.Semester) THEN BEGIN
                                IF Sems.From <> 0D THEN BEGIN
                                    IF Sems.From > DueDate THEN
                                        DueDate := Sems.From;
                                END;
                            END;


                            GenJnl.INIT;
                            GenJnl."Line No." := GenJnl."Line No." + 10000;
                            GenJnl."Posting Date" := TODAY;
                            GenJnl."Document No." := StudentCharges."Transacton ID";
                            GenJnl.VALIDATE(GenJnl."Document No.");
                            GenJnl."Journal Template Name" := 'SALES';
                            GenJnl."Journal Batch Name" := 'STUD PAY';
                            GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                            //
                            IF Cust.GET("Student No.") THEN BEGIN
                                IF Cust."Bill-to Customer No." <> '' THEN
                                    GenJnl."Account No." := Cust."Bill-to Customer No."
                                ELSE
                                    GenJnl."Account No." := "Student No.";
                            END;

                            GenJnl.Amount := StudentCharges.Amount;
                            GenJnl.VALIDATE(GenJnl."Account No.");
                            GenJnl.VALIDATE(GenJnl.Amount);
                            GenJnl.Description := StudentCharges.Description;
                            GenJnl."Bal. Account Type" := GenJnl."Account Type"::"G/L Account";

                            IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Fees") AND
                               (StudentCharges.Charge = FALSE) THEN BEGIN
                                GenJnl."Bal. Account No." := GenSetup."Pre-Payment Account";

                                CReg.RESET;
                                CReg.SETCURRENTKEY(CReg."Reg. Transacton ID");
                                CReg.SETRANGE(CReg."Reg. Transacton ID", StudentCharges."Reg. Transacton ID");
                                CReg.SETRANGE(CReg."Student No.", StudentCharges."Student No.");
                                IF CReg.FIND('-') THEN BEGIN
                                    IF CReg."Register for" = CReg."Register for"::Stage THEN BEGIN
                                        Stages.RESET;
                                        Stages.SETRANGE(Stages."Programme Code", CReg.Programmes);
                                        Stages.SETRANGE(Stages.Code, CReg.Stage);
                                        IF Stages.FIND('-') THEN BEGIN
                                            IF (Stages."Modules Registration" = TRUE) AND (Stages."Ignore No. Of Units" = FALSE) THEN BEGIN
                                                CReg.CALCFIELDS(CReg."Units Taken");
                                                IF CReg.Modules <> CReg."Units Taken" THEN
                                                    ERROR('Units Taken must be equal to the no of modules registered for.');

                                            END;
                                        END;
                                    END;

                                    CReg.Posted := TRUE;
                                    CReg.MODIFY;
                                END;


                            END ELSE
                                IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Fees") AND
                                   (StudentCharges.Charge = FALSE) THEN BEGIN
                                    GenJnl."Bal. Account No." := GenSetup."Pre-Payment Account";

                                    CReg.RESET;
                                    CReg.SETCURRENTKEY(CReg."Reg. Transacton ID");
                                    CReg.SETRANGE(CReg."Reg. Transacton ID", StudentCharges."Reg. Transacton ID");
                                    IF CReg.FIND('-') THEN BEGIN
                                        CReg.Posted := TRUE;
                                        CReg.MODIFY;
                                    END;



                                END ELSE
                                    IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Exam Fees" THEN BEGIN
                                        IF ExamsByStage.GET(StudentCharges.Programme, StudentCharges.Stage, StudentCharges.Semester, StudentCharges.Code) THEN
                                            GenJnl."Bal. Account No." := ExamsByStage."G/L Account";

                                    END ELSE
                                        IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Exam Fees" THEN BEGIN
                                            IF ExamsByUnit.GET(StudentCharges.Programme, StudentCharges.Stage, ExamsByUnit."Unit Code", StudentCharges.Semester,
                                            StudentCharges.Code) THEN
                                                GenJnl."Bal. Account No." := ExamsByUnit."G/L Account";

                                        END ELSE
                                            IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::Charges) OR
                                               (StudentCharges.Charge = TRUE) THEN BEGIN
                                                IF Charges.GET(StudentCharges.Code) THEN
                                                    GenJnl."Bal. Account No." := Charges."G/L Account";
                                            END;


                            GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                            IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Fees" THEN BEGIN
                                IF Stages.GET(StudentCharges.Programme, StudentCharges.Stage) THEN BEGIN
                                    GenJnl."Shortcut Dimension 2 Code" := Stages.Department;
                                END;

                            END ELSE
                                IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Fees" THEN BEGIN
                                    IF Units.GET(StudentCharges.Programme, StudentCharges.Stage, StudentCharges.Unit) THEN BEGIN
                                        GenJnl."Shortcut Dimension 2 Code" := Units.Department;
                                    END;
                                END;

                            GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                            GenJnl."Due Date" := DueDate;
                            GenJnl.VALIDATE(GenJnl."Due Date");
                            GenJnl.INSERT;

                            //Distribute Money
                            IF StudentCharges."Tuition Fee" = TRUE THEN BEGIN
                                IF Stages.GET(StudentCharges.Programme, StudentCharges.Stage) THEN BEGIN
                                    IF (Stages."Distribution Full Time (%)" > 0) OR (Stages."Distribution Part Time (%)" > 0) THEN BEGIN
                                        Stages.TESTFIELD(Stages."Distribution Account");
                                        StudentCharges.TESTFIELD(StudentCharges.Distribution);
                                        IF Cust.GET("Student No.") THEN BEGIN
                                            CustPostGroup.GET(Cust."Customer Posting Group");

                                            GenJnl.INIT;
                                            GenJnl."Line No." := GenJnl."Line No." + 10000;
                                            GenJnl."Posting Date" := TODAY;
                                            GenJnl."Document No." := StudentCharges."Transacton ID";
                                            //GenJnl."Document Type":=GenJnl."Document Type"::Payment;
                                            GenJnl.VALIDATE(GenJnl."Document No.");
                                            GenJnl."Journal Template Name" := 'SALES';
                                            GenJnl."Journal Batch Name" := 'STUD PAY';
                                            GenJnl."Account Type" := GenJnl."Account Type"::"G/L Account";
                                            GenJnl."Account No." := GenSetup."Pre-Payment Account";
                                            GenJnl.Amount := StudentCharges.Amount * (StudentCharges.Distribution / 100);
                                            GenJnl.VALIDATE(GenJnl."Account No.");
                                            GenJnl.VALIDATE(GenJnl.Amount);
                                            GenJnl.Description := 'Fee Distribution';
                                            GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                                            GenJnl."Bal. Account No." := Stages."Distribution Account";
                                            GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                                            IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Fees" THEN BEGIN
                                                IF Stages.GET(StudentCharges.Programme, StudentCharges.Stage) THEN BEGIN
                                                    GenJnl."Shortcut Dimension 2 Code" := Stages.Department;
                                                END;

                                            END ELSE
                                                IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Fees" THEN BEGIN
                                                    IF Units.GET(StudentCharges.Programme, StudentCharges.Stage, StudentCharges.Unit) THEN BEGIN
                                                        GenJnl."Shortcut Dimension 2 Code" := Units.Department;
                                                    END;
                                                END;
                                            GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");

                                            GenJnl.INSERT;

                                        END;
                                    END;
                                END;
                            END;
                            //End Distribution


                            StudentCharges.Recognized := TRUE;
                            StudentCharges.MODIFY;

                        UNTIL StudentCharges.NEXT = 0;



                        /*
                        //Post
                        GenJnl.RESET;
                        GenJnl.SETRANGE("Journal Template Name",'SALES');
                        GenJnl.SETRANGE("Journal Batch Name",'STUD PAY');
                        IF GenJnl.FIND('-') THEN BEGIN
                        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",GenJnl);
                        MODIFY;
                        END;
                        */


                        GenJnl.SETRANGE("Journal Template Name", 'SALES');
                        GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                        IF GenJnl.FIND('-') THEN BEGIN
                            REPEAT
                                //window.OPEN('Posting:,#1######################');
                                //window.UPDATE(1,GenJnl."Line No.");
                                GLPosting.RUN(GenJnl);
                            UNTIL GenJnl.NEXT = 0;
                            //window.CLOSE;
                        END;




                        GenJnl.RESET;
                        GenJnl.SETRANGE("Journal Template Name", 'SALES');
                        GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                        GenJnl.DELETEALL;



                        Cust.Status := Cust.Status::Current;
                        Cust.MODIFY;

                    END;





                    Posted := TRUE;
                    MODIFY;



                END;

            end;
        }
        field(19; "Student Type"; Option)
        {
            OptionCaption = 'Full Time,Part Time,Distance Learning';
            OptionMembers = "Full Time","Part Time","Distance Learning";
        }
        field(20; Posted; Boolean)
        {
            Editable = false;
        }
        field(21; "Units Taken"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           "Reg. Transacton ID" = FIELD("Reg. Transacton ID"),
                                                           Taken = CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(22; "User ID"; Code[20])
        {
        }
        field(23; "Total Paid"; Decimal)
        {
            CalcFormula = Sum("ACA-Receipt Items".Amount WHERE("Reg. No" = FIELD("Reg. Transacton ID"),
                                                                "Student No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(24; Status; Option)
        {
            FieldClass = Normal;
            OptionMembers = " ",Registration,Current,Alluminae,Dropped;
        }
        field(25; "Status Change Date"; Date)
        {
        }
        field(26; "Fees Billed"; Decimal)
        {
            CalcFormula = Sum("ACA-Std Charges".Amount WHERE("Reg. Transacton ID" = FIELD("Reg. Transacton ID"),
                                                              "Tuition Fee" = CONST(true)));
            FieldClass = FlowField;
        }
        field(27; "Total Billed"; Decimal)
        {
            CalcFormula = Sum("ACA-Std Charges".Amount WHERE("Reg. Transacton ID" = FIELD("Reg. Transacton ID"),
                                                              "Student No." = FIELD("Student No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(28; Reversed; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Reg. Transacton ID", "Student No.", Programmes, Semester, "Register for", Stage, Unit, "Student Type")
        {
        }
        key(Key2; "Student Type")
        {
        }
        key(Key3; "Student No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF "Attending Classes" = TRUE THEN
            ERROR('Transaction once posted cannot be delete.');

        IF Posted = TRUE THEN
            ERROR('Transaction once posted cannot be delete.');
        /*
        GenSetup.GET;
        IF ("Registration Date" > GenSetup."Allow Posting To") OR ("Registration Date" < GenSetup."Allow Posting From") THEN
        ERROR('Modification or deletion out of the allowed range not allowed.');
        */

        StudentCharges.RESET;
        StudentCharges.SETRANGE(StudentCharges."Reg. Transacton ID", "Reg. Transacton ID");
        IF StudentCharges.FIND('-') THEN
            StudentCharges.DELETEALL;

        StudentUnits.RESET;
        StudentUnits.SETRANGE(StudentUnits."Reg. Transacton ID", "Reg. Transacton ID");
        IF StudentUnits.FIND('-') THEN
            StudentUnits.DELETEALL;

    end;

    trigger OnInsert()
    begin
        IF "Reg. Transacton ID" = '' THEN BEGIN
            GenSetup.GET;
            GenSetup.TESTFIELD(GenSetup."Registration Nos.");
            //NoSeriesMgt.InitSeries(GenSetup."Registration Nos.",xRec."No. Series",0D,"Reg. Transacton ID","No. Series");
        END;
    end;

    trigger OnModify()
    begin
        IF "Attending Classes" = TRUE THEN
            ERROR('Transaction once posted cannot be modified.');

        IF Posted = TRUE THEN
            ERROR('Transaction once posted cannot be modified.');

        GenSetup.GET;
        IF ("Registration Date" > GenSetup."Allow Posting To") OR ("Registration Date" < GenSetup."Allow Posting From") THEN;
        ERROR('Modification or deletion out of the allowed range not allowed.');
    end;

    var
        FeeByStage: Record 61523;
        FeeByUnit: Record 61524;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenSetup: Record 61534;
        StudentCharges: Record 61535;
        TotalCost: Decimal;
        StageCharges: Record 61533;
        NewStudentCharges: Record 61543;
        RecFound: Boolean;
        CoursePrerequisite: Record 61546;
        SPrereq: Record 61547;
        Stages: Record 61516;
        StudentUnits: Record 61549;
        StageUnits: Record 61517;
        GenJnl: Record 81;
        Units: Record 61517;
        ExamsByStage: Record 61526;
        ExamsByUnit: Record 61527;
        Charges: Record 61515;
        Sems: Record 61692;
        SemFound: Boolean;
        DueDate: Date;
        Cust: Record 18;
        GenBatches: Record 232;
        window: Dialog;
        GLPosting: Codeunit 12;
        SettlementType: Record 61522;
        CReg: Record 61532;
        CustPostGroup: Record 92;
        Programmz: Record 61511;
        CourseReg: Record 61532;
        Found: Boolean;
        LibCode: Text[30];
        LibRefCodes: Record 61562;
        Custs: Record 18;
}

