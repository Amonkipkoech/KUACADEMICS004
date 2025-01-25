codeunit 40002 StaffPortall
{
    trigger OnRun()
    var
        myInt: Integer;
    begin
        // Message('filename');
        // IF EXISTS('C:\Slip') THEN
        //     ERASE('C:\Slip');
        // HRMEmployeeD.Reset();
        // HRMEmployeeD.SETRANGE(HRMEmployeeD."No.", '90352');
        // HRMEmployeeD.SETRANGE(HRMEmployeeD."Period Filter", 20220901D);
        // IF HRMEmployeeD.FIND('-') THEN BEGIN
        //     Message('in table');
        //     REPORT.SaveAsExcel(64310, 'C:\Slip', HRMEmployeeD);
        //     // filename := FORMAT(Period) + filename;
        // END;
    end;

    var
        EmployeeCard: Record 61188;
        trscripttbl: Record "Final Exam Result2";
        LeaveLE: Record "HRM-Leave Ledger";
        LeaveT: Record "HRM-Leave Requisition";
        HRLeave: Record "HRM-Leave Requisition";
        ltype: Record "HRM-Leave Types";
        HRSetup: Record "HRM-Setup";
        HRMEmployeeD: Record 61188;
        SupervisorCard: Record "User Setup";
        AcaApplications: Record "ACA-Applic. Form Header";
        ApprovalMgmtExt: Codeunit "Approval Mgmnt. Ext";
        ApprovalMgmtHr: Codeunit IntCodeunit;
        //ApprovalMgmtHr: Codeunit "Approval Mgmnt. Ext(hr)";
        PurchaseRN: Record "Purchase Header";
        PurchaseLines: Record "Purchase Line";
        ClaimRequisition: Record "FIN-Staff Claims Header";
        PRLPeriodTransactions: Record "PRL-Period Transactions";
        StoreRequisition: Record "PROC-Store Requistion Header";
        StoreReqLines: Record "PROC-Store Requistion Lines";
        ImprestRequisition: Record "FIN-Imprest Header";
        ApproverComments: Record "Approval Comment Line";
        ImprestReqLines: Record "FIN-Imprest Lines";
        ClaimReqLines: Record "FIN-Staff Claim Lines";
        P9: Record "PRL-Employee P9 Info";
        //VenueRequisition: Record "Gen-Venue Booking";
        RecAccountusers: Record "Online Recruitment users";
        JobApplications: Record "HRM-Job Applications (B)";
        ApplicantQualifications: Record "HRM-Applicant Qualifications";
        NextJobapplicationNo: Code[20];
        dates: Record Date;
        SDate: Date;
        EndLeave: Boolean;
        varDaysApplied: Decimal;
        fReturnDate: Date;
        DayCount: Integer;
        tableNo: Integer;
        State: Option Open,Pending,Approval,Cancelled,Approved,"Pending Approval";
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
        BaseCalendar: Record "Base Calendar Change";
        ApprovalEntry: Record "Approval Entry";
        ApprovalEntry_2: Record "Approval Entry";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Approvals: Codeunit "Approval Workflow Setup Mgt.";
        TXTCorrectDetails: Label 'Login';
        TXTIncorrectDetails: Label 'Incorrect Username or Password';
        FILESPATH_S: Label 'C:\inetpub\wwwroot\KUPORTALS\StaffPortal\Downloads\';
        //         <system.webServer>
        //   <rewrite>
        //     <rules>
        //       <rule name="HTTPS Redirect" enabled="true" stopProcessing="true">
        //         <match url="(.*)" />
        //         <conditions>
        //           <add input="{HTTPS}" pattern="^OFF$" />
        //         </conditions>
        //         <action type="Redirect" url="https://{HTTP_HOST}/{R:1}" redirectType="Permanent" />
        //       </rule>
        //     </rules>
        //   </rewrite>
        // </system.webServer>

        Text004: Label 'Approval Setup not found.';
        TblCustomer: Record Customer;
        EmpHist: Record "HRM-Employment History";
        daysInteger: Decimal;
        NextLeaveApplicationNo: Text;
        NextClaimapplicationNo: text;
        NextImprestapplicationNo: Text;
        NextStoreqNo: Text;
        bankintegration: Codeunit BankIntegration;

        NextVenueBookingNo: Text;
        LastNum: Text;
        SupervisorId: Text;
        EmployeeUserId: Text;
        FullNames: Text;
        Initials: Option;
        pCode: Code[30];
        IDNum: Text;
        Gender: Option;
        Phone: Code[20];
        rAddress: Text;
        Citizenship: Text;
        County: Text;
        Mstatus: Option;
        Eorigin: Option;
        Disabled: Text;
        dDetails: Text;
        DOB: Date;
        Dlicense: Text;
        KRA: Text;
        firstLang: Code[50];
        secondLang: Code[50];
        AdditionalLang: Code[50];
        ApplicantType: Option;
        pAddress: Text;
        filename: Text;
        IStream: InStream;
        Bytes: DotNet Bytes;
        Convert: DotNet Convert;
        MemStream: DotNet MemoryStream;

        ExamResults: Record "ACA-Exam Results";
        ExamsSetup: Record "ACA-Exams Setup";
        UnitSubjects: Record "ACA-Units/Subjects";
        Programme: Record "ACA-Programme";
        AcademicYr: Record "ACA-Academic Year";
        DimensionValue: Record "Dimension Value";
        CurrentSem: Record "ACA-Semesters";
        StudentUnitBaskets: Record "ACA-Student Units Baskets";
        CourseRegistration: Record "ACA-Course Registration";
        ACALecturersUnits: Record "ACA-Lecturers Units";
        AcaSpecialExamsDetails: Record "Aca-Special Exams Details";
        AcaSpecialExamsResults: Record "Aca-Special Exams Results";
        ACAExamResults: Record "ACA-Exam Results";
        leaveSch: Record "HRM-Leave Schedule";
        jobPosts: Record "HRM-Jobs";
        EmpReq: Record "HRM-Employee Requisitions";
        NextEmpReqNo: Text;
        fabList: Record "ACA-Applic. Form Header";
        programs: Record "ACA-Programme";
        programstages: Record "ACA-Programme Stages";
        semesters: Record "ACA-Programme Semesters";
        stageSemester: Record "ACA-Programme Stage Semesters";
        studymodes: Record "ACA-Student Types";
        HrTrainings: Record "HRM-Training Applications";
        TrainingParticipants: Record "HRM-Training Participants";
        AttendanceHeader: Record "Class Attendance Header";
        AttendanceDetails: Record "Class Attendance Details";
        ProgramUnits: Record "ACA-Semester Units On Offer";
        WorkExp: Record "HRM-Work eXP";
        Referees: Record "HRM-Applicant Referees";
        profQuals: Record "HRM-Prof Qualification";
        centralsetup: Record "ACA-Academics Central Setups";
        religions: Record "ACA-Religions";
        lecunits: Record "ACA-Lecturers Units";
        portalsetup: Record "PortalSetup";
        StudentUnits: Record "ACA-Student Units";
        Items: Record Item;
        GLAccounts: Record "G/L Account";
        hrdates: Codeunit "HR Dates";
        PRNPayablesSetup: Record "Purchases & Payables Setup";
        ExamGradingSourse: Record "ACA-Exam Grading Source";
        DocAtt: Page "Document Attachment Custom";
        offeredunits: Record "ACA-Units Offered";
        days: Record "TT-Days";
        timeslots: Record "TT-Daily Lessons";
        lecturehalls: Record "ACA-Lecturer Halls Setup";
        lecturers: Record "ACA-Lecturers Units";
        associatedunits: Record acaAssosiateUnits;
        ImprestSurrHeader: Record "FIN-Imprest Surr. Header";
        ImprestSurrDetails: Record "FIN-Imprest Surrender Details";
        ImprestRequisitionLines: Record "FIN-Imprest Lines";
        users: Record "User Setup";
        ApprovalMgmtFin: Codeunit "Approval Mgmnt. Ext";
        PartTimeClaimLn: Record "Parttime Claim Lines";
        PartTimeClaimHd: Record "Parttime Claim Header";
        banks: Record "PRL-Bank Structure";
        applicsummaryreport: Report "ACA-APPLICANTS Report";
        settlementtypes: Record "ACA-Settlement Type";
        stdissues: Record studentIssues;

        group: Record "GroupAssignments";
        unitsOnOffer: Record "ACA-Units Offered";
        masterRotation: Record "Master Rotation Table";
        clinicals: Record "Clinical rotation";
        clinicalAbs: Record "Student Absence Request";

    // Staff Portal Functions
    procedure CheckStaffLogin(username: Code[20]; userpassword: Text[50]) ReturnMsg: Text[200];
    begin
        EmployeeCard.Reset();
        EmployeeCard.SetRange(EmployeeCard."No.", username);

        if (EmployeeCard.Find('-')) then begin
            if (EmployeeCard.Status = 0) then begin
                if (EmployeeCard."Changed Password" = true) then begin
                    if (EmployeeCard."Portal Password" = userpassword) then begin
                        ReturnMsg := 'SUCCESS' + '::' + Format(EmployeeCard."Changed Password") + '::' + EmployeeCard."No." + '::' + EmployeeCard."First Name" + ' ' + EmployeeCard."Last Name" + '::' + EmployeeCard."CUEA Email Address";
                    end else begin
                        FullNames := EmployeeCard."First Name" + ' ' + EmployeeCard."Middle Name" + ' ' + EmployeeCard."Last Name";
                        ReturnMsg := 'Invalid Password' + '::' + Format(EmployeeCard."Changed Password") + '::' + EmployeeCard."No." + '::' + FullNames;
                    end
                end else begin
                    if (EmployeeCard."Portal Password" = userpassword) then begin
                        ReturnMsg := 'SUCCESS' + '::' + Format(EmployeeCard."Changed Password") + '::' + EmployeeCard."No." + '::' + FullNames + '::' + EmployeeCard."CUEA Email Address";
                    end else begin
                        ReturnMsg := 'Invalid Password' + '::' + Format(EmployeeCard."Changed Password");
                    end
                end
            end else begin
                ReturnMsg := 'Your Account Status Is Inactive. Please Contact Administrator.' + '::';
            end
        end else begin
            ReturnMsg := 'Invalid Staff Number' + '::';
        end

    end;

    procedure GetStudentName(StudentNo: Text) Message: Text
    var
        FullDetails: Integer;
    begin
        TblCustomer.RESET;
        TblCustomer.SETRANGE(TblCustomer."No.", StudentNo);
        IF TblCustomer.FIND('-') THEN BEGIN
            Message := TblCustomer.Name;
        END
    end;

    procedure GroupSubjects(paper: Option; unitCode: Text; currentsem: Text; AcademicYr: Text; stage: Text): Text
    var
        theoryUnits: Record "ACA-Student Theory Units ";
        modifiedCount: Integer;
    begin

        theoryUnits.SetRange(Unit, unitCode);
        theoryUnits.SetRange(Semester, currentsem);
        theoryUnits.SetRange("Academic Year", AcademicYr);
        theoryUnits.SetRange(Stage, stage);
        modifiedCount := 0;


        if theoryUnits.FindSet() then begin
            repeat
                theoryUnits.Paper := paper;
                if theoryUnits.Modify() then
                    modifiedCount += 1;
            until theoryUnits.Next() = 0;
        end;

        if modifiedCount > 0 then
            exit(Format('%1 record(s) updated successfully.', modifiedCount))
        else
            exit('No records found matching the criteria.');
    end;

    procedure GetGroupedPapers(dept: Text; currentSem: Text; AcademicYr: Text; stage: Text): Text
    var
        theoryUnits: Record "ACA-Student Theory Units ";
        Message: Text;
    begin
        theoryUnits.Reset();
        theoryUnits.SetRange(Programme, dept);
        theoryUnits.SetRange(Semester, currentSem);
        theoryUnits.SetRange("Academic Year", AcademicYr);
        theoryUnits.SetRange(Stage, stage);

        if theoryUnits.FindSet() then begin
            repeat

                Message += 'SUCCESS' + '::' + theoryUnits.Unit + '::' + GetUnitDescription(theoryUnits.Unit) + '::' + Format(theoryUnits.Paper) + '[]';

            until theoryUnits.Next() = 0;
        end;

        exit(Message);
    end;

    procedure AssignLecturerPapers(unitCode: Text; prog: Text; stage: Text; sem: Text; AcdYr: Text; lect: Text): Text
    var
        modifiedCount: Integer;
        Message: Text;
    begin
        modifiedCount := 0;
        StudentUnits.Reset();
        StudentUnits.SetRange(Programme, prog);
        StudentUnits.SetRange(Stage, stage);
        StudentUnits.SetRange(Semester, sem);
        StudentUnits.SetRange("Academic Year", AcdYr);
        StudentUnits.SetRange(Unit, unitCode);

        if StudentUnits.Find('-') then begin
            repeat
                StudentUnits.Supervisor := lect;
                if StudentUnits.Modify() then
                    modifiedCount += 1;
            until StudentUnits.Next() = 0;

            if modifiedCount > 0 then
                Message := Format('%1 record(s) updated successfully.', modifiedCount)
            else
                Message := 'No records found matching the criteria.';
        end else begin
            Message := 'No records found matching the criteria.';
        end;

        exit(Message);
    end;

    // procedure GetAssignedPaperUnits(sem:Text;AcademicYr:Text;Stage:Text;Prog:Text)Message:Text
    // begin
    //     StudentUnits.Reset();
    //     StudentUnits.SetRange(Semester,sem);
    //     StudentUnits.SetRange("Academic Year",AcademicYr);
    //     StudentUnits.SetRange(Stage,Stage);
    //     StudentUnits.SetRange(Programme,Prog);

    //     if StudentUnits.Find('-') then begin
    //         repeat
    //         Message += 'SUCCESS'+'::'+StudentUnits.Supervisor+'::'+StudentUnits.Unit+'::'+GetLecturerNames(StudentUnits.Supervisor)+'[]';
    //         until StudentUnits.Next() = 0;
    //     end;
    //     exit(Message);

    // end;
    procedure GetAssignedPaperUnits(sem: Text; AcademicYr: Text; Stage: Text; Prog: Text): Text
    var
        TempUniqueUnits: Record "ACA-Student Units" temporary;
        Message: Text;
        Keyy: Text;
    begin
        StudentUnits.Reset();
        StudentUnits.SetRange(Semester, sem);
        StudentUnits.SetRange("Academic Year", AcademicYr);
        StudentUnits.SetRange(Stage, Stage);
        StudentUnits.SetRange(Programme, Prog);
        StudentUnits.SetRange(StudentUnits."Unit Category", StudentUnits."Unit Category"::Exam);

        if StudentUnits.Find('-') then begin
            repeat
                Keyy := StudentUnits.Supervisor + '::' + StudentUnits.Unit;

                TempUniqueUnits.SetRange(Supervisor, StudentUnits.Supervisor);
                TempUniqueUnits.SetRange(Unit, StudentUnits.Unit);
                TempUniqueUnits.SetRange("Unit Category", TempUniqueUnits."Unit Category"::Exam);

                if TempUniqueUnits.IsEmpty() then begin
                    TempUniqueUnits.Init();
                    TempUniqueUnits.Supervisor := StudentUnits.Supervisor;
                    TempUniqueUnits.Unit := StudentUnits.Unit;
                    TempUniqueUnits.Insert();

                    Message += 'SUCCESS' + '::' + GetLecturerNames(StudentUnits.Supervisor) + '::' + StudentUnits.Supervisor + '::' + StudentUnits.Unit + '::' + GetLecturerDept(StudentUnits.Supervisor) + '::' + StudentUnits.Semester + '[]';
                end;
            until StudentUnits.Next() = 0;
        end;

        exit(Message);
    end;

    procedure GetLecturerDept(lecNo: Text) Message: Text
    begin
        HRMEmployeeD.Reset();
        HRMEmployeeD.SetRange(HRMEmployeeD."No.", lecNo);
        if HRMEmployeeD.FindFirst() then begin
            Message := HRMEmployeeD."Department Code";
        end;
        exit(Message);

    end;



    procedure GetExamAttendance(unitCode: Text; lectNo: Text; semester: Text) Message: Text
    var
        examAttendance: Record "ACA-Exam Attendance Register";
    begin
        examAttendance.Reset();
        examAttendance.SetRange(examAttendance."Lecturer No.", lectNo);
        examAttendance.SetRange(examAttendance."Semester Code", semester);
        examAttendance.SetRange(examAttendance."Unit Code", unitCode);

        if examAttendance.Find('-') then begin
            repeat
                Message += 'SUCCESS' + '::' + examAttendance."Student No." + '::' + GetStudentName(examAttendance."Student No.") + '::' + Format(examAttendance."Exam Date") + '::' + examAttendance."Exam Hall ID" + '[]';
            until examAttendance.Next() = 0;
        end;
        exit(Message);

    end;

    procedure GetMasterRotationPlan(Department: Text) Message: Text
    var
        masterRotation: Record "Master Rotation Plan2";
    begin
        masterRotation.Reset();
        masterRotation.SetRange(masterRotation.Department, Department);
        masterRotation.SetRange(Exhausted, False);
        if masterRotation.FindFirst() then begin
            repeat
                Message += 'SUCCESS' + '::' + masterRotation."Plan ID" + '::' + Format(masterRotation."Block1 Start Date") + '::' + Format(masterRotation."Block1 End Date") + '::'
                + Format(masterRotation."Clinical1 Start Date") + '::' + Format(masterRotation."Clinical1 End Date") + '::' + Format(masterRotation."Block2 Start Date") + '::'
                + Format(masterRotation."Block2 End Date") + '::' + Format(masterRotation."Clinical2 Start Date") + '::' + Format(masterRotation."Clinical2 End Date") + '::' + Format(masterRotation.Status);
            until masterRotation.Next() = 0;

        end;
        Exit(Message);

    end;


    procedure GetStudentStatus(StudentNo: Text) Message: Text
    begin
        TblCustomer.Reset();
        TblCustomer.SetRange(TblCustomer."No.", StudentNo);
        if TblCustomer.FindFirst() then begin
            Message := 'SUCCESS' + '::' + Format(TblCustomer.Status);
        end;
    end;

    procedure SetStudentStatus(StudentNo: Text[20]; Status: Option): Text[100]

    begin

        TblCustomer.Reset();
        TblCustomer.SetRange(TblCustomer."No.", StudentNo);


        if TblCustomer.FindFirst() then begin

            TblCustomer.Status := Status;

            if TblCustomer.Modify() then begin
                exit('SUCCESS');

            end;


        end else begin

            exit('STUDENT NOT FOUND');
        end;
    end;

    procedure GetClinicalAbsence(dept: Text) Message: Text
    begin
        clinicalAbs.Reset();
        clinicalAbs.SetRange("Program Admitted", dept);
        clinicalAbs.SetRange("HOD Objection", clinicalAbs."HOD Objection"::Open);
        // clinicalAbs.SetRange()
        if clinicalAbs.Find('-') then begin
            repeat
                Message += 'SUCCESS' + '::' + clinicalAbs."Student Name" + '::' + clinicalAbs."Request No." + '::' + Format(clinicalAbs."Date From") + '::' + Format(clinicalAbs."Date To") + '::' + Format(clinicalAbs."Reason for Absence") + '::' + clinicalAbs."Other Reason (Specify)" + '::' + Format(clinicalAbs."Apply Remedial") + '[]';
            until clinicalAbs.Next() = 0;
        end;
        exit(Message);
    end;

    procedure AcceptClinicalAbscence(ClinicalNo: Text) message: Text
    begin
        clinicalAbs.Reset();
        clinicalAbs.SetRange("Request No.", ClinicalNo);
        if clinicalAbs.FindFirst() then begin
            clinicalAbs."HOD Objection" := clinicalAbs."HOD Objection"::"I Do Not Object";
            clinicalAbs."Institute Approval" := clinicalAbs."Institute Approval"::Approved;
            clinicalAbs."Institute Signature Date" := Today;
            if clinicalAbs.Modify() then begin
                Message := 'SUCCESS';
            end;

        end;
        exit(Message);
    end;

    procedure GetRemedialStudents(dept: Text) Message: Text
    var
        clinicalAbs: Record "Student Absence Request";
    begin
        clinicalAbs.Reset();
        clinicalAbs.SetRange("Program Admitted", dept);
        clinicalAbs.SetRange("Institute Approval", clinicalAbs."Institute Approval"::Approved);
        clinicalAbs.SetRange("Apply Remedial", true);

        if clinicalAbs.Find('-') then begin
            repeat
                Message += 'SUCCESS' + '::' + clinicalAbs."Student Name" + '::' + clinicalAbs."Admission Number" + '::' + Format(clinicalAbs."Date To") + '::' + Format(clinicalAbs."Apply Remedial") + '[]';
            until clinicalAbs.Next() = 0;
        end;
        exit(Message);

    end;

    procedure GetDistinctCohort(dept: Text; AcademicYr: Text; semester: Text) Message: Text
    var
        units: Record "ACA-Programme Stages";
    begin
        units.Reset();
        units.SetRange("Programme Code", dept);
        if units.Find('-') then begin
            repeat
                Message += units.Code + '[]';
            until units.Next() = 0;
        end;
        exit(Message);
    end;


    procedure DeclineClinicalAbscence(ClinicalNo: Text) message: Text
    begin
        clinicalAbs.Reset();
        clinicalAbs.SetRange("Request No.", ClinicalNo);
        if clinicalAbs.FindFirst() then begin
            clinicalAbs."HOD Objection" := clinicalAbs."HOD Objection"::"I Object";
            clinicalAbs."Institute Approval" := clinicalAbs."Institute Approval"::"Not Approved";
            if clinicalAbs.Modify() then begin
                Message := 'SUCCESS';
            end;

        end;

        exit(Message);
    end;


    procedure GetStudents(filter: Option) Message: Text
    begin
        TblCustomer.Reset();
        TblCustomer.setRange(TblCustomer.Status, filter);
        if TblCustomer.Find('-') then begin
            repeat
                Message += 'SUCCESS' + '::' + TblCustomer."First Name" + '::' + TblCustomer."Middle Name" + '::' + TblCustomer."Last Name" + '::' + TblCustomer."No." + '::' + TblCustomer.Nationality + '::'
                + TblCustomer."Current Programme" + '::' + TblCustomer."Current Semester" + '::' + TblCustomer."Current Settlement Type" + '::' + Format(TblCustomer.Status) + '[]';
            until TblCustomer.Next() = 0;
        end;
        exit(Message)
    end;

    procedure CreateMRP(
        prog: Text; dept: Text; HOD: Text;
        sem: Text; Year: Text; block1Start: Date; block1End: Date;
        Clinical1Start: Date; clibical1end: Date; block2Start: Date;
        block2End: Date; clinical2Start: Date; clinical2End: Date;
        cohort: Text) Message: Text
    var
        masterRotation: Record "Master Rotation Plan2";
    begin
        masterRotation.Reset();
        masterRotation.SetRange(Department, dept);
        masterRotation.SetRange(Year, Year);
        //masterRotation.SetRange(Category, Category);
        masterRotation.SetRange("Program Code", prog);

        if masterRotation.FindFirst() then begin
            Message := 'There Exists A MRP For this Period';
            exit(Message);

        end else begin
            //masterRotation.Category := Category;
            masterRotation."Program Code" := prog;
            masterRotation."Program Name" := GetProgram(prog);
            masterRotation.Department := dept;
            masterRotation.Year := Year;
            masterRotation.HOD := HOD;
            masterRotation."Hod Name" := GetLecturerNames(HOD);
            masterRotation."Block1 Start Date" := block1Start;
            masterRotation."Block1 End Date" := block1End;
            masterRotation."Clinical1 Start Date" := Clinical1Start;
            masterRotation."Clinical1 End Date" := clibical1end;
            masterRotation."Block2 Start Date" := block2Start;
            masterRotation."Block2 End Date" := block2End;
            masterRotation."Clinical2 Start Date" := clinical2Start;
            masterRotation."Clinical2 End Date" := clinical2End;
            masterRotation.Status := 1;
            masterRotation.Exhausted := False;
            masterRotation."No. Series" := 'MAROT';
            masterRotation.Cohort := cohort;

            if masterRotation.Insert(true) then begin
                Message := 'SUCCESS' + ' ' + masterRotation."Plan ID" + ' ' + 'Has been Created Successfully!!';
            end;
            EXIT(Message);

        end;

    end;


    procedure GetStudentAndGroups(dept: text) Message: Text
    begin
        group.Reset();
        group.setRange(Department, dept);
        if group.Find('-') then begin
            repeat
                Message += 'SUCCESS' + '::' + group.GroupId + '::' + group.StudentNo + '::' + GetStudentName(group.StudentNo) + '[]';
            until group.Next() = 0;
        end;
        exit(Message);
    end;

    procedure ChangeStudentGroup(formerGroup: Text; Newgroup: Text; studentNo: Text) Message: Text
    var
        TempGroup: Record GroupAssignments;
    begin
        group.Reset();
        TempGroup.SetRange(StudentNo, studentNo);
        TempGroup.SetRange(GroupId, formerGroup);
        if TempGroup.Find('-') then begin
            //Remove the entry first
            TempGroup.Delete();
        end;

        group.SetRange(GroupId, Newgroup);
        if group.FindFirst() then begin

            TempGroup := group;
            TempGroup.StudentNo := studentNo;

            if TempGroup.Insert() then
                Message := 'SUCCESS'
            else
                Message := 'FAILED TO INSERT RECORD';
        end else
            Message := 'GROUP NOT FOUND';

        exit(Message);
    end;

    procedure GetIqeExamStudents(program: Text) msg: Text
    var
        stages: Record "ACA-Programme Stages";
        units: Record "ACA-Units/Subjects";
        students: Record "ACA-Student Units";
    begin
        stages.RESET;
        stages.SETRANGE(stages."Programme Code", program);
        stages.SetRange("Final Stage", true);

        if stages.Find('-') then begin
            units.Reset();
            units.SetRange(units."Programme Code", program);
            units.SetRange(units."Stage Code", stages.Code);
            units.SetRange(units."Unit Type", units."Unit Type"::"Exam");
            if units.Find('-') then begin
                students.Reset();
                students.setRange(students.Unit, units.Code);
                if students.FindSet() then begin
                    repeat
                        msg += 'SUCCESS' + '::' + students."Student No." + '::' + GetStudentName(students."Student No.") + '[]';
                    until students.Next() = 0;
                end;

            end;
        end;

    end;


    procedure GetTotalStudentsInDept(dept: Text): Text
    var
        counter: Integer;
    begin
        counter := 0;
        CourseRegistration.Reset();
        CourseRegistration.SetRange(Programmes, dept);

        if CourseRegistration.FindSet() then begin
            repeat
                counter := counter + 1;
            until CourseRegistration.Next() = 0;
        end;

        exit(Format(counter));
    end;

    procedure GetMRP2() Message: Text
    var
        masterRotation: Record "Master Rotation Plan2";
    begin
        masterRotation.Reset();
        masterRotation.SetRange(Status, masterRotation.Status::Open);
        masterRotation.SetRange(Exhausted, False);
        if masterRotation.Find('-') then begin
            repeat
                Message += 'SUCCESS' + '::' + masterRotation."Plan ID" + '::' + masterRotation.Department + '::' + masterRotation."HoD Name" + '::' + masterRotation."Program Code"
                + '::' + masterRotation."Program Name" + '::' + Format(masterRotation."Block1 Start Date") + '::' + Format(masterRotation."Block1 End Date") + '::'
                + Format(masterRotation."Clinical1 Start Date") + '::' + Format(masterRotation."Clinical1 End Date") + '::' + Format(masterRotation."Block2 Start Date") + '::'
                + Format(masterRotation."Block2 End Date") + '::' + Format(masterRotation."Clinical2 Start Date") + '::' + Format(masterRotation."Clinical2 End Date") + '::' + Format(masterRotation.Status) + '[]';
            until masterRotation.Next() = 0;

        end;
        Exit(Message);
    end;

    procedure ChangeMRPStatus2(mrpNo: Text; status: Integer) Message: Text
    var
        masterRotation: Record "Master Rotation Plan2";
    begin
        masterRotation.Reset();
        masterRotation.SetRange(masterRotation."Plan ID", mrpNo);
        if masterRotation.FindFirst() then begin
            masterRotation.Status := status;

            if masterRotation.Modify() then begin

                Message := 'SUCCESS';

            end;
        end;
        exit(Message);
    end;

    procedure GetStudentDept(prog: Text) Message: Text
    var
        customer: Record "ACA-Programme";

    begin
        Programme.Reset();
        Programme.SetRange(Programme.Code, prog);
        if Programme.Find('-') then begin

            Message := Programme."Department Code";
        end;

        exit(Message);

    end;


    procedure GetOpenMasterPlans() Message: Text
    begin
        masterRotation.Reset();
        masterRotation.SetRange(masterRotation.Status, masterRotation.Status::Open);
        if masterRotation.Find('-') then begin
            repeat
                Message += 'SUCCESS' + '::' + masterRotation."Plan ID" + '::' + masterRotation.Department + '::' + masterRotation."HoD Name" + '::' + masterRotation."Program Code" + '::' + masterRotation."Program Name" + '[]';
            until masterRotation.Next() = 0;
        end;

        exit(Message);
    end;

    procedure ChangeMRPStatus(mrpNo: Text; status: Integer) Message: Text
    begin
        masterRotation.Reset();
        masterRotation.SetRange(masterRotation."Plan ID", mrpNo);
        if masterRotation.FindFirst() then begin
            masterRotation.Status := status;

            if masterRotation.Modify() then begin

                Message := 'SUCCESS';

            end;
        end;
        exit(Message);
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

    procedure GetXYFormLines(studentNo: Text) Message: Text
    var
        xyFromLines: Record "ACA-XYForm Lines";
    begin
        xyFromLines.Reset();
        xyFromLines.setRange(xyFromLines."Student No_", studentNo);
        if xyFromLines.Find('-') then begin
            repeat
                Message += 'SUCCESS' + '::' + xyFromLines."Area" + '::' + xyFromLines.Duration + '::' + xyFromLines.Time + '::' + xyFromLines.Coverage + '::' + Format(xyFromLines.Date) + '[]';
            until xyFromLines.Next() = 0;
        end;

    end;

    procedure GetXYForms(lectNo: Text; studentNo: Text) Message: Text
    var
        xyform: Record "ACA-XY-FORM";
    begin
        xyform.Reset();
        xyform.SetRange(xyform.LecturerNo, lectNo);
        xyform.SetRange(xyform.StudentNo, studentNo);
        if xyform.Find('-') then begin

            Message := 'SUCCESS' + '::' + xyform.StudentNo + '::' + xyform."Student Name" + '::' + xyform."Form Id";

        end;
        exit(Message);

    end;

    procedure ApproveRejectXyform(lectNo: Text; StudentNo: Text; status: Option) Message: Text
    var
        xyform: Record "ACA-XY-FORM";
    begin
        xyform.Reset();
        xyform.SetRange(xyform.LecturerNo, lectNo);
        xyform.SetRange(xyform.StudentNo, studentNo);
        if xyform.FindFirst() then begin
            xyform.Status := status;
            if xyform.Modify() then begin
                Message := 'Success';
            end;
        end;
        exit(Message);

    end;



    procedure AssignGroupLect(groupId: Text; lectNo: Text) Message: Text
    begin
        group.Reset();
        group.SetRange(group.GroupId, groupId);

        if group.Find('-') then begin
            repeat

                group.LecturerNo := lectNo;
                group.LecturerName := GetFullNames(lectNo);
                if group.Modify() then begin
                    Message := 'SUCCESS';
                end
            until group.Next() = 0;
        end;

        Exit(Message);
    end;

    procedure GetAssignedGroups(lecturerNo: Text): Text
    var
        Message: Text;
        LastGroupId: Code[20];
    begin

        group.Reset();
        group.SetRange(group.LecturerNo, lecturerNo);

        group.SetCurrentKey("GroupId");

        if group.FindSet() then begin
            repeat

                if group.GroupId <> LastGroupId then begin
                    Message += 'SUCCESS' + '::' + group.GroupId + '[]';
                    LastGroupId := group.GroupId;
                end;
            until group.Next() = 0;
        end;

        exit(Message);
    end;


    procedure GetAssignedStudents(lecturerNo: Text) Message: Text
    var
        xyform: Record "ACA-XY-FORM";

    begin
        group.Reset();
        xyform.Reset();
        xyform.setRange(xyform.LecturerNo, lecturerNo);
        xyform.SetRange(xyform.Status, 1);
        if xyform.find('-') then begin
            group.SetRange(group.LecturerNo, xyform.LecturerNo);

            if group.Find('-') then begin
                repeat
                    Message += 'SUCCESS' + '::' + group.StudentNo + '::' + GetStudentName(group.StudentNo) + '[]';
                until group.Next() = 0;
            end;

        end;
        exit(Message);


    end;

    procedure CreateMasterGroups(Block: Text; StudentNo: Text; numberOfStudents: Integer; MasterRotNo: Text; Department: Text) Message: Text
    var
        groupId: Text;
        studentsAssigned: Integer;
        masterRotation: Record "Master Rotation Plan2";

    begin

        group.Reset();
        masterRotation.Reset();


        group.SetRange(group.StudentNo, StudentNo);
        group.SetRange(group.Block, Block);

        if group.FINDFIRST then begin
            Message := 'Student is already assigned a group' + '::';
        end else begin

            masterRotation.SetRange(masterRotation."Plan ID", MasterRotNo);

            if masterRotation.Find('-') then begin

                group.Reset();
                group.SetRange(group.Block, Block);
                group.SetRange(group.MasterRotationNo, MasterRotNo);


                if group.FindLast then begin
                    groupId := group.GroupId;
                    group.Reset();
                    group.SetRange(group.GroupId, groupId);
                    studentsAssigned := group.Count;
                end else begin

                    groupId := NoSeriesMgt.GetNextNo('GRPNO', 0D, TRUE);
                    studentsAssigned := 0;
                end;


                if studentsAssigned >= numberOfStudents then begin
                    groupId := NoSeriesMgt.GetNextNo('GRPNO', 0D, TRUE);
                    studentsAssigned := 0;
                end;


                group.Block := Block;
                group.Department := Department;
                group.StartDate := masterRotation."Start Date";
                group.EndDate := masterRotation."End Date";
                group.MasterRotationNo := MasterRotNo;
                group.GroupId := groupId;
                group.StudentNo := StudentNo;

                if group.Insert() then begin
                    Message := 'Success' + '::';
                end;
            end;
        end;
        exit(Message);
    end;

    procedure GetDistinctGroups(masterNo: Text; block: Text) Message: Text
    var

        distinctGroupIds: Dictionary of [Text, Boolean];
    begin
        group.Reset();
        group.SetRange(group.MasterRotationNo, masterNo);
        group.SetRange(group.Block, block);


        if group.FindSet() then begin
            repeat

                if not distinctGroupIds.ContainsKey(group.GroupId) then begin
                    distinctGroupIds.Add(group.GroupId, true);
                    Message += 'SUCCESS' + '::' + group.GroupId + ':::';
                end;
            until group.Next() = 0;
        end;

        exit(Message);
    end;

    procedure InsertActivity(groupId: Text; block: Text; masterNo: Text; startDate: Date; endDate: Date; department: Text; Areas: Text; AssessStart: Date; AssessEnd: Date) Message: Text
    var
        Id: Text;
    begin
        Id := NoSeriesMgt.GetNextNo('ACTVID', 0D, TRUE);
        clinicals.Reset();
        clinicals.setRange(clinicals.Group, groupId);
        clinicals.setRange(clinicals.Areas, Areas);
        if clinicals.FindFirst() then begin
            Message := 'The Group Is already assigned to that area';
        end else begin
            clinicals."Plan ID" := Id;
            clinicals.Group := groupId;
            clinicals."Block 1" := block;
            clinicals."Starting Date" := startDate;
            clinicals."Ending Date" := endDate;
            clinicals.Department := department;
            clinicals.Areas := Areas;
            clinicals."Assessment Start Date" := AssessStart;
            clinicals."Assessment End Date" := AssessEnd;
            clinicals."Master Plan No" := masterNo;
            clinicals."No. Series" := 'ACTVID';
            if clinicals.Insert() then begin
                Message := 'SUCCESS';
            end;

        end;


    end;


    // procedure GetDistinctGroups(masterNo:Text;block:Text)Message : Text
    // begin
    //     group.Reset();
    //     group.SetRange(group.MasterRotationNo,masterNo);
    //     group.SetRange(group.Block,block);
    //     if group.Find('-') then begin
    //         repeat
    //         Message += 'SUCCESS'+'::'+group.GroupId;
    //         until group.Next() = 0;
    //     exit(Message);
    // end;
    // end;

    procedure GetNumberOfStudents(unitCode: Text): Integer //; programme: Text
    var
        studentCount: Integer;
    begin
        studentCount := 0;


        StudentUnits.Reset();

        //StudentUnits.SetRange(StudentUnits.Programme, programme);
        StudentUnits.SetRange(StudentUnits.Semester, GetCurrentSemester());
        StudentUnits.SetRange(StudentUnits.Unit, unitCode);

        if StudentUnits.Find('-') then begin
            repeat
                studentCount := studentCount + 1;
            until StudentUnits.Next() = 0;
        end;

        exit(studentCount);
    end;

    // procedure UnitsToRegister(progCode: Text) Message: Text
    // begin
    //     unitsOnOffer.Reset();
    //     unitsOnOffer.SetRange(unitsOnOffer.Semester, GetCurrentSem());
    //     unitsOnOffer.SetRange(unitsOnOffer.Programs, progCode);
    //     if unitsOnOffer.Find('-') then begin
    //         Message += 'SUCCESS' + '::' + unitsOnOffer."Unit Base Code" + '::' + GetUnitName(unitsOnOffer."Unit Base Code") + '::' + unitsOnOffer.Campus + '::' + GetLectureName(unitsOnOffer.Lecturer) + '::' + unitsOnOffer."Lecture Hall" + '::' + unitsOnOffer.TimeSlot + '[]';
    //     end
    // end;

    // procedure GetUnitName(unitCode: Text) Name: Text
    // begin
    //     UnitSubjects.Reset();
    //     UnitSubjects.setRange(UnitSubjects.Code, unitCode);
    //     if UnitSubjects.FindFirst() then begin
    //         Name := UnitSubjects.Desription;
    //     end;
    //     Exit(Name);
    // end;

    // procedure GetLectureName(number: Text) Name: Text
    // begin
    //     EmployeeCard.Reset();
    //     EmployeeCard.SetRange(EmployeeCard."No.", number);
    //     if EmployeeCard.FindFirst() then begin
    //         Name := EmployeeCard."First Name" + EmployeeCard."Last Name";
    //     end;
    //     exit(Name);
    // end;
    procedure GenerateExamCard(studentNo: Text; FilenameFromapp: Text)
    var
        filename: Text;
        reportResult: Boolean;
    begin
        filename := FILESPATH_S + filenameFromApp;

        IF EXISTS(filename) THEN
            ERASE(filename);

        CourseRegistration.Reset();
        CourseRegistration.SetRange(CourseRegistration."Student No.", studentNo);
        if CourseRegistration.find('-') then begin
            REPORT.SAVEASPDF(report::"Exam Attendance Clearance", filename, CourseRegistration);


        end;

    end;

    procedure GenerateExamAttendanceList(Sem: text; unitCode: Text; filenameFromApp: Text) Message: Text
    var
        filename: Text;
        reportResult: Boolean;
    begin
        filename := FILESPATH_S + filenameFromApp;

        IF EXISTS(filename) THEN
            ERASE(filename);

        StudentUnits.Reset();
        StudentUnits.setRange(studentUnits.Semester, Sem);
        StudentUnits.SetRange(studentUnits.Unit, unitCode);
        if studentUnits.Find('-') then begin
            REPORT.SAVEASPDF(report::"Exam Attendance.", filename, StudentUnits);
            Message := 'Exam card generated successfully after adding registered courses.';

        end

    end;

    procedure CheckStaffLoginForUnchangedPass(Username: Code[20]; password: Text[50]) ReturnMsg: Text[200];
    begin
        EmployeeCard.Reset();

        EmployeeCard.SetRange(EmployeeCard."No.", Username);
        EmployeeCard.SetRange(EmployeeCard."Portal Password", password);

        if (EmployeeCard.Find('-')) then begin
            if (EmployeeCard.Status = 0) then begin
                ReturnMsg := 'SUCCESS' + '::' + EmployeeCard."No." + '::' + EmployeeCard."CUEA Email Address";
            end else begin
                ReturnMsg := 'Your Account Status Is Inactive. Please Contact Administrator.' + '::';
            end

        end
        else begin
            ReturnMsg := 'Invalid Password' + '::';
        end

    end;

    procedure GetStudentRequests(department: Text) Message: Text
    var
        deferredStudents: Record "defferedStudents";

    begin
        deferredStudents.Reset();
        deferredStudents.SetRange(deferredStudents.Department, department);
        deferredStudents.SetRange(deferredStudents.status, 0);
        deferredStudents.SetRange(deferredStudents."Hod cleared", False);

        if deferredStudents.Find('-') then begin
            repeat
                Message += 'SUCCESS' + '::' + deferredStudents."Request No" + '::' + deferredStudents.studentNo + '::' + deferredStudents.StudentName + '::' + deferredStudents.deffermentReason + '::' + Format(deferredStudents."Deferment  Starting Date") + '::' + Format(deferredStudents."Deferment  End Date") + '[]';
            until deferredStudents.Next() = 0;

        end else begin
            Message := 'No matching records';
        end;
        exit(Message);
    end;

    procedure AcceptRejectDefer(RequestNo: Text; dept: Text; accept: Boolean) Message: Text
    var
        deferredStudents: Record "defferedStudents";
    begin
        deferredStudents.Reset();
        //deferredStudents.SetRange(deferredStudents.Department, dept);
        deferredStudents.SetRange(deferredStudents.status, 0);
        deferredStudents.SetRange(deferredStudents."Request No", RequestNo);

        if deferredStudents.FindFirst() then begin

            if accept then begin
                deferredStudents."Hod cleared" := accept;
                deferredStudents."Hod Date" := Today;
                deferredStudents.status := 1;
            end else begin
                deferredStudents."Hod cleared" := accept;
                deferredStudents."Hod Date" := Today;
                deferredStudents.status := 4;
            end;

            if deferredStudents.Modify() then begin
                Message := 'SUCCESS';
            end else begin
                Message := 'FAILED';
            end;
            exit(Message);
        end;

    end;

    procedure PortalOTP(Username: Code[20]; otpCode: Code[20]) ReturnMsg: Boolean;
    begin
        EmployeeCard.Reset();
        EmployeeCard.SetRange(EmployeeCard."No.", Username);
        if (EmployeeCard.Find('-')) then begin
            EmployeeCard.OTP := otpCode;
            EmployeeCard.Modify();
            ReturnMsg := TRUE;
        end

    end;

    procedure ConfirmPortalOTP(Username: Code[20]; otpCode: Code[20]) ReturnMsg: Boolean;
    begin
        EmployeeCard.Reset();
        EmployeeCard.SetRange(EmployeeCard."No.", Username);
        if (EmployeeCard.Find('-')) then begin
            if (EmployeeCard.OTP = otpCode) then begin
                ReturnMsg := TRUE;
            end;
        end;
    end;

    procedure UpdateStaffPass(username: Code[30]; genpass: Text) ReturnMsg: Text[200];
    begin
        EmployeeCard.Reset();
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            EmployeeCard."Portal Password" := genpass;
            EmployeeCard."Changed Password" := TRUE;
            EmployeeCard.Modify();
            ReturnMsg := 'SUCCESS' + '::';
        END
    end;

    procedure VerifyCurrentPassword(username: Code[20]; oldpass: Text[100]) ReturnMsg: Text[200];
    begin
        EmployeeCard.Reset();
        EmployeeCard.SetRange(EmployeeCard."No.", username);
        EmployeeCard.SetRange(EmployeeCard."Portal Password", oldpass);

        if (EmployeeCard.Find('-')) then begin
            ReturnMsg := 'SUCCESS' + '::';
        end
    end;

    procedure ChangeStaffPassword(username: Code[30]; password: Text) ReturnMsg: Text[200];
    begin
        EmployeeCard.Reset();
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            EmployeeCard."Portal Password" := password;
            EmployeeCard."Changed Password" := TRUE;
            EmployeeCard.Modify();
            ReturnMsg := 'SUCCESS' + '::';
        END;
    end;

    procedure CheckStaffPasswordChanged(username: Code[30]) Message: Text
    begin
        EmployeeCard.Reset();
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            IF (EmployeeCard."Changed Password" = TRUE) THEN BEGIN
                Message := 'SUCCESS' + '::' + FORMAT(EmployeeCard."Changed Password");
            END ELSE BEGIN
                Message := 'FAILED' + '::' + FORMAT(EmployeeCard."Changed Password");
            END
        END ELSE BEGIN
            Message := 'FAILED' + '::';
        END
    end;

    procedure CheckValidStaffNo(username: Code[30]) Message: Text
    begin
        EmployeeCard.Reset();
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            Message := 'SUCCESS' + '::';
        END ELSE BEGIN
            Message := 'FAILED' + '::';
        END
    end;

    procedure GetStafBfProfileDetails(username: Code[30]) Message: Text
    begin
        EmployeeCard.Reset();
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            Message := EmployeeCard."ID Number" + '::' + EmployeeCard.Citizenship + '::' + EmployeeCard."Postal Address" + '::' +
  EmployeeCard."Job Name" + '::' + EmployeeCard."CUEA EMail Address" + '::' + FORMAT(EmployeeCard.Title) + '::' + FORMAT(EmployeeCard."Date Of Birth") + '::' + FORMAT(EmployeeCard.Gender) + '::' + EmployeeCard."Cellular Phone Number" + '::' + FORMAT(EmployeeCard.Title) + '::' + FORMAT(EmployeeCard."Department Name") + '::' + GetContractExpiryDuration(username);

        END
    end;

    procedure GetContractExpiryDuration(empno: Code[20]) Message: Text
    begin
        EmployeeCard.Reset();
        EmployeeCard.SetRange("No.", empno);
        if EmployeeCard.FIND('-') THEN begin
            EmployeeCard.CalcFields("Contract Expiry");
            if EmployeeCard."Contract Expiry" = 0D then
                Message := 'Contract end Date Not specified!'
            else
                Message := hrdates.DetermineAge(Today, EmployeeCard."Contract Expiry");
        end;
    end;

    procedure GetStaffEmpHistory(username: Code[30]) Message: Text
    begin
        EmpHist.Reset();
        EmpHist.SETRANGE(EmpHist."Employee No.", username);
        IF EmpHist.FIND('-') THEN BEGIN
            repeat
                Message := Message + EmpHist."Academic Rank" + ' ::' + EmpHist."Job Category" + ' ::' + EmpHist."Job Group" + ' ::' + EmpHist."Faculty Name" + ' ::' + EmpHist."Department Name" + ' ::' +
      FORMAT(EmpHist."Terms of Service") + ' ::' + FORMAT(EmpHist."Date of Confirmation") + ' ::' + FORMAT(EmpHist."Date of Last Promotion") + ' :::';
            until EmpHist.Next = 0;
        END
    end;

    procedure GetJobPosts() Message: Text
    begin
        jobPosts.Reset();
        jobPosts.SETFILTER(jobPosts."Vacant Positions", '>%1', 0);
        IF jobPosts.FIND('-') THEN BEGIN
            repeat
                Message := Message + jobPosts."Job ID" + ' ::' + jobPosts."Job Description" + ' :::';
            until jobPosts.Next = 0;
        END
    end;

    procedure GetJobPostDetails(id: Code[10]) Message: Text
    begin
        jobPosts.Reset();
        jobPosts.SETRANGE(jobPosts."Job ID", id);
        IF jobPosts.FIND('-') THEN BEGIN
            Message := jobPosts."Job Reference Number" + ' ::' + FORMAT(jobPosts."No of Posts") + ' ::' + jobPosts."Position Reporting to" + ' ';
        END
    end;

    procedure GetStaffMail(username: Code[30]) Message: Text
    begin
        EmployeeCard.Reset();
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            Message := EmployeeCard."CUEA Email Address" + '::';
        END
    end;

    procedure GetProfilePicture(StaffNo: Text) BaseImage: Text
    begin
        EmployeeCard.Reset();
        EmployeeCard.SETRANGE(EmployeeCard."No.", StaffNo);

        IF EmployeeCard.FIND('-') THEN BEGIN
            IF EmployeeCard.Picture.HASVALUE THEN BEGIN
                EmployeeCard.CALCFIELDS(Picture);
                EmployeeCard.Picture.CREATEINSTREAM(IStream);
                // MemoryStream := MemoryStream.MemoryStream();
                // COPYSTREAM(MemoryStream, IStream);
                // Bytes := MemoryStream.GetBuffer();
                // BaseImage := Convert.ToBase64String(Bytes);
            END;
        END;
    end;

    procedure GetCurrentPassword(username: Code[30]) Message: Text
    begin
        EmployeeCard.Reset();
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            Message := EmployeeCard."Portal Password" + '::';
        END
    end;

    procedure GenerateLeaveStatement(StaffNo: Text; filenameFromApp: Text)
    begin
        filename := FILESPATH_S + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        EmployeeCard.Reset();
        EmployeeCard.SETRANGE(EmployeeCard."No.", StaffNo);

        IF EmployeeCard.FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(51176, filename, EmployeeCard);
        END
    end;

    procedure GetStaffDetails(username: Code[30]) Message: Text
    begin
        EmployeeCard.Reset();
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            Message := EmployeeCard."ID Number" + '::' + EmployeeCard.Citizenship + '::' + EmployeeCard."Postal Address" + '::' +
  EmployeeCard."Job Title" + '::' + EmployeeCard."Company E-Mail" + '::' + FORMAT(EmployeeCard.Title) + '::' + FORMAT(EmployeeCard."Date Of Birth");

        END
    end;

    procedure GetStaffGender(username: Code[30]) Message: Text
    begin
        EmployeeCard.Reset();
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            Message := FORMAT(EmployeeCard.Gender) + '::' + EmployeeCard."Cellular Phone Number";

        END
    end;

    procedure GeneratePaySlipReport(Period: Date; EmployeeNo: Text; filenameFromApp: Text; var bigtext: BigText) filename: Text
    var
        rpt: Report PayslipTest;
        tmpBlob: Codeunit "Temp Blob";
        cnv64: Codeunit "Base64 Convert";
        InStr: InStream;
        OutStr: OutStream;
        txtB64: Text;
        format: ReportFormat;
        recRef: RecordRef;
    begin
        filename := FILESPATH_S + filenameFromApp;
        Message(filename);
        IF EXISTS(filename) THEN
            ERASE(filename);
        HRMEmployeeD.Reset();
        HRMEmployeeD.SETRANGE(HRMEmployeeD."No.", EmployeeNo);
        HRMEmployeeD.SetRange(HRMEmployeeD."Period Filter2", Period);
        IF HRMEmployeeD.FIND('-') THEN BEGIN
            recRef.GetTable(HRMEmployeeD);
            REPORT.SaveAsPdf(Report::"PayslipTest", filename, HRMEmployeeD);
            tmpBlob.CreateOutStream(OutStr);
            Report.SaveAs(85531, '', format::Pdf, OutStr, recRef);
            tmpBlob.CreateInStream(InStr);
            txtB64 := cnv64.ToBase64(InStr, true);
            bigtext.AddText(txtB64);
        END;
        EXIT(filename);
    end;

    procedure Generatep9Report(SelectedPeriod: Integer; EmployeeNo: Text; filenameFromApp: Text) filename: Text[100]
    begin
        //Message('executing');
        filename := FILESPATH_S + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        //MESSAGE('OK');
        P9.Reset();
        P9.SETRANGE(P9."Period Year", SelectedPeriod);
        P9.SETRANGE(P9."Employee Code", EmployeeNo);

        IF P9.FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(Report::"P9 Report (Final)", filename, P9);   //52017726
        END;
        EXIT(filename);
    end;

    procedure RejectLeave(DocumentNo: Text; UserID: Text)
    begin
        LeaveT.RESET;
        LeaveT.SETRANGE(LeaveT."No.", DocumentNo);
        IF LeaveT.FIND('-')
          THEN BEGIN
            ApprovalEntry.RESET();
            ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", DocumentNo);
            ApprovalEntry.SETRANGE(ApprovalEntry."Approver ID", UserID);
            ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Open);
            ApprovalEntry.SETRANGE(ApprovalEntry."Table ID", Database::"HRM-Leave Requisition");
            IF ApprovalEntry.FIND('-') THEN BEGIN
                ApprovalEntry.Status := ApprovalEntry.Status::Rejected;
                ApprovalEntry.MODIFY;
                HRLeave.RESET;
                HRLeave.SETRANGE(HRLeave."No.", DocumentNo);
                IF HRLeave.FIND('-') THEN BEGIN
                    HRLeave.Status := HRLeave.Status::Rejected;
                    HRLeave.MODIFY;
                END;
            END;

        END;
    end;

    procedure RejectPartTimeClaim(DocumentNo: Text; UserID: Text)
    begin
        PartTimeClaimHd.RESET;
        PartTimeClaimHd.SETRANGE("No.", DocumentNo);
        IF PartTimeClaimHd.FIND('-')
          THEN BEGIN
            ApprovalEntry.RESET();
            ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", DocumentNo);
            ApprovalEntry.SETRANGE(ApprovalEntry."Approver ID", UserID);
            ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Open);
            ApprovalEntry.SETRANGE(ApprovalEntry."Table ID", Database::"Parttime Claim Header");
            IF ApprovalEntry.FIND('-') THEN BEGIN
                ApprovalEntry.Status := ApprovalEntry.Status::Rejected;
                ApprovalEntry.MODIFY;
                PartTimeClaimHd.Status := PartTimeClaimHd.Status::Cancelled;
                PartTimeClaimHd.MODIFY;
            END;

        END;
    end;

    procedure ApprovePartTimeClaim(DocumentNo: Text; UserID: Text)
    begin
        PartTimeClaimHd.RESET;
        PartTimeClaimHd.SETRANGE("No.", DocumentNo);
        IF PartTimeClaimHd.FIND('-')
          THEN BEGIN
            ApprovalEntry.RESET();
            ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", DocumentNo);
            ApprovalEntry.SETRANGE(ApprovalEntry."Approver ID", UserID);
            ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Open);
            ApprovalEntry.SETRANGE(ApprovalEntry."Table ID", Database::"Parttime Claim Header");
            IF ApprovalEntry.FIND('-') THEN BEGIN
                //Modify status to approved if there are no other approvers
                ApprovalEntry.Status := ApprovalEntry.Status::Approved;
                ApprovalEntry.MODIFY;

                //Change next doc to open
                ApprovalEntry_2.RESET;
                ApprovalEntry_2.SETRANGE(ApprovalEntry_2."Document No.", DocumentNo);
                ApprovalEntry_2.SETRANGE(ApprovalEntry_2.Status, ApprovalEntry_2.Status::Created);
                IF ApprovalEntry_2.FIND('-') THEN BEGIN
                    ApprovalEntry_2.Status := ApprovalEntry_2.Status::Open;
                    ApprovalEntry_2."Last Date-Time Modified" := CREATEDATETIME(TODAY, TIME);
                    ApprovalEntry_2.MODIFY;
                END;

            END;
            ApprovalEntry_2.RESET;
            ApprovalEntry_2.SetCurrentKey("Sequence No.");
            ApprovalEntry_2.Ascending(true);
            ApprovalEntry_2.SETRANGE(ApprovalEntry_2."Document No.", DocumentNo);
            IF ApprovalEntry_2.FINDLAST THEN BEGIN
                IF ApprovalEntry_2.Status = ApprovalEntry_2.Status::Approved THEN BEGIN
                    PartTimeClaimHd.Status := PartTimeClaimHd.Status::Approved;
                    PartTimeClaimHd.MODIFY;
                END;
            END;
        END;
    end;

    procedure ApproveLeave(DocumentNo: Text; UserID: Text)
    begin
        LeaveT.RESET;
        LeaveT.SETRANGE(LeaveT."No.", DocumentNo);
        IF LeaveT.FIND('-')
          THEN BEGIN
            ApprovalEntry.RESET();
            ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", DocumentNo);
            ApprovalEntry.SETRANGE(ApprovalEntry."Approver ID", UserID);
            ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Open);
            ApprovalEntry.SETRANGE(ApprovalEntry."Table ID", Database::"HRM-Leave Requisition");
            IF ApprovalEntry.FIND('-') THEN BEGIN
                //Modify status to approved if there are no other approvers
                ApprovalEntry.Status := ApprovalEntry.Status::Approved;
                ApprovalEntry.MODIFY;

                //Change next doc to open
                ApprovalEntry_2.RESET;
                ApprovalEntry_2.SETRANGE(ApprovalEntry_2."Document No.", DocumentNo);
                ApprovalEntry_2.SETRANGE(ApprovalEntry_2.Status, ApprovalEntry_2.Status::Created);
                IF ApprovalEntry_2.FIND('-') THEN BEGIN
                    ApprovalEntry_2.Status := ApprovalEntry_2.Status::Open;
                    ApprovalEntry_2."Last Date-Time Modified" := CREATEDATETIME(TODAY, TIME);
                    ApprovalEntry_2.MODIFY;
                END;

            END;
            ApprovalEntry_2.RESET;
            ApprovalEntry_2.SetCurrentKey("Sequence No.");
            ApprovalEntry_2.Ascending(true);
            ApprovalEntry_2.SETRANGE(ApprovalEntry_2."Document No.", DocumentNo);
            IF ApprovalEntry_2.FINDLAST THEN BEGIN
                IF ApprovalEntry_2.Status = ApprovalEntry_2.Status::Approved THEN BEGIN
                    HRLeave.Status := HRLeave.Status::Approved;
                    HRLeave.MODIFY;
                END;
            END;

        END;
    end;

    procedure ApproveDocument(DocumentNo: Text; DocumentType: Text)
    var
        //Doc Type = LEAVE, IMPREST, STORE, CLAIM, PRN

        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        leaveR: Record "HRM-Leave Requisition";
        imprestH: Record "FIN-Imprest Header";
        storeH: Record "PROC-Store Requistion Header";
        claimH: Record "FIN-Staff Claims Header";
        prnH: Record "Purchase Header";



    begin
        CASE DocumentType of
            'LEAVE':
                begin
                    leaveR.Reset();
                    leaveR.SetRange("No.", DocumentNo);
                    if leaveR.FindFirst() then
                        ApprovalsMgmt.ApproveRecordApprovalRequest(leaveR.RecordId);
                end;
            'IMPREST':
                begin
                    imprestH.Reset();
                    imprestH.SetRange("No.", DocumentNo);
                    if imprestH.FindFirst() then
                        ApprovalsMgmt.ApproveRecordApprovalRequest(imprestH.RecordId);
                end;
            'STORE':
                begin
                    storeH.Reset();
                    storeH.SetRange("No.", DocumentNo);
                    if storeH.FindFirst() then
                        ApprovalsMgmt.ApproveRecordApprovalRequest(storeH.RecordId);
                end;
            'CLAIM':
                begin
                    claimH.Reset();
                    claimH.SetRange("No.", DocumentNo);
                    if claimH.FindFirst() then
                        ApprovalsMgmt.ApproveRecordApprovalRequest(claimH.RecordId);
                end;
            'PRN':
                begin
                    prnH.Reset();
                    prnH.SetRange("No.", DocumentNo);
                    if prnH.FindFirst() then
                        ApprovalsMgmt.ApproveRecordApprovalRequest(prnH.RecordId);
                end;
        END;
    end;

    procedure RejectDocument(DocumentNo: Text; ApproverID: Text)
    var
    //ApprovalEntry: Record "Approval Entry-proc";
    begin
        // ApprovalEntryProc.SETRANGE(ApprovalEntryProc."Document No.", DocumentNo);
        // ApprovalEntryProc.SETRANGE(ApprovalEntryProc."Approver ID", ApproverID);

        // IF ApprovalEntryProc.FIND('-') THEN
        //     REPEAT
        //         IF NOT ApprovalSetup.GET THEN
        //             ERROR(Text004);

        //     UNTIL ApprovalEntryProc.NEXT = 0;
    end;

    procedure CancelDocument(DocumentNo: Text; SenderID: Text)
    begin
        ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", DocumentNo);
        ApprovalEntry.SETRANGE(ApprovalEntry."Sender ID", SenderID);

        IF ApprovalEntry.FIND('-') THEN
            REPEAT
            //AppMgt.CancelApproval(ApprovalEntry);
            UNTIL ApprovalEntry.NEXT = 0;
    end;

    procedure GetCurrentSem() Msg: Text
    begin
        CurrentSem.reset;
        CurrentSem.SETRANGE(CurrentSem."Current Semester", true);
        IF CurrentSem.FIND('-') THEN begin
            Msg := CurrentSem.Code;
        end;
    end;

    procedure CancelApprovalRequest(ReqNo: Text)
    begin
        ApprovalEntry.Reset();
        ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", ReqNo);
        IF ApprovalEntry.FIND('-') THEN BEGIN
            ApprovalEntry.DELETE;
            PurchaseRN.Reset();
            PurchaseRN.SETRANGE(PurchaseRN."No.", ReqNo);
            IF PurchaseRN.FIND('-') THEN BEGIN
                PurchaseRN.Status := PurchaseRN.Status::Open;
                PurchaseRN.Modify();
            END;
        END;
    end;

    procedure AvailableLeaveDays(EmployeeNo: Text; LeaveType: Text) availabledays: Text
    begin
        CLEAR(availabledays);
        CLEAR(daysInteger);
        LeaveLE.Reset();
        LeaveLE.SETRANGE(LeaveLE."Employee No", EmployeeNo);
        LeaveLE.SETRANGE(LeaveLE."Leave Type", LeaveType);
        //LeaveLE.SETRANGE(LeaveLE."Leave Period",Year);
        IF LeaveLE.FIND('-') THEN
            REPEAT
            BEGIN
                daysInteger := daysInteger + LeaveLE."No. of Days"
                // availabledays:=FORMAT(LeaveLE."No. of Days");
            END;
            UNTIL LeaveLE.NEXT = 0;
        availabledays := FORMAT(daysInteger);
    end;

    procedure GetFullNames(no: Code[20]) fullname: Text
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

    procedure HRLeaveApplication(EmployeeNo: Text; LeaveType: Text; AppliedDays: Decimal; StartDate: Date; EndDate: Date; ReturnDate: Date; SenderComments: Text; Reliever: Text; RelieverName: Text; familyMember: Integer) successMessage: Text
    begin
        LeaveT.INIT;
        HRSetup.GET;
        NextLeaveApplicationNo := NoSeriesMgt.GetNextNo('LEAVE', 0D, TRUE);
        EmployeeCard.Reset();
        EmployeeCard.SETRANGE(EmployeeCard."No.", EmployeeNo);

        IF EmployeeCard.FIND('-')
        THEN BEGIN
            LeaveT."User ID" := EmployeeCard."User ID";
            EmployeeUserId := EmployeeCard."User ID";
            LeaveT."Employee No" := EmployeeNo;
            LeaveT."Employee Name" := GetFullNames(EmployeeCard."No.");//EmployeeCard.FullName;
            LeaveT."Responsibility Center" := EmployeeCard."Responsibility Center";
            LeaveT."Department Code" := EmployeeCard."Department Code";
            LeaveT."Campus Code" := EmployeeCard.Campus;
            SupervisorCard.Reset();
            SupervisorCard.SETRANGE(SupervisorCard."User ID", EmployeeCard."User ID");
            IF SupervisorCard.FIND('-')
            THEN BEGIN
                SupervisorId := SupervisorCard."Approver ID";
            END;
        END;
        LeaveT."Reliever No." := Reliever;
        LeaveT."Reliever Name" := RelieverName;
        LeaveT."No." := NextLeaveApplicationNo;
        LeaveT."Leave Type" := LeaveType;
        LeaveT.VALIDATE("Leave Type");
        LeaveT."Applied Days" := AppliedDays;
        LeaveT.Date := TODAY;
        LeaveT."Starting Date" := StartDate;
        LeaveT."End Date" := EndDate;
        LeaveT."Return Date" := ReturnDate;
        LeaveT.Purpose := SenderComments;
        LeaveT."No. Series" := 'LEAVE';
        LeaveT.Status := HRLeave.Status::Open;
        LeaveT."Family Member" := familyMember;
        LeaveT.INSERT;
        //send request for approval
        LeaveT.Reset();
        LeaveT.SETRANGE(LeaveT."No.", NextLeaveApplicationNo);
        IF LeaveT.FIND('-')
        THEN BEGIN
            //ApprovalMgmtHr.CheckLeaveApplicationApprovalPossible(LeaveT);
            ApprovalMgmtHr.OnSendLeavesForApproval(LeaveT);
        end
    end;

    procedure SendEmpReq(requestorid: code[20]; replacedemp: code[20]; jobid: Text; reason: Option; contractType: Option; priority: Option; posts: Integer; startDate: Date)
    begin
        EmpReq.INIT;

        NextEmpReqNo := NoSeriesMgt.GetNextNo('EMPREQ', 0D, TRUE);
        jobPosts.Reset();
        jobPosts.SETRANGE(jobPosts."Job ID", jobid);
        IF jobPosts.FIND('-')
        THEN BEGIN
            EmpReq."Job ID" := jobPosts."Job ID";
            EmpReq."Job Description" := jobPosts."Job Description";
            EmpReq."Job Ref No" := jobPosts."Job Reference Number";
            EmpReq."Vacant Positions" := jobPosts."Vacant Positions";
            EmpReq."Reporting To:" := jobPosts."Position Reporting to";
        END;
        HRMEmployeeD.Reset;
        HRMEmployeeD.SetRange("No.", requestorid);
        if HRMEmployeeD.FIND('-') THEN BEGIN
            EmpReq."Requestor Name" := HRMEmployeeD.FullName();
            EmpReq.Department := HRMEmployeeD."Department Code";
        END;
        EmpReq."Requisition No." := NextEmpReqNo;
        EmpReq.Requestor := requestorid;
        EmpReq."Requestor Staff ID" := requestorid;
        EmpReq."Requisition Date" := TODAY;
        EmpReq.Priority := priority;
        EmpReq."Proposed Starting Date" := startDate;
        EmpReq."Required Positions" := posts;
        EmpReq."Reason For Request" := reason;
        if replacedemp <> '' then begin
            HRMEmployeeD.RESET;
            HRMEmployeeD.SetRange("No.", replacedemp);
            if HRMEmployeeD.FIND('-') THEN begin
                EmpReq."Staff Exiting StaffID" := replacedemp;
                EmpReq."Staff Exiting Name" := HRMEmployeeD.FullName();
            end;
        end;
        EmpReq.INSERT;
        EmpReq.Reset();
        EmpReq.SETRANGE(EmpReq."Requisition No.", NextEmpReqNo);
        IF EmpReq.FIND('-')
        THEN BEGIN
            //ApprovalMgmtHr.CheckEmployeeRequisitionApprovalPossible(EmpReq);
            ApprovalMgmtHr.OnSendRecruitReqsforApproval(EmpReq);
        end
    end;

    Procedure GetActiveLeaves(user: Code[20]) msg: Text
    begin
        LeaveT.Reset;
        LeaveT.SetRange(LeaveT.Status, LeaveT.Status::Released);
        LeaveT.SetFilter(LeaveT."Return Date", '>%1', Today);
        if LeaveT.Find('-') Then begin
            REPEAT
                ApprovalEntry.Reset;
                ApprovalEntry.SetRange("Document No.", LeaveT."No.");
                ApprovalEntry.SetRange("Approver ID", user);
                if ApprovalEntry.Find('-') then begin
                    msg += LeaveT."No." + '::' + LeaveT."Employee No" + '::' + GetFullNames(LeaveT."Employee No") + '::' + FORMAT(LeaveT."Starting Date") + '::' + FORMAT(LeaveT."End Date") + '::' + FORMAT(LeaveT."Return Date") + ':::';
                end
            UNTIL LeaveT.Next = 0;
        end
    end;

    procedure HRCancelLeaveApplication(LeaveApplicationNo: Text)
    begin
        LeaveT.Reset();
        LeaveT.SETRANGE(LeaveT."No.", LeaveApplicationNo);
        LeaveT.SETRANGE(LeaveT.Status, LeaveT.Status::"Pending Approval");
        IF LeaveT.FIND('-') THEN BEGIN
            ApprovalMgmtHr.OnCancelLeaveForApproval(LeaveT);
        END;


        ApprovalEntry.Reset();
        ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", LeaveApplicationNo);

        IF ApprovalEntry.FIND('-') THEN BEGIN
            REPEAT
                ApprovalEntry.Status := ApprovalEntry_2.Status::Canceled;
                ApprovalEntry.Modify();
            UNTIL ApprovalEntry.NEXT = 0
        END;
    end;

    procedure CalcReturnDate(EndDate: Date; "Leave Type": Text) RDate: Date
    begin
        IF ltype.GET("Leave Type") THEN BEGIN
        END;
        RDate := EndDate + 1;
        WHILE DetermineIfIsNonWorking(RDate, "Leave Type") = TRUE DO BEGIN
            RDate := RDate + 1;
        END;
    end;

    procedure ValidateStartDate("Starting Date": Date)
    begin
        dates.Reset();
        dates.SETRANGE(dates."Period Start", "Starting Date");
        dates.SETFILTER(dates."Period Type", '=%1', dates."Period Type"::Date);
        IF dates.FIND('-') THEN
            IF ((dates."Period Name" = 'Sunday') OR (dates."Period Name" = 'Saturday')) THEN BEGIN
                IF (dates."Period Name" = 'Sunday') THEN
                    ERROR('You can not start your leave on a Sunday')
                ELSE
                    IF (dates."Period Name" = 'Saturday') THEN ERROR('You can not start your leave on a Saturday')
            END;

        BaseCalendar.Reset();
        BaseCalendar.SETFILTER(BaseCalendar."Base Calendar Code", HRSetup."Base Calendar");
        BaseCalendar.SETRANGE(BaseCalendar.Date, "Starting Date");
        IF BaseCalendar.FIND('-') THEN BEGIN
            REPEAT
                IF BaseCalendar.Nonworking = TRUE THEN BEGIN
                    IF BaseCalendar.Description <> '' THEN
                        ERROR('You can not start your Leave on a Holiday - ''' + BaseCalendar.Description + '''')
                    ELSE
                        ERROR('You can not start your Leave on a Holiday');
                END;
            UNTIL BaseCalendar.NEXT = 0;
        END;

        // For Annual Holidays
        BaseCalendar.Reset();
        BaseCalendar.SETFILTER(BaseCalendar."Base Calendar Code", HRSetup."Base Calendar");
        BaseCalendar.SETRANGE(BaseCalendar."Recurring System", BaseCalendar."Recurring System"::"Annual Recurring");
        IF BaseCalendar.FIND('-') THEN BEGIN
            REPEAT
                IF ((DATE2DMY("Starting Date", 1) = BaseCalendar."Date Day") AND (DATE2DMY("Starting Date", 2) = BaseCalendar."Date Month")) THEN BEGIN
                    IF BaseCalendar.Nonworking = TRUE THEN BEGIN
                        IF BaseCalendar.Description <> '' THEN
                            ERROR('You can not start your Leave on a Holiday - ''' + BaseCalendar.Description + '''')
                        ELSE
                            ERROR('You can not start your Leave on a Holiday');
                    END;
                END;
            UNTIL BaseCalendar.NEXT = 0;
        END;
    end;

    procedure CalcEndDate(SDate: Date; LDays: Integer; "Leave Type": Text) LEndDate: Date
    begin
        SDate := SDate;
        EndLeave := FALSE;
        DayCount := 1;
        WHILE EndLeave = FALSE DO BEGIN
            IF NOT DetermineIfIsNonWorking(SDate, "Leave Type") THEN
                DayCount := DayCount + 1;
            SDate := SDate + 1;
            IF DayCount > LDays THEN
                EndLeave := TRUE;
        END;
        LEndDate := SDate - 1;

        WHILE DetermineIfIsNonWorking(LEndDate, "Leave Type") = TRUE DO BEGIN
            LEndDate := LEndDate + 1;
        END;
    end;

    procedure DetermineIfIsNonWorking(VAR bcDate: Date; VAR "Leave Type": Text) ItsNonWorking: Boolean
    begin
        CLEAR(ItsNonWorking);
        HRSetup.FIND('-');
        //One off Hollidays like Good Friday
        BaseCalendar.Reset();
        BaseCalendar.SETFILTER(BaseCalendar."Base Calendar Code", HRSetup."Base Calendar");
        BaseCalendar.SETRANGE(BaseCalendar.Date, bcDate);
        IF BaseCalendar.FIND('-') THEN BEGIN
            IF BaseCalendar.Nonworking = TRUE THEN
                ItsNonWorking := TRUE;
        END;

        // For Annual Holidays
        BaseCalendar.Reset();
        BaseCalendar.SETFILTER(BaseCalendar."Base Calendar Code", HRSetup."Base Calendar");
        BaseCalendar.SETRANGE(BaseCalendar."Recurring System", BaseCalendar."Recurring System"::"Annual Recurring");
        IF BaseCalendar.FIND('-') THEN BEGIN
            REPEAT
                IF ((DATE2DMY(bcDate, 1) = BaseCalendar."Date Day") AND (DATE2DMY(bcDate, 2) = BaseCalendar."Date Month")) THEN BEGIN
                    IF BaseCalendar.Nonworking = TRUE THEN
                        ItsNonWorking := TRUE;
                END;
            UNTIL BaseCalendar.NEXT = 0;
        END;
        IF ItsNonWorking = FALSE THEN BEGIN
            // Check if its a weekend
            dates.Reset();
            dates.SETRANGE(dates."Period Type", dates."Period Type"::Date);
            dates.SETRANGE(dates."Period Start", bcDate);
            IF dates.FIND('-') THEN BEGIN
                //if date is a sunday
                IF dates."Period Name" = 'Sunday' THEN BEGIN
                    //check if Leave includes sunday
                    ltype.Reset();
                    ltype.SETRANGE(ltype.Code, "Leave Type");
                    IF ltype.FIND('-') THEN BEGIN
                        IF ltype."Inclusive of Sunday" = FALSE THEN ItsNonWorking := TRUE;
                    END;
                END ELSE
                    IF dates."Period Name" = 'Saturday' THEN BEGIN
                        //check if Leave includes sato
                        ltype.Reset();
                        ltype.SETRANGE(ltype.Code, "Leave Type");
                        IF ltype.FIND('-') THEN BEGIN
                            IF ltype."Inclusive of Saturday" = FALSE THEN ItsNonWorking := TRUE;
                        END;
                    END;

            END;
        END;
    end;

    procedure DetermineLeaveReturnDate(fBeginDate: Date; fDays: Decimal; "Leave Type": Text) fReturnDate: Date
    begin
        ltype.Reset();
        IF ltype.GET("Leave Type") THEN BEGIN
        END;
        varDaysApplied := fDays;
        fReturnDate := fBeginDate;
        REPEAT
            IF DetermineIfIncludesNonWorking("Leave Type") = FALSE THEN BEGIN
                fReturnDate := CALCDATE('1D', fReturnDate);
                IF DetermineIfIsNonWorking(fReturnDate, "Leave Type") THEN BEGIN
                    varDaysApplied := varDaysApplied + 1;
                END ELSE
                    varDaysApplied := varDaysApplied;
                varDaysApplied := varDaysApplied + 1
            END
            ELSE BEGIN
                fReturnDate := CALCDATE('1D', fReturnDate);
                varDaysApplied := varDaysApplied - 1;
            END;
        UNTIL varDaysApplied = 0;
        EXIT(fReturnDate);
    end;

    procedure DetermineIfIncludesNonWorking(VAR fLeaveCode: Text): Boolean
    begin
        IF ltype.GET(fLeaveCode) THEN BEGIN
            IF ltype."Inclusive of Non Working Days" = TRUE THEN
                EXIT(TRUE);
        END;
    end;



    procedure GetApprovalStatus(DocumentNo: Text) Message: Text
    begin
        ApprovalEntry.Reset();
        ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", DocumentNo);
        IF ApprovalEntry.FIND('-') THEN BEGIN
            Message := FORMAT(ApprovalEntry.Status);
        END
    end;

    procedure GetNextPRNNo() msg: Text
    begin
        msg := NoSeriesMgt.GetNextNo('PRN', 0D, FALSE);
    end;

    procedure PurchaseHeaderCreate(BusinessCode: Code[50]; UserID: Text; Purpose: Text)
    begin
        EmployeeCard.Reset;
        EmployeeCard.SetRange(EmployeeCard."No.", UserID);
        if EmployeeCard.find('-') THEN BEGIN
            NextLeaveApplicationNo := NoSeriesMgt.GetNextNo('PRN', 0D, TRUE);
            PurchaseRN.INIT;
            PurchaseRN."No." := NextLeaveApplicationNo;
            PurchaseRN."Document Type" := PurchaseRN."Document Type"::Quote;
            //PurchaseRN.Department:=DepartmentCode;
            PurchaseRN."Buy-from Vendor No." := 'DEPART';
            PurchaseRN."Pay-to Vendor No." := 'DEPART';
            PurchaseRN."Invoice Disc. Code" := 'DEPART';
            PurchaseRN."Shortcut Dimension 1 Code" := BusinessCode;
            PurchaseRN."Shortcut Dimension 2 Code" := EmployeeCard."Department Code";
            PurchaseRN."Responsibility Center" := EmployeeCard."Responsibility Center";
            PurchaseRN."Assigned User ID" := UserID;
            PurchaseRN."No. Series" := 'PRN';
            PurchaseRN."Order Date" := TODAY;
            PurchaseRN."Due Date" := TODAY;
            PurchaseRN."Expected Receipt Date" := TODAY;
            PurchaseRN."Posting Description" := Purpose;
            PurchaseRN.INSERT;
        END;
    end;

    procedure SubmitPurchaseLine(DocumentType: integer; DocumentNo: Text; FunctionNo: Code[50]; LocationID: Text; ExpectedDate: Date; FunctionDesc: Text; UnitsOfMeasure: Text; Quantityz: Decimal)
    begin
        PurchaseLines.INIT;
        PurchaseLines.Type := DocumentType;
        PurchaseLines."Document Type" := PurchaseLines."Document Type"::Quote;
        PurchaseLines."Document No." := DocumentNo;
        PurchaseLines."Line No." := PurchaseLines.COUNT + 1;
        PurchaseLines."No." := FunctionNo;
        PurchaseLines."Location Code" := LocationID;
        PurchaseLines."Expected Receipt Date" := ExpectedDate;
        PurchaseLines.Description := FunctionDesc;
        PurchaseLines."Unit of Measure" := UnitsOfMeasure;
        PurchaseLines.Quantity := Quantityz;
        PurchaseLines.Validate("Document No.");
        PurchaseLines.INSERT;
    end;

    procedure GetLastPRNNo(username: Code[30]) Message: Text
    begin
        PurchaseRN.Reset();
        PurchaseRN.SETRANGE(PurchaseRN."Assigned User ID", username);
        IF PurchaseRN.FIND('+') THEN BEGIN
            Message := PurchaseRN."No.";
        END
    end;

    procedure GetPRNHeaderDetails(PurchaseNo: Text) Message: Text
    begin
        PurchaseRN.Reset();
        PurchaseRN.SETRANGE(PurchaseRN."No.", PurchaseNo);
        IF PurchaseRN.FIND('-') THEN BEGIN
            Message := FORMAT(PurchaseRN."Expected Receipt Date");
        END
    end;

    procedure PRNApprovalRequest(ReqNo: Text)
    begin
        PurchaseRN.Reset();
        PurchaseRN.SETRANGE(PurchaseRN."No.", ReqNo);
        IF PurchaseRN.FIND('-')
        THEN BEGIN
            ApprovalMgmtExt.CheckPurchaseRequisitionApprovalPossible(PurchaseRN);
            ApprovalMgmtExt.OnSendPurchaseRequisitionForApproval(PurchaseRN);
        END;
    end;

    procedure CancelPrnApprovalRequest(ReqNo: Text)
    begin
        PurchaseRN.Reset();
        PurchaseRN.SETRANGE(PurchaseRN."No.", ReqNo);
        IF PurchaseRN.FIND('-')
        THEN BEGIN
            ApprovalMgmtExt.OnCancelPurchaseRequisitionForApproval(PurchaseRN);
        END;
    end;

    procedure RemoveStoreReqLine(LineNo: Integer)
    begin
        StoreReqLines.Reset();
        StoreReqLines.SETRANGE(StoreReqLines."Line No.", LineNo);
        IF StoreReqLines.FIND('-') THEN BEGIN
            StoreReqLines.DELETE;
            MESSAGE('Line Deleted Successfully');
        END;
    end;

    procedure RemoveImprestReqLine(ReqNo: Code[20]; AdvanceType: Code[20])
    begin
        ImprestReqLines.Reset();
        ImprestReqLines.SETRANGE(ImprestReqLines.No, ReqNo);
        ImprestReqLines.SETRANGE(ImprestReqLines."Advance Type", AdvanceType);
        IF ImprestReqLines.FIND('-') THEN BEGIN
            ImprestReqLines.DELETE;
            MESSAGE('Line Deleted Successfully');
        END;
    end;

    procedure RemoveClaimReqLine(ReqNo: Code[20]; AdvanceType: Code[20])
    begin
        ClaimReqLines.Reset();
        ClaimReqLines.SETRANGE(ClaimReqLines.No, ReqNo);
        ClaimReqLines.SETRANGE(ClaimReqLines."Advance Type", AdvanceType);
        IF ClaimReqLines.FIND('-') THEN BEGIN
            ClaimReqLines.DELETE;
            MESSAGE('Line Deleted Successfully');
        END;
    end;

    procedure RemovePurchaseLine(LineNo: Integer)
    begin
        PurchaseLines.Reset();
        PurchaseLines.SETRANGE(PurchaseLines."Line No.", LineNo);
        IF PurchaseLines.FIND('-') THEN BEGIN
            PurchaseLines.DELETE;
            MESSAGE('Line Deleted Successfully');
        END;
    end;

    procedure ClaimRequisitionCreate(Campusz: Code[30]; CampusName: Text; username: Code[30]; Reason: Text) LastNum: Text
    begin
        ClaimRequisition.INIT;
        NextClaimapplicationNo := NoSeriesMgt.GetNextNo('S-CLAIMS', 0D, TRUE);
        EmployeeCard.Reset();
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);

        IF EmployeeCard.FIND('-')
        THEN BEGIN
            ClaimRequisition."No." := NextClaimapplicationNo;
            ClaimRequisition.Date := TODAY;
            ClaimRequisition.Payee := EmployeeCard.Names;
            ClaimRequisition."On Behalf Of" := EmployeeCard.Names;
            ClaimRequisition.Posted := FALSE;
            ClaimRequisition."Global Dimension 1 Code" := Campusz;
            ClaimRequisition.Status := ClaimRequisition.Status::Pending;
            ClaimRequisition."Payment Type" := ClaimRequisition."Payment Type"::Imprest;
            ClaimRequisition."Shortcut Dimension 2 Code" := EmployeeCard."Department Code";
            ClaimRequisition."Function Name" := CampusName;
            ClaimRequisition."Budget Center Name" := EmployeeCard."Department Name";
            ClaimRequisition."No. Series" := 'S-CLAIMS';
            ClaimRequisition."Responsibility Center" := EmployeeCard."Responsibility Center";
            ClaimRequisition."Account No." := username;
            ClaimRequisition.Purpose := Reason;
            ClaimRequisition.Cashier := username;
            ClaimRequisition.INSERT;
            LastNum := NextClaimapplicationNo;
        END;
    end;

    procedure ClaimRequisitionApprovalRequest(ReqNo: Text)
    begin
        ClaimRequisition.Reset();
        ClaimRequisition.SETRANGE(ClaimRequisition."No.", ReqNo);
        IF ClaimRequisition.FIND('-')
        THEN BEGIN
            ApprovalMgmtExt.CheckStaffClaimApprovalPossible(ClaimRequisition);
            ApprovalMgmtExt.OnSendStaffClaimForApproval(ClaimRequisition);
        END;
    end;

    procedure CancelClaimRequisition(ReqNo: Text)
    begin
        ClaimRequisition.Reset();
        ClaimRequisition.SETRANGE(ClaimRequisition."No.", ReqNo);
        IF ClaimRequisition.FIND('-')
        THEN BEGIN
            ApprovalMgmtExt.OnCancelStaffClaimForApproval(ClaimRequisition);
        END;
    end;

    procedure StoreRequisitionApprovalRequest(ReqNo: Text)
    begin
        StoreRequisition.Reset();
        StoreRequisition.SETRANGE(StoreRequisition."No.", ReqNo);
        IF StoreRequisition.FIND('-')
        THEN BEGIN
            ApprovalMgmtExt.CheckStoreRequisitionApprovalPossible(StoreRequisition);
            ApprovalMgmtExt.OnSendStoreRequisitionForApproval(StoreRequisition);
        END;
    end;

    procedure CancelStoreRequisition(ReqNo: Text)
    begin
        StoreRequisition.Reset();
        StoreRequisition.SETRANGE(StoreRequisition."No.", ReqNo);
        IF StoreRequisition.FIND('-')
        THEN BEGIN
            ApprovalMgmtExt.OnCancelStoreRequisitionForApproval(StoreRequisition);
        END;
    end;

    procedure GetReqPostingGroup(ReqNo: Text) Msg: Text
    begin
        StoreRequisition.Reset();
        StoreRequisition.SETRANGE(StoreRequisition."No.", ReqNo);
        IF StoreRequisition.FIND('-')
        THEN BEGIN
            Msg := StoreRequisition."Inventory Posting Group";
        END;
    end;

    procedure StoresRequisitionCreate(EmployeeNo: Text; RequiredDate: Date; Purpose: Text; Campus: Code[20]; CampusName: Text[250]; ReqType: Code[50]) LastNum: Text
    begin
        StoreRequisition.INIT;
        NextStoreqNo := NoSeriesMgt.GetNextNo('STREQ', TODAY, TRUE);
        EmployeeCard.Reset();
        EmployeeCard.SETRANGE(EmployeeCard."No.", EmployeeNo);

        IF EmployeeCard.FIND('-')
        THEN BEGIN
            StoreRequisition."Requester ID" := EmployeeCard."User ID";
            StoreRequisition."User ID" := EmployeeCard."User ID";
            StoreRequisition."Responsibility Center" := EmployeeCard."Responsibility Center";
            StoreRequisition."Staff No." := EmployeeCard."No.";
            StoreRequisition."Department Name" := EmployeeCard."Department Name";
            StoreRequisition."Budget Center Name" := EmployeeCard."Department Name";
            StoreRequisition."Shortcut Dimension 2 Code" := EmployeeCard."Department Code";
            SupervisorCard.Reset();
            SupervisorCard.SETRANGE(SupervisorCard."User ID", UserID);
            IF SupervisorCard.FIND('-')
            THEN BEGIN
                SupervisorId := SupervisorCard."Approver ID";
            END;
            //StoreRequisition.INIT;
            //StoreRequisition."Staff No." := EmployeeNo;
            StoreRequisition."No." := NextStoreqNo;
            StoreRequisition."Request date" := TODAY;
            StoreRequisition."Required Date" := RequiredDate;
            StoreRequisition."Request date" := TODAY;
            StoreRequisition."Request Description" := Purpose;
            StoreRequisition."No. Series" := 'STREQ';
            StoreRequisition.Status := StoreRequisition.Status::Open;
            StoreRequisition."Global Dimension 1 Code" := Campus;
            StoreRequisition."Function Name" := CampusName;
            StoreRequisition."Inventory Posting Group" := ReqType;
            StoreRequisition.INSERT;
            LastNum := NextStoreqNo;
        end
    end;

    procedure ImprestRequisitionApprovalRequest(ReqNo: Text)
    begin
        ImprestRequisition.Reset();
        ImprestRequisition.SETRANGE(ImprestRequisition."No.", ReqNo);
        IF ImprestRequisition.FIND('-')
        THEN BEGIN
            ApprovalMgmtExt.CheckImprestApprovalPossible(ImprestRequisition);
            ApprovalMgmtExt.OnSendImprestForApproval(ImprestRequisition);

        END;
    end;

    procedure CancelImprestRequisition(ReqNo: Text)
    begin
        ImprestRequisition.Reset();
        ImprestRequisition.SETRANGE(ImprestRequisition."No.", ReqNo);
        IF ImprestRequisition.FIND('-')
        THEN BEGIN
            ApprovalMgmtExt.OnCancelImprestForApproval(ImprestRequisition);
        END;
    end;

    procedure ImprestRequisitionCreate(Campusz: Code[30]; CampusName: Text; AccType: Integer; username: Code[30]; Reason: Text) LastNum: Text
    begin
        ImprestRequisition.INIT;
        NextImprestapplicationNo := NoSeriesMgt.GetNextNo('IMP-REQ', 0D, TRUE);
        EmployeeCard.Reset();
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);

        IF EmployeeCard.FIND('-')
        THEN BEGIN
            ImprestRequisition."No." := NextImprestapplicationNo;
            ImprestRequisition.Date := TODAY;
            ImprestRequisition.Payee := EmployeeCard.Names;
            ImprestRequisition."On Behalf Of" := EmployeeCard.Names;
            ImprestRequisition.Posted := FALSE;
            ImprestRequisition."Global Dimension 1 Code" := Campusz;
            ImprestRequisition.Status := ImprestRequisition.Status::Pending;
            ImprestRequisition."Payment Type" := ImprestRequisition."Payment Type"::Imprest;
            ImprestRequisition."Shortcut Dimension 2 Code" := EmployeeCard."Department Code";
            ImprestRequisition."Function Name" := CampusName;
            ImprestRequisition."Budget Center Name" := EmployeeCard."Department Name";
            ImprestRequisition."No. Series" := 'IMP-REQ';
            ImprestRequisition."Responsibility Center" := EmployeeCard."Responsibility Center";
            //ImprestRequisition."Account Type" := AccType;
            ImprestRequisition."Account No." := EmployeeCard."No.";
            ImprestRequisition.Purpose := Reason;
            ImprestRequisition.Cashier := username;
            ImprestRequisition."Requested By" := username;
            ImprestRequisition.INSERT;
            LastNum := NextImprestapplicationNo;
        END;
    end;

    procedure InsertApproverComments(DocumentNo: Code[50]; ApproverID: Code[100]; Comments: Text[250])
    begin
        ApproverComments.Reset();

        ApproverComments."Document No." := DocumentNo;
        ApproverComments."User ID" := ApproverID;
        ApproverComments.Comment := Comments;
        ApproverComments."Date and Time" := CURRENTDATETIME;

        ApproverComments.Insert();
    end;

    procedure InsertStoreRequisitionLines(ReqNo: Code[30]; ItemNo: Code[30]; ItemDesc: Text; Amount: Decimal; LineAmount: Decimal; Qty: Decimal; UnitOfMsre: Code[10]; IStore: Code[30]) rtnMsg: Text
    begin
        StoreReqLines.Reset();
        StoreReqLines."Requistion No" := ReqNo;
        StoreReqLines.Validate("Requistion No");
        StoreReqLines."No." := ItemNo;
        StoreReqLines.Description := ItemDesc;
        StoreReqLines."Unit Cost" := Amount;
        StoreReqLines."Line Amount" := LineAmount;
        StoreReqLines.Quantity := Qty;
        StoreReqLines."Unit of Measure" := UnitOfMsre;
        StoreReqLines."Issuing Store" := IStore;
        StoreReqLines.Validate("Requistion No");
        StoreReqLines.Validate(Quantity);
        StoreReqLines.Insert();
        StoreReqLines.Validate(Quantity);

        rtnMsg := 'SUCCESS' + '::';
    end;

    procedure InsertImprestRequisitionLines(ReqNo: Code[20]; Atypes: Code[50]; AccNo: Code[50]; AccName: Code[50]; Amount: Decimal; UserId: Code[50]) rtnMsg: Text
    begin
        ImprestRequisition.Reset();
        ImprestRequisition.SetRange("No.", ReqNo);

        if ImprestRequisition.Find('-') then begin
            ImprestReqLines.Init();
            ImprestReqLines.No := ReqNo;
            ImprestReqLines."Advance Type" := Atypes;
            ImprestReqLines."Shortcut Dimension 2 Code" := ImprestRequisition."Shortcut Dimension 2 Code";
            ImprestReqLines."Account No:" := AccNo;
            ImprestReqLines."Account Name" := AccName;
            ImprestReqLines.Amount := Amount;
            ImprestReqLines."Due Date" := ImprestRequisition.Date;
            ImprestReqLines."Imprest Holder" := UserId;
            ImprestReqLines."Global Dimension 1 Code" := ImprestRequisition."Global Dimension 1 Code";
            ImprestReqLines.Purpose := ImprestRequisition.Purpose;
            ImprestReqLines."Amount LCY" := Amount;

            ImprestReqLines.Insert();

            rtnMsg := 'SUCCESS' + '::';
        end;

    end;

    procedure InsertClaimRequisitionLines(ReqNo: Code[20]; Atypes: Code[50]; AccNo: Code[50]; AccName: Code[50]; Amount: Decimal; UserId: Code[50]) rtnMsg: Text
    begin
        ClaimRequisition.Reset();
        ClaimRequisition.SetRange("No.", ReqNo);

        if ClaimRequisition.Find('-') then begin
            ClaimReqLines.Init();
            ClaimReqLines.No := ReqNo;
            ClaimReqLines."Advance Type" := Atypes;
            ClaimReqLines."Shortcut Dimension 2 Code" := ClaimRequisition."Shortcut Dimension 2 Code";
            ClaimReqLines."Account No:" := AccNo;
            ClaimReqLines."Account Name" := AccName;
            ClaimReqLines.Amount := Amount;
            ClaimReqLines."Due Date" := ClaimRequisition.Date;
            ClaimReqLines."Imprest Holder" := UserId;
            ClaimReqLines."Global Dimension 1 Code" := ClaimRequisition."Global Dimension 1 Code";
            ClaimReqLines.Purpose := ClaimRequisition.Purpose;
            ClaimReqLines."Amount LCY" := Amount;

            ClaimReqLines.Insert();

            rtnMsg := 'SUCCESS' + '::';
        end;
    end;

    procedure TransportRequisitionApprovalRequest(ReqNo: Text)
    begin
        // TransportRequisition.Reset();
        // TransportRequisition.SETRANGE(TransportRequisition."Transport Requisition No", ReqNo);
        // IF TransportRequisition.FIND('-')
        // THEN BEGIN
        //     AppMgt.SendTransportApprovalRequest(TransportRequisition, TransportRequisition."Responsibility Center");
        // END;
    end;

    procedure VenueRequisitionCreate(Department: Code[20]; BookingDate: Date; MeetingDescription: Text[150]; RequiredTime: Time; Venue: Code[20]; ContactPerson: Text[50]; ContactNo: Text[50]; ContactMail: Text[30]; RequestedBy: Text; Pax: Integer)
    begin
        // VenueRequisition.INIT;
        // NextVenueBookingNo := NoSeriesMgt.GetNextNo('VENUE', 0D, TRUE);
        // VenueRequisition."Booking Id" := NextVenueBookingNo;
        // VenueRequisition.Department := Department;
        // VenueRequisition."Request Date" := TODAY;
        // VenueRequisition."Booking Date" := BookingDate;
        // VenueRequisition."Meeting Description" := MeetingDescription;
        // VenueRequisition."Required Time" := RequiredTime;
        // VenueRequisition.Venue := Venue;
        // VenueRequisition."Contact Person" := ContactPerson;
        // VenueRequisition."Contact Number" := ContactNo;
        // VenueRequisition."Contact Mail" := ContactMail;
        // VenueRequisition.Pax := Pax;
        // VenueRequisition.Status := VenueRequisition.Status::"Pending Approval";
        // //VenueRequisition."Department Name":=DepartmentName;
        // VenueRequisition."Requested By" := RequestedBy;
        // VenueRequisition."No. Series" := 'VENUE';
        // //VenueRequisition."Booking Time":= ;

        // VenueRequisition.Insert();
    end;

    procedure CreateRecruitmentAccount(Initialsz: Integer; FirstName: Text; MiddleName: Text; LastName: Text; PostalAddress: Text; PostalCode: Text; IDNumber: Code[30]; Genderz: Integer; HomePhoneNumber: Code[30]; Citizenshipz: Text; MaritalStatus: Integer; EthnicOrigin: Text; Disabledz: Option; DesabilityDetails: Text; DoB: Date; KRAPINNumber: Text; ApplicantType: Integer; EmailAddress: Text; Passwordz: Text; PwdNumber: Text[50]) Message: Text
    begin
        RecAccountusers.RESET;
        RecAccountusers.SETRANGE(RecAccountusers."Email Address", EmailAddress);
        IF NOT RecAccountusers.FIND('-') THEN BEGIN
            RecAccountusers.INIT;

            RecAccountusers.Initials := Initialsz;
            RecAccountusers."First Name" := FirstName;
            RecAccountusers."Middle Name" := MiddleName;
            RecAccountusers."Last Name" := LastName;
            RecAccountusers."Postal Address" := PostalAddress;
            RecAccountusers."Postal Code" := PostalCode;
            RecAccountusers."ID Number" := IDNumber;
            RecAccountusers.Gender := Genderz;
            RecAccountusers."Home Phone Number" := HomePhoneNumber;
            //RecAccountusers."Residential Address" := ResidentialAddress;
            RecAccountusers.Citizenship := Citizenshipz;
            //RecAccountusers.County := Countyz;
            RecAccountusers."Marital Status" := MaritalStatus;
            //RecAccountusers."Ethnic Group" := EthnicOrigin;
            RecAccountusers.Disabled := Disabledz;
            RecAccountusers."Desability Details" := DesabilityDetails;
            //RecAccountusers."PWD Number" := PwdNumber;
            RecAccountusers."Date of Birth" := DoB;
            //RecAccountusers."Driving License" := DrivingLicense;
            //RecAccountusers."1st Language" := stLanguage;
            //RecAccountusers."2nd Language" := ndLanguage;
            //RecAccountusers."Additional Language" := AdditionalLanguage;
            RecAccountusers."Applicant Type" := ApplicantType;
            RecAccountusers."Email Address" := EmailAddress;
            RecAccountusers.Password := Passwordz;
            RecAccountusers."Created Date" := TODAY;
            RecAccountusers.INSERT;
            IF RecAccountusers.INSERT THEN;
            Message := 'Account Created successfully' + '::' + RecAccountusers.Password;
        END ELSE BEGIN
            Message := 'Warning! We already have account created with the Email address provided.' + '::' + RecAccountusers.Password;
        END
    end;

    procedure UpdateRecruitmentAccount(username: Text; Initialsz: Integer; PostalAddress: Text; PostalCode: Text; IDNumber: Code[30]; Genderz: Option; HomePhoneNumber: Code[30]; Citizenshipz: Text; MaritalStatus: Option; EthnicOrigin: Text; Disabledz: Option; DesabilityDetails: Text; DoB: Date; KRAPINNumber: Text; ApplicantType: option; PwdNumber: Text[50]; PassportNo: Text[30]; Religion: Text[30]; Denomination: Text[30]) Message: Boolean
    begin
        RecAccountusers.RESET;
        RecAccountusers.SETRANGE(RecAccountusers."Email Address", username);
        IF RecAccountusers.FIND('-') THEN BEGIN
            RecAccountusers.Initials := Initialsz;
            RecAccountusers."Postal Address" := PostalAddress;
            RecAccountusers."Postal Code" := PostalCode;
            RecAccountusers."ID Number" := IDNumber;
            RecAccountusers."Passport No" := PassportNo;
            RecAccountusers.Gender := Genderz;
            RecAccountusers."Home Phone Number" := HomePhoneNumber;
            //RecAccountusers."Residential Address" := ResidentialAddress;
            RecAccountusers.Citizenship := Citizenshipz;
            //RecAccountusers.County := Countyz;
            RecAccountusers."Marital Status" := MaritalStatus;
            //RecAccountusers."Ethnic Group" := EthnicOrigin;
            RecAccountusers.Disabled := Disabledz;
            RecAccountusers."Desability Details" := DesabilityDetails;
            //RecAccountusers."PWD Number" := PwdNumber;
            RecAccountusers."Date of Birth" := DoB;
            RecAccountusers.Religion := Religion;
            RecAccountusers.Denomination := Denomination;
            //RecAccountusers."2nd Language" := ndLanguage;
            //RecAccountusers."Additional Language" := AdditionalLanguage;
            RecAccountusers."Applicant Type" := ApplicantType;
            RecAccountusers."Created Date" := TODAY;
            //RecAccountusers."Details Updated" := TRUE;
            RecAccountusers.MODIFY;
            Message := TRUE;
        END;
    end;

    procedure CreateJobsAccount(FirstName: Text; MiddleName: Text; LastName: Text; EmailAddress: Text; sessionkey: Text) created: Boolean
    begin
        RecAccountusers.INIT;
        RecAccountusers."First Name" := FirstName;
        RecAccountusers."Middle Name" := MiddleName;
        RecAccountusers."Last Name" := LastName;
        RecAccountusers."Email Address" := EmailAddress;
        //RecAccountusers.SessionKey := sessionkey;
        RecAccountusers."Created Date" := TODAY;
        RecAccountusers.INSERT;
        created := true;
    end;

    procedure ActivateOnlineUserAccount(email: Text; sessionkey: Text) Message: Boolean
    begin
        RecAccountusers.RESET;
        RecAccountusers.SETRANGE(RecAccountusers."Email Address", email);
        //RecAccountusers.SETRANGE(RecAccountusers.SessionKey, sessionkey);
        IF RecAccountusers.FIND('-') THEN BEGIN
            //RecAccountusers."Account Confirmed" := TRUE;
            RecAccountusers.MODIFY;
            Message := TRUE;
        END
    end;

    procedure ResetPassword(email: Text; password: Text) Message: Boolean
    begin
        RecAccountusers.RESET;
        RecAccountusers.SETRANGE(RecAccountusers."Email Address", email);
        IF RecAccountusers.FIND('-') THEN BEGIN
            RecAccountusers.Password := password;
            RecAccountusers.MODIFY;
            Message := TRUE;
        END
    end;

    procedure ValidRecruitmentEmailAddress(username: Text) Message: Text
    begin
        RecAccountusers.RESET;
        RecAccountusers.SETRANGE(RecAccountusers."Email Address", username);
        IF RecAccountusers.FIND('-') THEN BEGIN
            Message := 'Yes' + '::';
        END ELSE BEGIN
            Message := 'No' + '::';
        END
    end;

    procedure CheckRecruitmentEmailAddress(username: Text) Message: Boolean
    begin
        RecAccountusers.RESET;
        RecAccountusers.SETRANGE(RecAccountusers."Email Address", username);
        IF RecAccountusers.FIND('-') THEN BEGIN
            Message := TRUE;
        END ELSE BEGIN
            Message := FALSE;
        END
    end;

    procedure CheckConfirmedEmailAddress(username: Text) Message: Boolean
    begin
        RecAccountusers.RESET;
        RecAccountusers.SETRANGE(RecAccountusers."Email Address", username);
        IF RecAccountusers.FIND('-') THEN BEGIN
            // Message := RecAccountusers."Account Confirmed";
        END
    end;

    procedure CheckUpdateRecDetails(username: Text) Message: Boolean
    begin
        RecAccountusers.RESET;
        RecAccountusers.SETRANGE(RecAccountusers."Email Address", username);
        IF RecAccountusers.FIND('-') THEN BEGIN
            //Message := RecAccountusers."Details Updated";
        END
    end;

    procedure GetRecruitmentEmailAddress(username: Text) Message: Text
    begin
        RecAccountusers.RESET;
        RecAccountusers.SETRANGE(RecAccountusers."Email Address", username);
        IF RecAccountusers.FIND('-') THEN BEGIN
            Message := RecAccountusers."Email Address" + '::';
        END
    end;

    procedure GetCurrentRecruitmentPassword(Username: Text) Message: Text
    begin
        RecAccountusers.RESET;
        RecAccountusers.SETRANGE(RecAccountusers."Email Address", Username);
        IF RecAccountusers.FIND('-') THEN BEGIN
            Message := RecAccountusers.Password + '::';
        END
    end;

    procedure CheckRecruitmentApplicantLogin(username: Text; userpassword: Text) Message: Text
    begin
        RecAccountusers.RESET;
        RecAccountusers.SETRANGE(RecAccountusers."Email Address", username);
        IF RecAccountusers.FIND('-') THEN BEGIN
            IF (RecAccountusers.Password = userpassword) THEN BEGIN
                FullNames := RecAccountusers."First Name" + ' ' + RecAccountusers."Middle Name" + ' ' + RecAccountusers."Last Name";
                Initials := RecAccountusers.Initials;
                pAddress := RecAccountusers."Postal Address";
                pCode := RecAccountusers."Postal Code";
                IDNum := RecAccountusers."ID Number";
                //Gender := RecAccountusers.Gender;
                Phone := RecAccountusers."Home Phone Number";
                rAddress := pAddress + '-' + pCode;
                Citizenship := RecAccountusers.Citizenship;
                County := RecAccountusers.County;
                Mstatus := RecAccountusers."Marital Status";
                //Eorigin := RecAccountusers."Ethnic Origin";
                Disabled := Format(RecAccountusers.Disabled);
                dDetails := RecAccountusers."Desability Details";
                DOB := RecAccountusers."Date of Birth";
                // //          Dlicense:=RecAccountusers."Driving License";		
                KRA := RecAccountusers."KRA PIN Number";
                // //          firstLang	:= RecAccountusers."1st Language";		
                // //          secondLang:=RecAccountusers."2nd Language";			
                // //          AdditionalLang:=RecAccountusers."Additional Language";	 
                ApplicantType := RecAccountusers."Applicant Type";

                Message := TXTCorrectDetails + '::' + RecAccountusers."Email Address" + '::' + RecAccountusers."First Name" + '::' + RecAccountusers."Middle Name" + '::' + RecAccountusers."Last Name" + '::' + FORMAT(RecAccountusers.Initials) + '::' + pAddress + '::' + pCode + '::' + IDNum
                + '::' + FORMAT(RecAccountusers.Gender) + '::' + Phone + '::' + rAddress + '::' + Citizenship + '::' + County + '::' + FORMAT(RecAccountusers."Marital Status") + '::' + FORMAT(Eorigin) + '::' + FORMAT(RecAccountusers.Disabled) + '::' + dDetails + '::' + FORMAT(DOB) + '::' + Dlicense
                + '::' + KRA + '::' + firstLang + '::' + secondLang + '::' + AdditionalLang + '::' + FORMAT(RecAccountusers."Applicant Type");
            END ELSE BEGIN
                FullNames := RecAccountusers."First Name" + ' ' + RecAccountusers."Middle Name" + ' ' + RecAccountusers."Last Name";
                Message := TXTIncorrectDetails + '::' + RecAccountusers."Email Address" + '::' + FullNames;
            END
        END
    end;

    procedure SubmitJobApplication(EMail: Text; FirstName: Text; MiddletName: Text; LastName: Text; JobID: Text; JobDescription: Text; RefNo: Text) Message: Text
    begin

        JobApplications.RESET;

        JobApplications.SETRANGE(JobApplications."E-Mail", EMail);
        JobApplications.SETRANGE(JobApplications."Job Applied For", JobID);
        IF NOT JobApplications.FIND('-') THEN BEGIN
            NextJobapplicationNo := NoSeriesMgt.GetNextNo('JOB', 0D, TRUE);

            RecAccountusers.RESET;
            RecAccountusers.SETRANGE(RecAccountusers."Email Address", EMail);
            IF RecAccountusers.FIND('-') THEN BEGIN
                JobApplications.INIT;

                JobApplications."Application No" := NextJobapplicationNo;
                JobApplications."Employee Requisition No" := RefNo;
                JobApplications."Applicant Type" := RecAccountusers."Applicant Type";
                JobApplications.Initials := FORMAT(RecAccountusers.Initials);
                JobApplications."First Name" := FirstName;
                JobApplications."Middle Name" := MiddletName;
                JobApplications."Last Name" := LastName;
                JobApplications."Postal Address" := RecAccountusers."Postal Address";
                JobApplications."Residential Address" := RecAccountusers."Residential Address";
                JobApplications."Post Code" := RecAccountusers."Postal Code";
                JobApplications.County := RecAccountusers.County;
                JobApplications."Home Phone Number" := RecAccountusers."Home Phone Number";
                JobApplications."Cell Phone Number" := RecAccountusers."Home Phone Number";
                JobApplications."Work Phone Number" := RecAccountusers."Home Phone Number";
                JobApplications."E-Mail" := EMail;
                JobApplications."ID Number" := RecAccountusers."ID Number";
                JobApplications.Gender := RecAccountusers.Gender;
                JobApplications."Country Code" := RecAccountusers.Citizenship;
                JobApplications."Marital Status" := RecAccountusers."Marital Status";
                // JobApplications."Ethnic Origin" := RecAccountusers."Ethnic Origin";
                JobApplications."First Language (R/W/S)" := RecAccountusers."1st Language";
                JobApplications."Driving Licence" := RecAccountusers."Driving License";
                JobApplications.Disabled := RecAccountusers.Disabled;
                JobApplications."Date Of Birth" := RecAccountusers."Date of Birth";
                JobApplications."Second Language (R/W/S)" := RecAccountusers."2nd Language";
                JobApplications."Additional Language" := RecAccountusers."Additional Language";
                JobApplications.Citizenship := RecAccountusers.Citizenship;
                JobApplications."Disabling Details" := RecAccountusers."Desability Details";
                JobApplications."Passport Number" := RecAccountusers."ID Number";
                JobApplications."PIN Number" := RecAccountusers."KRA PIN Number";
                JobApplications."Job Applied For" := JobID;
                JobApplications."Job Applied for Description" := JobDescription;
                JobApplications.Status := JobApplications.Status::"Under Review";
                JobApplications."Date Applied" := TODAY;
                JobApplications."No. Series" := 'JOB';
                //JobApplications.CVPath := MyCVPath;
                //JobApplications."Good Conduct Cert Path" := GoodConductPath;
                JobApplications.INSERT;
                IF JobApplications.INSERT THEN;
                Message := 'SUCCESS' + '::' + JobApplications."Application No";
            END

        END ELSE begin
            Message := 'FAILED' + '::' + JobApplications."Application No";
        end;

    end;

    procedure SubmitJobApplicationNew(EMail: Text; JobID: Text; JobDescription: Text; RefNo: Text) Message: Text
    begin

        JobApplications.RESET;

        JobApplications.SETRANGE(JobApplications."E-Mail", EMail);
        JobApplications.SETRANGE(JobApplications."Job Applied For", JobID);
        JobApplications.SETRANGE(JobApplications."Employee Requisition No", RefNo);
        IF NOT JobApplications.FIND('-') THEN BEGIN
            NextJobapplicationNo := NoSeriesMgt.GetNextNo('JOB', 0D, TRUE);

            RecAccountusers.RESET;
            RecAccountusers.SETRANGE(RecAccountusers."Email Address", EMail);
            IF RecAccountusers.FIND('-') THEN BEGIN
                JobApplications.INIT;

                JobApplications."Application No" := NextJobapplicationNo;
                JobApplications."Employee Requisition No" := RefNo;
                JobApplications."Applicant Type" := RecAccountusers."Applicant Type";
                JobApplications.Initials := FORMAT(RecAccountusers.Initials);
                JobApplications."First Name" := RecAccountusers."First Name";
                JobApplications."Middle Name" := RecAccountusers."Middle Name";
                JobApplications."Last Name" := RecAccountusers."Last Name";
                JobApplications."Postal Address" := RecAccountusers."Postal Address";
                JobApplications."Residential Address" := RecAccountusers."Residential Address";
                JobApplications."Post Code" := RecAccountusers."Postal Code";
                JobApplications.County := RecAccountusers.County;
                JobApplications."Home Phone Number" := RecAccountusers."Home Phone Number";
                JobApplications."Cell Phone Number" := RecAccountusers."Home Phone Number";
                JobApplications."Work Phone Number" := RecAccountusers."Home Phone Number";
                JobApplications."E-Mail" := EMail;
                JobApplications."ID Number" := RecAccountusers."ID Number";
                JobApplications.Gender := RecAccountusers.Gender;
                JobApplications."Country Code" := RecAccountusers.Citizenship;
                JobApplications."Marital Status" := RecAccountusers."Marital Status";
                JobApplications.Religion := RecAccountusers.Religion;
                JobApplications.Denomination := RecAccountusers.Denomination;
                //JobApplications."Ethnic Origin" := RecAccountusers."Ethnic Group";
                JobApplications."First Language (R/W/S)" := RecAccountusers."1st Language";
                JobApplications."Driving Licence" := RecAccountusers."Driving License";
                JobApplications.Disabled := RecAccountusers.Disabled;
                JobApplications."Date Of Birth" := RecAccountusers."Date of Birth";
                JobApplications."Second Language (R/W/S)" := RecAccountusers."2nd Language";
                JobApplications."Additional Language" := RecAccountusers."Additional Language";
                JobApplications.Citizenship := RecAccountusers.Citizenship;
                JobApplications."Disabling Details" := RecAccountusers."Desability Details";
                JobApplications."Passport Number" := RecAccountusers."ID Number";
                JobApplications."PIN Number" := RecAccountusers."KRA PIN Number";
                JobApplications."Job Applied For" := JobID;
                JobApplications."Job Applied for Description" := JobDescription;
                JobApplications.Status := JobApplications.Status::"Under Review";
                JobApplications."Date Applied" := TODAY;
                JobApplications."No. Series" := 'JOB';
                //JobApplications.CVPath := MyCVPath;
                //JobApplications."Good Conduct Cert Path" := GoodConductPath;
                JobApplications.INSERT;
                IF JobApplications.INSERT THEN;
                Message := 'SUCCESS' + '::' + JobApplications."Application No";
            END

        END ELSE begin
            Message := 'FAILED' + '::' + JobApplications."Application No";
        end;

    end;

    procedure GetJobApplicantQualifications(AppNo: Code[30]) rtnMsg: Text
    begin
        ApplicantQualifications.Reset();
        ApplicantQualifications.SetRange("Application No", AppNo);
        if ApplicantQualifications.Find('-') then begin
            REPEAT
                rtnMsg += ApplicantQualifications."Qualification Type" + '::' + ApplicantQualifications."Qualification Description" + '::' + ApplicantQualifications."Institution/Company" + '::' + FORMAT(ApplicantQualifications."From Date") + '::' + FORMAT(ApplicantQualifications."To Date") + ':::';
            UNTIL ApplicantQualifications.NEXT = 0;
        end;
    end;

    procedure InsertJobApplicantProfQuals(AppNo: Code[30]; professionalqual: Text; awardingbody: Text; year: Code[10]) rtnMsg: Boolean
    begin
        profQuals.Init();
        profQuals."Application No" := AppNo;
        profQuals."Proffesional Qualification" := professionalqual;
        profQuals."Awarding Body" := awardingbody;
        profQuals."Year Awarded" := year;
        profQuals.Insert();
        rtnMsg := TRUE;
    end;

    procedure GetJobApplicantProfQuals(AppNo: Code[30]) rtnMsg: Text
    begin
        profQuals.Reset();
        profQuals.SetRange("Application No", AppNo);
        if profQuals.Find('-') then begin
            REPEAT
                rtnMsg += profQuals."Proffesional Qualification" + '::' + profQuals."Awarding Body" + '::' + profQuals."Year Awarded" + ':::';
            UNTIL profQuals.Next = 0;
        end;
    end;

    procedure DeleteJobApplicantQualifications(AppNo: Code[30]; QualType: Code[30]; QualCode: Code[80]) rtnMsg: Boolean
    begin
        ApplicantQualifications.Reset();
        ApplicantQualifications.SetRange("Application No", AppNo);
        ApplicantQualifications.SetRange("Qualification Type", QualType);
        ApplicantQualifications.SetRange("Qualification Description", QualCode);
        if ApplicantQualifications.FIND('-') THEN begin
            ApplicantQualifications.Delete();
            rtnMsg := True;
        end;
    end;

    procedure JobApplicantQualificationsCount(AppNo: Code[30]) rtnMsg: Integer
    begin
        ApplicantQualifications.Reset();
        ApplicantQualifications.SetRange("Application No", AppNo);
        if ApplicantQualifications.FIND('-') THEN begin
            repeat
                rtnMsg := rtnMsg + 1;
            until ApplicantQualifications.Next = 0;
        end;
    end;

    procedure DeleteJobApplicantReferee(AppNo: Code[30]; name: Text) rtnMsg: Boolean
    begin
        Referees.Reset();
        Referees.SetRange("Job Application No", AppNo);
        Referees.SetRange(Names, name);
        if referees.FIND('-') THEN begin
            Referees.Delete();
            rtnMsg := True;
        end;
    end;

    procedure DeleteJobApplicantProfQual(AppNo: Code[30]; profqual: Text) rtnMsg: Boolean
    begin
        profQuals.Reset();
        profQuals.SetRange("Application No", AppNo);
        profQuals.SetRange(profQuals."Proffesional Qualification", profqual);
        if profQuals.FIND('-') THEN begin
            profQuals.Delete();
            rtnMsg := True;
        end;
    end;

    procedure InsertJobApplicantQualifications(AppNo: Code[30]; QualType: Code[30]; QualCode: Code[30]; Institution: Code[50]; FromDate: Date; ToDate: Date) rtnMsg: Text
    begin
        ApplicantQualifications.Reset();

        ApplicantQualifications.SetRange("Application No", AppNo);
        ApplicantQualifications.SetRange("Qualification Type", QualType);
        ApplicantQualifications.SetRange("Qualification Code", QualCode);
        ApplicantQualifications.SetRange("Institution/Company", Institution);
        if not ApplicantQualifications.Find('-') then begin
            ApplicantQualifications.Init();

            ApplicantQualifications."Application No" := AppNo;
            ApplicantQualifications."Qualification Type" := QualType;
            ApplicantQualifications."Qualification Code" := QualCode;
            ApplicantQualifications.Validate("Qualification Code");
            ApplicantQualifications."Institution/Company" := Institution;
            ApplicantQualifications."From Date" := FromDate;
            ApplicantQualifications."To Date" := ToDate;

            ApplicantQualifications.Insert();

            rtnMsg := 'SUCCESS' + '::';
        end else begin
            rtnMsg := 'FAILED' + '::';
        end;
    end;

    procedure InsertJobApplicantReferee(AppNo: Code[30]; Name: Text; designation: Text; institution: Text; address: Text; phone: Text; email: Text) rtnMsg: Boolean
    begin
        Referees.SetRange("Job Application No", AppNo);
        Referees.SetRange(Names, Name);
        if not Referees.Find('-') then begin
            Referees.Init();
            Referees."Job Application No" := AppNo;
            Referees.Names := Name;
            Referees.Designation := designation;
            Referees.Institution := institution;
            Referees.Address := address;
            Referees."Telephone No" := phone;
            Referees."E-Mail" := email;
            Referees.Insert();
            rtnMsg := TRUE;
        end;
    end;

    procedure GetJobApplicantReferees(AppNo: Code[30]) rtnMsg: Text
    begin
        Referees.Reset();
        Referees.SetRange("Job Application No", AppNo);
        if Referees.Find('-') then begin
            REPEAT
                rtnMsg += Referees.Names + '::' + Referees.Designation + '::' + Referees.Institution + '::' + Referees.Address + '::' + Referees."Telephone No" + '::' + Referees."E-Mail" + ':::';
            UNTIL Referees.Next = 0;
        end;
    end;

    procedure InsertJobApplicantWorkExp(AppNo: Code[30]; durations: Integer; organization: Text; position: Text) rtnMsg: Boolean
    begin
        WorkExp.Init();
        WorkExp."Application No" := AppNo;
        WorkExp.Duration := durations;
        WorkExp.Organisation := organization;
        WorkExp.Position := position;
        WorkExp.Insert();
        rtnMsg := TRUE;
    end;

    procedure DeleteJobApplicantWorkExp(AppNo: Code[30]; durations: Integer; organization: Code[30]; position: Code[30]) rtnMsg: Boolean
    begin
        WorkExp.Reset();
        WorkExp.SetRange(WorkExp."Application No", AppNo);
        WorkExp.SetRange(WorkExp.Duration, durations);
        WorkExp.SetRange(WorkExp.Organisation, organization);
        WorkExp.SetRange(WorkExp.Position, position);
        if WorkExp.FIND('-') THEN begin
            WorkExp.Delete();
            rtnMsg := true;
        end;
    end;

    procedure GetJobApplicantWorkExp(AppNo: Code[30]) rtnMsg: Text
    begin
        WorkExp.Reset();
        WorkExp.SETRANGE("Application No", AppNo);
        if WorkExp.Find('-') then begin
            repeat
                rtnMsg += FORMAT(WorkExp.Duration) + '::' + WorkExp.Organisation + '::' + WorkExp.Position + ':::';
            UNTIL WorkExp.NEXT = 0;
        end;
    end;

    procedure DeleteJobApplications(Email: Text) Message: Text
    begin
        JobApplications.RESET;

        JobApplications.SETRANGE(JobApplications."E-Mail", Email);
        IF JobApplications.FIND('-') THEN BEGIN
            JobApplications.DeleteAll();
        end;
    end;

    procedure SubmitJobApplicationAttachments(AppNo: Code[30]; CvPath: Text; CoverLetterPath: Text) Message: Text
    begin

        JobApplications.RESET;

        JobApplications.SETRANGE(JobApplications."Application No", AppNo);
        IF JobApplications.FIND('-') THEN BEGIN

            if (JobApplications.Submitted = false) then begin
                JobApplications."CV Path" := CvPath;
                JobApplications."Cover Letter Path" := CoverLetterPath;
                JobApplications.Submitted := true;
                JobApplications.Modify();
                IF JobApplications.Modify() THEN;
                Message := 'SUCCESS' + '::';
            end else begin
                Message := 'FAIL 1' + '::';
            end



        END ELSE begin
            Message := 'FAIL 2' + '::';
        end
    end;

    procedure SubmitAttachments(AppNo: Code[30]; CvPath: Text; CoverLetterPath: Text) Message: Boolean
    begin
        JobApplications.RESET;
        JobApplications.SETRANGE(JobApplications."Application No", AppNo);
        IF JobApplications.FIND('-') THEN BEGIN
            JobApplications."CV Path" := CvPath;
            JobApplications."Cover Letter Path" := CoverLetterPath;
            JobApplications.Modify();
            Message := True;
        end;
    end;

    procedure SubmitApplication(AppNo: Code[30]) Message: Boolean
    begin
        JobApplications.RESET;
        JobApplications.SETRANGE(JobApplications."Application No", AppNo);
        IF JobApplications.FIND('-') THEN BEGIN
            JobApplications.Submitted := TRUE;
            JobApplications.Modify();
            Message := True;
        end;
    end;

    procedure CheckSubmittedApplication(AppNo: Code[30]) Message: Boolean
    begin
        JobApplications.RESET;
        JobApplications.SETRANGE(JobApplications."Application No", AppNo);
        IF JobApplications.FIND('-') THEN BEGIN
            Message := JobApplications.Submitted;
        end;
    end;

    procedure RemoveJobQualiReqLine(QualCode: Code[20]; AppNo: Code[20]) rtnMsg: Text
    begin
        ApplicantQualifications.Reset();

        ApplicantQualifications.SetRange("Application No", AppNo);
        ApplicantQualifications.SetRange("Qualification Code", QualCode);

        if ApplicantQualifications.Find('-') then begin
            ApplicantQualifications.DELETE;
            rtnMsg := 'Qualification Deleted Successfully';
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

    procedure GetCohorts(dept: Text) Message: Text
    var
        intakes: Record "ACA-Intake";
    begin
        intakes.Reset();
        intakes.SetRange(Department, dept);
        intakes.SetRange(Current, true);
        if intakes.Find('-') then begin
            Message += intakes.Code + '::';
        end;
        exit(Message);
    end;

    procedure GetLecturerUnits(lectNo: Text; semester: Text) Message: Text
    var
        lecunits: Record "Timetable";
    begin
        lecunits.Reset();
        lecunits.SetRange(lecunits.Semester, semester);
        lecunits.setRange(lecunits.Lecturer, lectNo);

        if lecunits.FindSet() then begin
            repeat
                Message += lecunits."Unit Base Code" + '::' + lecunits."Unit Base Code" + '[]';
            until lecunits.Next() = 0;
        end;

        exit(Message);
    end;

    procedure GetLecStage(lecno: Text; sem: Text; prog: Text; units: Text) Stage: Text
    begin
        lecunits.RESET;
        lecunits.SETRANGE(Lecturer, lecno);
        lecunits.SETRANGE(Programme, prog);
        lecunits.SETRANGE(semester, sem);
        lecunits.SETRANGE(Unit, units);
        IF lecunits.FIND('-') THEN BEGIN
            Stage := lecunits.Stage;
        END;
    end;

    procedure SubmitMarks(sem: Text; units: Text; StudentNo: Text; CatMark: Decimal; ExamTypes: Text; Reg_TransactonID: Text; AcademicYear: Text; username: Text; LectName: Text)
    begin
        ExamResults.RESET;
        ExamResults.SETRANGE("Student No.", StudentNo);
        ExamResults.SETRANGE(Unit, units);
        ExamResults.SETRANGE(Semester, sem);
        ExamResults.SETRANGE(ExamType, ExamTypes);
        IF NOT ExamResults.FIND('-') THEN BEGIN
            ExamResults.INIT;
            StudentUnits.Reset;
            StudentUnits.SetRange("Student No.", StudentNo);
            StudentUnits.SetRange(Unit, units);
            StudentUnits.SetRange(Semester, sem);
            IF StudentUnits.FIND('-') THEN begin
                ExamResults.Stage := StudentUnits.Stage;
                ExamResults.Programmes := StudentUnits.Programme;
            end;
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
            ExamResults.INSERT
        END ELSE BEGIN
            ExamResults.Score := CatMark;
            ExamResults."User Name" := username;
            ExamResults."Lecturer Names" := LectName;
            ExamResults.MODIFY;
        END;
    end;

    procedure GetUnitDescription(UnitID: Code[20]) Message: Text
    begin
        UnitSubjects.RESET;
        UnitSubjects.SETRANGE(UnitSubjects.Code, UnitID);
        IF UnitSubjects.FIND('-') THEN BEGIN
            Message := UnitSubjects.Desription;
        END
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

    procedure GetUnitExamCategory(unit: Code[20]; prog: Code[20]) Message: Text
    begin
        UnitSubjects.RESET;
        UnitSubjects.SETRANGE(UnitSubjects.Code, unit);
        IF UnitSubjects.FIND('-') THEN BEGIN
            if UnitSubjects."Exam Category" <> '' then begin
                Message := UnitSubjects."Exam Category";
            end else begin
                Message := GetProgramCategory(prog);
            end;
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

    procedure GetScore(StudentNo: Code[20]; prog: Code[20]; unitz: Code[20]; ExmaType: Code[20]; sem: code[20]) Message: Text
    begin
        ExamResults.RESET;
        ExamResults.SETRANGE(ExamResults."Student No.", StudentNo);
        ExamResults.SETRANGE(ExamResults.Unit, unitz);
        ExamResults.SETRANGE(ExamResults.ExamType, ExmaType);
        ExamResults.SETRANGE(ExamResults.Programmes, prog);
        ExamResults.SETRANGE(ExamResults.Semester, sem);
        IF ExamResults.FIND('-') THEN BEGIN
            Message := FORMAT(ExamResults.Score);

        END
    end;

    procedure GetGrade(StudentNo: Code[20]; prog: Code[20]; unitz: Code[20]; sem: code[20]; markstatus: option; totalscore: Decimal) Message: Text
    var
        examcategory: Code[20];
    begin
        StudentUnits.reset;
        StudentUnits.SetRange("Student No.", StudentNo);
        StudentUnits.SetRange(Unit, unitz);
        StudentUnits.SetRange(Programme, prog);
        StudentUnits.SetRange(Semester, sem);
        if StudentUnits.FIND('-') then begin
            Clear(examcategory);
            examcategory := GetUnitExamCategory(unitz, prog);
            ExamGradingSourse.Reset;
            ExamGradingSourse.SetRange("Exam Catregory", examcategory);
            ExamGradingSourse.SetRange("Results Exists Status", markstatus);
            ExamGradingSourse.SetRange("Total Score", totalscore);
            if ExamGradingSourse.find('-') then begin
                message := ExamGradingSourse.Grade + '::' + ExamGradingSourse.Remarks;
            end;
        end;
    end;

    procedure GetMeanGrade(unitz: Code[20]; totalscore: Decimal) Message: Text
    var
        examcategory: Code[20];
    begin
        Clear(examcategory);
        UnitSubjects.RESET;
        UnitSubjects.SETRANGE(UnitSubjects.Code, unitz);
        IF UnitSubjects.FIND('-') THEN BEGIN
            if UnitSubjects."Exam Category" <> '' then begin
                examcategory := UnitSubjects."Exam Category";
            end else begin
                examcategory := GetProgramCategory(UnitSubjects."Programme Code");
            end;
        END;
        ExamGradingSourse.Reset;
        ExamGradingSourse.SetRange("Exam Catregory", examcategory);
        ExamGradingSourse.SetRange("Results Exists Status", ExamGradingSourse."Results Exists Status"::"Both Exists");
        ExamGradingSourse.SetRange("Total Score", totalscore);
        if ExamGradingSourse.find('-') then begin
            message := ExamGradingSourse.Grade + '::' + ExamGradingSourse.Remarks;
        end;
    end;

    procedure GetAcademicYr() Message: Text
    begin
        AcademicYr.RESET;
        AcademicYr.SETRANGE(AcademicYr.Current, TRUE);
        IF AcademicYr.FIND('-') THEN BEGIN
            Message := AcademicYr.Code + '::' + AcademicYr.Description;
        END
    end;

    procedure GetStudentProgram(StudentNo: Code[20]) Message: Text
    begin
        CourseRegistration.RESET;
        CourseRegistration.SETCURRENTKEY(Stage);
        CourseRegistration.Ascending(true);
        CourseRegistration.SETRANGE(CourseRegistration."Student No.", StudentNo);
        CourseRegistration.SETRANGE(CourseRegistration.Reversed, FALSE);
        IF CourseRegistration.FIND('+') THEN BEGIN
            Message := CourseRegistration.Programmes;
        END;
    end;

    procedure GetSchool(Prog: Code[20]) SchoolName: Text
    begin
        CLEAR(SchoolName);
        IF Programme.GET(Prog) THEN BEGIN
            DimensionValue.RESET;
            DimensionValue.SETRANGE("Dimension Code", 'FACULTY');
            DimensionValue.SETRANGE(Code, Programme."School Code");
            IF DimensionValue.FIND('-') THEN SchoolName := DimensionValue.Name;
        END;
    end;

    procedure GetProgDept(Prog: Code[20]) DeptName: Text
    begin
        Programme.RESET;
        Programme.SETRANGE(Programme.Code, Prog);
        IF Programme.FIND('-') THEN BEGIN
            DeptName := Programme."Department Name";
        END
    end;

    procedure GetHODCampus(hod: Code[20]) campus: Text
    begin
        HRMEmployeeD.RESET;
        HRMEmployeeD.SETRANGE("No.", hod);
        IF HRMEmployeeD.FIND('-') THEN BEGIN
            campus := HRMEmployeeD.Campus;
        END
    end;

    procedure GetProgFaculty(Prog: Code[20]) FactName: Text
    begin
        Programme.RESET;
        Programme.SETRANGE(Programme.Code, Prog);
        IF Programme.FIND('-') THEN BEGIN
            FactName := Programme."Faculty Name";
        END
    end;

    procedure GetProgramme(unitCode: Text; lectNo: Text) Message: Text
    begin
        StudentUnits.Reset();
        //lecunits.SetRange(lecunits.Semester, semester);
        StudentUnits.SetRange(Supervisor, lectNo);
        StudentUnits.SetRange(Unit, unitCode);

        if StudentUnits.FindFirst() then Begin
            Message := StudentUnits.Programme;

        End;
        exit(Message);
    end;


    procedure GetSemData(sem: Code[20]) Message: Text
    begin
        CurrentSem.RESET;
        CurrentSem.SetRange(Code, sem);
        IF CurrentSem.FIND('-') THEN BEGIN
            Message := CurrentSem.Code + '::' + CurrentSem.Description + '::' + FORMAT(CurrentSem."Registration Deadline") + '::' +
  FORMAT(CurrentSem."Lock CAT Editting") + '::' + FORMAT(CurrentSem."Lock Exam Editting") + '::' + FORMAT(CurrentSem."Ignore Editing Rule")
  + '::' + Format(CurrentSem."Mark entry Dealine", 0, '<Day,2>/<Month,2>/<Year4>')
+ '::' + FORMAT(CurrentSem."Lock Lecturer Editing") + '::' + FORMAT(CurrentSem.AllowDeanEditing) + '::' + FORMAT(CurrentSem."Unit Registration Deadline");
        END
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

    procedure LecturerSpecificTimetables(Semesters: Code[20]; LecturerNo: Code[20]; TimetableType: Text[20]; filenameFromApp: Text[150]) TimetableReturn: Text
    var
        UnitFilterString: Text[1024];
        NoOfLoops: Integer;
        EXTTimetableFInalCollector: Record "EXT-Timetable FInal Collector";
        TTTimetableFInalCollector: Record "TT-Timetable FInal Collector";
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
                                                                 //REPORT.RUN(74501,TRUE,FALSE,TTTimetableFInalCollector);
                                                                 //filename :=FILESPATH_S+LecturerNo+'_ClassTimetable_'+Semesters;
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

    procedure SubmitSpecialAndSupplementary(StudNo: Code[20]; LectNo: Code[20]; Marks: Decimal; AcademicYear: Code[20]; UnitCode: Code[20]) ReturnMessage: Text[250]
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

    procedure ModifySuppCAT(StudNo: Code[30]; Prog: Code[30]; Unitz: Code[30]; ExamTypez: Code[30]; Scorez: Decimal; LecturerNamez: Code[50]; UserNamez: Code[30]) ReturnMessage: Text
    begin
        ACAExamResults.RESET;
        ACAExamResults.SETRANGE("Student No.", StudNo);
        ACAExamResults.SETRANGE(Programmes, Prog);
        ACAExamResults.SETRANGE(Unit, Unitz);
        ACAExamResults.SETRANGE(ExamType, ExamTypez);
        IF ACAExamResults.FIND('-') THEN BEGIN
            ACAExamResults.Score := Scorez;
            ACAExamResults.VALIDATE(Score);
            ACAExamResults."Lecturer Names" := LecturerNamez;
            ACAExamResults."User Name" := UserNamez;
            ACAExamResults.UserID := UserNamez;
            ACAExamResults.MODIFY;
            ACAExamResults.VALIDATE(ExamType);
            ReturnMessage := 'Marks Saved Successfully!';
        END ELSE begin
            ACAExamResults.init;
            ACAExamResults."Student No." := StudNo;
            ACAExamResults.Programmes := Prog;
            ACAExamResults.Unit := Unitz;
            AcaSpecialExamsDetails.Reset;
            AcaSpecialExamsDetails.SetRange("Student No.", StudNo);
            AcaSpecialExamsDetails.SetRange("Unit Code", Unitz);
            AcaSpecialExamsDetails.SetRange(Programme, Prog);
            IF AcaSpecialExamsDetails.FIND('-') then begin
                ACAExamResults."Academic Year" := AcaSpecialExamsDetails."Academic Year";
                ACAExamResults.Semester := AcaSpecialExamsDetails.Semester;
                ACAExamResults.Stage := AcaSpecialExamsDetails.Stage;
            end;
            ACAExamResults.ExamType := ExamTypez;
            ACAExamResults.Score := Scorez;
            ACAExamResults.VALIDATE(Score);
            ACAExamResults."Lecturer Names" := LecturerNamez;
            ACAExamResults."User Name" := UserNamez;
            ACAExamResults.UserID := UserNamez;
            ACAExamResults.INSERT;
            ACAExamResults.VALIDATE(ExamType);
            ReturnMessage := 'Marks Saved Successfully!';
        end;
    end;

    procedure GetSuppMarks(StudNo: Code[30]; Prog: Code[30]; Unitz: Code[30]; ExamTypez: Code[30]) ReturnMessage: Text
    begin
        ACAExamResults.RESET;
        ACAExamResults.SETRANGE("Student No.", StudNo);
        ACAExamResults.SETRANGE(Programmes, Prog);
        ACAExamResults.SETRANGE(Unit, Unitz);
        ACAExamResults.SETRANGE(ExamType, ExamTypez);
        IF ACAExamResults.FIND('-') THEN BEGIN
            ReturnMessage := FORMAT(ACAExamResults.Score) + '::' + FORMAT(ACAExamResults."Edit Count");
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

    procedure Islecturer(username: Text) Message: Text
    begin
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            Message := FORMAT(EmployeeCard.Lecturer);
        END
    end;

    procedure GetPersonaldata(username: code[30]; fname: Text; mname: Text; lname: Text; gender: Text; dob: Date; nationality: text; county: Text; IDno: Text; PassNo: Text; Religion: Text; denomination: Text;
    congr: Text; diocese: Text; orderInst: Text; protCong: Text; maritalStatus: Text; disability: Text; disabilityType: Text;
    knewCollege: Text; formerCueaNo: Text; prevEdu: Text; ethnicity: Text)
    begin
        AcaApplications.Reset();




    end;

    procedure getLeaveSch(username: code[10]; startDate: date; endDate: date)
    begin
        leaveSch.Init;
        leaveSch.PayrollNo := username;
        leaveSch."Start Date" := startDate;
        leaveSch."End Date" := endDate;
        leaveSch.Insert;
    end;

    procedure CancelLeaveApplication(appno: Text) cancelled: Boolean
    begin
        LeaveT.Reset();
        LeaveT.SETRANGE(LeaveT."No.", appno);
        IF LeaveT.FIND('-') THEN BEGIN
            LeaveT.Status := LeaveT.Status::Cancelled;
            LeaveT.Modify;
            cancelled := true;
        END
    end;

    procedure checkDean(username: code[10]) ishod: Boolean
    begin
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        EmployeeCard.SETRANGE(EmployeeCard.isDean, TRUE);
        IF EmployeeCard.FIND('-') THEN BEGIN
            ishod := TRUE;
        END;
    end;

    procedure checkHOD(username: code[10]) ishod: Boolean
    begin
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        EmployeeCard.SETRANGE(EmployeeCard.HOD, TRUE);
        IF EmployeeCard.FIND('-') THEN BEGIN
            ishod := TRUE;
        END;
    end;

    procedure GetFacultyApps(username: code[10]) apps: Text
    var
        progname: Text;
        faculty: Text;
    begin
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            fablist.RESET;
            fablist.SETRANGE(fablist."Programme School", EmployeeCard."Faculty Code");
            fablist.SETRANGE(fablist.Status, fablist.Status::"Department Approved");
            IF fablist.FIND('-') THEN BEGIN
                REPEAT
                    programs.RESET;
                    programs.SETRANGE(programs.Code, fablist."First Degree Choice");
                    IF programs.FIND('-') THEN BEGIN
                        progname := programs.Description;
                        faculty := programs.Faculty;
                    END;
                    apps := apps + fablist."Application No." + ' ::' + progname + ' ::' + faculty + ' ::' + FORMAT(fablist."Application Date") + ' ::' + fablist."First Name" + ' ::' + fablist.Surname + ' ::' + FORMAT(fablist."Application Type") + ' :::';
                UNTIL fablist.Next = 0;
            END;
        END;
    end;

    procedure GetApplicantEmail(appno: code[50]) email: Text
    begin
        fablist.RESET;
        fablist.SETRANGE(fablist."Application No.", appno);
        IF fablist.FIND('-') THEN BEGIN
            email := fabList.Email;
        END;
    end;

    procedure GetDepartmentalApps(username: code[10]) apps: Text
    var
        progname: Text;
        faculty: Text;
    begin
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            fablist.RESET;
            fablist.SETRANGE(fablist."Programme Department", EmployeeCard."Department Code");
            fablist.SETRANGE(fablist.Status, fablist.Status::"Pending Approval");
            IF fablist.FIND('-') THEN BEGIN
                REPEAT
                    programs.RESET;
                    programs.SETRANGE(programs.Code, fablist."First Degree Choice");
                    IF programs.FIND('-') THEN BEGIN
                        progname := programs.Description;
                        faculty := programs.Faculty;
                    END;
                    apps += fablist."Application No." + ' ::' + progname + ' ::' + faculty + ' ::' + FORMAT(fablist."Application Date") + ' ::' + fablist."First Name" + ' ::' + fablist.Surname + ' ::' + FORMAT(fablist."Application Type") + ' :::';
                UNTIL fablist.Next = 0;
            END;
        END;
    end;

    procedure GetDepartmentalPrograms(username: code[10]) progs: Text
    begin
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            programs.RESET;
            programs.SETRANGE(programs."Department Code", EmployeeCard."Department Code");
            IF programs.FIND('-') THEN BEGIN
                REPEAT
                    progs += programs.Code + ' ::' + programs.Description + ' :::';
                UNTIL programs.Next = 0;
            END;
        END;
    end;

    procedure GetProgDeptCode(progcode: code[10]) deptcode: Text
    begin
        programs.RESET;
        programs.SETRANGE(programs.Code, progcode);
        IF programs.FIND('-') THEN BEGIN
            deptcode := programs."Department Code";
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

    procedure GetModeofStudy() Message: Text
    begin
        studymodes.RESET;
        IF studymodes.FIND('-') THEN BEGIN
            REPEAT
                Message := Message + studymodes.Code + ' ::' + studymodes.Description + ' :::';
            UNTIL studymodes.NEXT = 0;
        END;
    end;

    procedure GetTrainings(username: Text) Message: Text
    begin
        TrainingParticipants.RESET;
        TrainingParticipants.SETRANGE(TrainingParticipants."Employee Code", username);
        IF TrainingParticipants.FIND('-') THEN BEGIN
            REPEAT
                HrTrainings.RESET;
                HrTrainings.SETRANGE(HrTrainings."Application No", TrainingParticipants."Training Code");
                HrTrainings.SETRANGE(HrTrainings.Status, HrTrainings.Status::Approved);
                IF HrTrainings.FIND('-') THEN BEGIN
                    Message := Message + HrTrainings."Course Title" + ' ::' + HrTrainings.Description + ' ::' + FORMAT(HrTrainings."From Date") + ' ::' + FORMAT(HrTrainings."To Date")
                    + ' ::' + HrTrainings."Purpose of Training" + ' ::' + HrTrainings."Training Institution" + ' :::';
                END;
            UNTIL TrainingParticipants.NEXT = 0;
        END;
    end;

    procedure AcceptDepartmentalApps(appno: code[20]; staffno: Code[20]; stype: code[20]) accepted: Boolean
    begin
        fablist.RESET;
        fablist.SETRANGE(fablist."Application No.", appno);
        IF fablist.FIND('-') THEN BEGIN
            fablist.Status := fablist.Status::"Department Approved";
            fablist."DAB Staff ID" := staffno;
            fablist.Validate("DAB Staff ID");
            fablist."Settlement Type" := stype;
            fablist.MODIFY;
            SendEmail(fablist."First Degree Choice", fablist."Application No.");
            accepted := TRUE;
        END;
    end;

    procedure GetCourseDurations(appno: code[20]) msg: Text
    begin
        fablist.RESET;
        fablist.SETRANGE(fablist."Application No.", appno);
        IF fablist.FIND('-') THEN BEGIN
            settlementtypes.Reset;
            settlementtypes.SETCURRENTKEY(Description);
            settlementtypes.SetRange(ModeofStudy, fablist."Mode of Study");
            settlementtypes.SetFilter(Description, '<>%1', '');
            if settlementtypes.Find('-') then begin
                //Repeat
                msg += settlementtypes.Code + '::' + settlementtypes.Description;
                //Until settlementtypes.Next = 0;
            end;
        END;
    end;

    procedure GetUnitsOnOffer(progcode: code[20]; stagecode: code[20]; studymode: code[20]) Details: Text
    begin
        UnitSubjects.RESET;
        UnitSubjects.SETRANGE(UnitSubjects."Programme Code", progcode);
        UnitSubjects.SETRANGE(UnitSubjects."Stage Code", stagecode);
        IF UnitSubjects.FIND('-') THEN BEGIN
            repeat
                ProgramUnits.RESET;
                ProgramUnits.SETRANGE(ProgramUnits."Unit Code", UnitSubjects.Code);
                ProgramUnits.SETRANGE(ProgramUnits."Programme Code", progcode);
                ProgramUnits.SETRANGE(ProgramUnits."Stage Code", stagecode);
                ProgramUnits.SETRANGE(ProgramUnits."Mode of Study", studymode);
                ProgramUnits.SETRANGE(ProgramUnits.Semester, GetCurrentSem(progcode, stagecode));
                IF NOT ProgramUnits.FIND('-') THEN BEGIN
                    Details := Details + UnitSubjects.Code + ' ::' + UnitSubjects.Desription + ' :::';
                end;
            until UnitSubjects.Next = 0;
        END;
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

    procedure OfferSemUnits(unitcode: code[20]; progcode: code[20]; stagecode: code[20]; studymode: code[20]) Details: Boolean
    begin
        ProgramUnits.INIT;
        IF ProgramUnits.FIND('+') THEN BEGIN
            ProgramUnits."Entry No" := ProgramUnits."Entry No" + 1;
        END ELSE BEGIN
            ProgramUnits."Entry No" := 0;
        END;
        ProgramUnits."Unit Code" := unitcode;
        ProgramUnits."Programme Code" := progcode;
        ProgramUnits."Stage Code" := stagecode;
        ProgramUnits."Mode of Study" := studymode;
        ProgramUnits.Semester := GetCurrentSem(progcode, stagecode);
        ProgramUnits.Insert();
        Details := true;
    end;

    procedure RemoveSemUnit(hodno: Code[20]; unitcode: code[20]; progcode: code[20]; studymode: code[20]; stream: Text) Details: Boolean
    begin
        //delete associate units
        associatedunits.Reset;
        associatedunits.SetRange(UnitBaseCode, unitcode);
        if associatedunits.Find('-') then begin
            repeat
                //delete associate unit registered students
                studentUnits.RESET;
                studentUnits.SETRANGE(Semester, GetCurrentSemester());
                studentUnits.SETRANGE(Unit, associatedunits."Associated Unit");
                StudentUnits.SetRange("Campus Code", GetHODCampus(hodno));
                studentUnits.SETRANGE(Stream, stream);
                studentUnits.SETRANGE(Programme, progcode);
                studentUnits.SETRANGE(ModeOfStudy, studymode);
                if studentUnits.FIND('-') then begin
                    repeat
                        studentUnits.CALCFIELDS("CATs Marks Exists", "EXAMs Marks Exists");
                        if ((studentUnits."CATs Marks Exists") OR (studentUnits."EXAMs Marks Exists")) then begin
                            Error('Marks Exist you cannot Delete!');
                        end else begin
                            studentUnits.DELETE;
                        end;
                    until StudentUnits.next = 0;
                end;
                offeredunits.RESET;
                offeredunits.SETRANGE("Unit Base Code", associatedunits."Associated Unit");
                offeredunits.SETRANGE(Programs, progcode);
                offeredunits.SETRANGE(ModeofStudy, studymode);
                offeredunits.SETRANGE(Stream, stream);
                offeredunits.SETRANGE(Semester, GetCurrentSemester());
                offeredunits.SetRange(Campus, GetHODCampus(hodno));
                IF offeredunits.FIND('-') THEN begin
                    offeredunits.Delete();
                end;
            until associatedunits.Next = 0;
        end;
        //delete base unit
        offeredunits.RESET;
        offeredunits.SETRANGE("Unit Base Code", unitcode);
        offeredunits.SETRANGE(Programs, progcode);
        offeredunits.SETRANGE(ModeofStudy, studymode);
        offeredunits.SETRANGE(Stream, stream);
        offeredunits.SETRANGE(Semester, GetCurrentSemester());
        offeredunits.SetRange(Campus, GetHODCampus(hodno));
        IF offeredunits.FIND('-') THEN BEGIN
            //delete base unit registered students
            studentUnits.RESET;
            studentUnits.SETRANGE(Semester, GetCurrentSemester());
            studentUnits.SETRANGE(Unit, unitcode);
            StudentUnits.SetRange("Campus Code", GetHODCampus(hodno));
            studentUnits.SETRANGE(Stream, stream);
            studentUnits.SETRANGE(Programme, progcode);
            studentUnits.SETRANGE(ModeOfStudy, studymode);
            if studentUnits.FIND('-') then begin
                repeat
                    studentUnits.CALCFIELDS("CATs Marks Exists", "EXAMs Marks Exists");
                    if ((studentUnits."CATs Marks Exists") OR (studentUnits."EXAMs Marks Exists")) then begin
                        Error('Marks Exist you cannot Delete!');
                    end else begin
                        studentUnits.DELETE;
                    end;
                until StudentUnits.next = 0;
            end;
            offeredunits.Delete();
            //delete allocated lecturers
            lecturers.Reset;
            lecturers.SetRange(Lecturer, offeredunits.Lecturer);
            lecturers.SetRange(Unit, offeredunits."Unit Base Code");
            lecturers.SetRange(ModeOfStudy, offeredunits.ModeofStudy);
            lecturers.SetRange(Stream, offeredunits.Stream);
            lecturers.SetRange(Semester, offeredunits.Semester);
            lecturers.SetRange("Campus Code", GetHODCampus(hodno));
            lecturers.SetRange(Day, offeredunits.Day);
            lecturers.SetRange(TimeSlot, offeredunits.TimeSlot);
            if lecturers.Find('-') then begin
                lecturers.Delete;
            end;
            Details := true;
        END;
    end;



    procedure RejectDepartmentalApps(appno: code[20]; staffno: code[20]; reason: Text[250]) rejected: Boolean
    begin
        fablist.RESET;
        fablist.SETRANGE(fablist."Application No.", appno);
        IF fablist.FIND('-') THEN BEGIN
            fabList.Status := fablist.Status::"Department Rejected";
            fablist."Rejection Reason" := reason;
            fablist."DAB Staff ID" := staffno;
            fablist.Validate("DAB Staff ID");
            fablist.MODIFY;
            rejected := TRUE;
        END;
    end;

    procedure ClassAttendanceHeader(lectno: code[20]; unit: text; classtime: Code[20])
    begin
        AttendanceHeader.INIT;
        AttendanceHeader."Attendance Date" := Today;
        AttendanceHeader."Lecturer Code" := lectno;
        AttendanceHeader.Semester := GetCurrentSem();
        AttendanceHeader."Unit Code" := unit;
        AttendanceHeader."Class Type" := AttendanceHeader."Class Type"::"Normal Single";
        AttendanceHeader.Time := classtime;
        AttendanceHeader.INSERT;
    end;

    procedure ClassAttendanceDetails(counting: integer; stdno: code[20]; stdname: text; lectno: code[20]; unit: text; present: boolean)
    var
        entryno: integer;
    begin
        AttendanceDetails.INIT;
        AttendanceDetails.Counting := counting;
        AttendanceDetails."Lecturer Code" := lectno;
        AttendanceDetails."Attendance Date" := Today;
        AttendanceDetails."Unit Code" := unit;
        AttendanceDetails."Student No." := stdno;
        AttendanceDetails."Student Name" := stdname;
        AttendanceDetails.Present := present;
        AttendanceDetails.Semester := GetCurrentSem();
        AttendanceDetails.INSERT;
    end;

    procedure AcceptFacultyApps(appno: code[20]; staffno: code[20]) accepted: Boolean
    begin
        fablist.RESET;
        fablist.SETRANGE(fablist."Application No.", appno);
        IF fablist.FIND('-') THEN BEGIN
            fabList.Status := fablist.Status::"Dean Approved";
            fablist."FAB Staff ID" := staffno;
            fablist.Validate("FAB Staff ID");
            fablist.MODIFY;
            accepted := TRUE;
        END;
    end;

    procedure RejectFacultyApps(appno: code[20]; staffno: code[20]; reason: Text[250]) accepted: Boolean
    begin
        fablist.RESET;
        fablist.SETRANGE(fablist."Application No.", appno);
        IF fablist.FIND('-') THEN BEGIN
            fabList.Status := fablist.Status::"Dean Rejected";
            fablist."Rejection Reason" := reason;
            fablist."FAB Staff ID" := staffno;
            fablist.Validate("FAB Staff ID");
            fablist.MODIFY;
            accepted := TRUE;
        END;
    end;

    procedure GetReligions() Message: Text
    begin
        religions.RESET;
        IF religions.FIND('-') THEN BEGIN
            REPEAT
                Message := Message + religions.Religion + ' :::';
            UNTIL religions.NEXT = 0;
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
        filename := FILESPATH_S + filenameFromApp;
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

    procedure GenerateBS64DepartmentAppSummary(hod: code[20]; filenameFromApp: Text; var bigtext: BigText) rtnmsg: Text
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
        filename := FILESPATH_S + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.", hod);
        IF EmployeeCard.FIND('-') THEN BEGIN
            fablist.RESET;
            fablist.SETRANGE(fablist."Programme Department", EmployeeCard."Department Code");
            IF fablist.FIND('-') THEN BEGIN
                recRef.GetTable(fablist);
                tmpBlob.CreateOutStream(OutStr);
                Report.SaveAs(86521, '', format::Pdf, OutStr, recRef);
                tmpBlob.CreateInStream(InStr);
                txtB64 := cnv64.ToBase64(InStr, true);
                bigtext.AddText(txtB64);
            END;
        END;
        EXIT(filename);
    end;

    procedure GenerateBS64FacultyAppSummary(hod: code[20]; filenameFromApp: Text; var bigtext: BigText) rtnmsg: Text
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
        filename := FILESPATH_S + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.", hod);
        IF EmployeeCard.FIND('-') THEN BEGIN
            fablist.RESET;
            fablist.SETRANGE(fablist."Programme School", EmployeeCard."Faculty Code");
            IF fablist.FIND('-') THEN BEGIN
                recRef.GetTable(fablist);
                tmpBlob.CreateOutStream(OutStr);
                Report.SaveAs(86521, '', format::Pdf, OutStr, recRef);
                tmpBlob.CreateInStream(InStr);
                txtB64 := cnv64.ToBase64(InStr, true);
                bigtext.AddText(txtB64);
            END;
        END;
        EXIT(filename);
    end;

    procedure GenerateBS64ClassRegister(progcode: Code[20]; unitcode: Code[20]; campus: Code[20]; filenameFromApp: Text; var bigtext: BigText) rtnmsg: Text
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
        filename := FILESPATH_S + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);

        StudentUnits.RESET;
        StudentUnits.SETRANGE(StudentUnits.Programme, progcode);
        StudentUnits.SETRANGE(StudentUnits.Unit, unitcode);
        StudentUnits.SETRANGE(StudentUnits.Semester, GetCurrentSem());
        StudentUnits.SETRANGE(StudentUnits."Campus Code", campus);
        IF StudentUnits.FIND('-') THEN BEGIN
            recRef.GetTable(StudentUnits);
            tmpBlob.CreateOutStream(OutStr);
            Report.SaveAs(51864, '', format::Pdf, OutStr, recRef);
            tmpBlob.CreateInStream(InStr);
            txtB64 := cnv64.ToBase64(InStr, true);
            bigtext.AddText(txtB64);
        END ELSE BEGIN
            Error('No class list for the details provided!');
        END;
        EXIT(filename);
    end;

    procedure GenerateBS64ClassRegisterNew(lecturer: Code[20]; unitcode: Code[20]; mode: Code[20]; stream: Text; filenameFromApp: Text; var bigtext: BigText) rtnmsg: Text
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
        filename := FILESPATH_S + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);

        StudentUnits.RESET;
        StudentUnits.SETRANGE(StudentUnits.Unit, unitcode);
        //StudentUnits.SETRANGE(StudentUnits.ModeOfStudy, mode);
        //StudentUnits.SETRANGE(StudentUnits.Stream, stream);
        StudentUnits.SETRANGE(StudentUnits.Semester, GetCurrentSem());
        StudentUnits.SETRANGE(StudentUnits."Campus Code", GetHODCampus(lecturer));
        IF StudentUnits.FIND('-') THEN BEGIN
            recRef.GetTable(StudentUnits);
            tmpBlob.CreateOutStream(OutStr);
            Report.SaveAs(51864, '', format::Pdf, OutStr, recRef);
            tmpBlob.CreateInStream(InStr);
            txtB64 := cnv64.ToBase64(InStr, true);
            bigtext.AddText(txtB64);
        END ELSE BEGIN
            Error('No class list for the details provided!');
        END;
        EXIT(filename);
    end;

    procedure GenerateBS64ApplicationSummary(appNo: Text; filenameFromApp: Text; var bigtext: BigText) rtnmsg: Text
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
        filename := FILESPATH_S + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);

        fablist.RESET;
        fablist.SETRANGE(fablist."Application No.", appNo);
        IF fablist.FIND('-') THEN BEGIN
            recRef.GetTable(fablist);
            tmpBlob.CreateOutStream(OutStr);
            Report.SaveAs(86663, '', format::Pdf, OutStr, recRef);
            tmpBlob.CreateInStream(InStr);
            txtB64 := cnv64.ToBase64(InStr, true);
            bigtext.AddText(txtB64);
        END;
        EXIT(filename);
    end;

    procedure GenerateBS64MarksReport(unitCode: Code[20]; Sem: Code[20]; Campus: Code[20]; filenameFromApp: Text; var bigtext: BigText) rtnmsg: Text
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
        filename := FILESPATH_S + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);

        studentUnits.RESET;
        StudentUnits.CalcFields("Campus Code");
        studentUnits.SETRANGE(studentUnits."Campus Code", Campus);
        studentUnits.SETRANGE(studentUnits.Unit, unitCode);
        studentUnits.SETRANGE(studentUnits.Semester, Sem);
        IF studentUnits.FIND('-') THEN BEGIN
            recRef.GetTable(studentUnits);
            tmpBlob.CreateOutStream(OutStr);
            Report.SaveAs(51771, '', format::Pdf, OutStr, recRef);
            tmpBlob.CreateInStream(InStr);
            txtB64 := cnv64.ToBase64(InStr, true);
            bigtext.AddText(txtB64);
        END;
        EXIT(filename);
    end;

    procedure ValidStdNo(stdno: Text) vld: Boolean
    begin
        trscripttbl.RESET;
        trscripttbl.SETRANGE(trscripttbl.StudentID, stdno);
        IF trscripttbl.FIND('-') THEN BEGIN
            vld := true;
        end;
    end;

    procedure ValidUnitCode(unitcode: Text) vld: Boolean
    begin
        UnitSubjects.RESET;
        UnitSubjects.SETRANGE(UnitSubjects.Code, unitcode);
        IF UnitSubjects.FIND('-') THEN BEGIN
            vld := true;
        end;
    end;

    procedure GetStaffPortalMsg() Message: Text
    begin
        portalsetup.RESET;
        portalsetup.SETRANGE(portalsetup.status, portalsetup.status::Active);
        IF portalsetup.FIND('-') THEN BEGIN
            Message := portalsetup.StaffPortalMessage;
        END;
    end;

    procedure CheckLecAssigned(progcode: Text; unit: Text; stage: Text; username: Text) Assigned: Boolean
    begin
        Assigned := FALSE;
        ACALecturersUnits.RESET;
        ACALecturersUnits.SETRANGE(ACALecturersUnits.Programme, progcode);
        ACALecturersUnits.SETRANGE(ACALecturersUnits.Stage, stage);
        ACALecturersUnits.SETRANGE(ACALecturersUnits.Unit, unit);
        ACALecturersUnits.SETRANGE(ACALecturersUnits.Semester, GetCurrentSem(progcode, stage));
        ACALecturersUnits.SETRANGE(ACALecturersUnits."Campus Code", GetHODCampus(username));
        ACALecturersUnits.SETFILTER(ACALecturersUnits.Lecturer, '<>%1', '');
        IF ACALecturersUnits.FIND('-') THEN BEGIN
            Assigned := TRUE;
        END;
    end;

    procedure AssignLec(progcode: Text; unit: Text; stage: Text; lec: Text) Assigned: Boolean
    begin
        ACALecturersUnits.RESET;
        ACALecturersUnits.SETRANGE(ACALecturersUnits.Programme, progcode);
        ACALecturersUnits.SETRANGE(ACALecturersUnits.Stage, stage);
        ACALecturersUnits.SETRANGE(ACALecturersUnits.Unit, unit);
        ACALecturersUnits.SETRANGE(ACALecturersUnits.Semester, GetCurrentSem(progcode, stage));
        ACALecturersUnits.SETRANGE(ACALecturersUnits."Campus Code", GetHODCampus(lec));
        ACALecturersUnits.SETFILTER(ACALecturersUnits.Lecturer, '=%1', '');
        IF ACALecturersUnits.FIND('-') THEN BEGIN
            ACALecturersUnits.Lecturer := lec;
            ACALecturersUnits.MODIFY;
        END ELSE BEGIN
            ACALecturersUnits.Init();
            ACALecturersUnits.Programme := progcode;
            ACALecturersUnits.Stage := stage;
            ACALecturersUnits.Unit := unit;
            ACALecturersUnits.Semester := GetCurrentSem(progcode, stage);
            ACALecturersUnits."Campus Code" := GetHODCampus(lec);
            ACALecturersUnits.Lecturer := lec;
            ACALecturersUnits.Insert;
        END;
    end;

    procedure GetLec(progcode: Text; unit: Text; stage: Text; username: Text) Name: Text
    begin
        ACALecturersUnits.RESET;
        ACALecturersUnits.SETRANGE(ACALecturersUnits.Programme, progcode);
        ACALecturersUnits.SETRANGE(ACALecturersUnits.Stage, stage);
        ACALecturersUnits.SETRANGE(ACALecturersUnits.Unit, unit);
        ACALecturersUnits.SETRANGE(ACALecturersUnits.Semester, GetCurrentSem(progcode, stage));
        ACALecturersUnits.SETRANGE(ACALecturersUnits."Campus Code", GetHODCampus(username));
        IF ACALecturersUnits.FIND('-') THEN BEGIN
            HRMEmployeeD.RESET;
            HRMEmployeeD.SetRange("No.", ACALecturersUnits.Lecturer);
            IF HRMEmployeeD.FIND('-') THEN BEGIN
                Name := HRMEmployeeD."First Name" + ' ' + HRMEmployeeD."Middle Name" + ' ' + HRMEmployeeD."Last Name";
            END
        END
    end;

    procedure GetStoreItems(postinggroup: Code[20]) Message: Text
    begin
        Items.Reset();
        Items.SETRANGE(Items."Inventory Posting Group", postinggroup);
        Items.SETFILTER(Items.Description, '<>%1', '');
        IF Items.FIND('-') THEN BEGIN
            repeat
                Message := Message + Items."No." + ' ::' + Items.Description + ' :::';
            until Items.Next = 0;
        END
    end;

    procedure GetPRNItems() Message: Text
    begin
        Items.Reset();
        Items.SETFILTER(Items.Description, '<>%1', '');
        IF Items.FIND('-') THEN BEGIN
            repeat
                Message := Message + Items."No." + ' ::' + Items.Description + ' :::';
            until Items.Next = 0;
        END
    end;

    procedure GetGLItems() Message: Text
    begin
        GLAccounts.Reset();
        GLAccounts.SETRANGE(GLAccounts.IsService, true);
        GLAccounts.SETRANGE(GLAccounts."Account Type", GLAccounts."Account Type"::Posting);
        IF GLAccounts.FIND('-') THEN BEGIN
            repeat
                Message := Message + GLAccounts."No." + ' ::' + GLAccounts.Name + ' :::';
            until GLAccounts.Next = 0;
        END
    end;

    procedure FnApplicationAttachement(retNo: Code[50]; fileName: Text; attachment: BigText; tableId: Integer) return_value: Boolean
    var
        DocAttachment: Record "Document Attachment";
        DocAttachment1: Record "Document Attachment";
        FromRecRef: RecordRef;
        FileManagement: Codeunit "File Management";
        Bytes: dotnet Array;
        Convert: dotnet Convert;
        MemoryStream: dotnet MemoryStream;
        Ostream: OutStream;
        tableFound: Boolean;
        ObjAppliRec: Record "HRM-Job Applications (B)";

    begin

        tableFound := false;
        return_value := false;
        if TableID = Database::"HRM-Job Applications (B)" then begin
            ObjAppliRec.RESET;
            ObjAppliRec.SETRANGE(ObjAppliRec."Application No", retNo);
            if ObjAppliRec.FIND('-') then begin
                FromRecRef.GETTABLE(ObjAppliRec);
            end;
            tableFound := true;
        end;

        if tableFound = true then begin
            if FileName <> '' then begin
                DocAttachment1.Reset();
                DocAttachment1.SetRange("No.", retNo);
                DocAttachment1.SetRange("Table ID", FromRecRef.Number);
                DocAttachment1.SetRange("File Name", CopyStr(FileManagement.GetFileNameWithoutExtension(FileName), 1, MaxStrLen(FileName)));
                if DocAttachment1.Find('-') then begin
                    DocAttachment1.DeleteAll;
                end;
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

    procedure GetLectureTimeSlots(day: Code[20]) Message: Text
    begin
        timeslots.Reset;
        timeslots.SetRange("Day Code", day);
        timeslots.SetCurrentKey("Lesson Code");
        IF timeslots.FIND('-') THEN BEGIN
            REPEAT
                Message += timeslots."Lesson Code" + ' :::';
            UNTIL timeslots.NEXT = 0;
        END;
    end;

    procedure GetLectureHalls(hodno: Code[20]; day: Code[20]; timeslot: Code[20]) Message: Text
    begin
        lecturehalls.Reset();
        lecturehalls.SetCurrentKey("Lecture Room Name");
        lecturehalls.SetRange(Campus, GetHODCampus(hodno));
        lecturehalls.SetRange(Department, GetHODDepartment(hodno));
        IF lecturehalls.FIND('-') THEN BEGIN
            repeat
                offeredunits.Reset();
                offeredunits.SetRange("Lecture Hall", lecturehalls."Lecture Room Code");
                offeredunits.SetRange(Semester, GetCurrentSemester());
                offeredunits.SetRange(Day, day);
                offeredunits.SetRange(TimeSlot, timeslot);
                if not offeredunits.find('-') then begin
                    Message += lecturehalls."Lecture Room Code" + ' ::' + lecturehalls."Lecture Room Name" + ' (Capacity ' + FORMAT(lecturehalls."Sitting Capacity") + ') :::';
                end;
            until lecturehalls.Next = 0;
        END
    end;

    procedure GetDepartmentLecturers(department: Text) Message: Text
    begin
        HRMEmployeeD.Reset();
        HRMEmployeeD.SetRange(Lecturer, true);
        HRMEmployeeD.SetRange(Status, HRMEmployeeD.Status::Active);
        HRMEmployeeD.SetRange("Department Code", department);

        if HRMEmployeeD.Find('-') then begin
            repeat
                Message += 'SUCCESS' + '::' + HRMEmployeeD."No." + '::' + GetFullNames(HRMEmployeeD."No.") + '[]';
            until HRMEmployeeD.Next() = 0;

        end;
        exit(Message);

    end;



    procedure GetLecturers(hodno: Code[20]; day: Code[20]; timeslot: Code[20]) Message: Text
    var
        campus: Code[20];
    begin
        campus := GetHODCampus(hodno);
        HRMEmployeeD.Reset();
        HRMEmployeeD.SetRange(Lecturer, true);
        HRMEmployeeD.SetRange(Campus, campus);
        HRMEmployeeD.SetRange(Status, HRMEmployeeD.Status::Active);
        IF HRMEmployeeD.FIND('-') THEN BEGIN
            repeat
                lecturers.Reset();
                lecturers.SetRange(Lecturer, HRMEmployeeD."No.");
                lecturers.SetRange(Semester, GetCurrentSemester());
                lecturers.SetRange(Day, day);
                lecturers.SetRange(TimeSlot, timeslot);
                if NOT lecturers.FIND('-') then begin
                    Message += HRMEmployeeD."No." + ' ::' + HRMEmployeeD."No." + '-' + GetFullNames(HRMEmployeeD."No.") + ' :::';
                end;
            until HRMEmployeeD.Next = 0;
        END
    end;

    procedure GetUnitsToOffer(progcode: Code[20]; stage: Text) Details: Text
    var
        theoryUnits: Record "Timetable";
    begin

        // UnitSubjects.SETRANGE(UnitSubjects."Programme Code", progcode);
        // UnitSubjects.SETRANGE(UnitSubjects."Time Table", true);
        // UnitSubjects.SETRANGE(UnitSubjects."Stage Code", stage);
        // UnitSubjects.SETRANGE(UnitSubjects."Unit Type", UnitSubjects."Unit Type"::Theory);
        theoryUnits.RESET;
        theoryUnits.SETRANGE(theoryUnits.Programs, progcode);
        theoryUnits.SetRange(theoryUnits.Semester, stage);
        //theoryUnits.SetRange(Stage, stage);

        IF theoryUnits.FIND('-') THEN BEGIN
            repeat

                Details += theoryUnits."Unit Base Code" + ' :: ' + theoryUnits."Unit Base Code" + ' []';

            until theoryUnits.Next = 0;

        END;

    end;

    procedure GetDepartmentOfferedUnits(username: Code[20]) Details: Text
    begin
        offeredunits.RESET;
        offeredunits.SetCurrentKey(SystemCreatedAt);
        offeredunits.Ascending(false);
        offeredunits.SETRANGE(Department, GetHODDepartment(username));
        offeredunits.SETRANGE(Campus, GetHODCampus(username));
        offeredunits.SETRANGE(Semester, GetCurrentSemester());
        IF offeredunits.FIND('-') THEN BEGIN
            repeat
                offeredunits.CalcFields("Sitting Capacity", "Registered Students");
                Details += offeredunits."Unit Base Code" + ' ::' + GetUnitDescription(offeredunits."Unit Base Code") + ' ::' + offeredunits."Program Name" + ' ::' + offeredunits.ModeofStudy + ' ::' + GetFullNames(offeredunits.Lecturer) + ' ::' + GetLectureHallName(offeredunits."Lecture Hall") + ' ::' + offeredunits.Day + ' ::' + offeredunits.TimeSlot + ' ::' + offeredunits.Programs + ' ::' + offeredunits.Stream + ' ::' + FORMAT(offeredunits."Sitting Capacity" - GetRegisteredStds(offeredunits."Unit Base Code", offeredunits.Stream, GetHODCampus(username), offeredunits.ModeofStudy)) + ' ::' + FORMAT(GetRegisteredStds(offeredunits."Unit Base Code", offeredunits.Stream, GetHODCampus(username), offeredunits.ModeofStudy)) + ' :::';
            until offeredunits.Next = 0;
        END;
    end;

    procedure GetProgramOfferedUnits(progcode: Code[20]) Details: Text
    begin
        offeredunits.RESET;
        offeredunits.SETRANGE(offeredunits.Programs, progcode);
        offeredunits.SETRANGE(Semester, GetCurrentSemester());
        IF offeredunits.FIND('-') THEN BEGIN
            repeat
                Details += offeredunits."Unit Base Code" + ' ::' + GetUnitDescription(offeredunits."Unit Base Code") + ' ::' + offeredunits."Program Name" + offeredunits.ModeofStudy + ' ::' + GetFullNames(offeredunits.Lecturer) + ' ::' + GetLectureHallName(offeredunits."Lecture Hall") + ' ::' + offeredunits.Day + ' ::' + offeredunits.TimeSlot + ' :::';
            until offeredunits.Next = 0;
        END;
    end;

    procedure GetHODDepartment(empno: Code[20]) dept: Text
    begin
        HRMEmployeeD.Reset;
        HRMEmployeeD.SetRange("No.", empno);
        if HRMEmployeeD.Find('-') then begin
            dept := HRMEmployeeD."Department Code";
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

    procedure OfferUnit(hodno: Code[20]; progcode: Code[20]; unitcode: Code[20]; studymode: Code[20]; lecturer: Code[20]; lecturehall: Code[20]; day: Code[20]; timeslot: Code[20]) rtnMsg: Boolean
    begin
        offeredunits.Init;
        programs.Reset;
        programs.SetRange(Code, progcode);
        if programs.Find('-') then begin
            offeredunits.Programs := programs.Code;
            offeredunits."Program Name" := programs.Description;
            offeredunits.Department := programs."Department Code";
        end;
        offeredunits.Campus := GetHODCampus(hodno);
        offeredunits.Semester := GetCurrentSemester();
        offeredunits.ModeofStudy := studymode;
        offeredunits."Unit Base Code" := unitcode;
        offeredunits.Validate("Unit Base Code");
        offeredunits."Academic Year" := GetCurrentAcademicYear();
        offeredunits.Day := day;
        offeredunits.TimeSlot := timeslot;
        offeredunits."Lecture Hall" := lecturehall;
        offeredunits.Lecturer := lecturer;
        offeredunits.Validate(Lecturer);
        offeredunits.Validate("Lecture Hall");
        offeredunits.Insert;
        lecturers.Init;
        lecturers.Lecturer := lecturer;
        lecturers.Programme := progcode;
        lecturers.Unit := unitcode;
        lecturers.Description := GetUnitDescription(unitcode);
        lecturers.ModeOfStudy := studymode;
        lecturers."Campus Code" := GetHODCampus(lecturer);
        lecturers.Stream := offeredunits.Stream;
        lecturers.Semester := GetCurrentSemester();
        lecturers.Day := day;
        lecturers.TimeSlot := timeslot;
        lecturers.Insert;
        associatedunits.Reset;
        associatedunits.SetRange(UnitBaseCode, unitcode);
        if associatedunits.Find('-') then begin
            Repeat
                offeredunits.Init;
                programs.Reset;
                programs.SetRange(Code, associatedunits.Program);
                if programs.Find('-') then begin
                    offeredunits.Programs := programs.Code;
                    offeredunits."Program Name" := programs.Description;
                    offeredunits.Department := programs."Department Code";
                end;
                offeredunits."Unit Base Code" := associatedunits."Associated Unit";
                offeredunits.Validate("Unit Base Code");
                offeredunits.ModeofStudy := studymode;
                offeredunits.Semester := GetCurrentSemester();
                offeredunits."Academic Year" := GetCurrentAcademicYear();
                offeredunits.Day := day;
                offeredunits.TimeSlot := timeslot;
                offeredunits."Lecture Hall" := lecturehall;
                offeredunits.Lecturer := lecturer;
                offeredunits.Insert;
            Until associatedunits.Next = 0;
        end;
        rtnMsg := true;
    end;

    procedure ChangeLecturer(hodno: Code[20]; unitcode: code[20]; progcode: code[20]; studymode: code[20]; stream: Text; lec: Code[20]) Details: Boolean
    begin
        //delete associate units
        associatedunits.Reset;
        associatedunits.SetRange(UnitBaseCode, unitcode);
        if associatedunits.Find('-') then begin
            repeat
                //change associate unit lecturer
                offeredunits.RESET;
                offeredunits.SETRANGE("Unit Base Code", associatedunits."Associated Unit");
                offeredunits.SETRANGE(Programs, progcode);
                offeredunits.SETRANGE(ModeofStudy, studymode);
                offeredunits.SETRANGE(Stream, stream);
                offeredunits.SETRANGE(Semester, GetCurrentSemester());
                offeredunits.SetRange(Campus, GetHODCampus(hodno));
                IF offeredunits.FIND('-') THEN begin
                    offeredunits.Lecturer := lec;
                    offeredunits.Modify();
                end;
            until associatedunits.Next = 0;
        end;
        //change base unit lecturer
        offeredunits.RESET;
        offeredunits.SETRANGE("Unit Base Code", unitcode);
        offeredunits.SETRANGE(Programs, progcode);
        offeredunits.SETRANGE(ModeofStudy, studymode);
        offeredunits.SETRANGE(Stream, stream);
        offeredunits.SETRANGE(Semester, GetCurrentSemester());
        offeredunits.SetRange(Campus, GetHODCampus(hodno));
        IF offeredunits.FIND('-') THEN BEGIN
            offeredunits.Lecturer := lec;
            offeredunits.Modify();
            //change allocated lecturers
            lecturers.Reset;
            lecturers.SetRange(Unit, offeredunits."Unit Base Code");
            lecturers.SetRange(ModeOfStudy, offeredunits.ModeofStudy);
            lecturers.SetRange(Stream, offeredunits.Stream);
            lecturers.SetRange(Semester, offeredunits.Semester);
            lecturers.SetRange("Campus Code", GetHODCampus(hodno));
            lecturers.SetRange(Day, offeredunits.Day);
            lecturers.SetRange(TimeSlot, offeredunits.TimeSlot);
            if lecturers.Find('-') then begin
                lecturers.Rename(lecturers.Programme, lecturers.Stage, lecturers."Campus Code", lecturers."Group Type", lecturers.Class, lec, lecturers.Unit, lecturers.Semester, Lecturers.Description, lecturers.TimeSlot, lecturers.Day);
            end;
            Details := true;
        END;
    end;

    procedure ChangeLectureHall(hodno: Code[20]; unitcode: code[20]; progcode: code[20]; studymode: code[20]; stream: Text; lechall: Code[20]) Details: Boolean
    begin
        //delete associate units
        associatedunits.Reset;
        associatedunits.SetRange(UnitBaseCode, unitcode);
        if associatedunits.Find('-') then begin
            repeat
                //change associate unit lecturer
                offeredunits.RESET;
                offeredunits.SETRANGE("Unit Base Code", associatedunits."Associated Unit");
                offeredunits.SETRANGE(Programs, progcode);
                offeredunits.SETRANGE(ModeofStudy, studymode);
                offeredunits.SETRANGE(Stream, stream);
                offeredunits.SETRANGE(Semester, GetCurrentSemester());
                offeredunits.SetRange(Campus, GetHODCampus(hodno));
                IF offeredunits.FIND('-') THEN begin
                    offeredunits."Lecture Hall" := lechall;
                    offeredunits.Modify();
                end;
            until associatedunits.Next = 0;
        end;
        //change base unit lecturer
        offeredunits.RESET;
        offeredunits.SETRANGE("Unit Base Code", unitcode);
        offeredunits.SETRANGE(Programs, progcode);
        offeredunits.SETRANGE(ModeofStudy, studymode);
        offeredunits.SETRANGE(Stream, stream);
        offeredunits.SETRANGE(Semester, GetCurrentSemester());
        offeredunits.SetRange(Campus, GetHODCampus(hodno));
        IF offeredunits.FIND('-') THEN BEGIN
            offeredunits."Lecture Hall" := lechall;
            offeredunits.Modify();
            Details := true;
        END;
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

    procedure GetAllocatedLectureHall(lecturer: Code[20]; unit: Code[20]; stream: Text; campus: Code[20]; mode: Code[20]) details: Text
    begin
        offeredunits.Reset;
        offeredunits.SetRange("Unit Base Code", unit);
        offeredunits.SetRange(Lecturer, lecturer);
        offeredunits.SetRange(Campus, GetHODCampus(lecturer));
        offeredunits.SetRange(Stream, stream);
        offeredunits.SetRange(Semester, GetCurrentSemester());
        if offeredunits.Find('-') then begin
            details := GetLectureHallName(offeredunits."Lecture Hall") + ' ::' + Format(GetRegisteredStds(unit, stream, GetHODCampus(lecturer), mode));
        end else begin
            details := ' ::';
        end;
    end;

    procedure GetLecturerUnits(lecno: Code[20]) msg: Text
    begin
        lecturers.Reset;
        lecturers.SetRange(Lecturer, lecno);
        lecturers.SetRange(Semester, GetCurrentSemester());
        if lecturers.Find('-') then begin
            repeat
                msg += lecturers.Unit + ' ::' + GetUnitDescription(Lecturers.Unit) + ' ::' + lecturers.ModeOfStudy + ' ::' + lecturers.Stream + ' ::' + lecturers.Day + ' ::' + lecturers.TimeSlot + ' ::' + GetAllocatedLectureHall(lecturers.Lecturer, lecturers.Unit, lecturers.stream, lecturers."Campus Code", lecturers.ModeOfStudy) + ' :::';
            until lecturers.Next = 0;
        end;
    end;

    procedure GetLecturerUnits2(lectNo: Text; semester: Text) Message: Text
    var
        lecunits: Record "Timetable";
    begin
        lecunits.Reset();
        //lecunits.SetRange(lecunits.Semester, semester);
        lecunits.setRange(lecunits.Lecturer, lectNo);

        if lecunits.FindSet() then begin
            repeat
                Message += lecunits."Unit Base Code" + '::' + lecunits."Unit Base Code" + '::' + lecunits.Day + '::' + lecunits.TimeSlot + '::' + lecunits."Lecture Hall" + '[]';
            until lecunits.Next() = 0;
        end;

        exit(Message);
    end;

    procedure GetLecUnits(lecno: Code[20]) msg: Text
    begin
        lecturers.Reset;
        lecturers.SetRange(Lecturer, lecno);
        lecturers.SetRange(Semester, GetCurrentSemester());
        if lecturers.Find('-') then begin
            repeat
                msg += lecturers.Unit + ' ::' + GetUnitDescription(Lecturers.Unit) + ' ::' + lecturers.ModeOfStudy + ' ::' + lecturers.Stream + ' ::' + lecturers.Day + ' ::' + lecturers.TimeSlot + ' ::' + GetAllocatedLectureHall(lecturers.Lecturer, lecturers.Unit, lecturers.stream, lecturers."Campus Code", lecturers.ModeOfStudy) + ' :::';
            until lecturers.Next = 0;
        end;
    end;

    procedure GetExamUnits(lecNo: Code[20]; sem: Code[20]; AcademicYr: Code[20]): Text
    var
        message: Text;
    begin
        StudentUnits.Reset();
        Studentunits.SetRange(Supervisor, lecNo);
        Studentunits.SetRange(Semester, sem);
        Studentunits.SetRange("Academic Year", AcademicYr);

        if Studentunits.Find('-') then begin
            repeat
                message += Studentunits.Unit + '::' + StudentUnits."Unit Name" + '[]';
            until Studentunits.next() = 0;

        end;
        exit(message);
    end;


    procedure GetLecturerSemUnits(lecno: Code[20]; sem: Code[20]) msg: Text
    begin
        lecturers.Reset;
        lecturers.SetRange(Lecturer, lecno);
        lecturers.SetRange(Semester, sem);
        if lecturers.Find('-') then begin
            repeat
                msg += lecturers.Unit + ' ::' + GetUnitDescription(Lecturers.Unit) + ' ::' + lecturers.ModeOfStudy + ' ::' + lecturers.Stream + ' :::';
            until lecturers.Next = 0;
        end;
    end;

    procedure GetClinicalUnits(lecno: Code[20]; sem: Code[20]) Response: Text
    var
        units: Record "ACA-Units/Subjects";
    begin
        StudentUnits.Reset();
        StudentUnits.SetRange(Lecturer, lecno);
        StudentUnits.SetRange(Semester, sem);
        StudentUnits.SetRange(StudentUnits."Unit Type", units."Unit type"::Clinical);

        if StudentUnits.Find('-') then begin
            repeat
                Response += StudentUnits.Unit + ' ::' + GetUnitDescription(StudentUnits.Unit) + ' ::' + 'FULL-TIME' + '[]';
            until StudentUnits.Next = 0;
        end;
    end;

    procedure GetResearchUnits(lecNo: Code[20]; sem: Code[20]) Message: Text
    begin
        StudentUnits.Reset;
        StudentUnits.SetRange(Supervisor, lecno);
        StudentUnits.SetRange(Semester, sem);
        StudentUnits.SetRange(StudentUnits."Unit Category", StudentUnits."Unit Category"::Research);
        if StudentUnits.Find('-') then begin
            repeat
                Message += StudentUnits.Unit + ' ::' + GetUnitDescription(StudentUnits.Unit) + ' ::' + 'FULL-TIME' + '[]';
            until StudentUnits.Next = 0;
        end;
        exit(Message);
    end;

    procedure SubmitImprestSurrHeader(ImprestNo: Code[20]) Message: Text
    begin
        ImprestSurrHeader.RESET;
        ImprestSurrHeader.SETRANGE(ImprestSurrHeader."Imprest Issue Doc. No", ImprestNo);
        IF NOT ImprestSurrHeader.FIND('-') THEN BEGIN
            NextJobapplicationNo := NoSeriesMgt.GetNextNo('SURR', 0D, TRUE);
            ImprestRequisition.RESET;
            ImprestRequisition.GET(ImprestNo);
            /*Copy the details to the user interface*/
            ImprestSurrHeader.No := NextJobapplicationNo;
            ImprestSurrHeader."Imprest Issue Doc. No" := ImprestNo;
            ImprestSurrHeader."Paying Bank Account" := ImprestRequisition."Paying Bank Account";
            ImprestSurrHeader.Payee := ImprestRequisition.Payee;
            ImprestSurrHeader."Surrender Date" := TODAY;
            ImprestSurrHeader."Account Type" := ImprestSurrHeader."Account Type"::Customer;
            ImprestSurrHeader."Account No." := ImprestRequisition."Account No.";
            HRMEmployeeD.GET(ImprestRequisition."Requested By");
            ImprestSurrHeader."Responsibility Center" := HRMEmployeeD."Responsibility Center";
            ImprestRequisition.CALCFIELDS(ImprestRequisition."Total Net Amount");
            ImprestSurrHeader.Amount := ImprestRequisition."Total Net Amount";
            ImprestSurrHeader."Amount Surrendered LCY" := ImprestRequisition."Total Net Amount LCY";
            //Currencies
            ImprestSurrHeader."Currency Factor" := ImprestRequisition."Currency Factor";
            ImprestSurrHeader."Currency Code" := ImprestRequisition."Currency Code";

            ImprestSurrHeader."Date Posted" := ImprestRequisition."Date Posted";
            ImprestSurrHeader."Global Dimension 1 Code" := ImprestRequisition."Global Dimension 1 Code";
            ImprestSurrHeader."Shortcut Dimension 2 Code" := ImprestRequisition."Shortcut Dimension 2 Code";
            ImprestSurrHeader."Shortcut Dimension 3 Code" := ImprestRequisition."Shortcut Dimension 3 Code";
            ImprestSurrHeader.Dim3 := ImprestRequisition.Dim3;
            ImprestSurrHeader."Shortcut Dimension 4 Code" := ImprestRequisition."Shortcut Dimension 4 Code";
            ImprestSurrHeader.Dim4 := ImprestRequisition.Dim4;
            ImprestSurrHeader."Imprest Issue Date" := ImprestRequisition.Date;
            ImprestSurrHeader.INSERT;
            IF ImprestSurrHeader.INSERT THEN;
            Message := NextJobapplicationNo;
        END ELSE BEGIN

            //MODIFY
            ImprestRequisition.GET(ImprestNo);
            HRMEmployeeD.GET(ImprestRequisition."Requested By");
            ImprestSurrHeader."Responsibility Center" := HRMEmployeeD."Responsibility Center";
            IF ImprestSurrHeader.Modify() THEN BEGIN
                ImprestSurrDetails.Reset;
                ImprestSurrDetails.SetRange("Surrender Doc No.", ImprestSurrHeader.No);
                if ImprestSurrDetails.Find('-') then BEGIN
                    ImprestSurrDetails.DeleteAll;
                END;
                Message := ImprestSurrHeader.No;
            END;
        END;

    end;

    procedure SubmitImprestSurrDetails(DocumentNo: Text; ActualSpent: Decimal; CashAmount: Decimal; ImprestNo: Text) Message: Text
    begin

        /*Copy the detail lines from the imprest details table in the database*/
        ImprestRequisitionLines.RESET;
        ImprestRequisitionLines.SETRANGE(ImprestRequisitionLines.No, ImprestNo);
        IF ImprestRequisitionLines.FIND('-') THEN /*Copy the lines to the line table in the database*/
          BEGIN
            /*ImprestSurrDetails.SetRange("Surrender Doc No.", DocumentNo);
            if ImprestSurrDetails.Find('-') then BEGIN
                ImprestSurrDetails."Actual Spent" := ActualSpent;
                ImprestSurrDetails."Cash Receipt Amount" := CashAmount;
                ImprestSurrDetails.Modify(true)
            END else BEGIN*/
            ImprestSurrDetails.INIT;
            ImprestSurrDetails."Surrender Doc No." := DocumentNo;
            ImprestSurrDetails."Account No:" := ImprestRequisitionLines."Account No:";
            ImprestSurrDetails."Imprest Type" := ImprestRequisitionLines."Advance Type";
            ImprestSurrDetails.VALIDATE(ImprestSurrDetails."Account No:");
            ImprestSurrDetails."Account Name" := ImprestRequisitionLines."Account Name";
            ImprestSurrDetails.Amount := ImprestRequisitionLines.Amount;
            ImprestSurrDetails."Due Date" := ImprestRequisitionLines."Due Date";
            ImprestSurrDetails."Imprest Holder" := ImprestRequisitionLines."Imprest Holder";
            ImprestSurrDetails."Actual Spent" := ActualSpent;
            ImprestSurrDetails."Cash Surrender Amt" := CashAmount;
            ImprestSurrDetails."Apply to" := ImprestRequisitionLines."Apply to";
            ImprestSurrDetails."Apply to ID" := ImprestRequisitionLines."Apply to ID";
            ImprestSurrDetails."Surrender Date" := ImprestRequisitionLines."Surrender Date";
            ImprestSurrDetails.Surrendered := ImprestRequisitionLines.Surrendered;
            ImprestSurrDetails."Cash Receipt No" := ImprestRequisitionLines."M.R. No";
            ImprestSurrDetails."Date Issued" := ImprestRequisitionLines."Date Issued";
            ImprestSurrDetails."Type of Surrender" := ImprestRequisitionLines."Type of Surrender";
            ImprestSurrDetails."Dept. Vch. No." := ImprestRequisitionLines."Dept. Vch. No.";
            ImprestSurrDetails."Currency Factor" := ImprestRequisitionLines."Currency Factor";
            ImprestSurrDetails."Currency Code" := ImprestRequisitionLines."Currency Code";
            ImprestSurrDetails."Imprest Req Amt LCY" := ImprestRequisitionLines."Amount LCY";
            ImprestSurrDetails."Shortcut Dimension 1 Code" := ImprestRequisitionLines."Global Dimension 1 Code";
            ImprestSurrDetails."Shortcut Dimension 2 Code" := ImprestRequisitionLines."Shortcut Dimension 2 Code";
            ImprestSurrDetails."Shortcut Dimension 3 Code" := ImprestRequisitionLines."Shortcut Dimension 3 Code";
            ImprestSurrDetails."Shortcut Dimension 4 Code" := ImprestRequisitionLines."Shortcut Dimension 4 Code";
            if ImprestSurrDetails.INSERT(true, true) then begin
                Message := 'Line added successfully';
            end;
            //END
        END
    END;

    procedure SendImpSurrAppReq(docNo: Code[20]) msg: Boolean
    begin
        ImprestSurrHeader.Reset;
        ImprestSurrHeader.SETRANGE(ImprestSurrHeader.No, docNo);
        IF ImprestSurrHeader.FIND('-') THEN BEGIN
            ApprovalMgmtFin.OnSendImprestSurrenderForApproval(ImprestSurrHeader);
            msg := true;
        end;
    end;

    procedure GetImprestAccountNo(username: Code[30]) Message: Text
    begin
        HRMEmployeeD.Reset();
        HRMEmployeeD.SETRANGE("No.", username);
        IF HRMEmployeeD.FIND('+') THEN BEGIN
            Message := HRMEmployeeD."Customer Acc";
        END
    end;

    procedure FnImpSurrAttachement(retNo: Code[50]; fileName: Text; attachment: BigText; tableId: Integer) return_value: Boolean
    var
        DocAttachment: Record "Document Attachment";
        FromRecRef: RecordRef;
        FileManagement: Codeunit "File Management";
        Bytes: dotnet Array;
        Convert: dotnet Convert;
        MemoryStream: dotnet MemoryStream;
        Ostream: OutStream;
        tableFound: Boolean;
        ObjAppliRec: Record "FIN-Imprest Surr. Header";

    begin

        tableFound := false;
        return_value := false;
        if TableID = Database::"FIN-Imprest Surr. Header" then begin
            ObjAppliRec.RESET;
            ObjAppliRec.SETRANGE(ObjAppliRec.No, retNo);
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
    //Part Time Claims
    procedure GetSemesters() Message: Text
    begin
        CurrentSem.Reset();
        IF CurrentSem.FIND('-') THEN BEGIN
            REPEAT
                Message += CurrentSem.Code + '::';
            UNTIL CurrentSem.NEXT = 0;
        END
    end;

    procedure GetPartTimeClaims(username: Code[30]) Message: Text
    begin
        PartTimeClaimHd.Reset();
        PartTimeClaimHd.SETRANGE(PartTimeClaimHd."Account No.", username);
        IF PartTimeClaimHd.FIND('-') THEN BEGIN
            REPEAT
                Message += PartTimeClaimHd."No." + ' ::' + PartTimeClaimHd.Semester + ' ::' + PartTimeClaimHd.Purpose + ' ::' + FORMAT(PartTimeClaimHd.Status) + ' :::';
            UNTIL PartTimeClaimHd.NEXT = 0;
        END
    end;

    procedure AddPartTimeClaimLine(claimno: code[20]; progcode: code[20]; unitcode: code[20]; invigilationdone: Boolean) added: Boolean
    var
        lineNo: integer;
    begin
        PartTimeClaimHd.Reset();
        PartTimeClaimHd.SETRANGE(PartTimeClaimHd."No.", claimno);
        IF PartTimeClaimHd.FIND('-') THEN BEGIN
            ACALecturersUnits.Reset();
            ACALecturersUnits.SetRange(ACALecturersUnits.Lecturer, PartTimeClaimHd."Account No.");
            ACALecturersUnits.SetRange(ACALecturersUnits.Unit, unitcode);
            ACALecturersUnits.SetRange(ACALecturersUnits.Semester, PartTimeClaimHd.Semester);
            if ACALecturersUnits.find('-') then begin
                REPEAT
                    PartTimeClaimLn.reset();
                    IF PartTimeClaimLn.FIND('+') THEN
                        lineNo := PartTimeClaimLn."Line No." + 1
                    ELSE
                        lineNo := 1;
                    PartTimeClaimLn.Init();
                    PartTimeClaimLn.Unit := unitcode;
                    PartTimeClaimLn."Line No." := lineNo;
                    PartTimeClaimLn."Document No." := PartTimeClaimHd."No.";
                    PartTimeClaimLn.Semester := PartTimeClaimHd.Semester;
                    // PartTimeClaimLn."Mode OF Study" := ACALecturersUnits.ModeOfStudy;
                    // PartTimeClaimLn.Stream := ACALecturersUnits.Stream;
                    PartTimeClaimLn."Academic Year" := PartTimeClaimHd."Academic Year";
                    PartTimeClaimLn."Lecture No." := PartTimeClaimHd."Account No.";
                    Programme.Reset();
                    Programme.SetRange(Programme.Code, progcode);
                    if Programme.find('-') then begin
                        PartTimeClaimLn.Programme := Programme.Code;
                        PartTimeClaimLn."Programme Description" := Programme.Description;
                    end;
                    UnitSubjects.Reset;
                    unitsubjects.SetRange("Programme Code", progcode);
                    unitsubjects.SetRange(Code, unitcode);
                    if UnitSubjects.Find('-') then begin
                        PartTimeClaimLn."Unit Description" := unitsubjects.Desription;
                    end;
                    PartTimeClaimLn."Invigillation Done" := invigilationdone;
                    PartTimeClaimLn.Validate(Programme);
                    PartTimeClaimLn.Validate(Unit);
                    PartTimeClaimLn.Validate("Invigillation Done");
                    PartTimeClaimLn.Insert();
                until ACALecturersUnits.Next = 0;
                added := TRUE;
            end;
        END;
    END;

    procedure GetPartTimeClaimLecDetails(clmNo: Code[20]) msg: Text
    begin
        PartTimeClaimHd.Reset();
        PartTimeClaimHd.SETRANGE(PartTimeClaimHd."No.", clmNo);
        IF PartTimeClaimHd.FIND('-') THEN BEGIN
            msg := PartTimeClaimHd."Account No." + '-' + PartTimeClaimHd.payee;
        END;
    end;

    procedure GetPartTimeClaimLines(claimno: code[20]) Message: Text
    begin
        PartTimeClaimLn.reset();
        PartTimeClaimLn.SETRANGE(PartTimeClaimLn."Document No.", claimno);
        IF PartTimeClaimLn.FIND('-') THEN begin
            repeat
                UnitSubjects.Reset;
                unitsubjects.SetRange("Programme Code", PartTimeClaimLn.Programme);
                unitsubjects.SetRange(Code, PartTimeClaimLn.Unit);
                if UnitSubjects.Find('-') then begin
                    Message += FORMAT(PartTimeClaimLn."Line No.") + '::' + PartTimeClaimLn."Academic Year" + '::' + PartTimeClaimLn."Semester" + '::' + PartTimeClaimLn."Programme Description" + '::' + UnitSubjects.Desription + ' ::' + FORMAT(PartTimeClaimLn.Amount) + ':::';//+ PartTimeClaimLn."Mode OF Study" + ' ::' + PartTimeClaimLn.Stream + 
                end;
            UNTIL PartTimeClaimLn.Next = 0;
        end;
    END;

    procedure DeletePartTimeClaimLine(claimno: code[20]; lineno: integer) deleted: boolean
    begin
        PartTimeClaimLn.reset();
        PartTimeClaimLn.SETRANGE(PartTimeClaimLn."Document No.", claimno);
        PartTimeClaimLn.SETRANGE(PartTimeClaimLn."Line No.", lineno);
        IF PartTimeClaimLn.FIND('-') THEN begin
            PartTimeClaimLn.Delete();
            DELETED := true;
        end;
    END;

    procedure GetLecturerUnits(lectno: code[20]; progcode: code[20]; sem: code[20]) Message: Text
    begin
        ACALecturersUnits.Reset();
        ACALecturersUnits.SetRange(ACALecturersUnits.Lecturer, lectno);
        ACALecturersUnits.SetRange(ACALecturersUnits.Programme, progcode);
        ACALecturersUnits.SetRange(ACALecturersUnits.Semester, sem);
        if ACALecturersUnits.find('-') then begin
            repeat
                PartTimeClaimLn.Reset;
                PartTimeClaimLn.SetRange("Lecture No.", ACALecturersUnits.Lecturer);
                PartTimeClaimLn.SetRange(Unit, ACALecturersUnits.Unit);
                PartTimeClaimLn.SetRange(Programme, ACALecturersUnits.Programme);
                PartTimeClaimLn.SetRange(Semester, ACALecturersUnits.Semester);
                if NOT PartTimeClaimLn.FIND('-') Then begin
                    Message += ACALecturersUnits.Unit + '::' + ACALecturersUnits.Description + ':::';
                end;
            until ACALecturersUnits.next = 0;
        end;
    END;

    procedure CreatePartTimeClaim(username: Code[30]; sem: Code[20]; purpose: Text) Message: Text
    Var
        ClaimNo: Text;
        GenLedgerSetup: Record "Cash Office Setup";
        GLAcc: Record "G/L Account";
        tcodes: Record "FIN-Tariff Codes";
    begin
        ClaimNo := NoSeriesMgt.GetNextNo('CLAIM', 0D, TRUE);
        PartTimeClaimHd.Init();
        EmployeeCard.Reset;
        EmployeeCard.SETRANGE("No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            PartTimeClaimHd."No." := ClaimNo;
            PartTimeClaimHd."Account No." := EmployeeCard."No.";
            PartTimeClaimHd."Global Dimension 1 Code" := EmployeeCard.Campus;
            PartTimeClaimHd."Global Dimension 2 Code" := EmployeeCard."Department Code";
            PartTimeClaimHd.payee := EmployeeCard."Full Name";
            PartTimeClaimHd.Date := Today;
            PartTimeClaimHd.Semester := sem;
            PartTimeClaimHd.Purpose := purpose;
            PartTimeClaimHd."Main Bank" := EmployeeCard."Main Bank";
            PartTimeClaimHd."Branch Bank" := EmployeeCard."Branch Bank";
            PartTimeClaimHd."Bank Account No." := EmployeeCard."Bank Account Number";
            banks.Reset();
            banks.SetRange("Bank Code", EmployeeCard."Main Bank");
            banks.SetRange("Branch Code", EmployeeCard."Branch Bank");
            if banks.Find('-') then begin
                PartTimeClaimHd."Main Bank Name" := banks."Bank Name";
                PartTimeClaimHd."Branch Bank Name" := banks."Branch Name";
            end;
            CurrentSem.Reset();
            CurrentSem.SETRANGE(CurrentSem.Code, sem);
            IF CurrentSem.FIND('-') THEN BEGIN
                PartTimeClaimHd."Academic Year" := CurrentSem."Academic Year";
                PartTimeClaimHd."Semester Start Date" := CurrentSem.From;
                PartTimeClaimHd."Semester End Date" := CurrentSem."To";
            END;
            GenLedgerSetup.Reset;
            GenLedgerSetup.SetRange("Primary Key", '1');
            if GenLedgerSetup.Find('-') then begin
                PartTimeClaimHd."Expense AC" := GenLedgerSetup."Parttimers Expense Account";
                PartTimeClaimHd."Payee Code" := GenLedgerSetup."Parttime payee code";
                GLAcc.Reset();
                GLAcc.SetRange("No.", GenLedgerSetup."Parttimers Expense Account");
                if GLAcc.Find('-') then
                    PartTimeClaimHd."Expense Ac Name" := GLAcc.Name;
                tcodes.Reset();
                tcodes.SetRange(Code, GenLedgerSetup."Parttime payee code");
                if tcodes.Find('-') then begin
                    PartTimeClaimHd."Payee AC" := tcodes."G/L Account";
                    PartTimeClaimHd."Payee Rates" := tcodes.Percentage;
                end;
            end;
            PartTimeClaimHd.Insert();
            message := ClaimNo;
        END
    end;

    procedure CheckPartTimeLine(appno: Code[20]) exists: Boolean
    begin
        PartTimeClaimLn.Reset();
        PartTimeClaimLn.SETRANGE("Document No.", appno);
        IF PartTimeClaimLn.FIND('-') THEN BEGIN
            exists := true;
        END
    end;

    procedure CheckPartTimeApproval(appno: Code[20]) exists: Boolean
    begin
        ApprovalEntry.Reset();
        ApprovalEntry.SETRANGE("Document No.", appno);
        IF ApprovalEntry.FIND('-') THEN BEGIN
            exists := true;
        END
    end;

    procedure GetBanks() Msg: Text
    begin
        banks.reset;
        banks.setfilter("Bank Name", '<>%1', '');
        banks.SETCURRENTKEY("Bank Name");
        IF banks.FIND('-') THEN
            REPEAT
                banks.SETRANGE("Bank Code", banks."Bank Code");
                banks.FIND('+');
                banks.SETRANGE("Bank Code");
                Msg += banks."Bank Code" + '::' + banks."Bank Name" + ':::';
            UNTIL banks.NEXT = 0;
    end;

    procedure GetBankBranches(bankcode: Code[10]) Msg: Text
    begin
        banks.reset;
        banks.SETCURRENTKEY("Branch Name");
        banks.SETRANGE("Bank Code", bankcode);
        IF banks.FIND('-') THEN
            REPEAT
                Msg += banks."Branch Code" + '::' + banks."Branch Name" + ':::';
            UNTIL banks.NEXT = 0;
    end;

    procedure GetPartTimeLecturerUnits(lectno: code[20]; progcode: code[20]; sem: code[20]) Message: Text
    begin
        ACALecturersUnits.Reset();
        ACALecturersUnits.SetRange(ACALecturersUnits.Lecturer, lectno);
        ACALecturersUnits.SetRange(ACALecturersUnits.Programme, progcode);
        ACALecturersUnits.SetRange(ACALecturersUnits.Semester, sem);
        //ACALecturersUnits.SetRange(ACALecturersUnits."Unit Type", ACALecturersUnits."Unit Type"::"Part-Time");
        if ACALecturersUnits.find('-') then begin
            repeat
                PartTimeClaimLn.Reset;
                PartTimeClaimLn.SetRange("Lecture No.", ACALecturersUnits.Lecturer);
                PartTimeClaimLn.SetRange(Unit, ACALecturersUnits.Unit);
                PartTimeClaimLn.SetRange(Programme, ACALecturersUnits.Programme);
                PartTimeClaimLn.SetRange(Semester, ACALecturersUnits.Semester);
                if NOT PartTimeClaimLn.FIND('-') Then begin
                    UnitSubjects.Reset;
                    unitsubjects.SetRange("Programme Code", progcode);
                    unitsubjects.SetRange(Code, ACALecturersUnits.Unit);
                    if UnitSubjects.Find('-') then begin
                        Message += ACALecturersUnits.Unit + '::' + ACALecturersUnits.Unit + '-' + unitsubjects.Desription + ':::';
                    end;
                end;
            until ACALecturersUnits.next = 0;
        end;
    END;

    procedure PartTimeApprovalRequest(ReqNo: Code[20])
    var
        Approvalmgt: codeunit "Workflow Initialization";

    begin
        PartTimeClaimHd.Reset();
        PartTimeClaimHd.SETRANGE("No.", ReqNo);
        IF PartTimeClaimHd.FIND('-')
        THEN BEGIN
            if Approvalmgt.IsParttimeClaimEnabled(PartTimeClaimHd) = true then begin
                //PartTimeClaimHd.CommitBudget();
                Approvalmgt.OnSendParttimeClaimforApproval(PartTimeClaimHd);
            end
        END;
    end;

    procedure SubmitStaffIssue(stdNo: Code[20]; issue: Text) submitted: Boolean
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

    procedure GetMyIssuesList(staffNo: Code[20]) msg: Text
    begin
        stdissues.Reset;
        stdissues.SetCurrentKey(lineNo);
        stdissues.Ascending(false);
        stdissues.SetRange(Client, staffNo);
        if stdissues.find('-') then begin
            repeat
                msg += stdissues."Issue Raised" + ' ::' + FORMAT(stdissues.DateRaised) + ' ::' + FORMAT(stdissues.Status) + ' :::';
            until stdissues.Next = 0;
        end
    end;

    procedure SendEmail(degree: Code[20]; appNo: Code[20])
    var
        salutation: Text[50];
        FileMgt: Codeunit "File Management";
        hrEmp: Record "HRM-Employee (D)";
        progName: Record "ACA-Programme";
        progLeader: text;
        mail: Text;
        EmailBody: Text;
        EmailSubject: Text;
        SendMail: Codeunit "Email Message";
        emailObj: Codeunit Email;
    begin

        Clear(EmailBody);
        Clear(EmailSubject);
        Clear(mail);

        progName.Reset();
        progName.SetRange(Code, degree);
        if progName.Find('-') then begin
            //progLeader := progName."Program Leader";
            hrEmp.Reset();
            hrEmp.SetRange(IsDean, true);
            hrEmp.SetRange("Faculty Code", progName.Faculty);
            if hrEmp.Find('-') then begin
                if hrEmp."CUEA Email Address" = '' then begin
                    Error('Dean Must have E-mail')
                end else begin
                    mail := hrEmp."CUEA Email Address";
                    EmailBody := 'Hello,' + ' ' + hrEmp."First Name" + ' ' + 'Kindly Log into your staff portal and check Application No.' + ' ' + appNo + ' ' + 'that requires your Approval.' + 'This Is a system Generated Email. DO NOT REPLY!!';
                    EmailSubject := 'ADMISSIONS APPROVAL ALERT';
                    SendMail.Create(mail, EmailSubject, EmailBody);
                    emailObj.Send(SendMail, Enum::"Email Scenario"::Notification);
                end;

            end;
        end;





        //Dialogie.Open('Sending to #1  ');





        // Dialogie.Update(1, kuccpsImport.Names);


        //Dialogie.Close();



    end;

    procedure GetStaffFacultyAndDepartment(staffNo: Code[20]) msg: Text
    var
        Dimensions: Record "Dimension Value";
    begin
        HRMEmployeeD.Reset;
        HRMEmployeeD.SetRange("No.", staffNo);
        if HRMEmployeeD.Find('-') then begin
            Dimensions.Reset;
            Dimensions.SetRange("Global Dimension No.", 3);
            Dimensions.SetRange(Code, HRMEmployeeD."Faculty Code");
            if Dimensions.Find('-') then begin
                msg := Dimensions.Name + ' :: ' + HRMEmployeeD."Department Name";
            end
            ;
        end
    end;
}



