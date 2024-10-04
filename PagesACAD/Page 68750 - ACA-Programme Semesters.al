page 68750 "ACA-Programme Semesters"
{
    PageType = List;
    SourceTable = "ACA-Programme Semesters";

    layout
    {
        area(content)
        {
            repeater(general)
            {
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
                field(Current; Rec.Current)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
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
        IF Sem.GET(Rec.Semester) THEN
            Desc := Sem.Description
        ELSE
            Desc := '';
    end;

    var
        Sem: Record "ACA-Semesters";
        Desc: Text[200];
}

