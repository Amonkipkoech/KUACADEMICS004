page 68832 "ACA-Schools/Faculties"
{
    PageType = List;
    SourceTable = 61649;

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
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Dean Staff ID"; "Dean Staff ID")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

