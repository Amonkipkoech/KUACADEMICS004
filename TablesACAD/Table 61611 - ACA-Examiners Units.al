table 61611 "ACA-Examiners Units"
{

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; No; Code[20])
        {
        }
        field(3; "Campus code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(4; Programmes; Code[20])
        {
            TableRelation = "ACA-Programme".Code;
        }
        field(5; Stage; Code[20])
        {
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD(Programmes));
        }
        field(6; Unit; Code[20])
        {
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD(Programmes),
                                                           "Stage Code" = FIELD(Stage));

            trigger OnValidate()
            begin
                StudUnits.RESET;
                StudUnits.SETRANGE(StudUnits.Programme, Programmes);
                StudUnits.SETRANGE(StudUnits.Unit, Unit);
                if StudUnits.FIND('-') THEN BEGIN
                    REPEAT
                        StudUnits.CALCFIELDS(StudUnits."Campus Code");
                        if StudUnits."Campus Code" = "Campus code" THEN BEGIN
                            StudUnits.Supervisor := No;
                            StudUnits.MODIFY;
                        END;
                    UNTIL StudUnits.NEXT = 0;
                END;
            end;
        }
    }

    keys
    {
        key(Key1; "Line No", No)
        {
        }
    }

    fieldgroups
    {
    }

    var
        StudUnits: Record "ACA-Student Units";
}

