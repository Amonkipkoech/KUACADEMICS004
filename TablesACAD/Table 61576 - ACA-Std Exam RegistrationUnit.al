table 61576 "ACA-Std Exam Registration/Unit"
{

    fields
    {
        field(1; "Reg.Code"; Code[10])
        {
            NotBlank = false;
        }
        field(2; "Student No."; Code[30])
        {
            NotBlank = true;
            TableRelation = Customer."No." WHERE("Customer Type" = CONST(Student));
        }
        field(4; Remark; Text[150])
        {
            Editable = false;
        }
        field(5; Programmes; Code[30])
        {
            Editable = true;
            NotBlank = false;
            TableRelation = "ACA-Programme".Code;
        }
        field(6; Stage; Code[30])
        {
            NotBlank = false;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD(Programmes));
        }
        field(7; Semester; Code[30])
        {
            NotBlank = false;
            TableRelation = "ACA-Programme Semesters".Semester WHERE("Programme Code" = FIELD(Programmes));
        }
        field(8; Unit; Code[30])
        {
            NotBlank = false;
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD(Programmes),
                                                           "Stage Code" = FIELD(Stage));
        }
        field(9; "Reg.Date"; Date)
        {
            Editable = false;
        }
        field(10; Balance; Decimal)
        {
            NotBlank = false;
        }
        field(11; "Student Type"; Code[10])
        {
            NotBlank = false;
        }
        field(13; "Student Name"; Text[250])
        {
            Editable = true;
            NotBlank = false;
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

            trigger OnValidate()
            begin
                myUserID := USERID;
                IF USERID <> 'AppKings' THEN BEGIN
                    ERROR('You do not have permissions to change the Exam Registration Status');
                    EXIT;
                END;
            end;
        }
        field(22; Faculty; Code[100])
        {
        }
        field(23; UnitCount; Integer)
        {
            CalcFormula = Count("ACA-Std Exam Registration/Unit" WHERE("Student No." = FIELD("Student No."),
                                                                        Stage = FIELD(Stage)));
            FieldClass = FlowField;
        }
        field(24; StageGrade; Text[120])
        {
        }
        field(25; UnitGrade; Text[120])
        {
        }
        field(26; Tested; Boolean)
        {
        }
        field(27; StudentCount; Integer)
        {
            CalcFormula = Count("ACA-Std Exam Registration/Unit" WHERE(Unit = FIELD(Unit)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Student No.", Programmes, Stage, Semester, Unit)
        {
        }
        key(Key2; Programmes, Stage, Semester, Unit)
        {
        }
        key(Key3; "Student No.", Unit)
        {
        }
    }

    fieldgroups
    {
    }

    var
        myUserID: Text[150];
}

