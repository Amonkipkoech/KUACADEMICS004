codeunit 40004  "Admissions Notification Action"

{
    procedure NotifyAdmissionsRequestStatus(RequestID: Code[20])
    var
        AdmissionsRequest: Record "ACA-Applic. Form Header";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Subject: Text;
        MessageBody: Text;
        Recipients: List of [Text];
        Result: Boolean;
        CurrentDate: Date;
    begin
        CurrentDate := Today();

        if not AdmissionsRequest.Get(RequestID) then begin
            Message('No request found with ID: %1', RequestID);
            exit;
        end;

        // Notify Student if Status is Pending Approval
        if AdmissionsRequest.Status = AdmissionsRequest.Status::"Pending Approval" then begin
            if AdmissionsRequest.Email <> '' then begin
                Recipients.Add(AdmissionsRequest.Email);

                Subject := 'Admissions Request Pending Approval';
                MessageBody :=
                    StrSubstNo(
                        'Dear %1 %2 %3,<br>Your admissions request with ID <b>%4</b> is now pending approval.<br>We will notify you once a decision is made.<br>Thank you.',
                        AdmissionsRequest."First Name",
                        AdmissionsRequest."Other Names",
                        AdmissionsRequest.Surname,
                        RequestID
                    );

                EmailMessage.Create(Recipients, Subject, MessageBody, true);
                Result := Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

                if Result then
                    Message('Notification email sent successfully to: %1', AdmissionsRequest.Email)
                else
                    Message('Failed to send notification email to: %1', AdmissionsRequest.Email);
            end else
                Message('No email address found for Student: %1', AdmissionsRequest."First Name");
        end;
    end;
}

