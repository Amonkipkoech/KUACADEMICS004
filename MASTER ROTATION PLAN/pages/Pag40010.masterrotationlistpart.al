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
                field("Week"; rec."Week No") { ApplicationArea = All; }
                field("Group"; rec.Group) { ApplicationArea = All; }

                // Continue with fields up to Site Week 52...
            }
        }
    }
}

