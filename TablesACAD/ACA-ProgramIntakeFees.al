table 51869 "ACA-ProgramIntakeFee"
{
    //DataClassification = ToBeClassified;

    fields
    {
        field(1; ProgCode; Code[20])
        {
            TableRelation = "ACA-Programme".Code;
            trigger OnValidate()
            begin
                acaProg.Reset();
                acaProg.SetRange(acaProg.Code, ProgCode);
                if acaProg.Find('-') then begin
                    progName := acaProg.Description

                end
            end;
        }
        field(2; progName; text[200])
        {

        }
        field(3; intakeFee; Decimal)
        {

        }
        field(4; ModeOfstudy; code[20])
        {
            TableRelation = "ACA-Settlement Type".Code;
        }
        field(5; Campus; code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));

        }
    }

    keys
    {
        key(Key1; ProgCode, progName, ModeOfstudy,Campus)
        {
            Clustered = true;
        }
    }

    var
        acaProg: Record "ACA-Programme";

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}