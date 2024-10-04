page 70262 "ACA-Mailing Card Params"
{
    PageType = Card;

    SourceTable = "CRM Mail Parameters";

    layout
    {
        area(Content)
        {
            group("Mailing Header")
            {

                field("Mail Code"; Rec."Mail Code")
                {
                    ToolTip = 'Specifies the value of the Mail Code field.';
                    ApplicationArea = All;
                }
                field("Mail Batch"; Rec."Mail Batch")
                {
                    ToolTip = 'Specifies the value of the Mail Batch field.';
                    ApplicationArea = All;
                }
                field("Cc 1"; Rec."Cc 1")
                {
                    ToolTip = 'Specifies the value of the Cc 1 field.';
                    ApplicationArea = All;
                }
                field("Cc 2"; Rec."Cc 2")
                {
                    ToolTip = 'Specifies the value of the Cc 2 field.';
                    ApplicationArea = All;
                }
                field("Cc 3"; Rec."Cc 3")
                {
                    ToolTip = 'Specifies the value of the Cc 3 field.';
                    ApplicationArea = All;
                }
                field("Cc 4"; Rec."Cc 4")
                {
                    ToolTip = 'Specifies the value of the Cc 4 field.';
                    ApplicationArea = All;
                }
                field("BCc 1"; Rec."BCc 1")
                {
                    ToolTip = 'Specifies the value of the BCc 1 field.';
                    ApplicationArea = All;
                }
                field("BCc 2"; Rec."BCc 2")
                {
                    ToolTip = 'Specifies the value of the BCc 2 field.';
                    ApplicationArea = All;
                }
                field("BCc 3"; Rec."BCc 3")
                {
                    ToolTip = 'Specifies the value of the BCc 3 field.';
                    ApplicationArea = All;
                }
                field("Email Subject"; Rec."Email Subject")
                {
                    ToolTip = 'Specifies the value of the Email Subject field.';
                    ApplicationArea = All;
                }
                field("Email Body"; Rec."Email Body")
                {
                    ToolTip = 'Specifies the value of the Email Body field.';
                    ApplicationArea = All;
                }
                field("Email Body 2"; Rec."Email Body 2")
                {
                    ToolTip = 'Specifies the value of the Email Body 2 field.';
                    ApplicationArea = All;
                }

            }
            part("KUCCPS Imports Mailing List"; "KUCCPS Imports Mailing List")
            {
                SubPageLink = "KUCCPS Batch" = field("Mail Batch");
                ApplicationArea = all;

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(Print)
            {
                Caption = 'Print';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                begin
                    // KUCCPSImport.RESET;
                    // KUCCPSImport.SETFILTER(KUCCPSImport.Index,  Rec.Index);
                    // REPORT.RUN(51343, TRUE, TRUE, KUCCPSImport);
                    // Report.SaveAsPdf(51343,'OfferLetter' + kuccpsImport.Names, Rec);
                end;
            }
            action(SendMail)
            {
                Caption = 'Send Mail';
                ApplicationArea = All;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                var

                begin
                    Send();
                end;
            }
            action(SendMailWithAttachment)
            {
                Caption = 'Send Mail- Attachment';
                ApplicationArea = All;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                var

                begin
                    SendWithAttachemnt();
                end;
            }
        }
    }

    var
        smtpSetup: Codeunit "Mail Management";
        UserSetup: Record "User Setup";
        EmailSubject: Text[50];
        EmailBody: Text[250];
        EmailRecipient: List of [Text];
        SendMail: Codeunit "Email Message";
        Dialogie: Dialog;

        emailObj: Codeunit Email;

        kuccpsImport: Record "KUCCPS Imports";
        counter: Integer;


    local procedure Send()
    var
        salutation: Text[50];
        FileMgt: Codeunit "File Management";
    begin

        Clear(EmailBody);
        Clear(EmailSubject);
        Clear(EmailRecipient);

        if REc."Mail Batch" = '' then begin
            Message('Mail Batch Cannot Be Empty');
            exit;
        end;

        Rec.TestField("Email Body");
        Rec.TestField("Email Subject");


        EmailBody := 'Hello,' + ' ' + Rec."Email Body" + ' ' + Rec."Email Body 2" + 'This Is a system Generated Email. DO NOT REPLY!!';
        EmailSubject := Rec."Email Subject";

        //Dialogie.Open('Sending to #1  ');

        kuccpsImport.Reset();
        kuccpsImport.SetRange("KUCCPS Batch", Rec."Mail Batch");
        kuccpsImport.SetFilter(Email, '<>%1', '');
        if kuccpsImport.FindSet() then begin
            repeat

                SendMail.Create(kuccpsImport.Email, EmailSubject, EmailBody);
                emailObj.Send(SendMail);

                // Dialogie.Update(1, kuccpsImport.Names);

                kuccpsImport.Notified := true;
                kuccpsImport.Modify();

            until kuccpsImport.Next() = 0;
            //Dialogie.Close();
        end
        else
            Message('Batch Not Found In KUCCP List');

    end;


    local procedure SendWithAttachemnt()
    var
        salutation: Text[50];
        FileMgt: Codeunit "File Management";
        AttachmentInStream: InStream;
        AttachmentOutStream: OutStream;
        TempBlob: Codeunit "Temp Blob";
    begin

        Clear(EmailBody);
        Clear(EmailSubject);
        Clear(EmailRecipient);

        if REc."Mail Batch" = '' then begin
            Message('Mail Batch Cannot Be Empty');
            exit;
        end;

        Rec.TestField("Email Body");
        Rec.TestField("Email Subject");


        EmailBody := 'Hello,' + '\' + Rec."Email Body" + ' \' + Rec."Email Body 2";
        EmailSubject := Rec."Email Subject";

        //Dialogie.Open('Sending to #1  ');


        kuccpsImport.Reset();
        kuccpsImport.SetRange("KUCCPS Batch", Rec."Mail Batch");
        kuccpsImport.SetRange(Notified, FALSE);
        kuccpsImport.SetFilter(Email, '<>%1', '');
        if kuccpsImport.FindSet() then begin
            repeat

                TempBlob.CreateOutStream(AttachmentOutStream);

                Report.SaveAs(51343, kuccpsImport.Index, ReportFormat::Pdf, AttachmentOutStream);

                TempBlob.CreateInStream(AttachmentInStream);

                SendMail.Create(kuccpsImport.Email, EmailSubject, EmailBody);

                SendMail.AddAttachment(kuccpsImport.Names + '.pdf', 'PDF', AttachmentInStream);

                emailObj.Send(SendMail);

                emailObj.Send(SendMail, Enum::"Email Scenario"::Default);

                kuccpsImport.Notified := true;
                kuccpsImport.Modify();

            until kuccpsImport.Next() = 0;

        end
        else
            Message('Batch Not Found In KUCCP List');

    end;


}