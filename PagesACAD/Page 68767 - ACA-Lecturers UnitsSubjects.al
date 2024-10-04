page 68767 "ACA-Lecturers Units/Subjects"
{
    PageType = ListPart;
    SourceTable = "ACA-Lecturers Units";

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Programme; Rec.Programme)
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
                field("Campus Code"; Rec."Campus Code")
                {
                    ApplicationArea = All;
                }
                field(Unit; Rec.Unit)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Rate; Rec.Rate)
                {
                    ApplicationArea = All;
                }
                field("No. Of Hours"; Rec."No. Of Hours")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Claimed Amount"; Rec."Claimed Amount")
                {
                    ApplicationArea = All;
                }
                field("Claim to pay"; Rec."Claim to pay")
                {
                    ApplicationArea = All;
                }
                field("Student Type"; Rec."Student Type")
                {
                    ApplicationArea = All;
                }
                field("Available From"; Rec."Available From")
                {
                    ApplicationArea = All;
                }
                field("Available To"; Rec."Available To")
                {
                    ApplicationArea = All;
                }
                field(Allocation; Rec.Allocation)
                {
                    ApplicationArea = All;
                }
                field("No. Of Hours Contracted"; Rec."No. Of Hours Contracted")
                {
                    Caption = 'Contracted Hours ';
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
        //Units.RESET;
        //IF Units.GET(Programme,Stage,Unit) THEN
    end;

    var
        Units: Record "ACA-Units/Subjects";
}

