page 68792 "ACA-Units Lecture can take"
{
    PageType = List;
    SourceTable = "ACA-Lecturers Qualified Units";

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
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Unit; Rec.Unit)
                {
                    ApplicationArea = All;
                }
                /* field(Units.Desription;
                    Units.Desription)
                {
                    Caption = 'Description';
                    Editable = false;
                } */
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
        Units.RESET;
        IF Units.GET(Rec.Programmes, Rec.Stage, Rec.Unit) THEN begin

        end;
    end;


    var
        Units: Record "ACA-Units/Subjects";
}

