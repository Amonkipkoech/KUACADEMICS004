page 60023 "ELECT-Role Center"
{
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
        }
    }

    actions
    {
        area(creation)
        {
            action(Vote)
            {
                Caption = 'Vote';
                Image = PostedVoucherGroup;
                
                
                RunObject = Page 60022;
                ApplicationArea = All;
            }
        }
    }
}

