page 77801 "ACA-Programme Grad. Groups"
{
    PageType = List;
    SourceTable = "ACA-Programme Graduation Group";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Admission Academic Year"; Rec."Admission Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Graduation Academic Year"; Rec."Graduation Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Academic Year is Current"; Rec."Academic Year is Current")
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

