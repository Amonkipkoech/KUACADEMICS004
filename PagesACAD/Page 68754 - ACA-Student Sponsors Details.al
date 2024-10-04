page 68754 "ACA-Student Sponsors Details"
{
    PageType = List;
    SourceTable = "ACA-Student Sponsors Details";

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Names; Rec.Names)
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Telephone No"; Rec."Telephone No")
                {
                    ApplicationArea = All;
                }
                field("E-Mail Address"; Rec."E-Mail Address")
                {
                    ApplicationArea = All;
                }
                field("Contact Person"; Rec."Contact Person")
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
}

