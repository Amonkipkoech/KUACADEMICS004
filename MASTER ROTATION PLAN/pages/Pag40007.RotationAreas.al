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
                field("Lab ID"; Rec."Lab ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lab ID field.', Comment = '%';
                }
                field("Lab Name"; Rec."Lab Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lab Name field.', Comment = '%';
                }
            }
        }
    }
}
