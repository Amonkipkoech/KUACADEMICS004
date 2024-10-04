page 69032 "ACA-Examiners Units"
{
    PageType = ListPart;
    SourceTable = "ACA-Examiners Units";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Campus code"; Rec."Campus code")
                {
                    ApplicationArea = All;
                }
                field(Programme; Rec.Programmes)
                {
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
            }
        }
    }

    actions
    {
    }
}

