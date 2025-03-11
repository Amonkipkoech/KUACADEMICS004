page 40008 "master rotation list "
{
    Caption = 'Master Rotation List';
    PageType = List;
    CardPageId = "Master Rotation Plan Card";
    SourceTable = "Master Rotation Table";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Plan ID"; Rec."Plan ID") {}
              
              
                field(Category; Rec.Category) {}
            }
        }
    }
}
