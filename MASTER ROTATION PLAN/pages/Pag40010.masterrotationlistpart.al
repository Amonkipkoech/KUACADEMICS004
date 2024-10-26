page 40010 "Clinical Rotation List Part"

{
    PageType = ListPart;

    SourceTable = "Clinical Rotation"; // This should be a separate table for managing weekly rotations

    Caption = 'Clinical Rotation List';

    layout
    {
        area(content)
        {
            repeater("clinical rotation")
            {
                field("Plan ID"; rec."Plan ID")
                {
                    ApplicationArea = all;
                }
                field(Group; rec.Group)
                {
                    ApplicationArea = all;

                }
                field(Areas; rec.Areas)
                {
                    ApplicationArea = all;

                }
                field("Week No"; rec."Week No")
                {
                    ApplicationArea = all;

                }
                field(Month; rec.Month)
                {
                    ApplicationArea = all;

                }
                field("Starting Date"; rec."Starting Date")
                {
                    ApplicationArea = all;

                }
                field("Ending Date"; rec."Ending Date")
                {
                    ApplicationArea = all;

                }


                // Continue with fields up to Site Week 52...
            }
        }
    }
}

