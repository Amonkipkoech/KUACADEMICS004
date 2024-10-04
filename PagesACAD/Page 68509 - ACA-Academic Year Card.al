/// <summary>
/// Page ACA-Academic Year Card (ID 68509).
/// </summary>
page 68509 "ACA-Academic Year Card"
{
    PageType = Card;
    SourceTable = "ACA-Academic Year";

    layout
    {
        area(content)
        {
            group(general)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(From; Rec.From)
                {
                    ApplicationArea = All;
                }
                field("To"; Rec."To")
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
                field("Graduating Group"; Rec."Graduating Group")
                {
                    ApplicationArea = All;
                }
                field("Admission Date"; Rec."Admission Date")
                {
                    ApplicationArea = All;
                }
                field("Graduation Date (Degree)"; Rec."Graduation Date (Degree)")
                {
                    ApplicationArea = All;
                }
                field("Graduation Date (Certificate)"; Rec."Graduation Date (Certificate)")
                {
                    ApplicationArea = All;
                }
                field("Graduation Date (Diploma)"; Rec."Graduation Date (Diploma)")
                {
                    ApplicationArea = All;
                }
                field("Graduation Date (Masters)"; Rec."Graduation Date (Masters)")
                {
                    ApplicationArea = All;
                }
                field("Graduation Date (Medicine)"; Rec."Graduation Date (Medicine)")
                {
                    ApplicationArea = All;
                }
                field("Graduation Date (Engineering)"; Rec."Graduation Date (Engineering)")
                {
                    ApplicationArea = All;
                }
                field("Allow View of Transcripts"; Rec."Allow View of Transcripts")
                {
                    ApplicationArea = All;
                }
                field("Graduation Group (PhD)"; Rec."Graduation Group (PhD)")
                {
                    ApplicationArea = All;
                }
                field("Graduation Group (Masters)"; Rec."Graduation Group (Masters)")
                {
                    ApplicationArea = All;
                }
                field("Graduation Group (Degree)"; Rec."Graduation Group (Degree)")
                {
                    ApplicationArea = All;
                }
                field("Graduation Group (Diploma)"; Rec."Graduation Group (Diploma)")
                {
                    ApplicationArea = All;
                }
                field("Graduation Group (Certificate)"; Rec."Graduation Group (Certificate)")
                {
                    ApplicationArea = All;
                }
                field("ID Card Validity"; Rec."ID Card Validity")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Application_deadlines)
            {
                Image = Info;
                Promoted = true;
                RunObject = Page "ACA-Online Application Notes";
                RunPageLink = "Academic Year" = FIELD(Code);
                ApplicationArea = All;
            }
            action("Academic Year Schedule")
            {
                Image = CalendarMachine;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "ACA-Academic Year Schedule";
                RunPageLink = "Academic Year" = FIELD(Code);
                ApplicationArea = All;
            }
        }
    }

    var
        AcademicY: Record "ACA-Academic Year";

    local procedure CurrentOnPush()
    begin
        IF Rec.Current = TRUE THEN BEGIN
            IF CONFIRM('Are you sure you want to make ' + Rec.Code + ' as the current academic year?') THEN BEGIN
                AcademicY.RESET;
                IF AcademicY.FIND('-') THEN BEGIN
                    REPEAT
                        IF AcademicY.Code <> Rec.Code THEN BEGIN
                            AcademicY.Current := FALSE;
                            AcademicY.MODIFY;
                        END;
                    UNTIL AcademicY.NEXT = 0;
                END;
            END;
        END;
    end;
}

