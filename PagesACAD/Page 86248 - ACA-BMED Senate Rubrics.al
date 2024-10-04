page 86248 "ACA-BMED Senate Rubrics"
{
    CardPageID = "ACA-BMED Senate Rubric Labels";
    DeleteAllowed = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "ACA-Academic Year";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    Editable = false;
                    Enabled = false;
                    Visible = true;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Current; Rec.Current)
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Allow View of Transcripts"; Rec."Allow View of Transcripts")
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
            action("Update Grading System")
            {
                Caption = 'Update Grades';
                Image = ExportShipment;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ExamsProcessing: Codeunit "Exams Processing";
                begin
                    ExamsProcessing.UpdateGradingSystem(Rec.Code);
                    MESSAGE('Grading System Updated');
                end;
            }
        }
    }
}

