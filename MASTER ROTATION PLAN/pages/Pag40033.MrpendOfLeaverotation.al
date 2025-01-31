page 40033 "Mrp  end Of Leave rotation"
{
    Caption = 'Mrp  end Of Leave rotation';
    PageType = ListPart;
    SourceTable = "Mrp End Of Leave Rotation ";




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
                field("No Std"; rec."No Std")
                {
                    ApplicationArea = all;
                    DrillDownPageId = "Group Assignmnets ";

                }
                // Continue with fields up to Site Week 52...
            }
        }
    }
}


