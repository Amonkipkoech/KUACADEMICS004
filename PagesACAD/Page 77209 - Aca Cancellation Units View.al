/// <summary>
/// Page Aca Cancellation Units View (ID 77209).
/// </summary>
page 77209 "Aca Cancellation Units View"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Aca-Result Cancelation Subject";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Unit Code"; Rec."Unit Code")
                {
                    ApplicationArea = All;
                }
                field("Exam Type"; Rec."Exam Type")
                {
                    ApplicationArea = All;
                }
                field("Unit Description"; Rec."Unit Description")
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

