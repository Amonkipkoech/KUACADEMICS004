page 68855 "ACA-Student Picture"
{
    PageType = Card;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            group("Student Picture")
            {
                field(Picture; Rec.Image)
                {
                    ApplicationArea = All;
                }
                field("Barcode/QR Code"; Rec."Barcode/QR Code")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

