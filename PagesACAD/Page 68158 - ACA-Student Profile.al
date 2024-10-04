page 68158 "ACA-Student Profile"
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
        area(processing)
        {
            action("Student Login")
            {
                Image = Lock;
                InFooterBar = true;
                RunObject = Page 68156;
                ApplicationArea = All;
            }
            separator(__)
            {
            }
            separator(Login)
            {
            }
            action("Staff Login")
            {
                Image = Lock;
                RunObject = Page 68157;
                ApplicationArea = All;
            }
        }
        area(creation)
        {
            separator(Form)
            {
            }
            action("Application Form")
            {
                Image = New;
                RunObject = Page 68467;
                ApplicationArea = All;
            }
        }
    }
}

