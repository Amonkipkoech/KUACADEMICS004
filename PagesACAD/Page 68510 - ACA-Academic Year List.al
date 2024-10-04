page 68510 "ACA-Academic Year List"
{
    CardPageID = "ACA-Academic Year Card";
    PageType = List;
    SourceTable = "ACA-Academic Year";

    layout
    {
        area(content)
        {
            repeater(general)
            {
                Editable = false;
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
                field("Graduating Group"; Rec."Graduating Group")
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
                RunObject = Page 68858;
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
                Caption = 'University Calender';
            }
        }
    }

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;
}

