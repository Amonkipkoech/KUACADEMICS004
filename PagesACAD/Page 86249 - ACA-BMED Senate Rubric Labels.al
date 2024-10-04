page 86249 "ACA-BMED Senate Rubric Labels"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Document;
    SourceTable = "ACA-Academic Year";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Code; Rec.Code)
                {
                    Editable = false;
                    Enabled = false;
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
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
            }
            group(Lubric)
            {
                Caption = 'Lubric Details';
                part(acalub; 86247)
                {
                    SubPageLink = "Academic Year" = FIELD(Code);
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

