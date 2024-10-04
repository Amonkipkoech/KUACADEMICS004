page 70260 "ACA CRM Role Center"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part("Dashboard Greetings"; "Dashboard Greetings")

            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(Creation)
        {
            group(SetUP)
            {
                action(KUCCPSMailingLis)
                {
                    Caption = 'GSS Mailing List';
                    ApplicationArea = all;
                    RunObject = Page "KUCCPS Imports Mailing List";
                    RunPageMode = View;
                }//"ACA-Mailing List Params"
                action("Send GSS MailS")
                {
                    Caption = 'Send Mail';
                    ApplicationArea = all;
                    RunObject = Page "ACA-Mailing List Params";

                }//"ACA-Mailing List Params"
                action(SendMail)
                {
                    Caption = 'Sent Mail';
                    ApplicationArea = all;
                    RunObject = Page "Sent Emails";
                    RunPageMode = View;
                }
            }
        }
        area(Sections)
        {
            group("Mail Management")
            {
                action(KUCCPSMailingList)
                {
                    Caption = 'GSS Mailing List';
                    ApplicationArea = all;
                    RunObject = Page "KUCCPS Imports Mailing List";
                    RunPageMode = View;
                }//"ACA-Mailing List Params"
                action("Send GSS Mail")
                {
                    Caption = 'Send Mail';
                    ApplicationArea = all;
                    RunObject = Page "ACA-Mailing List Params";

                }//"ACA-Mailing List Params"
                action(SendMails)
                {
                    Caption = 'Sent Mail';
                    ApplicationArea = all;
                    RunObject = Page "Sent Emails";
                    RunPageMode = View;
                }
                // action(Pass)
                // {
                //     ApplicationArea = All;
                //     RunObject = Page "Portal Pass"
                // }
            }
            group("Issues Management")
            {
                action("Issue List")
                {

                    ApplicationArea = all;
                    RunObject = Page "Issues List";
                    //RunPageMode = View;
                }//"ACA-Mailing List Params"

                // action(Pass)
                // {
                //     ApplicationArea = All;
                //     RunObject = Page "Portal Pass"
                // }
            }
        }
        area(Embedding)
        {
            action(EmbeddingAction)
            {
                // RunObject = Page ObjectName;
            }
        }
    }
}