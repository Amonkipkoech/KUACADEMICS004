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
                field("Line No."; rec."Application No.")
                {
                    ApplicationArea = All;
                    TableRelation = "Supp Exam Registration Header"."Application No.";

                }

                field("Unit Code"; rec."Unit Code")
                {
                    ApplicationArea = All;
                }

                field("Unit Name"; rec."Unit Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
