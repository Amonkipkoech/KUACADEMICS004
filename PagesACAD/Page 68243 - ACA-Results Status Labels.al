/// <summary>
/// Page ACA-Results Status Labels (ID 68243).
/// </summary>
page 68243 "ACA-Results Status Labels"
{
    DeleteAllowed = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Document;
    SourceTable = 61382;

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
                part(AcaR; "ACA-Results Status List")
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

