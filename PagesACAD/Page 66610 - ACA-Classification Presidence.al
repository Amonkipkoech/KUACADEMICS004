page 66610 "ACA-Classification Presidence"
{
    PageType = List;
    SourceTable = 66600;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                }
                field(Presidence; Rec.Presidence)
                {
                    ApplicationArea = All;
                }
                field("Exists in Course Registration"; Rec."Exists in Course Registration")
                {
                    ApplicationArea = All;
                }
                field("Graduation Academic Year"; Rec."Graduation Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Program Code"; Rec."Program Code")
                {
                    ApplicationArea = All;
                }
                field("Pass Status"; Rec."Pass Status")
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

