page 68417 "HRM-Class Allocation List"
{
    CardPageID = "ACA-Class Allocation Card";
    PageType = List;
    SourceTable = "ACA-Class Allocation";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Campus; Rec.Campus)
                {
                    ApplicationArea = All;
                }
                field("Students Range"; Rec."Students Range")
                {
                    ApplicationArea = All;
                }
                field("Student Count"; Rec."Student Count")
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

