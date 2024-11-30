table 61532 "ACA-Course Registration"
{
    DrillDownPageID = 68773;
    LookupPageID = 68773;

    fields
    {
        field(1; "Student No."; Code[20])
        {
            NotBlank = true;
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if Posted = TRUE then
                    ERROR('Transaction once posted cannot be modified.');
                // CLEAR(YearOfAdmin);
                // if STRLEN(Rec."Student No.") > 1 THEN BEGIN
                //     IF EVALUATE(YearOfAdmin, COPYSTR(Rec."Student No.", STRLEN(Rec."Student No.") - 1, 2)) THEN
                //         Rec."Year of Admission" := YearOfAdmin;
                // END;
            end;
        }
        field(2; Semester; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme Semesters".Semester WHERE("Programme Code" = FIELD(Programmes));

            trigger OnValidate()
            begin
                //"Settlement Type":='';
                coReg2.RESET;
                coReg2.SETRANGE(coReg2.Semester, Semester);
                coReg2.SETRANGE(coReg2."Student No.", "Student No.");
                coReg2.SETRANGE(Reversed, FALSE);
                IF coReg2.FIND('-') THEN BEGIN
                    IF coReg2.COUNT > 1 THEN ERROR('Multiple Registration in the same semester is not allowed....');
                END;
            end;
        }
        field(3; Programmes; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme".Code WHERE(Category = FILTER(<> Professional));

            trigger OnValidate()
            begin
                Sems.RESET;
                Sems.SETRANGE(Sems."Current Semester", TRUE);
                IF Sems.FIND('-') THEN BEGIN
                    PSemester.RESET;
                    PSemester.SETRANGE("Programme Code", Programmes);
                    PSemester.SETRANGE(Semester, Sems.Code);
                    IF NOT PSemester.FIND('-') THEN BEGIN
                        PSemester.RESET;
                        PSemester.SETRANGE("Programme Code", Programmes);
                        IF PSemester.FIND('-') THEN BEGIN
                            REPEAT
                                IF PSemester.Current = TRUE THEN BEGIN
                                    PSemester.Current := FALSE;
                                    PSemester.MODIFY;
                                END;
                            UNTIL PSemester.NEXT = 0;
                        END;
                        PSemester.INIT;
                        PSemester."Programme Code" := Programmes;
                        PSemester.Semester := Sems.Code;
                        PSemester.Current := TRUE;
                        PSemester.INSERT(TRUE);
                    END;
                END;
                //"Settlement Type":='';
                IF Posted = TRUE THEN
                    ERROR('Transaction once posted cannot be modified.');

                IF Posted = TRUE THEN EXIT;
                acadYears.RESET;
                acadYears.SETRANGE(acadYears.Current, TRUE);
                IF acadYears.FIND('-') THEN BEGIN
                    "Academic Year" := acadYears.Code;
                END;



                Found := FALSE;

                CourseReg.RESET;
                CourseReg.SETRANGE(CourseReg."Student No.", Rec."Student No.");
                CourseReg.SETRANGE(CourseReg.Reversed, FALSE);
                IF CourseReg.FIND('-') THEN BEGIN
                    REPEAT
                        Programmz.RESET;
                        Programmz.SETRANGE(Programmz.Code, CourseReg.Programmes);
                        IF Programmz.FIND('-') THEN BEGIN
                            //ProgramName := Programmz.Description;
                            IF Programmz.Priority = 1 THEN BEGIN
                                Found := TRUE;
                                LibCode := Programmz.Code;
                            END;


                            //Don't allow multiple programme registration
                            /*IF Programme <> '' THEN BEGIN
                            IF Programme <> CourseReg.Programme THEN BEGIN
                            IF Prog.GET(Programme) THEN BEGIN
                            IF Prog2.GET(CourseReg.Programme) THEN BEGIN
                            IF Prog.Category = Prog2.Category THEN
                            ERROR('You can only register a student for one programme.');
                            END;
                            END;
                            END;
                            END;*/


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


                //Default Stage and semeter

                //Defaulting of semester
                Sems.RESET;
                Sems.SETRANGE(Sems."Current Semester", TRUE);
                IF Sems.FIND('-') THEN
                    Semester := Sems.Code
                ELSE
                    ERROR('Please specify the Curent Semester in the Semesters Setup!');
                VALIDATE(Semester);
                // Get Default Year
                // GenSetup.GET;
                //IF GenSetup."Default Year"<>'' THEN BEGIN
                // Stage:=GenSetup."Default Year";
                // coReg1.RESET;
                // coReg1.SETRANGE(coReg1."Student No.", "Student No.");
                // coReg1.SETFILTER(coReg1.Stage, '<>%1', '');
                // coReg1.SETFILTER(Reversed, '=%1', FALSE);
                // IF coReg1.FIND('-') THEN BEGIN
                //     IF coReg1.COUNT = 0 THEN
                //         Stage := 'Y1S1' ELSE
                //         IF coReg1.COUNT = 1 THEN
                //             Stage := 'Y1S2' ELSE
                //             IF coReg1.COUNT = 2 THEN
                //                 Stage := 'Y2S1' ELSE
                //                 IF coReg1.COUNT = 3 THEN
                //                     Stage := 'Y2S2' ELSE
                //                     IF coReg1.COUNT = 4 THEN
                //                         Stage := 'Y3S1' ELSE
                //                         IF coReg1.COUNT = 5 THEN
                //                             Stage := 'Y3S2' ELSE
                //                             IF coReg1.COUNT = 6 THEN
                //                                 Stage := 'Y4S1' ELSE
                //                                 IF coReg1.COUNT = 7 THEN Stage := 'Y4S2';
                //     //END;

                // END;
                // Get Default Intake
                IntakeRec.RESET;
                IntakeRec.SETRANGE(IntakeRec.Current, TRUE);
                IF IntakeRec.FIND('-') THEN
                    Session := IntakeRec.Code;
                VALIDATE("Reg. Transacton ID");



                IF Cust.GET("Student No.") THEN BEGIN
                    Cust."Current Programme" := Programmes;
                    //Cust.MODIFY;
                END;
                // Insert the Settlement Type
                CReg2.RESET;
                CReg2.SETRANGE("Student No.", Rec."Student No.");
                CReg2.SETFILTER("Settlement Type", '<>%1', '');
                IF CReg2.FIND('-') THEN BEGIN
                    "Settlement Type" := CReg2."Settlement Type";

                END;

                IF "Registration Date" = 0D THEN
                    "Registration Date" := TODAY;
                VALIDATE(Stage);
                //VALIDATE("Registration Date");
                //VALIDATE("Settlement Type");

            end;
        }
        field(4; "Register for"; Option)
        {
            NotBlank = false;
            OptionCaption = 'Stage,Unit/Subject,Supplementary';
            OptionMembers = Stage,"Unit/Subject",Supplementary;

            trigger OnValidate()
            begin
                //"Settlement Type":='';
                IF "Register for" = "Register for"::Stage THEN
                    Unit := '';
            end;
        }
        field(5; Stage; Code[20])
        {
            Caption = 'Cohort Stage';
            NotBlank = true;
            TableRelation = "ACA-Programme Stages".Code where("Programme Code" = field(Programmes));
            trigger OnValidate()
            var
                YearOfStudy: Integer;
                ACASemesters: Record "ACA-Semesters";
            begin

                CLEAR(YearOfStudy);
                IF EVALUATE(YearOfStudy, COPYSTR(Rec.Stage, 2, 1)) THEN BEGIN

                END;

                IF YearOfStudy <> 0 THEN BEGIN
                    "Year Of Study" := YearOfStudy;
                END;

                ACASemesters.RESET;
                ACASemesters.SETRANGE(Code, Rec.Semester);
                IF ACASemesters.FIND('-') THEN BEGIN
                    IF ACASemesters."Academic Year" <> '' THEN BEGIN
                        "Academic Year" := ACASemesters."Academic Year";
                    END;
                END;

                //"Settlement Type":='';
                // Check duplicates
                /*
                CReg.RESET;
                CReg.SETRANGE(CReg."Student No.","Student No.");
                CReg.SETRANGE(CReg.Stage,Stage);
                CReg.SETRANGE(CReg."Register for","Register for");
                IF CReg.FIND('-') THEN BEGIN
                REPEAT
                IF CReg."Reg. Transacton ID"<>"Reg. Transacton ID" THEN
                //IF CReg.Reversed=FALSE THEN ERROR(
                //'Please note that you can not register to same year twice without stopping the older registration')
                UNTIL CReg.NEXT=0;
                END;*/

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

                END;


                IF Cust.GET("Student No.") THEN BEGIN
                    Cust."Current Stage" := Stage;
                    Cust.MODIFY;
                END;

            end;
        }
        field(6; Unit; Code[20])
        {
            //fieldclass = flowfield;
            TableRelation = "ACA-Student Units".Unit where(Programme = field(Programmes), "Student No." = field("Student No."));

        }
        field(7; "Settlement Type"; Code[20])
        {
            NotBlank = false;
            TableRelation = "ACA-Settlement Type";

            trigger OnValidate()
            begin
                //VALIDATE("Registration Date");

                IF "Allow Adjustment" = FALSE THEN BEGIN

                    IF Posted = TRUE THEN
                        ERROR('You can not modify an already posted registration.');
                END ELSE BEGIN
                    "Allow Adjustment" := FALSE;
                    MODIFY;

                END;
                //"Allow Adjustment":=FALSE;
                TESTFIELD("Reg. Transacton ID");
                CalcFields("Campus Code");
                //TESTFIELD("Registration Date");
                "User ID" := USERID;
                //MODIFY;

                CReg2.RESET;
                CReg2.SETRANGE(CReg2."Student No.", "Student No.");
                CReg2.SETRANGE(CReg2.Programmes, Programmes);
                CReg2.SETRANGE(CReg2.Stage, Stage);
                CReg2.SETRANGE(CReg2.Unit, Unit);
                CReg2.SETRANGE(CReg2."Student Type", "Student Type");
                CReg2.SETRANGE(CReg2.Semester, Semester);
                CReg2.SETRANGE(CReg2.Reversed, FALSE);
                CReg2.SETRANGE(CReg2."Register for", "Register for");
                IF CReg2.FIND('-') THEN BEGIN
                    REPEAT
                        IF "Reg. Transacton ID" <> CReg2."Reg. Transacton ID" THEN BEGIN
                            //ERROR('Student already registered for this course.');
                            //Audit Issue":=TRUE;
                            //MODIFY;
                            //
                        END;
                    UNTIL CReg2.NEXT = 0;


                END;




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
                            CALCFIELDS("Units Taken");
                            Modules := "Units Taken";
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

                //PKK - Old student
                OldStud := FALSE;
                IF Stage <> 'Y1S1' THEN
                    OldStud := TRUE;
                //PKK

                IF Posted = FALSE THEN BEGIN

                    IF "First Time Student" = TRUE THEN BEGIN
                        /*
                        StudentCharges.RESET;
                        StudentCharges.SETRANGE(StudentCharges."Student No.","Student No.");
                        IF NOT StudentCharges.FIND('-') THEN BEGIN
                        */
                        NewStudentCharges.RESET;
                        NewStudentCharges.SETRANGE(NewStudentCharges."Programme Code", Programmes);
                        NewStudentCharges.SETRANGE(NewStudentCharges."First Time Students", TRUE);

                        IF NewStudentCharges.FIND('-') THEN BEGIN
                            REPEAT
                            /*StudentCharges.INIT;
                            StudentCharges.Programme:=Programme;
                            StudentCharges.Stage:=Stage;
                            StudentCharges.Semester:=Semester;
                            StudentCharges."Student No.":="Student No.";
                            StudentCharges."Reg. Transacton ID":="Reg. Transacton ID";
                            StudentCharges."Transaction Type":=StudentCharges."Transaction Type"::"Stage Fees";
                            StudentCharges.Date:="Registration Date";
                            StudentCharges.Code:=NewStudentCharges.Code;
                            StudentCharges.Description:=NewStudentCharges.Description;
                            StudentCharges.Amount:=NewStudentCharges.Amount;
                            StudentCharges."Recovered First":=NewStudentCharges."Recovered First";
                            StudentCharges."Recovery Priority":=NewStudentCharges."Recovery Priority";
                            StudentCharges.Distribution:=NewStudentCharges."Distribution (%)";
                            StudentCharges."Distribution Account":=NewStudentCharges."Distribution Account";
                            StudentCharges.Charge:=TRUE;
                            StudentCharges."Transacton ID":='';
                            StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                            StudentCharges.INSERT;*/

                            UNTIL NewStudentCharges.NEXT = 0
                            //END;
                        END;
                    END;


                    NewStudentCharges.RESET;
                    NewStudentCharges.SETRANGE(NewStudentCharges."Programme Code", Programmes);
                    NewStudentCharges.SETRANGE(NewStudentCharges."First Time Students", FALSE);
                    IF NewStudentCharges.FIND('-') THEN BEGIN
                        REPEAT
                        /*StudentCharges.INIT;
                        StudentCharges.Programme:=Programme;
                        StudentCharges.Stage:=Stage;
                        StudentCharges.Semester:=Semester;
                        StudentCharges."Student No.":="Student No.";
                        StudentCharges."Reg. Transacton ID":="Reg. Transacton ID";
                        StudentCharges."Transaction Type":=StudentCharges."Transaction Type"::"Stage Fees";
                        StudentCharges.Date:="Registration Date";
                        StudentCharges.Code:=NewStudentCharges.Code;
                        StudentCharges.Description:=NewStudentCharges.Description;
                        StudentCharges.Amount:=NewStudentCharges.Amount;
                        StudentCharges."Recovered First":=NewStudentCharges."Recovered First";
                        StudentCharges."Recovery Priority":=NewStudentCharges."Recovery Priority";
                        StudentCharges.Distribution:=NewStudentCharges."Distribution (%)";
                        StudentCharges."Distribution Account":=NewStudentCharges."Distribution Account";
                        StudentCharges.Charge:=TRUE;
                        StudentCharges."Transacton ID":='';
                        StudentCharges.VALIDATE(StudentCharges."Transacton ID");*/
                        //StudentCharges.INSERT;

                        UNTIL NewStudentCharges.NEXT = 0
                    END;




                    TotalUnits := 0;
                    if Rec."Settlement Type" = 'FT(UBB)' then
                        Rec."Register for" := "Register for"::"Unit/Subject" else
                        if rec."Settlement Type" = 'PT(UBB)' then
                            Rec."Register for" := "Register for"::"Unit/Subject" else
                            if Rec."Settlement Type" = 'ODEL(UBB)' then
                                Rec."Register for" := "Register for"::"Unit/Subject";



                    IF ("Settlement Type" <> '') and ("Settlement Type" <> 'units') THEN BEGIN
                        IF "Register for" = "Register for"::Stage THEN BEGIN

                            FeeByStage.RESET;
                            FeeByStage.SETRANGE(FeeByStage."Programme Code", Programmes);
                            FeeByStage.SETRANGE(FeeByStage."Stage Code", Stage);
                            FeeByStage.SETRANGE(FeeByStage."Settlemet Type", "Settlement Type");
                            FeeByStage.SetRange(FeeByStage.Campus, "Campus Code");
                            //FeeByStage.SETRANGE(FeeByStage.Semester,Semester);
                            //FeeByStage.SETRANGE(FeeByStage."Student Type","Student Type");
                            IF not FeeByStage.FIND('-') THEN BEGIN
                                //ERROR('I made it here');
                                //ERROR('No fees structure defined for the settlement type!.Kindly Contact Administrator ' + Programmes);
                                //"Audit Issue":=TRUE;
                                //MODIFY;
                                //
                                //"Settlement Type":='';
                            END
                            ELSE BEGIN



                                IF FeeByStage.FIND('-') THEN BEGIN

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

                                        CALCFIELDS("Total Exempted");

                                        //Exemptions
                                        IF "Total Exempted" > 0 THEN BEGIN
                                            IF TotalUnits > 0 THEN BEGIN
                                                TotalCost := (TotalUnits - "Total Exempted") * (TotalCost / TotalUnits);
                                            END;
                                        END;

                                        ///////////////////////
                                        //Recalculate fee based on units
                                        IF Modules > 0 THEN BEGIN
                                            TotalCost := 0;

                                            PStage.RESET;
                                            PStage.SETRANGE(PStage."Programme Code", Programmes);
                                            PStage.SETFILTER(PStage."Student No.", "Student No.");
                                            PStage.SETFILTER(PStage."Reg. ID", "Reg. Transacton ID");
                                            IF PStage.FIND('-') THEN BEGIN
                                                REPEAT
                                                    PStage.CALCFIELDS(PStage."Units Taken");

                                                    IF PStage."Units Taken" > 0 THEN BEGIN
                                                        SFee.RESET;
                                                        SFee.SETRANGE(SFee."Programme Code", Programmes);
                                                        SFee.SETRANGE(SFee."Stage Code", PStage.Code);
                                                        SFee.SETRANGE(SFee."Settlemet Type", "Settlement Type");
                                                        //SFee.SETRANGE(SFee.Semester,Semester);
                                                        //SFee.SETRANGE(SFee."Student Type","Student Type");
                                                        IF SFee.FIND('-') THEN BEGIN
                                                            TotalCost := TotalCost + (SFee."Break Down" * PStage."Units Taken");
                                                        end
                                                        ELSE
                                                            ERROR('No fee structure defined for %1.', PStage.Code)

                                                    END;

                                                UNTIL PStage.NEXT = 0;
                                            END;
                                        END;
                                        ///////////////////////


                                        StudentCharges.Amount := TotalCost;
                                        StudentCharges."Tuition Fee" := TRUE;
                                        StudentCharges."Full Tuition Fee" := TotalCost;
                                        StudentCharges."Transacton ID" := '';
                                        StudentCharges."Recovery Priority" := 20;
                                        StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                                        StudentCharges.INSERT;

                                    UNTIL FeeByStage.NEXT = 0;


                                    StageCharges.RESET;
                                    StageCharges.SETRANGE(StageCharges."Programme Code", Programmes);
                                    StageCharges.SETRANGE(StageCharges."Stage Code", Stage);
                                    //StageCharges.SETRANGE(StageCharges."Student Type",StageCharges."Student Type"::" ");
                                    StageCharges.SETRANGE(StageCharges."Settlement Type", "Settlement Type");
                                    IF StageCharges.FIND('-') THEN BEGIN
                                        REPEAT
                                            /*IF StageCharges.Semester = '' THEN BEGIN
                                            StudentCharges.INIT;
                                            StudentCharges.Programme:=Programme;
                                            StudentCharges.Stage:=Stage;
                                            StudentCharges.Semester:=Semester;
                                            StudentCharges."Student No.":="Student No.";
                                            StudentCharges."Reg. Transacton ID":="Reg. Transacton ID";
                                            StudentCharges."Transaction Type":=StudentCharges."Transaction Type"::"Stage Fees";
                                            StudentCharges.Date:="Registration Date";
                                            StudentCharges.Code:=StageCharges.Code;
                                            StudentCharges.Description:=StageCharges.Description;
                                            StudentCharges.Amount:=StageCharges.Amount;
                                            StudentCharges."Recovered First":=StageCharges."Recovered First";
                                            StudentCharges."Recovery Priority":=StageCharges."Recovery Priority";
                                            StudentCharges.Distribution:=StageCharges."Distribution (%)";
                                            StudentCharges."Distribution Account":=StageCharges."Distribution Account";
                                            StudentCharges."Transacton ID":='';
                                            StudentCharges.Charge:=TRUE;
                                            StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                                            StudentCharges.INSERT;

                                            END ELSE BEGIN
                                            IF StageCharges.Semester = Semester THEN BEGIN*/
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
                                            StudentCharges."Recovery Priority" := StageCharges."Recovery Priority";
                                            StudentCharges.Distribution := StageCharges."Distribution (%)";
                                            StudentCharges."Distribution Account" := StageCharges."Distribution Account";
                                            StudentCharges."Transacton ID" := '';
                                            StudentCharges.Charge := TRUE;
                                            StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                                            StudentCharges.INSERT;
                                        //END;
                                        //END;

                                        UNTIL StageCharges.NEXT = 0;

                                    END;
                                    /*
                                    IF "Student Type" = "Student Type"::"Full Time" THEN BEGIN
                                    ///////Charges by student type - Full Time
                                    StageCharges.RESET;
                                    StageCharges.SETRANGE(StageCharges."Programme Code",Programme);
                                    StageCharges.SETRANGE(StageCharges."Stage Code",Stage);
                                    //StageCharges.SETRANGE(StageCharges."Student Type",StageCharges."Student Type"::"Full Time");
                                    StageCharges.SETRANGE(StageCharges."Settlement Type","Settlement Type");
                                    IF StageCharges.FIND('-') THEN BEGIN
                                    REPEAT
                                    IF StageCharges.Semester = '' THEN BEGIN
                                    StudentCharges.INIT;
                                    StudentCharges.Programme:=Programme;
                                    StudentCharges.Stage:=Stage;
                                    StudentCharges.Semester:=Semester;
                                    StudentCharges."Student No.":="Student No.";
                                    StudentCharges."Reg. Transacton ID":="Reg. Transacton ID";
                                    StudentCharges."Transaction Type":=StudentCharges."Transaction Type"::"Stage Fees";
                                    StudentCharges.Date:="Registration Date";
                                    StudentCharges.Code:=StageCharges.Code;
                                    StudentCharges.Description:=StageCharges.Description;
                                    StudentCharges.Amount:=StageCharges.Amount;
                                    StudentCharges."Recovered First":=StageCharges."Recovered First";
                                    StudentCharges."Recovery Priority":=StageCharges."Recovery Priority";
                                    StudentCharges.Distribution:=StageCharges."Distribution (%)";
                                    StudentCharges."Distribution Account":=StageCharges."Distribution Account";
                                    StudentCharges."Transacton ID":='';
                                    StudentCharges.Charge:=TRUE;
                                    StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                                    StudentCharges.INSERT;

                                    END ELSE BEGIN
                                    IF StageCharges.Semester = Semester THEN BEGIN
                                    StudentCharges.INIT;
                                    StudentCharges.Programme:=Programme;
                                    StudentCharges.Stage:=Stage;
                                    StudentCharges.Semester:=Semester;
                                    StudentCharges."Student No.":="Student No.";
                                    StudentCharges."Reg. Transacton ID":="Reg. Transacton ID";
                                    StudentCharges."Transaction Type":=StudentCharges."Transaction Type"::"Stage Fees";
                                    StudentCharges.Date:="Registration Date";
                                    StudentCharges.Code:=StageCharges.Code;
                                    StudentCharges.Description:=StageCharges.Description;
                                    StudentCharges.Amount:=StageCharges.Amount;
                                    StudentCharges."Recovered First":=StageCharges."Recovered First";
                                    StudentCharges."Recovery Priority":=StageCharges."Recovery Priority";
                                    StudentCharges.Distribution:=StageCharges."Distribution (%)";
                                    StudentCharges."Distribution Account":=StageCharges."Distribution Account";
                                    StudentCharges."Transacton ID":='';
                                    StudentCharges.Charge:=TRUE;
                                    StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                                    StudentCharges.INSERT;
                                    END;
                                    END;

                                    UNTIL StageCharges.NEXT = 0;

                                    END;

                                    END ELSE BEGIN
                                    ///////Charges by student type - Part Time
                                    StageCharges.RESET;
                                    StageCharges.SETRANGE(StageCharges."Programme Code",Programme);
                                    StageCharges.SETRANGE(StageCharges."Stage Code",Stage);
                                    //StageCharges.SETRANGE(StageCharges."Student Type",StageCharges."Student Type"::"Part Time");
                                    StageCharges.SETRANGE(StageCharges."Settlement Type","Settlement Type");
                                    IF StageCharges.FIND('-') THEN BEGIN
                                    REPEAT
                                    IF StageCharges.Semester = '' THEN BEGIN
                                    StudentCharges.INIT;
                                    StudentCharges.Programme:=Programme;
                                    StudentCharges.Stage:=Stage;
                                    StudentCharges.Semester:=Semester;
                                    StudentCharges."Student No.":="Student No.";
                                    StudentCharges."Reg. Transacton ID":="Reg. Transacton ID";
                                    StudentCharges."Transaction Type":=StudentCharges."Transaction Type"::"Stage Fees";
                                    StudentCharges.Date:="Registration Date";
                                    StudentCharges.Code:=StageCharges.Code;
                                    StudentCharges.Description:=StageCharges.Description;
                                    StudentCharges.Amount:=StageCharges.Amount;
                                    StudentCharges."Recovered First":=StageCharges."Recovered First";
                                    StudentCharges."Recovery Priority":=StageCharges."Recovery Priority";
                                    StudentCharges.Distribution:=StageCharges."Distribution (%)";
                                    StudentCharges."Distribution Account":=StageCharges."Distribution Account";
                                    StudentCharges."Transacton ID":='';
                                    StudentCharges.Charge:=TRUE;
                                    StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                                    StudentCharges.INSERT;

                                    END ELSE BEGIN
                                    IF StageCharges.Semester = Semester THEN BEGIN
                                    StudentCharges.INIT;
                                    StudentCharges.Programme:=Programme;
                                    StudentCharges.Stage:=Stage;
                                    StudentCharges.Semester:=Semester;
                                    StudentCharges."Student No.":="Student No.";
                                    StudentCharges."Reg. Transacton ID":="Reg. Transacton ID";
                                    StudentCharges."Transaction Type":=StudentCharges."Transaction Type"::"Stage Fees";
                                    StudentCharges.Date:="Registration Date";
                                    StudentCharges.Code:=StageCharges.Code;
                                    StudentCharges.Description:=StageCharges.Description;
                                    StudentCharges.Amount:=StageCharges.Amount;
                                    StudentCharges."Recovered First":=StageCharges."Recovered First";
                                    StudentCharges."Recovery Priority":=StageCharges."Recovery Priority";
                                    StudentCharges.Distribution:=StageCharges."Distribution (%)";
                                    StudentCharges."Distribution Account":=StageCharges."Distribution Account";
                                    StudentCharges."Transacton ID":='';
                                    StudentCharges.Charge:=TRUE;
                                    StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                                    StudentCharges.INSERT;
                                    END;
                                    END;

                                    UNTIL StageCharges.NEXT = 0;

                                    END;
                                    END;
                                    */

                                END;

                            END

                        END;

                        IF "Register for" = "Register for"::"Unit/Subject" THEN BEGIN
                            // StudentUnits.Reset();
                            // StudentUnits.SetRange("Student No.", "Student No.");
                            // StudentUnits.SetRange(Stage, "Stage Filter");
                            // StudentUnits.SetRange("Register for", StudentUnits."Register for"::"Unit/Subject");
                            TotalCost := 0;
                            StudentUnits.Reset();
                            StudentUnits.SetRange("Student No.", Rec."Student No.");
                            StudentUnits.SetRange("Academic Year", Rec."Academic Year");
                            StudentUnits.SetRange(Semester, Rec.Semester);
                            StudentUnits.SetRange(Stage, Rec.Stage);
                            //StudentUnits.SetRange("Reg. Transacton ID", Rec."Reg. Transacton ID");
                            if StudentUnits.Find('-') then begin
                                repeat
                                    FeeByUnit.Reset();
                                    FeeByUnit.SetRange("Unit Code", StudentUnits.Unit);
                                    FeeByUnit.SetRange("Programme Code", StudentUnits.Programme);
                                    FeeByUnit.SetRange("Settlemet Type", rec."Settlement Type");
                                    FeeByUnit.SetRange(Campus, Rec."Campus Code");
                                    if FeeByUnit.Find('-') then begin
                                        //Message(Format(FeeByUnit."Break Down"));
                                        TotalCost := TotalCost + FeeByUnit."Break Down";
                                    end;
                                until StudentUnits.Next() = 0;
                                //Error(Format(TotalCost));
                            end;

                            // FeeByUnit.RESET;
                            // FeeByUnit.SETRANGE(FeeByUnit."Programme Code", Programmes);

                            // //FeeByUnit.SETRANGE(FeeByUnit."Stage Code", Stage);
                            // FeeByUnit.SETRANGE(FeeByUnit."Unit Code", Unit);
                            // //FeeByUnit.SETRANGE(FeeByUnit.Semester,Semester);
                            // FeeByUnit.SETRANGE(FeeByUnit."Settlemet Type", "Settlement Type");
                            // //FeeByUnit.SETRANGE(FeeByUnit."Student Type","Student Type");
                            // IF NOT FeeByUnit.FIND('-') THEN BEGIN
                            //     ERROR('No fees structure defined for the settlement type. !' + Stage);
                            //     "Settlement Type" := '';
                            // END
                            // ELSE BEGIN
                            //Insert Units
                            /*
                            StudentUnits.INIT;
                            StudentUnits."Reg. Transacton ID":="Reg. Transacton ID";
                            StudentUnits."Student No.":="Student No.";
                            StudentUnits.Programme:=Programme;
                            StudentUnits.Stage:=Stage;
                            StudentUnits.Unit:=Unit;
                            StudentUnits.Semester:=Semester;
                            StudentUnits."Register for":="Register for";
                            //IF Stages."Modules Registration" = FALSE THEN
                            StudentUnits.Taken:=TRUE;
                            //StudentUnits.INSERT;
                            */

                            // REPEAT
                            //     TotalCost := TotalCost + FeeByUnit."Break Down";
                            // UNTIL FeeByUnit.NEXT = 0;

                            StudentCharges.INIT;
                            StudentCharges.Programme := Programmes;
                            StudentCharges.Stage := Stage;
                            StudentCharges.Unit := Unit;
                            StudentCharges.Semester := Semester;
                            StudentCharges."Student No." := "Student No.";
                            StudentCharges."Reg. Transacton ID" := "Reg. Transacton ID";
                            StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::"Unit Fees";
                            StudentCharges.Date := "Registration Date";
                            StudentCharges.Code := Rec.Stage;
                            StudentCharges.Description := 'Fees for' + ' ' + Programmes + '-' + Stage + '-' + Unit;
                            StudentCharges.Amount := TotalCost;
                            StudentCharges."Tuition Fee" := TRUE;
                            StudentCharges."Full Tuition Fee" := TotalCost;
                            StudentCharges."Transacton ID" := '';
                            StudentCharges."Recovery Priority" := 20;
                            StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                            StudentCharges.INSERT;




                            // Prog.GET(Programmes);
                            // Prog.TESTFIELD(Prog."Unit Fee");
                            // CALCFIELDS("Units Taken");
                            // IF "Units Taken" = 0 THEN ERROR('Please select the units to be billed');
                            // StudentCharges.INIT;
                            // StudentCharges.Programme := Programmes;
                            // StudentCharges.Stage := Stage;
                            // StudentCharges.Unit := Unit;
                            // StudentCharges.Semester := Semester;
                            // StudentCharges."Student No." := "Student No.";
                            // StudentCharges."Reg. Transacton ID" := "Reg. Transacton ID";
                            // StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::"Unit Fees";
                            // StudentCharges.Date := "Registration Date";
                            // StudentCharges.Code := Unit;
                            // StudentCharges.Description := 'Fees for' + ' ' + Programmes + '-' + Stage + '-' + FORMAT("Units Taken") + 'Units';
                            // StudentCharges.Amount := Prog."Unit Fee" * "Units Taken";
                            // StudentCharges."Tuition Fee" := TRUE;
                            // StudentCharges."Full Tuition Fee":=TotalCost;
                            // StudentCharges."Transacton ID" := '';
                            // StudentCharges."Recovery Priority" := 20;
                            // StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                            // StudentCharges.INSERT;

                            // END;
                        end;


                    END;


                end;
            end;
        }
        field(8; "Registration Date"; Date)
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                /*
                IF "Registration Date" <> 0D THEN BEGIN
                //"Settlement Type":='FULL PAYMENT';
                //VALIDATE("Settlement Type");
                END;

                //Insert units
                Cust.GET("Student No.");
                // CALCFIELDS(Status);
                // IF (Cust.Status<>0) OR (Cust.Status<>1) THEN ERROR('Please note that you can only register students with current and registration status!');
                {
                StudentUnits.RESET;
                StudentUnits.SETRANGE(StudentUnits."Student No.","Student No.");
                StudentUnits.SETRANGE(StudentUnits."Reg. Transacton ID","Reg. Transacton ID");
                IF StudentUnits.FIND('-') THEN
                StudentUnits.DELETEALL;
                }


                //Insert Students Units Single Options
                Stages.RESET;
                Stages.SETRANGE(Stages."Programme Code",Programme);
                Stages.SETRANGE(Stages.Code,Stage);
                IF Stages.FIND('-') THEN BEGIN
                StageUnits.RESET;
                StageUnits.SETRANGE(StageUnits."Programme Code",Programme);
                StageUnits.SETRANGE(StageUnits."Stage Code",Stage);
                StageUnits.SETRANGE(StageUnits."Programme Option",Options);
                StageUnits.SETRANGE(StageUnits."Old Unit",FALSE);
                IF StageUnits.FIND('-') THEN BEGIN
                REPEAT
                IF ("Register for"="Register for"::Stage) THEN BEGIN
                StageUnits.CALCFIELDS(StageUnits."Combination Count");

                StudentUnits.INIT;
                StudentUnits."Reg. Transacton ID":="Reg. Transacton ID";
                StudentUnits."Student No.":="Student No.";
                StudentUnits.Programme:=Programme;
                StudentUnits.Stage:=Stage;
                StudentUnits."Unit Stage":=Stage;
                StudentUnits.Unit:=StageUnits.Code;
                StudentUnits.Semester:=Semester;
                StudentUnits."Register for":="Register for";
                StudentUnits."Unit Type":=StageUnits."Unit Type";
                StudentUnits."No. Of Units":=StageUnits."No. Units";
                StudentUnits.Description:=StageUnits.Desription;
                IF Stages."Modules Registration" = FALSE THEN BEGIN
                IF (StageUnits."Unit Type" = StageUnits."Unit Type"::Core) OR (StageUnits."Unit Type" = StageUnits."Unit Type"::Required) THEN
                StudentUnits.Taken:=TRUE;
                END;
                {
                IF (StageUnits."Programme Option" = '') AND (StageUnits."Combination Count"=0) THEN
                StudentUnits.INSERT
                ELSE BEGIN
                IF (StageUnits."Unit Type" = StageUnits."Unit Type"::Core) THEN
                StudentUnits.INSERT;
                END;
                }

                TotalUnits:=TotalUnits+1;
                //END;
                END;
                UNTIL StageUnits.NEXT = 0
                END;

                //Insert Students Units Multiple Options
                Stages.RESET;
                Stages.SETRANGE(Stages."Programme Code",Programme);
                Stages.SETRANGE(Stages.Code,Stage);
                IF Stages.FIND('-') THEN BEGIN

                StageUnits.RESET;
                StageUnits.SETRANGE(StageUnits."Programme Code",Programme);
                StageUnits.SETRANGE(StageUnits."Stage Code",Stage);
                //StageUnits.SETRANGE(StageUnits."Programme Option",Options);
                StageUnits.SETFILTER(StageUnits."Combination Count",'>%1',0);
                IF StageUnits.FIND('-') THEN BEGIN
                REPEAT

                MultipleCombination.RESET;
                MultipleCombination.SETRANGE(MultipleCombination.Programme,Programme);
                MultipleCombination.SETRANGE(MultipleCombination.Stage,Stage);
                MultipleCombination.SETRANGE(MultipleCombination.Option,Options);
                MultipleCombination.SETRANGE(MultipleCombination.Unit,StageUnits.Code);
                IF MultipleCombination.FIND('-') AND ("Register for"="Register for"::Stage) THEN BEGIN
                StudentUnits.INIT;
                StudentUnits."Reg. Transacton ID":="Reg. Transacton ID";
                StudentUnits."Student No.":="Student No.";
                StudentUnits.Programme:=Programme;
                StudentUnits.Stage:=Stage;
                StudentUnits."Unit Stage":=Stage;
                StudentUnits.Unit:=StageUnits.Code;
                StudentUnits.Semester:=Semester;
                StudentUnits."Register for":="Register for";
                StudentUnits."Unit Type":=StageUnits."Unit Type";
                StudentUnits."No. Of Units":=StageUnits."No. Units";
                StudentUnits.Description:=StageUnits.Desription;
                IF (StageUnits."Unit Type" <> StageUnits."Unit Type"::Core) OR (StageUnits."Unit Type" = StageUnits."Unit Type"::Required) THEN
                StudentUnits.Taken:=TRUE;
                //IF Check_Units_Exist("Student No.",Programme,Stage,StageUnits.Code)=FALSE THEN
                //StudentUnits.INSERT;
                TotalUnits:=TotalUnits+1;
                END;

                UNTIL StageUnits.NEXT = 0
                END;
                END;
                END;
                //Insert Core Units
                IF (Options<>'') AND ("Register for"="Register for"::Stage) THEN BEGIN
                Stages.RESET;
                Stages.SETRANGE(Stages."Programme Code",Programme);
                Stages.SETRANGE(Stages.Code,Stage);
                IF Stages.FIND('-') THEN BEGIN
                StageUnits.RESET;
                StageUnits.SETRANGE(StageUnits."Programme Code",Programme);
                StageUnits.SETRANGE(StageUnits."Stage Code",Stage);
                StageUnits.SETRANGE(StageUnits."Unit Type",StageUnits."Unit Type"::Core);
                StageUnits.SETRANGE(StageUnits."Old Unit",FALSE);
                IF StageUnits.FIND('-') THEN BEGIN
                REPEAT
                StudentUnits.INIT;
                StudentUnits."Reg. Transacton ID":="Reg. Transacton ID";
                StudentUnits."Student No.":="Student No.";
                StudentUnits.Programme:=Programme;
                StudentUnits.Stage:=Stage;
                StudentUnits."Unit Stage":=Stage;
                StudentUnits.Unit:=StageUnits.Code;
                StudentUnits.Semester:=Semester;
                StudentUnits."Register for":="Register for";
                StudentUnits."Unit Type":=StageUnits."Unit Type";
                StudentUnits."No. Of Units":=StageUnits."No. Units";
                StudentUnits.Description:=StageUnits.Desription;
                StudentUnits.Taken:=TRUE;
                //IF Check_Units_Exist("Student No.",Programme,Stage,StageUnits.Code)=FALSE THEN
                //StudentUnits.INSERT;
                TotalUnits:=TotalUnits+1;
                //END;

                UNTIL StageUnits.NEXT = 0
                END;
                END;
                END;



                IF "Register for"="Register for"::Supplementary THEN BEGIN
                StudUnits.RESET;
                StudUnits.SETRANGE(StudUnits."Student No.","Student No.");
                StudUnits.SETRANGE(StudUnits.Stage,Stage);
                //StudUnits.SETRANGE(StudUnits.Semester,Semester);
                StudUnits.SETRANGE(StudUnits.Failed,TRUE);
                IF StudUnits.FIND('-') THEN BEGIN
                REPEAT
                StudentUnits.INIT;
                StudentUnits."Reg. Transacton ID":="Reg. Transacton ID";
                StudentUnits."Student No.":="Student No.";
                StudentUnits.Programme:=Programme;
                StudentUnits.Stage:=Stage;
                StudentUnits."Unit Stage":=StudUnits."Unit Stage";
                StudentUnits.Unit:=StudUnits.Unit;
                StudentUnits.Semester:=Semester;
                StudentUnits."Register for":="Register for";
                StudentUnits."Unit Type":=StudUnits."Unit Type";
                StudentUnits."No. Of Units":=StudUnits."No. Of Units";
                StudentUnits."Attachment Unit":=StudUnits."Attachment Unit";
                StudentUnits.Taken:=TRUE;
                StudentUnits."Re-Take":=TRUE;
                //StudentUnits.INSERT;
                UNTIL StudUnits.NEXT=0;
                END ELSE BEGIN
                ERROR('No Unit has been Marked as Failed in Selected Period');
                END;
                // Charge Supplimentary Fees if Enabled.
                GenSetup.GET;
                IF GenSetup."Bill Supplimentary Fee"=TRUE THEN BEGIN
                GenSetup.TESTFIELD(GenSetup."Supplimentary Fee Code");
                Charges.GET(GenSetup."Supplimentary Fee Code");
                CALCFIELDS("Units Taken");
                StudentCharges.INIT;
                StudentCharges.Programme:=Programme;
                StudentCharges.Stage:=Stage;
                StudentCharges.Semester:=Semester;
                StudentCharges."Student No.":="Student No.";
                StudentCharges."Reg. Transacton ID":="Reg. Transacton ID";
                StudentCharges."Transaction Type":=StudentCharges."Transaction Type"::"Stage Fees";
                StudentCharges.Date:="Registration Date";
                StudentCharges.Code:=GenSetup."Supplimentary Fee Code";
                StudentCharges.Description:=Charges.Description;
                StudentCharges.Amount:=Charges.Amount*"Units Taken";
                StudentCharges."Transacton ID":='';
                StudentCharges.Charge:=TRUE;
                StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                StudentCharges.INSERT;

                END;
                END;
                */

            end;
        }
        field(9; Remarks; Text[150])
        {
        }
        field(10; "Reg. Transacton ID"; Code[20])
        {

            trigger OnValidate()
            VAR
                REG: Record "ACA-Course Registration";
            begin

                IF "Reg. Transacton ID" = '' THEN BEGIN
                    GenSetup.GET;
                    GenSetup.TESTFIELD(GenSetup."Registration Nos.");
                    NoSeriesMgt.InitSeries(GenSetup."Registration Nos.", xRec."No. Series", 0D, "Reg. Transacton ID", "No. Series");
                END;
                Cust.Reset();
                Cust.SetRange("No.", rEC."Student No.");
                IF CUST.Find('-') then begin
                    Cust.CalcFields("Balance Due");
                    IF Cust."Balance Due" > 0 then begin
                        Error('%1%2', 'Student Must Clear Fee balance first! ', Cust."Balance Due")
                    end;
                    if ((cust.Status = Cust.Status::Suspended) or (cust.Status = Cust.Status::Deceased) or (cust.Status = Cust.Status::Transferred) or (cust.Status = Cust.Status::Alluminae) or (cust.Status = Cust.Status::Halt)) then
                        Error('You Are Not Allowed to Change The Status');
                end;



            end;
        }
        field(11; "No. Series"; Code[20])
        {

            trigger OnValidate()
            begin
                IF "Reg. Transacton ID" <> xRec."Reg. Transacton ID" THEN BEGIN
                    GenSetup.GET;
                    NoSeriesMgt.TestManual(GenSetup."Registration Nos.");
                    "No. Series" := '';
                END;

                IF "Reg. Transacton ID" = '' THEN BEGIN
                    GenSetup.GET;
                    GenSetup.TESTFIELD(GenSetup."Registration Nos.");
                    NoSeriesMgt.InitSeries(GenSetup."Registration Nos.", xRec."No. Series", 0D, "Reg. Transacton ID", "No. Series");
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
            Caption = 'Year Filter';
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD("Programme Filter"));
        }
        field(15; "Unit Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD(Programmes),
                                                           "Stage Code" = FIELD("Stage Filter"));
        }
        field(16; "Semester Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Semesters".Code;
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
                "Allow Adjustment" := TRUE;
                MODIFY;

                EXIT;

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
                            //GLPosting.RUN(GenJnl);
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
            OptionCaption = 'Full Time,School-Based,Weekend';
            OptionMembers = "Full Time","School-Based",Weekend;
        }
        field(20; Posted; Boolean)
        {
            Editable = true;
        }
        field(21; "Units Taken"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Programme = FIELD(Programmes),
                                                           Stage = field(Stage),
                                                           Reversed = FILTER(false),
                                                           Semester = FIELD(Semester)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(211; "Units theory Taken"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("ACA-Student Theory Units " WHERE("Student No." = FIELD("Student No."),
                                                           Programme = FIELD(Programmes),
                                                           Stage = field(Stage),
                                                           Reversed = FILTER(false),
                                                           Semester = FIELD(Semester)));
            Editable = false;

        }
        field(22; "User ID"; Code[50])
        {
        }
        field(23; "Total Paid"; Decimal)
        {
            CalcFormula = Sum("ACA-Receipt".Amount WHERE("Student No." = FIELD("Student No."),
                                                        "Reg ID" = FIELD("Reg. Transacton ID")));
            FieldClass = FlowField;
        }
        field(24; Status; Option)
        {
            CalcFormula = Lookup(Customer.Status WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
            OptionCaption = 'Registration,Current,Alluminae,Dropped Out,Deffered,Suspended,Expulsion,Discontinued,Deferred,Deceased,Transferred,Disciplinary,Unknown,Completed not graduated,Graduated no Certificates,Graduated with Certificate,Halt';
            OptionMembers = Registration,Current,Alluminae,"Dropped Out",Deffered,Suspended,Expulsion,Discontinued,Deferred,Deceased,Transferred,Disciplinary,Unknown,"Completed not graduated","Graduated no Certificates","Graduated with Certificate",Halt;
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

            trigger OnValidate()
            begin
                /*IF Reversed=TRUE THEN BEGIN
                  TESTFIELD(Remarks);
                  END;
                IF UserSetup.GET(USERID) THEN
                IF UserSetup."Can Stop Reg."=FALSE THEN ERROR('Please note that you do not have the rights to stop the registration!');
                "Allow Adjustment" := TRUE;
                MODIFY;


                StudentUnits.RESET;
                StudentUnits.SETRANGE(StudentUnits."Student No.","Student No.");
                StudentUnits.SETRANGE(StudentUnits."Reg. Transacton ID","Reg. Transacton ID");
                IF StudentUnits.FIND('-') THEN
                StudentUnits.DELETEALL;
                 */

            end;
        }
        field(29; "Total Units"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           "Reg. Transacton ID" = FIELD("Reg. Transacton ID")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Total Exempted"; Integer)
        {
            CalcFormula = Count("ACA-Std Units Exemptions" WHERE("Student No." = FIELD("Student No."),
                                                                  Programmes = FIELD(Programmes),
                                                                  Stage = FIELD(Stage),
                                                                  Semester = FIELD(Semester),
                                                                  Status = CONST(Approved)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(31; "OLD No."; Code[20])
        {
        }
        field(32; "Unbilled Charges"; Integer)
        {
            CalcFormula = Count("ACA-Std Charges" WHERE("Reg. Transacton ID" = FIELD("Reg. Transacton ID"),
                                                         "Student No." = FIELD("Student No."),
                                                         Recognized = CONST(false)));
            FieldClass = FlowField;
        }
        field(33; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(35; "Student Card"; Decimal)
        {
            CalcFormula = Sum("ACA-Std Charges".Amount WHERE("Student No." = FIELD("Student No."),
                                                              "Reg. Transacton ID" = FIELD("Reg. Transacton ID"),
                                                              Code = CONST('CARD'),
                                                              Recognized = CONST(true)));
            FieldClass = FlowField;
        }
        field(36; "Admission No."; Code[30])
        {
        }
        field(37; "Academic Year"; Code[20])
        {
            Description = 'Stores the reference to the academic year in the database';
            TableRelation = "ACA-Academic Year".Code;

            trigger OnValidate()
            var
                ACAAcademicYear: Record 61382;
                ACAProgramme: Record 61511;
            begin

                ACAProgramme.RESET;
                ACAProgramme.SETRANGE(Code, Rec.Programmes);
                IF ACAProgramme.FIND('-') THEN BEGIN
                    ACAAcademicYear.RESET;
                    ACAAcademicYear.SETRANGE(Code, Rec."Academic Year");
                    IF ACAAcademicYear.FIND('-') THEN BEGIN
                        IF ACAProgramme.Category = ACAProgramme.Category::Certificate THEN "Graduation Group" := ACAAcademicYear."Graduation Group (Certificate)";
                        IF ACAProgramme.Category = ACAProgramme.Category::Diploma THEN "Graduation Group" := ACAAcademicYear."Graduation Group (Diploma)";
                        IF ACAProgramme.Category = ACAProgramme.Category::Postgraduate THEN "Graduation Group" := ACAAcademicYear."Graduation Group (Masters)";
                        IF ACAProgramme.Category = ACAProgramme.Category::Undergraduate THEN "Graduation Group" := ACAAcademicYear."Graduation Group (Degree)";
                    END;
                END;
            end;
        }
        field(38; "Admission Type"; Option)
        {
            OptionMembers = "JAB/Direct";
        }
        field(39; Options; Code[20])
        {
            TableRelation = "ACA-Programme Options".Code WHERE("Programme Code" = FIELD(Programmes));

            trigger OnValidate()
            begin
                IF Rec.Options <> '' THEN BEGIN
                    Stages.RESET;
                    Stages.SETRANGE(Stages."Programme Code", Programmes);
                    Stages.SETRANGE(Stages.Code, Stage);
                    IF Stages.FIND('-') THEN
                        IF Stages."Allow Programme Options" = FALSE THEN ERROR('Please note that Programme Option is not enabled at ' + Stage);
                END;
            end;
        }
        field(47; "Registration Status"; Option)
        {
            OptionCaption = ' ,Specials,Academic Leave,WithHold,Deregister,Discontinue,Nullification';
            OptionMembers = " ",Specials,"Academic Leave",WithHold,Deregister,Discontinue,Nullification;
        }
        field(52; "General Remark"; Code[50])
        {

            trigger OnValidate()
            var
                ACAAcademicYear: Record 61382;
                ACAProgramme: Record 61511;
            begin
                ACAProgramme.RESET;
                ACAProgramme.SETRANGE(Code, Rec.Programmes);
                IF ACAProgramme.FIND('-') THEN BEGIN
                    ACAAcademicYear.RESET;
                    ACAAcademicYear.SETRANGE(Code, Rec."Academic Year");
                    IF ACAAcademicYear.FIND('-') THEN BEGIN
                        IF ACAProgramme.Category = ACAProgramme.Category::Certificate THEN "Graduation Group" := ACAAcademicYear."Graduation Group (Certificate)";
                        IF ACAProgramme.Category = ACAProgramme.Category::Diploma THEN "Graduation Group" := ACAAcademicYear."Graduation Group (Diploma)";
                        IF ACAProgramme.Category = ACAProgramme.Category::Postgraduate THEN "Graduation Group" := ACAAcademicYear."Graduation Group (Masters)";
                        IF ACAProgramme.Category = ACAProgramme.Category::Undergraduate THEN "Graduation Group" := ACAAcademicYear."Graduation Group (Degree)";
                    END;
                END;
            end;
        }
        field(53; "Allow Adjustment"; Boolean)
        {
        }
        field(54; Transfered; Boolean)
        {
            Editable = true;

            trigger OnValidate()
            begin
                "Allow Adjustment" := TRUE;
                Reversed := TRUE;
                MODIFY;

                StudentUnits.RESET;
                StudentUnits.SETRANGE(StudentUnits."Student No.", "Student No.");
                StudentUnits.SETRANGE(StudentUnits."Reg. Transacton ID", "Reg. Transacton ID");
                IF StudentUnits.FIND('-') THEN
                    StudentUnits.DELETEALL;
            end;
        }
        field(55; Registered; Boolean)
        {

            trigger OnValidate()
            begin

                IF Registered = FALSE THEN ERROR('De-Registration is not Allowed');
                Sems.RESET;
                IF Sems.GET(Semester) THEN
                    IF Sems."Current Semester" = FALSE THEN ERROR('Please note that you can only Register to the Current Semester');

                IF Posted = FALSE THEN ERROR('The Selected Registration has not been Posted');
                CALCFIELDS("Total Billed");
                IF "Total Billed" = 0 THEN ERROR('Please note that the Billed Amount can not be Zero');

                GenSetup.GET;
                IF GenSetup."Allowed Reg. Fees Perc." = 0 THEN
                    ERROR('Please not that you must specify the Required Fees Percentage in the General setup');

                Custs.RESET;
                Custs.SETRANGE(Custs."No.", "Student No.");
                IF Custs.FIND('-') THEN BEGIN
                    Custs.CALCFIELDS(Custs."Balance (LCY)");
                    IF ((("Total Billed" - Custs."Balance (LCY)") / "Total Billed") * 100) < GenSetup."Allowed Reg. Fees Perc." THEN BEGIN
                        ERROR('You cannot register a student with a fee balance.');
                    END;
                END;


                IF Registered = TRUE THEN BEGIN
                    CALCFIELDS("Units Taken");

                    IF Programmz.GET(Programmes) THEN BEGIN
                        IF Programmz."Min No. of Courses" > 0 THEN BEGIN
                            IF "Units Taken" < Programmz."Min No. of Courses" THEN
                                ERROR('Student must register for a minimum of %1 course.', Programmz."Min No. of Courses")
                        END;

                        /*
                        IF Programmes."Max No. of Courses" > 0 THEN BEGIN
                        IF "Units Taken" > Programmes."Max No. of Courses" THEN
                        ERROR('Student must register for a maximum of %1 course.',Programmes."Max No. of Courses")
                        END;
                        */

                    END;
                END;


                "Date Registered" := TODAY;
                "Allow Adjustment" := TRUE;
                MODIFY;

            end;
        }
        field(56; "Re-sits"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           "Reg. Transacton ID" = FIELD("Reg. Transacton ID"),
                                                           Taken = CONST(true),
                                                           "Repeat Unit" = CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(57; "Cummulative Score"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Results".Contribution WHERE("Student No." = FIELD("Student No."),
                                                                     Programmes = FIELD(Programmes),
                                                                     Stage = FIELD("Cummulative Year Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(58; "Cummulative Units Taken"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Programme = FIELD(Programmes),
                                                           Stage = FIELD("Cummulative Year Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(59; "Options Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme Options".Code WHERE("Programme Code" = FIELD("Programme Filter"));
        }
        field(60; "System Created"; Boolean)
        {
        }
        field(61; Gender; Option)
        {
            CalcFormula = Lookup(Customer.Gender WHERE("No." = FIELD("Student No.")));
            Description = 'to be used in summary by gender report';
            FieldClass = FlowField;
            OptionMembers = " ",Male,Female;
        }
        field(62; Faculty; Code[20])
        {
            CalcFormula = Lookup("ACA-Programme"."School Code" WHERE(Code = FIELD(Programmes)));
            Description = 'to be used in exam labels';
            FieldClass = FlowField;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('FACULTY'));
        }
        field(63; Session; Code[20])
        {
            Editable = false;
            TableRelation = "ACA-Intake".Code;

            trigger OnValidate()
            begin
                /*
                StudentCharges.RESET;
                StudentCharges.SETRANGE(StudentCharges."Student No.","Student No.");
                StudentCharges.SETRANGE(StudentCharges."Reg. Transacton ID","Reg. Transacton ID");
                StudentCharges.SETRANGE(StudentCharges.Recognized,FALSE);
                IF StudentCharges.FIND('-') THEN
                StudentCharges.DELETEALL;


                StageCharges.RESET;
                StageCharges.SETRANGE(StageCharges."Programme Code",Programme);
                StageCharges.SETRANGE(StageCharges."Stage Code",Stage);
                //StageCharges.SETRANGE(StageCharges."Student Type",StageCharges."Student Type"::" ");
                StageCharges.SETRANGE(StageCharges."Settlement Type","Settlement Type");
                IF StageCharges.FIND('-') THEN BEGIN
                REPEAT
                //IF StageCharges.Semester = '' THEN BEGIN
                StudentCharges.INIT;
                StudentCharges.Programme:=Programme;
                StudentCharges.Stage:=Stage;
                StudentCharges.Semester:=Semester;
                StudentCharges."Student No.":="Student No.";
                StudentCharges."Reg. Transacton ID":="Reg. Transacton ID";
                StudentCharges."Transaction Type":=StudentCharges."Transaction Type"::"Stage Fees";
                StudentCharges.Date:="Registration Date";
                StudentCharges.Code:=StageCharges.Code;
                StudentCharges.Description:=StageCharges.Description;
                StudentCharges.Amount:=StageCharges.Amount;
                StudentCharges."Recovered First":=StageCharges."Recovered First";
                StudentCharges."Recovery Priority":=StageCharges."Recovery Priority";
                StudentCharges.Distribution:=StageCharges."Distribution (%)";
                StudentCharges."Distribution Account":=StageCharges."Distribution Account";
                StudentCharges."Transacton ID":='';
                StudentCharges.Charge:=TRUE;
                StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                StudentCharges.INSERT;
                UNTIL StageCharges.NEXT=0;
                END;
                */

            end;
        }
        field(64; "Cummulative Year Filter"; Code[20])
        {
            Caption = 'Cummulative Year Filter';
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD("Programme Filter"));
        }
        field(65; "Result Status"; Option)
        {
            OptionCaption = ',Pass,Fail';
            OptionMembers = ,Pass,Fail;
        }
        field(66; "Entry No."; Integer)
        {
        }
        field(67; "Audit Issue"; Boolean)
        {
        }
        field(68; "Date Registered"; Date)
        {
        }
        field(69; "Programme Exam Category"; Code[20])
        {
            CalcFormula = Lookup("ACA-Programme"."Exam Category" WHERE(Code = FIELD(Programmes)));
            FieldClass = FlowField;
        }
        field(70; "Not Billed"; Boolean)
        {
        }
        field(71; "Cust Billed"; Boolean)
        {
            FieldClass = FlowFilter;
        }
        field(72; Marks; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Results".Contribution WHERE(Programmes = FIELD(Programmes),
                                                                     Stage = FIELD(Stage),
                                                                     Semester = FIELD(Semester),
                                                                     "Student No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(73; "Exams Done"; Integer)
        {
            CalcFormula = Count("ACA-Exams" WHERE("Programme Code" = FIELD(Programmes),
                                                 "Stage Code" = FIELD(Stage),
                                                 Code = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(74; "Sem Reg Counter"; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE("Student No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(75; "Check Reg"; Boolean)
        {
        }
        field(76; "Helb Beneficiary"; Integer)
        {
            CalcFormula = Count("Cust. Ledger Entry" WHERE("Customer No." = FIELD("Student No."),
                                                            "Document No." = FILTER('*HELB*')));
            FieldClass = FlowField;
        }
#pragma warning disable AL0603
        field(77; Blocked; Option)
#pragma warning restore AL0603
        {
            CalcFormula = Lookup(Customer.Blocked WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
            OptionCaption = ',Ship,Invoice,All';
            OptionMembers = ,Ship,Invoice,All;
        }
        field(78; "Prog Exist"; Integer)
        {
            CalcFormula = Count("ACA-Programme" WHERE(Code = FIELD(Programmes)));
            FieldClass = FlowField;
        }
        field(79; "Fee Exist"; Integer)
        {
            CalcFormula = Count("ACA-Fee By Stage" WHERE("Programme Code" = FIELD(Programmes),
                                                          "Settlemet Type" = FIELD("Settlement Type"),
                                                          Semester = FIELD(Semester),
                                                          "Stage Code" = FIELD(Stage)));
            FieldClass = FlowField;
        }
        field(80; "Intake Code"; Code[20])
        {
            TableRelation = "ACA-Intake".Code;
        }
        field(81; "Sem Repeated"; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE("Student No." = FIELD("Student No."),
                                                                 Semester = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(82; "Student Status"; Option)
        {
            CalcFormula = Lookup(Customer.Status WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
            OptionCaption = 'Registration,Current,Alluminae,Dropped Out,Differed,Suspended,Expulsion,Discontinued,Deferred,Deceased,Transferred,Disciplinary,Graduated,Completed,Alumnae,Demoted, Other';
            OptionMembers = Registration,Current,Alluminae,"Dropped Out",Differed,Suspended,Expulsion,Discontinued,Deferred,Deceased,Transferred,Disciplinary,Graduated,Completed,Alumnae,Demoted,Other;
        }
        field(83; "Account Count"; Integer)
        {
            CalcFormula = Count(Customer WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(84; "Exam Status"; Code[50])
        {
            TableRelation = "ACA-Results Status".Code;
        }
        field(85; "Units Passed"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Semester = FIELD(Semester),
                                                           Programme = FIELD(Programmes),
                                                           Stage = FIELD(Stage),
                                                           "Result Status" = FILTER('PASS')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(86; "Units Failed"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Semester = FIELD(Semester),
                                                           Programme = FIELD(Programmes),
                                                           Stage = FIELD(Stage),
                                                           "Result Status" = CONST('FAIL')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(87; "Units Repeat"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Semester = FIELD(Semester),
                                                           Programme = FIELD(Programmes),
                                                           Stage = FIELD(Stage),
                                                           "Result Status" = FILTER('REPEAT')));
            FieldClass = FlowField;
        }
        field(89; "Exam Grade"; Code[50])
        {
        }
        field(90; "Class Stream"; Code[20])
        {

        }
        field(50000; "Cum Average"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Final Score" WHERE("Student No." = FIELD("Student No."),
                                                                       Semester = FIELD("Semester Filter"),
                                                                       Programme = FIELD("Programme Filter"),
                                                                       Stage = FIELD("Stage Filter"),
                                                                       Reversed = CONST(false),
                                                                       "Attachment Unit" = CONST(false),
                                                                       "Ignore in Cumm  Average" = CONST(false),
                                                                       "Supp Taken" = CONST(false)));
            FieldClass = FlowField;
        }
        field(50001; "Cum Units Done"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Semester = FIELD("Semester Filter"),
                                                           Programme = FIELD(Programmes),
                                                           Stage = FIELD("Stage Filter"),
                                                           Reversed = CONST(false),
                                                           "Attachment Unit" = CONST(false),
                                                           "Ignore in Cumm  Average" = CONST(false),
                                                           "Supp Taken" = CONST(false)));
            FieldClass = FlowField;
        }
        field(50002; "Cum Units Passed"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Programme = FIELD(Programmes),
                                                           Stage = FIELD("Stage Filter"),
                                                           "Result Status" = FILTER('PASS'),
                                                           Semester = FIELD("Semester Filter"),
                                                           Reversed = CONST(false),
                                                           "Supp Taken" = CONST(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; "Cum Units Failed"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Programme = FIELD(Programmes),
                                                           Stage = FIELD("Stage Filter"),
                                                           Failed = CONST(true),
                                                           Semester = FIELD(Semester),
                                                           Reversed = CONST(false),
                                                           "Supp Taken" = CONST(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "Programme Average"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Final Score" WHERE("Student No." = FIELD("Student No."),
                                                                       Programme = FIELD(Programmes),
                                                                       "Attachment Unit" = CONST(false),
                                                                       "Ignore in Cumm  Average" = CONST(false),
                                                                       "Supp Taken" = CONST(false)));
            FieldClass = FlowField;
        }
        field(50005; "Programme Units Done"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Programme = FIELD("Programme Filter"),
                                                           "Attachment Unit" = CONST(false),
                                                           "Reg Reversed" = CONST(false),
                                                           "Ignore in Final Average" = CONST(false),
                                                           "Supp Taken" = CONST(false)));
            FieldClass = FlowField;
        }
        field(50006; "Trans Count"; Integer)
        {
            CalcFormula = Count("Cust. Ledger Entry" WHERE("Customer No." = FIELD("Student No."),
                                                            "Posting Date" = FILTER('09/01/12..11/27/12')));
            FieldClass = FlowField;
        }
        field(50007; "Current Sem"; Boolean)
        {
            CalcFormula = Lookup("ACA-Semesters"."Current Semester" WHERE(Code = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(50008; "Registered Reason"; Text[100])
        {
        }
        field(50009; "Registered By"; Code[20])
        {
        }
        field(50010; "Study Year"; Code[20])
        {
        }
        field(50011; "Cust Exist"; Integer)
        {
            CalcFormula = Count(Customer WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(50012; "Cumm Score"; Decimal)
        {
        }
        field(50013; "Marks Status"; Option)
        {
            OptionCaption = ' ,R,RP1,RD,RPC,RPD,RPE,RA,RAS,M,TF,TFS,R2,RP12,RD2,RPC2,RPD2,RPE2,RA2,RAS2,M2,TF2,TFS2,R3,RP13,RD3,RPC3,RPD3,RPE3,RA3,RAS3,M3,TF3,TFS3,R4,RP14,RD4,RPC4,RPD4,RPE4,RA4,RAS4,M4,TF4,TFS4,R5,RP15,RD5,RPC5,RPD5,RPE5,RA5,RAS5,M5,TF5,TFS5';
            OptionMembers = " ",R,RP1,RD,RPC,RPD,RPE,RA,RAS,M,TF,TFS,R2,RP12,RD2,RPC2,RPD2,RPE2,RA2,RAS2,M2,TF2,TFS2,R3,RP13,RD3,RPC3,RPD3,RPE3,RA3,RAS3,M3,TF3,TFS3,R4,RP14,RD4,RPC4,RPD4,RPE4,RA4,RAS4,M4,TF4,TFS4,R5,RP15,RD5,RPC5,RPD5,RPE5,RA5,RAS5,M5,TF5,TFS5;
        }
        field(50014; "Units Status Count"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Programme = FIELD(Programmes),
                                                           "Result Status" = FILTER('FAIL')));
            FieldClass = FlowField;
        }
        field(50015; "Sem Pass Count"; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE("Student No." = FIELD("Student No."),
                                                                 Programmes = FIELD(Programmes),
                                                                 "Exam Status" = FILTER('PASS'),
                                                                 Stage = FIELD("Stage Filter"),
                                                                 Semester = FIELD("Semester Filter")));
            FieldClass = FlowField;
        }
        field(50016; "Cum Units Count"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Semester = FIELD("Semester Filter"),
                                                           Programme = FIELD("Programme Filter"),
                                                           Stage = FIELD("Stage Filter"),
                                                           Reversed = CONST(false)));
            FieldClass = FlowField;
        }
        field(50036; "Total CF Count"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."CF Score" WHERE(Programme = FIELD(Programmes),
                                                                    "Student No." = FIELD("Student No."),
                                                                    Stage = FIELD("Stage Filter"),
                                                                    Semester = FIELD("Semester Filter"),
                                                                    "Supp Taken" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(50051; "Current Cumm Score"; Decimal)
        {
        }
        field(50052; "CF Count"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."No. Of Units" WHERE(Programme = FIELD(Programmes),
                                                                        "Student No." = FIELD("Student No."),
                                                                        Stage = FIELD("Stage Filter"),
                                                                        Semester = FIELD("Semester Filter"),
                                                                        "Supp Taken" = FILTER(false),
                                                                        "Attachment Unit" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(50053; "CF Total Score"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."CF Score" WHERE(Programme = FIELD(Programmes),
                                                                    "Student No." = FIELD("Student No."),
                                                                    Stage = FIELD("Stage Filter"),
                                                                    Semester = FIELD("Semester Filter"),
                                                                    "Supp Taken" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(50054; "Current Cumm Grade"; Code[20])
        {
        }
        field(50055; "Cumm Grade"; Code[20])
        {
        }
        field(50056; Names; Text[100])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(50057; "Programme Campus"; Code[20])
        {
            CalcFormula = Lookup("ACA-Programme Stages"."Campus Code" WHERE("Programme Code" = FIELD(Programmes),
                                                                             Code = FIELD(Stage)));
            FieldClass = FlowField;
        }
        field(50059; "Manual Exam Status"; Boolean)
        {
            CalcFormula = Lookup("ACA-Results Status"."Manual Status Processing" WHERE(Code = FIELD("Exam Status")));
            FieldClass = FlowField;
        }
        field(50060; Award; Text[200])
        {
        }
        field(50061; "Campus Filter"; Code[20])
        {
            CalcFormula = Lookup(Customer."Global Dimension 1 Code" WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50062; "Registered Units"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Semester = FIELD("Semester Filter"),
                                                           Stage = FIELD("Stage Filter"),
                                                           "Total Score" = FILTER(> 0)));
            FieldClass = FlowField;
        }
        field(60000; "Average Semester GPA"; Decimal)
        {
            CalcFormula = Average("ACA-Student Units"."Final Score" WHERE(Grade = FILTER(<> ''),
                                                                           "Student No." = FIELD("Student No."),
                                                                           Semester = FIELD(Semester),
                                                                           "Academic Year" = FIELD("Academic Year")));
            DecimalPlaces = 1 : 1;
            FieldClass = FlowField;
        }
        field(60001; "Average Cummulative GPA"; Decimal)
        {
            CalcFormula = Average("ACA-Student Units"."Final Score" WHERE("Student No." = FIELD("Student No."),
                                                                           Grade = FILTER(<> '')));
            DecimalPlaces = 1 : 1;
            FieldClass = FlowField;
        }
        field(60002; "Description of Intake/Semester"; Code[100])
        {
            CalcFormula = Lookup("ACA-Academic Year Schedule"."Description of Intake/Semester" WHERE("Academic Year" = FIELD("Academic Year"),
                                                                                                      Semester = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(60003; "Repeat"; Boolean)
        {
            CalcFormula = Exist("ACA-Student Units" WHERE(Failed = CONST(true),
                                                           "Reg. Transacton ID" = FIELD("Reg. Transacton ID"),
                                                           "Student No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(60004; "Semester Points"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Unit Points" WHERE(Grade = FILTER(<> ''),
                                                                       Grade = FILTER('A|A+|B|B+|C|C+|D|D+|E'),
                                                                       "Student No." = FIELD("Student No."),
                                                                       Semester = FIELD(Semester),
                                                                       "Academic Year" = FIELD("Academic Year")));
            FieldClass = FlowField;
        }
        field(60005; "Semester Hours"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Credit Hours" WHERE(Grade = FILTER(<> ''),
                                                                        Grade = FILTER('A|A+|B|B+|C|C+|D|D+|E|!'),
                                                                        "Student No." = FIELD("Student No."),
                                                                        Semester = FIELD(Semester),
                                                                        "Academic Year" = FIELD("Academic Year")));
            FieldClass = FlowField;
        }
        field(60006; "Cummulative Units"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Programme = FIELD(Programmes),
                                                           Unit = FILTER(<> '')));
            FieldClass = FlowField;
        }
        field(60007; "Cummulative Marks"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Total Marks" WHERE("Student No." = FIELD("Student No."),
                                                                       Programme = FIELD(Programmes),
                                                                       Unit = FILTER(<> '')));
            FieldClass = FlowField;
        }
        field(60008; "Cumm GPA"; Decimal)
        {
        }
        field(60009; "Sem GPA"; Decimal)
        {
        }
        field(60010; "Allow View of Results"; Boolean)
        {
            CalcFormula = Lookup("ACA-Academic Year Schedule"."Allow View of Results" WHERE("Academic Year" = FIELD("Academic Year"),
                                                                                             Semester = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(60011; "Semester Average"; Decimal)
        {
        }
        field(60012; "Cummulative Average"; Decimal)
        {
        }
        field(60013; "Semester Grade"; Code[20])
        {
        }
        field(60014; "Cummulative Grade"; Code[20])
        {
        }
        field(60015; "Campus Code"; Code[20])
        {
            CalcFormula = Lookup(Customer."Global Dimension 1 Code" WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(60016; "Student Name"; Text[250])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(60017; "County Code"; Text[30])
        {
            CalcFormula = Lookup(Customer.County WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
            TableRelation = "ACA-Academics Central Setups"."Title Code" WHERE(Category = FILTER(Counties));
        }
        field(60018; "Cumm Status"; Code[20])
        {
        }
        field(60019; "Sem FAIL Count"; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE("Student No." = FIELD("Student No."),
                                                                 Programmes = FIELD(Programmes),
                                                                 "Exam Status" = FILTER('<>PASS'),
                                                                 Stage = FIELD("Stage Filter"),
                                                                 Semester = FIELD("Semester Filter"),
                                                                 Reversed = CONST(false)));
            FieldClass = FlowField;
        }
        field(60020; "School Filter"; Code[20])
        {
            CalcFormula = Lookup("ACA-Programme"."School Code" WHERE(Code = FIELD(Programmes)));
            FieldClass = FlowField;
        }
        field(60021; "Intake Current Stage"; Code[20])
        {
            CalcFormula = Lookup("ACA-Intake".lost WHERE(Code = FIELD(Session)));
            FieldClass = FlowField;
        }
        field(60022; Balance; Decimal)
        {
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Customer No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(60023; "First Time Student"; Boolean)
        {
        }
        field(60024; "Fee Structure Exists"; Integer)
        {
            CalcFormula = Count("ACA-Fee By Stage" WHERE("Programme Code" = FIELD(Programmes),
                                                          "Stage Code" = FIELD(Stage),
                                                          "Settlemet Type" = FIELD("Settlement Type"),
                                                          Semester = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(60025; "Reg Count"; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE("Student No." = FIELD("Student No."),
                                                                 Reversed = CONST(false)));
            FieldClass = FlowField;
        }
        field(60026; "Old Prog Code"; Code[20])
        {
            CalcFormula = Lookup("ACA-Programme"."Old Code" WHERE(Code = FIELD(Programmes)));
            FieldClass = FlowField;
        }
        field(60027; "Class Code"; Code[30])
        {
        }
        field(60028; "Mass Stop"; Boolean)
        {
        }
        field(60029; "Mass Stopped By"; Code[20])
        {
        }
        field(60030; "Mass Stooped Date"; Date)
        {
        }
        field(60031; "Room No"; Code[20])
        {
            CalcFormula = Lookup("ACA-Students Hostel Rooms"."Space No" WHERE(Student = FIELD("Student No."),
                                                                               Cleared = CONST(false)));
            FieldClass = FlowField;
        }
        field(60032; "Hostel No"; Code[20])
        {
            CalcFormula = Lookup("ACA-Students Hostel Rooms"."Hostel No" WHERE(Student = FIELD("Student No."),
                                                                                Cleared = CONST(false)));
            FieldClass = FlowField;
        }
        field(60033; "ID Number"; Code[20])
        {
            CalcFormula = Lookup(Customer."ID No" WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(60034; "Total Billed Accomodation"; Decimal)
        {
            CalcFormula = Sum("ACA-Std Charges".Amount WHERE("Reg. Transacton ID" = FIELD("Reg. Transacton ID"),
                                                              "Student No." = FIELD("Student No."),
                                                              accommodation = CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60035; "Programme Category"; Option)
        {
            CalcFormula = Lookup("ACA-Programme".Category WHERE(Code = FIELD(Programmes)));
            FieldClass = FlowField;
            OptionCaption = ',Certificate ,Diploma,Undergraduate,Postgraduate,Professional,Course List';
            OptionMembers = ,"Certificate ",Diploma,Undergraduate,Postgraduate,Professional,"Course List";
        }
        field(60036; "Year Of Study"; Integer)
        {
        }
        field(60037; "Total Yearly Marks"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Total Marks" WHERE("Student No." = FIELD("Student No."),
                                                                       Programme = FIELD(Programmes),
                                                                       "Year Of Study" = FIELD("Year Of Study"),
                                                                       Unit = FILTER(<> '')));
            FieldClass = FlowField;
        }
        field(60038; "Yearly Average"; Decimal)
        {
        }
        field(60039; "Yearly Grade"; Code[2])
        {
        }
        field(60040; "Yearly Failed Units"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Programme = FIELD(Programmes),
                                                           "Unit Year of Study" = FIELD("Year Of Study"),
                                                           Failed = FILTER(true),
                                                           "Reg. Reversed" = FILTER(false),
                                                           "Academic Year" = FIELD("Academic Year")));
            FieldClass = FlowField;
        }
        field(60041; "Yearly Total Units Taken"; Integer)
        {
            CalcFormula = Sum("ACA-Student Units".Units WHERE("Student No." = FIELD("Student No."),
                                                               Programme = FIELD(Programmes),
                                                               Unit = FILTER(<> ''),
                                                               "Year Of Study" = FIELD("Year Of Study"),
                                                               "Reg. Reversed" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60042; "Yearly Remarks"; Code[250])
        {
        }
        field(60043; "Yearly Passed Units"; Integer)
        {
            CalcFormula = Sum("ACA-Student Units".Units WHERE("Student No." = FIELD("Student No."),
                                                               Programme = FIELD(Programmes),
                                                               "Year Of Study" = FIELD("Year Of Study"),
                                                               Grade = FILTER('A|B|C|D'),
                                                               Unit = FILTER(<> ''),
                                                               "Total Marks" = FILTER(> 0),
                                                               "Reg. Reversed" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60044; "Total Semester Marks"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Total Marks" WHERE("Student No." = FIELD("Student No."),
                                                                       Programme = FIELD(Programmes),
                                                                       Semester = FIELD(Semester),
                                                                       Unit = FILTER(<> '')));
            FieldClass = FlowField;
        }
        field(60047; "Semester Failed Units"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Programme = FIELD(Programmes),
                                                           Semester = FIELD(Semester),
                                                           Grade = FILTER('E'),
                                                           "Reg. Reversed" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60048; "Semester Total Units Taken"; Integer)
        {
            CalcFormula = Sum("ACA-Student Units".Units WHERE("Student No." = FIELD("Student No."),
                                                               Programme = FIELD(Programmes),
                                                               Semester = FIELD(Semester),
                                                               Unit = FILTER(<> ''),
                                                               "Reg. Reversed" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60049; "Semester Remarks"; Code[250])
        {
        }
        field(60050; "Semester Passed Units"; Integer)
        {
            CalcFormula = Sum("ACA-Student Units".Units WHERE("Student No." = FIELD("Student No."),
                                                               Programme = FIELD(Programmes),
                                                               Semester = FIELD(Semester),
                                                               Grade = FILTER('A|B|C|D'),
                                                               Unit = FILTER(<> ''),
                                                               "Total Marks" = FILTER(> 0),
                                                               "Reg. Reversed" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60051; "Failed Unit"; Text[250])
        {
        }
        field(60053; "Yearly Weighted Total"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Weighted Units" WHERE("Student No." = FIELD("Student No."),
                                                                          Programme = FIELD(Programmes),
                                                                          "Year Of Study" = FIELD("Year Of Study"),
                                                                          "Reg. Reversed" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60054; "Semester Weighted Total"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Weighted Units" WHERE("Student No." = FIELD("Student No."),
                                                                          Programme = FIELD(Programmes),
                                                                          Semester = FIELD(Semester),
                                                                          "Reg. Reversed" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60055; "Yearly CF% Failed"; Decimal)
        {
        }
        field(60056; "Yearly Curr. Average"; Decimal)
        {
        }
        field(60057; "Semester Curr. Average"; Decimal)
        {
        }
        field(60058; "Semester CF% Failed"; Decimal)
        {
        }
        field(60059; "Transcript Remarks"; Text[250])
        {
        }
        field(60060; "Yearly Failed Courses"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Programme = FIELD(Programmes),
                                                           "Year Of Study" = FIELD("Year Of Study"),
                                                           Failed = FILTER(true),
                                                           "Reg. Reversed" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60061; "Year of Admission"; Integer)
        {
        }
        field(60062; "Special Exam Exists"; Option)
        {
            CalcFormula = Lookup("ACA-Student Units"."Special Exam" WHERE("Student No." = FIELD("Student No."),
                                                                           "Year Of Study" = FIELD("Year Of Study")));
            FieldClass = FlowField;
            OptionCaption = ' ,Special,Suspension';
            OptionMembers = " ",Special,Suspension;
        }
        field(60063; "Supp. Year Of Study"; Integer)
        {
        }
        field(60064; "Supp. Total Yearly Marks"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Supp. Total Marks" WHERE("Student No." = FIELD("Student No."),
                                                                             Programme = FIELD(Programmes),
                                                                             "Year Of Study" = FIELD("Year Of Study"),
                                                                             Unit = FILTER(<> '')));
            FieldClass = FlowField;
        }
        field(60065; "Supp. Yearly Average"; Decimal)
        {
        }
        field(60066; "Supp. Yearly Grade"; Code[2])
        {
        }
        field(60067; "Supp. Yearly Failed Units"; Integer)
        {
            CalcFormula = Sum("ACA-Student Units".Units WHERE("Student No." = FIELD("Student No."),
                                                               Programme = FIELD(Programmes),
                                                               "Year Of Study" = FIELD("Year Of Study"),
                                                               "Supp. Failed" = FILTER(true),
                                                               "Reg. Reversed" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60068; "Supp. Yearly Total Units Taken"; Integer)
        {
            CalcFormula = Sum("ACA-Student Units".Units WHERE("Student No." = FIELD("Student No."),
                                                               Programme = FIELD(Programmes),
                                                               Unit = FILTER(<> ''),
                                                               "Year Of Study" = FIELD("Year Of Study"),
                                                               "Reg. Reversed" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60069; "Supp. Yearly Remarks"; Code[50])
        {
        }
        field(60070; "Supp. Yearly Passed Units"; Integer)
        {
            CalcFormula = Sum("ACA-Student Units".Units WHERE("Student No." = FIELD("Student No."),
                                                               Programme = FIELD(Programmes),
                                                               "Year Of Study" = FIELD("Year Of Study"),
                                                               "Supp. Failed" = FILTER(false),
                                                               Unit = FILTER(<> ''),
                                                               "Total Marks" = FILTER(> 0),
                                                               "Reg. Reversed" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60071; "Supp. Total Semester Marks"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Total Marks" WHERE("Student No." = FIELD("Student No."),
                                                                       Programme = FIELD(Programmes),
                                                                       Semester = FIELD(Semester),
                                                                       Unit = FILTER(<> '')));
            FieldClass = FlowField;
        }
        field(60072; "Supp. Semester Failed Units"; Integer)
        {
            CalcFormula = Sum("ACA-Student Units".Units WHERE("Student No." = FIELD("Student No."),
                                                               Programme = FIELD(Programmes),
                                                               Semester = FIELD(Semester),
                                                               "Supp. Failed" = FILTER(true),
                                                               Unit = FILTER(<> ''),
                                                               "Reg. Reversed" = FILTER(true)));
            FieldClass = FlowField;
        }
        field(60073; "Supp. Semester Tot Units Taken"; Integer)
        {
            CalcFormula = Sum("ACA-Student Units".Units WHERE("Student No." = FIELD("Student No."),
                                                               Programme = FIELD(Programmes),
                                                               Semester = FIELD(Semester),
                                                               Unit = FILTER(<> ''),
                                                               "Reg. Reversed" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60074; "Supp. Semester Remarks"; Code[50])
        {
        }
        field(60075; "Supp. Semester Passed Units"; Integer)
        {
            CalcFormula = Sum("ACA-Student Units".Units WHERE("Student No." = FIELD("Student No."),
                                                               Programme = FIELD(Programmes),
                                                               Semester = FIELD(Semester),
                                                               Failed = FILTER(false),
                                                               Unit = FILTER(<> ''),
                                                               "Total Marks" = FILTER(> 0),
                                                               "Reg. Reversed" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60076; "Supp. Failed Unit"; Text[50])
        {
        }
        field(60077; "Supp. Yearly Weighted Total"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Supp. Weighted Units" WHERE("Student No." = FIELD("Student No."),
                                                                                Programme = FIELD(Programmes),
                                                                                "Year Of Study" = FIELD("Year Of Study"),
                                                                                "Reg. Reversed" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60078; "Supp. Semester Weighted Total"; Decimal)
        {
        }
        field(60079; "Supp. Yearly CF% Failed"; Decimal)
        {
        }
        field(60080; "Supp. Yearly Curr. Average"; Decimal)
        {
        }
        field(60081; "Supp. Semester Curr. Average"; Decimal)
        {
        }
        field(60082; "Supp. Semester CF% Failed"; Decimal)
        {
        }
        field(60083; "Supp. Transcript Remarks"; Text[150])
        {
        }
        field(60084; "Supp. Yearly Failed Courses"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Programme = FIELD(Programmes),
                                                           "Year Of Study" = FIELD("Year Of Study"),
                                                           "Supp. Grade" = FILTER('E'),
                                                           "Reg. Reversed" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60085; "Supp. Year of Admission"; Integer)
        {
        }
        field(60086; "Supp. Registered"; Boolean)
        {
            CalcFormula = Exist("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           "Year Of Study" = FIELD("Year Of Study"),
                                                           "No of Supplementaries" = FILTER(> 0),
                                                           "Reg Reversed" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60100; "Gen. Year Of Study"; Integer)
        {
        }
        field(60101; "Gen. Total Yearly Marks"; Decimal)
        {
        }
        field(60102; "Gen. Yearly Average"; Decimal)
        {
        }
        field(60103; "Gen. Yearly Grade"; Code[2])
        {
        }
        field(60104; "Gen. Yearly Failed Units"; Integer)
        {
        }
        field(60105; "Gen. Yearly Total Units Taken"; Integer)
        {
        }
        field(60106; "Gen. Yearly Remarks"; Code[50])
        {
        }
        field(60107; "Gen. Yearly Passed Units"; Integer)
        {
        }
        field(60108; "Gen. Total Semester Marks"; Decimal)
        {
        }
        field(60109; "Gen. Semester Failed Units"; Integer)
        {
        }
        field(60110; "Gen. Semester Tot Units Taken"; Integer)
        {
        }
        field(60111; "Gen. Semester Remarks"; Code[50])
        {
        }
        field(60112; "Gen. Semester Passed Units"; Integer)
        {
        }
        field(60113; "Gen. Failed Unit"; Text[50])
        {
        }
        field(60114; "Gen. Yearly Weighted Total"; Decimal)
        {
        }
        field(60115; "Gen. Semester Weighted Total"; Decimal)
        {
        }
        field(60116; "Gen. Yearly CF% Failed"; Decimal)
        {
        }
        field(60117; "Gen. Yearly Curr. Average"; Decimal)
        {
        }
        field(60118; "Gen. Semester Curr. Average"; Decimal)
        {
        }
        field(60119; "Gen. Semester CF% Failed"; Decimal)
        {
        }
        field(60120; "Gen. Transcript Remarks"; Text[50])
        {
        }
        field(60121; "Gen. Yearly Failed Courses"; Integer)
        {
        }
        field(60122; "Gen. Year of Admission"; Integer)
        {
        }
        field(60123; "Supp. Cummulative Units"; Integer)
        {
            CalcFormula = Sum("ACA-Student Units".Units WHERE("Student No." = FIELD("Student No."),
                                                               Programme = FIELD(Programmes),
                                                               Unit = FILTER(<> ''),
                                                               "Reg Reversed" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60124; "Supp. Cummulative Marks"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Supp. Total Score" WHERE("Student No." = FIELD("Student No."),
                                                                             Programme = FIELD(Programmes),
                                                                             Unit = FILTER(<> ''),
                                                                             "Supp. Grade" = FILTER(<> '')));
            FieldClass = FlowField;
        }
        field(60125; "Supp. Cummulative Average"; Decimal)
        {
        }
        field(60126; "Supp. Cummulative Grade"; Code[20])
        {
        }
        field(60127; "Supp. Total Number of courses"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Programme = FIELD(Programmes),
                                                           Unit = FILTER(<> ''),
                                                           "Reg Reversed" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60128; "Supplementary Exists"; Boolean)
        {
            CalcFormula = Exist("Aca-Special Exams Details" WHERE("Student No." = FIELD("Student No."),
                                                                   "Academic Year" = FIELD("Academic Year")));
            FieldClass = FlowField;
        }
        field(60129; "Supp. Yearly Total Courses"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Programme = FIELD(Programmes),
                                                           Unit = FILTER(<> ''),
                                                           "Reg Reversed" = FILTER(false),
                                                           "Year Of Study" = FIELD("Year Of Study")));
            FieldClass = FlowField;
        }
        field(60130; "Maximum Year of Study"; Integer)
        {
            CalcFormula = Max("ACA-Course Registration"."Year Of Study" WHERE("Student No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(60131; "Graduation Group"; Code[20])
        {
        }
        field(60132; "Yearly Graduating Units Count"; Integer)
        {
            CalcFormula = Sum("ACA-Student Units".Units WHERE("Student No." = FIELD("Student No."),
                                                               Programme = FIELD(Programmes),
                                                               Unit = FILTER(<> ''),
                                                               "Reg Reversed" = FILTER(false),
                                                               "Year Of Study" = FIELD("Year Of Study"),
                                                               "Include in Graduation" = FILTER(true)));
            FieldClass = FlowField;
        }
        field(60133; "Yearly Graduating Core Units"; Integer)
        {
            CalcFormula = Sum("ACA-Student Units".Units WHERE("Student No." = FIELD("Student No."),
                                                               Programme = FIELD(Programmes),
                                                               Unit = FILTER(<> ''),
                                                               "Reg Reversed" = FILTER(true),
                                                               "Year Of Study" = FIELD("Year Of Study"),
                                                               "Include in Graduation" = FILTER(true),
                                                               "Unit Type (Flow)" = FILTER('Core|Required')));
            FieldClass = FlowField;
        }
        field(60134; "Yearly Graduating Electives"; Integer)
        {
            CalcFormula = Sum("ACA-Student Units".Units WHERE("Student No." = FIELD("Student No."),
                                                               Programme = FIELD(Programmes),
                                                               Unit = FILTER(<> ''),
                                                               "Reg Reversed" = FILTER(false),
                                                               "Year Of Study" = FIELD("Year Of Study"),
                                                               "Include in Graduation" = FILTER(true),
                                                               "Unit Type (Flow)" = FILTER(Elective)));
            FieldClass = FlowField;
        }
        field(60135; "Yearly Grad. Req. Units"; Integer)
        {
            CalcFormula = Lookup("ACA-Defined Units per YoS"."Number of Units" WHERE(Programmes = FIELD(Programmes),
                                                                                      "Year of Study" = FIELD("Year Of Study"),
                                                                                      Options = FIELD(Options)));
            FieldClass = FlowField;
        }
        field(60136; "Final  Graduating Units Count"; Integer)
        {
            CalcFormula = Sum("ACA-Student Units".Units WHERE("Student No." = FIELD("Student No."),
                                                               Programme = FIELD(Programmes),
                                                               Unit = FILTER(<> ''),
                                                               "Reg Reversed" = FILTER(false),
                                                               "Include in Graduation" = FILTER(true),
                                                               "Supp. Failed" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60137; "Final  Graduating Core Units"; Integer)
        {
            CalcFormula = Sum("ACA-Student Units".Units WHERE("Student No." = FIELD("Student No."),
                                                               Programme = FIELD(Programmes),
                                                               Unit = FILTER(<> ''),
                                                               "Reg Reversed" = FILTER(false),
                                                               "Include in Graduation" = FILTER(true),
                                                               "Unit Type (Flow)" = FILTER('Core|Required'),
                                                               "Supp. Failed" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60138; "Final  Graduating Electives"; Integer)
        {
            CalcFormula = Sum("ACA-Student Units".Units WHERE("Student No." = FIELD("Student No."),
                                                               Programme = FIELD(Programmes),
                                                               Unit = FILTER(<> ''),
                                                               "Reg Reversed" = FILTER(false),
                                                               "Include in Graduation" = FILTER(true),
                                                               "Unit Type (Flow)" = FILTER(Elective),
                                                               "Supp. Failed" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60139; "Final  Grad. Req. Units"; Integer)
        {
            CalcFormula = Sum("ACA-Defined Units per YoS"."Number of Units" WHERE(Programmes = FIELD(Programmes),
                                                                                   Options = FIELD(Options)));
            FieldClass = FlowField;
        }
        field(60140; "Is Final Year Student"; Boolean)
        {
            CalcFormula = Exist("ACA-Course Registration" WHERE("Maximum Year of Study" = FIELD("Final Graduation YoS"),
                                                                 "Student No." = FIELD("Student No."),
                                                                 Reversed = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60141; "Yearly Graduating Marks"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Supp. Total Marks" WHERE("Student No." = FIELD("Student No."),
                                                                             Programme = FIELD(Programmes),
                                                                             "Unit Year of Study" = FIELD("Year Of Study"),
                                                                             Unit = FILTER(<> ''),
                                                                             "Include in Graduation" = FILTER(true),
                                                                             "Supp. Grade" = FILTER('A|B|C|D')));
            FieldClass = FlowField;
        }
        field(60142; "Final Graduating Marks"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Supp. Total Marks" WHERE("Student No." = FIELD("Student No."),
                                                                             Programme = FIELD(Programmes),
                                                                             Unit = FILTER(<> ''),
                                                                             "Include in Graduation" = FILTER(true),
                                                                             "Supp. Grade" = FILTER('A|B|C|D')));
            FieldClass = FlowField;
        }
        field(60143; "Yearly Graduating Average"; Decimal)
        {
        }
        field(60144; "Yearly Graduating Courses"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Programme = FIELD(Programmes),
                                                           Unit = FILTER(<> ''),
                                                           "Reg Reversed" = FILTER(false),
                                                           "Unit Year of Study" = FIELD("Year Of Study"),
                                                           "Include in Graduation" = FILTER(true),
                                                           "Supp. Grade" = FILTER('A|B|C|D')));
            FieldClass = FlowField;
        }
        field(60145; "Final Graduating Courses"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Programme = FIELD(Programmes),
                                                           Unit = FILTER(<> ''),
                                                           "Reg Reversed" = FILTER(false),
                                                           "Include in Graduation" = FILTER(true),
                                                           "Supp. Grade" = FILTER('A|B|C|D')));
            FieldClass = FlowField;
        }
        field(60146; "Final Graduating Average"; Decimal)
        {
        }
        field(60149; "Yearly Grad. W. Average"; Decimal)
        {
        }
        field(60150; "Final Grad. W.Average"; Decimal)
        {
        }
        field(60151; "Final Clasification"; Code[100])
        {
        }
        field(60152; "Yearly Grad. Weighted Units"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Supp. Weighted Units" WHERE("Student No." = FIELD("Student No."),
                                                                                Programme = FIELD(Programmes),
                                                                                "Unit Year of Study" = FIELD("Year Of Study"),
                                                                                "Reg. Reversed" = FILTER(false),
                                                                                "Include in Graduation" = FILTER(true),
                                                                                "Supp. Grade" = FILTER('A|B|C|D')));
            FieldClass = FlowField;
        }
        field(60153; "Final Grad. Weighted Units"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Supp. Weighted Units" WHERE("Student No." = FIELD("Student No."),
                                                                                Programme = FIELD(Programmes),
                                                                                "Reg. Reversed" = FILTER(false),
                                                                                "Include in Graduation" = FILTER(true),
                                                                                "Supp. Grade" = FILTER('A|B|C|D')));
            FieldClass = FlowField;
        }
        field(60154; "Final Graduation YoS"; Integer)
        {
            CalcFormula = Max("ACA-Defined Units per YoS"."Year of Study" WHERE(Programmes = FIELD(Programmes)));
            FieldClass = FlowField;
        }
        field(60155; "Final Grad. Year of Admission"; Code[20])
        {
            CalcFormula = Lookup("ACA-Course Registration"."Academic Year" WHERE("Student No." = FIELD("Student No."),
                                                                                  "Year Of Study" = FILTER(1),
                                                                                  Reversed = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60156; "Yearly Passed (To Graduate)"; Boolean)
        {
        }
        field(60157; "Final Passed (To Graduate)"; Boolean)
        {
            CalcFormula = - Exist("ACA-Course Registration" WHERE("Student No." = FIELD("Student No."),
                                                                  "Yearly Passed (To Graduate)" = FILTER(false),
                                                                  Reversed = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60158; "Yearly Passed Cores"; Integer)
        {
            CalcFormula = Sum("ACA-Student Units".Units WHERE("Student No." = FIELD("Student No."),
                                                               Programme = FIELD(Programmes),
                                                               "Unit Year of Study" = FIELD("Year Of Study"),
                                                               "Supp. Grade" = FILTER('A|B|C|D'),
                                                               Unit = FILTER(<> ''),
                                                               "Total Marks" = FILTER(> 0),
                                                               "Reg. Reversed" = FILTER(false),
                                                               "Unit Type (Flow)" = FILTER('Core|Required')));
            FieldClass = FlowField;
        }
        field(60159; "Yearly Passed Electives"; Integer)
        {
            CalcFormula = Sum("ACA-Student Units".Units WHERE("Student No." = FIELD("Student No."),
                                                               Programme = FIELD(Programmes),
                                                               "Unit Year of Study" = FIELD("Year Of Study"),
                                                               "Supp. Grade" = FILTER('A|B|C|D'),
                                                               Unit = FILTER(<> ''),
                                                               "Total Marks" = FILTER(> 0),
                                                               "Reg. Reversed" = FILTER(false),
                                                               "Unit Type (Flow)" = FILTER(Elective)));
            FieldClass = FlowField;
        }
        field(60160; "Exists Where Not Graduating"; Boolean)
        {
            CalcFormula = Exist("ACA-Course Registration" WHERE("Student No." = FIELD("Student No."),
                                                                 "Yearly Passed (To Graduate)" = FILTER(false),
                                                                 Reversed = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60161; "To Graduate"; Boolean)
        {
        }
        field(60162; "Reason not to Graduate"; Text[100])
        {
        }
        field(60163; "Graduation Academic Year"; Code[20])
        {
            TableRelation = "ACA-Academic Year".Code;
        }
        field(60164; "No. of Registrations"; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE("Student No." = FIELD("Student No."),
                                                                 Reversed = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60165; "Program Option (Flow)"; Code[20])
        {
            CalcFormula = Lookup("ACA-Course Registration".Options WHERE("Student No." = FIELD("Student No."),
                                                                          Options = FILTER(<> '')));
            FieldClass = FlowField;
            TableRelation = "ACA-Programme Options".Code WHERE("Programme Code" = FIELD(Programmes));
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
            CalcFormula = Lookup("ACA-Programme"."School Code" WHERE(Code = FIELD(Programmes)));
            FieldClass = FlowField;
        }
        field(60168; "Department Code"; Code[20])
        {
            CalcFormula = Lookup("ACA-Programme"."Department Code" WHERE(Code = FIELD(Programmes)));
            FieldClass = FlowField;
        }
        field(60169; "Exists Unevaluated"; Boolean)
        {
            CalcFormula = Exist("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Semester = FIELD(Semester),
                                                           Programme = FIELD(Programmes),
                                                           "Course Evaluated" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60170; "Final Stage"; Boolean)
        {
            CalcFormula = Lookup("ACA-Programme Stages"."Final Stage" WHERE("Programme Code" = FIELD(Programmes),
                                                                             Code = FIELD(Stage)));
            FieldClass = FlowField;
        }
        field(60171; "Special Programme Class"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'General,Medicine & Nursing,Engineering';
            OptionMembers = General,"Medicine & Nursing",Engineering;
        }
        field(60172; "Highest Yearly Repeats"; Integer)
        {
            CalcFormula = Count("Aca-Special Exams Details" WHERE("Student No." = FIELD("Student No."),
                                                                   Catogory = FILTER(Supplementary),
                                                                   "Academic Year" = FIELD("Academic Year")));
            FieldClass = FlowField;
        }
        field(60173; "Number of Acedemic Year Repeat"; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE("Student No." = FIELD("Student No."),
                                                                 Programmes = FIELD(Programmes),
                                                                 "Supplementary Exists" = FILTER(true)));
            FieldClass = FlowField;
        }
        field(60174; "Yearly Failed Cores"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Credit Hours" WHERE("Student No." = FIELD("Student No."),
                                                                        Programme = FIELD(Programmes),
                                                                        "Unit Year of Study" = FIELD("Year Of Study"),
                                                                        Failed = FILTER(true),
                                                                        Unit = FILTER(<> ''),
                                                                        "CATs Marks Exists" = FILTER(true),
                                                                        "EXAMs Marks Exists" = FILTER(true),
                                                                        "Reg. Reversed" = FILTER(false),
                                                                        "Unit Type (Flow)" = FILTER('Core|Required')));
            FieldClass = FlowField;
        }
        field(60175; "Yearly Failed Electives"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Credit Hours" WHERE("Student No." = FIELD("Student No."),
                                                                        Programme = FIELD(Programmes),
                                                                        "Unit Year of Study" = FIELD("Year Of Study"),
                                                                        Failed = FILTER(true),
                                                                        Unit = FILTER(<> ''),
                                                                        "CATs Marks Exists" = FILTER(true),
                                                                        "EXAMs Marks Exists" = FILTER(true),
                                                                        "Reg. Reversed" = FILTER(false),
                                                                        "Unit Type (Flow)" = FILTER(Elective)));
            FieldClass = FlowField;
        }
        field(60176; "Yearly Total Cores"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Credit Hours" WHERE("Student No." = FIELD("Student No."),
                                                                        Programme = FIELD(Programmes),
                                                                        "Unit Year of Study" = FIELD("Year Of Study"),
                                                                        "Reg. Reversed" = FILTER(false),
                                                                        "Unit Type (Flow)" = FILTER('Core|Required')));
            FieldClass = FlowField;
        }
        field(60177; "ID Printed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60178; "Yearly Total Electives"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Credit Hours" WHERE("Student No." = FIELD("Student No."),
                                                                        Programme = FIELD(Programmes),
                                                                        "Unit Year of Study" = FIELD("Year Of Study"),
                                                                        "Reg. Reversed" = FILTER(false),
                                                                        "Unit Type (Flow)" = FILTER(Elective)));
            FieldClass = FlowField;
        }
        field(60179; "Yearly Failed Cores %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60180; "Yearly Failed Electives %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60181; "Yearly Failed Units %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60182; "Resits Registered and Failed"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Programme = FIELD(Programmes),
                                                           "Unit Year of Study" = FIELD("Year Of Study"),
                                                           "Reg. Reversed" = FILTER(false),
                                                           Failed = FILTER(true),
                                                           "Supp. Registered & Passed" = FILTER(false),
                                                           "Supp Taken" = FILTER(true)));
            FieldClass = FlowField;
        }
        field(60183; "Supp. Yearly Failed Cores"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Credit Hours" WHERE("Student No." = FIELD("Student No."),
                                                                        Programme = FIELD(Programmes),
                                                                        "Unit Year of Study" = FIELD("Year Of Study"),
                                                                        "Supp. Failed" = FILTER(true),
                                                                        Unit = FILTER(<> ''),
                                                                        "Reg. Reversed" = FILTER(false),
                                                                        "Unit Type (Flow)" = FILTER('Core|Required')));
            FieldClass = FlowField;
        }
        field(60184; "Supp. Yearly Failed Electives"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Credit Hours" WHERE("Student No." = FIELD("Student No."),
                                                                        Programme = FIELD(Programmes),
                                                                        "Unit Year of Study" = FIELD("Year Of Study"),
                                                                        "Supp. Failed" = FILTER(true),
                                                                        Unit = FILTER(<> ''),
                                                                        "Reg. Reversed" = FILTER(false),
                                                                        "Unit Type (Flow)" = FILTER(Elective)));
            FieldClass = FlowField;
        }
        field(60185; "Supp. Yearly Total Cores"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Credit Hours" WHERE("Student No." = FIELD("Student No."),
                                                                        Programme = FIELD(Programmes),
                                                                        "Unit Year of Study" = FIELD("Year Of Study"),
                                                                        "Reg. Reversed" = FILTER(false),
                                                                        "Unit Type (Flow)" = FILTER('Core|Required')));
            FieldClass = FlowField;
        }
        field(60186; "Supp. Yearly Total Electives"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Credit Hours" WHERE("Student No." = FIELD("Student No."),
                                                                        Programme = FIELD(Programmes),
                                                                        "Unit Year of Study" = FIELD("Year Of Study"),
                                                                        "Reg. Reversed" = FILTER(false),
                                                                        "Unit Type (Flow)" = FILTER(Elective)));
            FieldClass = FlowField;
        }
        field(60187; "Supp. Yearly Failed Cores %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60188; "SuppYearly Failed Electives %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60189; "Supp. Yearly Failed Units %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60190; "Graduation Status Count"; Integer)
        {
            CalcFormula = Count("ACAD-Grad. Stud. Presidence" WHERE("Pass Status" = FIELD("Class Status"),
                                                                     "Graduation Academic Year" = FIELD("Graduation Academic Year"),
                                                                     "Program Code" = FIELD(Programmes)));
            FieldClass = FlowField;
        }
        field(60191; "Class Status"; Code[20])
        {
            CalcFormula = Lookup("ACAD-Grad. Stud. Presidence"."Pass Status" WHERE("Student No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(60192; "Final Failed Courses"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Credit Hours" WHERE("Student No." = FIELD("Student No."),
                                                                        "Supp. Failed" = FILTER(true),
                                                                        Unit = FILTER(<> ''),
                                                                        "Reg. Reversed" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60193; "Option Exist"; Boolean)
        {
            CalcFormula = Exist("ACA-Programme Options" WHERE("Programme Code" = FIELD(Programmes)));
            FieldClass = FlowField;
        }
        field(60194; "Results Cancelled"; Boolean)
        {
            CalcFormula = Exist("Aca-Result Cancelation Req. Hd" WHERE("Student No." = FIELD("Student No."),
                                                                        "Academic Year" = FIELD("Academic Year"),
                                                                        "Semester Code" = FIELD(Semester),
                                                                        Status = FILTER(Approved),
                                                                        "Program Code" = FILTER('ZZZZZ'),
                                                                        Scope = FILTER("Entire Semester")));
            FieldClass = FlowField;
        }
        field(60195; ProgramName; Text[250])
        {
            CalcFormula = lookup("ACA-Programme".Description where(Code = field(Programmes)));
            FieldClass = FlowField;
        }
        field(60196; "Personal Email"; Text[100])
        {
            CalcFormula = Lookup(Customer."E-Mail" WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(60198; "Date Posted"; Date)
        {

        }
        field(60199; "Posted By"; Code[20])
        {

        }
        field(60200; Nationality; code[20])
        {
            CalcFormula = lookup(Customer.Nationality where("No." = field("Student No.")));
            FieldClass = FlowField;
        }
        field(60201; ModeofStudy; code[20])
        {
            CalcFormula = lookup("ACA-Settlement Type".ModeofStudy where(Code = field("Settlement Type")));
            FieldClass = FlowField;
        }
        // field(60202; FacultyName; Text[250])
        // {
        //     CalcFormula = lookup("ACA-Programme"."Faculty Name" where(Code = field(Programmes)));
        //     FieldClass = FlowField;
        // }
        // field(60196; Unitz; Integer)
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = count("ACA-Student Units".Unit where(Programme =field(Programmes),"Student No." = field("Student No."));
        // }
    }

    keys
    {
        key(Key1; "Reg. Transacton ID", "Student No.", Programmes, Semester, "Register for", Stage, "Student Type", "Entry No.")
        {
        }
        key(Key2; "Student Type")
        {
        }
        key(Key3; "Student No.")
        {
        }
        key(Key4; "General Remark")
        {
        }
        key(Key5; "Registration Date", Programmes, Stage)
        {
        }
        key(Key6; Stage)
        {
        }
        key(Key7; "Student No.", Programmes, Semester, "Register for", Stage, Unit, "Student Type")
        {
        }
        key(Key8; Stage, "Student No.")
        {
        }
        key(Key9; "Reg. Transacton ID", "Student No.", Programmes, Semester, "Register for", Unit, "Student Type")
        {
        }
        key(Key10; Programmes, "Student No.", "Entry No.")
        {
        }
        key(Key11; "Reg. Transacton ID", "Student No.", Programmes, Semester, "Register for", Stage, Unit, "Student Type")
        {
        }
        key(Key12; "Cumm Score")
        {
        }
        key(Key13; "Settlement Type", "Student No.")
        {
        }
        key(Key14; "Student No.", Stage)
        {
        }
        key(Key15; "Year of Admission", "Student No.")
        {
        }
        key(Key16; "Registration Date")
        {
        }
        key(Key17; Semester)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        RecType := RecType::CourseReg;
        // ValidateUser.validateUser(RecType);

        /*
       //IF "Attending Classes" = TRUE THEN
       //ERROR('Transaction once posted cannot be delete.');
       */
        IF Posted = TRUE THEN
            ERROR('Transaction once posted cannot be delete.');
        /*IF Registered = TRUE THEN
        ERROR('Transaction once Registered cannot be delete.');*/

        /*
        GenSetup.GET;
        IF ("Registration Date" > GenSetup."Allow Posting To") OR ("Registration Date" < GenSetup."Allow Posting From") THEN
        ERROR('Modification or deletion out of the allowed range not allowed.');
         */

        StudentCharges.RESET;
        StudentCharges.SETRANGE(StudentCharges."Student No.", "Student No.");
        StudentCharges.SETRANGE(StudentCharges."Reg. Transacton ID", "Reg. Transacton ID");
        IF StudentCharges.FIND('-') THEN
            StudentCharges.DELETEALL;

        StudentUnits.RESET;
        StudentUnits.SETRANGE(StudentUnits."Student No.", Rec."Student No.");
        StudentUnits.SETRANGE(Semester, Rec.Semester);
        //StudentUnits.SETRANGE(StudentUnits."Reg. Transacton ID","Reg. Transacton ID");
        IF StudentUnits.FIND('-') THEN
            StudentUnits.DELETEALL;
        /*
        ExamR.RESET;
        ExamR.SETRANGE(ExamR."Student No.","Student No.");
        ExamR.SETRANGE(Semester,Rec.Semester);
        IF ExamR.FIND('-') THEN
        ExamR.DELETEALL;
        */

    end;

    trigger OnInsert()
    begin
        RecType := RecType::CourseReg;
        //ValidateUser.validateUser(RecType);

        IF "Reg. Transacton ID" = '' THEN BEGIN
            GenSetup.GET;
            GenSetup.TESTFIELD(GenSetup."Registration Nos.");
            NoSeriesMgt.InitSeries(GenSetup."Registration Nos.", xRec."No. Series", 0D, "Reg. Transacton ID", "No. Series");

            //IF Stage='Y1S1' THEN
            //"First Time Student":=TRUE;

            //BKK Insert Academic year
            /* AcademicYear.RESET;
             AcademicYear.SETRANGE(AcademicYear.Current,TRUE);
             IF AcademicYear.FIND('-') THEN
             "Academic Year":=AcademicYear.Code
             ELSE ERROR('Please specify the current academic year in the academic year setup!');

             IntakeRec.RESET;
             IntakeRec.SETRANGE(IntakeRec.Current,TRUE);
             IF IntakeRec.FIND('-') THEN
             Session:=IntakeRec.Code;  */

        END;

    end;

    trigger OnModify()
    begin
        /*RecType:=RecType::CourseReg;
        ValidateUser.validateUser(RecType);

        //IF Posted = TRUE THEN
        //ERROR('Transaction once posted cannot be modified.');

        IF Programme<>xRec.Programme THEN BEGIN

        IF "Attending Classes" = TRUE THEN
        ERROR('Transaction once posted cannot be modified.');

        //IF Posted = TRUE THEN
        //ERROR('Transaction once posted cannot be modified.');
        {
        GenSetup.GET;
        IF ("Registration Date" > GenSetup."Allow Posting To") OR ("Registration Date" < GenSetup."Allow Posting From") THEN
        ERROR('Modification or deletion out of the allowed range not allowed.');
        }

        IF "Allow Adjustment" = FALSE THEN BEGIN
        IF Posted = TRUE THEN
        ERROR('You can not modify an already posted registration.');
        END ELSE BEGIN
        "Allow Adjustment":=FALSE;
        MODIFY;
        END;

        END;*/

        //IF Posted = TRUE THEN
        //ERROR('Transaction once posted cannot be modified.');

    end;

    trigger OnRename()
    begin
        RecType := RecType::CourseReg;
        // ValidateUser.validateUser(RecType);
        IF Posted = TRUE THEN
            ERROR('Transaction once posted cannot be modified.');
    end;

    var
        UserSetup: Record 91;
        coReg2: Record 61532;
        coReg1: Record 61532;
        acadYears: Record 61382;
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
        ProgStages: Record 61516;
        StudentUnits: Record 61549;
        StageUnits: Record 61517;
        EStageUnits: Record 61591;
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
        //GLPosting: Codeunit 12;
        SettlementType: Record 61522;
        CReg: Record 61532;
        CustPostGroup: Record 92;
        Programmz: Record 61511;
        CourseReg: Record 61532;
        CourseReg2: Record 61532;
        Found: Boolean;
        LibCode: Text[30];
        LibRefCodes: Record 61562;
        Custs: Record 18;
        UnitType: Text[100];
        TotalUnits: Integer;
        OldStud: Boolean;
        CReg2: Record 61532;
        PSemester: Record 61525;
        StudUnits: Record 61549;
        PStage: Record 61516;
        SFee: Record 61523;
        ExamR: Record 61548;
        Prog: Record 61511;
        Prog2: Record 61511;
        AcademicYear: Record 61382;
        IntakeRec: Record 61383;
        MultipleCombination: Record 61601;
        HostLedger: Record 61163;
        HostStudent: Record 61155;
        StudentUnits_2: Record 61549;

        //ValidateUser: Codeunit 61105;
        RecType: Option " ",GL,Cust,Item,Supp,FA,Emp,Sal,CourseReg,prTrans,EmpTrans;
        YearOfAdmin: Integer;

    procedure Check_Units_Exist(StudentNo: Code[20]; StudProg: Code[20]; Stag: Code[20]; Unt: Code[20]) Exists: Boolean
    var
        StudUnits: Record 61549;
    begin
        Exists := FALSE;
        StudUnits.RESET;
        StudUnits.SETRANGE(StudUnits.Programme, StudProg);
        StudUnits.SETRANGE(StudUnits.Stage, Stag);
        StudUnits.SETRANGE(StudUnits.Unit, Unt);
        StudUnits.SETRANGE(StudUnits."Student No.", StudentNo);
        IF StudUnits.FIND('-') THEN
            Exists := TRUE;
    end;
}

