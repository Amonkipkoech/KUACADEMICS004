page 68729 "ACA-Time Table Header"
{
    PageType = Card;
    SourceTable = 61571;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Programmes; Rec.Programme)
                {
                    ApplicationArea = All;
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Campus; Rec.Campus)
                {
                    ApplicationArea = All;
                }
                field(Day; Rec.Day)
                {
                    ApplicationArea = All;
                }
                field("Lecturer Room"; Rec."Lecturer Room")
                {
                    ApplicationArea = All;
                }
                field(Lecturer; Rec.Lecturer)
                {
                    ApplicationArea = All;
                }
            }
            group(Units)
            {
                Caption = 'Units';
#pragma warning disable AL0269
                part("Programme Units"; "ACA-Time Table Lines")
#pragma warning restore AL0269
                {
                    Caption = 'Programme Units';
                    SubPageLink = "Programme Code" = FIELD(Programme),
                                  "Stage Code" = FIELD(Stage),
                                  "Semester Filter" = FIELD(Semester),
                                  "Day Filter" = FIELD(Day),
                                  "Lecture Room Filter" = FIELD("Lecturer Room"),
                                  "Lecturer Filter" = FIELD(Lecturer);
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Update Header")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF GenSetup.GET() THEN
                        GenSetup.MODIFYALL(GenSetup."Current TT Code", Rec.Code);
                end;
            }
        }
    }

    var
        GenSetup: Record "ACA-General Set-Up";
}

