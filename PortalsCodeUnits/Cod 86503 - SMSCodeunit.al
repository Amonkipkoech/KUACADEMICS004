// codeunit 86503 SMSCodeunit
// {
//     var
//         sms: Record SMS;
//         licenseapplic: Record "License Applications";

//     procedure FetchSMS() Msg: Text
//     begin
//         sms.Reset;
//         sms.SetRange("Sent to Server", false);
//         sms.SetRange("Date Entered", Today);
//         if sms.Find('-') then begin
//             repeat
//                 Msg += FORMAT(sms."Entry No.") + '::' + sms."Phone No." + '::' + sms.Message + ':::';
//             until sms.Next = 0;
//         end;
//     end;

//     procedure UpdateSMSStatus(entryno: integer) updated: boolean
//     begin
//         sms.Reset;
//         sms.SetRange("Entry No.", entryno);
//         if sms.Find('-') then begin
//             sms."Sent to Server" := true;
//             sms."Date Sent to Server" := Today;
//             sms."Time Sent to Server" := Time;
//             sms.Modify;
//             updated := true;
//         end;
//     end;

//     procedure CreateSMS() created: boolean
//     begin
//         sms.Init;
//         sms."Phone No." := '0712529700';
//         sms.Message := 'Davie is testing the sms console app!!!';
//         sms.Insert(true);
//         created := true;
//     end;

//     procedure ApplicationIDExists(applicid: Code[20]) msg: Boolean
//     begin
//         licenseapplic.RESET;
//         licenseapplic.SETRANGE("Application ID", applicid);
//         IF licenseapplic.FIND('-') THEN BEGIN
//             msg := TRUE;
//         END;
//     end;

//     procedure InsertLicenseApplication(applicid: Code[20]; name: Text; amt: Decimal; Title: Code[20]; pin: Code[20]; phone: Code[20]; email: Text) msg: Boolean
//     begin
//         licenseapplic.RESET;
//         licenseapplic.SETRANGE("Application ID", applicid);
//         IF NOT licenseapplic.FIND('-') THEN BEGIN
//             licenseapplic.Init;
//             licenseapplic."Application ID" := applicid;
//             licenseapplic."Applicant Name" := name;
//             licenseapplic.Amount := amt;
//             licenseapplic."Application Date" := Today;
//             licenseapplic.Title := title;
//             licenseapplic.PIN_Number := pin;
//             licenseapplic.PhoneNumber := phone;
//             licenseapplic.Email := email;
//             licenseapplic.Insert;
//             msg := TRUE;
//         END;
//     end;
// }
