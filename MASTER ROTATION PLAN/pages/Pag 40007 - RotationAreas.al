page 40007 "Rotation Areas"
{
    Caption = 'Rotation Areas';
    PageType = List;
    SourceTable = Lab;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Area cODE"; rec."Area cODE")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lab ID field.', Comment = '%';
                }
                field("Lab Name"; Rec."Lab Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lab Name field.', Comment = '%';
                }
                field(Capacity; REC.Capacity)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
