table 61575 "ACA-Exam Grading"
{

    fields
    {
        field(1; ExamCode; Code[150])
        {
        }
        field(2; Upto; Decimal)
        {
        }
        field(3; Grade; Text[50])
        {
        }
        field(4; Remark; Text[100])
        {
        }
        field(5; Description; Text[150])
        {
        }
    }

    keys
    {
        key(Key1; ExamCode, Grade)
        {
        }
        key(Key2; Upto)
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

