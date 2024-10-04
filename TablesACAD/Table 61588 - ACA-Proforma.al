table 61588 "ACA-Proforma"
{

    fields
    {
        field(1; "Proforma No."; Code[20])
        {
        }
        field(2; Name; Text[30])
        {
            Caption = 'Name';
        }
        field(5; Address; Text[30])
        {
            Caption = 'Address';
        }
        field(6; "Address 2"; Text[30])
        {
            Caption = 'Address 2';
        }
        field(7; City; Text[30])
        {
            Caption = 'City';

            trigger OnLookup()
            begin
                //PostCode.LookUpCity(City,"Post Code",TRUE);
            end;

            trigger OnValidate()
            begin
                //PostCode.ValidateCity(City,"Post Code");
            end;
        }
        field(8; Contact; Text[30])
        {
            Caption = 'Contact';
        }
        field(9; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
        }
        field(10; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                //PostCode.LookUpPostCode(City,"Post Code",TRUE);
            end;

            trigger OnValidate()
            begin
                //PostCode.ValidatePostCode(City,"Post Code");
            end;
        }
        field(11; County; Text[30])
        {
            Caption = 'County';
        }
        field(12; Semester; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme Semesters".Semester WHERE("Programme Code" = FIELD(Programmes));

            trigger OnValidate()
            begin
                //"Settlement Type":='';
            end;
        }
        field(13; Programmes; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme".Code;

            trigger OnValidate()
            begin
                Programms.RESET;
                Programms.SETRANGE(Programms.Code, Programmes);
                IF Programms.FIND('-') THEN BEGIN
                    "Programme Description" := Programms.Description;
                END;
                "Settlement Type" := '';
                Semester := '';
                Stage := '';
            end;
        }
        field(14; "Register for"; Option)
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
        field(15; Stage; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD(Programmes));

            trigger OnValidate()
            begin
                "Settlement Type" := '';
                Semester := '';
            end;
        }
        field(16; Unit; Code[20])
        {
            TableRelation = IF ("Register for" = CONST("Unit/Subject")) "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD(Programmes),
                                                                                                 "Stage Code" = FIELD(Stage));

            trigger OnValidate()
            begin
                "Settlement Type" := '';
            end;
        }
        field(17; "Settlement Type"; Code[20])
        {
            NotBlank = false;
            TableRelation = "ACA-Settlement Type".Code;

            trigger OnValidate()
            begin

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


                /*
                StudentCharges.RESET;
                StudentCharges.SETRANGE(StudentCharges."Student No.","Student No.");
                StudentCharges.SETRANGE(StudentCharges."Reg. Transacton ID","Proforma No.");
                IF StudentCharges.FIND('-') THEN
                StudentCharges.DELETEALL;
                */


                StudentChargesR.RESET;
                StudentChargesR.SETRANGE(StudentChargesR."Student No.", "Student No.");
                IF NOT StudentChargesR.FIND('-') THEN BEGIN
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
                            StudentCharges."Reg. Transacton ID" := "Proforma No.";
                            StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::"Stage Fees";
                            StudentCharges.Code := NewStudentCharges.Code;
                            StudentCharges.Description := NewStudentCharges.Description;
                            StudentCharges.Amount := NewStudentCharges.Amount;
                            StudentCharges.Quantity := 1;
                            StudentCharges."Recovered First" := NewStudentCharges."Recovered First";
                            StudentCharges."Recovery Priority" := NewStudentCharges."Recovery Priority";
                            StudentCharges.Distribution := NewStudentCharges."Distribution (%)";
                            StudentCharges."Distribution Account" := NewStudentCharges."Distribution Account";
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
                        StudentCharges."Reg. Transacton ID" := "Proforma No.";
                        StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::"Stage Fees";
                        StudentCharges.Code := NewStudentCharges.Code;
                        StudentCharges.Description := NewStudentCharges.Description;
                        StudentCharges.Amount := NewStudentCharges.Amount;
                        StudentCharges.Quantity := 1;
                        StudentCharges."Recovered First" := NewStudentCharges."Recovered First";
                        StudentCharges."Recovery Priority" := NewStudentCharges."Recovery Priority";
                        StudentCharges.Distribution := NewStudentCharges."Distribution (%)";
                        StudentCharges."Distribution Account" := NewStudentCharges."Distribution Account";
                        StudentCharges.Charge := TRUE;
                        StudentCharges."Transacton ID" := '';
                        StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                        StudentCharges.INSERT;

                    UNTIL NewStudentCharges.NEXT = 0
                END;


                TotalUnits := 0;

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
                                StudentCharges."Reg. Transacton ID" := "Proforma No.";
                                StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::"Stage Fees";
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
                                StudentCharges.Quantity := 1;
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
                            StageCharges.SETRANGE(StageCharges."Student Type", StageCharges."Student Type"::" ");
                            IF StageCharges.FIND('-') THEN BEGIN
                                REPEAT
                                    IF StageCharges.Semester = '' THEN BEGIN
                                        StudentCharges.INIT;
                                        StudentCharges.Programme := Programmes;
                                        StudentCharges.Stage := Stage;
                                        StudentCharges.Semester := Semester;
                                        StudentCharges."Student No." := "Student No.";
                                        StudentCharges."Reg. Transacton ID" := "Proforma No.";
                                        StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::"Stage Fees";
                                        StudentCharges.Code := StageCharges.Code;
                                        StudentCharges.Description := StageCharges.Description;
                                        StudentCharges.Amount := StageCharges.Amount;
                                        StudentCharges.Quantity := 1;
                                        StudentCharges."Recovered First" := StageCharges."Recovered First";
                                        StudentCharges."Recovery Priority" := StageCharges."Recovery Priority";
                                        StudentCharges.Distribution := StageCharges."Distribution (%)";
                                        StudentCharges."Distribution Account" := StageCharges."Distribution Account";
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
                                            StudentCharges."Reg. Transacton ID" := "Proforma No.";
                                            StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::"Stage Fees";
                                            StudentCharges.Code := StageCharges.Code;
                                            StudentCharges.Description := StageCharges.Description;
                                            StudentCharges.Amount := StageCharges.Amount;
                                            StudentCharges.Quantity := 1;
                                            StudentCharges."Recovered First" := StageCharges."Recovered First";
                                            StudentCharges."Recovery Priority" := StageCharges."Recovery Priority";
                                            StudentCharges.Distribution := StageCharges."Distribution (%)";
                                            StudentCharges."Distribution Account" := StageCharges."Distribution Account";
                                            StudentCharges."Transacton ID" := '';
                                            StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                                            StudentCharges.INSERT;
                                        END;
                                    END;

                                UNTIL StageCharges.NEXT = 0;

                            END;

                            IF "Student Type" = "Student Type"::"Full Time" THEN BEGIN
                                //Charges by student type - Full Time
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
                                            StudentCharges."Reg. Transacton ID" := "Proforma No.";
                                            StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::"Stage Fees";
                                            StudentCharges.Code := StageCharges.Code;
                                            StudentCharges.Description := StageCharges.Description;
                                            StudentCharges.Amount := StageCharges.Amount;
                                            StudentCharges.Quantity := 1;
                                            StudentCharges."Recovered First" := StageCharges."Recovered First";
                                            StudentCharges."Recovery Priority" := StageCharges."Recovery Priority";
                                            StudentCharges.Distribution := StageCharges."Distribution (%)";
                                            StudentCharges."Distribution Account" := StageCharges."Distribution Account";
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
                                                StudentCharges."Reg. Transacton ID" := "Proforma No.";
                                                StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::"Stage Fees";
                                                StudentCharges.Code := StageCharges.Code;
                                                StudentCharges.Description := StageCharges.Description;
                                                StudentCharges.Amount := StageCharges.Amount;
                                                StudentCharges.Quantity := 1;
                                                StudentCharges."Recovered First" := StageCharges."Recovered First";
                                                StudentCharges."Recovery Priority" := StageCharges."Recovery Priority";
                                                StudentCharges.Distribution := StageCharges."Distribution (%)";
                                                StudentCharges."Distribution Account" := StageCharges."Distribution Account";
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
                                            StudentCharges."Reg. Transacton ID" := "Proforma No.";
                                            StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::"Stage Fees";
                                            StudentCharges.Code := StageCharges.Code;
                                            StudentCharges.Description := StageCharges.Description;
                                            StudentCharges.Amount := StageCharges.Amount;
                                            StudentCharges.Quantity := 1;
                                            StudentCharges."Recovered First" := StageCharges."Recovered First";
                                            StudentCharges."Recovery Priority" := StageCharges."Recovery Priority";
                                            StudentCharges.Distribution := StageCharges."Distribution (%)";
                                            StudentCharges."Distribution Account" := StageCharges."Distribution Account";
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
                                                StudentCharges."Reg. Transacton ID" := "Proforma No.";
                                                StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::"Stage Fees";
                                                StudentCharges.Code := StageCharges.Code;
                                                StudentCharges.Description := StageCharges.Description;
                                                StudentCharges.Amount := StageCharges.Amount;
                                                StudentCharges.Quantity := 1;
                                                StudentCharges."Recovered First" := StageCharges."Recovered First";
                                                StudentCharges."Recovery Priority" := StageCharges."Recovery Priority";
                                                StudentCharges.Distribution := StageCharges."Distribution (%)";
                                                StudentCharges."Distribution Account" := StageCharges."Distribution Account";
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
                            StudentCharges."Reg. Transacton ID" := "Proforma No.";
                            StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::"Unit Fees";
                            StudentCharges.Code := Unit;
                            StudentCharges.Description := 'Fees for' + ' ' + Programmes + '-' + Stage + '-' + Unit;
                            StudentCharges.Amount := TotalCost;
                            StudentCharges.Quantity := 1;
                            StudentCharges."Tuition Fee" := TRUE;
                            StudentCharges."Full Tuition Fee" := TotalCost;
                            StudentCharges."Transacton ID" := '';
                            StudentCharges."Recovery Priority" := 20;
                            StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                            StudentCharges.INSERT;


                        END;
                    END;
                END;

            end;
        }
        field(18; Modules; Integer)
        {

            trigger OnValidate()
            begin
                "Settlement Type" := '';
            end;
        }
        field(19; "Student No."; Code[20])
        {
            TableRelation = Customer."No." WHERE("Customer Type" = CONST(Student));

            trigger OnValidate()
            begin
                IF Cust.GET("Student No.") THEN BEGIN
                    Name := Cust.Name;
                    Address := Cust.Address;
                    "Address 2" := Cust."Address 2";
                    City := Cust.City;
                    Contact := Cust.Contact;
                    "Phone No." := Cust."Phone No.";
                    "Post Code" := Cust."Post Code";
                    County := Cust.County;

                END;
            end;
        }
        field(20; "Student Type"; Option)
        {
            OptionCaption = 'Full Time,Part Time,Distance Learning';
            OptionMembers = "Full Time","Part Time","Distance Learning";
        }
        field(21; "Programme Description"; Text[150])
        {
        }
        field(22; "No. Series"; Code[20])
        {

            trigger OnValidate()
            begin
                IF "Proforma No." <> xRec."Proforma No." THEN BEGIN
                    GenSetup.GET;
                    //NoSeriesMgt.TestManual(GenSetup."Proforma Nos");
                    "No. Series" := '';
                END;

                IF "Proforma No." = '' THEN BEGIN
                    GenSetup.GET;
                    GenSetup.TESTFIELD(GenSetup."Proforma Nos");
                    //NoSeriesMgt.InitSeries(GenSetup."Proforma Nos", xRec."No. Series", 0D, "Proforma No.", "No. Series");
                END;
            end;
        }
        field(23; Date; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Proforma No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "Proforma No." = '' THEN BEGIN
            GenSetup.GET;
            GenSetup.TESTFIELD(GenSetup."Proforma Nos");
            //NoSeriesMgt.InitSeries(GenSetup."Proforma Nos", xRec."No. Series", 0D, "Proforma No.", "No. Series");
        END;

        Date := TODAY;
    end;

    var
        PostCode: Record "Post Code";
        FeeByStage: Record "ACA-Fee By Stage";
        FeeByUnit: Record "ACA-Fee By Unit";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenSetup: Record "ACA-General Set-Up";
        StudentCharges: Record "ACA-Proforma Lines";
        StudentChargesR: Record "ACA-Std Charges";
        TotalCost: Decimal;
        StageCharges: Record "ACA-Stage Charges";
        NewStudentCharges: Record "ACA-New Student Charges";
        RecFound: Boolean;
        CoursePrerequisite: Record "ACA-Course Prerequisite";
        SPrereq: Record "ACA-Std Prerequisite Approval";
        Stages: Record "ACA-Programme Stages";
        StudentUnits: Record "ACA-Student Units";
        StageUnits: Record "ACA-Units/Subjects";
        GenJnl: Record "Gen. Journal Line";
        Units: Record "ACA-Units/Subjects";
        ExamsByStage: Record "ACA-Exams";
        ExamsByUnit: Record "ACA-Exams By Units";
        Charges: Record "ACA-Charge";
        Sems: Record "ACA-Semesters";
        SemFound: Boolean;
        DueDate: Date;
        Cust: Record "Customer";
        GenBatches: Record "Gen. Journal Batch";
        window: Dialog;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        SettlementType: Record "ACA-Settlement Type";
        CReg: Record "ACA-Course Registration";
        CustPostGroup: Record "Customer Posting Group";
        Programms: Record "ACA-Programme";
        CourseReg: Record "ACA-Course Registration";
        Found: Boolean;
        LibCode: Text[30];
        LibRefCodes: Record "ACA-Lib Refference Table";
        Custs: Record "Customer";
        UnitType: Text[100];
        TotalUnits: Integer;
}

