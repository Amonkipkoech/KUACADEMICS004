page 68513 "ACA-Intake Card"
{
    PageType = Card;
    SourceTable = 61383;

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Current; Rec.Current)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrentOnPush;
                    end;
                }
                field("Reporting Date"; Rec."Reporting Date")
                {
                    ApplicationArea = All;
                }
                field("Reporting End Date"; Rec."Reporting End Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    var
        IntakeRec: Record "ACA-Intake";

    local procedure CurrentOnPush()
    begin
        IF Rec.Current = TRUE THEN BEGIN
            IF CONFIRM('Do you really want to make ' + Rec.Code + ' as the current Intake?') THEN BEGIN
                IntakeRec.RESET;
                IF IntakeRec.FIND('-') THEN BEGIN
                    REPEAT
                        IF IntakeRec.Code <> Rec.Code THEN BEGIN
                            IntakeRec.Current := FALSE;
                            IntakeRec.MODIFY;
                        END;
                    UNTIL IntakeRec.NEXT = 0;
                END;
            END;
        END;
    end;
}

