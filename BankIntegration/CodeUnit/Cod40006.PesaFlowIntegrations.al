codeunit 40006 "PesaFlow Integration"
{
    var
        PesaflowIntegration: Record "PesaFlow Integration";
        PesaFlowInvoices: Record "PesaFlow Invoices";
        Cust: Record Customer;
        KUCCPSRaw: Record "KUCCPS Imports";
        licenseapplic: Record "License Applications";
        stdclearance: Record "Student Clerance";
        ApprovalsMgmt: Codeunit "Approval Mgnt. Util.";

    procedure InsertApplicationFee(paymentrefid: Code[50]; customerrefno: Code[20]; invoiceno: Code[20]; invoiceamt: Decimal; paidamt: Decimal; paymentchannel: Text; paymentdate: Text; status: Text) inserted: Boolean
    var
        applicheader: Record "ACA-Applic. Form Header";
        pesaflowserviceCodes: Record "E-Citizen Services";
    begin
        applicheader.RESET;
        applicheader.SETRANGE("Application No.", customerrefno);
        IF applicheader.FIND('-') THEN BEGIN
            PesaFlowIntegration.RESET;
            PesaFlowIntegration.SETRANGE(PaymentRefID, paymentrefid);
            IF NOT PesaFlowIntegration.FIND('-') THEN BEGIN
                PesaFlowIntegration.INIT;
                PesaFlowIntegration.PaymentRefID := paymentrefid;
                PesaFlowIntegration.CustomerRefNo := applicheader."Application No.";
                PesaFlowIntegration."Customer Name" := applicheader."First Name";
                PesaFlowIntegration.InvoiceNo := invoiceno;
                PesaFlowIntegration.InvoiceAmount := invoiceamt;
                PesaFlowIntegration.PaidAmount := paidamt;
                PesaFlowIntegration.ServiceID := '4914862';
                PesaFlowIntegration.Description := 'Payment for course application fee';
                PesaFlowIntegration.PaymentChannel := paymentchannel;
                PesaFlowIntegration.PaymentDate := paymentdate;
                PesaFlowIntegration.Status := status;
                PesaFlowIntegration."Date Received" := TODAY;
                PesaFlowIntegration.INSERT;
                inserted := TRUE;
            END ELSE BEGIN
                ERROR('invalid transaction id');
            END;
            if inserted then begin
                applicheader."Finance Cleared" := true;
                applicheader.Modify;
            end;
        END ELSE BEGIN
            ERROR('invalid invoice');
        END
    end;


    procedure ApplicationIDExists(applicid: Code[20]) msg: Boolean
    begin
        licenseapplic.RESET;
        licenseapplic.SETRANGE("Application ID", applicid);
        IF licenseapplic.FIND('-') THEN BEGIN
            msg := TRUE;
        END;
    end;

    procedure InsertLicenseApplication(applicid: Code[20]; name: Text; amt: Decimal) msg: Boolean
    begin
        licenseapplic.RESET;
        licenseapplic.SETRANGE("Application ID", applicid);
        IF NOT licenseapplic.FIND('-') THEN BEGIN
            licenseapplic.Init;
            licenseapplic."Application ID" := applicid;
            licenseapplic."Applicant Name" := name;
            licenseapplic.Amount := amt;
            licenseapplic."Application Date" := Today;
            licenseapplic.Insert;
            msg := TRUE;
        END;
    end;

    procedure PesaFlowTransExists(refid: Code[20]) msg: Boolean
    begin
        PesaFlowIntegration.RESET;
        PesaFlowIntegration.SETRANGE(PaymentRefID, refid);
        IF PesaFlowIntegration.FIND('-') THEN BEGIN
            msg := TRUE;
        END;
    end;

    procedure StaffCafeteriaPyments(paymentrefid: Code[50]; customerrefno: Code[20]; invoiceno: Code[20]; invoiceamt: Decimal; paidamt: Decimal; paymentchannel: Text; paymentdate: Text; status: Text) inserted: Boolean
    begin
        PesaFlowIntegration.RESET;
        PesaFlowIntegration.SETRANGE(PaymentRefID, paymentrefid);
        IF NOT PesaFlowIntegration.FIND('-') THEN BEGIN
            PesaFlowIntegration.INIT;
            PesaFlowIntegration.PaymentRefID := paymentrefid;
            PesaFlowIntegration.CustomerRefNo := customerrefno;
            PesaFlowIntegration.InvoiceNo := invoiceno;
            PesaFlowIntegration.InvoiceAmount := invoiceamt;
            PesaFlowIntegration.PaidAmount := paidamt;
            PesaFlowIntegration.ServiceID := '7745980';
            PesaFlowIntegration.PaymentChannel := paymentchannel;
            PesaFlowIntegration.PaymentDate := paymentdate;
            PesaFlowIntegration.Status := status;
            PesaFlowIntegration."Date Received" := TODAY;
            PesaFlowIntegration.INSERT;
            inserted := TRUE;
            //Post
        END ELSE BEGIN
            ERROR('invalid transaction id');
        END;
    end;

    procedure UniversityFarmPayments(paymentrefid: Code[50]; customerrefno: Code[20]; invoiceno: Code[20]; invoiceamt: Decimal; paidamt: Decimal; paymentchannel: Text; paymentdate: Text; status: Text) inserted: Boolean
    begin
        PesaFlowIntegration.RESET;
        PesaFlowIntegration.SETRANGE(PaymentRefID, paymentrefid);
        IF NOT PesaFlowIntegration.FIND('-') THEN BEGIN
            PesaFlowIntegration.INIT;
            PesaFlowIntegration.PaymentRefID := paymentrefid;
            PesaFlowIntegration.CustomerRefNo := customerrefno;
            PesaFlowIntegration.InvoiceNo := invoiceno;
            PesaFlowIntegration.InvoiceAmount := invoiceamt;
            PesaFlowIntegration.PaidAmount := paidamt;
            PesaFlowIntegration.ServiceID := '7745910';
            PesaFlowIntegration.PaymentChannel := paymentchannel;
            PesaFlowIntegration.PaymentDate := paymentdate;
            PesaFlowIntegration.Status := status;
            PesaFlowIntegration."Date Received" := TODAY;
            PesaFlowIntegration.INSERT;
            inserted := TRUE;
            //Post
        END ELSE BEGIN
            ERROR('invalid transaction id');
        END;
    end;

    procedure PostPesaFlowTrans(paymentrefid: Code[50]; customerrefno: Code[20]; invoiceno: Code[20]; invoiceamt: Decimal; paidamt: Decimal; paymentchannel: Text; paymentdate: Text; status: Text) inserted: Boolean
    begin
        PesaFlowInvoices.RESET;
        PesaFlowInvoices.SETRANGE(BillRefNo, customerrefno);
        IF PesaFlowInvoices.FIND('-') THEN BEGIN
            PesaFlowIntegration.RESET;
            PesaFlowIntegration.SETRANGE(PaymentRefID, paymentrefid);
            IF NOT PesaFlowIntegration.FIND('-') THEN BEGIN
                PesaFlowIntegration.INIT;
                PesaFlowIntegration.PaymentRefID := paymentrefid;
                PesaFlowIntegration.CustomerRefNo := PesaFlowInvoices.CustomerRefNo;
                PesaFlowIntegration."Customer Name" := PesaFlowInvoices.CustomerName;
                PesaFlowIntegration.InvoiceNo := invoiceno;
                PesaFlowIntegration.InvoiceAmount := invoiceamt;
                PesaFlowIntegration.PaidAmount := paidamt;
                PesaFlowIntegration.ServiceID := PesaFlowInvoices.ServiceID;
                PesaFlowIntegration.Description := PesaFlowInvoices.Description;
                PesaFlowIntegration.PaymentChannel := paymentchannel;
                PesaFlowIntegration.PaymentDate := paymentdate;
                PesaFlowIntegration.Status := status;
                PesaFlowIntegration."Date Received" := TODAY;
                PesaFlowIntegration.INSERT;
                inserted := TRUE;
                Cust.Reset();
                Cust.SetRange("No.", PesaFlowInvoices.CustomerRefNo);
                if Cust.Find('-') then begin
                    PostPesaFlow(PesaFlowIntegration);
                    stdclearance.Reset;
                    stdclearance.SetRange("Clearance No", customerrefno);
                    if stdclearance.Find('-') then begin
                        If ApprovalsMgmt.CheckstudentClearanceWorkflowEnable(stdClearance) then
                            ApprovalsMgmt.OnSendstudentClearanceForApproval(stdClearance);
                    end;
                end else begin
                    KUCCPSRaw.Reset;
                    KUCCPSRaw.SetRange(Admin, PesaFlowInvoices.CustomerRefNo);
                    if KUCCPSRaw.Find('-') then begin
                        //Admit the student and post the payment....
                        //TransferToAdmission(PesaFlowInvoices.CustomerRefNo);
                        //Post to students Ledger
                        PostPesaFlow(PesaFlowIntegration);
                    end;
                end;
            END ELSE BEGIN
                ERROR('invalid transaction id');
            END;
        END ELSE BEGIN
            ERROR('invalid invoice');

        END
    end;

    procedure InsertAccommodationFee(paymentrefid: Code[50]; customerrefno: Code[20]; invoiceno: Code[20]; invoiceamt: Decimal; paidamt: Decimal; paymentchannel: Text; paymentdate: Text; status: Text) inserted: Boolean
    var
        accommodationBooking: Record "Accomodation and Booking";
    begin
        accommodationBooking.RESET;
        accommodationBooking.SETRANGE(BillRefNo, customerrefno);
        IF accommodationBooking.FIND('-') THEN BEGIN
            PesaFlowIntegration.RESET;
            PesaFlowIntegration.SETRANGE(PaymentRefID, paymentrefid);
            IF NOT PesaFlowIntegration.FIND('-') THEN BEGIN
                PesaFlowIntegration.INIT;
                PesaFlowIntegration.PaymentRefID := paymentrefid;
                PesaFlowIntegration.CustomerRefNo := accommodationBooking.StudentNo;
                PesaFlowIntegration."Customer Name" := accommodationBooking.StudentName;
                PesaFlowIntegration.InvoiceNo := invoiceno;
                PesaFlowIntegration.InvoiceAmount := invoiceamt;
                PesaFlowIntegration.PaidAmount := paidamt;
                PesaFlowIntegration.ServiceID := accommodationBooking.ServiceCode;
                PesaFlowIntegration.Description := accommodationBooking.Description;
                PesaFlowIntegration.PaymentChannel := paymentchannel;
                PesaFlowIntegration.PaymentDate := paymentdate;
                PesaFlowIntegration.Status := status;
                PesaFlowIntegration."Date Received" := TODAY;
                PesaFlowIntegration.INSERT;
                if paidamt = accommodationBooking.SpaceCost then begin
                    BookHostel(accommodationBooking.StudentNo, accommodationBooking.HostelNo, accommodationBooking.Semester, accommodationBooking."Academic Year", accommodationBooking.RoomNo, accommodationBooking.SpaceCost, accommodationBooking.SpaceNo, accommodationBooking.SpaceCost);
                    PostPesaFlow(PesaflowIntegration);
                end;
                inserted := TRUE;
            END ELSE BEGIN
                ERROR('invalid transaction id');
            END;
        END ELSE BEGIN
            ERROR('invalid invoice');

        END
    end;

    procedure InsertGraduationFee(paymentrefid: Code[50]; customerrefno: Code[20]; invoiceno: Code[20]; invoiceamt: Decimal; paidamt: Decimal; paymentchannel: Text; paymentdate: Text; status: Text) inserted: Boolean
    var
        stdClearance: Record "Student Clerance";
    begin
        stdClearance.RESET;
        stdClearance.SETRANGE("Clearance No", customerrefno);
        IF stdClearance.FIND('-') THEN BEGIN
            PesaFlowIntegration.RESET;
            PesaFlowIntegration.SETRANGE(PaymentRefID, paymentrefid);
            IF NOT PesaFlowIntegration.FIND('-') THEN BEGIN
                PesaFlowIntegration.INIT;
                PesaFlowIntegration.PaymentRefID := paymentrefid;
                PesaFlowIntegration.CustomerRefNo := stdClearance."Student No";
                PesaFlowIntegration."Customer Name" := stdClearance."Student Name ";
                PesaFlowIntegration.InvoiceNo := invoiceno;
                PesaFlowIntegration.InvoiceAmount := invoiceamt;
                PesaFlowIntegration.PaidAmount := paidamt;
                PesaFlowIntegration.ServiceID := '5362265';
                PesaFlowIntegration.Description := 'Payment for graduation services';
                PesaFlowIntegration.PaymentChannel := paymentchannel;
                PesaFlowIntegration.PaymentDate := paymentdate;
                PesaFlowIntegration.Status := status;
                PesaFlowIntegration."Date Received" := TODAY;
                PesaFlowIntegration.INSERT;
                stdClearance."Graduation Fee Paid" := true;
                stdClearance.Modify;
                inserted := TRUE;
            END ELSE BEGIN
                ERROR('invalid transaction id');
            END;
        END ELSE BEGIN
            ERROR('invalid invoice');

        END
    end;

    procedure BookHostel(studentNo: Text; MyHostelNo: Text; MySemester: Text; MyAcademicYear: Text; myRoomNo: Text; MyAccomFee: Decimal; mySpaceNo: Text; MyspaceCost: Decimal) ReturnMessage: Text
    var
        HostelRooms: Record "ACA-Students Hostel Rooms";
        HostelRooms1: Record "ACA-Students Hostel Rooms";
        RoomSpaces: Record "ACA-Room Spaces";
    //StudentNotifications: Codeunit StudentNotifications;
    begin
        HostelRooms1.RESET;
        HostelRooms1.SETRANGE(HostelRooms1.Student, studentNo);
        HostelRooms1.SETRANGE(HostelRooms1.Semester, MySemester);
        IF NOT HostelRooms1.FIND('-') THEN BEGIN
            HostelRooms.INIT;
            HostelRooms.Student := studentNo;
            HostelRooms.Charges := MyspaceCost;
            HostelRooms."Space No" := mySpaceNo;
            HostelRooms."Room No" := myRoomNo;
            HostelRooms."Hostel No" := MyHostelNo;
            HostelRooms."Accomodation Fee" := MyAccomFee;
            HostelRooms."Allocation Date" := TODAY;
            HostelRooms.Semester := MySemester;
            HostelRooms."Academic Year" := MyAcademicYear;
            HostelRooms.Billed := true;


            HostelRooms.INSERT;

            RoomSpaces.RESET;
            RoomSpaces.SETRANGE(RoomSpaces."Space Code", mySpaceNo);
            IF RoomSpaces.FIND('-') THEN BEGIN
                RoomSpaces.Booked := TRUE;
                RoomSpaces.Status := RoomSpaces.Status::"Fully Booked";
                RoomSpaces.VALIDATE(RoomSpaces."Space Code");
                RoomSpaces.MODIFY;
                // Notify the student of the successful booking
                postCharge(HostelRooms);
                //StudentNotifications.SendBookingNotification(studentNo, mySpaceNo, myRoomNo, MyHostelNo, MySemester);
                ReturnMessage := 'You have successfully booked ' + mySpaceNo + ' space::';



            END
            ELSE BEGIN
                ReturnMessage := 'You have already booked ' + mySpaceNo + ' space::';
            END
        END;
    end;





    procedure PostPesaFlowPayBillTrans(paymentrefid: Code[50]; customerrefno: Code[20]; invoiceno: Code[20]; invoiceamt: Decimal; paidamt: Decimal; paymentchannel: Text; paymentdate: Text; status: Text) inserted: Boolean
    begin
        PesaFlowIntegration.RESET;
        PesaFlowIntegration.SETRANGE(PaymentRefID, paymentrefid);
        IF NOT PesaFlowIntegration.FIND('-') THEN BEGIN
            PesaFlowIntegration.INIT;
            PesaFlowIntegration.PaymentRefID := paymentrefid;
            PesaFlowIntegration.CustomerRefNo := customerrefno;
            PesaFlowIntegration.InvoiceNo := invoiceno;
            PesaFlowIntegration.InvoiceAmount := invoiceamt;
            PesaFlowIntegration.PaidAmount := paidamt;
            PesaFlowIntegration.PaymentChannel := paymentchannel;
            PesaFlowIntegration.PaymentDate := paymentdate;
            PesaFlowIntegration.Status := status;
            PesaFlowIntegration."Date Received" := TODAY;
            PesaFlowIntegration.INSERT;
            inserted := TRUE;
            //Post;
        END ELSE BEGIN
            ERROR('invalid transaction id');
        END;
    end;

    procedure PostPesaFlow(ecitizen: Record "PesaFlow Integration")
    var
        pflow: Record "PesaFlow Integration";
        bsetup: Record "E-Citizen Services";
        StudPay: Record "ACA-Std Payments";
        PaymentProcessor: Codeunit "KU Payment Processor";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        StudentRec: Record Customer; // Replace with 'Student' if you use a custom table
    begin
        pflow.RESET;
        pflow.SETRANGE(Posted, FALSE);
        pflow.SETRANGE(PaymentRefID, ecitizen.PaymentRefID);

        IF pflow.FIND('-') THEN BEGIN
            // Delete old student payment if exists
            StudPay.RESET;
            StudPay.SETRANGE(StudPay."Student No.", pflow.CustomerRefNo);
            IF StudPay.FIND('-') THEN
                StudPay.DELETEALL;

            // Insert new student payment
            StudPay.INIT;
            StudPay."Student No." := pflow.CustomerRefNo;
            StudPay."User ID" := USERID;
            StudPay."Payment Mode" := StudPay."Payment Mode"::"Direct Bank Deposit";
            StudPay."Cheque No" := pflow.PaymentRefID;
            StudPay."Drawer Name" := pflow."Customer Name";
            StudPay."Payment By" := pflow."Customer Name";

            bsetup.RESET;
            bsetup.SETRANGE("Service Code", pflow.ServiceID);
            IF bsetup.FIND('-') THEN
                StudPay."Bank No." := bsetup."Bank Code"
            ELSE
                ERROR('%1%2%3', 'Service ID ', pflow.ServiceID, ' has not been setup with an associated bank');

            StudPay."Amount to pay" := pflow.PaidAmount;
            StudPay.VALIDATE(StudPay."Amount to pay");
            StudPay."Transaction Date" := pflow."Date Received";
            StudPay.INSERT;

            // ✅ Post to General Journal automatically using KU Payment Processor
            PaymentProcessor.ProcessPayment(
                pflow.PaymentRefID,
                pflow.CustomerRefNo,
                pflow.PaidAmount,
                pflow."Customer Name",
                bsetup."Bank Code"
            );
            // Email notification
            if StudentRec.Get(pflow.CustomerRefNo) then begin
                if StudentRec."E-Mail" <> '' then begin
                    Recipients.Add(StudentRec."E-Mail");
                    EmailMessage.Create(
                        Recipients,
                        'Payment Received',
                        StrSubstNo(
                            'Dear %1, we have received your payment of KES %2 on %3. Kindly check your clearance status.',
                            StudentRec.Name,
                            Format(pflow.PaidAmount),
                            Format(pflow."Date Received")
                        ),
                        true // isHTML
                    );
                    if not Email.Send(EmailMessage, Enum::"Email Scenario"::Default) then
                        Message('⚠️ Failed to send email to %1', StudentRec."E-Mail");
                end else
                    Message('⚠️ No email address found for student %1 (%2)', StudentRec.Name, StudentRec."No.");
            end else
                Message('⚠️ Student with No. %1 not found in Customer table.', pflow.CustomerRefNo);



            // Mark PesaFlow as posted
            pflow.Posted := TRUE;
            pflow.MODIFY;
        END;
    end;



    Procedure PostBatchPesaFlow()
    var
        pflow: Record "PesaFlow Integration";
        bsetup: Record "E-Citizen Services";
        StudPay: Record "ACA-Std Payments";
    begin

        if UserId <> 'FRANKIE' then Error('');

        pflow.RESET;
        pflow.SETRANGE(Posted, FALSE);
        IF pflow.FIND('-') THEN BEGIN
            REPEAT

                StudPay.RESET;
                StudPay.SETRANGE(StudPay."Student No.", pflow.CustomerRefNo);
                IF StudPay.FIND('-') THEN
                    StudPay.DELETEALL;

                StudPay.INIT;
                StudPay."Student No." := pflow.CustomerRefNo;
                StudPay."User ID" := USERID;
                StudPay."Payment Mode" := StudPay."Payment Mode"::"Direct Bank Deposit";
                StudPay."Cheque No" := pflow.PaymentRefID;
                StudPay."Drawer Name" := pflow."Customer Name";
                StudPay."Payment By" := pflow."Customer Name";
                bsetup.RESET;
                bsetup.SETRANGE("Service Code", pflow.ServiceID);
                IF bsetup.FIND('-') THEN
                    StudPay."Bank No." := bsetup."Bank Code"
                ELSE
                    ERROR('%1%2%3', 'Service ID ', pflow.ServiceID, ' has not been setup with an associated bank');
                if pflow.PaidAmount > 50 then
                    StudPay."Amount to pay" := pflow.PaidAmount - 50
                else
                    StudPay."Amount to pay" := pflow.PaidAmount;
                StudPay.VALIDATE(StudPay."Amount to pay");
                StudPay."Transaction Date" := pflow."Date Received";
                // StudPay.VALIDATE(StudPay."Auto Post PesaFlow");
                StudPay.INSERT;
                pflow.Posted := TRUE;
                pflow.MODIFY;
            until pflow.Next() = 0;
        end;

        Message('Complete');
    end;


    procedure TakeStudentToRegistration(AdmissNo: Code[20])
    var
        Admissions: Record "ACA-Adm. Form Header";
        AdminKin: Record "ACA-Adm. Form Next of Kin";
        StudentKin: Record "ACA-Student Kin";
        StudentGuardian: Record "ACA-Student Sponsors Details";
    begin
        Admissions.Reset;
        Admissions.SetRange("Admission No.", AdmissNo);
        if Admissions.Find('-') then begin

            //insert the details related to the next of kin of the student into the database
            AdminKin.Reset;
            AdminKin.SetRange(AdminKin."Admission No.", Admissions."Admission No.");
            if AdminKin.Find('-') then begin
                repeat
                    StudentKin.Reset;
                    StudentKin.Init;
                    StudentKin."Student No" := Admissions."Admission No.";
                    StudentKin.Relationship := AdminKin.Relationship;
                    StudentKin.Name := AdminKin."Full Name";
                    StudentKin."Office Tel No" := AdminKin."Telephone No. 1";
                    StudentKin."Home Tel No" := AdminKin."Telephone No. 2";
                    StudentKin.Insert;
                until AdminKin.Next = 0;
            end;

            //insert the details in relation to the guardian/sponsor into the database in relation to the current student
            if Admissions."Mother Alive Or Dead" = Admissions."Mother Alive Or Dead"::Alive then begin
                if Admissions."Mother Full Name" <> '' then begin
                    StudentGuardian.Reset;
                    StudentGuardian.Init;
                    StudentGuardian."Student No." := Admissions."Admission No.";
                    StudentGuardian.Names := Admissions."Mother Full Name";
                    StudentGuardian.Insert;
                end;
            end;
            if Admissions."Father Alive Or Dead" = Admissions."Father Alive Or Dead"::Alive then begin
                if Admissions."Father Full Name" <> '' then begin
                    StudentGuardian.Reset;
                    StudentGuardian.Init;
                    StudentGuardian."Student No." := Admissions."Admission No.";
                    StudentGuardian.Names := Admissions."Father Full Name";
                    StudentGuardian.Insert;
                end;
            end;
            if Admissions."Guardian Full Name" <> '' then begin
                if Admissions."Guardian Full Name" <> '' then begin
                    StudentGuardian.Reset;
                    StudentGuardian.Init;
                    StudentGuardian."Student No." := Admissions."Admission No.";
                    StudentGuardian.Names := Admissions."Guardian Full Name";
                    StudentGuardian.Insert;
                end;
            end;
        end;
    end;



    Procedure postCharge(HostelRooms: Record "ACA-Students Hostel Rooms")
    var
        charges1: Record "ACA-Charge";
        StudentCharges: Record "ACA-Std Charges";
        GenSetUp: Record "ACA-General Set-Up";
        CustPostGroup: Record "Customer Posting Group";
        Stages: Record "ACA-Programme Stages";
        NoSeries: Record "No. Series Line";
        prog: Record "ACA-Programme";
        "Billed Date": Date;
        ExamsByStage: Record "ACA-Exams";
        CReg: Record "ACA-Course Registration";
        GenJnl: Record "Gen. Journal Line";
        ExamsByUnit: Record "ACA-Exams By Units";
        Billed: Boolean;
        DueDate: Date;
        LastNo: Code[20];
        AccPayment: Boolean;
    begin
        //BILLING
        charges1.RESET;
        charges1.SETRANGE(charges1.Hostel, TRUE);
        IF NOT charges1.FIND('-') THEN BEGIN
            ERROR('The charges Setup does not have an item tagged as Hostel.');
        END;

        AccPayment := FALSE;
        StudentCharges.RESET;
        StudentCharges.SETRANGE(StudentCharges."Student No.", HostelRooms.Student);
        StudentCharges.SETRANGE(StudentCharges.Recognized, FALSE);
        StudentCharges.SETFILTER(StudentCharges.Code, '=%1', charges1.Code);
        IF NOT StudentCharges.FIND('-') THEN BEGIN //3
                                                   // The charge does not exist. Created it, but check first if it exists as unrecognized
            StudentCharges.RESET;
            StudentCharges.SETRANGE(StudentCharges."Student No.", HostelRooms.Student);
            //StudentCharges.SETRANGE(StudentCharges.Recognized,FALSE);
            StudentCharges.SETFILTER(StudentCharges.Code, '=%1', charges1.Code);
            IF NOT StudentCharges.FIND('-') THEN BEGIN //4
                                                       // Does not exist hence just create
                CReg.RESET;
                CReg.SETRANGE(CReg."Student No.", HostelRooms.Student);
                CReg.SETRANGE(CReg.Semester, HostelRooms.Semester);
                IF CReg.FIND('-') THEN BEGIN //5
                    GenSetUp.GET();
                    IF GenSetUp.FIND('-') THEN BEGIN  //6
                        NoSeries.RESET;
                        NoSeries.SETRANGE(NoSeries."Series Code", GenSetUp."Transaction Nos.");
                        IF NoSeries.FIND('-') THEN BEGIN // 7
                            LastNo := NoSeries."Last No. Used"
                        END;  // 7
                    END; // 6
                         //message(LastNo);
                    LastNo := INCSTR(LastNo);
                    NoSeries."Last No. Used" := LastNo;
                    NoSeries.MODIFY;
                    StudentCharges.INIT();
                    StudentCharges."Transacton ID" := LastNo;
                    StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                    StudentCharges."Student No." := HostelRooms.Student;
                    StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::Charges;
                    StudentCharges."Reg. Transacton ID" := CReg."Reg. Transacton ID";
                    StudentCharges.Description := 'Hostel Charges ';
                    StudentCharges.Amount := HostelRooms.Charges;
                    StudentCharges.Date := TODAY;
                    StudentCharges.Code := charges1.Code;
                    StudentCharges.Charge := TRUE;
                    StudentCharges.INSERT(TRUE);
                    Billed := TRUE;
                    "Billed Date" := TODAY;


                END; //5

            END ELSE BEGIN//4
                          // Charge Exists, Delete from the charges then create a new one
                StudentCharges.DELETE;

                CReg.RESET;
                CReg.SETRANGE(CReg."Student No.", HostelRooms.Student);
                CReg.SETRANGE(CReg.Semester, HostelRooms.Semester);
                IF CReg.FIND('-') THEN BEGIN //5
                    GenSetUp.GET();
                    IF GenSetUp.FIND('-') THEN BEGIN  //6
                        NoSeries.RESET;
                        NoSeries.SETRANGE(NoSeries."Series Code", GenSetUp."Transaction Nos.");
                        IF NoSeries.FIND('-') THEN BEGIN // 7
                            LastNo := NoSeries."Last No. Used"
                        END;  // 7
                    END; // 6
                         //message(LastNo);
                    LastNo := INCSTR(LastNo);
                    NoSeries."Last No. Used" := LastNo;
                    NoSeries.MODIFY;
                    StudentCharges.INIT();
                    StudentCharges."Transacton ID" := LastNo;
                    StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                    StudentCharges."Student No." := HostelRooms.Student;
                    StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::Charges;
                    StudentCharges."Reg. Transacton ID" := CReg."Reg. Transacton ID";
                    StudentCharges.Description := 'Hostel Charges ';
                    StudentCharges.Amount := HostelRooms.Charges;
                    StudentCharges.Date := TODAY;
                    StudentCharges.Code := charges1.Code;
                    StudentCharges.Charge := TRUE;
                    StudentCharges.INSERT(TRUE);
                    // Billed:=TRUE;
                    // "Billed Date":=TODAY;
                    // MODIFY;
                END; //5
            END;//4

        END; //3


        //SettlementType1:='';
        // CReg.RESET;
        // CReg.SETRANGE(CReg."Student No.", Rec.Student);
        // CReg.SETRANGE(CReg.Semester, Rec.Semester);
        // IF CReg.FIND('-') THEN BEGIN //10
        //                              //"Settlement Type".GET(CReg."Settlement Type");
        //                              //"Settlement Type".TESTFIELD("Settlement Type"."Tuition G/L Account");
        // END // 10
        // ELSE BEGIN // 10.1
        //     ERROR('The Settlement Type Does not Exists in the Course Registration for: ' + Rec.Student);
        // END;//10.1



        /*
        
        // MANUAL APPLICATION OF ACCOMODATION FOR PREPAYED STUDENTS BY Wanjala.....//
        StudentCharges.RESET;
        StudentCharges.SETRANGE(StudentCharges."Student No.",student);
        StudentCharges.SETRANGE(StudentCharges.Recognized,FALSE);
        StudentCharges.SETFILTER(StudentCharges.Code,'=%1',Charges1.Code) ;
        
        IF StudentCharges.COUNT=1 THEN BEGIN
        CALCFIELDS(Balance);
        IF Balance<0 THEN BEGIN
        IF ABS(Balance)>StudentCharges.Amount THEN BEGIN
        "Application Method":="Application Method"::Manual;
        AccPayment:=TRUE;
        MODIFY;
        END;
        END;
        END; */

        //END;


        //ERROR('TESTING '+FORMAT("Application Method"));

        IF Cust.GET(HostelRooms.Student) THEN;

        GenJnl.RESET;
        GenJnl.SETRANGE("Journal Template Name", 'SALES');
        GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
        GenJnl.DELETEALL;

        GenSetUp.GET();
        //GenSetUp.TESTFIELD(GenSetUp."Pre-Payment Account");

        // Charge Student - Accommodation- if not charged
        StudentCharges.RESET;
        StudentCharges.SETRANGE(StudentCharges."Student No.", HostelRooms.Student);
        StudentCharges.SETRANGE(StudentCharges.Recognized, FALSE);
        StudentCharges.SETFILTER(StudentCharges.Code, '=%1', charges1.Code);
        IF StudentCharges.FIND('-') THEN BEGIN

            REPEAT

                DueDate := StudentCharges.Date;
                //IF Sems.GET(StudentCharges.Semester) THEN BEGIN
                //IF Sems.From<>0D THEN BEGIN
                //IF Sems.From > DueDate THEN
                //DueDate:=Sems.From;
                //END;
                //END;
                IF DueDate = 0D THEN DueDate := TODAY;

                GenJnl.INIT;
                GenJnl."Line No." := GenJnl."Line No." + 10000;
                GenJnl."Posting Date" := TODAY;
                GenJnl."Document No." := StudentCharges."Transacton ID";
                GenJnl.VALIDATE(GenJnl."Document No.");
                GenJnl."Journal Template Name" := 'SALES';
                GenJnl."Journal Batch Name" := 'STUD PAY';
                GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                //
                IF Cust.GET(HostelRooms.Student) THEN BEGIN
                    IF Cust."Bill-to Customer No." <> '' THEN
                        GenJnl."Account No." := Cust."Bill-to Customer No."
                    ELSE
                        GenJnl."Account No." := HostelRooms.Student;
                END;

                GenJnl.Amount := StudentCharges.Amount;
                GenJnl.VALIDATE(GenJnl."Account No.");
                GenJnl.VALIDATE(GenJnl.Amount);
                GenJnl.Description := StudentCharges.Description;
                GenJnl."Bal. Account Type" := GenJnl."Account Type"::"G/L Account";

                IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Fees") AND
                   (StudentCharges.Charge = FALSE) THEN BEGIN
                    //GenJnl."Bal. Account No.":="Settlement Type"."Tuition G/L Account";

                    CReg.RESET;
                    CReg.SETCURRENTKEY(CReg."Reg. Transacton ID");
                    CReg.SETRANGE(CReg."Reg. Transacton ID", StudentCharges."Reg. Transacton ID");
                    CReg.SETRANGE(CReg."Student No.", StudentCharges."Student No.");
                    IF CReg.FIND('-') THEN BEGIN
                        IF CReg."Register for" = CReg."Register for"::Stage THEN BEGIN
                            Stages.RESET;
                            Stages.SETRANGE(Stages."Programme Code", CReg.Programmes);
                            Stages.SETRANGE(Stages.Code, CReg.Stage);
                            IF Stages.FIND('-') THEN BEGIN
                                IF (Stages."Modules Registration" = TRUE) AND (Stages."Ignore No. Of Units" = FALSE) THEN BEGIN
                                    CReg.CALCFIELDS(CReg."Units Taken");
                                    IF CReg.Modules <> CReg."Units Taken" THEN
                                        ERROR('Units Taken must be equal to the no of modules registered for.');

                                END;
                            END;
                        END;

                        CReg.Posted := TRUE;
                        CReg.MODIFY;
                    END;


                END ELSE
                    IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Fees") AND
                       (StudentCharges.Charge = FALSE) THEN BEGIN
                        //GenJnl."Bal. Account No.":=GenSetUp."Pre-Payment Account";
                        StudentCharges.CALCFIELDS(StudentCharges."Settlement Type");
                        //GenJnl."Bal. Account No.":="Settlement Type"."Tuition G/L Account";


                        CReg.RESET;
                        CReg.SETCURRENTKEY(CReg."Reg. Transacton ID");
                        CReg.SETRANGE(CReg."Reg. Transacton ID", StudentCharges."Reg. Transacton ID");
                        IF CReg.FIND('-') THEN BEGIN
                            CReg.Posted := TRUE;
                            CReg.MODIFY;
                        END;



                    END ELSE
                        IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Exam Fees" THEN BEGIN
                            IF ExamsByStage.GET(StudentCharges.Programme, StudentCharges.Stage, StudentCharges.Semester, StudentCharges.Code) THEN
                                GenJnl."Bal. Account No." := ExamsByStage."G/L Account";

                        END ELSE
                            IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Exam Fees" THEN BEGIN
                                IF ExamsByUnit.GET(StudentCharges.Programme, StudentCharges.Stage, ExamsByUnit."Unit Code", StudentCharges.Semester,
                                StudentCharges.Code) THEN
                                    GenJnl."Bal. Account No." := ExamsByUnit."G/L Account";

                            END ELSE
                                IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::Charges) OR
                                   (StudentCharges.Charge = TRUE) THEN BEGIN
                                    charges1.Reset;
                                    charges1.setrange(Hostel, true);
                                    if charges1.find('-') then begin
                                        GenJnl."Bal. Account No." := charges1."G/L Account";
                                    end


                                END;


                GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                IF prog.GET(StudentCharges.Programme) THEN BEGIN
                    prog.TESTFIELD(prog."Department Code");
                    GenJnl."Shortcut Dimension 2 Code" := prog."Department Code";
                END;



                GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
                GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                GenJnl."Due Date" := DueDate;
                GenJnl.VALIDATE(GenJnl."Due Date");
                IF StudentCharges."Recovery Priority" <> 0 THEN;
                //     GenJnl."Recovery Priority" := StudentCharges."Recovery Priority"
                // ELSE
                //     GenJnl."Recovery Priority" := 25;
                GenJnl.INSERT;

                //Distribute Money
                IF StudentCharges."Tuition Fee" = TRUE THEN BEGIN
                    IF Stages.GET(StudentCharges.Programme, StudentCharges.Stage) THEN BEGIN
                        IF (Stages."Distribution Full Time (%)" > 0) OR (Stages."Distribution Part Time (%)" > 0) THEN BEGIN
                            Stages.TESTFIELD(Stages."Distribution Account");
                            StudentCharges.TESTFIELD(StudentCharges.Distribution);
                            IF Cust.GET(HostelRooms.Student) THEN BEGIN
                                CustPostGroup.GET(Cust."Customer Posting Group");

                                GenJnl.INIT;
                                GenJnl."Line No." := GenJnl."Line No." + 10000;
                                GenJnl."Posting Date" := TODAY;
                                GenJnl."Document No." := StudentCharges."Transacton ID";
                                //GenJnl."Document Type":=GenJnl."Document Type"::Payment;
                                GenJnl.VALIDATE(GenJnl."Document No.");
                                GenJnl."Journal Template Name" := 'SALES';
                                GenJnl."Journal Batch Name" := 'STUD PAY';
                                GenJnl."Account Type" := GenJnl."Account Type"::"G/L Account";
                                //GenSetUp.TESTFIELD(GenSetUp."Pre-Payment Account");
                                //GenJnl."Account No.":="Settlement Type"."Tuition G/L Account";
                                GenJnl.Amount := StudentCharges.Amount * (StudentCharges.Distribution / 100);
                                GenJnl.VALIDATE(GenJnl."Account No.");
                                GenJnl.VALIDATE(GenJnl.Amount);
                                GenJnl.Description := 'Fee Distribution';
                                GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                                //GenJnl."Bal. Account No.":=Stages."Distribution Account";
                                GenJnl."Bal. Account No." := charges1."G/L Account";
                                StudentCharges.CALCFIELDS(StudentCharges."Settlement Type");
                                //"Settlement Type".GET(StudentCharges."Settlement Type");
                                //GenJnl."Bal. Account No.":="Settlement Type"."Tuition G/L Account";

                                GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                                GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                                IF prog.GET(StudentCharges.Programme) THEN BEGIN
                                    prog.TESTFIELD(prog."Department Code");
                                    GenJnl."Shortcut Dimension 2 Code" := prog."Department Code";
                                END;

                                GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
                                GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");

                                GenJnl.INSERT;

                            END;
                        END;
                    END;
                END ELSE BEGIN
                    //Distribute Charges
                    IF StudentCharges.Distribution > 0 THEN BEGIN
                        StudentCharges.TESTFIELD(StudentCharges."Distribution Account");
                        IF charges1.GET(StudentCharges.Code) THEN BEGIN
                            charges1.TESTFIELD(charges1."G/L Account");
                            GenJnl.INIT;
                            GenJnl."Line No." := GenJnl."Line No." + 10000;
                            GenJnl."Posting Date" := TODAY;
                            GenJnl."Document No." := StudentCharges."Transacton ID";
                            GenJnl.VALIDATE(GenJnl."Document No.");
                            GenJnl."Journal Template Name" := 'SALES';
                            GenJnl."Journal Batch Name" := 'STUD PAY';
                            GenJnl."Account Type" := GenJnl."Account Type"::"G/L Account";
                            GenJnl."Account No." := StudentCharges."Distribution Account";
                            GenJnl.Amount := StudentCharges.Amount * (StudentCharges.Distribution / 100);
                            GenJnl.VALIDATE(GenJnl."Account No.");
                            GenJnl.VALIDATE(GenJnl.Amount);
                            GenJnl.Description := 'Fee Distribution';
                            GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                            GenJnl."Bal. Account No." := charges1."G/L Account";
                            GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                            GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";

                            IF prog.GET(StudentCharges.Programme) THEN BEGIN
                                prog.TESTFIELD(prog."Department Code");
                                GenJnl."Shortcut Dimension 2 Code" := prog."Department Code";
                            END;
                            GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
                            GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                            GenJnl.INSERT;

                        END;
                    END;
                END;
                //End Distribution


                StudentCharges.Recognized := TRUE;
                //StudentCharges.MODIFY;
                //.......BY Wanjala
                StudentCharges.Posted := TRUE;
                StudentCharges.MODIFY;

            //CReg.Posted:=TRUE;
            //CReg.MODIFY;


            //.....END Wanjala

            UNTIL StudentCharges.NEXT = 0;


            /*
            GenJnl.SETRANGE("Journal Template Name",'SALES');
            GenJnl.SETRANGE("Journal Batch Name",'STUD PAY');
            IF GenJnl.FIND('-') THEN BEGIN
            REPEAT
            GLPosting.RUN(GenJnl);
            UNTIL GenJnl.NEXT = 0;
            END;


            GenJnl.RESET;
            GenJnl.SETRANGE("Journal Template Name",'SALES');
            GenJnl.SETRANGE("Journal Batch Name",'STUD PAY');
            GenJnl.DELETEALL;
            */

            //Post New
            GenJnl.RESET;
            GenJnl.SETRANGE("Journal Template Name", 'SALES');
            GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
            IF GenJnl.FIND('-') THEN BEGIN
                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Bill", GenJnl);
            END;

            //Post New


            Cust."Application Method" := Cust."Application Method"::"Apply to Oldest";
            //Cust.Status:=Cust.Status::Current;
            Cust.MODIFY;

        END;

        /*
       //BILLING

       StudentPayments.RESET;
       StudentPayments.SETRANGE(StudentPayments."Student No.",student);
       IF StudentPayments.FIND('-') THEN
       StudentPayments.DELETEALL;


       StudentPayments.RESET;
       StudentPayments.SETRANGE(StudentPayments."Student No.",student);
       IF AccPayment=TRUE THEN BEGIN
        IF Cust.GET(student) THEN
        Cust."Application Method":=Cust."Application Method"::"Apply to Oldest";
        Cust. MODIFY;
       END;*/

        MESSAGE('The Accommodation charge was generated and posted.');
    end;





}
