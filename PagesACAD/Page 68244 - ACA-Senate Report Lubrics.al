page 68244 "ACA-Senate Report Lubrics"
{
    CardPageID = "ACA-Results Status Labels";
    DeleteAllowed = false;
    InsertAllowed = false;
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
            action("Import Lubrics")
            {
                ApplicationArea = All;
                Image = Accounts;
                RunObject = xmlport "Import Senate Lubrics";

            }
        }
    }
}

