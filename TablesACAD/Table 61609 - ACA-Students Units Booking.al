table 61609 "ACA-Students Units Booking"
{

    fields
    {
        field(1; Programmes; Code[20])
        {
            TableRelation = "ACA-Programme".Code;
        }
        field(2; Semester; Code[20])
        {
            TableRelation = "ACA-Programme Semesters".Semester WHERE("Programme Code" = FIELD(Programmes));
        }
        field(3; Stage; Code[20])
        {
            TableRelation = "ACA-Programme Stages".Code;
        }
        field(4; "Student No"; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(5; Unit; Code[20])
        {
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD(Programmes),
                                                           "Stage Code" = FIELD(Stage));

            trigger OnValidate()
            begin
                UnitsRec.RESET;
                UnitsRec.SETRANGE(UnitsRec."Programme Code", Programmes);
                UnitsRec.SETRANGE(UnitsRec."Stage Code", Stage);
                UnitsRec.SETRANGE(UnitsRec.Code, Unit);
                if UnitsRec.FIND('-') THEN BEGIN
                    Description := UnitsRec.Desription;
                END;
            end;
        }
        field(6; Description; Text[100])
        {
        }
        field(7; Taken; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Student No", Unit, Semester)
        {
        }
        key(Key2; Unit)
        {
        }
    }

    fieldgroups
    {
    }

    var
        UnitsRec: Record "ACA-Units/Subjects";
}

