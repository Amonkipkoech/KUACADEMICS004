dotnet
{
    assembly(mscorlib)
    {
        type(System.Array; Bytes) { }
    }
    assembly(mscorlib)
    {
        type(System.Convert; Convert) { }
    }
    assembly(mscorlib)
    {
        type(System.IO.MemoryStream; MemoryStream) { }
    }
}
codeunit 61106 webportalsOLD
{

    trigger OnRun()
    begin
        //AppMgt.SendApproval(61125,'LV000958',31,0,'',0);
        //CheckFeeStatus('ACR/00204/019','SEM 1 19/20');
        //GenerateStudentStatement('CI/00136/018','FeeStatement'+'-CI00136018');
        //SubmitMarks('BED ARTS','Y4S1','SEM 1 19/20','EMA 411','ED/03341/016',19,'CAT','R856081','2019/2020','WANJALA','');
        //GenerateOfferLetter('BHR/00033/020','OfferLetter');
        //GenerateAdmLetter('ACM/00001/020','StudADMLetter');
        //GenerateTranscript('sc/00112/017','TestFileFromApp','2018/2019');
        //GenerateStudentProvisionalResults('sc/00112/017','Resultslip','SEM 1 18/19');
        //HRLeaveApplication('1742', 'ANNUAL', 10, TODAY, TODAY, TODAY, 'test', '1762', 'Okoyo', '094');
    end;

    var
        "Employee Card": Record "HRM-Employee (D)";
        //"HR Leave Application": Record 61125;
        "Supervisor Card": Record "User Setup";
        //HRLeaveTypes: Record "61279";
        ApprovalEntry: Record "Approval Entry";
        ApprovalEntry_2: Record "Approval Entry";
        //LeaveT: Record "61125";
        //HRSetup: Record "61675";
        NoSeriesMgt: Codeunit 396;
        NextLeaveApplicationNo: Code[20];
        EmployeeUserId: Text;
        SupervisorId: Text;
        //PeriodTrans: Record "61092";
        "Supervisor ID": Text;
        //HRLeave: Record "61125";
        //BaseCalendar: Record "7601";
        test: Boolean;
        testDate: Date;
        //GeneralOptions: Record "61675";
        //TransportRequisition: Record "61801";
        //HRTravellingStaff: Record "61802";
        //ltype: Record "61279";
        dates: Record "Date";
        //LeaveTypes: Record "61279";
        varDaysApplied: Decimal;
        //TransportRequisition_2: Record "61801";
        //SalaryCard: Record "61105";
        Customer: Record "Customer";
        "Fee By Stage": Record "ACA-Fee By Unit";
        CourseRegistration: Record "ACA-Course Registration";
        //MealBookingHeader: Record "61778";
        //MealBookingLines: Record "61779";
        //ApprovalMgt: Codeunit "61107";
        AppMgt: Codeunit 439;
        //ApprovalSetup: Record "452";
        Text004: Label 'Approval Setup not found.';
        FILESPATH_S: Label 'C:\inetpub\wwwroot\StaffPortal\Downloads\';
        RelieverName: Text;
        //LeaveLE: Record "61659";
        ExamResults: Record "ACA-Exam Results";
        showmessage: Boolean;
        ManualCancel: Boolean;
        State: Option Open,"Pending Approval",Cancelled,Approved;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
        tableNo: Integer;
        ApproverComments: Record "Approval Comment Line";
        //objPeriod: Record "61081";
        //P9: Record "61093";
        //StoreRequisition: Record "61399";
        //ImprestRequisition: Record "61704";
        //CourseReg: Record "61532";
        GenSetup: Record "ACA-General Set-Up";
        NextStoreqNo: Code[10];
        //MealRequisition: Record "61778";
        NextMtoreqNo: Code[10];
        //MealLinesCreate: Record "61779";
        //VenueRequisition: Record "77709";
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
        StudentUnitBaskets: Record "ACA-Student Units Baskets";
        EmployeeCard: Record "HRM-Employee (D)";
        LedgerEntries: Record "Detailed Cust. Ledg. Entry";
        Stages: Record "ACA-Programme Stages";
        HostelLedger: Record "ACA-Hostel Ledger";
        HostelRooms: Record "ACA-Students Hostel Rooms";
        HostelCard: Record "ACA-Hostel Card";
        HostelBlockRooms: Record "ACA-Hostel Block Rooms";
        RoomSpaces: Record "ACA-Room Spaces";
        //KUCCPSRaw: Record "70082";
        PurchaseRN: Record "Purchase Header";
        LecEvaluation: Record "ACA-Lecturers Evaluation";
        //VoteElection: Record "61464";
        ExamsSetup: Record "ACA-Exams Setup";
        //OnlineUsersz: Record "78012";
        AplicFormHeader: Record "ACA-Applic. Form Header";
        ProgEntrySubjects: Record "ACA-Programme Entry Subjects";
        ApplicFormAcademic: Record "ACA-Applic. Form Academic";
        Intake: Record "ACA-Intake";
        ProgramSem: Record "ACA-Programme Semesters";
        filename2: Text[250];
        FILESPATH: Label 'C:\inetpub\wwwroot\StudentPortal\Downloads\';
        FILESPATH_A: Label 'D:\';
        AdmissionFormHeader: Record "ACA-Applic. Form Header";
        ApplicQualification: Record "ACA-Applic. Form Qualification";
        ApplicpPostGraduate: Record "ACA-Applic Form PostGraduate";
        ApplicPostEmployment: Record "ACA-Applic. Form Employment";
        ApplicPhd: Record "ACA-Applic Form pHD additional";
        ApplicPostReferee: Record "ACA-Applic Form Referee";
        FILESPATH_SSP: Label 'D:\';
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
        TTTimetableFInalCollector: Record "TT-Timetable FInal Collector";
        EXTTimetableFInalCollector: Record "EXT-Timetable FInal Collector";
        KUCCPSRaw: Record "KUCCPS Imports";
        ImportsBuffer: Record "ACA-Imp. Receipts Buffer";
        ClearanceHeader: Record "ACA-Clearance Header";
        NextJobapplicationNo: Text;
        studetUnits: Record "ACA-Student Units";
        StudentsTransfer: Record "ACA-Students Transfer";
        AcaSpecialExamsDetailss: Record "Aca-Special Exams Details";
        InterSchoolTransfer: Record "ACA-Students Transfer";
        ProgStages: Record "ACA-Programme Stages";
        ClassifiactionStudents: Record "ACA-Exam Classification Studs";

    // JobApplications: Record "61225";
    // NextJobapplicationNo: Code[20];
    //ClearanceHeader: Record "61357";
    //RecAccountusers: Record "78013";
    //ClaimRequisition: Record "61602";
    //NextClaimapplicationNo: Code[20];

#pragma warning disable AL0667

#pragma warning restore AL0667

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
            REPORT.SAVEASPDF(51072, filename, Customer);
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
            REPORT.SAVEASPDF(51015, filename, "Fee By Stage");
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
            REPORT.SAVEASPDF(51774, filename, CourseRegistration);
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
            REPORT.SAVEASPDF(51797, filename, CourseRegistration);
        END;
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
        //CourseReg.Stage:=stage;
        CourseReg.VALIDATE(Stage);
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
            REPORT.SAVEASPDF(51794, filename, Programme);   //52017726
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
            REPORT.SAVEASPDF(51524, filename, Receiptz);   //52017726
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
                    FullNames := StudentCard.Name;
                    Message := TXTCorrectDetails + '::' + FORMAT(StudentCard."Changed Password") + '::' + StudentCard."No." + '::' + StudentCard.Name + '::' + FORMAT(StudentCard.Status);
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
  + '::' + FORMAT(CurrentSem."Mark entry Dealine") + '::' + FORMAT(CurrentSem."Lock Lecturer Editing") + '::' + FORMAT(CurrentSem.AllowDeanEditing) + '::' + FORMAT(CurrentSem."Unit Registration Deadline");
        END
    end;


    procedure GetStudentCourseData(StudentNo: Text; Sem: Text) Message: Text
    begin
        CourseRegistration.RESET;
        CourseRegistration.SETRANGE(CourseRegistration."Student No.", StudentNo);
        //CourseRegistration.SETRANGE(CourseRegistration.Semester,Sem);
        CourseRegistration.SETRANGE(CourseRegistration.Reversed, FALSE);
        //CourseRegistration.SETRANGE(CourseRegistration.Posted,FALSE);
        CourseRegistration.SETCURRENTKEY(Stage);
        IF CourseRegistration.FIND('+') THEN BEGIN
            Message := CourseRegistration.Stage + '::' + CourseRegistration.Programmes + '::' + CourseRegistration."Reg. Transacton ID" + '::' + CourseRegistration.Semester + '::'
    + CourseRegistration."Settlement Type" + '::' + GetProgram(CourseRegistration.Programmes) + '::' + GetSchool(CourseRegistration.Programmes);
        END;
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
        UnitSubjects.SETRANGE(UnitSubjects."Time Table", TRUE);
        UnitSubjects.SETRANGE(UnitSubjects."Old Unit", FALSE);
        IF UnitSubjects.FIND('-') THEN BEGIN
            Message := UnitSubjects.Desription;
        END
    end;


    procedure SubmitUnits(studentNo: Text; Unit: Text; Prog: Text; myStage: Text; sem: Text; RegTransID: Text; UnitDescription: Text; AcademicYear: Text) ReturnMessage: Text[150]
    var
        Customer: Record "Customer";
    begin
        IF Customer.GET(studentNo) THEN BEGIN
            Customer.CALCFIELDS(Balance);
            IF Customer.Balance > 0 THEN BEGIN
                ReturnMessage := 'Units not registered! Your Balance is greater than zero!';
            END;
        END;
        IF NOT (Customer.Balance > 0) THEN BEGIN
            StudentUnits.INIT;
            StudentUnits."Student No." := studentNo;
            StudentUnits.Unit := Unit;
            StudentUnits.Programme := Prog;
            StudentUnits.Stage := myStage;
            StudentUnits.Semester := sem;
            StudentUnits.Taken := TRUE;
            StudentUnits."Reg. Transacton ID" := RegTransID;
            StudentUnits."Unit Description" := UnitDescription;
            StudentUnits."Academic Year" := AcademicYear;
            StudentUnits.INSERT(TRUE);
            ReturnMessage := 'Units registered Successfully!'
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
        StudentUnits.SETRANGE(StudentUnits.Stage, Stage);
        IF StudentUnits.FIND('-') THEN BEGIN
            Message := TXTtaken + '::';
        END ELSE BEGIN
            Message := TXTNotTaken + '::';
        END
    end;


    procedure SubmitUnitsBaskets(studentNo: Text; Unit: Text; Prog: Text; myStage: Text; sem: Text; RegTransID: Text; UnitDescription: Text; AcademicYear: Text)
    begin
        StudentUnitBaskets.RESET;
        StudentUnitBaskets.SETRANGE("Student No.", studentNo);
        StudentUnitBaskets.SETRANGE(Unit, Unit);
        StudentUnitBaskets.SETRANGE(Programmes, Prog);
        StudentUnitBaskets.SETRANGE(Stage, myStage);
        StudentUnitBaskets.SETRANGE(Semester, sem);
        StudentUnitBaskets.SETRANGE("Reg. Transacton ID", RegTransID);
        StudentUnitBaskets.SETRANGE("Academic Year", AcademicYear);
        IF NOT StudentUnitBaskets.FIND('-') THEN BEGIN
            StudentUnitBaskets.INIT;
            StudentUnitBaskets."Student No." := studentNo;
            StudentUnitBaskets.Unit := Unit;
            StudentUnitBaskets.Programmes := Prog;
            StudentUnitBaskets.Stage := myStage;
            StudentUnitBaskets.Taken := TRUE;
            StudentUnitBaskets.Semester := sem;
            StudentUnitBaskets."Reg. Transacton ID" := RegTransID;
            StudentUnitBaskets.Description := UnitDescription;
            StudentUnitBaskets."Academic Year" := AcademicYear;
            StudentUnitBaskets.Posted := FALSE;
            StudentUnitBaskets.INSERT(TRUE);
        END ELSE BEGIN
            StudentUnitBaskets.Posted := FALSE;
            StudentUnitBaskets.MODIFY;
        END;
    end;


    procedure GetUnitSelected(UnitID: Text; StudentNo: Text; Stage: Text) Message: Text
    var
        TXTtaken: Label 'Taken';
        TXTNotTaken: Label 'Not Taken';
    begin
        StudentUnitBaskets.RESET;
        StudentUnitBaskets.SETRANGE(StudentUnitBaskets.Unit, UnitID);
        StudentUnitBaskets.SETRANGE(StudentUnitBaskets."Student No.", StudentNo);
        StudentUnitBaskets.SETRANGE(StudentUnitBaskets.Stage, Stage);
        StudentUnitBaskets.SETRANGE(StudentUnitBaskets.Posted, FALSE);
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


    procedure DeleteSubmittedUnit(studentNo: Text)
    begin
        StudentUnitBaskets.RESET;
        StudentUnitBaskets.SETRANGE(StudentUnitBaskets."Student No.", studentNo);
        IF StudentUnitBaskets.FIND('-') THEN BEGIN
            REPEAT
                StudentUnitBaskets.Posted := TRUE;
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
        CourseRegistration.RESET;
        CourseRegistration.SETRANGE(CourseRegistration."Student No.", StudentNo);
        CourseRegistration.SETRANGE(CourseRegistration."Academic Year", AcademicYear);

        IF CourseRegistration.FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(51772, filename, CourseRegistration);
        END;
    end;


    procedure GenerateLeaveStatement(StaffNo: Text; filenameFromApp: Text)
    var
        filename: Text;
    begin
        filename := FILESPATH_S + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.", StaffNo);

        IF EmployeeCard.FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(51457, filename, EmployeeCard);
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
        AcaSpecialExamsDetails.SETRANGE("Current Academic Year", AcademicYear);
        AcaSpecialExamsDetails.SETRANGE("Student No.", StudNo);
        AcaSpecialExamsDetails.SETRANGE("Unit Code", UnitCode);
        IF AcaSpecialExamsDetails.FIND('-') THEN BEGIN
            AcaSpecialExamsResults.RESET;
            AcaSpecialExamsResults.SETRANGE("Current Academic Year", AcademicYear);
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
                AcaSpecialExamsResults."Current Academic Year" := AcaSpecialExamsDetails."Current Academic Year";
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

        END
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
        // EXTTimetableFInalCollector: Record "74568";
        // TTTimetableFInalCollector: Record "74523";
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
                    REPORT.RUN(74501, TRUE, FALSE, TTTimetableFInalCollector);
                    filename := FILESPATH_S + StudentNo + '_ClassTimetable_' + Semesters;
                    IF EXISTS(filename) THEN
                        ERASE(filename);
                    REPORT.SAVEASPDF(74501, filename, TTTimetableFInalCollector);
                END;
            END ELSE
                IF TimetableType = 'EXAM' THEN BEGIN
                    //**2. Exam Timetable
                    EXTTimetableFInalCollector.RESET;
                    EXTTimetableFInalCollector.SETRANGE(Programme, ACACourseRegistration.Programmes);
                    EXTTimetableFInalCollector.SETRANGE(Semester, Semesters);
                    EXTTimetableFInalCollector.SETFILTER(Unit, UnitFilterString);
                    IF EXTTimetableFInalCollector.FIND('-') THEN BEGIN//Pull the Exam Timetable Here
                        REPORT.RUN(74551, TRUE, FALSE, EXTTimetableFInalCollector);
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
                    filename := FILESPATH_S + filenameFromApp;
                    IF EXISTS(filename) THEN
                        ERASE(filename);
                    REPORT.SAVEASPDF(74501, filename, TTTimetableFInalCollector);
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
                        filename := FILESPATH_S + filenameFromApp;
                        IF EXISTS(filename) THEN
                            ERASE(filename);
                        REPORT.SAVEASPDF(74551, filename, EXTTimetableFInalCollector);
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


    procedure SubmitUnitsBasketsRegister(studentNo: Text; Unit: Text; Prog: Text; myStage: Text; sem: Text; RegTransID: Text; UnitDescription: Text; AcademicYear: Text; HODz: Text)
    begin
        StudentUnitBaskets.INIT;
        StudentUnitBaskets."Student No." := studentNo;
        StudentUnitBaskets.Unit := Unit;
        StudentUnitBaskets.Programmes := Prog;
        StudentUnitBaskets.Stage := myStage;
        StudentUnitBaskets.Taken := TRUE;
        StudentUnitBaskets.Semester := sem;
        StudentUnitBaskets."Reg. Transacton ID" := RegTransID;
        StudentUnitBaskets.Description := UnitDescription;
        StudentUnitBaskets."Academic Year" := AcademicYear;
        StudentUnitBaskets.HOD := HODz;
        StudentUnitBaskets.Posted := FALSE;
        StudentUnitBaskets.New := TRUE;
        StudentUnitBaskets.INSERT(TRUE);
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
        NextLeaveApplicationNo := NoSeriesMgt.GetNextNo('APP', 0D, TRUE);
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
        AplicFormHeader."No. Series" := 'APP';
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
        ProgramSem.RESET;
        ProgramSem.SETRANGE(ProgramSem."Programme Code", Progz);
        ProgramSem.SETRANGE(ProgramSem.Current, TRUE);
        IF ProgramSem.FIND('-') THEN BEGIN
            Message := ProgramSem.Semester;

        END
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
            IF Customerz1.CALCFIELDS(Balance) THEN;
            ACACourseRegistrationz.RESET;
            ACACourseRegistrationz.SETRANGE("Student No.", StudentN);
            ACACourseRegistrationz.SETRANGE(Semester, Semest);
            IF ACACourseRegistrationz.FIND('-') THEN BEGIN
                IF ACACourseRegistrationz.CALCFIELDS("Total Billed") THEN BEGIN
                    IF NOT (Customerz1.Balance > ((ACACourseRegistrationz."Total Billed") / 2)) THEN Register := 'YES';
                END;
            END;
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
            REPORT.SAVEASPDF(51343, filename, KUCCPSRaw);
            //AdmissionFormHeader.RESET;
            //AdmissionFormHeader.SETRANGE(AdmissionFormHeader."Admission No.",AdmNo);

            //IF AdmissionFormHeader.FIND('-') THEN BEGIN
            //REPORT.SAVEASPDF(51343,filename,AdmissionFormHeader);
            // REPORT.SAVEASPDF(51338,filename,AdmissionFormHeader);
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
            REPORT.SAVEASPDF(51339, filename, AplicFormHeader);
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
            REPORT.SAVEASPDF(51794, filename, Programme);   //52017726
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
        NextLeaveApplicationNo := NoSeriesMgt.GetNextNo('APP', 0D, TRUE);
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
        AplicFormHeader."No. Series" := 'APP';
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
        KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(KUCCPSRaw.Index, username);
        IF KUCCPSRaw.FIND('-') THEN BEGIN
            Message := KUCCPSRaw.Index + '::' + KUCCPSRaw.Admin + '::' + FORMAT(KUCCPSRaw.Prog) + '::' + KUCCPSRaw.Names + '::' + FORMAT(KUCCPSRaw.Gender) + '::' +
            KUCCPSRaw.Phone + '::' + KUCCPSRaw.Box + '::' + KUCCPSRaw.Codes + '::' + KUCCPSRaw.Town + '::' + KUCCPSRaw.Email + '::' + KUCCPSRaw."ID Number/Birth Certificate" + '::' +
            FORMAT(KUCCPSRaw."Date of Birth") + '::' + FORMAT(KUCCPSRaw.County) + '::' + FORMAT(KUCCPSRaw.Nationality) + '::' + FORMAT(KUCCPSRaw."Ethnic Background") + '::' +
            FORMAT(KUCCPSRaw."Disability Status") + '::' + KUCCPSRaw."Disability Description";
        END
    end;


    procedure UpdateKUCCPSProfile(username: Text; Genderz: Integer; Phonez: Code[20]; Boxz: Code[50]; Codesz: Code[20]; Townz: Code[40]; Emailz: Text; Countyz: Code[50]; DateofBirth: Date; IDNumber: Text; PhysicalImpairments: Boolean; PhysicalImpairmentsDetails: Text; Ethnic: Code[50]; Nationalityz: Code[50])
    begin
        KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(KUCCPSRaw.Index, username);
        IF KUCCPSRaw.FIND('-') THEN BEGIN
            KUCCPSRaw.Gender := Genderz;
            KUCCPSRaw.Phone := Phonez;
            KUCCPSRaw.Box := Boxz;
            KUCCPSRaw.Codes := Codesz;
            KUCCPSRaw.Town := Townz;
            KUCCPSRaw.Email := Emailz;
            KUCCPSRaw.County := Countyz;
            KUCCPSRaw."Date of Birth" := DateofBirth;
            KUCCPSRaw."ID Number/Birth Certificate" := IDNumber;
            KUCCPSRaw."Disability Status" := PhysicalImpairments;
            KUCCPSRaw."Disability Description" := PhysicalImpairmentsDetails;
            KUCCPSRaw."Ethnic Background" := Ethnic;
            KUCCPSRaw.Nationality := Nationalityz;
            KUCCPSRaw.Updated := TRUE;
            KUCCPSRaw.MODIFY;
            //MESSAGE('Meal Item Updated Successfully');
        END;
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


    procedure GenerateReferralReport(EmployeeNo: Text; filenameFromApp: Text) filename: Text[100]
    begin
        /*filename :=FILESPATH_S+filenameFromApp;
        IF EXISTS(filename) THEN
          ERASE(filename);
        //MESSAGE('OK');
        Referrralll.RESET;
        Referrralll.SETRANGE(Referrralll."Treatment no.",EmployeeNo);

        IF Referrralll.FIND('-') THEN BEGIN
        REPORT.SAVEASPDF(51871,filename,Referrralll);   //52017726
         END;
        EXIT(filename);*/

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


    procedure UpdateContStudentProfile(username: Text; Genderz: Integer; Phonez: Code[20]; Boxz: Code[50]; Codesz: Code[20]; Townz: Code[40]; Emailz: Text; Countyz: Code[50]; DateofBirth: Date; IDNumber: Text; PhysicalImpairments: Integer; PhysicalImpairmentsDetails: Text; Ethnic: Code[50]; Nationalityz: Code[50])
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
            Customer.Nationality := Nationalityz;
            Customer.County := Countyz;
            Customer.Address := Boxz;
            Customer."Post Code" := Codesz;
            Customer."Address 2" := Townz;
            Customer."Disability Description" := PhysicalImpairmentsDetails;
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
            REPORT.SAVEASPDF(51725, filename, ClearanceHeader);
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
                rtnMsg := 'SUCCESS: You have deleted ' + Unit;
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
}

