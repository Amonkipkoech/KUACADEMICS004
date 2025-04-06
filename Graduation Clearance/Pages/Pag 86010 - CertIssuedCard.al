page 86010 "Cert Issued Card"
{
    Caption = 'Cert Issued Card';
    PageType = Card;
    SourceTable = "Certificate Issuance";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    Editable = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student No. field.', Comment = '%';
                }
                field("Student Name"; Rec."Student Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student Name field.', Comment = '%';
                }
                field("Student Email"; Rec."Student Email")
                {
                    ApplicationArea = All;
                }
                field(School; Rec.School)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the School field.', Comment = '%';
                }
                field(Department; Rec.Department)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department field.', Comment = '%';
                }
                field("Certificate No"; Rec."Certificate No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Certificate No field.', Comment = '%';
                }
                field("Date Issued"; Rec."Date Issued")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Issued field.', Comment = '%';
                }
                field("Certificate Issued Date"; Rec."Certificate Issued Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Certificate Issued Date field.', Comment = '%';
                }
                field("Certficate issued By"; Rec."Certficate issued By")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Certficate issued By field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Post Allocation")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                Image = Post;
                trigger OnAction()
                begin
                    if Rec."Certificate No" = '' then
                        Error('Certificate No Must Have a Value') else begin
                        Rec."Certficate issued By" := UserId;
                        Rec.Issued := true;
                        Rec."Date Issued" := Today;
                        Rec."Certificate Issued Date" := CurrentDateTime;
                        Rec.Modify();
                        Send();
                        Message('Certificate Issued Successfully!');
                    end;

                end;
            }
            action("Send Certificate Mail")
            {
                ApplicationArea = all;
                Image = Email;
                PromotedCategory = Report;
                Promoted = true;
                trigger OnAction()
                var
                    EmailMsg: Codeunit "Email Message";
                    Email: Codeunit Email;
                    ToRecipients: List of [Text];
                    Subject: Text[100];
                    Body: Text;
                    StudentRec: Record "Certificate Issuance";
                    OutStr: OutStream;
                    InStr: InStream;
                    TempBlob: Codeunit "Temp Blob";
                    FileName: Text[250];
                begin
                    // Fetch Student Record
                    IF Rec.GET(Rec."No.") THEN BEGIN
                        // Generate Certificate PDF
                        TempBlob.CreateOutStream(OutStr);
                        //REPORT.SAVEAS(REPORT::"Student Fee Statement", ReportFormat::Pdf, OutStr, Rec); // ✅ FIXED

                        TempBlob.CreateInStream(InStr);
                        FileName := 'Certificate_' + Rec."Student No." + '.pdf';

                        // Get Student Email
                        IF Rec."Student Email" <> '' THEN BEGIN
                            // Prepare Email
                            ToRecipients.Add(Rec."Student Email");
                            Subject := 'Certificate for ' + Rec."Student No.";
                            Body := 'Dear ' + Rec."Student No." + ',<br><br>' +
                                    'Please find attached your certificate.<br><br>' +
                                    'Regards,<br><br>' +
                                    '<font size="2" color="red">This is a system-generated message. Please do not reply.</font>';

                            // Create Email Message
                            // EmailMsg.Create(ToRecipients, Subject, Body, true);
                            // EmailMsg.AddAttachment(FileName, InStr, 'application/pdf'); // ✅ FIXED

                            // Send Email
                            Email.Send(EmailMsg, Enum::"Email Scenario"::Notification);
                            MESSAGE('Mail has been sent successfully.');
                        END ELSE
                            ERROR('Student does not have a valid email.');
                    END ELSE
                        ERROR('No record found for the student.');
                end;
            }





        }
    }
    local procedure Send()
    var
        salutation: Text[50];
        FileMgt: Codeunit "File Management";
        hrEmp: Record "HRM-Employee (D)";
        progLeader: text;
        mail: Text;
        EmailSubject: Text[50];
        EmailBody: Text[800];
        EmailRecipient: List of [Text];
        SendMail: Codeunit "Email Message";
        emailObj: Codeunit Email;
    begin

        Clear(EmailBody);
        Clear(EmailSubject);
        Clear(mail);
        EmailSubject := 'CERTIFICATE ISSUANCE NOTIFICATION';
        mail := Rec."Student Email";
        EmailBody := 'Dear,' + ' ' + Rec."Student Name" + ' ' + 'Please note that your certificate No' + ' ' + Rec."Certificate No" + ' ' + 'has been issued succeffully.';
        SendMail.Create(mail, EmailSubject, EmailBody);
        emailObj.Send(SendMail, Enum::"Email Scenario"::Notification);
    end;
}
