page 40003 "Users Custom"
{
    AdditionalSearchTerms = 'permission,office 365 admin center,microsoft 365 admin center';
    ApplicationArea = Basic, Suite;
    Caption = 'Users Custom';
    CardPageID = "User Card Custom";
    DelayedInsert = true;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Navigate';
    RefreshOnActivate = true;
    SourceTable = User;
    SourceTableView = sorting("User Name");
    UsageCategory = Administration;
    Editable = false;

    AboutTitle = 'About user accounts';
    AboutText = 'Here, you manage who has access, and who can do what. Assign specific permissions to individual users, and organize users in user groups with group-level permissions.';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User Security ID"; "User Security ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies an ID that uniquely identifies the user. This value is generated automatically and should not be changed.';
                    Visible = false;
                }
                field("User Name"; "User Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'User Name';
                    ToolTip = 'Specifies the user''s name. If the user is required to present credentials when starting the client, this is the name that the user must present.';

                    trigger OnValidate()
                    begin
                        ValidateUserName;
                    end;
                }
                field("Full Name"; "Full Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Full Name';
                    Editable = not IsSaaS;
                    ToolTip = 'Specifies the full name of the user.';
                }
                field(State; State)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Status';
                    ToolTip = 'Specifies if the user''s login is enabled.';
                }
                field("Windows Security ID"; "Windows Security ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the Windows Security ID of the user. This is only relevant for Windows authentication.';
                    Visible = false;
                    Editable = not IsSaas;
                }
                field("Windows User Name"; WindowsUserName)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Windows User Name';
                    ToolTip = 'Specifies the user''s name on Windows.';
                    Visible = not IsSaaS;

                    trigger OnValidate()
                    var
                        UserSID: Text;
                    begin
                        if WindowsUserName = '' then
                            "Windows Security ID" := ''
                        else begin
                            UserSID := Sid(WindowsUserName);
                            WindowsUserName := IdentityManagement.UserName(UserSID);
                            if WindowsUserName <> '' then begin
                                "Windows Security ID" := UserSID;
                                ValidateSid;
                                SetUserName;
                            end else
                                Error(Text001Err, WindowsUserName);
                        end;
                    end;
                }
                field("License Type"; "License Type")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'License Type';
                    Visible = not IsSaaS;
                    ToolTip = 'Specifies the type of license that applies to the user. For more information, see License Types.';
                }
                field("Authentication Email"; "Authentication Email")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ExtendedDatatype = EMail;
                    ToolTip = 'Specifies the Microsoft account that this user signs into Microsoft 365 or SharePoint Online with.';
                    Visible = IsSaaS;
                }
            }
        }
        area(factboxes)
        {
            part(Control18; "Permission Sets FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "User Security ID" = field("User Security ID");
            }
            part("User Group Memberships"; "User Group Memberships FactBox")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'User Group Memberships';
                SubPageLink = "User Security ID" = field("User Security ID");
            }
            part(Plans; "User Plans FactBox")
            {
                Caption = 'Licenses';
                ApplicationArea = Basic, Suite;
                SubPageLink = "User Security ID" = field("User Security ID");
                Visible = IsSaaS;
            }
            part(Control20; "User Setup FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "User ID" = field("User Name");
            }
            part(Control33; "User Settings FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "User Security ID" = field("User Security ID");
            }
            part(Control32; "Printer Selections FactBox")
            {
                ApplicationArea = Basic, Suite;
                ShowFilter = false;
                SubPageLink = "User ID" = field("User Name");
            }
            part(Control28; "My Customers")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
                ShowFilter = false;
                SubPageLink = "User ID" = field("User Name");
                Visible = false;
            }
            part(Control29; "My Vendors")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
                ShowFilter = false;
                SubPageLink = "User ID" = field("User Name");
                Visible = false;
            }
            part(Control30; "My Items")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
                ShowFilter = false;
                SubPageLink = "User ID" = field("User Name");
                Visible = false;
            }
            systempart(Control11; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
            systempart(Control12; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {

        }
    }

    views
    {
        view(OnlyEnabled)
        {
            Caption = 'Enabled';
            Filters = where(State = Const(Enabled));
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        User: Record User;
    begin
        CurrPage.SetSelectionFilter(User);
        CanSendEmail := User.Count() = 1;
    end;

    trigger OnAfterGetRecord()
    begin
        WindowsUserName := IdentityManagement.UserName("Windows Security ID");
        NoUserExists := false;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        if UserCard.DeleteUserIsAllowed(Rec) then
            exit(true);
        if not UserCard.ManageUsersIsAllowed then
            Error('');
    end;

    trigger OnInit()
    var
        EnvironmentInfo: Codeunit "Environment Information";
        UserPermissions: Codeunit "User Permissions";
    begin
        IsSaaS := EnvironmentInfo.IsSaaS();
        CanManageUsersOnTenant := UserPermissions.CanManageUsersOnTenant(UserSecurityId());
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if not UserCard.ManageUsersIsAllowed then
            Error('');
        if "User Name" = '' then
            Error(Text004Err, FieldCaption("User Name"));
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "User Security ID" := CreateGuid;
        WindowsUserName := '';
    end;

    trigger OnOpenPage()
    var
        MyNotification: Record "My Notifications";
        UserSelection: Codeunit "User Selection";
        UserManagement: Codeunit "User Management";
    begin
        rec.SetFilter("User Name", UserId);
        NoUserExists := IsEmpty;
        UserSelection.HideExternalUsers(Rec);
        if UserWithWebServiceKeyExist then begin
            Usermanagement.BasicAuthUsedNotificationDefault(true);
            if MyNotification.IsEnabled(UserManagement.BasicAuthUsedNotificationId()) then
                UserManagement.BasicAuthUsedNotificationShow(BasicAuthUsedNotification);
        end;
    end;

    var
        IdentityManagement: Codeunit "Identity Management";
        UserCard: Page "User Card";
        BasicAuthUsedNotification: Notification;
        WindowsUserName: Text[208];
        Text001Err: Label 'The account %1 is not a valid Windows account.', Comment = '%1=user name';
        Text002Err: Label 'The account %1 already exists.', Comment = '%1=user name';
        Text003Err: Label 'The account %1 is not allowed.', Comment = '%1=user name';
        Text004Err: Label '%1 cannot be empty.', Comment = '%1=user name';
        NoUserExists: Boolean;
        CreateQst: Label 'Do you want to create %1 as super user?', Comment = '%1=user name, e.g. europe\myaccountname';
        [InDataSet]
        CanSendEmail: Boolean;
        RestoreUserGroupsToDefaultQst: Label 'Do you want to restore the default user groups to for user %1?', Comment = 'Do you want to restore the default user groups to for user Annie?';
        CanManageUsersOnTenant: Boolean;
        IsSaaS: Boolean;

    local procedure ValidateSid()
    var
        User: Record User;
    begin
        if "Windows Security ID" = '' then
            Error(Text001Err, "User Name");

        if ("Windows Security ID" = 'S-1-1-0') or ("Windows Security ID" = 'S-1-5-7') then
            Error(Text003Err, "User Name");

        User.SetFilter("Windows Security ID", "Windows Security ID");
        User.SetFilter("User Security ID", '<>%1', "User Security ID");
        if not User.IsEmpty() then
            Error(Text002Err, WindowsUserName);
    end;

    local procedure ValidateUserName()
    var
        UserMgt: Codeunit "User Management";
    begin
        UserMgt.ValidateUserName(Rec, xRec, WindowsUserName);
        CurrPage.Update();
    end;

    local procedure SetUserName()
    begin
        "User Name" := WindowsUserName;
        ValidateUserName;
    end;

    procedure GetSelectionFilter(var User: Record User)
    begin
        CurrPage.SetSelectionFilter(User);
    end;

    local procedure UserWithWebServiceKeyExist(): Boolean
    var
        User: Record User;
        WebServiceKey: Text[80];
        UserWithWebServiceKeyFound: Boolean;
    begin
        if User.Count() > MaxNumberOfUsersToScanWebServcieAccessKey() then
            Exit(false);
        UserWithWebServiceKeyFound := false;
        if User.FindSet() then
            repeat
                WebServiceKey := IdentityManagement.GetWebServicesKey(USer."User Security ID");
                if WebServiceKey <> '' then
                    UserWithWebServiceKeyFound := true;
            until (User.Next() = 0) or UserWithWebServiceKeyFound;
        exit(UserWithWebServiceKeyFound);
    end;

    local procedure MaxNumberOfUsersToScanWebServcieAccessKey(): Integer
    begin
        exit(1000);
    end;
}

