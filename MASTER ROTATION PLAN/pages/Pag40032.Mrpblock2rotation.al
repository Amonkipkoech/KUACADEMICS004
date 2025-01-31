page 40032 "Mrp block 2 rotation "
{

    PageType = ListPart;

    SourceTable = "Mrp Block Two Rotation Areas"; // This should be a separate table for managing weekly rotations

    Caption = 'Mrp block 2 rotation ';

    layout
    {
        area(content)
        {
            repeater("clinical rotation")
            {
                // field("Plan ID"; rec."Plan ID")
                // {
                //     ApplicationArea = all;
                // }
                field(Group; rec.Group)
                {
                    ApplicationArea = all;
                    TableRelation = GroupAssignments.GroupId;

                }
                field(Areas; rec.Areas)
                {
                    ApplicationArea = all;
                    TableRelation = Lab."Area cODE";


                }


                field("Starting Date"; rec."Starting Date")
                {
                    ApplicationArea = all;

                }
                field("Ending Date"; rec."Ending Date")
                {
                    ApplicationArea = all;

                }

                field(Month; rec.Month)
                {
                    ApplicationArea = all;

                }
                field("No Of Students"; rec."No Std")
                {
                    ApplicationArea = all;
                    DrillDownPageId = "Group Assignmnets ";

                }

                // Continue with fields up to Site Week 52...
            }
        }
    }
}


