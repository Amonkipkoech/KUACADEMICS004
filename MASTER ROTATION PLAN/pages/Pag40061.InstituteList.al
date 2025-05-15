page 40061 "Institute List"
{
    PageType = List;
    SourceTable = "Institute Master";
    ApplicationArea = All;
    CardPageId = "Institute Master Card";
    UsageCategory = Lists;
    Caption = 'Institute Master List';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Institute Code"; rec."Institute Code") { }
                field("Institute Name"; rec."Institute Name") { }
                field("Contact Email"; rec."Contact Email") { }
                field("Phone Number"; rec."Phone Number") { }
            }
        }
    }
}
