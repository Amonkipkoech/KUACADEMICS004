/// <summary>
/// Page ACA-Application Form Acad. Ref (ID 68468).
/// </summary>
page 68468 "ACA-Application Form Acad. Ref"
{
    PageType = ListPart;
    SourceTable = 61359;
    Caption = 'Applicant Next Of Kin';

    layout
    {
        area(content)
        {
            repeater(__)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Caption = 'Names';

                }
                field("Telephone No."; Rec."Telephone No.")
                {
                    ApplicationArea = All;
                    Caption =  'Mobile No';
                }
                field("Next Of Kin Relationship";Rec."Next Of Kin Relationship")
                {
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = All;
                    Visible =   false;
                }
                
            }
        }
    }

    actions
    {
    }
}

