codeunit 86502 "studentportals"
{
    // trigger OnRun()
    // begin
    //     //AppMgt.SendApproval(61125,'LV000958',31,0,'',0);
    //     //CheckFeeStatus('ACR/00204/019','SEM 1 19/20');
    //     //GenerateStudentStatement('CI/00136/018','FeeStatement'+'-CI00136018');

    // end;

    var
        admnlettr: Report "Bachelors Admission Letter";
        trscripttbl: Record "Final Exam Result2";
        "Employee Card": Record 61188;
        "Supervisor Card": Record "User Setup";
        ApprovalEntry: Record "Approval Entry";
        ApprovalEntry_2: Record "Approval Entry";
        NoSeriesMgt: Codeunit 396;
        NextLeaveApplicationNo: Code[20];
        EmployeeUserId: Text;
        SupervisorId: Text;
        "Supervisor ID": Text;
        test: Boolean;
        testDate: Date;
        dates: Record "Date";
        varDaysApplied: Decimal;
        Customer: Record "Customer";
        "Fee By Stage": Record "ACA-Fee By Unit";
        CourseRegistration: Record "ACA-Course Registration";
        AppMgt: Codeunit 439;
        Text004: Label 'Approval Setup not found.';
        RelieverName: Text;
        ExamResults: Record "ACA-Exam Results";
        showmessage: Boolean;
        ManualCancel: Boolean;
        State: Option Open,"Pending Approval",Cancelled,Approved;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
        tableNo: Integer;
        ApproverComments: Record "Approval Comment Line";
        GenSetup: Record "ACA-General Set-Up";
        NextStoreqNo: Code[10];
        NextMtoreqNo: Code[10];
        Programme: Record "ACA-Programme";
        Receiptz: Record "ACA-Receipt";
        StudentCard: Record "Customer";
        ACAUnitsSubjects: Record "ACA-Units/Subjects";
        CurrentSem: Record "ACA-Semesters";
        StudCharges: Record "ACA-Std Charges";
        AcademicYr: Record "ACA-Academic Year";
        UnitSubjects: Record "ACA-Units/Subjects";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        StudentUnits: Record "ACA-Student Units";
        StudentUnitBaskets: Record "ACA-Student Units Reservour";
        EmployeeCard: Record 61188;
        LedgerEntries: Record "Detailed Cust. Ledg. Entry";
        Stages: Record "ACA-Programme Stages";
        HostelLedger: Record "ACA-Hostel Ledger";
        HostelRooms: Record "ACA-Students Hostel Rooms";
        HostelCard: Record "ACA-Hostel Card";
        HostelBlockRooms: Record "ACA-Hostel Block Rooms";
        RoomSpaces: Record "ACA-Room Spaces";
        PurchaseRN: Record "Purchase Header";
        LecEvaluation: Record "ACA-Lecturers Evaluation";
        ExamsSetup: Record "ACA-Exams Setup";
        AplicFormHeader: Record "ACA-Applic. Form Header";
        ProgEntrySubjects: Record "ACA-Programme Entry Subjects";
        ApplicFormAcademic: Record "ACA-Applic. Form Academic";
        Intake: Record "ACA-Intake";
        ProgramSem: Record "ACA-Programme Semesters";
        filename2: Text[250];
        FILESPATH: Label 'C:\inetpub\wwwroot\KUPORTALS\StudentPortal\Downloads\';
        FILESPATH_A: Label 'C:\inetpub\wwwroot\StaffPortal\Downloads\';
        FILESPATH_SSP: Label 'C:\inetpub\wwwroot\StaffPortal\Downloads\';
        FILESPATH_APP: Label 'C:\inetpub\wwwroot\KUPORTALS\ApplicationsPortal\Documents\';
        // 'C:\inetpub\wwwroot\CUEAApplyMVC\Downloads\';
        /* FILESPATH_A: Label 'C:\PORTALS\TMUCApply\TMUCApply\Downloads\';
        FILESPATH_SSP: Label 'C:\PORTALS\TMUCApply\TMUCApply\Downloads\'; */
        AdmissionFormHeader: Record "ACA-Applic. Form Header";
        ApplicQualification: Record "ACA-Applic. Form Qualification";
        ApplicpPostGraduate: Record "ACA-Applic Form PostGraduate";
        ApplicPostEmployment: Record "ACA-Applic. Form Employment";
        ApplicPhd: Record "ACA-Applic Form pHD additional";
        ApplicPostReferee: Record "ACA-Applic Form Referee";
        //ImportsBuffer: Record "77762";
        Admissions: Record "ACA-Applic. Form Header";
        ApplicationSubject: Record "ACA-Applic. Form Academic";
        AdmissionSubject: Record "ACA-Applic. Setup Subjects";
        LineNo: Integer;
        MedicalCondition: Record "ACA-Medical Condition";
        AdmissionMedical: Record "ACA-Adm. Form Medical Form";
        AdmissionFamily: Record "ACA-Adm. Form Family Medical";
        Immunization: Record "ACA-Immunization";
        AdmissionImmunization: Record "ACA-Adm. Form Immunization";
        AdminKin: Record "ACA-Adm. Form Next of Kin";
        StudentKin: Record "ACA-Student Kin";
        StudentGuardian: Record "ACA-Student Sponsors Details";
        Approvals: Codeunit 439;
        SupUnits: Record "Aca-Special Exams Details";
        SupUnitsBasket: Record "Aca-Special Exams Basket";
        CourseReg: Record "ACA-Course Registration";
        filename: Text;
        IStream: InStream;
        Bytes: DotNet Bytes;
        Convert: DotNet Convert;
        MemStream: DotNet MemoryStream;
        TTTimetableFInalCollector: Record "ACA-Time Table";
        EXTTimetableFInalCollector: Record "ACA-Time Table";
        KUCCPSRaw: Record "KUCCPS Imports";
        //Nationalities: Record "ACA-Academics Central Setups";
        //Counties: Record "County";
        ImportsBuffer: Record "ACA-Imp. Receipts Buffer";
        ClearanceHeader: Record "ACA-Clearance Header";
        NextJobapplicationNo: Text;
        studetUnits: Record "ACA-Student Units";
        StudentsTransfer: Record "ACA-Students Transfer";
        AcaSpecialExamsDetailss: Record "Aca-Special Exams Details";
        InterSchoolTransfer: Record "ACA-Students Transfer";
        ProgStages: Record "ACA-Programme Stages";
        ClassifiactionStudents: Record "ACA-Exam Classification Studs";
        OnlineUsersz: Record OnlineUsers;
        FullNames: Text;
        fabList: Record "ACA-Applic. Form Header";
        centralsetup: Record "ACA-Academics Central Setups";
        counties: Record County;
        countries: Record "Country/Region";
        relationships: Record Relative;
        programs: Record "ACA-Programme";
        programsetups: Record "Programme Setups";
        programstages: Record "ACA-Programme Stages";
        religions: Record "ACA-Religions";
        intakes: Record "ACA-Intake";
        semesters: Record "ACA-Programme Semesters";
        studymodes: Record "ACA-Student Types";
        CourseReg1: Record "ACA-EXAM. Course Registration";
        ethnicity: Record "HRM-Ethnicity";
        AdminSetup: Record "ACA-Adm. Number Setup";
        ProgramUnits: Record "ACA-Semester Units On Offer";
        stageSemester: Record "ACA-Programme Stage Semesters";
        portalsetup: Record PortalSetup;
        generalsetup: Record "ACA-General Set-Up";
        marketingstrategies: Record "ACA-Marketing Strategies";
        bankintergration: Codeunit BankIntegration;
        CuFileManagement: Codeunit "File Management";
        TbDocumentAttachment: Record "Document Attachment";
        campus: Record "Dimension Value";
        DocAttachments: Record "Document Attachment";
        PgDocAtt: Page "Document Attachment Custom";
        offeredunits: Record "ACA-Units Offered";
        days: Record "TT-Days";
        timeslots: Record "TT-Daily Lessons";
        lecturehalls: Record "ACA-Lecturer Halls Setup";
        lecturers: Record "ACA-Lecturers Units";
        associatedunits: Record acaAssosiateUnits;
        settlementtypes: Record "ACA-Settlement Type";
        stdissues: Record studentIssues;



#pragma warning disable AL0667

#pragma warning restore AL0667
    procedure GenerateFullNames() nos: integer
    var
        fullname: Text;
    begin
        nos := 0;
        customer.RESET;
        IF Customer.FIND('-') THEN begin
            REPEAT
                fullname := '';
                if Customer."First Name" <> '' then
                    fullname += Customer."First Name";
                if Customer."Middle Name" <> '' then begin
                    if fullname <> '' then begin
                        fullname += ' ' + Customer."Middle Name";
                    end else
                        fullname += Customer."Middle Name";
                end;
                if Customer."Last Name" <> '' then
                    fullname += ' ' + Customer."Last Name";
                Customer.Name := fullname;
                Customer.modify;
                nos += 1;
            UNTIL Customer.Next = 0;
        end;
    end;

    procedure GenerateAdmLetter2(AdmNo: Text; filenameFromApp: Text)
    var
        filename: Text;
    begin
        filename := FILESPATH_A + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        AdmissionFormHeader.RESET;
        AdmissionFormHeader.SETRANGE(AdmissionFormHeader."Admission No", AdmNo);

        IF AdmissionFormHeader.FIND('-') THEN BEGIN
            //REPORT.SAVEASPDF(51343,filename,AdmissionFormHeader);
            REPORT.SAVEASPDF(Report::"Official Admission Letter -JAB", filename, KUCCPSRaw);
        END;

    end;

    procedure GenerateStudentStatement("Student No": Text; filenameFromApp: Text)
    var
        filename: Text;
    begin
        filename := FILESPATH + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", "Student No");

        IF Customer.FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(report::"Student Fee Statement 2", filename, Customer);
        END;
    end;


    procedure GenerateStudentProformaInvoice("Programme Code": Text; "Stage Code": Text; filenameFromApp: Text)
    var
        filename: Text;
    begin
        filename := FILESPATH + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        "Fee By Stage".RESET;
        "Fee By Stage".SETRANGE("Fee By Stage"."Programme Code", "Programme Code");
        "Fee By Stage".SETRANGE("Fee By Stage"."Stage Code", "Stage Code");

        IF "Fee By Stage".FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(Report::"Student Proforma Invoice", filename, "Fee By Stage");
        END;
    end;

    procedure GenerateStudentProformaInvoice2("StudentNo": Code[20]; filenameFromApp: Text)
    var
        filename: Text;
    begin
        filename := FILESPATH + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        CourseReg.RESET;
        CourseReg.SETRANGE(CourseReg."Student No.", StudentNo);
        IF CourseReg.FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(Report::"Student Proforma Invoice2", filename, CourseReg);
        END;
    end;

    procedure GenerateStudentExamCard(StudentNo: Text; Sem: Text; filenameFromApp: Text): Text
    var
        filename: Text;
    begin
        filename := FILESPATH + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);

        CourseRegistration.RESET;
        CourseRegistration.SETRANGE(CourseRegistration."Student No.", StudentNo);
        CourseRegistration.SETRANGE(CourseRegistration.Semester, Sem);
        IF CourseRegistration.FINDFIRST THEN BEGIN
            REPORT.SAVEASPDF(report::"Exam Card Final", filename, CourseRegistration);
            /*
            IF CourseRegistration.FIND('-') THEN BEGIN
              REPORT.SAVEASPDF(51515,filename,CourseRegistration);
            END;
            Customer.RESET;
            Customer.SETRANGE("No.",StudentNo);
            Customer.SETFILTER("Semester Filter",sem);
            IF Customer.FINDFIRST THEN BEGIN
               REPORT.SAVEASPDF(51515,filename,Customer);*/
        END;

    end;

    procedure GenerateBS64StudentExamCard(StudentNo: Text; Sem: Code[20]; filenameFromApp: Text; var bigtext: BigText) rtnmsg: Text
    var
        tmpBlob: Codeunit "Temp Blob";
        cnv64: Codeunit "Base64 Convert";
        InStr: InStream;
        OutStr: OutStream;
        txtB64: Text;
        format: ReportFormat;
        recRef: RecordRef;
        filename: Text;
    begin
        filename := FILESPATH + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);

        CourseRegistration.RESET;
        CourseRegistration.SETRANGE(CourseRegistration."Student No.", StudentNo);
        CourseRegistration.SETRANGE(CourseRegistration.Semester, Sem);
        IF CourseRegistration.FINDFIRST THEN BEGIN
            recRef.GetTable(CourseRegistration);
            tmpBlob.CreateOutStream(OutStr);
            Report.SaveAs(51774, '', format::Pdf, OutStr, recRef);
            tmpBlob.CreateInStream(InStr);
            txtB64 := cnv64.ToBase64(InStr, true);
            bigtext.AddText(txtB64);
        END;
        EXIT(filename);
    end;

    procedure GenerateStudentProvisionalResults(StudentNo: Text; filenameFromApp: Text; sem: Text)
    var
        filename: Text;
    begin
        filename := FILESPATH + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        CourseRegistration.RESET;
        CourseRegistration.SETRANGE(CourseRegistration."Student No.", StudentNo);
        CourseRegistration.SETRANGE(CourseRegistration.Semester, sem);

        IF CourseRegistration.FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(report::"Official University Resultslip", filename, CourseRegistration);
        END;
    end;

    procedure GenerateStudentProvisionalResults2(StudentNo: Text; filenameFromApp: Text; sem: Text)
    var
        filename: Text;
    begin
        filename := FILESPATH + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        StudentUnits.RESET;
        StudentUnits.SETRANGE(StudentUnits."Student No.", StudentNo);
        StudentUnits.SETRANGE(StudentUnits.Semester, sem);

        IF StudentUnits.FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(report::"Provisional Transcript2", filename, StudentUnits);
        END;
    end;

    procedure GenerateStudentADMLetter(StudentNo: Text; filenameFromApp: Text)
    var
        filename: Text;
    begin
        filename := FILESPATH + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        fabList.RESET;
        fabList.SETRANGE("Admission No", StudentNo);
        if fablist.Find('-') then begin
            if (fabList."Application Type" = fabList."Application Type"::Full) then begin
                REPORT.SAVEASPDF(66679, filename, fablist);

            end else
                if (fablist."Application Type" = fablist."Application Type"::Provisional) then begin
                    REPORT.SAVEASPDF(51345, filename, fablist);

                end;
        end;
    end;

    procedure GetProfilePictureStudent(StudentNo: Text) BaseImage: Text
    var
        ToFile: Text;
        IStream: InStream;
    // Bytes: DotNet BCArray;
    // Convert: DotNet BCConvert;
    // MemoryStream: DotNet BCMemoryStream;
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", StudentNo);

        IF Customer.FIND('-') THEN BEGIN
            // IF Customer.Picture.HASVALUE THEN BEGIN
            //     Customer.CALCFIELDS(Picture);
            //     Customer.Picture.CREATEINSTREAM(IStream);
            //     MemoryStream := MemoryStream.MemoryStream();
            //     COPYSTREAM(MemoryStream, IStream);
            //     Bytes := MemoryStream.GetBuffer();
            //     BaseImage := Convert.ToBase64String(Bytes);
            // END;
        END;
    end;


    procedure ExamResultsCreate(StudentNo: Text; Prog: Text; Stage: Text; Sem: Text; Unit: Text; Score: Integer; ExamType: Text; AcademicYear: Text; RegistrationType: Option)
    begin
        ExamResults.INIT;
        ExamResults."Student No." := StudentNo;
        ExamResults.Programmes := Prog;
        ExamResults.Stage := Stage;
        ExamResults.Unit := Unit;
        ExamResults.Semester := Sem;
        ExamResults.Score := Score;
        ExamResults.ExamType := ExamType;
        ExamResults."Academic Year" := AcademicYear;
        //ExamResults."Registration Type":=RegistrationType;
        ExamResults.INSERT;
    end;

    procedure CheckValidOnlineUserzEmail(email: Text) Msg: Text
    begin
        OnlineUsersz.Reset();
        OnlineUsersz.SetRange(OnlineUsersz."Email Address", email);
        if OnlineUsersz.Find('-') then begin
            Msg := 'Yes::' + OnlineUsersz.Password;
        end;
    end;

    procedure StaffLogin(Username: Text; UserPassword: Text) Message: Text
    var
        TXTIncorrectDetails: Label 'Incorrect Username or Password';
        TXTCorrectDetails: Label 'Login';
        FullNames: Text;
    begin
        "Employee Card".RESET;
        "Employee Card".SETRANGE("Employee Card"."No.", Username);
        IF "Employee Card".FIND('-') THEN BEGIN
            IF ("Employee Card"."Changed Password" = TRUE) THEN BEGIN
                IF ("Employee Card"."Portal Password" = UserPassword) THEN BEGIN
                    FullNames := "Employee Card"."First Name" + ' ' + "Employee Card"."Middle Name" + ' ' + "Employee Card"."Last Name";
                    Message := TXTCorrectDetails + '::' + FORMAT("Employee Card"."Changed Password") + '::' + "Employee Card"."No." + '::' + "Employee Card"."User ID" + '::' + FullNames;
                END ELSE BEGIN
                    Message := TXTIncorrectDetails + '::' + FORMAT("Employee Card"."Changed Password");
                END
            END ELSE BEGIN
                IF ("Employee Card"."ID Number" = UserPassword) THEN BEGIN
                    Message := TXTCorrectDetails + '::' + FORMAT("Employee Card"."Changed Password") + '::' + "Employee Card"."No." + '::' + "Employee Card"."User ID" + '::' + FullNames;
                END ELSE BEGIN
                    Message := TXTIncorrectDetails + '::' + FORMAT("Employee Card"."Changed Password");
                END
            END
        END ELSE BEGIN
            Message := TXTIncorrectDetails + '::';
        END
    end;


    procedure GetFullName(EmployeeNo: Text)
    begin
        "Employee Card".RESET;
        "Employee Card".SETRANGE("Employee Card"."No.", EmployeeNo);

        IF "Employee Card".FIND('-')
        THEN BEGIN
            MESSAGE("Employee Card".FullName);
        END
    end;





    procedure PreRegisterStudents2(studentNo: Text; stage: Text; semester: Text; Programme: Text; AcademicYear: Text; settlementType: Text; ProgrammeOption: Code[20]) CourseRegId: Code[30]
    var
        Progs: Code[20];
    begin
        GenSetup.GET;
        CLEAR(Progs);
        IF EVALUATE(Progs, Programme) THEN;
        CourseReg.RESET;
        CourseReg.SETRANGE(CourseReg."Student No.", studentNo);
        CourseReg.SETRANGE(CourseReg.Programmes, Progs);
        CourseReg.SETRANGE(CourseReg.Semester, semester);
        CourseReg.SETRANGE(CourseReg.Reversed, FALSE);

        IF CourseReg.FIND('-') THEN
            ERROR('You have already registered for Semester %1, Year %2', semester, CourseReg.Stage);

        CourseReg.INIT;
        CourseRegId := NoSeriesMgt.GetNextNo(GenSetup."Registration Nos.", TODAY, TRUE);
        CourseReg."Reg. Transacton ID" := CourseRegId;
        CourseReg."Student No." := studentNo;
        CourseReg.Options := ProgrammeOption;
        CourseReg.Programmes := Progs;
        CourseReg.VALIDATE(Programmes);
        CourseReg.Stage := stage;
        //CourseReg.VALIDATE(Stage);
        //CourseReg."Date Registered":=TODAY;
        //CourseReg.Semester:=semester;
        //CourseReg."Academic Year":=AcademicYear;
        CourseReg.VALIDATE("Settlement Type", settlementType);
        CourseReg.INSERT(TRUE);
    end;

    procedure GenerateFeeStructure(Programz: Code[20]; SettlementType: Code[20]; filenameFromApp: Text) filename: Text
    begin
        filename := FILESPATH + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        //MESSAGE('OK');
        Programme.RESET;
        Programme.SETRANGE(Programme.Code, Programz);
        Programme.SETFILTER(Programme."Settlement Type Filter", '%1', SettlementType);

        IF Programme.FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(report::"Fee Structure Summary Report", filename, Programme);   //52017726
        END;
        EXIT(filename);
    end;

    procedure GenerateAppFeeStructure(Programz: Code[20]; SettlementType: Code[20]; filenameFromApp: Text) filename: Text
    begin
        filename := FILESPATH_APP + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        //MESSAGE('OK');
        Programme.RESET;
        Programme.SETRANGE(Programme.Code, Programz);
        Programme.SETFILTER(Programme."Settlement Type Filter", '%1', SettlementType);

        IF Programme.FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(report::"Fee Structure Summary Report", filename, Programme);   //52017726
        END;
        EXIT(filename);
    end;

    procedure GenerateAdmnLetter(index: Text; filenameFromApp: Text) filename: Text
    begin
        filename := FILESPATH_APP + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        fablist.RESET;
        fablist.SETRANGE(fablist."Index Number", index);
        IF fablist.FIND('-') THEN BEGIN
            if fablist."Settlement Type" = '4YR-HEF' then begin
                REPORT.SAVEASPDF(66680, filename, fablist);
            end else begin
                REPORT.SAVEASPDF(report::"Bachelors Admission Letter", filename, fablist);
            end;
        END;
        EXIT(filename);
    end;

    procedure GenerateReceipt(ReceiptNo: Code[20]; filenameFromApp: Text) filename: Text
    begin
        filename := FILESPATH + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        //MESSAGE('OK');
        Receiptz.RESET;
        Receiptz.SETRANGE(Receiptz."Receipt No.", ReceiptNo);

        IF Receiptz.FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(report::"Student Fee Receipts", filename, Receiptz);   //52017726
        END;
        EXIT(filename);
    end;


    procedure StudentsLogin(Username: Text; UserPassword: Text) Message: Text
    var
        TXTIncorrectDetails: Label 'Incorrect Username or Password';
        TXTCorrectDetails: Label 'Login';
        FullNames: Text;
    begin
        StudentCard.RESET;
        StudentCard.SETRANGE(StudentCard."No.", Username);
        IF StudentCard.FIND('-') THEN BEGIN
            IF (StudentCard."Changed Password" = TRUE) THEN BEGIN
                IF (StudentCard.Password = UserPassword) THEN BEGIN
                    IF (StudentCard.Status = StudentCard.Status::Disciplinary) THEN BEGIN
                        Message := 'Your account has been blocked due to disciplinary issues!' + '::'
                    END ELSE BEGIN
                        FullNames := StudentCard.Name;
                        Message := TXTCorrectDetails + '::' + FORMAT(StudentCard."Changed Password") + '::' + StudentCard."No." + '::' + StudentCard.Name + '::' + FORMAT(StudentCard.Status);

                    END;
                END ELSE BEGIN
                    Message := TXTIncorrectDetails + '::' + FORMAT(StudentCard."Changed Password");
                END
            END ELSE BEGIN
                IF (StudentCard."ID No" = UserPassword) THEN BEGIN
                    Message := TXTCorrectDetails + '::' + FORMAT(StudentCard."Changed Password") + '::' + StudentCard."No." + '::' + StudentCard.Name + '::' + FORMAT(StudentCard.Status);
                END ELSE BEGIN
                    Message := TXTIncorrectDetails + '::' + FORMAT(StudentCard."Changed Password");
                END
            END
        END ELSE BEGIN
            Message := TXTIncorrectDetails + '::' + FORMAT(StudentCard.Status);
        END

    end;


    procedure GetStudentFullName(StudentNo: Text) Message: Text
    var
        FullDetails: Integer;
    begin
        StudentCard.RESET;
        StudentCard.SETRANGE(StudentCard."No.", StudentNo);
        IF StudentCard.FIND('-') THEN BEGIN
            Message := StudentCard."No." + '::' + StudentCard.Name + '::' + StudentCard."E-Mail" + '::' + StudentCard."ID No" + '::' + FORMAT(StudentCard.Gender) + '::' + FORMAT(StudentCard."Date Of Birth") + '::' + StudentCard."Post Code" + '::' + StudentCard.Address;

        END
    end;


    procedure IsStudentRegistered(StudentNo: Text; Sem: Text) Message: Text
    var
        TXTNotRegistered: Label 'Not registered';
        TXTRegistered: Label 'Registered';
    begin
        CourseRegistration.RESET;
        CourseRegistration.SETRANGE(CourseRegistration."Student No.", StudentNo);
        CourseRegistration.SETRANGE(CourseRegistration.Semester, Sem);
        CourseRegistration.SETRANGE(CourseRegistration.Reversed, FALSE);
        IF CourseRegistration.FIND('-') THEN BEGIN
            Message := TXTRegistered + '::';
        END ELSE BEGIN
            Message := TXTNotRegistered + '::';
        END
    end;


    procedure LoadUnits(ProgCode: Code[20]; StageCode: Code[20]) Message: Text
    begin
        ACAUnitsSubjects.RESET;
        ACAUnitsSubjects.SETRANGE("Programme Code", ProgCode);
        ACAUnitsSubjects.SETRANGE("Stage Code", StageCode);
        ACAUnitsSubjects.SETRANGE("Time Table", TRUE);
        ACAUnitsSubjects.SETRANGE("Old Unit", FALSE);
        IF ACAUnitsSubjects.FIND('-') THEN BEGIN
            Message := ACAUnitsSubjects.Code + '::' + ACAUnitsSubjects.Desription;
        END;
    end;


    procedure GetCurrentSemData() Message: Text
    begin
        CurrentSem.RESET;
        CurrentSem.SETRANGE(CurrentSem."Current Semester", TRUE);
        IF CurrentSem.FIND('-') THEN BEGIN
            Message := CurrentSem.Code + '::' + CurrentSem.Description + '::' + FORMAT(CurrentSem."Registration Deadline") + '::' +
  FORMAT(CurrentSem."Lock CAT Editting") + '::' + FORMAT(CurrentSem."Lock Exam Editting") + '::' + FORMAT(CurrentSem."Ignore Editing Rule")
  + '::' + FORMAT(CurrentSem."Mark entry Dealine") + '::' + FORMAT(CurrentSem."Lock Lecturer Editing") + '::' + FORMAT(CurrentSem.AllowDeanEditing) + '::' + FORMAT(CurrentSem."Unit Registration Deadline") + '::' + FORMAT(CurrentSem."Apply For Supp");
        END
    end;


    procedure GetStudentCourseData(StudentNo: Text; Sem: Text) Message: Text
    begin
        CourseRegistration.RESET;
        CourseRegistration.SETCURRENTKEY(Stage);
        CourseRegistration.Ascending(true);
        CourseRegistration.SETRANGE(CourseRegistration."Student No.", StudentNo);
        CourseRegistration.SETRANGE(CourseRegistration.Reversed, FALSE);
        IF CourseRegistration.FIND('+') THEN BEGIN
            Message := CourseRegistration.Stage + '::' + CourseRegistration.Programmes + '::' + CourseRegistration."Reg. Transacton ID" + '::' + CourseRegistration.Semester + '::'
    + CourseRegistration."Settlement Type" + '::' + GetProgram(CourseRegistration.Programmes) + '::' + GetSchool(CourseRegistration.Programmes);
        END;
    end;

    procedure GetRegisteredStudyMode(setmtype: Code[20]) studymode: Code[20]
    begin
        settlementtypes.Reset;
        settlementtypes.SetRange(Code, setmtype);
        if settlementtypes.Find('-') then begin
            studymode := settlementtypes.ModeofStudy;
        end;
    end;

    procedure GetProgram(ProgID: Text) Message: Text
    begin
        Programme.RESET;
        Programme.SETRANGE(Programme.Code, ProgID);
        IF Programme.FIND('-') THEN BEGIN
            Message := Programme.Description;
        END
    end;


    procedure GetBilled(StudentNo: Text; Sem: Text) Message: Text
    var
        ACACourseRegistration: Record "ACA-Course Registration";
    begin
        ACACourseRegistration.RESET;
        ACACourseRegistration.SETRANGE(ACACourseRegistration."Student No.", StudentNo);
        ACACourseRegistration.SETRANGE(ACACourseRegistration.Semester, Sem);
        ACACourseRegistration.SETRANGE(ACACourseRegistration.Reversed, FALSE);
        ACACourseRegistration.SETRANGE(ACACourseRegistration.Posted, TRUE);
        IF StudCharges.FIND('-') THEN BEGIN
            Message := ACACourseRegistration.Semester;
        END;
    end;


    procedure GetAcademicYr() Message: Text
    begin
        AcademicYr.RESET;
        AcademicYr.SETRANGE(AcademicYr.Current, TRUE);
        IF AcademicYr.FIND('-') THEN BEGIN
            Message := AcademicYr.Code + '::' + AcademicYr.Description;
        END
    end;


    procedure UnitDescription(ProgID: Text; UnitID: Text) Message: Text
    begin
        UnitSubjects.RESET;
        UnitSubjects.SETRANGE(UnitSubjects."Programme Code", ProgID);
        UnitSubjects.SETRANGE(UnitSubjects.Code, UnitID);
        //UnitSubjects.SETRANGE(UnitSubjects."Time Table", TRUE);
        //UnitSubjects.SETRANGE(UnitSubjects."Old Unit", FALSE);
        IF UnitSubjects.FIND('-') THEN BEGIN
            Message := UnitSubjects.Desription;
        END
    end;


    procedure SubmitUnits(studentNo: Text; Unit: Text; Prog: Text; myStage: Text; sem: Text; RegTransID: Text; UnitDescription: Text; AcademicYear: Text) ReturnMessage: Text[150]
    var
        Customer: Record "Customer";
    begin
        /*IF Customer.GET(studentNo) THEN BEGIN
            Customer.CALCFIELDS(Balance);
            IF Customer.Balance > 0 THEN BEGIN
                ReturnMessage := 'Units not registered! Your Balance is greater than zero!';
            END;
        END;
        IF NOT (Customer.Balance > 0) THEN BEGIN*/
        StudentUnits.INIT;
        StudentUnits."Student No." := studentNo;
        StudentUnits.Unit := Unit;
        StudentUnits."Unit Name" := UnitDescription;
        StudentUnits.Programme := Prog;
        StudentUnits.Stage := myStage;
        StudentUnits.Semester := sem;
        StudentUnits.Taken := TRUE;
        StudentUnits."Reg. Transacton ID" := RegTransID;
        StudentUnits."Unit Description" := UnitDescription;
        StudentUnits."Academic Year" := AcademicYear;
        StudentUnits.INSERT(TRUE);
        ReturnMessage := 'Units registered Successfully!';
        StudentUnitBaskets.RESET;
        StudentUnitBaskets.SETRANGE("Student No.", studentNo);
        StudentUnitBaskets.SETRANGE(Unit, Unit);
        StudentUnitBaskets.SETRANGE(Programme, Prog);
        //StudentUnitBaskets.SETRANGE(Stage, myStage);
        StudentUnitBaskets.SETRANGE(Semester, sem);
        StudentUnitBaskets.SETRANGE("Reg. Transacton ID", RegTransID);
        StudentUnitBaskets.SETRANGE("Academic Year", AcademicYear);
        IF StudentUnitBaskets.FIND('-') THEN begin
            StudentUnitBaskets.Delete();
        END;
    end;


    procedure GetUnitTaken(UnitID: Text; StudentNo: Text; Stage: Text) Message: Text
    var
        TXTtaken: Label 'Taken';
        TXTNotTaken: Label 'Not Taken';
    begin
        StudentUnits.RESET;
        StudentUnits.SETRANGE(StudentUnits.Unit, UnitID);
        StudentUnits.SETRANGE(StudentUnits."Student No.", StudentNo);
        //StudentUnits.SETRANGE(StudentUnits.Stage, Stage);
        IF StudentUnits.FIND('-') THEN BEGIN
            Message := TXTtaken + '::';
        END ELSE BEGIN
            trscripttbl.RESET;
            trscripttbl.SETRANGE(trscripttbl.StudentID, StudentNo);
            trscripttbl.SETRANGE(trscripttbl.UnitCode, UnitID);
            IF trscripttbl.FIND('-') THEN BEGIN
                Message := TXTtaken + '::';
            END ELSE BEGIN
                Message := TXTNotTaken + '::';
            END
        END
    end;


    procedure SubmitUnitsBaskets(studentNo: Text; Unit: Text; Prog: Text; myStage: Text; sem: Text; RegTransID: Text; UnitDescription: Text; AcademicYear: Text)
    begin
        StudentUnitBaskets.RESET;
        StudentUnitBaskets.SETRANGE("Student No.", studentNo);
        StudentUnitBaskets.SETRANGE(Unit, Unit);
        StudentUnitBaskets.SETRANGE(Programme, Prog);
        StudentUnitBaskets.SETRANGE(Stage, myStage);
        StudentUnitBaskets.SETRANGE(Semester, sem);
        StudentUnitBaskets.SETRANGE("Reg. Transacton ID", RegTransID);
        StudentUnitBaskets.SETRANGE("Academic Year", AcademicYear);
        IF NOT StudentUnitBaskets.FIND('-') THEN BEGIN
            StudentUnitBaskets.INIT;
            StudentUnitBaskets."Student No." := studentNo;
            StudentUnitBaskets.Unit := Unit;
            StudentUnitBaskets.Programme := Prog;
            StudentUnitBaskets.Stage := myStage;
            StudentUnitBaskets.Taken := TRUE;
            StudentUnitBaskets.Semester := sem;
            StudentUnitBaskets."Reg. Transacton ID" := RegTransID;
            StudentUnitBaskets.Description := UnitDescription;
            StudentUnitBaskets."Academic Year" := AcademicYear;
            //StudentUnitBaskets.Posted := FALSE;
            StudentUnitBaskets.INSERT(TRUE);
        END ELSE BEGIN
            //StudentUnitBaskets.Posted := FALSE;
            StudentUnitBaskets.MODIFY;
        END;
    end;

    procedure GetUnitsBaskets(studentNo: Text; Prog: Text; myStage: Text) Details: Text
    begin
        StudentUnitBaskets.RESET;
        StudentUnitBaskets.SETRANGE("Student No.", studentNo);
        StudentUnitBaskets.SETRANGE(Programme, Prog);
        StudentUnitBaskets.SETRANGE(Stage, myStage);
        StudentUnitBaskets.SETRANGE(Semester, GetCurrentSem(Prog, myStage));
        IF StudentUnitBaskets.FIND('-') THEN BEGIN
            REPEAT
                Details := Details + StudentUnitBaskets.Unit + ' ::' + StudentUnitBaskets.Description + ' :::';

            until StudentUnitBaskets.Next = 0;
        END
    end;

    procedure GetUnitSelected(UnitID: Text; StudentNo: Text; Stage: Text) Message: Text
    var
        TXTtaken: Label 'Taken';
        TXTNotTaken: Label 'Not Taken';
    begin
        StudentUnitBaskets.RESET;
        StudentUnitBaskets.SETRANGE(StudentUnitBaskets.Unit, UnitID);
        StudentUnitBaskets.SETRANGE(StudentUnitBaskets."Student No.", StudentNo);
        //StudentUnitBaskets.SETRANGE(StudentUnitBaskets.Stage, Stage);
        // StudentUnitBaskets.SETRANGE(StudentUnitBaskets.Posted, FALSE);
        IF StudentUnitBaskets.FIND('-') THEN BEGIN
            Message := TXTtaken + '::';
        END ELSE BEGIN
            Message := TXTNotTaken + '::';
        END
    end;


    procedure DeleteSelectedUnit(studentNo: Text; UnitID: Text)
    begin
        StudentUnitBaskets.RESET;
        StudentUnitBaskets.SETRANGE(StudentUnitBaskets."Student No.", studentNo);
        StudentUnitBaskets.SETRANGE(StudentUnitBaskets.Unit, UnitID);
        IF StudentUnitBaskets.FIND('-') THEN BEGIN
            StudentUnitBaskets.DELETE;
            MESSAGE('Deleted Successfully');
        END;
    end;

    procedure RemoveSelectedUnit(studentNo: Text; UnitID: Text) Removed: Boolean
    begin
        StudentUnitBaskets.RESET;
        StudentUnitBaskets.SETRANGE(StudentUnitBaskets."Student No.", studentNo);
        StudentUnitBaskets.SETRANGE(StudentUnitBaskets.Unit, UnitID);
        IF StudentUnitBaskets.FIND('-') THEN BEGIN
            StudentUnitBaskets.DELETE;
            Removed := TRUE;
        END;
    end;

    procedure DeleteSubmittedUnit(studentNo: Text)
    begin
        StudentUnitBaskets.RESET;
        StudentUnitBaskets.SETRANGE(StudentUnitBaskets."Student No.", studentNo);
        IF StudentUnitBaskets.FIND('-') THEN BEGIN
            REPEAT
                //StudentUnitBaskets.Posted := TRUE;
                StudentUnitBaskets.MODIFY;
                MESSAGE('Deleted Successfully');
            UNTIL StudentUnitBaskets.NEXT = 0;
        END;
    end;

    //
    procedure CheckStaffPasswordChanged(username: Text) Message: Text
    var
        TXTIncorrectDetails: Label 'No';
        TXTCorrectDetails: Label 'Yes';
    begin
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            IF (EmployeeCard."Changed Password" = TRUE) THEN BEGIN
                Message := TXTCorrectDetails + '::' + FORMAT(EmployeeCard."Changed Password");
            END ELSE BEGIN
                Message := TXTIncorrectDetails + '::' + FORMAT(EmployeeCard."Changed Password");
            END
        END ELSE BEGIN
            Message := TXTIncorrectDetails + '::';
        END
    end;

    procedure GenerateTranscript(StudentNo: Text; filenameFromApp: Text; sem: Text)
    var
        filename: Text;
        AcademicYear: Code[20];
    begin
        filename := FILESPATH + filenameFromApp;
        CLEAR(AcademicYear);
        AcademicYear := sem;
        IF EXISTS(filename) THEN
            ERASE(filename);
        CourseReg1.RESET;
        CourseReg1.SETRANGE(CourseReg1."Student Number", StudentNo);
        CourseReg1.SETRANGE(CourseReg1."Academic Year", AcademicYear);

        IF CourseReg1.FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(report::"Provisional College Transcrip3", filename, CourseReg1);
        END;
    end;



    procedure GetStaffDetails(username: Text) Message: Text
    begin
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            Message := EmployeeCard."ID Number" + '::' + EmployeeCard.Citizenship + '::' + EmployeeCard."Postal Address" + '::' +
  EmployeeCard."Job Title" + '::' + EmployeeCard."Company E-Mail" + '::' + FORMAT(EmployeeCard.Title) + '::' + FORMAT(EmployeeCard."Date Of Birth");

        END
    end;


    procedure GetStaffGender(username: Text) Message: Text
    begin
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            Message := FORMAT(EmployeeCard.Gender) + '::' + EmployeeCard."Cellular Phone Number";

        END
    end;


    procedure HasFinances(StudentNo: Text) Message: Text
    var
        TXTNotRegistered: Label 'No';
        TXTRegistered: Label 'Yes';
    begin
        LedgerEntries.RESET;
        LedgerEntries.SETRANGE(LedgerEntries."Customer No.", StudentNo);
        IF LedgerEntries.FIND('-') THEN BEGIN
            Message := TXTRegistered + '::';
        END ELSE BEGIN
            Message := TXTNotRegistered + '::';
        END
    end;


    procedure GetCurrentSTageOrder(stage: Text; "Program": Text) Message: Text
    begin
        Stages.RESET;
        Stages.SETRANGE(Stages.Code, stage);
        Stages.SETRANGE(Stages."Programme Code", "Program");
        IF Stages.FIND('-') THEN BEGIN
            Message := FORMAT(Stages.Order);
        END
    end;


    procedure GetNextSTage(orderd: Integer; Progz: Text) Message: Text
    begin
        Stages.RESET;
        Stages.SETRANGE(Stages.Order, orderd);
        Stages.SETRANGE(Stages."Programme Code", Progz);
        IF Stages.FIND('-') THEN BEGIN
            Message := Stages.Code;
        END
    end;


    procedure SubmitSpecialAndSupplementary(StudNo: Code[20]; LectNo: Code[20]; Marks: Decimal; AcademicYear: Code[20]; UnitCode: Code[20]) ReturnMessage: Text[250]
    var
        AcaSpecialExamsDetails: Record "Aca-Special Exams Details";
        AcaSpecialExamsResults: Record "Aca-Special Exams Results";
    begin
        CLEAR(ReturnMessage);
        AcaSpecialExamsDetails.RESET;
        AcaSpecialExamsDetails.SETRANGE("Academic Year", AcademicYear);
        AcaSpecialExamsDetails.SETRANGE("Student No.", StudNo);
        AcaSpecialExamsDetails.SETRANGE("Unit Code", UnitCode);
        IF AcaSpecialExamsDetails.FIND('-') THEN BEGIN
            AcaSpecialExamsResults.RESET;
            AcaSpecialExamsResults.SETRANGE("Academic Year", AcademicYear);
            AcaSpecialExamsResults.SETRANGE("Student No.", StudNo);
            AcaSpecialExamsResults.SETRANGE(Unit, UnitCode);
            IF AcaSpecialExamsResults.FIND('-') THEN BEGIN
                AcaSpecialExamsResults.VALIDATE(Score, Marks);
                AcaSpecialExamsResults.UserID := LectNo;
                AcaSpecialExamsResults."Modified Date" := TODAY;
                AcaSpecialExamsResults.Catogory := AcaSpecialExamsDetails.Catogory;
                AcaSpecialExamsResults.MODIFY;
                ReturnMessage := '1'
            END ELSE BEGIN
                AcaSpecialExamsResults.INIT;
                AcaSpecialExamsResults.Programmes := AcaSpecialExamsDetails.Programme;
                AcaSpecialExamsResults.Stage := AcaSpecialExamsDetails.Stage;
                AcaSpecialExamsResults.Unit := UnitCode;
                AcaSpecialExamsResults.Semester := AcaSpecialExamsDetails.Semester;
                AcaSpecialExamsResults."Student No." := AcaSpecialExamsDetails."Student No.";
                AcaSpecialExamsResults."Academic Year" := AcaSpecialExamsDetails."Academic Year";
                AcaSpecialExamsResults."Admission No" := StudNo;
                AcaSpecialExamsResults."Academic Year" := AcaSpecialExamsDetails."Academic Year";
                AcaSpecialExamsResults.UserID := LectNo;
                AcaSpecialExamsResults."Capture Date" := TODAY;
                AcaSpecialExamsResults.Catogory := AcaSpecialExamsDetails.Catogory;
                AcaSpecialExamsResults.VALIDATE(Score, Marks);
                AcaSpecialExamsResults.INSERT;
                AcaSpecialExamsResults.VALIDATE(Unit);
                ReturnMessage := '1';
            END;
        END;
    end;


    procedure GetFees(StudentNo: Text) Message: Text
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", StudentNo);
        IF Customer.FIND('-') THEN BEGIN
            Customer.CALCFIELDS("Debit Amount", "Credit Amount", Balance);
            Message := FORMAT(Customer."Debit Amount") + '::' + FORMAT(Customer."Credit Amount") + '::' + FORMAT(Customer.Balance);

        END
    end;


    procedure GetStaffProfileDetails(username: Text) Message: Text
    begin
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            Message := EmployeeCard."ID Number" + '::' + EmployeeCard.Citizenship + '::' + EmployeeCard."Postal Address" + '::' +
  EmployeeCard."Job Title" + '::' + EmployeeCard."Company E-Mail" + '::' + FORMAT(EmployeeCard.Title) + '::' + FORMAT(EmployeeCard."Date Of Birth") + '::' + FORMAT(EmployeeCard.Gender) + '::' + EmployeeCard."Cellular Phone Number";

        END
    end;


    procedure IsHostelBlacklisted(username: Text) Message: Text
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", username);
        IF Customer.FIND('-') THEN BEGIN
            Message := FORMAT(Customer."Hostel Black Listed");

        END
    end;


    procedure GetAccomodationFee(username: Text; Sem: Text) Message: Text
    begin
        StudCharges.RESET;
        StudCharges.SETRANGE(StudCharges."Student No.", username);
        StudCharges.SETRANGE(StudCharges.Semester, Sem);
        StudCharges.SETRANGE(StudCharges.accommodation, TRUE);
        IF StudCharges.FIND('-') THEN BEGIN
            Message := FORMAT(StudCharges.Amount);
        END;
    end;


    procedure GetStudentGender(username: Text) Message: Text
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", username);
        IF Customer.FIND('-') THEN BEGIN
            Message := FORMAT(Customer.Gender);
        END;
    end;


    procedure GetSettlementType(username: Text) Message: Text
    begin
        CourseRegistration.RESET;
        CourseRegistration.SETRANGE(CourseRegistration."Student No.", username);
        IF Customer.FIND('-') THEN BEGIN
            Message := FORMAT(CourseRegistration."Settlement Type");

        END
    end;


    procedure GetRoomCostNum(SpaceNo: Text) Message: Text
    begin
        HostelLedger.RESET;
        HostelLedger.SETRANGE(HostelLedger."Space No", SpaceNo);
        IF HostelLedger.FIND('-') THEN BEGIN
            Message := HostelLedger."Room No" + '::' + FORMAT(HostelLedger."Room Cost");

        END
    end;


    procedure GetHasBooked(username: Text; sem: Text) Message: Text
    begin
        HostelRooms.RESET;
        HostelRooms.SETRANGE(HostelRooms.Student, username);
        HostelRooms.SETRANGE(HostelRooms.Semester, sem);
        IF HostelRooms.FIND('-') THEN BEGIN
            Message := HostelRooms.Student + '::' + HostelRooms."Space No" + '::' + HostelRooms."Room No" + '::' +
  HostelRooms."Hostel No" + '::' + FORMAT(HostelRooms."Accomodation Fee") + '::' + HostelRooms.Semester + '::' + FORMAT(HostelRooms."Allocation Date");

        END
    end;


    procedure GetHostelDesc(HostelNo: Text) Message: Text
    begin
        HostelCard.RESET;
        HostelCard.SETRANGE(HostelCard."Asset No", HostelNo);
        IF HostelCard.FIND('-') THEN BEGIN
            Message := HostelCard.Description;

        END
    end;


    procedure GetRoomSpaceCosts(HostelNo: Text) Message: Text
    begin
        HostelBlockRooms.RESET;
        HostelBlockRooms.SETRANGE(HostelBlockRooms."Hostel Code", HostelNo);
        IF HostelRooms.FIND('-') THEN BEGIN
            Message := FORMAT(HostelBlockRooms."Room Cost") + '::' + FORMAT(HostelBlockRooms."JAB Fees") + '::' + FORMAT(HostelBlockRooms."SSP Fees");

        END
    end;


    procedure BookHostel(studentNo: Text; MyHostelNo: Text; MySemester: Text; myRoomNo: Text; MyAccomFee: Decimal; mySpaceNo: Text; MyspaceCost: Decimal) ReturnMessage: Text
    begin
        HostelRooms.RESET;
        HostelRooms.INIT;
        HostelRooms.SETRANGE(HostelRooms.Student, studentNo);
        HostelRooms.SETRANGE(HostelRooms.Semester, MySemester);
        IF NOT HostelRooms.FIND('-') THEN BEGIN
            HostelRooms.Student := studentNo;
            HostelRooms.Charges := MyspaceCost;
            HostelRooms."Space No" := mySpaceNo;
            HostelRooms."Room No" := myRoomNo;
            HostelRooms."Hostel No" := MyHostelNo;
            HostelRooms."Accomodation Fee" := MyAccomFee;
            HostelRooms."Allocation Date" := TODAY;
            HostelRooms.Semester := MySemester;
            HostelRooms.INSERT;

            RoomSpaces.RESET;
            RoomSpaces.SETRANGE(RoomSpaces."Space Code", mySpaceNo);
            IF RoomSpaces.FIND('-') THEN BEGIN
                RoomSpaces.Booked := TRUE;
                RoomSpaces.VALIDATE(RoomSpaces."Space Code");
                RoomSpaces.MODIFY;
                ReturnMessage := 'You have successfully booked ' + mySpaceNo + ' space::';
            END
            ELSE BEGIN
                ReturnMessage := 'You have already booked ' + mySpaceNo + ' space::';
            END
        END;
    end;


    procedure StudentSpecificTimetables(Semesters: Code[20]; StudentNo: Code[20]; TimetableType: Text[20]; filenameFromApp: Text) TimetableReturn: Text
    var
        ACACourseRegistration: Record "ACA-Course Registration";
        ACAStudentUnits: Record "ACA-Student Units";
        UnitFilterString: Text[1024];
        NoOfLoops: Integer;
        EXTTimetableFInalCollector: Record "EXT-Timetable FInal Collector";
        TTTimetableFInalCollector: Record "TT-Timetable FInal Collector";
        filename: Text;
    begin
        CLEAR(TimetableReturn);
        ACACourseRegistration.RESET;
        ACACourseRegistration.SETRANGE(Semester, Semesters);
        ACACourseRegistration.SETRANGE("Student No.", StudentNo);
        IF ACACourseRegistration.FIND('-') THEN BEGIN
            ACAStudentUnits.RESET;
            ACAStudentUnits.SETRANGE(Semester, Semesters);
            ACAStudentUnits.SETRANGE("Student No.", StudentNo);
            ACAStudentUnits.SETFILTER("Reg. Reversed", '=%1', FALSE);
            IF ACAStudentUnits.FIND('-') THEN BEGIN
                CLEAR(UnitFilterString);
                CLEAR(NoOfLoops);
                REPEAT
                BEGIN
                    IF NoOfLoops > 0 THEN
                        UnitFilterString := UnitFilterString + '|';
                    UnitFilterString := UnitFilterString + ACAStudentUnits.Unit;
                    NoOfLoops := NoOfLoops + 1;
                END;
                UNTIL ACAStudentUnits.NEXT = 0;
            END ELSE
                TimetableReturn := 'You have not registered for Units in ' + Semesters;
        END ELSE
            TimetableReturn := 'You are not registered in ' + Semesters;
        IF UnitFilterString <> '' THEN BEGIN
            //Render the timetables here
            //**1. Class Timetable
            IF TimetableType = 'CLASS' THEN BEGIN
                TTTimetableFInalCollector.RESET;
                TTTimetableFInalCollector.SETRANGE(Programme, ACACourseRegistration.Programmes);
                TTTimetableFInalCollector.SETRANGE(Semester, Semesters);
                TTTimetableFInalCollector.SETFILTER(Unit, UnitFilterString);
                IF TTTimetableFInalCollector.FIND('-') THEN BEGIN//Pull the Class Timetable Here
                    REPORT.RUN(report::"TT-Master Timetable (Final) 2", TRUE, FALSE, TTTimetableFInalCollector);
                    filename := FILESPATH + StudentNo + '_ClassTimetable_' + Semesters;
                    IF EXISTS(filename) THEN
                        ERASE(filename);
                    REPORT.SAVEASPDF(report::"TT-Master Timetable (Final) 2", filename, TTTimetableFInalCollector);
                END;
            END ELSE
                IF TimetableType = 'EXAM' THEN BEGIN
                    //**2. Exam Timetable
                    EXTTimetableFInalCollector.RESET;
                    EXTTimetableFInalCollector.SETRANGE(Programme, ACACourseRegistration.Programmes);
                    EXTTimetableFInalCollector.SETRANGE(Semester, Semesters);
                    EXTTimetableFInalCollector.SETFILTER(Unit, UnitFilterString);
                    IF EXTTimetableFInalCollector.FIND('-') THEN BEGIN//Pull the Exam Timetable Here
                        REPORT.RUN(report::"EXT-Master Timetable (Final) 2", TRUE, FALSE, EXTTimetableFInalCollector);
                        // // // //     filename :=FILESPATH_S+StudentNo+'_ExamTimetable_'+Semesters;
                        // // // //     IF EXISTS(filename) THEN
                        // // // //      ERASE(filename);
                        // // // //     REPORT.SAVEASPDF(74551,filename,EXTTimetableFInalCollector);
                    END;
                END;
        END;

        //EXIT(filename);
    end;


    procedure LecturerSpecificTimetables(Semesters: Code[20]; LecturerNo: Code[20]; TimetableType: Text[20]; filenameFromApp: Text[150]) TimetableReturn: Text
    var
        UnitFilterString: Text[1024];
        NoOfLoops: Integer;
        // EXTTimetableFInalCollector: Record "74568";
        // TTTimetableFInalCollector: Record "74523";
        ACALecturersUnits: Record "ACA-Lecturers Units";
        filename: Text;
    begin
        CLEAR(TimetableReturn);
        ACALecturersUnits.RESET;
        ACALecturersUnits.SETRANGE(Semester, Semesters);
        ACALecturersUnits.SETRANGE(Lecturer, LecturerNo);
        IF ACALecturersUnits.FIND('-') THEN BEGIN
            CLEAR(UnitFilterString);
            CLEAR(NoOfLoops);
            REPEAT
            BEGIN
                IF NoOfLoops > 0 THEN
                    UnitFilterString := UnitFilterString + '|';
                UnitFilterString := UnitFilterString + ACALecturersUnits.Unit;
                NoOfLoops := NoOfLoops + 1;
            END;
            UNTIL ACALecturersUnits.NEXT = 0;
        END ELSE
            TimetableReturn := 'You''ve not been allocated units in ' + Semesters;
        IF UnitFilterString <> '' THEN BEGIN
            //Render the timetables here
            //**1. Class Timetable
            IF TimetableType = 'CLASS' THEN BEGIN
                TTTimetableFInalCollector.RESET;
                TTTimetableFInalCollector.SETRANGE(Lecturer, LecturerNo);
                TTTimetableFInalCollector.SETRANGE(Semester, Semesters);
                TTTimetableFInalCollector.SETFILTER(Unit, UnitFilterString);
                IF TTTimetableFInalCollector.FIND('-') THEN BEGIN//Pull the Class Timetable Here
                                                                 //    REPORT.RUN(74501,TRUE,FALSE,TTTimetableFInalCollector);
                                                                 // filename :=FILESPATH_S+LecturerNo+'_ClassTimetable_'+Semesters;
                    filename := FILESPATH + filenameFromApp;
                    IF EXISTS(filename) THEN
                        ERASE(filename);
                    REPORT.SAVEASPDF(report::"TT-Master Timetable (Final) 2", filename, TTTimetableFInalCollector);
                END;
            END ELSE
                IF TimetableType = 'EXAM' THEN BEGIN
                    //**2. Exam Timetable
                    EXTTimetableFInalCollector.RESET;
                    EXTTimetableFInalCollector.SETRANGE(Semester, Semesters);
                    EXTTimetableFInalCollector.SETFILTER(Unit, UnitFilterString);
                    IF EXTTimetableFInalCollector.FIND('-') THEN BEGIN//Pull the Exam Timetable Here
                                                                      //  REPORT.RUN(74551,TRUE,FALSE,EXTTimetableFInalCollector);
                                                                      // filename :=FILESPATH_S+LecturerNo+'_ExamTimetable_'+Semesters;
                        filename := FILESPATH + filenameFromApp;
                        IF EXISTS(filename) THEN
                            ERASE(filename);
                        REPORT.SAVEASPDF(report::"EXT-Master Timetable (Final) 2", filename, EXTTimetableFInalCollector);
                    END;
                END;
        END;
    end;


    procedure KUCCPSLogin(username: Text) Message: Text
    var
        TXTIncorrectDetails: Label 'Incorrect Username or Password';
        TXTCorrectDetails: Label 'Login';
        TXTInactive: Label 'Your Account is not active';
        FullNames: Text;
    begin
        KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(KUCCPSRaw.Index, username);
        //EmployeeCard.SETRANGE(EmployeeCard.Status,EmployeeCard.Status::Active);
        IF KUCCPSRaw.FIND('-') THEN BEGIN
            FullNames := KUCCPSRaw.Names;
            Message := TXTCorrectDetails + '::' + KUCCPSRaw.Index + '::' + FullNames + '::' + KUCCPSRaw.Admin;
        END ELSE BEGIN
            Message := TXTIncorrectDetails + '::';
        END
    end;


    procedure GetKUCCPSUserData(username: Text) Message: Text
    begin
        KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(KUCCPSRaw.Index, username);
        IF KUCCPSRaw.FIND('-') THEN BEGIN
            Message := KUCCPSRaw.Admin + '::' + KUCCPSRaw.Names + '::' + FORMAT(KUCCPSRaw.Gender) + '::' +
  KUCCPSRaw.Email + '::' + KUCCPSRaw.Phone + '::' + GetSchool(KUCCPSRaw.Prog) + '::' + GetProgram(KUCCPSRaw.Prog) + '::' + KUCCPSRaw.Prog;

        END
    end;


    procedure Islecturer(username: Text) Message: Text
    var
        TXTIncorrectDetails: Label 'No';
        TXTCorrectDetails: Label 'Yes';
    begin
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            Message := FORMAT(EmployeeCard.Lecturer);
        END
    end;


    procedure VerifyOldStudentPassword(username: Text; OldPass: Text) Message: Text
    var
        TXTIncorrectDetails: Label 'No';
        TXTCorrectDetails: Label 'Yes';
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", username);
        Customer.SETRANGE(Customer.Password, OldPass);
        IF Customer.FIND('-') THEN BEGIN
            Message := TXTCorrectDetails;
        END ELSE BEGIN
            Message := TXTIncorrectDetails + '::';
        END
    end;


    procedure ChangeStudentPassword(username: Text; Pass: Text)
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", username);
        IF Customer.FIND('-') THEN BEGIN
            Customer.Password := Pass;
            Customer."Changed Password" := TRUE;
            Customer.MODIFY;
            MESSAGE('Password Updated Successfully');
        END;
    end;


    procedure CheckStudentPasswordChanged(username: Text) Message: Text
    var
        TXTIncorrectDetails: Label 'No';
        TXTCorrectDetails: Label 'Yes';
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", username);
        IF Customer.FIND('-') THEN BEGIN
            IF (Customer."Changed Password" = TRUE) THEN BEGIN
                Message := TXTCorrectDetails + '::' + FORMAT(Customer."Changed Password");
            END ELSE BEGIN
                Message := TXTIncorrectDetails + '::' + FORMAT(Customer."Changed Password");
            END
        END ELSE BEGIN
            Message := TXTIncorrectDetails + '::' + FORMAT(Customer."Changed Password");
        END
    end;


    procedure CheckStudentLoginForUnchangedPass(username: Text; Passwordz: Text) Message: Text
    var
        TXTIncorrectDetails: Label 'Warning!, login failed! Ensure you login with your Admission Number as both your username as well as password!';
        TXTCorrectDetails: Label 'Login';
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", username);
        //Customer.SETRANGE(Customer.Status,Customer.Status::);
        IF Customer.FIND('-') THEN BEGIN
            IF (Customer."No." = Passwordz) THEN BEGIN
                Message := TXTCorrectDetails + '::' + Customer."No." + '::' + Customer."E-Mail";
            END ELSE BEGIN
                Message := TXTIncorrectDetails + '::';
            END
        END ELSE BEGIN
            Message := TXTIncorrectDetails + '::';
        END
    end;


    procedure ChangeStaffPassword(username: Text; password: Text)
    begin
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            EmployeeCard."Portal Password" := password;
            EmployeeCard."Changed Password" := TRUE;
            EmployeeCard.MODIFY;
            MESSAGE('Password Updated Successfully');
        END;
    end;


    procedure PurchaseHeaderCreate(BusinessCode: Code[50]; DepartmentCode: Code[50]; ResponsibilityCentre: Code[50]; UserID: Text; Purpose: Text)
    begin
        NextLeaveApplicationNo := NoSeriesMgt.GetNextNo('QUO3456', 0D, TRUE);
        PurchaseRN.INIT;
        PurchaseRN."No." := NextLeaveApplicationNo;
        PurchaseRN."Document Type" := PurchaseRN."Document Type"::Quote;
        //PurchaseRN.Department:=DepartmentCode;
        PurchaseRN."Buy-from Vendor No." := 'DEPART';
        PurchaseRN."Pay-to Vendor No." := 'DEPART';
        PurchaseRN."Invoice Disc. Code" := 'DEPART';
        PurchaseRN."Shortcut Dimension 1 Code" := BusinessCode;
        PurchaseRN."Shortcut Dimension 2 Code" := DepartmentCode;
        PurchaseRN."Responsibility Center" := ResponsibilityCentre;
        PurchaseRN."Assigned User ID" := UserID;
        PurchaseRN."Order Date" := TODAY;
        PurchaseRN."Due Date" := TODAY;
        PurchaseRN."Expected Receipt Date" := TODAY;
        PurchaseRN."Posting Description" := Purpose;
        PurchaseRN.INSERT;
    end;

    procedure GetStudentRegStatus(username: Text) Message: Text
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", username);
        IF Customer.FIND('-') THEN BEGIN
            Message := FORMAT(Customer.Status);

        END
    end;


    procedure EvaluateLecturer(Programme: Text; Stage: Text; Unit: Text; Semester: Text; StudentNo: Text; LecturerNo: Text; QuestionNo: Text; Response: Text; EvaluationDate: Text; ResponseAnalysis: Integer)
    begin
        IF (Programme = '') THEN BEGIN
            ERROR('Programme cannot be null');
        END;
        IF (Semester = '') THEN BEGIN
            ERROR('Semester cannot be null');
        END
        ELSE BEGIN
            LecEvaluation.INIT;
            LecEvaluation.Programme := Programme;
            LecEvaluation.Stage := Stage;
            LecEvaluation.Unit := Unit;
            LecEvaluation.Semester := Semester;
            LecEvaluation."Student No" := StudentNo;
            LecEvaluation."Lecturer No" := LecturerNo;
            LecEvaluation."Question No" := QuestionNo;
            LecEvaluation.Response := Response;
            LecEvaluation."Date Time" := CURRENTDATETIME;
            LecEvaluation."Response Analysis" := ResponseAnalysis;
            LecEvaluation.INSERT(TRUE);

            StudentUnits.RESET;
            StudentUnits.INIT;
            StudentUnits.SETRANGE(StudentUnits."Student No.", StudentNo);
            StudentUnits.SETRANGE(StudentUnits.Unit, Unit);
            StudentUnits.SETRANGE(StudentUnits.Semester, Semester);
            IF StudentUnits.FIND('-') THEN BEGIN
                StudentUnits.Evaluated := TRUE;
                StudentUnits."Evaluated semester" := Semester;
                StudentUnits."Evaluated Date" := EvaluationDate;
                StudentUnits.MODIFY;
            END
        END;
    end;

    procedure GetEvaluated(Username: Text; "Program": Text; Stage: Text; Unit: Text; Sem: Text) Message: Text
    var
        TXTNotEvaluated: Label 'No';
        TXTEvaluated: Label 'Yes';
    begin
        LecEvaluation.RESET;
        LecEvaluation.SETRANGE(LecEvaluation."Student No", Username);
        LecEvaluation.SETRANGE(LecEvaluation.Programme, "Program");
        LecEvaluation.SETRANGE(LecEvaluation.Stage, Stage);
        LecEvaluation.SETRANGE(LecEvaluation.Unit, Unit);
        LecEvaluation.SETRANGE(LecEvaluation.Semester, Sem);
        IF LecEvaluation.FIND('-') THEN BEGIN
            Message := TXTEvaluated + '::';
        END ELSE BEGIN
            Message := TXTNotEvaluated + '::';
        END
    end;


    procedure GetSchool(Prog: Code[20]) SchoolName: Text
    var
        ACAProgramme2: Record "ACA-Programme";
        DimensionValue: Record "Dimension Value";
    begin
        CLEAR(SchoolName);
        IF ACAProgramme2.GET(Prog) THEN BEGIN
            DimensionValue.RESET;
            DimensionValue.SETRANGE("Dimension Code", 'FACULTY');
            DimensionValue.SETRANGE(Code, ACAProgramme2."School Code");
            IF DimensionValue.FIND('-') THEN SchoolName := DimensionValue.Name;
        END;
    end;


    procedure LoadAssignedScores(studentNo: Text; unitz: Text; ExamTypez: Text; Semz: Text) Message: Text
    begin
        ExamResults.RESET;
        ExamResults.SETRANGE(ExamResults."Student No.", studentNo);
        ExamResults.SETRANGE(ExamResults.Unit, unitz);
        ExamResults.SETRANGE(ExamResults.ExamType, ExamTypez);
        ExamResults.SETRANGE(ExamResults.Semester, Semz);
        IF ExamResults.FIND('-') THEN BEGIN
            Message := FORMAT(ExamResults.Score) + '::' + FORMAT(ExamResults."Edit Count");

        END
    end;


    procedure SubmitMarks(prog: Text; stage: Text; sem: Text; units: Text; StudentNo: Text; CatMark: Decimal; ExamTypes: Text; Reg_TransactonID: Text; AcademicYear: Text; username: Text; LectName: Text)
    begin
        ExamResults.RESET;
        ExamResults.SETRANGE(Programmes, prog);
        ExamResults.SETRANGE(Stage, stage);
        ExamResults.SETRANGE(Semester, sem);
        ExamResults.SETRANGE(Unit, units);
        ExamResults.SETRANGE("Student No.", StudentNo);
        ExamResults.SETRANGE(ExamType, ExamTypes);
        //ExamResults.SETRANGE("Reg. Transaction ID",Reg_TransactonID);
        IF NOT ExamResults.FIND('-') THEN BEGIN
            ExamResults.INIT;
            ExamResults.Programmes := prog;
            ExamResults.Stage := stage;
            ExamResults.Semester := sem;
            ExamResults.Unit := units;
            ExamResults."Student No." := StudentNo;
            ExamResults.Score := CatMark;
            ExamResults.ExamType := ExamTypes;
            ExamResults."Submitted On" := TODAY;
            ExamResults."Last Edited On" := TODAY;
            ExamResults.Exam := ExamTypes;
            ExamResults."Reg. Transaction ID" := Reg_TransactonID;
            ExamResults."User Name" := username;
            ExamResults."Lecturer Names" := LectName;
            IF ExamResults.INSERT THEN;
        END ELSE BEGIN
            ExamResults.Score := CatMark;
            ExamResults."User Name" := username;
            ExamResults."Lecturer Names" := LectName;
            ExamResults.MODIFY;
        END;
    end;


    procedure GetMaxScores(ProgCat: Text; Typez: Integer) Message: Text
    begin
        ExamsSetup.RESET;
        ExamsSetup.SETRANGE(ExamsSetup.Category, ProgCat);
        ExamsSetup.SETRANGE(ExamsSetup.Type, Typez);
        IF ExamsSetup.FIND('-') THEN BEGIN
            Message := FORMAT(ExamsSetup."Max. Score");

        END
    end;


    procedure GetDefaultProgramCategory(Progz: Text) Message: Text
    begin
        UnitSubjects.RESET;
        UnitSubjects.SETRANGE(UnitSubjects.Code, Progz);
        IF UnitSubjects.FIND('-') THEN BEGIN
            Message := UnitSubjects."Default Exam Category";
        END
    end;


    procedure GetProgramCategory(programz: Text) Message: Text
    begin
        Programme.RESET;
        Programme.SETRANGE(Programme.Code, programz);
        IF Programme.FIND('-') THEN BEGIN
            Message := Programme."Exam Category";
        END
    end;


    procedure GetFinalExamScore(StudentNo: Text; unitz: Text; ExmaType: Text) Message: Text
    begin
        ExamResults.RESET;
        ExamResults.SETRANGE(ExamResults."Student No.", StudentNo);
        ExamResults.SETRANGE(ExamResults.Unit, unitz);
        ExamResults.SETRANGE(ExamResults.ExamType, ExmaType);
        IF ExamResults.FIND('-') THEN BEGIN
            Message := FORMAT(ExamResults.Score);

        END
    end;


    procedure SubmitUnitsBasketsRegister(studentNo: Text; Unit: Text; Prog: Text; myStage: Text; sem: Text; RegTransID: Text; UnitDescription: Text; AcademicYear: Text; HODz: Text) Inserted: Boolean
    begin
        StudentUnitBaskets.INIT;
        StudentUnitBaskets."Student No." := studentNo;
        StudentUnitBaskets.Unit := Unit;
        StudentUnitBaskets."Unit Name" := UnitDescription;
        StudentUnitBaskets.Programme := Prog;
        StudentUnitBaskets.Stage := myStage;
        StudentUnitBaskets.Taken := TRUE;
        StudentUnitBaskets.Semester := sem;
        StudentUnitBaskets."Reg. Transacton ID" := RegTransID;
        StudentUnitBaskets.Description := UnitDescription;
        StudentUnitBaskets."Academic Year" := AcademicYear;
        // StudentUnitBaskets.HOD := HODz;
        // StudentUnitBaskets.Posted := FALSE;
        // StudentUnitBaskets.New := TRUE;
        StudentUnitBaskets.INSERT(TRUE);
        Inserted := TRUE;
    end;


    procedure GetAdmissionNo(IdNumber: Text) Message: Text
    begin
        AplicFormHeader.RESET;
        AplicFormHeader.SETRANGE(AplicFormHeader."ID Number", IdNumber);
        IF AplicFormHeader.FIND('-') THEN BEGIN
            Message := AplicFormHeader."Admission No" + '::' + AplicFormHeader."Application No." + '::' + AplicFormHeader."First Degree Choice" + '::' + FORMAT(AplicFormHeader.Gender) + '::' + FORMAT(AplicFormHeader."Academic Year");
        END
    end;

    procedure GetCourseApplicNumber(progz: Text; IDNumber: Text) Message: Text
    begin
        AplicFormHeader.RESET;
        AplicFormHeader.SETRANGE(AplicFormHeader."First Degree Choice", progz);
        AplicFormHeader.SETRANGE(AplicFormHeader."ID Number", IDNumber);
        IF AplicFormHeader.FIND('-') THEN BEGIN
            Message := AplicFormHeader."Application No." + '::' + FORMAT(AplicFormHeader."Points Acquired") + '::' + AplicFormHeader."Mean Grade Acquired";
        END
    end;


    procedure GeProgrammeMinimumPoints(ProgzCode: Text) Message: Text
    begin
        Programme.RESET;
        Programme.SETRANGE(Programme.Code, ProgzCode);
        IF Programme.FIND('-') THEN BEGIN
            Message := FORMAT(Programme."Minimum Points") + '::' + Programme."Minimum Grade";
        END
    end;


    procedure ValidateSubjectGrade(Programme: Text; SubjectCode: Text) Message: Text
    begin
        ProgEntrySubjects.RESET;
        ProgEntrySubjects.SETRANGE(ProgEntrySubjects.Programme, Programme);
        ProgEntrySubjects.SETRANGE(ProgEntrySubjects.Subject, SubjectCode);
        IF ProgEntrySubjects.FIND('-') THEN BEGIN
            Message := FORMAT(ProgEntrySubjects."Minimum Points") + '::' + ProgEntrySubjects."Minimum Grade" + '::' + GetAttainedPoints(ProgEntrySubjects."Minimum Grade");
        END
    end;


    procedure GetGradeForSelectedSubject(SubjectCode: Text; ApplicationNo: Text) Message: Text
    begin
        ApplicFormAcademic.RESET;
        ApplicFormAcademic.SETRANGE(ApplicFormAcademic."Subject Code", SubjectCode);
        ApplicFormAcademic.SETRANGE(ApplicFormAcademic."Application No.", ApplicationNo);
        IF ApplicFormAcademic.FIND('-') THEN BEGIN
            Message := ApplicFormAcademic.Grade;
        END
    end;


    procedure SubmitOnlineCourseApplication(Surnamez: Text; OtherNames: Text; DateOfBirth: Date; Gender: Integer; IDNumber: Text; PermanentHomeAddress: Text; CorrAddress: Text; MobileNo: Text; EmailAddress: Text; programz: Text; CampusCode: Text; ModeOfStudy: Text; HowDid: Text)
    begin
        AplicFormHeader.INIT;
        NextLeaveApplicationNo := NoSeriesMgt.GetNextNo('STD-APPLIC', 0D, TRUE);
        AplicFormHeader."Application No." := NextLeaveApplicationNo;
        AplicFormHeader.Date := TODAY;
        AplicFormHeader."Application Date" := TODAY;
        AplicFormHeader.Surname := Surnamez;
        AplicFormHeader."Other Names" := OtherNames;
        AplicFormHeader."Date Of Birth" := DateOfBirth;
        AplicFormHeader.Gender := Gender;
        AplicFormHeader."First Degree Choice" := programz;
        AplicFormHeader.School1 := GetSchool(programz);
        AplicFormHeader."ID Number" := IDNumber;
        AplicFormHeader."Address for Correspondence2" := PermanentHomeAddress;
        AplicFormHeader."Address for Correspondence1" := CorrAddress;
        AplicFormHeader."Telephone No. 1" := MobileNo;
        AplicFormHeader.Email := EmailAddress;
        AplicFormHeader."Emergency Email" := EmailAddress;
        AplicFormHeader.Campus := CampusCode;
        AplicFormHeader."No. Series" := 'STD-APPLIC';
        AplicFormHeader."Mode of Study" := ModeOfStudy;
        AplicFormHeader."Knew College Thru" := HowDid;
        AplicFormHeader.INSERT(TRUE);
    end;


    procedure SubmitSujects(ApplicationNo: Text; SubjectCode: Text; MinGrade: Text; Gradez: Text) Message: Text
    begin
        ApplicFormAcademic.RESET;
        ApplicFormAcademic.SETRANGE(ApplicFormAcademic."Application No.", ApplicationNo);
        ApplicFormAcademic.SETRANGE(ApplicFormAcademic."Subject Code", SubjectCode);

        IF NOT ApplicFormAcademic.FIND('-') THEN BEGIN
            ApplicFormAcademic.INIT;
            ApplicFormAcademic."Application No." := ApplicationNo;
            ApplicFormAcademic."Subject Code" := SubjectCode;
            ApplicFormAcademic."Min Grade" := MinGrade;
            ApplicFormAcademic.Grade := Gradez;
            ApplicFormAcademic.INSERT(TRUE);
        END ELSE BEGIN
            ApplicFormAcademic."Min Grade" := MinGrade;
            ApplicFormAcademic.Grade := Gradez;
            ApplicFormAcademic.MODIFY;
        END;
    end;


    procedure UpdateApplication(gradez: Text; pointz: Integer; ApplicationNo: Text)
    begin
        ApplicFormAcademic.RESET;
        ApplicFormAcademic.SETRANGE(ApplicFormAcademic."Application No.", ApplicationNo);

        IF ApplicFormAcademic.FIND('-') THEN BEGIN
            ApplicFormAcademic.Grade := gradez;
            ApplicFormAcademic.Points := pointz;
            ApplicFormAcademic.MODIFY;
        END;
    end;


    procedure GetAttainedPoints(AttainedCode: Code[30]) Message: Text
    var
        ACAApplicSetupGrade: Record "ACA-Applic. Setup";
    begin
        CLEAR(Message);
        IF ACAApplicSetupGrade.GET(AttainedCode) THEN BEGIN
            ACAApplicSetupGrade.RESET;
            IF ACAApplicSetupGrade.FIND('-') THEN;
            //Message := FORMAT(ACAApplicSetupGrade.Points);
        END;
    end;


    procedure CurrentIntake() Message: Text
    begin
        Intake.RESET;
        Intake.SETRANGE(Intake.Current, TRUE);
        IF Intake.FIND('-') THEN BEGIN
            Message := Intake.Code + '::' + Intake.Description;
        END
    end;

    procedure GetProgramSemesters(Progz: Code[50]) Message: Text
    begin
        Programme.RESET;
        Programme.SETRANGE(Code, Progz);
        Programme.SETRANGE("Use Stage Semesters", true);
        IF Programme.FIND('-') THEN BEGIN
            ProgramSem.RESET;
            ProgramSem.SETRANGE(ProgramSem."Programme Code", Progz);
            ProgramSem.SETRANGE(ProgramSem.Current, TRUE);
            IF ProgramSem.FIND('-') THEN BEGIN
                Message := ProgramSem.Semester;
            END;
        END ELSE BEGIN
            CurrentSem.RESET;
            CurrentSem.SETRANGE("Current Semester", true);
            IF CurrentSem.FIND('-') THEN BEGIN
                Message := CurrentSem.Code;
            END;
        END;
    end;


    procedure CheckFeeStatus(StudentN: Code[20]; Semest: Code[20]) Register: Code[20]
    var
        BilledAmount: Decimal;
        "50Percent": Decimal;
        Customerz1: Record Customer;
        ACACourseRegistrationz: Record "ACA-Course Registration";
    begin
        Register := 'NO';
        Customerz1.RESET;
        Customerz1.SETRANGE("No.", StudentN);
        IF Customerz1.FIND('-') THEN BEGIN
            /*IF Customerz1.CALCFIELDS(Balance) THEN;
            ACACourseRegistrationz.RESET;
            ACACourseRegistrationz.SETRANGE("Student No.", StudentN);
            ACACourseRegistrationz.SETRANGE(Semester, Semest);
            IF ACACourseRegistrationz.FIND('-') THEN BEGIN
                IF ACACourseRegistrationz.CALCFIELDS("Total Billed") THEN BEGIN
                IF NOT (Customerz1.Balance > ((ACACourseRegistrationz."Total Billed") / 2)) THEN Register := 'YES';
                END;
            END;*/
            Customerz1.CALCFIELDS(Balance, "Total Billed");
            IF NOT (Customerz1.Balance > ((Customerz1."Total Billed") / 2))
            THEN
                Register := 'YES';
        END;

        //MESSAGE('Register Status: '+Register);
    end;


    procedure UpdateApplicationLevel(ApplicNum: Text; NumSq: Integer)
    begin
        AplicFormHeader.RESET;
        AplicFormHeader.SETRANGE(AplicFormHeader."Application No.", ApplicNum);

        IF AplicFormHeader.FIND('-') THEN BEGIN
            AplicFormHeader.OnlineSeq := NumSq;
            AplicFormHeader.MODIFY;
        END;
    end;


    procedure UpdateApplicationIntake(AppLicNum: Text; Intake: Text; academicYear: Text)
    begin
        AplicFormHeader.RESET;
        AplicFormHeader.SETRANGE(AplicFormHeader."Application No.", AppLicNum);

        IF AplicFormHeader.FIND('-') THEN BEGIN
            AplicFormHeader."Academic Year" := academicYear;
            AplicFormHeader."Intake Code" := Intake;
            AplicFormHeader.MODIFY;
        END;
    end;


    procedure UpdateApplicationPayments(ApplicNum: Text; PayMode: Text; TransID: Text)
    begin
        AplicFormHeader.RESET;
        AplicFormHeader.SETRANGE(AplicFormHeader."Application No.", ApplicNum);

        IF AplicFormHeader.FIND('-') THEN BEGIN
            AplicFormHeader."Mode Of Payment" := PayMode;
            AplicFormHeader."Receipt Slip No." := TransID;
            AplicFormHeader.MODIFY;
        END;
    end;


    procedure GenerateAdmLetter(AdmNo: Text; filenameFromApp: Text)
    var
        filename: Text;
    begin
        filename := FILESPATH_A + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(KUCCPSRaw.Admin, AdmNo);

        IF KUCCPSRaw.FIND('-') THEN BEGIN
            //REPORT.SAVEASPDF(51343, filename, KUCCPSRaw);
            REPORT.SAVEASPDF(report::"Official Admission LetterJAb", filename, KUCCPSRaw);
            //AdmissionFormHeader.RESET;
            //AdmissionFormHeader.SETRANGE(AdmissionFormHeader."Admission No.",AdmNo);

            //IF AdmissionFormHeader.FIND('-') THEN BEGIN
            //REPORT.SAVEASPDF(51343,filename,AdmissionFormHeader);
            // REPORT.SAVEASPDF(51863,filename,AdmissionFormHeader);
        END;
    end;


    procedure GenerateOfferLetter(AdmNo: Text; filenameFromApp: Text)
    var
        filename: Text;
    begin
        filename := FILESPATH_SSP + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        AplicFormHeader.RESET;
        AplicFormHeader.SETRANGE(AplicFormHeader."Admission No", AdmNo);

        IF AplicFormHeader.FIND('-') THEN BEGIN
            //REPORT.SAVEASPDF(report::"TMUC Admission letter - SSP", filename, AplicFormHeader);
        END;
    end;


    procedure GetUnderApllicLevel(username: Text) Message: Text
    begin
        AplicFormHeader.RESET;
        AplicFormHeader.SETRANGE(AplicFormHeader.Email, username);
        AplicFormHeader.SETRANGE(AplicFormHeader."Post Graduate", FALSE);
        AplicFormHeader.SETFILTER(AplicFormHeader.OnlineSeq, '%1|%2|%3|%4', 1, 2, 3, 4);
        //AplicFormHeader.SETFILTER(AplicFormHeader.OnlineSeq,FORMAT(3));
        IF AplicFormHeader.FIND('-') THEN BEGIN
            Message := FORMAT(AplicFormHeader.OnlineSeq) + '::' + AplicFormHeader."First Degree Choice";

        END
    end;


    procedure GenerateAdmissionNo(var ProgCode: Code[20]; IndexNo: Code[30])
    var
        AdminSetup: Record "ACA-Adm. Number Setup";
        NewAdminCode: Code[20];
        KuccpsImport: Record "KUCCPS Imports";
    begin
        KuccpsImport.RESET;
        KuccpsImport.SETRANGE(Index, IndexNo);
        IF KuccpsImport.FIND('-') THEN BEGIN
            AdminSetup.RESET;
            AdminSetup.SETRANGE(AdminSetup.Degree, ProgCode);
            IF AdminSetup.FIND('-') THEN BEGIN
                NewAdminCode := NoSeriesMgt.GetNextNo(AdminSetup."No. Series", 0D, TRUE);
                NewAdminCode := AdminSetup."JAB Prefix" + '/' + NewAdminCode + '/' + AdminSetup.Year;
            END
            ELSE BEGIN
                ERROR('The Admission Number Setup For Programme ' + FORMAT(KuccpsImport.Prog) + ' Does Not Exist');
            END;
            KuccpsImport.Admin := NewAdminCode;
            KuccpsImport.Generated := TRUE;
            KuccpsImport.MODIFY;
        END;
    end;


    procedure UpdateStudentProfile(username: Text; genderz: Integer; DoB: Date; Countyz: Text; Tribes: Text; Disabled: Integer)
    begin
        StudentCard.RESET;
        StudentCard.SETRANGE(StudentCard."No.", username);
        IF StudentCard.FIND('-') THEN BEGIN
            StudentCard.Gender := genderz;
            StudentCard."Date Of Birth" := DoB;
            StudentCard.County := Countyz;
            StudentCard.Tribe := Tribes;
            StudentCard."Disability Status" := Disabled;
            StudentCard.MODIFY;
            MESSAGE('Updated Successfully');
        END;
    end;


    procedure GenerateKUCCPSFeeStructure(Programz: Code[20]; SettlementType: Code[20]; filenameFromApp: Text) filename: Text
    begin
        filename := FILESPATH_A + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        //MESSAGE('OK');
        Programme.RESET;
        Programme.SETRANGE(Programme.Code, Programz);
        Programme.SETFILTER(Programme."Settlement Type Filter", '%1', SettlementType);

        IF Programme.FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(report::"Fee Structure Generation", filename, Programme);   //52017726
        END;
        EXIT(filename);
    end;


    procedure HasAdmissionNumber(username: Text) Message: Text
    begin
        KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(KUCCPSRaw.Index, username);
        IF KUCCPSRaw.FIND('-') THEN BEGIN
            Message := KUCCPSRaw.Admin;

        END
    end;


    procedure GetPostApllicLevel(username: Text) Message: Text
    begin
        AplicFormHeader.RESET;
        AplicFormHeader.SETRANGE(AplicFormHeader.Email, username);
        AplicFormHeader.SETRANGE(AplicFormHeader."Post Graduate", TRUE);
        AplicFormHeader.SETFILTER(AplicFormHeader.OnlineSeq, '%1|%2|%3|%4|%5|%6', 1, 2, 3, 4, 5, 6);
        //AplicFormHeader.SETFILTER(AplicFormHeader.OnlineSeq,FORMAT(3));
        IF AplicFormHeader.FIND('-') THEN BEGIN
            Message := FORMAT(AplicFormHeader.OnlineSeq) + '::' + AplicFormHeader."First Degree Choice";

        END
    end;


    procedure SubmitOnlinePostCourseApplication(Surnamez: Text; OtherNames: Text; DateOfBirth: Date; Gender: Integer; IDNumber: Text; PermanentHomeAddress: Text; CorrAddress: Text; MobileNo: Text; EmailAddress: Text; programz: Text; CampusCode: Text; ModeOfStudy: Text; HowDid: Text; Intake: Text)
    begin
        AplicFormHeader.INIT;
        NextLeaveApplicationNo := NoSeriesMgt.GetNextNo('STD-APPLIC', 0D, TRUE);
        AplicFormHeader."Application No." := NextLeaveApplicationNo;
        AplicFormHeader.Date := TODAY;
        AplicFormHeader."Application Date" := TODAY;
        AplicFormHeader.Surname := Surnamez;
        AplicFormHeader."Other Names" := OtherNames;
        AplicFormHeader."Date Of Birth" := DateOfBirth;
        AplicFormHeader.Gender := Gender;
        AplicFormHeader."First Degree Choice" := programz;
        AplicFormHeader.School1 := GetSchool(programz);
        AplicFormHeader."ID Number" := IDNumber;
        AplicFormHeader."Address for Correspondence2" := PermanentHomeAddress;
        AplicFormHeader."Address for Correspondence1" := CorrAddress;
        AplicFormHeader."Telephone No. 1" := MobileNo;
        AplicFormHeader.Email := EmailAddress;
        AplicFormHeader."Emergency Email" := EmailAddress;
        AplicFormHeader.Campus := CampusCode;
        AplicFormHeader."Post Graduate" := TRUE;
        AplicFormHeader."No. Series" := 'STD-APPLIC';
        AplicFormHeader."Mode of Study" := ModeOfStudy;
        AplicFormHeader."Knew College Thru" := HowDid;
        AplicFormHeader."Intake Code" := Intake;
        AplicFormHeader.INSERT(TRUE);
    end;


    procedure PostFormerSchool(applicNo: Text; SchoolCode: Text)
    begin
        AplicFormHeader.RESET;
        AplicFormHeader.SETRANGE(AplicFormHeader."Application No.", applicNo);

        IF AplicFormHeader.FIND('-') THEN BEGIN
            AplicFormHeader."Former School Code" := SchoolCode;
            AplicFormHeader.MODIFY;
        END;
    end;


    procedure SubmitPostDegrees(ApplicationNo: Text; WhereObtained: Text; FromDate: Date; ToDate: Date; Qualificationz: Text; Awardz: Text; dateAwarded: Date)
    begin
        ApplicQualification.INIT;
        ApplicQualification."Application No." := ApplicationNo;
        ApplicQualification."Where Obtained" := WhereObtained;
        ApplicQualification."From Date" := FromDate;
        ApplicQualification."To Date" := ToDate;
        ApplicQualification.Qualification := Qualificationz;
        ApplicQualification.Award := Awardz;
        ApplicQualification."Date Awarded" := dateAwarded;
        ApplicQualification.INSERT(TRUE);
    end;


    procedure SubmitPostGrad(ApplicationNo: Text; OtherDegrees: Text; ResarchExperience: Text; Languages: Text; OtherResearchInstitution: Text; Sourceoffinance: Text)
    begin
        ApplicpPostGraduate.INIT;
        ApplicpPostGraduate.ApplicationNo := ApplicationNo;
        ApplicpPostGraduate."Other Degrees/Diploma" := OtherDegrees;
        ApplicpPostGraduate."Resarch Experience" := ResarchExperience;
        ApplicpPostGraduate.Languages := ResarchExperience;
        ApplicpPostGraduate."Other Research Institution" := OtherResearchInstitution;
        ApplicpPostGraduate."Source of finance" := Sourceoffinance;
        ApplicpPostGraduate.INSERT(TRUE);
    end;


    procedure SubmitPostEmployment(ApplicationNo: Text; Organisationz: Text; JobTitlez: Text; Fromz: Date; Toz: Date)
    begin
        ApplicPostEmployment.INIT;
        ApplicPostEmployment."Application No." := ApplicationNo;
        ApplicPostEmployment.Organisation := Organisationz;
        ApplicPostEmployment."Job Title" := JobTitlez;
        ApplicPostEmployment.From := Fromz;
        ApplicPostEmployment."To date" := Toz;
        ApplicPostEmployment.INSERT(TRUE);
    end;


    procedure SubmitForpHD(ApplicationNo: Text; MastersTypez: Integer; MasterthesisTitle: Text; MasterProjectTitle: Text)
    begin
        ApplicPhd.INIT;
        ApplicPhd."Application No" := ApplicationNo;
        ApplicPhd.MastersType := MastersTypez;
        ApplicPhd."Masters thesis Title" := MasterthesisTitle;
        ApplicPhd."Masters Project Title" := MasterProjectTitle;
        ApplicPhd.INSERT(TRUE);
    end;


    procedure SubmitReferees(ApplicationNoz: Text; Namez: Text; Titlez: Text; Addressz: Text; PhoneNo: Text; Faxz: Text; Emailz: Text)
    begin
        ApplicPostReferee.INIT;
        ApplicPostReferee.ApplicationNo := ApplicationNoz;
        ApplicPostReferee.Name := Namez;
        ApplicPostReferee.Title := Titlez;
        ApplicPostReferee.Address := Addressz;
        ApplicPostReferee."Phone No" := PhoneNo;
        ApplicPostReferee.Fax := Faxz;
        ApplicPostReferee.Email := Emailz;
        ApplicPostReferee.INSERT(TRUE);
    end;


    procedure GetPersonaldata(username: Text) Message: Text
    begin
        fabList.RESET;
        fabList.SETRANGE(fabList."Application No.", username);
        IF KUCCPSRaw.FIND('-') THEN BEGIN
            Message := KUCCPSRaw.Index + '::' + KUCCPSRaw.Admin + '::' + FORMAT(KUCCPSRaw.Prog) + '::' + KUCCPSRaw.Names + '::' + FORMAT(KUCCPSRaw.Gender) + '::' +
            KUCCPSRaw.Phone + '::' + KUCCPSRaw.Box + '::' + KUCCPSRaw.Codes + '::' + KUCCPSRaw.Town + '::' + KUCCPSRaw.Email + '::' + KUCCPSRaw."ID Number/Birth Certificate" + '::' +
            FORMAT(KUCCPSRaw."Date of Birth") + '::' + FORMAT(KUCCPSRaw.County) + '::' + FORMAT(KUCCPSRaw.Nationality) + '::' + FORMAT(KUCCPSRaw."Ethnic Background") + '::' +
            FORMAT(KUCCPSRaw."Disability Status") + '::' + KUCCPSRaw."Disability Description";
        END
    end;


    procedure KuccpsProfileUpdated(username: Text) Message: Text
    begin
        KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(KUCCPSRaw.Index, username);
        IF KUCCPSRaw.FIND('-') THEN BEGIN
            Message := FORMAT(KUCCPSRaw.Updated);
        END
    end;


    procedure GetReadyLetter(username: Text) Message: Text
    begin
        AplicFormHeader.RESET;
        AplicFormHeader.SETRANGE(AplicFormHeader.Email, username);
        AplicFormHeader.SETRANGE(AplicFormHeader.Status, AplicFormHeader.Status::"Admission Letter");

        IF AplicFormHeader.FIND('-') THEN BEGIN
            Message := FORMAT(AplicFormHeader.Status);

        END
    end;


    procedure IsStudentKuccpsRegistered(StudentNo: Text; Stage: Text) Message: Text
    var
        TXTNotRegistered: Label 'Not registered';
        TXTRegistered: Label 'Registered';
    begin
        CourseRegistration.RESET;
        CourseRegistration.SETRANGE(CourseRegistration."Student No.", StudentNo);
        CourseRegistration.SETRANGE(CourseRegistration.Stage, Stage);
        CourseRegistration.SETRANGE(CourseRegistration.Reversed, FALSE);
        IF CourseRegistration.FIND('-') THEN BEGIN
            Message := TXTRegistered + '::';
        END ELSE BEGIN
            Message := TXTNotRegistered + '::';
        END
    end;


    procedure HasKuccpsFinances(StudentNo: Text) Message: Text
    var
        TXTNotRegistered: Label 'No';
        TXTRegistered: Label 'Yes';
    begin
        ImportsBuffer.RESET;
        ImportsBuffer.SETRANGE(ImportsBuffer."Student No.", StudentNo);
        IF ImportsBuffer.FIND('-') THEN BEGIN
            Message := TXTRegistered + '::';
        END ELSE BEGIN
            Message := TXTNotRegistered + '::';
        END
    end;


    procedure TransferToAdmission(AdmissionNumber: Code[20])
    var
        AdminSetup: Record "KUCCPS Imports";
        NewAdminCode: Code[20];
    begin
        /*This function transfers the fieldsin the application to the fields in the admissions table*/
        /*Get the new admission code for the selected application*/

        AdminSetup.RESET;
        AdminSetup.SETRANGE(AdminSetup.Admin, AdmissionNumber);
        IF AdminSetup.FIND('-') THEN BEGIN
            Customer.INIT;
            Customer."No." := AdminSetup.Admin;
            Customer.Name := COPYSTR(AdminSetup.Names, 1, 80);
            Customer."Search Name" := UPPERCASE(COPYSTR(AdminSetup.Names, 1, 80));
            Customer.Address := AdminSetup.Box;
            IF AdminSetup.Box <> '' THEN
                Customer."Address 2" := COPYSTR(AdminSetup.Box + ',' + AdminSetup.Codes, 1, 30);
            IF AdminSetup.Phone <> '' THEN
                Customer."Phone No." := AdminSetup.Phone + ',' + AdminSetup."Alt. Phone";
            //  Customer."Telex No.":=Rec."Fax No.";
            Customer."E-Mail" := AdminSetup.Email;
            Customer.Gender := AdminSetup.Gender;
            Customer."Date Of Birth" := AdminSetup."Date of Birth";
            Customer."Date Registered" := TODAY;
            Customer."Customer Type" := Customer."Customer Type"::Student;
            //Customer."Student Type":=FORMAT(Enrollment."Student Type");
            Customer."Date Of Birth" := AdminSetup."Date of Birth";
            Customer."ID No" := AdminSetup."ID Number/Birth Certificate";
            Customer."Application No." := AdminSetup.Admin;
            //Customer."Marital Status":=AdminSetup."Marital Status";
            Customer.Citizenship := FORMAT(AdminSetup.Nationality);
            Customer."Current Programme" := AdminSetup.Prog;
            Customer."Current Semester" := 'SEM1 20/21';
            Customer."Current Stage" := 'Y1S1';
            //Customer.Religion:=FORMAT(AdminSetup.Religion);
            Customer."Application Method" := Customer."Application Method"::"Apply to Oldest";
            Customer."Customer Posting Group" := 'STUDENT';
            Customer.VALIDATE(Customer."Customer Posting Group");
            Customer."Global Dimension 1 Code" := 'MAIN';
            Customer.County := AdminSetup.County;
            Customer.INSERT();

            ////////////////////////////////////////////////////////////////////////////////////////


            Customer.RESET;
            Customer.SETRANGE("No.", AdminSetup.Admin);
            //Customer.SETFILTER("Date Registered",'=%1',TODAY);
            IF Customer.FIND('-') THEN BEGIN
                IF AdminSetup.Gender = AdminSetup.Gender::Female THEN BEGIN
                    Customer.Gender := Customer.Gender::Female;
                END ELSE BEGIN
                    Customer.Gender := Customer.Gender::Male;
                END;
                Customer.MODIFY;
            END;

            Customer.RESET;
            Customer.SETRANGE("No.", AdminSetup.Admin);
            Customer.SETFILTER("Date Registered", '=%1', TODAY);
            IF Customer.FIND('-') THEN BEGIN
                CourseRegistration.RESET;
                CourseRegistration.SETRANGE("Student No.", AdminSetup.Admin);
                CourseRegistration.SETRANGE("Settlement Type", 'JAB');
                CourseRegistration.SETRANGE(Programmes, AdminSetup.Prog);
                CourseRegistration.SETRANGE(Semester, 'SEM1 20/21');
                IF NOT CourseRegistration.FIND('-') THEN BEGIN
                    CourseRegistration.INIT;
                    CourseRegistration."Reg. Transacton ID" := '';
                    CourseRegistration.VALIDATE(CourseRegistration."Reg. Transacton ID");
                    CourseRegistration."Student No." := AdminSetup.Admin;
                    CourseRegistration.Programmes := AdminSetup.Prog;
                    CourseRegistration.Semester := 'SEM1 20/21';
                    CourseRegistration.Stage := 'Y1S1';
                    CourseRegistration."Student Type" := CourseRegistration."Student Type"::"Full Time";
                    CourseRegistration."Registration Date" := TODAY;
                    CourseRegistration."Settlement Type" := 'JAB';
                    CourseRegistration."Academic Year" := '2020/2021';

                    //CourseRegistration.VALIDATE(CourseRegistration."Settlement Type");
                    CourseRegistration.INSERT;
                    CourseRegistration.RESET;
                    CourseRegistration.SETRANGE("Student No.", AdminSetup.Admin);
                    CourseRegistration.SETRANGE("Settlement Type", 'JAB');
                    CourseRegistration.SETRANGE(Programmes, AdminSetup.Prog);
                    CourseRegistration.SETRANGE(Semester, 'SEM1 20/21');
                    IF CourseRegistration.FIND('-') THEN BEGIN
                        CourseRegistration."Settlement Type" := 'JAB';
                        CourseRegistration.VALIDATE(CourseRegistration."Settlement Type");
                        CourseRegistration."Academic Year" := '2020/2021';
                        CourseRegistration."Registration Date" := TODAY;
                        CourseRegistration.VALIDATE(CourseRegistration."Registration Date");
                        CourseRegistration.MODIFY;

                    END;
                END ELSE BEGIN
                    CourseRegistration.RESET;
                    CourseRegistration.SETRANGE("Student No.", AdminSetup.Admin);
                    CourseRegistration.SETRANGE("Settlement Type", 'JAB');
                    CourseRegistration.SETRANGE(Programmes, AdminSetup.Prog);
                    CourseRegistration.SETRANGE(Semester, 'SEM1 20/21');
                    CourseRegistration.SETFILTER(Posted, '=%1', FALSE);
                    IF CourseRegistration.FIND('-') THEN BEGIN
                        CourseRegistration."Settlement Type" := 'JAB';
                        CourseRegistration.VALIDATE(CourseRegistration."Settlement Type");
                        CourseRegistration."Academic Year" := '2020/2021';
                        CourseRegistration."Registration Date" := TODAY;
                        CourseRegistration.VALIDATE(CourseRegistration."Registration Date");
                        CourseRegistration.MODIFY;

                    END;
                END;
            END;


            /*Get the record and transfer the details to the admissions database*/
            //ERROR('TEST- '+NewAdminCode);
            /*Transfer the details into the admission database table*/
            Admissions.INIT;
            Admissions."Admission No" := AdminSetup.Admin;
            Admissions.VALIDATE("Admission No");
            Admissions.Date := TODAY;
            Admissions."Application No." := AdminSetup.Index;
            Admissions."Settlement Type" := 'JAB';
            Admissions."Academic Year" := '2020/2021';
            Admissions.Surname := AdminSetup.Names;
            Admissions."Other Names" := AdminSetup.Names;
            Admissions.Status := Admissions.Status::Approved;
            Admissions."Admitted Degree" := AdminSetup.Prog;
            Admissions.VALIDATE("Admitted Degree");
            Admissions."Date Of Birth" := AdminSetup."Date of Birth";
            Admissions.Gender := AdminSetup.Gender + 1;
            //Admissions."Marital Status":=AdminSetup."Marital Status";
            Admissions.County := AdminSetup.County;
            Admissions.Campus := 'MAIN';
            Admissions.Nationality := AdminSetup.Nationality;
            Admissions."Address for Correspondence1" := AdminSetup.Box;
            Admissions."Address for Correspondence2" := AdminSetup.Codes;
            Admissions."Address for Correspondence3" := AdminSetup.Town;
            Admissions."Telephone No. 1" := AdminSetup.Phone;
            Admissions."Telephone No. 2" := AdminSetup."Alt. Phone";
            //Admissions."Former School Code":=AdminSetup."Former School Code";
            Admissions."Index Number" := AdminSetup.Index;
            Admissions."Admitted To Stage" := 'Y1S1';
            Admissions."Admitted Semester" := 'SEM1 20/21';
            Admissions."Settlement Type" := 'KUCCPS';
            Admissions."Intake Code" := AdminSetup."Intake Code";
            Admissions."ID Number" := AdminSetup."ID Number/Birth Certificate";
            Admissions.Email := AdminSetup.Email;
            // Admissions."Telephone No. 1":=AdminSetup."Telephone No. 1";
            // Admissions."Telephone No. 2":=AdminSetup."Telephone No. 1";
            Admissions.INSERT();
            AdminSetup.Admin := NewAdminCode;
            /*Get the subject details and transfer the  same to the admissions subject*/
            ApplicationSubject.RESET;
            ApplicationSubject.SETRANGE(ApplicationSubject."Application No.", AdminSetup.Admin);
            IF ApplicationSubject.FIND('-') THEN BEGIN
                /*Get the last number in the admissions table*/
                AdmissionSubject.RESET;
                IF AdmissionSubject.FIND('+') THEN BEGIN
                    // LineNo := AdmissionSubject."Line No." + 1;
                END
                ELSE BEGIN
                    LineNo := 1;
                END;

                /*Insert the new records into the database table*/
                REPEAT
                    // INIT;
                    // "Line No." := LineNo + 1;
                    // "Admission No." := NewAdminCode;
                    // "Subject Code" := ApplicationSubject."Subject Code";
                    // Grade := Grade;
                    // INSERT();
                    LineNo := LineNo + 1;
                UNTIL ApplicationSubject.NEXT = 0;
            END;
            /*Insert the medical conditions into the admission database table containing the medical condition*/
            MedicalCondition.RESET;
            MedicalCondition.SETRANGE(MedicalCondition.Mandatory, TRUE);
            IF MedicalCondition.FIND('-') THEN BEGIN
                /*Get the last line number from the medical condition table for the admissions module*/
                AdmissionMedical.RESET;
                IF AdmissionMedical.FIND('+') THEN BEGIN
                    LineNo := AdmissionMedical."Line No." + 1;
                END
                ELSE BEGIN
                    LineNo := 1;
                END;
                AdmissionMedical.RESET;
                /*Loop thru the medical conditions*/
                REPEAT
                    AdmissionMedical.INIT;
                    AdmissionMedical."Line No." := LineNo + 1;
                    AdmissionMedical."Admission No." := NewAdminCode;
                    AdmissionMedical."Medical Condition Code" := MedicalCondition.Code;
                    AdmissionMedical.INSERT();
                    LineNo := LineNo + 1;
                UNTIL MedicalCondition.NEXT = 0;
            END;
            /*Insert the details into the family table*/
            MedicalCondition.RESET;
            MedicalCondition.SETRANGE(MedicalCondition.Mandatory, TRUE);
            MedicalCondition.SETRANGE(MedicalCondition.Family, TRUE);
            IF MedicalCondition.FIND('-') THEN BEGIN
                /*Get the last number in the family table*/
                AdmissionFamily.RESET;
                IF AdmissionFamily.FIND('+') THEN BEGIN
                    LineNo := AdmissionFamily."Line No.";
                END
                ELSE BEGIN
                    LineNo := 0;
                END;
                REPEAT
                    AdmissionFamily.INIT;
                    AdmissionFamily."Line No." := LineNo + 1;
                    AdmissionFamily."Medical Condition Code" := MedicalCondition.Code;
                    AdmissionFamily."Admission No." := NewAdminCode;
                    AdmissionFamily.INSERT();
                    LineNo := LineNo + 1;
                UNTIL MedicalCondition.NEXT = 0;
            END;

            /*Insert the immunization details into the database*/
            Immunization.RESET;
            //Immunization.SETRANGE(Immunization.Mandatory,TRUE);
            IF Immunization.FIND('-') THEN BEGIN
                /*Get the last line number from the database*/
                AdmissionImmunization.RESET;
                IF AdmissionImmunization.FIND('+') THEN BEGIN
                    LineNo := AdmissionImmunization."Line No." + 1;
                END
                ELSE BEGIN
                    LineNo := 1;
                END;
                /*loop thru the immunizations table adding the details into the admissions table for immunizations*/
                REPEAT
                    AdmissionImmunization.INIT;
                    AdmissionImmunization."Line No." := LineNo + 1;
                    AdmissionImmunization."Admission No." := NewAdminCode;
                    AdmissionImmunization."Immunization Code" := Immunization.Code;
                    AdmissionImmunization.INSERT();
                UNTIL Immunization.NEXT = 0;
            END;

            TakeStudentToRegistration(NewAdminCode);
        END;

    end;


    procedure TakeStudentToRegistration(var AdmissNo: Code[20])
    begin
        Admissions.RESET;
        Admissions.SETRANGE("Admission No", AdmissNo);
        IF Admissions.FIND('-') THEN BEGIN

            //insert the details related to the next of kin of the student into the database
            AdminKin.RESET;
            AdminKin.SETRANGE(AdminKin."Admission No.", Admissions."Admission No");
            IF AdminKin.FIND('-') THEN BEGIN
                REPEAT
                    StudentKin.RESET;
                    StudentKin.INIT;
                    StudentKin."Student No" := Admissions."Admission No";
                    StudentKin.Relationship := AdminKin.Relationship;
                    StudentKin.Name := AdminKin."Full Name";
                    //StudentKin."Other Names":=EnrollmentNextofKin."Other Names";
                    //StudentKin."ID No/Passport No":=EnrollmentNextofKin."ID No/Passport No";
                    //StudentKin."Date Of Birth":=EnrollmentNextofKin."Date Of Birth";
                    //StudentKin.Occupation:=EnrollmentNextofKin.Occupation;
                    StudentKin."Office Tel No" := AdminKin."Telephone No. 1";
                    StudentKin."Home Tel No" := AdminKin."Telephone No. 2";
                    //StudentKin.Remarks:=EnrollmentNextofKin.Remarks;
                    StudentKin.INSERT;
                UNTIL AdminKin.NEXT = 0;
            END;

            //insert the details in relation to the guardian/sponsor into the database in relation to the current student
            // IF Admissions."Mother Alive Or Dead" = Admissions."Mother Alive Or Dead"::Alive THEN BEGIN
            //     IF Admissions."Mother Full Name" <> '' THEN BEGIN
            //         StudentGuardian.RESET;
            //         StudentGuardian.INIT;
            //         StudentGuardian."Student No." := Admissions."Admission No.";
            //         StudentGuardian.Names := Admissions."Mother Full Name";
            //         StudentGuardian.INSERT;
            //     END;
            // END;
            // IF Admissions."Father Alive Or Dead" = Admissions."Father Alive Or Dead"::Alive THEN BEGIN
            //     IF Admissions."Father Full Name" <> '' THEN BEGIN
            //         StudentGuardian.RESET;
            //         StudentGuardian.INIT;
            //         StudentGuardian."Student No." := Admissions."Admission No.";
            //         StudentGuardian.Names := Admissions."Father Full Name";
            //         StudentGuardian.INSERT;
            //     END;
            // END;
            // IF Admissions."Guardian Full Name" <> '' THEN BEGIN
            //     IF Admissions."Guardian Full Name" <> '' THEN BEGIN
            //         StudentGuardian.RESET;
            //         StudentGuardian.INIT;
            //         StudentGuardian."Student No." := Admissions."Admission No.";
            //         StudentGuardian.Names := Admissions."Guardian Full Name";
            //         StudentGuardian.INSERT;
            //     END;
            // END;
        END;
    end;


    procedure SubmitReferral(Username: Text; Reason: Text)
    begin
        /*This function transfers the fieldsin the application to the fields in the admissions table*/
        /*Get the new admission code for the selected application*/
        /*NextLeaveApplicationNo:=NoSeriesMgt.GetNextNo('HOSPAPP',0D,TRUE);
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.",Username);
        IF EmployeeCard.FIND('-') THEN
          BEGIN
           Referrralll.INIT;
                Referrralll."Treatment no.":=NextLeaveApplicationNo;
                Referrralll."Date Referred":=TODAY;
                Referrralll."Referral Reason":=Reason;
                Referrralll.Status:=Referrralll.Status::"0";
                Referrralll.Surname:=EmployeeCard."Last Name";
                Referrralll."Middle Name":=EmployeeCard."Middle Name";
                Referrralll."Last Name":=EmployeeCard."First Name";
                Referrralll."ID Number":=EmployeeCard."First Name";
                Referrralll."Correspondence Address 1":=EmployeeCard."Postal Address";
                Referrralll."Telephone No. 1":=EmployeeCard."Cellular Phone Number";
                Referrralll.Email:=EmployeeCard."Company E-Mail";
                //Referrralll."Staff No":=Username;
                //Referrralll."No. Series":='HOSPAPP';
                Referrralll.INSERT();
                END;*/

    end;


    procedure GetMyApprovals_LeaveTotal(ApproverID: Text) Message: Text
    begin
        ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE(ApprovalEntry."Approver ID", ApproverID);
        ApprovalEntry.SETRANGE(ApprovalEntry."Approval Code", 'LEAVE');
        ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        IF KUCCPSRaw.FIND('-') THEN BEGIN
            Message := FORMAT(ApprovalEntry.COUNT);
        END
    end;


    procedure GetPRNHeaderDetails(PurchaseNo: Text) Message: Text
    begin
        PurchaseRN.RESET;
        PurchaseRN.SETRANGE(PurchaseRN."No.", PurchaseNo);
        IF PurchaseRN.FIND('-') THEN BEGIN
            Message := FORMAT(PurchaseRN."Expected Receipt Date");
        END
    end;

    procedure GetApprovalStatus(DocumentNo: Text) Message: Text
    begin
        ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", DocumentNo);
        IF ApprovalEntry.FIND('-') THEN BEGIN
            Message := FORMAT(ApprovalEntry.Status);
        END
    end;



    procedure CancelApprovalRequest(ReqNo: Text)
    begin
        ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", ReqNo);
        IF ApprovalEntry.FIND('-') THEN BEGIN
            ApprovalEntry.DELETE;
            PurchaseRN.RESET;
            PurchaseRN.SETRANGE(PurchaseRN."No.", ReqNo);
            IF PurchaseRN.FIND('-') THEN BEGIN
                PurchaseRN.Status := PurchaseRN.Status::Open;
                PurchaseRN.MODIFY;
            END;
        END;
    end;



    procedure GetTotalStoresReq(UserID: Text) Message: Text
    begin
        ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE(ApprovalEntry."Approver ID", UserID);
        ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        ApprovalEntry.SETRANGE(ApprovalEntry."Approver ID", UserID);
        ApprovalEntry.SETRANGE(ApprovalEntry."Approver ID", UserID);
        IF ApprovalEntry.FIND('+') THEN BEGIN
            Message := ApprovalEntry."Approver ID";
        END
    end;


    procedure StudentProfileUpdated(username: Text) Message: Text
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", username);
        IF Customer.FIND('-') THEN BEGIN
            Message := FORMAT(Customer."Updated Profile");
        END
    end;

    procedure StudentProfileUnUpdated(username: Text) Message: Text
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", username);
        IF Customer.FIND('-') THEN BEGIN
            Customer."Updated Profile" := false;
            Customer.MODIFY;
        END
    end;

    procedure GetStudentPersonaldata(username: Text) Message: Text
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", username);
        IF Customer.FIND('-') THEN BEGIN
            Message := Customer.Name + '::' + FORMAT(Customer.Gender) + '::' + Customer."ID No" + '::' + FORMAT(Customer."Date Of Birth") + '::' +
            Customer."Phone No." + '::' + FORMAT(Customer."Disability Status") + '::' + FORMAT(Customer.Tribe) + '::' + FORMAT(Customer.Nationality)
            + '::' + FORMAT(Customer.County) + '::' +
            Customer.Address + '::' + Customer."Post Code" + '::' + Customer."Address 2" + '::' + Customer."Disability Description" + '::' +
            Customer."E-Mail";
        END
    end;


    procedure UpdateContStudentProfile(username: Text; Genderz: Integer; Phonez: Code[20]; Boxz: Code[50]; Codesz: Code[20]; Townz: Code[40]; Emailz: Text; Countyz: Code[50]; DateofBirth: Date; IDNumber: Text; PhysicalImpairments: Integer; Ethnic: Code[50]; Nationalityz: Code[50]; fit: Text[20])
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", username);
        IF Customer.FIND('-') THEN BEGIN
            Customer.Gender := Genderz;
            Customer."ID No" := IDNumber;
            Customer."Date Of Birth" := DateofBirth;
            Customer."Phone No." := Phonez;
            Customer."Disability Status" := PhysicalImpairments;
            Customer.Tribe := Ethnic;
            Customer.Ethnicity := Ethnic;
            Customer.Nationality := Nationalityz;
            Customer.County := Countyz;
            Customer.Address := Boxz;
            Customer."Post Code" := Codesz;
            Customer."Address 2" := Townz;
            //Customer."Disability Description" := PhysicalImpairmentsDetails;
            Customer."E-Mail" := Emailz;
            Customer."Updated Profile" := TRUE;
            Customer.MODIFY;
            //MESSAGE('Meal Item Updated Successfully');
        END;
    end;


    procedure GetUniversityMailPass(username: Text) Message: Text
    begin
        StudentCard.RESET;
        StudentCard.SETRANGE(StudentCard."No.", username);
        IF StudentCard.FIND('-') THEN BEGIN
            Message := StudentCard."University Email" + '::' + StudentCard."Email Password" + '::' + StudentCard."Phone No.";

        END
    end;

    procedure SubmitSupUnitsBaskets(studentNo: Text; AcademicYear: Text; Sem: Text; myStage: Text; Programmez: Text; UnitCode: Text; Catogoryz: Integer; UnitDesc: Text)
    begin
        SupUnitsBasket.RESET;
        SupUnitsBasket.SETRANGE(SupUnitsBasket."Academic Year", AcademicYear);
        SupUnitsBasket.SETRANGE(SupUnitsBasket."Student No.", studentNo);
        SupUnitsBasket.SETRANGE(SupUnitsBasket."Unit Code", UnitCode);
        SupUnitsBasket.SETRANGE(SupUnitsBasket.Stage, myStage);
        SupUnitsBasket.SETRANGE(SupUnitsBasket.Semester, Sem);
        IF NOT SupUnitsBasket.FIND('-') THEN BEGIN
            SupUnitsBasket.INIT;
            SupUnitsBasket."Academic Year" := AcademicYear;
            SupUnitsBasket.Semester := Sem;
            SupUnitsBasket."Student No." := studentNo;
            SupUnitsBasket.Stage := myStage;
            SupUnitsBasket.Programme := Programmez;
            SupUnitsBasket."Unit Code" := UnitCode;
            SupUnitsBasket."Unit Description" := UnitDesc;
            SupUnitsBasket.Status := SupUnitsBasket.Status::New;
            SupUnitsBasket.Catogory := Catogoryz;
            SupUnitsBasket.INSERT(TRUE);
        END ELSE BEGIN
            SupUnitsBasket.MODIFY;
        END;
    end;

    procedure SubmitHistSupUnitsBaskets(studentNo: Text; AcademicYear: Text; Session: Text; Sem: Text; category: integer; Programmez: Text; UnitCode: Text; UnitDesc: Text)
    var
        SupUnitsBasket1: Record "Aca-Special Exams Basket";
    begin
        SupUnitsBasket1.RESET;
        SupUnitsBasket1.SETRANGE(SupUnitsBasket1."Student No.", studentNo);
        SupUnitsBasket1.SETRANGE(SupUnitsBasket1."Unit Code", UnitCode);
        IF SupUnitsBasket1.FIND('-') THEN BEGIN
            SupUnitsBasket1.Delete();
        END;
        SupUnitsBasket.INIT;
        SupUnitsBasket."Academic Year" := AcademicYear;
        SupUnitsBasket."Exam Session" := Session;
        SupUnitsBasket.Semester := Sem;
        SupUnitsBasket.Catogory := Category;
        SupUnitsBasket."Student No." := studentNo;
        SupUnitsBasket.Programme := Programmez;
        SupUnitsBasket."Unit Code" := UnitCode;
        SupUnitsBasket."Unit Description" := UnitDesc;
        SupUnitsBasket.Status := SupUnitsBasket.Status::New;
        SupUnitsBasket.INSERT(TRUE);
    end;

    procedure SubmitHistSupUnits(studentNo: Text; AcademicYear: Text; Programmez: Text; UnitCode: Text; UnitDesc: Text; ThisemacYear: Text; CurrentSem: Text; session: Text; Category: Integer)
    begin
        SupUnits.RESET;
        SupUnits.SETRANGE(SupUnits."Student No.", studentNo);
        SupUnits.SETRANGE(SupUnits.Programme, Programmez);
        SupUnits.SETRANGE(SupUnits."Unit Code", UnitCode);
        SupUnits.SETRANGE(SupUnits."Academic Year", AcademicYear);
        SupUnits.SETRANGE(SupUnits."Current Semester", CurrentSem);
        IF NOT SupUnits.FIND('-') THEN BEGIN
            SupUnits.INIT;
            SupUnits."Academic Year" := AcademicYear;
            SupUnits."Student No." := studentNo;
            SupUnits.Programme := Programmez;
            SupUnits."Unit Code" := UnitCode;
            SupUnits."Unit Description" := UnitDesc;
            SupUnits.Status := SupUnits.Status::New;
            SupUnits."Current Academic Year" := ThisemacYear;
            SupUnits."Current Semester" := CurrentSem;
            SupUnits."Exam Session" := Session;
            SupUnits.Catogory := Category;
            SupUnits.Validate("Unit Code");
            SupUnits.INSERT(TRUE);

            SupUnitsBasket.RESET;
            SupUnitsBasket.SETRANGE(SupUnitsBasket."Student No.", studentNo);
            SupUnitsBasket.SETRANGE(SupUnitsBasket.Programme, Programmez);
            SupUnitsBasket.SETRANGE(SupUnitsBasket."Unit Code", UnitCode);
            SupUnitsBasket.SETRANGE(SupUnitsBasket."Academic Year", AcademicYear);
            IF SupUnitsBasket.FIND('-') THEN BEGIN
                SupUnitsBasket.DELETE;
            END;
        END
        else begin
            error('This unit is already registered for in the current semester!');
        end;
    end;

    procedure DeleteHistSupUnits(studentNo: Text; UnitCode: Text; CurrentSem: Text; category: Integer) deleted: Boolean
    begin
        SupUnits.RESET;
        SupUnits.SETRANGE(SupUnits."Student No.", studentNo);
        SupUnits.SETRANGE(SupUnits.Catogory, category);
        SupUnits.SETRANGE(SupUnits."Unit Code", UnitCode);
        SupUnits.SETRANGE(SupUnits."Current Semester", CurrentSem);
        IF SupUnits.FIND('-') THEN BEGIN
            SupUnits.Delete();
            deleted := true;
        END;
    end;

    procedure SubmitSupUnits(studentNo: Text; AcademicYear: Text; Sem: Text; myStage: Text; Programmez: Text; UnitCode: Text; Catogoryz: Integer; UnitDesc: Text; ThisemacYear: Text; CurrentSem: Text)
    begin
        SupUnits.RESET;
        SupUnits.SETRANGE(SupUnits."Student No.", studentNo);
        SupUnits.SETRANGE(SupUnits."Unit Code", UnitCode);
        SupUnits.SETRANGE(SupUnits.Stage, myStage);
        SupUnits.SETRANGE(SupUnits.Semester, Sem);
        SupUnits.SETRANGE(SupUnits."Academic Year", AcademicYear);
        IF NOT SupUnits.FIND('-') THEN BEGIN
            SupUnits.INIT;
            SupUnits."Academic Year" := AcademicYear;
            SupUnits.Semester := Sem;
            SupUnits."Student No." := studentNo;
            SupUnits.Stage := myStage;
            SupUnits.Programme := Programmez;
            SupUnits."Unit Code" := UnitCode;
            SupUnits."Unit Description" := UnitDesc;
            SupUnits.Status := SupUnits.Status::New;
            SupUnits.Catogory := Catogoryz;
            SupUnits."Current Academic Year" := ThisemacYear;
            SupUnits."Current Semester" := CurrentSem;
            SupUnits.INSERT(TRUE);
            SupUnits.VALIDATE("Unit Code");
            SupUnitsBasket.RESET;
            SupUnitsBasket.SETRANGE(SupUnitsBasket."Student No.", studentNo);
            SupUnitsBasket.SETRANGE(SupUnitsBasket."Unit Code", UnitCode);
            SupUnitsBasket.SETRANGE(SupUnitsBasket.Semester, Sem);
            SupUnitsBasket.SETRANGE(SupUnitsBasket."Academic Year", AcademicYear);
            IF SupUnitsBasket.FIND('-') THEN BEGIN
                SupUnitsBasket.DELETE;
            END;
        END;
    end;

    procedure UpdateSupUnits()
    var
        category: Integer;
        i: Integer;
    begin
        SupUnits.RESET;
        IF SupUnits.FIND('-') THEN BEGIN
            REPEAT
                trscripttbl.RESET;
                trscripttbl.SetRange(trscripttbl.StudentID, SupUnits."Student No.");
                trscripttbl.SetRange(trscripttbl.UnitCode, SupUnits."Unit Code");
                trscripttbl.SetRange(trscripttbl.AcademicYr, SupUnits."Academic Year");
                trscripttbl.SetRange(trscripttbl.ProgrammeID, SupUnits.Programme);
                trscripttbl.SetFilter(trscripttbl.MeanGrade, 'I|F|F*');
                if trscripttbl.FIND('-') THEN begin
                    if trscripttbl.MeanGrade = 'I' THEN begin
                        category := 1;
                    end;
                    if (trscripttbl.MeanGrade = 'F') OR (trscripttbl.MeanGrade = 'F*') THEN begin
                        category := 2;
                    end;
                    SupUnits.RENAME(SupUnits."Academic Year", SupUnits.Semester, trscripttbl.Session, SupUnits."Student No.", '', SupUnits.Programme, SupUnits."Unit Code", category, SupUnits."Current Academic Year");
                    i += 1;
                end;
            UNTIL SupUnits.Next = 0;
            Message(FORMAT(i));
        END;
    end;

    procedure DeleteSupBasket(username: Text; Stagez: Text; Sem: Text; AcademicYear: Text; UnitCode: Text)
    begin
        SupUnitsBasket.RESET;
        SupUnitsBasket.SETRANGE(SupUnitsBasket."Student No.", username);
        SupUnitsBasket.SETRANGE(SupUnitsBasket.Stage, Stagez);
        SupUnitsBasket.SETRANGE(SupUnitsBasket.Semester, Sem);
        SupUnitsBasket.SETRANGE(SupUnitsBasket."Academic Year", AcademicYear);
        SupUnitsBasket.SETRANGE(SupUnitsBasket."Unit Code", UnitCode);
        IF SupUnitsBasket.FIND('-') THEN BEGIN
            SupUnitsBasket.DELETE;
        END;
    end;


    procedure DeleteeSubmittedSup(username: Text; Stagez: Text; Sem: Text; AcademicYear: Text; UnitCode: Text)
    begin
        SupUnits.RESET;
        SupUnits.SETRANGE(SupUnits."Student No.", username);
        SupUnits.SETRANGE(SupUnits.Stage, Stagez);
        SupUnits.SETRANGE(SupUnits.Semester, Sem);
        SupUnits.SETRANGE(SupUnits."Academic Year", AcademicYear);
        SupUnits.SETRANGE(SupUnits."Unit Code", UnitCode);
        IF SupUnits.FIND('-') THEN BEGIN
            SupUnits.DELETE;
        END;
    end;



    procedure GetStudentCampus(username: Text) Message: Text
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", username);
        IF Customer.FIND('-') THEN BEGIN
            Message := Customer."Global Dimension 1 Code";

        END
    end;


    procedure UpdateCampusCode(username: Text; CampusCode: Code[30]) Message: Text
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", username);
        IF Customer.FIND('-') THEN BEGIN
            Customer."Global Dimension 1 Code" := CampusCode;
            Customer.MODIFY;
            Message := 'Campus updated Successfully';
        END;
    end;


    procedure GetSupUnitTaken(UnitID: Text; StudentNo: Text; Stage: Text) Message: Text
    var
        TXTtaken: Label 'Taken';
        TXTNotTaken: Label 'Not Taken';
    begin
        SupUnits.RESET;
        SupUnits.SETRANGE(SupUnits."Unit Code", UnitID);
        SupUnits.SETRANGE(SupUnits."Student No.", StudentNo);
        SupUnits.SETRANGE(SupUnits.Stage, Stage);
        IF SupUnits.FIND('-') THEN BEGIN
            Message := TXTtaken + '::';
        END ELSE BEGIN
            Message := TXTNotTaken + '::';
        END
    end;


    procedure GetSupUnitSelected(UnitID: Text; StudentNo: Text; Stage: Text) Message: Text
    var
        TXTtaken: Label 'Taken';
        TXTNotTaken: Label 'Not Taken';
    begin
        SupUnitsBasket.RESET;
        SupUnitsBasket.SETRANGE(SupUnitsBasket."Unit Code", UnitID);
        SupUnitsBasket.SETRANGE(SupUnitsBasket."Student No.", StudentNo);
        SupUnitsBasket.SETRANGE(SupUnitsBasket.Stage, Stage);
        IF SupUnitsBasket.FIND('-') THEN BEGIN
            Message := TXTtaken + '::';
        END ELSE BEGIN
            Message := TXTNotTaken + '::';
        END
    end;


    procedure DeleteSelectedSupUnit(studentNo: Text; UnitID: Text)
    begin
        SupUnitsBasket.RESET;
        SupUnitsBasket.SETRANGE(SupUnitsBasket."Student No.", studentNo);
        SupUnitsBasket.SETRANGE(SupUnitsBasket."Unit Code", UnitID);
        IF SupUnitsBasket.FIND('-') THEN BEGIN
            SupUnitsBasket.DELETE;
            MESSAGE('Deleted Successfully');
        END;
    end;


    procedure GetAllowedHostelBookingGroup(username: Text) Message: Text
    begin
        CourseRegistration.RESET;
        CourseRegistration.SETRANGE(CourseRegistration."Student No.", username);
        CourseRegistration.SETRANGE(CourseRegistration.Reversed, FALSE);
        CourseRegistration.SETCURRENTKEY(Stage);
        IF CourseRegistration.FIND('+') THEN BEGIN
            Message := CourseRegistration.Stage + '::' + CourseRegistration.Semester;
        END;
    end;


    procedure GetHostelGenSetups() Message: Text
    begin
        GenSetup.RESET;
        IF GenSetup.FIND('-') THEN BEGIN
            Message := GenSetup."Default Year" + '::' + GenSetup."Default Semester";

        END
    end;

    procedure GetProgramCode(index: Text) Message: Text
    begin
        KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(Index, index);
        IF KUCCPSRaw.FIND('-') THEN BEGIN
            Message := KUCCPSRaw.prog;

        END
    end;

    procedure SubmitForClearance(username: Text; Programmm: Text) Message: Text
    begin
        IF Customer.GET(username) THEN BEGIN
            Customer.CALCFIELDS(Balance);
            IF Customer.Balance > 0 THEN BEGIN
                Message := 'Clearance application not successful! Your Balance is greater than zero!';
            END;
        END;
        IF NOT (Customer.Balance > 0) THEN BEGIN
            NextJobapplicationNo := NoSeriesMgt.GetNextNo('CLRE', 0D, TRUE);
            ClearanceHeader.RESET;
            ClearanceHeader.SETRANGE(ClearanceHeader."Student No.", username);
            IF NOT ClearanceHeader.FIND('-') THEN BEGIN
                ClearanceHeader.INIT;
                ClearanceHeader."No." := NextJobapplicationNo;
                ClearanceHeader.Date := TODAY;
                ClearanceHeader."Student No." := username;
                ClearanceHeader.Programme := Programmm;
                ClearanceHeader.Status := ClearanceHeader.Status::New;
                ClearanceHeader."No. Series" := 'CLRE';
                ClearanceHeader.INSERT;
                IF ClearanceHeader.INSERT THEN;
                Customer.RESET;
                Customer.SETRANGE(Customer."No.", username);
                IF Customer.FIND('-') THEN BEGIN
                    Customer."Applied for Clearance" := TRUE;
                    Customer."Clearance Initiated by" := username;
                    Customer."Clearance Initiated Date" := TODAY;
                    Customer."Clearance Initiated Time" := TIME;
                    Customer."Clearance Reason" := Customer."Clearance Reason"::Graduation;
                    Customer.MODIFY;
                END;
                Message := 'Clearance request successfully initiated';
            END ELSE BEGIN
                Message := 'You already initiated your clearance process.';
            END;
        END;
    end;


    procedure IsStageFinal(Stage: Text; programm: Text) Message: Text
    begin
        Stages.RESET;
        Stages.SETRANGE(Stages."Programme Code", programm);
        Stages.SETRANGE(Stages.Code, Stage);
        IF Stages.FIND('-') THEN BEGIN
            Message := FORMAT(Stages."Final Stage");

        END
    end;


    procedure HasAppliedClearance(username: Text) Message: Text
    var
        TXTApplied: Label 'Yes';
        TXTNotApplied: Label 'Not Applied';
    begin
        ClearanceHeader.RESET;
        ClearanceHeader.SETRANGE(ClearanceHeader."Student No.", username);
        IF ClearanceHeader.FIND('-') THEN BEGIN
            Message := TXTApplied + '::';
        END ELSE BEGIN
            Message := TXTNotApplied + '::';
        END
    end;


    procedure GenerateClearanceForm(StudentNo: Text; filenameFromApp: Text)
    var
        filename: Text;
    begin
        filename := FILESPATH + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        ClearanceHeader.RESET;
        ClearanceHeader.SETRANGE(ClearanceHeader."Student No.", StudentNo);

        IF ClearanceHeader.FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(report::"Students Clearance", filename, ClearanceHeader);
        END;
    end;

    procedure GenerateStudentResitExamCard(StudentNo: Text; Sem: Text; filenameFromApp: Text): Text
    var
        filename: Text;
        cusz: Record Customer;
    begin
        filename := FILESPATH + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        cusz.RESET;
        cusz.SETRANGE("No.", StudentNo);
        IF cusz.FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(63900, filename, cusz);
        END;
    end;


    procedure EraseStudentGeneratedFile(filenameFromApp: Text) filename: Text
    begin
        filename := FILESPATH + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
    end;

    procedure DeleteRegisteredUnit(Unit: Code[20]; Sem: Code[20]; StudNo: Code[20]) rtnMsg: Text
    begin
        studetUnits.RESET;
        studetUnits.SETRANGE(studetUnits."Student No.", StudNo);
        studetUnits.SETRANGE(studetUnits.Semester, Sem);
        studetUnits.SETRANGE(studetUnits.Unit, Unit);
        IF studetUnits.FIND('-') THEN BEGIN
            studetUnits.CALCFIELDS("CATs Marks Exists", "EXAMs Marks Exists");
            IF ((studetUnits."CATs Marks Exists") OR (studetUnits."EXAMs Marks Exists")) THEN
                rtnMsg := 'Marks Exist you cannot Delete!';
            IF (rtnMsg = '') THEN BEGIN
                studetUnits.DELETE;
                rtnMsg := 'SUCCESS: You have dropped unit: ' + Unit;
            END;
        END;
    end;

    procedure ChechPostedSemReg(StudNo: Code[30]; Sem: Code[30]) Message: Text
    begin
        CourseReg.RESET;
        CourseReg.SETRANGE(CourseReg."Student No.", StudNo);
        CourseReg.SETRANGE(CourseReg.Semester, Sem);
        IF CourseReg.FIND('-') THEN BEGIN
            IF CourseReg.Posted = TRUE THEN BEGIN
                Message := 'YES' + '::';
            END
            ELSE BEGIN
                Message := 'NO' + '::';
            END
        END;
    end;

    procedure GenerateSudTransferLetter(AdmNo: Text; filenameFromApp: Text)
    begin
        filename := FILESPATH + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        StudentsTransfer.RESET;
        StudentsTransfer.SETRANGE(StudentsTransfer."New Student No", AdmNo);

        IF StudentsTransfer.FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(61612, filename, StudentsTransfer);
        END;
    end;

    procedure DeleteRegisteredSupp(Unit: Code[20]; Sem: Code[20]; StudNo: Code[20]) rtnMsg: Text
    begin
        AcaSpecialExamsDetailss.RESET;
        AcaSpecialExamsDetailss.SETRANGE(AcaSpecialExamsDetailss."Student No.", StudNo);
        AcaSpecialExamsDetailss.SETRANGE(AcaSpecialExamsDetailss.Semester, Sem);
        AcaSpecialExamsDetailss.SETRANGE(AcaSpecialExamsDetailss."Unit Code", Unit);
        IF AcaSpecialExamsDetailss.FIND('-') THEN BEGIN
            IF ((AcaSpecialExamsDetailss."Exam Marks" <> 0)) THEN
                rtnMsg := 'Marks Exist you cannot Delete!';
            IF (rtnMsg = '') THEN BEGIN
                AcaSpecialExamsDetailss.DELETE;
                rtnMsg := 'SUCCESS: You have deleted ' + Unit;
            END;
        END;
    end;

    procedure InterSchoolTransferApprovalRequest(StudNumber: Code[30]; DepartmentCode: Code[30])
    begin
        InterSchoolTransfer.RESET;
        InterSchoolTransfer.SETRANGE("Student No", StudNumber);
        IF InterSchoolTransfer.FIND('-') THEN BEGIN
            State := State::Open;
            IF InterSchoolTransfer.Status <> InterSchoolTransfer.Status::"Pending approval" THEN State := State::Open;
            //DocType := DocType::"School Transfer";
            CLEAR(tableNo);
            tableNo := 61612;
            //IF AppMgt.SendApproval(tableNo, StudNumber, DocType, State, DepartmentCode, 0) THEN;
        END;
    end;

    procedure SubmitInterSchoolTransferRequest(AdmNo: Text; Department: Text; CurrentProg: Text; NewProg: Text; Reason: Text; KCSEAggregate: Text; KCSEResultSlip: Text; Semester: Code[30]) Message: Text
    begin
        InterSchoolTransfer.RESET;
        InterSchoolTransfer.INIT;
        InterSchoolTransfer.SETRANGE("Student No", AdmNo);
        InterSchoolTransfer.SETRANGE(Status, 1);
        IF InterSchoolTransfer.FIND('-') THEN BEGIN
            Message := 'You already have an application with pending approval.' + '::';
        END
        ELSE BEGIN
            InterSchoolTransfer."Student No" := AdmNo;
            InterSchoolTransfer."Responsibility Centre" := Department;
            InterSchoolTransfer."Current Programme" := CurrentProg;
            InterSchoolTransfer."New Programme" := NewProg;
            InterSchoolTransfer."Reason for Transfer" := Reason;
            InterSchoolTransfer."Agregate Points" := KCSEAggregate;
            InterSchoolTransfer."Result Slip" := KCSEResultSlip;
            InterSchoolTransfer.Status := 1;
            InterSchoolTransfer.Semester := Semester;
            InterSchoolTransfer.INSERT(TRUE);
            Message := 'Application for inter-school transfer submitted successfully!' + '::';
        END;
    end;

    procedure IsProgOptionsAllowed(Prog: Code[20]; Stage: Code[20]) Message: Text
    begin
        ProgStages.RESET;
        ProgStages.SETRANGE(ProgStages.Code, Stage);
        ProgStages.SETRANGE(ProgStages."Programme Code", Prog);
        ProgStages.SETRANGE(ProgStages."Allow Programme Options", TRUE);
        IF ProgStages.FIND('-') THEN BEGIN
            Message := 'Yes' + '::';
        END ELSE BEGIN
            Message := 'No' + '::';
        END;
    end;

    procedure CheckGraduationStatus(AdmNo: Code[30]) Message: Text
    var
        Success: Label 'Graduated';
        Fail: Label 'Not Graduated';
        NotFound: Label 'Not Found';
    begin
        ClassifiactionStudents.RESET;
        ClassifiactionStudents.INIT;
        ClassifiactionStudents.SETRANGE("Student Number", AdmNo);
        IF ClassifiactionStudents.FIND('-') THEN BEGIN
            IF ClassifiactionStudents.Graduating = TRUE THEN BEGIN
                Message := Success + '::';
            END
            ELSE
                Message := Fail + '::';
        END
        ELSE BEGIN
            Message := NotFound + '::';
        END
    end;

    procedure CheckSemLecturerEvaluation(Semester: Code[30]) Message: Text
    var
        Semesters: Record "ACA-Semesters";
        Success: Label 'Success';
        Fail: Label 'Fail';
    begin
        Semesters.RESET;
        Semesters.INIT;
        Semesters.SETRANGE(Code, Semester);
        IF Semesters.FIND('-') THEN BEGIN
            IF Semesters."Evaluate Lecture" = TRUE THEN BEGIN
                Message := Success + '::';
            END
            ELSE
                Message := Fail + '::';
        END
    end;

    procedure CheckOnlineAccountStatus(username: Text) Message: Text
    begin
        OnlineUsersz.RESET;
        OnlineUsersz.SETRANGE(OnlineUsersz."Email Address", username);
        IF OnlineUsersz.FIND('-') THEN BEGIN
            Message := FORMAT(OnlineUsersz.Confirmed);
        END
    end;

    procedure ValidateEmail(username: Text) Message: Boolean
    begin
        OnlineUsersz.RESET;
        OnlineUsersz.SETRANGE(OnlineUsersz."Email Address", username);
        IF OnlineUsersz.FIND('-') THEN BEGIN
            Message := true;
        END
    end;

    procedure CheckValidOnlineAccount(username: Text) Message: Boolean
    begin
        OnlineUsersz.RESET;
        OnlineUsersz.SETRANGE(OnlineUsersz."Email Address", username);
        IF OnlineUsersz.FIND('-') THEN BEGIN
            Message := true;
        END
    end;

    procedure SendPasswordResetCode(username: Text; resetcode: Text) Message: Boolean
    begin
        OnlineUsersz.RESET;
        OnlineUsersz.SETRANGE(OnlineUsersz."Email Address", username);
        IF OnlineUsersz.FIND('-') THEN BEGIN
            OnlineUsersz.SessionID := resetcode;
            OnlineUsersz.MODIFY;
            Message := TRUE;
        END
    end;

    procedure ResetPassword(username: Text; resetcode: Text; newpassword: Text) Message: Boolean
    begin
        OnlineUsersz.RESET;
        OnlineUsersz.SETRANGE(OnlineUsersz."Email Address", username);
        OnlineUsersz.SETRANGE(OnlineUsersz.SessionID, resetcode);
        IF OnlineUsersz.FIND('-') THEN BEGIN
            OnlineUsersz.Password := newpassword;
            OnlineUsersz.MODIFY;
            Message := TRUE;
        END
    end;

    procedure CheckOnlineLogin(username: Text; passrd: Text) Message: Text
    var
        TXTIncorrectDetails: Label 'Incorrect Username or Password';
        TXTCorrectDetails: Label 'Login';
    begin
        OnlineUsersz.RESET;
        OnlineUsersz.SETRANGE(OnlineUsersz."Email Address", username);
        OnlineUsersz.SETRANGE(OnlineUsersz.Password, passrd);
        IF OnlineUsersz.FIND('-') THEN BEGIN
            FullNames := OnlineUsersz."First Name" + ' ' + OnlineUsersz."Middle Name" + ' ' + OnlineUsersz."Last Name";
            Message := TXTCorrectDetails + '::' + OnlineUsersz."Email Address" + '::' + OnlineUsersz."ID No" + '::' + FullNames;
        END ELSE BEGIN
            Message := TXTIncorrectDetails + '::';
        END
    end;

    procedure RegisterOnlineAccount(EmailAddress: Text; IDNo: Text; Genderz: Integer; PhoneNo: Text; Passwordz: Text; FirstName: Text; MiddleName: Text; LastName: Text; SessionIDz: Text; DoBz: Date; Countyz: Code[50]; MaritalStatus: Integer; Nationalityz: Code[50]; PostalAddress: Text)
    begin
        OnlineUsersz.INIT;
        OnlineUsersz."Email Address" := EmailAddress;
        OnlineUsersz."ID No" := IDNo;
        OnlineUsersz.Gender := Genderz;
        OnlineUsersz."Phone No" := PhoneNo;
        OnlineUsersz.Password := Passwordz;
        OnlineUsersz."First Name" := FirstName;
        OnlineUsersz."Middle Name" := MiddleName;
        OnlineUsersz."Last Name" := LastName;
        OnlineUsersz.SessionID := SessionIDz;
        OnlineUsersz.Confirmed := false;
        OnlineUsersz.DoB := DoBz;
        OnlineUsersz.County := Countyz;
        OnlineUsersz."Marital Status" := MaritalStatus;
        OnlineUsersz.Nationality := Nationalityz;
        OnlineUsersz."Postal Address" := PostalAddress;
        OnlineUsersz.INSERT(TRUE);
    end;

    procedure CreateAccount(EmailAddress: Text; PhoneNo: Text; Passwordz: Text; FirstName: Text; MiddleName: Text; LastName: Text; SessionIDz: Text)
    begin
        OnlineUsersz.INIT;
        OnlineUsersz."Email Address" := EmailAddress;
        OnlineUsersz."Phone No" := PhoneNo;
        OnlineUsersz.Password := Passwordz;
        OnlineUsersz."First Name" := FirstName;
        OnlineUsersz."Middle Name" := MiddleName;
        OnlineUsersz."Last Name" := LastName;
        OnlineUsersz.SessionID := SessionIDz;
        OnlineUsersz.Confirmed := false;
        OnlineUsersz.INSERT(TRUE);
    end;

    procedure DeleteOnlineAccount(EmailAddress: Text)
    begin
        OnlineUsersz.RESET;
        OnlineUsersz.SETRANGE(OnlineUsersz."Email Address", EmailAddress);
        IF OnlineUsersz.FIND('-') THEN begin
            OnlineUsersz.DELETE(TRUE);
        end;
    end;

    procedure GetOnlineSessionID(sessionIDz: Text) Message: Text
    var
        TXTIncorrectDetails: Label 'No';
        TXTCorrectDetails: Label 'Yes';
    begin
        OnlineUsersz.RESET;
        OnlineUsersz.SETRANGE(OnlineUsersz.SessionID, sessionIDz);
        IF OnlineUsersz.FIND('-') THEN BEGIN
            Message := TXTCorrectDetails;
        END ELSE BEGIN
            Message := TXTIncorrectDetails;
        END
    end;

    procedure ActivateOnlineUserAccount(sessionIDz: Text) Message: Text
    begin
        OnlineUsersz.RESET;
        OnlineUsersz.SETRANGE(OnlineUsersz.SessionID, sessionIDz);
        IF OnlineUsersz.FIND('-') THEN BEGIN
            OnlineUsersz.Confirmed := TRUE;
            OnlineUsersz.MODIFY;
            Message := FORMAT(OnlineUsersz.Confirmed);
        END
    end;

    procedure GetOnlineUserDetails(username: Text) Message: Text
    begin
        OnlineUsersz.RESET;
        OnlineUsersz.SETRANGE(OnlineUsersz."Email Address", username);
        //OnlineUsersz.SETRANGE(OnlineUsersz.Password,passrd);
        IF OnlineUsersz.FIND('-') THEN BEGIN
            Message := OnlineUsersz."Email Address" + '::' + OnlineUsersz."Phone No" + '::' + FORMAT(OnlineUsersz.Gender) + '::' + OnlineUsersz."First Name" + '::' + OnlineUsersz."Middle Name" + '::' + OnlineUsersz."Last Name" + '::' + OnlineUsersz."Postal Address";
        END
    end;

    procedure GetOnlineEmailExists(emailaddress: Text) Message: Text
    var
        TXTIncorrectDetails: Label 'No';
        TXTCorrectDetails: Label 'Yes';
    begin
        OnlineUsersz.RESET;
        OnlineUsersz.SETRANGE(OnlineUsersz."Email Address", emailaddress);
        IF OnlineUsersz.FIND('-') THEN BEGIN
            Message := TXTCorrectDetails;
        END ELSE BEGIN
            Message := TXTIncorrectDetails;
        END
    end;

    procedure GetOnlineUserDetailsMore(username: Text) Message: Text
    begin
        OnlineUsersz.RESET;
        OnlineUsersz.SETRANGE(OnlineUsersz."Email Address", username);
        IF OnlineUsersz.FIND('-') THEN BEGIN
            Message := FORMAT(OnlineUsersz."Marital Status") + '::' + FORMAT(OnlineUsersz.County) + '::' + FORMAT(OnlineUsersz.Nationality) + '::' + FORMAT(OnlineUsersz.DoB);
        END
    end;

    procedure GetKuccpsFamilydata(username: Text) Message: Text
    begin
        KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(KUCCPSRaw.Index, username);
        IF KUCCPSRaw.FIND('-') THEN BEGIN
            Message := KUCCPSRaw."Full Name of Father" + '::' + FORMAT(KUCCPSRaw."Father Status") + '::' + KUCCPSRaw."Father Occupation" + '::' + FORMAT(KUCCPSRaw."Father Date of Birth") + '::' + KUCCPSRaw."Name of Mother" + '::' +
            FORMAT(KUCCPSRaw."Mother Status") + '::' + KUCCPSRaw."Mother Occupation" + '::' + FORMAT(KUCCPSRaw."Mother Date of Birth") + '::' + KUCCPSRaw."Number of brothers and sisters" + '::' + KUCCPSRaw."Father Phone" + '::' + KUCCPSRaw."Mother Phone";
        END
    end;

    procedure GetNationalities() Message: Text
    begin
        centralsetup.RESET;
        centralsetup.SetCurrentKey(Description);
        centralsetup.SETRANGE(centralsetup.Category, centralsetup.Category::Nationality);
        IF centralsetup.FIND('-') THEN BEGIN
            REPEAT
                Message := Message + centralsetup."Title Code" + ' ::' + centralsetup.Description + ' :::';
            UNTIL centralsetup.NEXT = 0;
        END;
    end;

    procedure GetCountries() Message: Text
    begin
        countries.RESET;
        countries.SetCurrentKey(Name);
        IF countries.FIND('-') THEN BEGIN
            REPEAT
                Message := Message + countries.Code + ' ::' + countries.Name + ' :::';
            UNTIL countries.NEXT = 0;
        END;
    end;

    procedure GetCounties() Message: Text
    begin
        counties.RESET;
        counties.SetCurrentKey(Name);
        IF counties.FIND('-') THEN BEGIN
            REPEAT
                Message := Message + counties.Code + ' ::' + counties.Name + ' :::';
            UNTIL counties.NEXT = 0;
        END;
    end;

    procedure GetDenomination() Message: Text
    begin
        centralsetup.RESET;
        centralsetup.SETRANGE(centralsetup.Category, centralsetup.Category::Denominations);
        IF centralsetup.FIND('-') THEN BEGIN
            REPEAT
                Message := Message + centralsetup."Title Code" + ' ::' + centralsetup.Description + ' :::';
            UNTIL centralsetup.NEXT = 0;
        END;
    end;

    procedure GetRelationships() Message: Text
    begin
        relationships.RESET;
        IF relationships.FIND('-') THEN BEGIN
            REPEAT
                Message := Message + relationships.Code + ' ::' + relationships.Description + ' :::';
            UNTIL relationships.NEXT = 0;
        END;
    end;

    procedure GetPrograms(progcode: Option; studymode: code[20]; campus: code[20]; intake: code[20]) Message: Text
    begin
        programs.RESET;
        programs.SETRANGE(programs.Levels, progcode);
        programs.SETRANGE(programs."Program Status", programs."Program Status"::Active);
        IF programs.FIND('-') THEN BEGIN
            REPEAT
                programsetups.Reset;
                programsetups.SetRange(Code, programs.Code);
                programsetups.SetRange(Campus, campus);
                programsetups.SetRange(Modeofstudy, studymode);
                programsetups.SetRange(Semester, intake);
                if programsetups.Find('-') then begin
                    Message += programs.Code + ' ::' + programs.Description + ' :::';
                end;
            UNTIL programs.NEXT = 0;
        END;
    end;

    procedure GetAppliedLevelPrograms(appno: Code[50]) Message: Text
    begin
        fablist.reset;
        fablist.SetRange("Application No.", appno);
        IF fablist.FIND('-') THEN BEGIN
            programs.RESET;
            programs.SETRANGE(programs.Levels, fablist."Programme Level");
            programs.SETRANGE(programs."Program Status", programs."Program Status"::Active);
            IF programs.FIND('-') THEN BEGIN
                REPEAT
                    Message := Message + programs.Code + ' ::' + programs.Description + ' :::';
                UNTIL programs.NEXT = 0;
            END;
        END;
    end;

    procedure GetProgramStages(progcode: Text) Message: Text
    begin
        programstages.RESET;
        programstages.SETRANGE(programstages."Programme Code", progcode);
        IF programstages.FIND('-') THEN BEGIN
            REPEAT
                Message := Message + programstages.Code + ' ::' + programstages.Description + ' :::';
            UNTIL programstages.NEXT = 0;
        END;
    end;

    procedure GetProgramSemesters(progcode: Text) Message: Text
    begin
        semesters.RESET;
        semesters.SETRANGE(semesters."Programme Code", progcode);
        IF semesters.FIND('-') THEN BEGIN
            REPEAT
                Message := Message + semesters.Semester + ' :::';
            UNTIL semesters.NEXT = 0;
        END;
    end;

    procedure GetIntakes(level: option) Message: Text
    begin
        intakes.RESET;
        intakes.SetRange(Current, true);
        intakes.SetRange(Level, level);
        IF intakes.FIND('-') THEN BEGIN
            REPEAT
                Message := Message + intakes.Code + ' ::' + intakes.Description + ' :::';
            UNTIL intakes.NEXT = 0;
        END;
    end;

    procedure GetSSDetails(username: text) Message: Text
    begin
        OnlineUsersz.RESET;
        OnlineUsersz.SETRANGE(OnlineUsersz."Email Address", username);
        IF OnlineUsersz.FIND('-') THEN BEGIN
            Message := OnlineUsersz."First Name" + ' ::' + OnlineUsersz."Middle Name" + ' ::' + OnlineUsersz."Last Name" + ' ::' + OnlineUsersz."Phone No" + ' ::' + FORMAT(OnlineUsersz.Gender) + ' ::';
        END;
    end;

    procedure GetModeofStudy() Message: Text
    begin
        studymodes.RESET;
        IF studymodes.FIND('-') THEN BEGIN
            REPEAT
                Message := Message + studymodes.Code + ' ::' + studymodes.Description + ' :::';
            UNTIL studymodes.NEXT = 0;
        END;
    end;

    procedure GetEthnicity() Message: Text
    begin
        ethnicity.RESET;
        ethnicity.SetCurrentKey(Name);
        IF ethnicity.FIND('-') THEN BEGIN
            REPEAT
                Message := Message + ethnicity.Code + ' ::' + ethnicity.Name + ' :::';
            UNTIL ethnicity.NEXT = 0;
        END;
    end;

    procedure GetCampus() Message: Text
    begin
        campus.RESET;
        campus.SetRange("Dimension Code", 'CAMPUS');
        campus.SetRange(Blocked, false);
        campus.SetCurrentKey(Name);
        IF campus.FIND('-') THEN BEGIN
            REPEAT
                Message := Message + campus.Code + ' ::' + campus.Name + ' :::';
            UNTIL campus.NEXT = 0;
        END;
    end;

    procedure GetReligions() Message: Text
    begin
        religions.RESET;
        religions.SetCurrentKey(Religion);
        IF religions.FIND('-') THEN BEGIN
            REPEAT
                Message := Message + religions.Religion + ' :::';
            UNTIL religions.NEXT = 0;
        END;
    end;

    procedure GetMarketingStrategies() Message: Text
    begin
        marketingstrategies.RESET;
        marketingstrategies.SetCurrentKey(Description);
        IF marketingstrategies.FIND('-') THEN BEGIN
            REPEAT
                Message := Message + marketingstrategies.Code + '::' + marketingstrategies.Description + ' :::';
            UNTIL marketingstrategies.NEXT = 0;
        END;
    end;

    procedure GetKuccpsResidencedata(username: Text) Message: Text
    begin
        KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(KUCCPSRaw.Index, username);
        IF KUCCPSRaw.FIND('-') THEN BEGIN
            Message := KUCCPSRaw."Place of Birth" + '::' + KUCCPSRaw."Permanent Residence" + '::' + KUCCPSRaw."Nearest Town" + '::' + KUCCPSRaw.Location + '::' + KUCCPSRaw."Name of Chief" + '::' +
            FORMAT(KUCCPSRaw.County) + '::' + KUCCPSRaw."Sub-County" + '::' + KUCCPSRaw.Constituency + '::' + KUCCPSRaw."Nearest Police Station";
        END
    end;

    procedure GetKuccpsEmmergencydata(username: Text) Message: Text
    begin
        KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(KUCCPSRaw.Index, username);
        IF KUCCPSRaw.FIND('-') THEN BEGIN
            Message := KUCCPSRaw."Emergency Name1" + '::' + KUCCPSRaw."Emergency Relationship1" + '::' + KUCCPSRaw."Emergency P.O. Box1" + '::' + KUCCPSRaw."Emergency Phone No1" + '::' + KUCCPSRaw."Emergency Email1" + '::' +
            KUCCPSRaw."Emergency Name2" + '::' + KUCCPSRaw."Emergency Relationship2" + '::' + KUCCPSRaw."Emergency P.O. Box2" + '::' + KUCCPSRaw."Emergency Phone No2" + '::' + KUCCPSRaw."Emergency Email2";

        END
    end;

    procedure GetKuccpsAcademicdata(username: Text) Message: Text
    begin
        KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(KUCCPSRaw.Index, username);
        IF KUCCPSRaw.FIND('-') THEN BEGIN
            Message := KUCCPSRaw."OLevel School" + '::' + KUCCPSRaw.Index + '::' + KUCCPSRaw."OLevel Year Completed" + '::' + KUCCPSRaw."Primary School" + '::' + KUCCPSRaw."Primary Index no" + '::' +
            KUCCPSRaw."Primary Year Completed" + '::' + KUCCPSRaw."K.C.P.E. Results" + '::' + KUCCPSRaw."Any Other Institution Attended";

        END
    end;

    procedure UpdateKUCCPSProfile(index: code[20]; fname: text; mmname: text; lname: text; gender: option; dob: Date; nationality: text; county: text; idNo: code[20]; passPort: code[20];
    birthCert: code[20]; religion: text; denomination: text; diocese: text; congregation: option; inst: text; protCongregation: Option; maritalStat: Option;
    disability: option; disTyp: Option; knewThru: Text; ethnic: Text; phoneNo: Text; altPhoneNo: text; email: Text;
    postAddress: Text; town: text; kinName: Text; kinEmail: text; kinPhoneNo: Text; kinRel: Text; fpName: Text; fpmob: text; fpEmail: Text; fpRel: Text;
    highSchool: Text; hschF: Date; hschT: Date) Message: Text
    begin
        fablist.Init;
        fabList."Application No." := NoSeriesMgt.GetNextNo('APPNO', 0D, TRUE);
        fabList."First Name" := fname;
        fablist."Other Names" := mmname;
        fablist.Surname := lname;
        fabList."Index Number" := index;
        fabList.Gender := gender;
        fabList."Date Of Birth" := dob;
        fabList.Nationality := Nationality;
        fabList.County := county;
        fabList."ID Number" := idNo;
        fabList."Passport Number" := passPort;
        fabList."Birth Cert No" := birthCert;
        fabList.Religion := religion;
        fabList.Denomination := denomination;
        fabList.Congregation := congregation;
        fabList.Diocese := diocese;
        fablist."Order/Instutute" := inst;
        fablist."Protestant Congregation" := protCongregation;
        fabList."Marital Status" := maritalStat;
        fabList.Disability := disability;
        fablist."Nature of Disability" := disTyp;
        fabList."Knew College Thru" := knewThru;
        fablist.Ethnicity := ethnic;
        fabList."Telephone No. 1" := phoneNo;
        fablist."Telephone No. 2" := altPhoneNo;
        fabList.Email := email;
        fabList."Address for Correspondence1" := postAddress;
        fablist."Address for Correspondence3" := town;
        fablist."Next of kin Name" := kinName;
        fabList."Next Of Kin Email" := email;
        fablist."Next of kin Mobile" := kinPhoneNo;
        fablist."Next of Kin R/Ship" := kinRel;
        fabList."Fee payer Names" := fpName;
        fablist."Fee payer mobile" := fpmob;
        fabList."Fee payer Email" := fpEmail;
        fabList."Fee payer R/Ship" := fpRel;
        fablist."Former School Code" := highSchool;
        fabList."Date of Admission" := hschF;
        fabList."Date of Completion" := hschT;
        fablist."Settlement Type" := '4YR-HEF';
        fablist."Intake Code" := 'SEPT-DEC24';
        fablist."Mode of Study" := 'FULL TIME';
        fablist."Admitted To Stage" := 'Y1S1';
        /*AcademicYr.Reset;
        AcademicYr.SetRange(Current, True);
        if AcademicYr.Find('-') then begin
            fablist."Academic Year" := AcademicYr.Code;
        end;*/
        fablist."Academic Year" := '2024/2025';
        fablist."Programme Level" := fablist."Programme Level"::Bachelor;
        Semesters.Reset;
        Semesters.SetRange(Current, True);
        If semesters.Find('-') then begin
            fablist."Admitted Semester" := Semesters.Semester;
        end;
        fabList."Application Date" := Today;
        KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(KUCCPSRaw.Index, index);
        IF KUCCPSRaw.FIND('-') THEN BEGIN
            fabList."Year of Examination" := KUCCPSRaw."OLevel Year Completed";
            programs.RESET;
            programs.SETRANGE(programs.Code, KUCCPSRaw.Prog);
            IF programs.FIND('-') THEN BEGIN
                fablist."First Degree Choice" := programs.Code;
                fablist."Programme Faculty" := programs.Faculty;
                fablist.programName := programs.Description;
                fablist."Programme Department" := programs."Department Code";
            end;
        end;
        fablist.Status := fablist.Status::Open;
        fabList.Insert;
        KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(KUCCPSRaw.Index, index);
        IF KUCCPSRaw.FIND('-') THEN BEGIN
            KUCCPSRaw.Updated := TRUE;
            KUCCPSRaw.MODIFY;
        end;
        Message := 'Details updated successfully!!!';
    end;

    procedure GetMyApplications(username: Text) apps: Text
    var
        progname: Text;
    begin
        fablist.RESET;
        fablist.SETRANGE(fablist.Email, username);
        IF fablist.FIND('-') THEN BEGIN
            REPEAT
                programs.RESET;
                programs.SETRANGE(programs.Code, fablist."First Degree Choice");
                IF programs.FIND('-') THEN BEGIN
                    progname := programs.Description;
                END;
                apps := apps + fablist."Application No." + ' ::' + progname + ' ::' + FORMAT(fablist."Application Date") + ' ::' + FORMAT(fablist.Status) + ' ::' + FORMAT(fablist."Finance Cleared") + '::' + fablist.Nationality + ' :::';
            UNTIL fablist.Next = 0;
        END;
    end;

    procedure ReturnApplication()
    var
        progname: Text;
    begin
        fablist.RESET;
        fablist.SETRANGE(fablist.Email, 'davidmuema95@gmail.com');
        IF fablist.FIND('-') THEN BEGIN
            REPEAT
                fablist.returned := true;
                fabList.Modify();
            UNTIL fablist.Next = 0;
        END;
    end;

    procedure GetMyReturnedApplications(username: Text) apps: Text
    var
        progname: Text;
    begin
        fablist.RESET;
        fablist.SETRANGE(fablist.Email, username);
        fablist.SETRANGE(fablist.returned, true);
        IF fablist.FIND('-') THEN BEGIN
            REPEAT
                programs.RESET;
                programs.SETRANGE(programs.Code, fablist."First Degree Choice");
                IF programs.FIND('-') THEN BEGIN
                    progname := programs.Description;
                END;
                apps := apps + fablist."Application No." + ' ::' + progname + ' ::' + FORMAT(fablist."Application Date") + ' ::' + FORMAT(fablist.Status) + ' :::';
            UNTIL fablist.Next = 0;
        END;
    end;

    procedure GenerateAdmnNo(username: Text) admNo: Text
    var
        NewAdminCode: Text;
    begin
        fablist.RESET;
        fablist.SETRANGE(fablist."Index Number", username);
        IF fablist.FIND('-') THEN BEGIN
            AdminSetup.RESET;
            AdminSetup.SETRANGE(AdminSetup.Degree, fablist."First Degree Choice");
            IF AdminSetup.FIND('-') THEN BEGIN
                NewAdminCode := NoSeriesMgt.GetNextNo(AdminSetup."No. Series", TODAY, TRUE);
                fablist."Admission No" := NewAdminCode;
                fablist.MODIFY;

                KUCCPSRaw.Reset();
                KUCCPSRaw.SETRANGE(Index, username);
                IF KUCCPSRaw.FIND('-') THEN BEGIN
                    KUCCPSRaw.Admin := NewAdminCode;
                    KUCCPSRaw.MODIFY;
                END;
                admNo := NewAdminCode;
            END ELSE BEGIN
                ERROR('The Admission Number Setup For Programme ' + FORMAT(fablist."Admitted Degree") + ' Does Not Exist');
            END;
            MESSAGE('Admission number generated successfully!');
        end;
    END;

    procedure SSApplication(index: code[20]; fname: text; mmname: text; lname: text; gender: option; dob: Date; nationality: text; county: text; idNo: code[20]; passPort: code[20];
            birthCert: code[20]; religion: text; denomination: text; diocese: text; congregation: option; inst: text; protCongregation: Option; maritalStat: Option;
            disability: option; disTyp: Option; knewThru: Text; formerStud: boolean; formerregno: text; prevedlvl: option; phoneNo: Text; altPhoneNo: text; email: Text;
            postAddress: Text; town: text; programlevel: option;
            intakecode: text; appliedprogram: text; campus: code[20]; modeofstudy: text; highSchool: Text; hschF: Date; hschT: Date; examination: text;
            examinationbody: text; yearofexam: text; meangrade: text; coluniatt: text; coluniattF: Date; colunattTo: Date; highschcertatt: Boolean; rsltslipatt: Boolean;
            undegradcertatt: Boolean; mststrascrptsatt: Boolean; transfercaseatt: Boolean; transferletteratt: Boolean;
            highschcertpath: Text; rsltslippath: Text; undegradcertpath: Text; mststrascrptspath: Text) Message: Text
    var
        programs: Record "ACA-Programme";
        colfrom: Date;
        colto: Date;
        appno: Text;
    begin
        CLEAR(appno);
        appno := NoSeriesMgt.GetNextNo('APPNO', 0D, TRUE);
        IF coluniattF = Today THEN begin
            colfrom := 0D;
        end;
        IF colunattTo = Today THEN begin
            colto := 0D;
        end;
        fablist.Init;
        fabList."Application No." := appno;
        fabList."First Name" := fname;
        fablist."Other Names" := mmname;
        fablist.Surname := lname;
        fabList."Index Number" := index;
        fabList.Gender := gender;
        fabList."Date Of Birth" := dob;
        fabList.Nationality := Nationality;
        fabList.County := county;
        fabList."ID Number" := idNo;
        fabList."Passport Number" := passPort;
        fabList."Birth Cert No" := birthCert;
        fabList.Religion := religion;
        fabList.Denomination := denomination;
        fabList.Congregation := congregation;
        fabList.Diocese := diocese;
        fablist."Order/Instutute" := inst;
        fablist."Protestant Congregation" := protCongregation;
        fabList."Marital Status" := maritalStat;
        fabList.Disability := disability;
        fablist."Nature of Disability" := disTyp;
        fabList."Knew College Thru" := knewThru;
        fabList."Telephone No. 1" := phoneNo;
        fablist."Telephone No. 2" := altPhoneNo;
        fabList.Email := email;
        fabList."Address for Correspondence1" := postAddress;
        fablist."Address for Correspondence3" := town;
        /*fablist."Next of kin Name" := kinName;
        fabList."Next Of Kin Email" := kinEmail;
        fablist."Next of kin Mobile" := kinPhoneNo;
        fablist."Next of Kin R/Ship" := kinRel;
        fabList."Fee payer Names" := fpName;
        fablist."Fee payer mobile" := fpmob;
        fabList."Fee payer Email" := fpEmail;
        fabList."Fee payer R/Ship" := fpRel;*/
        fablist."Former School Code" := highSchool;
        fabList."Date of Admission" := hschF;
        fabList."Date of Completion" := hschT;
        fablist."Year of Examination" := yearofexam;
        fablist."Examination Body" := examinationbody;
        fablist."Mean Grade Acquired" := meangrade;
        fablist."Country of Origin" := nationality;
        fablist."Settlement Type" := 'SSS';
        fablist.Campus := 'LANGATA';
        fabList."Application Date" := Today;
        fablist."Previous Education Level" := prevedlvl;
        //fabList."Admitted Semester" := startingsem;
        fablist."Intake Code" := intakecode;
        fablist."College/UNV attended" := coluniatt;
        fablist."College/Unv attend final date" := colto;
        fablist."College/Unv attend start date" := colfrom;
        fabList."Programme Level" := programlevel;
        fablist."Mode of Study" := modeofstudy;
        fablist."First Degree Choice" := appliedprogram;
        fablist.Campus := campus;
        //fablist."First Choice Stage" := firststage;
        //fablist."First Choice Semester" := startingsem;
        fablist."High Sch. Cert attched" := highschcertatt;
        fablist."High Sch. Rslt Slip Attached" := rsltslipatt;
        fablist."Undergrad Cert attached" := undegradcertatt;
        fablist."Master Transcript attached" := mststrascrptsatt;
        fablist."Transfer Case" := transfercaseatt;
        fablist."Transfer Letter Attached" := transferletteratt;
        fabList."High School Certificate" := highschcertpath;
        fablist."High School Result slip" := rsltslippath;
        fablist."Under Graduate Certificate" := undegradcertpath;
        fablist."Masters Transcript" := mststrascrptspath;
        programs.RESET;
        programs.SETRANGE(programs.Code, appliedprogram);
        IF programs.FIND('-') THEN BEGIN
            fablist."Programme Faculty" := programs.Faculty;
            fablist.programName := programs.Description;
            fablist."Programme Department" := programs."Department Code";
        end;
        fablist.Status := fablist.Status::Open;
        fabList.Insert;
        Message := appno;//'Application submitted successfully.';
    end;

    procedure EditSSApplication(appno: code[50]; appliedprogram: Code[20]; highschcertatt: Boolean; rsltslipatt: Boolean; undegradcertatt: Boolean; mststrascrptsatt: Boolean; transfercaseatt: Boolean; transferletteratt: Boolean; highschcertpath: Text; rsltslippath: Text; undegradcertpath: Text; mststrascrptspath: Text) Message: Text
    var
        programs: Record "ACA-Programme";
    begin
        fablist.reset;
        fablist.Setrange("Application No.", appno);
        if fabList.FIND('-') THEN begin
            fablist."First Degree Choice" := appliedprogram;
            fablist."High Sch. Cert attched" := highschcertatt;
            fablist."High Sch. Rslt Slip Attached" := rsltslipatt;
            fablist."Undergrad Cert attached" := undegradcertatt;
            fablist."Master Transcript attached" := mststrascrptsatt;
            fablist."Transfer Case" := transfercaseatt;
            fablist."Transfer Letter Attached" := transferletteratt;
            fabList."High School Certificate" := highschcertpath;
            fablist."High School Result slip" := rsltslippath;
            fablist."Under Graduate Certificate" := undegradcertpath;
            fablist."Masters Transcript" := mststrascrptspath;
            programs.RESET;
            programs.SETRANGE(programs.Code, appliedprogram);
            IF programs.FIND('-') THEN begin
                fablist."Programme Faculty" := programs.Faculty;
                fablist.programName := programs.Description;
                fablist."Programme Department" := programs."Department Code";
            end;
            fablist.returned := false;
            fabList.Modify;
            Message := 'Your Application has been edited successfully!!';
        end;
    end;

    procedure UpdateKUCCPSProfile2(username: Text; NHIFNo: Text; Religionz: Code[20]; Tribez: Text; Nationalityz: Code[50]; CountyOriginz: Text; MaritalStatus: Integer; NameOfSpouse: Text; OccupationOfSpouse: Text; SpousePhoneNo: Code[30]; NumberOfChildren: Text; FullNameofFather: Text; FatherStatus: Integer; FatherOccupation: Text; FatherDateOfBirth: Date; NameOfMother: Text; MotherStatus: Integer; MotherOccupation: Text; NumberOfbrothersandsisters: Code[20]; PlaceOfBirth: Text; PermanentResidence: Text; NearestTown: Text; Locationz: Text; NameOfChief: Text; SubCounty: Text; Constituencyz: Text; NearestPoliceStation: Text)
    begin
        KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(KUCCPSRaw.Index, username);
        IF KUCCPSRaw.FIND('-') THEN BEGIN

            KUCCPSRaw."Marital Status" := MaritalStatus;
            KUCCPSRaw."Name of Spouse" := Religionz;
            KUCCPSRaw."Ethnic Background" := Tribez;
            KUCCPSRaw.Nationality := Nationalityz;
            KUCCPSRaw."County Of Origin" := CountyOriginz;
            KUCCPSRaw."Occupation of Spouse" := OccupationOfSpouse;
            KUCCPSRaw."Name of Spouse" := NameOfSpouse;
            KUCCPSRaw."Occupation of Spouse" := OccupationOfSpouse;
            KUCCPSRaw."Spouse Phone No" := SpousePhoneNo;
            KUCCPSRaw."Number of Children" := NumberOfChildren;
            KUCCPSRaw."Full Name of Father" := FullNameofFather;
            KUCCPSRaw."Father Status" := FatherStatus;
            // KUCCPSRaw."Father Phone" := FatherPhone;
            KUCCPSRaw."Father Occupation" := FatherOccupation;
            KUCCPSRaw."Father Date of Birth" := FatherDateOfBirth;
            KUCCPSRaw."Name of Mother" := NameOfMother;
            KUCCPSRaw."Mother Status" := MotherStatus;
            // KUCCPSRaw."Mother Phone" := MotherPhone;
            KUCCPSRaw."Mother Occupation" := MotherOccupation;
            //KUCCPSRaw."Mother Date of Birth" := MotherDateOfBirth;
            KUCCPSRaw."Number of brothers and sisters" := NumberOfbrothersandsisters;
            KUCCPSRaw."Place of Birth" := PlaceOfBirth;
            KUCCPSRaw."Permanent Residence" := PermanentResidence;
            KUCCPSRaw."Nearest Town" := NearestTown;
            KUCCPSRaw.Location := Locationz;
            KUCCPSRaw."Name of Chief" := NameOfChief;
            KUCCPSRaw."Sub-County" := SubCounty;
            KUCCPSRaw.Constituency := Constituencyz;
            KUCCPSRaw."Nearest Police Station" := NearestPoliceStation;
            KUCCPSRaw.Updated := TRUE;
            KUCCPSRaw.MODIFY;
        END
    end;

    procedure UpdateKUCCPSProfileMore(username: Text; EmergencyName1: Text; EmergencyRelationship1: Text; EmergencyBox1: Text; EmergencyPhoneNo1: Code[30]; EmergencyEmail1: Text; EmergencyName2: Text; EmergencyRelationship2: Text; EmergencyBox2: Text; EmergencyPhoneNo2: Code[30]; EmergencyEmail2: Text; OLevelSchool: Text; OLevelYearCompleted: Code[20]; PrimarySchool: Text; PrimaryIndexNo: Text; PrimaryYearCompleted: Code[20]; KCPEResults: Text; AnyOtherInstitutionAttended: Text)
    begin
        KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(KUCCPSRaw.Index, username);
        IF KUCCPSRaw.FIND('-') THEN BEGIN
            KUCCPSRaw."Emergency Name1" := EmergencyName1;
            KUCCPSRaw."Emergency Relationship1" := EmergencyRelationship1;
            KUCCPSRaw."Emergency P.O. Box1" := EmergencyBox1;
            KUCCPSRaw."Emergency Phone No1" := EmergencyPhoneNo1;
            KUCCPSRaw."Emergency Email1" := EmergencyEmail1;
            KUCCPSRaw."Emergency Name2" := EmergencyName2;
            KUCCPSRaw."Emergency P.O. Box2" := EmergencyBox2;
            KUCCPSRaw."Emergency Phone No2" := EmergencyPhoneNo2;
            KUCCPSRaw."Emergency Email2" := EmergencyEmail2;
            KUCCPSRaw."OLevel School" := OLevelSchool;
            KUCCPSRaw."OLevel Year Completed" := OLevelYearCompleted;
            KUCCPSRaw."Primary School" := PrimarySchool;
            KUCCPSRaw."Primary Index no" := PrimaryIndexNo;
            KUCCPSRaw."Primary Year Completed" := PrimaryYearCompleted;
            KUCCPSRaw."K.C.P.E. Results" := KCPEResults;
            KUCCPSRaw."Any Other Institution Attended" := AnyOtherInstitutionAttended;
            KUCCPSRaw.Updated := TRUE;
            KUCCPSRaw.MODIFY;
            //MESSAGE('Meal Item Updated Successfully');
        END
    end;

    procedure GetOfferedUnits(progcode: code[20]; stagecode: code[20]; studymode: code[20]) Details: Text
    begin
        ProgramUnits.RESET;
        ProgramUnits.SETRANGE(ProgramUnits."Programme Code", progcode);
        ProgramUnits.SETRANGE(ProgramUnits."Stage Code", stagecode);
        ProgramUnits.SETRANGE(ProgramUnits."Mode of Study", studymode);
        ProgramUnits.SETRANGE(ProgramUnits.Semester, GetCurrentSem(progcode, stagecode));
        IF ProgramUnits.FIND('-') THEN BEGIN
            REPEAT
                Details := Details + ProgramUnits."Unit Code" + ' ::' + ProgramUnits.Desription + ' :::';

            until ProgramUnits.Next = 0;
        END;
    end;

    procedure GetProgramUnselectedUnits(studentNo: code[20]; progcode: code[20]; stagecode: code[20]) Details: Text
    begin
        ProgramUnits.RESET;
        ProgramUnits.SETRANGE(ProgramUnits."Programme Code", progcode);
        ProgramUnits.SETRANGE(ProgramUnits."Stage Code", stagecode);
        ProgramUnits.SETRANGE(ProgramUnits.Semester, GetCurrentSem(progcode, stagecode));
        IF ProgramUnits.FIND('-') THEN BEGIN
            REPEAT
                StudentUnitBaskets.RESET;
                StudentUnitBaskets.SETRANGE(Unit, ProgramUnits."Programme Code");
                StudentUnitBaskets.SETRANGE("Student No.", studentNo);
                StudentUnitBaskets.SETRANGE(Programme, progcode);
                StudentUnitBaskets.SETRANGE(Stage, stagecode);
                StudentUnitBaskets.SETRANGE(Semester, GetCurrentSem(progcode, stagecode));
                IF NOT StudentUnitBaskets.FIND('-') THEN BEGIN
                    Details := Details + ProgramUnits."Unit Code" + ' ::' + ProgramUnits.Desription + ' :::';

                END;
            until ProgramUnits.Next = 0;
        END;
    end;

    procedure GetCurrentSem(progcode: Text; stagecode: Text) Message: Text
    begin
        stageSemester.RESET;
        stageSemester.SETRANGE(stageSemester."Programme Code", progcode);
        stageSemester.SETRANGE(stageSemester.Stage, stagecode);
        stageSemester.SETRANGE(stageSemester.Current, TRUE);
        IF stageSemester.FIND('-') THEN BEGIN
            Message := stageSemester.Semester;
        END;
    end;

    procedure GetStdPortalMsg() Message: Text
    begin
        portalsetup.RESET;
        portalsetup.SETRANGE(portalsetup.status, portalsetup.status::Active);
        IF portalsetup.FIND('-') THEN BEGIN
            Message := portalsetup.StudentPortalMessage;
        END;
    end;

    procedure ReleaseProformaInvoice() Release: Boolean;
    begin
        generalsetup.RESET;
        IF generalsetup.FIND('-') THEN BEGIN
            Release := generalsetup."Release Proforma Invoice";
        END;
    end;

    procedure GenerateBS64Transcript(StudentNo: Text; filenameFromApp: Text; var bigtext: BigText) rtnmsg: Text
    var
        tmpBlob: Codeunit "Temp Blob";
        cnv64: Codeunit "Base64 Convert";
        InStr: InStream;
        OutStr: OutStream;
        txtB64: Text;
        format: ReportFormat;
        recRef: RecordRef;
        filename: Text;
    begin
        filename := FILESPATH + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);

        trscripttbl.RESET;
        trscripttbl.SETRANGE(trscripttbl.StudentID, StudentNo);
        IF trscripttbl.FIND('-') THEN BEGIN
            recRef.GetTable(trscripttbl);
            tmpBlob.CreateOutStream(OutStr);
            Report.SaveAs(50736, '', format::Pdf, OutStr, recRef);
            tmpBlob.CreateInStream(InStr);
            txtB64 := cnv64.ToBase64(InStr, true);
            bigtext.AddText(txtB64);
        END;
        EXIT(filename);
    end;

    procedure GenerateBS64AdmissionLetter(appNo: Code[20]; filenameFromApp: Text; var bigtext: BigText) rtnmsg: Text
    var
        tmpBlob: Codeunit "Temp Blob";
        cnv64: Codeunit "Base64 Convert";
        InStr: InStream;
        OutStr: OutStream;
        txtB64: Text;
        format: ReportFormat;
        recRef: RecordRef;
        filename: Text;
    begin
        filename := FILESPATH + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);

        fablist.RESET;
        fablist.SETRANGE(fabList."Application No.", appNo);
        fablist.SETRANGE(fabList.Status, fablist.Status::"Provisional Admission");
        IF fablist.FIND('-') THEN BEGIN
            recRef.GetTable(fablist);
            tmpBlob.CreateOutStream(OutStr);
            Report.SaveAs(66679, '', format::Pdf, OutStr, recRef);
            tmpBlob.CreateInStream(InStr);
            txtB64 := cnv64.ToBase64(InStr, true);
            bigtext.AddText(txtB64);
        END;
        EXIT(filename);
    end;

    procedure GetUnitSubjects(progcode: Text; stagecode: Text) Message: Text
    var
        stageorder: Integer;
        Stages2: Record "ACA-Programme Stages";
    begin
        Stages.RESET;
        Stages.SETRANGE(Stages.Code, stagecode);
        Stages.SETRANGE(Stages."Programme Code", progcode);
        IF Stages.FIND('-') THEN BEGIN
            stageorder := Stages.Order;
        END;
        Stages2.RESET;
        Stages2.SETRANGE(Stages2."Programme Code", progcode);
        Stages2.SETFILTER(Stages2.Order, '<=%1', stageorder);
        IF Stages2.FIND('-') THEN BEGIN
            REPEAT
                UnitSubjects.RESET;
                UnitSubjects.SETRANGE(UnitSubjects."Programme Code", progcode);
                UnitSubjects.SETRANGE(UnitSubjects."Stage Code", Stages2.Code);
                UnitSubjects.SETRANGE(UnitSubjects."Old Unit", False);
                IF UnitSubjects.FIND('-') THEN BEGIN
                    REPEAT
                        Message := Message + UnitSubjects.Code + ' ::' + UnitSubjects.Desription + ' ::' + UnitSubjects."Stage Code" + ' :::';
                    UNTIL UnitSubjects.Next = 0;
                END
            UNTIL Stages2.NEXT = 0;
        END;
    end;

    procedure DownloadExamCards() Msg: Boolean
    begin
        CurrentSem.reset;
        //CurrentSem.SETRANGE(CurrentSem."Current Semester", true);
        CurrentSem.SETRANGE(CurrentSem."Download Exam Card", true);
        IF CurrentSem.FIND('-') THEN begin
            Msg := true;
        end;
    end;

    procedure GetSpecialUnits(progcode: code[20]; stdno: code[20]) Details: Text
    var
        progunits: Record "ACA-Units Offered";
    begin
        trscripttbl.RESET;
        trscripttbl.SETRANGE(ProgrammeID, progcode);
        trscripttbl.SETRANGE(StudentID, stdno);
        trscripttbl.SETFILTER(MeanGrade, 'I|F|F*');
        IF trscripttbl.FIND('-') THEN BEGIN
            repeat
                SupUnits.RESET;
                SupUnits.SETRANGE("Student No.", trscripttbl.StudentID);
                SupUnits.SETRANGE("Unit Code", trscripttbl.UnitCode);
                SupUnits.SETRANGE("Current Semester", GetCurrentGlobalSem());
                IF NOT SupUnits.FIND('-') THEN BEGIN
                    progunits.RESET;
                    progunits.SETRANGE("Unit Base Code", trscripttbl.UnitCode);
                    progunits.SETRANGE(Semester, GetCurrentGlobalSem());
                    progunits.SETRANGE(Campus, GetStudentCampus(trscripttbl.StudentID));
                    IF progunits.FIND('-') THEN BEGIN
                        if (trscripttbl.MeanGrade = 'F') and ((trscripttbl.AcademicYr = '2022/2023') and (trscripttbl.Session = '3')) or (trscripttbl.AcademicYr = '2023/2024') then begin
                            Details := Details + trscripttbl.UnitCode + ' ::' + trscripttbl.UnitDesc + ' ::' + trscripttbl.AcademicYr + ' ::' + trscripttbl.Session + ' ::' + trscripttbl.MeanGrade + ' :::';
                        end else if (trscripttbl.MeanGrade = 'F*') and (((trscripttbl.AcademicYr = '2021/2022') and (trscripttbl.Session = '3')) or (trscripttbl.AcademicYr = '2022/2023') or (trscripttbl.AcademicYr = '2023/2024')) then begin
                            Details := Details + trscripttbl.UnitCode + ' ::' + trscripttbl.UnitDesc + ' ::' + trscripttbl.AcademicYr + ' ::' + trscripttbl.Session + ' ::' + trscripttbl.MeanGrade + ' :::';
                        end else if (trscripttbl.MeanGrade = 'I') and ((trscripttbl.AcademicYr = '2022/2023') and (trscripttbl.Session = '3')) or (trscripttbl.AcademicYr = '2023/2024') then begin
                            Details := Details + trscripttbl.UnitCode + ' ::' + trscripttbl.UnitDesc + ' ::' + trscripttbl.AcademicYr + ' ::' + trscripttbl.Session + ' ::' + trscripttbl.MeanGrade + ' :::';
                        end;
                    end;
                end;
            until trscripttbl.Next = 0;
        END;
    end;

    procedure GetRegisteredSpecialUnits(stdNo: Code[20]; sem: Code[20]) MSG: Text
    begin
        supUnits.Reset;
        supUnits.SetRange("Student No.", stdNo);
        supUnits.SetRange("Current Semester", sem);
        if SupUnits.Find('-') then begin
            repeat
                unitSubjects.Reset;
                UnitSubjects.SetRange("Programme Code", SupUnits.Programme);
                UnitSubjects.SetRange(Code, SupUnits."Unit Code");
                if unitSubjects.Find('-') then begin
                    msg += SupUnits."Unit Code" + '::' + UnitSubjects.Desription + '::' + Format(SupUnits.Catogory) + ':::';
                end;
            until supUnits.Next = 0;
        end;
    end;

    procedure GetCurrentGlobalSem() Msg: Text
    begin
        CurrentSem.reset;
        CurrentSem.SETRANGE(CurrentSem."Current Semester", true);
        IF CurrentSem.FIND('-') THEN begin
            Msg := CurrentSem.Code;
        end;
    end;

    procedure GetStudentCampus(stdno: Code[20]) Msg: Text
    begin
        Customer.reset;
        Customer.SETRANGE(Customer."No.", stdno);
        IF Customer.FIND('-') THEN begin
            Msg := Customer."Global Dimension 1 Code";
        end;
    end;

    procedure UpdatedResidence(stdno: Code[20]) Msg: Boolean
    begin
        Customer.reset;
        Customer.SETRANGE(Customer."No.", stdno);
        IF Customer.FIND('-') THEN begin
            Msg := Customer."Updated Nationality";
        end;
    end;

    procedure UpdateResidenceDetails(stdno: Code[20]; nationality: Code[20]; county: Code[20]; religion: Code[20]; indexno: code[20]) Msg: boolean
    begin
        Customer.reset;
        Customer.SETRANGE(Customer."No.", stdno);
        IF Customer.FIND('-') THEN begin
            Customer.Nationality := nationality;
            Customer.County := county;
            Customer.Religion := religion;
            Customer."High Sch. Index Number" := indexno;
            Customer."Updated Nationality" := true;
            Customer.Modify;
            msg := true;
        end;
    end;

    procedure ChangeAppStatus(appno: Code[20]) Msg: Text
    begin
        fablist.reset;
        fablist.SETRANGE(fablist."Application No.", appno);
        IF fabList.FIND('-') THEN begin
            fabList.Status := fabList.Status::"Provisional Admission";
            fabList.Modify();
            Msg := FORMAT(fablist.Status);
        end;
    end;

    procedure GetApplicationFee(appno: Code[20]) appfee: Decimal
    begin
        fablist.reset;
        fablist.SETRANGE(fablist."Application No.", appno);
        IF fabList.FIND('-') THEN begin
            Programme.Reset;
            Programme.SetRange(Programme.Code, fablist."First Degree Choice");
            IF Programme.FIND('-') THEN begin
                appfee := ROUND(Programme.ApplicationFee, 0.01, '>');
            end;
        end;
    end;

    procedure FnConfirmPaybillTransaction(confimationcode: code[20]; appno: Code[20]; amount: Decimal) Msg: Boolean
    var
        mpesatrans: Record confirmedMpesaTransaction;
    begin
        mpesatrans.reset;
        mpesatrans.SETRANGE(mpesatrans.transactionRefNo, confimationcode);
        mpesatrans.SETRANGE(mpesatrans.transactionAmount, amount);
        mpesatrans.SETRANGE(mpesatrans.confirmed, false);
        IF mpesatrans.FIND('-') THEN begin
            mpesatrans.accountNo := appno;
            mpesatrans.confirmed := true;
            mpesatrans.modify;
            fabList.reset;
            fablist.SetRange("Application No.", appno);
            IF fablist.FIND('-') THEN begin
                fablist."Finance Cleared" := true;
                fablist.modify;
            end;
            Msg := true;
        end;
    end;

    procedure FnGetExamCardSem() Msg: Text
    begin
        CurrentSem.reset;
        CurrentSem.SETRANGE(CurrentSem."DownLoad Exam Card", true);
        IF CurrentSem.FIND('-') THEN begin
            msg := CurrentSem.Code;
        end;
    end;

    procedure CheckLecturerEvaluation(stdno: code[20]; sem: code[20]) Msg: Boolean
    begin
        StudentUnits.reset;
        StudentUnits.SETRANGE(StudentUnits."Student No.", stdno);
        StudentUnits.SETRANGE(StudentUnits.Semester, sem);
        StudentUnits.SETRANGE(StudentUnits.Evaluated, false);
        IF StudentUnits.FIND('-') THEN begin
            Msg := true;
        end;
    end;

    procedure GetStage(stdno: code[20]; sem: code[20]) Msg: Text
    begin
        CourseReg.reset;
        CourseReg.SETRANGE(CourseReg."Student No.", stdno);
        CourseReg.SETRANGE(CourseReg.Semester, sem);
        IF CourseReg.FIND('-') THEN begin
            Msg := CourseReg.Stage;
        end;
    end;

    procedure FnApplicationAttachement(retNo: Code[50]; fileName: Text; attachment: BigText; tableId: Integer) return_value: Boolean
    var
        DocAttachment: Record "Document Attachment";
        FromRecRef: RecordRef;
        FileManagement: Codeunit "File Management";
        Bytes: dotnet Array;
        Convert: dotnet Convert;
        MemoryStream: dotnet MemoryStream;
        Ostream: OutStream;
        tableFound: Boolean;
        ObjAppliRec: Record "ACA-Applic. Form Header";

    begin

        tableFound := false;
        return_value := false;
        if TableID = Database::"ACA-Applic. Form Header" then begin
            ObjAppliRec.RESET;
            ObjAppliRec.SETRANGE(ObjAppliRec."Application No.", retNo);
            if ObjAppliRec.FIND('-') then begin
                FromRecRef.GETTABLE(ObjAppliRec);
            end;
            tableFound := true;
        end;

        if tableFound = true then begin
            if FileName <> '' then begin
                Clear(DocAttachment);
                DocAttachment.Init();
                DocAttachment.Validate("Table ID", FromRecRef.Number);
                DocAttachment.Validate("No.", retNo);
                DocAttachment.Validate("File Extension", FileManagement.GetExtension(FileName));
                DocAttachment.Validate("File Name", CopyStr(FileManagement.GetFileNameWithoutExtension(FileName), 1, MaxStrLen(FileName)));
                Bytes := Convert.FromBase64String(Attachment);
                MemoryStream := MemoryStream.MemoryStream(Bytes);
                DocAttachment."Document Reference ID".ImportStream(MemoryStream, '', FileName);
                DocAttachment.Insert(true);
                return_value := true;

            end else
                Error('No file to upload');
        end else
            Error('File not uploaded. No table filter found');

    end;

    procedure GetCurrentSemester() Message: Text
    begin
        CurrentSem.RESET;
        CurrentSem.SETRANGE("Current Semester", TRUE);
        IF CurrentSem.FIND('-') THEN BEGIN
            Message := CurrentSem.Code;
        END;
    end;

    procedure GetCurrentAcademicYear() Message: Text
    begin
        AcademicYr.RESET;
        AcademicYr.SETRANGE(Current, TRUE);
        IF AcademicYr.FIND('-') THEN BEGIN
            Message := AcademicYr.Code;
        END;
    end;

    procedure GetUnitDescription(unitcode: Code[20]) desc: Text
    begin
        UnitSubjects.Reset;
        UnitSubjects.SetRange(Code, unitcode);
        if UnitSubjects.Find('-') then begin
            desc := UnitSubjects.Desription;
        end;
    end;

    procedure GetLecturerNames(no: Code[20]) fullname: Text
    begin
        EmployeeCard.RESET;
        EmployeeCard.SetRange("No.", no);
        IF EmployeeCard.FIND('-') THEN begin
            fullname := '';
            if EmployeeCard."First Name" <> '' then
                fullname += EmployeeCard."First Name";
            if EmployeeCard."Middle Name" <> '' then begin
                if fullname <> '' then begin
                    fullname += ' ' + EmployeeCard."Middle Name";
                end else
                    fullname += EmployeeCard."Middle Name";
            end;
            if EmployeeCard."Last Name" <> '' then
                fullname += ' ' + EmployeeCard."Last Name";
        end;
    end;

    procedure GetLectureHallName(hallcode: Code[20]) hallname: text
    begin
        lecturehalls.Reset;
        lecturehalls.SetRange("Lecture Room Code", hallcode);
        if lecturehalls.Find('-') Then begin
            hallname := lecturehalls."Lecture Room Name";
        end;
    end;

    procedure GetLectureDays() Message: Text
    begin
        days.RESET;
        days.SetCurrentKey("Day Order");
        IF days.FIND('-') THEN BEGIN
            REPEAT
                Message += days."Day Code" + ' :::';
            UNTIL days.NEXT = 0;
        END;
    end;

    procedure GetLectureTimeSlots(day: Code[20]; stdno: Code[20]) Message: Text
    begin
        timeslots.Reset;
        timeslots.SetRange("Day Code", day);
        timeslots.SetCurrentKey("Lesson Code");
        IF timeslots.FIND('-') THEN BEGIN
            REPEAT
                StudentUnits.Reset;
                StudentUnits.SetRange("Student No.", stdno);
                StudentUnits.SetRange(Semester, GetCurrentSemester());
                StudentUnits.SetRange(Day, day);
                StudentUnits.SetRange(TimeSlot, timeslots."Lesson Code");
                if not StudentUnits.Find('-') then begin
                    Message += timeslots."Lesson Code" + ' :::';
                end;
            UNTIL timeslots.NEXT = 0;
        END;
    end;

    procedure GetStdCampus(stdno: Code[20]) msg: Text
    begin
        Customer.Reset;
        Customer.SetRange("No.", stdno);
        if Customer.Find('-') then begin
            msg := Customer."Global Dimension 1 Code";
        end;
    end;

    procedure GetRegisteredStds(unit: Code[20]; stream: Text; campus: Code[20]; mode: Code[20]) stds: Integer
    var
        associatedunits1: Record acaAssosiateUnits;
        associatedunits2: Record acaAssosiateUnits;
        StudentUnits1: Record "ACA-Student Units";
    begin
        associatedunits.Reset;
        associatedunits.SetRange(UnitBaseCode, unit);
        if associatedunits.Find('-') then begin
            StudentUnits.Reset;
            StudentUnits.SetRange("Campus Code", campus);
            StudentUnits.SetRange(Unit, unit);
            StudentUnits.SetRange(ModeofStudy, mode);
            StudentUnits.SetRange(Stream, stream);
            StudentUnits.SetRange(Semester, GetCurrentSemester());
            if StudentUnits.Find('-') then begin
                stds := StudentUnits.Count;
            end;
            repeat
                StudentUnits1.Reset;
                StudentUnits1.SetRange("Campus Code", campus);
                StudentUnits1.SetRange(Unit, associatedunits."Associated Unit");
                StudentUnits.SetRange(ModeofStudy, mode);
                StudentUnits1.SetRange(Stream, stream);
                StudentUnits1.SetRange(Semester, GetCurrentSemester());
                if StudentUnits1.Find('-') then begin
                    stds += StudentUnits1.Count;
                end;
            until associatedunits.next = 0;
        end else begin
            associatedunits1.Reset;
            associatedunits1.SetRange("Associated Unit", unit);
            if associatedunits1.find('-') then begin
                StudentUnits.Reset;
                StudentUnits.SetRange("Campus Code", campus);
                StudentUnits.SetRange(Unit, associatedunits1.UnitBaseCode);
                StudentUnits.SetRange(ModeofStudy, mode);
                StudentUnits.SetRange(Stream, stream);
                StudentUnits.SetRange(Semester, GetCurrentSemester());
                if StudentUnits.Find('-') then begin
                    stds := StudentUnits.Count;
                end;
                associatedunits2.Reset;
                associatedunits2.SetRange(UnitBaseCode, associatedunits1.UnitBaseCode);
                if associatedunits2.find('-') then begin
                    repeat
                        StudentUnits1.Reset;
                        StudentUnits1.SetRange("Campus Code", campus);
                        StudentUnits1.SetRange(Unit, associatedunits2."Associated Unit");
                        StudentUnits.SetRange(ModeofStudy, mode);
                        StudentUnits1.SetRange(Stream, stream);
                        StudentUnits1.SetRange(Semester, GetCurrentSemester());
                        if StudentUnits1.Find('-') then begin
                            stds += StudentUnits1.Count;
                        end;
                    until associatedunits2.next = 0;
                end;
            end else begin
                StudentUnits.Reset;
                StudentUnits.SetRange("Campus Code", campus);
                StudentUnits.SetRange(Unit, unit);
                StudentUnits.SetRange(ModeofStudy, mode);
                StudentUnits.SetRange(Stream, stream);
                StudentUnits.SetRange(Semester, GetCurrentSemester());
                if StudentUnits.Find('-') then begin
                    stds := StudentUnits.Count;
                end;
            end;
        end;
    end;

    procedure GetUnitsToRegister(stdno: Code[20]; progcode: Code[20]; studymode: Code[20]; day: Code[20]; timeslot: Code[20]) Details: Text
    var
        grd: Code[20];
    begin
        offeredunits.RESET;
        offeredunits.SetRange(Campus, GetStdCampus(stdno));
        offeredunits.SetRange(ModeofStudy, studymode);
        offeredunits.SETRANGE(Semester, GetCurrentSemester());
        offeredunits.SETRANGE(Day, day);
        offeredunits.SETRANGE(TimeSlot, timeslot);
        IF offeredunits.FIND('-') then begin
            repeat
                UnitSubjects.Reset;
                UnitSubjects.SetRange("Programme Code", progcode);
                UnitSubjects.SetRange(Code, offeredunits."Unit Base Code");
                if UnitSubjects.Find('-') then begin
                    //offeredunits.CalcFields("Sitting Capacity");
                    //if offeredunits."Sitting Capacity" > GetRegisteredStds(offeredunits."Unit Base Code", offeredunits.Stream, GetStdCampus(stdno)) then begin
                    StudentUnits.Reset;
                    StudentUnits.SetRange("Student No.", stdno);
                    StudentUnits.SetRange(Unit, offeredunits."Unit Base Code");
                    If StudentUnits.Find('-') then begin
                        /*StudentUnits.CalcFields(Grade);
                        grd := StudentUnits.Grade;
                        if (grd <> '') AND (StudentUnits.Semester<>GetCurrentSemester())then begin*/
                        trscripttbl.Reset;
                        trscripttbl.SetRange(StudentID, stdno);
                        trscripttbl.SetRange(UnitCode, offeredunits."Unit Base Code");
                        trscripttbl.SetFilter(MeanGrade, '%1|%2|%3', 'F', 'FF', 'Z');
                        if trscripttbl.Find('-') then begin
                            if NOT UndonePrerequisite(offeredunits."Unit Base Code", stdno) then begin
                                Details += offeredunits."Unit Base Code" + ' ::' + GetUnitDescription(offeredunits."Unit Base Code") + ' ::' + GetLecturerNames(offeredunits.Lecturer) + ' ::' + GetLectureHallName(offeredunits."Lecture Hall") + ' ::' + offeredunits.Stream + ' ::' + 'Retake' + ' :::';
                            end;
                        end;
                        //end;
                    end else begin
                        if NOT UndonePrerequisite(offeredunits."Unit Base Code", stdno) then begin
                            Details += offeredunits."Unit Base Code" + ' ::' + GetUnitDescription(offeredunits."Unit Base Code") + ' ::' + GetLecturerNames(offeredunits.Lecturer) + ' ::' + GetLectureHallName(offeredunits."Lecture Hall") + ' ::' + offeredunits.Stream + ' ::' + 'Normal Registration' + ' :::';
                        end;
                    end
                end;
            until offeredunits.Next = 0;
        end;
    end;

    procedure MaxUnitsRegistered(stdno: Code[20]) msg: Boolean;
    begin
        StudentUnits.Reset;
        StudentUnits.SetRange("Student No.", stdno);
        StudentUnits.SetRange(Semester, GetCurrentSemester());
        If StudentUnits.Find('-') then begin
            if StudentUnits.Count >= GetMaxSemUnits(stdno) then begin
                msg := true;
            end;
        end;
    end;

    procedure GetRegisteredUnits(stdno: Code[20]; progcode: Code[20]) Details: Text
    begin
        StudentUnits.Reset;
        StudentUnits.SetRange("Student No.", stdno);
        StudentUnits.SetRange(Programme, progcode);
        StudentUnits.SetRange(Semester, GetCurrentSemester());
        If StudentUnits.Find('-') then begin
            Repeat
                StudentUnits.CalcFields("Unit Description", Lecturer);
                Details += StudentUnits.Unit + ' ::' + StudentUnits."Unit Description" + ' ::' + GetLecturerNames(StudentUnits.Lecturer) + ' ::' + GetLectureHallName(StudentUnits.LectureHall) + ' ::' + StudentUnits.Stream + ' ::' + StudentUnits.Day + ' ::' + StudentUnits.TimeSlot + ' :::';
            Until StudentUnits.Next = 0;
        end;
    end;

    procedure GetExamTimeTable(stdno: Code[20]; progcode: Code[20]; studymode: Code[20]) Details: Text
    var
        ExamTTable: Record "Exam Timetable";
    begin
        ExamTTable.Reset;
        ExamTTable.SetRange(ModeofStudy, studymode);
        ExamTTable.SetRange(Semester, GetCurrentSemester());
        ExamTTable.SetFilter("final Exam Date", '<>%1', 0D);
        If ExamTTable.Find('-') then begin
            Repeat
                StudentUnits.Reset;
                StudentUnits.SetRange("Student No.", stdno);
                StudentUnits.SetRange(Unit, ExamTTable."Unit Base Code");
                StudentUnits.SetRange(Programme, progcode);
                StudentUnits.SetRange(Stream, ExamTTable.Stream);
                StudentUnits.SetRange(Semester, GetCurrentSemester());
                StudentUnits.SetRange(ModeOfStudy, ExamTTable.ModeofStudy);
                If StudentUnits.Find('-') then begin
                    StudentUnits.CalcFields("Unit Description", Lecturer);
                    Details += StudentUnits.Unit + ' ::' + StudentUnits."Unit Description" + ' ::' + Format(ExamTTable."final Exam Date") + ' ::' + ExamTTable."final exam day" + ' ::' + ExamTTable."final Exam Time" + ' ::' + GetLectureHallName(ExamTTable."Final Exam Room") + ' ::' + GetLecturerNames(ExamTTable."Invigilator 1") + ' :::';
                end;
            Until ExamTTable.Next = 0;
        end;
    end;

    procedure GetExamTimeTable1(stdno: Code[20]; progcode: Code[20]) Details: Text
    begin
        StudentUnits.Reset;
        StudentUnits.SetRange("Student No.", stdno);
        StudentUnits.SetRange(Programme, progcode);
        StudentUnits.SetRange(Semester, GetCurrentSemester());
        If StudentUnits.Find('-') then begin
            Repeat
                StudentUnits.CalcFields("Unit Description", Lecturer);
                offeredunits.Reset;
                offeredunits.SetRange("Unit Base Code", StudentUnits.Unit);
                offeredunits.SetRange(Semester, GetCurrentSemester());
                offeredunits.SetRange(Stream, StudentUnits.Stream);
                offeredunits.SetRange(ModeofStudy, StudentUnits.ModeOfStudy);
                offeredunits.SetFilter("final Exam Date", '<>%1', 0D);
                if offeredunits.Find('-') then begin
                    Details += StudentUnits.Unit + ' ::' + StudentUnits."Unit Description" + ' ::' + Format(offeredunits."final Exam Date") + ' ::' + offeredunits."final exam day" + ' ::' + offeredunits."final Exam Time" + ' ::' + GetLectureHallName(offeredunits."Final Exam Room") + ' ::' + GetLecturerNames(offeredunits."Invigilator 1") + ' :::';
                end;
            Until StudentUnits.Next = 0;
        end;
    end;

    procedure RegisterSemesterUnits(stdno: Code[20]; unitcode: Code[20]; progcode: Code[20]; studymode: Code[20]; stream: Text; day: Code[20]; timeslot: Code[20]; regtype: text) msg: Boolean
    var
        registered: Integer;
        capacity: integer;
    begin
        Customer.Reset;
        Customer.Get(stdno);
        offeredunits.Reset;
        offeredunits.SetRange(Semester, GetCurrentSemester());
        offeredunits.SetRange("Unit Base Code", unitcode);
        offeredunits.SetRange(Campus, Customer."Global Dimension 1 Code");
        offeredunits.SetRange(ModeofStudy, studymode);
        offeredunits.SetRange(Day, day);
        offeredunits.SetRange(TimeSlot, timeslot);
        offeredunits.SetRange(Stream, stream);
        if offeredunits.Find('-') then begin
            offeredunits.CalcFields("Sitting Capacity");
            registered := GetRegisteredStds(offeredunits."Unit Base Code", offeredunits.Stream, offeredunits.Campus, offeredunits.ModeofStudy);
            capacity := offeredunits."Sitting Capacity";
            if (registered >= capacity) then
                Error('This stream is already full. Contact your Head of Department!');
            CourseReg.Reset;
            CourseReg.SetRange("Student No.", stdno);
            CourseReg.SetRange(Programmes, progcode);
            CourseReg.SetRange(Semester, GetCurrentSemester());
            if CourseReg.Find('-') then begin
                StudentUnits.Reset;
                StudentUnits.SetRange("Student No.", stdno);
                StudentUnits.SetRange(Unit, unitcode);
                StudentUnits.SetRange(Semester, GetCurrentSemester());
                if not StudentUnits.Find('-') then begin
                    StudentUnits.Init;
                    StudentUnits."Student No." := stdno;
                    StudentUnits.Unit := unitcode;
                    StudentUnits."Settlement Type" := CourseReg."Settlement Type";
                    StudentUnits.ModeOfStudy := GetRegisteredStudyMode(CourseReg."Settlement Type");
                    StudentUnits.Programme := progcode;
                    StudentUnits."Reg. Transacton ID" := CourseReg."Reg. Transacton ID";
                    StudentUnits."Academic Year" := GetCurrentAcademicYear();
                    StudentUnits."Register for" := StudentUnits."Register for"::Stage;
                    if (regtype = 'Retake') then begin
                        StudentUnits."Re-Take" := true;
                    end;
                    StudentUnits.Semester := GetCurrentSemester();
                    StudentUnits."Campus Code" := Customer."Global Dimension 1 Code";
                    StudentUnits.Stage := CourseReg.Stage;
                    StudentUnits.Stream := offeredunits.Stream;
                    StudentUnits.LectureHall := offeredunits."Lecture Hall";
                    StudentUnits.Day := offeredunits.Day;
                    StudentUnits.TimeSlot := offeredunits.TimeSlot;
                    StudentUnits.Insert;
                    msg := true;
                end else begin
                    Error('Unit already registered!')
                end;

            end else begin
                Error('Course Registration not found!')
            end;
        end else begin
            Error('Unit not found in offered units!')
        end;
    end;

    procedure UndonePrerequisite(unit: Code[20]; stdno: Code[20]) msg: Boolean
    begin
        UnitSubjects.Reset;
        UnitSubjects.SetRange(Code, offeredunits."Unit Base Code");
        if UnitSubjects.Find('-') then begin
            if UnitSubjects.Prerequisite <> '' then begin
                trscripttbl.Reset;
                trscripttbl.SetRange(StudentID, stdno);
                trscripttbl.SetRange(UnitCode, UnitSubjects.Prerequisite);
                if NOT trscripttbl.Find('-') then begin
                    msg := true;
                end;
            end;
        end;
    end;

    procedure GetMaxSemUnits(stdno: Code[20]) maxunits: integer
    begin
        CourseReg.Reset;
        CourseReg.SetCurrenTkey(Stage);
        CourseReg.SetRange("Student No.", stdno);
        if CourseReg.FindLast then begin
            if CourseReg."Settlement Type" = 'PARTTIME' then begin
                maxunits := 5;
            end else begin
                if CourseReg."Settlement Type" = 'ODEL' then begin
                    maxunits := 5;
                end else begin
                    programs.Reset;
                    programs.SetRange(Code, CourseReg.Programmes);
                    if programs.find('-') then begin
                        maxunits := programs."Maximum No of Units";
                    end;
                end;
            end;
        end;
    end;

    procedure SubmitStdIssue(stdNo: Code[20]; issue: Text) submitted: Boolean
    begin
        stdissues.Init;
        stdissues.Client := stdNo;
        stdissues."Client Type" := stdissues."Client Type"::Student;
        stdissues."issue Raised" := issue;
        stdissues.DateRaised := CURRENTDATETIME;
        stdissues.Status := stdissues.Status::Submitted;
        stdissues.Insert;
        submitted := true;
    end;

    procedure GetMyIssuesList(stdNo: Code[20]) msg: Text
    begin
        stdissues.Reset;
        stdissues.SetCurrentKey(lineNo);
        stdissues.Ascending(false);
        stdissues.SetRange(Client, stdNo);
        if stdissues.find('-') then begin
            repeat
                msg += stdissues."Issue Raised" + ' ::' + FORMAT(stdissues.DateRaised) + ' ::' + FORMAT(stdissues.Status) + ' :::';
            until stdissues.Next = 0;
        end
    end;
}