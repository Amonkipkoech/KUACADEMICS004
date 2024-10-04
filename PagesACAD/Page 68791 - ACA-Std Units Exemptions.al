page 68791 "ACA-Std Units Exemptions"
{
    PageType = List;
    SourceTable = 61553;

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Programme; Rec.Programmes)
                {
                    ApplicationArea = All;
                }
                field("Register for"; Rec."Register for")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;
                }
                field(Unit; Rec.Unit)
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Desc; Desc)
                {
                    Caption = 'Description';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Approval Date"; Rec."Approval Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Units.RESET;
        Units.SETRANGE(Units."Programme Code", Rec.Programmes);
        Units.SETRANGE(Units."Stage Code", Rec.Stage);
        Units.SETRANGE(Units.Code, Rec.Unit);
        IF Units.FIND('-') THEN
            Desc := Units.Desription
        ELSE
            Desc := '';
    end;

    trigger OnOpenPage()
    begin
        Desc := '';
    end;

    var
        Units: Record "ACA-Units/Subjects";
        Desc: Text[250];
}

