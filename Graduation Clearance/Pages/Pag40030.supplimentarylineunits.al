page 40030 "Supp Exam Reg ListPart"
{
    PageType = ListPart;
   
    SourceTable = "Supp Exam Registration Line";
    Caption = 'Registered Units';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Unit Code"; "Unit Code")
                {
                    ApplicationArea = All;
                }

                field("Unit Name"; "Unit Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
