table 61521 "ACA-Grading System"
{
    // DrillDownPageID = 67010;
    // LookupPageID = 67010;

    fields
    {
        field(1; "Programme Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme".Code;
        }
        field(2; Grade; Code[20])
        {
            NotBlank = true;
        }
        field(3; Description; Text[150])
        {
        }
        field(4; "Up to"; Decimal)
        {
        }
        field(5; Remarks; Text[150])
        {
        }
        field(6; Failed; Boolean)
        {
        }
        field(7; Range; Text[150])
        {
        }
        field(8; "Programme Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            //TableRelation = Table67000.Field1;
        }
        field(9; "Stage Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            //TableRelation = Table67005.Field2 WHERE (Field1=FIELD("Programme Filter"));
        }
        field(10; "Semester Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            //TableRelation = Table67014.Field2 WHERE (Field1=FIELD(Programme Filter));
        }
        field(11; "Student Count"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE(Grade = FIELD(Grade),
                                                           Semester = FIELD("Semester Filter"),
                                                           Programme = FIELD("Programme Filter"),
                                                           Stage = FIELD("Stage Filter"),
                                                           Unit = FIELD("Unit Filter")));
            FieldClass = FlowField;
        }
        field(12; "Unit Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(13; RangeReport; Text[150])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Programme Code", "Up to", Grade)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF ((USERID <> 'COSMAS.MUTHAMIA') AND (USERID <> 'WANJALA') AND (USERID <> 'OOKOTH') AND (USERID <> 'JODERO')) THEN ERROR('Accecc Denied!');
    end;

    trigger OnInsert()
    begin
        IF ((USERID <> 'COSMAS.MUTHAMIA') AND (USERID <> 'WANJALA') AND (USERID <> 'OOKOTH') AND (USERID <> 'JODERO')) THEN ERROR('Accecc Denied!');
    end;

    trigger OnModify()
    begin
        IF ((USERID <> 'COSMAS.MUTHAMIA') AND (USERID <> 'WANJALA') AND (USERID <> 'OOKOTH') AND (USERID <> 'JODERO')) THEN ERROR('Accecc Denied!');
    end;

    trigger OnRename()
    begin
        IF ((USERID <> 'COSMAS.MUTHAMIA') AND (USERID <> 'WANJALA') AND (USERID <> 'OOKOTH') AND (USERID <> 'JODERO')) THEN ERROR('Accecc Denied!');
    end;
}

