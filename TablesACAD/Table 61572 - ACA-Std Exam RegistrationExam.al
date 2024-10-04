table 61572 "ACA-Std Exam Registration/Exam"
{
    //LookupPageID = 69135;

    fields
    {
        field(1; "Reg.Code"; Code[10])
        {
            NotBlank = true;

            trigger OnLookup()
            begin
                // myUserID := USERID;
                // IF myUserID <> 'AppKings' THEN BEGIN
                //     //ERROR('You do not have permission to modify Exam Registrations');
                // END
            end;

            trigger OnValidate()
            begin
                // myUserID := USERID;
                // IF myUserID <> 'AppKings' THEN BEGIN
                //     //ERROR('You do not have permission to modify Exam Registrations');
                // END
            end;
        }
        field(2; "Student No."; Code[30])
        {
            NotBlank = true;
            TableRelation = Customer."No." WHERE("Customer Type" = CONST(Student));

            trigger OnLookup()
            begin
                // myUserID := USERID;
                // IF myUserID <> 'AppKings' THEN
                // BEGIN
                //      //ERROR('You do not have permission to modify Exam Registrations');
                // END
            end;

            trigger OnValidate()
            begin
                // myUserID := USERID;
                // IF myUserID <> 'AppKings' THEN
                // BEGIN
                //      //ERROR('You do not have permission to modify Exam Registrations');
                // END
            end;
        }
        field(3; "Exam Code"; Code[30])
        {
            Editable = true;
            NotBlank = true;
            TableRelation = "ACA-Exams".Code;

            trigger OnLookup()
            begin
                // myUserID := USERID;
                // IF myUserID <> 'AppKings' THEN BEGIN
                //     //ERROR('You do not have permission to modify Exam Registrations');
                // END
            end;

            trigger OnValidate()
            begin
                // myUserID := USERID;
                // IF myUserID <> 'AppKings' THEN BEGIN
                //     //ERROR('You do not have permission to modify Exam Registrations');
                // END
            end;
        }
        field(4; Remark; Text[150])
        {
            Editable = false;

            trigger OnLookup()
            begin
                // myUserID := USERID;
                // IF myUserID <> 'AppKings' THEN BEGIN
                //     //ERROR('You do not have permission to modify Exam Registrations');
                // END
            end;

            trigger OnValidate()
            begin
                // myUserID := USERID;
                // IF myUserID <> 'AppKings' THEN BEGIN
                //     //ERROR('You do not have permission to modify Exam Registrations');
                // END
            end;
        }
        field(5; Programmes; Code[30])
        {
            Editable = true;
            NotBlank = false;
            TableRelation = "ACA-Programme".Code;

            trigger OnLookup()
            begin
                // myUserID := USERID;
                // IF myUserID <> 'AppKings' THEN
                // BEGIN
                //      //ERROR('You do not have permission to modify Exam Registrations');
                // END
            end;

            trigger OnValidate()
            begin
                // myUserID := USERID;
                // IF myUserID <> 'AppKings' THEN
                // BEGIN
                //      //ERROR('You do not have permission to modify Exam Registrations');
                // END
            end;
        }
        field(6; Stage; Code[30])
        {
            NotBlank = false;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD(Programmes));

            trigger OnLookup()
            begin
                // myUserID := USERID;
                // IF myUserID <> 'AppKings' THEN
                // BEGIN
                //      //ERROR('You do not have permission to modify Exam Registrations');
                // END
            end;

            trigger OnValidate()
            begin
                // myUserID := USERID;
                // IF myUserID <> 'AppKings' THEN
                // BEGIN
                //      //ERROR('You do not have permission to modify Exam Registrations');
                // END
            end;
        }
        field(7; Semester; Code[30])
        {
            NotBlank = false;
            TableRelation = "ACA-Programme Semesters".Semester WHERE("Programme Code" = FIELD(Programmes));

            trigger OnLookup()
            begin
                // myUserID := USERID;
                // IF myUserID <> 'AppKings' THEN
                // BEGIN
                //      //ERROR('You do not have permission to modify Exam Registrations');
                // END
            end;

            trigger OnValidate()
            begin
                // myUserID := USERID;
                // IF myUserID <> 'AppKings' THEN
                // BEGIN
                //      //ERROR('You do not have permission to modify Exam Registrations');
                // END
            end;
        }
        field(8; Unit; Code[30])
        {
            NotBlank = true;
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD(Programmes),
                                                           "Stage Code" = FIELD(Stage));

            trigger OnLookup()
            begin
                // myUserID := USERID;
                // IF myUserID <> 'AppKings' THEN
                // BEGIN
                //      //ERROR('You do not have permission to modify Exam Registrations');
                // END
            end;

            trigger OnValidate()
            begin
                // myUserID := USERID;
                // IF myUserID <> 'AppKings' THEN
                // BEGIN
                //      //ERROR('You do not have permission to modify Exam Registrations');
                // END
            end;
        }
        field(9; "Reg.Date"; Date)
        {
            Editable = false;

            trigger OnLookup()
            begin
                // myUserID := USERID;
                // IF myUserID <> 'AppKings' THEN
                // BEGIN
                //      //ERROR('You do not have permission to modify Exam Registrations');
                // END
            end;

            trigger OnValidate()
            begin
                // myUserID := USERID;
                // IF myUserID <> 'AppKings' THEN
                // BEGIN
                //      //ERROR('You do not have permission to modify Exam Registrations');
                // END
            end;
        }
        field(10; Balance; Decimal)
        {
            NotBlank = false;

            trigger OnLookup()
            begin
                // myUserID := USERID;
                // IF myUserID <> 'AppKings' THEN
                // BEGIN
                //      //ERROR('You do not have permission to modify Exam Registrations');
                // END
            end;

            trigger OnValidate()
            begin
                // myUserID := USERID;
                // IF myUserID <> 'AppKings' THEN
                // BEGIN
                //      //ERROR('You do not have permission to modify Exam Registrations');
                // END
            end;
        }
        field(11; "Student Type"; Code[10])
        {
            NotBlank = false;
        }
        field(12; "Sat.For.Exam"; Boolean)
        {
            InitValue = true;

            trigger OnLookup()
            begin
                // myUserID := USERID;
                // IF myUserID <> 'AppKings' THEN
                // BEGIN
                //      //ERROR('You do not have permission to modify Exam Registrations');
                // END
            end;

            trigger OnValidate()
            begin
                // myUserID := USERID;
                // IF myUserID <> 'AppKings' THEN
                // BEGIN
                //      //ERROR('You do not have permission to modify Exam Registrations');
                // END
            end;
        }
        field(13; "Student Name"; Text[250])
        {
            Editable = true;
            NotBlank = false;

            trigger OnLookup()
            begin
                // myUserID := USERID;
                // IF myUserID <> 'AppKings' THEN
                // BEGIN
                //      //ERROR('You do not have permission to modify Exam Registrations');
                // END
            end;

            trigger OnValidate()
            begin
                // myUserID := USERID;
                // IF myUserID <> 'AppKings' THEN
                // BEGIN
                //      //ERROR('You do not have permission to modify Exam Registrations');
                // END
            end;
        }
        field(14; Campus; Code[20])
        {
        }
        field(15; "Programme Filter"; Code[50])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme".Code;
        }
        field(16; "Stage Filter"; Code[60])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD("Programme Filter"));
        }
        field(17; "Semester Filter"; Code[80])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme Semesters".Semester WHERE("Programme Code" = FIELD("Programme Filter"));
        }
        field(18; "Unit Filter"; Code[80])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD("Programme Filter"),
                                                           "Stage Code" = FIELD("Stage Filter"));
        }
        field(19; "Exam Filter"; Code[150])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Exams".Code WHERE(Code = FIELD("Exam Filter"));
        }
        field(20; "Campus Filter"; Code[50])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('CAMPUS'));
        }
        field(21; Status; Option)
        {
            NotBlank = false;
            OptionMembers = "  ",PENDING,APPROVED,REJECTED;

            trigger OnLookup()
            begin
                // myUserID := USERID;
                // IF myUserID <> 'AppKings' THEN
                // BEGIN
                //   //   ERROR('You do not have permission to modify Exam Registrations');
                // END
            end;

            trigger OnValidate()
            begin
                // myUserID := USERID;
                // IF USERID<>'AppKings' THEN
                // BEGIN
                // //ERROR('You do not have permissions to change the Exam Registration Status');
                // EXIT;
                // END;
            end;
        }
        field(22; Result; Integer)
        {

            trigger OnLookup()
            begin
                // myUserID := USERID;
                // IF myUserID <> 'AppKings' THEN
                // BEGIN
                //      //ERROR('You do not have permission to modify Exam Registrations');
                // END
            end;

            trigger OnValidate()
            begin
                // myUserID := USERID;
                // IF myUserID <> 'AppKings' THEN
                // BEGIN
                //     // ERROR('You do not have permission to modify Exam Registrations');
                // END
                // ELSE
                // BEGIN
                //      SUPPS.GoToStudentUnits("Student No.");
                // END;
            end;
        }
        field(23; Faculty; Code[100])
        {

            trigger OnLookup()
            begin
                // myUserID := USERID;
                // IF myUserID <> 'AppKings' THEN
                // BEGIN
                //      //ERROR('You do not have permission to modify Exam Registrations');
                // END
            end;

            trigger OnValidate()
            begin
                // myUserID := USERID;
                // IF myUserID <> 'AppKings' THEN
                // BEGIN
                //      //ERROR('You do not have permission to modify Exam Registrations');
                // END
            end;
        }
        field(24; CATCOUNT; Integer)
        {
            CalcFormula = Count("ACA-Std Exam Registration/Exam" WHERE("Student No." = FIELD("Student No."),
                                                                        Unit = FIELD(Unit),
                                                                        "Sat.For.Exam" = CONST(true)));
            FieldClass = FlowField;
        }
        field(25; "Class Attendance"; Decimal)
        {
        }
        field(26; "Student Filter"; Code[150])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Std Exam Registration/Exam"."Student No." WHERE(Programmes = FIELD("Programme Filter"),
                                                                                  Stage = FIELD("Stage Filter"),
                                                                                  Semester = FIELD("Semester Filter"),
                                                                                  Unit = FIELD("Unit Filter"),
                                                                                  "Exam Code" = FIELD("Exam Filter"));
        }
        field(27; "New Score"; Integer)
        {

            trigger OnValidate()
            begin
                IF xRec."New Score" <> Rec."New Score" THEN BEGIN
                    Remarked := TRUE;
                    MODIFY;
                    IF Comment = '' THEN
                        ERROR('A Comment must be entered on remarking');

                    IF "New Score" > Result THEN BEGIN
                        IF ReceiptNo = '' THEN
                            ERROR('Enter the Receipt No. for this transaction');
                        //IF Grading.CalculateFinalScore("Student No.",Unit,"New Score","Exam Code") = TRUE THEN
                        BEGIN
                            MESSAGE('Student No %1 is due for refunds of Exam Remarking fee', "Student No.");
                            "Due for Refund" := TRUE;
                            "Refund Comment" := 'Refund the Remarking Fee Amount';
                            // SUPPS.GoToStudentUnits("Student No.");
                            MODIFY;
                        END;
                    END;
                END;
            end;
        }
        field(28; Remarked; Boolean)
        {
        }
        field(29; Comment; Text[150])
        {
        }
        field(31; DateModified; Date)
        {
        }
        field(32; RecUserID; Code[100])
        {
        }
        field(33; ReceiptNo; Code[80])
        {
            TableRelation = "ACA-Receipt"."Receipt No.";
        }
        field(34; UNITCOUNT; Integer)
        {
            CalcFormula = Count("ACA-Std Exam Registration/Exam" WHERE("Student No." = FIELD("Student No."),
                                                                        Programmes = FIELD(Programmes),
                                                                        Stage = FIELD(Stage),
                                                                        Unit = FIELD(Unit),
                                                                        "Sat.For.Exam" = CONST(true)));
            FieldClass = FlowField;
        }
        field(35; UnitGrade; Text[130])
        {
        }
        field(36; StageGrade; Text[130])
        {
        }
        field(37; "Due for Refund"; Boolean)
        {
        }
        field(38; "Refund Comment"; Text[150])
        {
        }
        field(39; StudentCount; Integer)
        {
            CalcFormula = Count("ACA-Std Exam Registration/Exam" WHERE(Unit = FIELD(Unit),
                                                                        "Sat.For.Exam" = CONST(true),
                                                                        "Exam Code" = FIELD("Exam Code")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Student No.", Programmes, Stage, Semester, Unit, "Exam Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        myUserID := USERID;
        IF myUserID <> 'AppKings' THEN BEGIN
            //ERROR('You do not have permission to modify Exam Registrations');
        END
    end;

    trigger OnInsert()
    begin
        myUserID := USERID;
        IF myUserID <> 'AppKings' THEN BEGIN
            //ERROR('You do not have permission to modify Exam Registrations');
        END;
        IF Rec."New Score" <> xRec."New Score" THEN BEGIN
            //RecUserID := USERID;
            //DateModified := WORKDATE;
            MODIFY;
        END;
    end;

    trigger OnModify()
    begin
        myUserID := USERID;
        IF myUserID <> 'AppKings' THEN BEGIN
            //ERROR('You do not have permission to modify Exam Registrations');
        END;
        IF Rec."New Score" <> xRec."New Score" THEN BEGIN
            IF Comment = '' THEN
                ERROR('A Comment must be entered on remarking');
            IF ReceiptNo = '' THEN
                ERROR('Enter the Receipt No. for this transaction');

        END;
        BEGIN
            //RecUserID := USERID;
            //DateModified := WORKDATE;
            //MODIFY;
        END;
    end;

    trigger OnRename()
    begin
        myUserID := USERID;
        IF myUserID <> 'AppKings' THEN BEGIN
            //ERROR('You do not have permission to modify Exam Registrations');
        END;
        BEGIN
        END;
    end;

    var
        myUserID: Text[150];
        //SUPPS: Codeunit "50137";
        RecExamGrades: Record 61575;
    // Grading: Codeunit "50138";
}

