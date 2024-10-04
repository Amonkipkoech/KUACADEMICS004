table 61573 "ACA-Exam Prerequisites"
{

    fields
    {
        field(1; "Code"; Code[30])
        {
            TableRelation = "ACA-Exam Preq Checklist".Prerequisite;
        }
        field(2; Description; Text[100])
        {
        }
        field(3; "Min Value"; Decimal)
        {
        }
        field(4; "Max Value"; Decimal)
        {
        }
        field(5; "Exam Code"; Code[50])
        {
            TableRelation = "ACA-Exams".Code;
        }
        field(6; Apply; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Exam Code", "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF USERID <> 'AppKings' THEN BEGIN
            //ERROR('You do not have permissions to modify the Exam Prerequisites Tables');
            EXIT;
        END;
    end;

    trigger OnInsert()
    begin
        IF USERID <> 'AppKings' THEN BEGIN
            //ERROR('You do not have permissions to modify the Exam Prerequisites Tables');
            EXIT;
        END;
    end;

    trigger OnModify()
    begin
        IF USERID <> 'AppKings' THEN BEGIN
            //ERROR('You do not have permissions to modify the Exam Prerequisites Tables');
            EXIT;
        END;
    end;

    trigger OnRename()
    begin
        IF USERID <> 'AppKings' THEN BEGIN
            //ERROR('You do not have permissions to modify the Exam Prerequisites Tables');
            EXIT;
        END;
    end;
}

