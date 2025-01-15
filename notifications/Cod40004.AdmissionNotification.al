codeunit 40004 "Admissions Notification Action"

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
                        'Dear %1 %2 %3,<br>Your admissions request with ID <b>%4</b> has been verified by SRO and  now is  pending approval at HoD.<br>We will notify you once a decision is made.<br>Thank you.',
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

    procedure NotifyAdmissionsRequestSuccessful(RequestID: Code[20])
    var
        AdmissionsRequest: Record "ACA-Applic. Form Header";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Subject: Text;
        MessageBody: Text;
        Recipients: List of [Text];
        Result: Boolean;
        CurrentDate: Date;
        ReportingDate: Date;
        CompletionDate: Date;
    begin
        CurrentDate := Today();

        if not AdmissionsRequest.Get(RequestID) then begin
            Message('No request found with ID: %1', RequestID);
            exit;
        end;

        // Get reporting and completion dates (assuming they are calculated based on admission date)
        ReportingDate := AdmissionsRequest."Date Letter of admission";
        CompletionDate := ReportingDate + 365; // Example, assume 1 year duration for the program

        // Prepare email notification
        if AdmissionsRequest.Email <> '' then begin
            Recipients.Add(AdmissionsRequest.Email);

            Subject := 'Your Admission Has Been Successful';
            MessageBody :=
                StrSubstNo(
                    'Dear %1 %2 %3,<br>Your application for the %4 program under the %5 intake has been successfully processed.<br>Your admission number is <b>%6</b>.<br>The reporting date is <b>%7</b>, and your expected completion date is <b>%8</b>.<br>Congratulations and welcome to the Kenyatta University Teaching, Referral & Research Hospital (KUTRRH)!',
                    AdmissionsRequest."First Name",
                    AdmissionsRequest."Other Names",
                    AdmissionsRequest.Surname,
                    AdmissionsRequest."First Degree Choice",
                    AdmissionsRequest."Intake Code",
                    AdmissionsRequest."Admission No",
                    ReportingDate,
                    CompletionDate
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


    procedure NotifyAdmissionsRequestmylist(RequestID: Code[20])
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
        if AdmissionsRequest.Status = AdmissionsRequest.Status::Open then begin
            if AdmissionsRequest.Email <> '' then begin
                Recipients.Add(AdmissionsRequest.Email);

                Subject := 'Admissions Request Pending Approval';
                MessageBody :=
                    StrSubstNo(
                        'Dear %1 %2 %3,<br>Your Application request with ID <b>%4</b> has been received and    now is  pending approval at Student Recruitment Office for document verification.<br>We will notify you once a decision is made.<br>Thank you.',
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

    procedure NotifyApplicantSuccessfulSubmission(RequestID: Code[20])
    var
        AdmissionsRequest: Record "ACA-Applic. Form Header";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Subject: Text;
        MessageBody: Text;
        Recipients: List of [Text];
        Result: Boolean;
    begin
        if not AdmissionsRequest.Get(RequestID) then begin
            Message('No request found with ID: %1', RequestID);
            exit;
        end;

        // Notify the applicant about successful submission
        if AdmissionsRequest.Email <> '' then begin
            Recipients.Add(AdmissionsRequest.Email);

            Subject := 'Application Received - Awaiting Processing';
            MessageBody :=
                StrSubstNo(
                    'Dear %1 %2 %3,<br>Your application with ID <b>%4</b> has been successfully submitted and is awaiting processing.<br>We will notify you of the next steps.<br>Thank you for applying.',
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
            Message('No email address found for Applicant: %1', AdmissionsRequest."First Name");
    end;

    procedure NotifyIctSuccessfulAccountCreation(RequestID: Code[20])
    var
        AdmissionsRequest: Record "ACA-Applic. Form Header";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Subject: Text;
        EmailBody: Text;
        Recipient: Text;
        Result: Boolean;
    begin
        // Fetch the admissions request by RequestID
        if not AdmissionsRequest.Get(RequestID) then begin
            Message('No request found with ID: %1', RequestID);
            exit;
        end;

        // Ensure the admission number exists
        if AdmissionsRequest."Admission No" = '' then begin
            Message('Admission number is missing for Request ID: %1', RequestID);
            exit;
        end;

        // Prepare email content
        Recipient := 'amonkiprop68@gmail.com';
        Subject := 'Student Portal Account Created';
        EmailBody := StrSubstNo(
            'Dear ICT,\n\n' +
            'The following student account has been created:\n' +
            'Admission Number: %1\n\n' +
            'The student can access the student portal using the admission number as their username and the default password. ' +
            'They will be prompted to change their password to a strong one upon first login.\n\n' +
            'Regards,\n' +
            'Admissions Department',
            AdmissionsRequest."Admission No"
        );

        // Create and send the email
        EmailMessage.Create(Recipient, Subject, EmailBody, true); // Plain text email
        Result := Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

        // Handle the result of the email send action
        if Result then
            Message('Notification email sent successfully to ICT.')
        else
            Message('Failed to send notification email to ICT.');
    end;



}

