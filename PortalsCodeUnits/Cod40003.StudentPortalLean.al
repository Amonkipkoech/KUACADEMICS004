codeunit 40003 StudentPortalTest
{
    var
        CourseRegistration: Record "ACA-Course Registration";
        examAttendance: Record "ACA-Exam Attendance Register";
        studentUnits: Record "ACA-Student Units";
        Customer: Record "Customer";
        KUCCPSRaw: Record "KUCCPS Imports";
        "Fee By Stage": Record "ACA-Fee By Unit";
        AdmissionFormHeader: Record "ACA-Applic. Form Header";
        group: Record "GroupAssignments";
        offeredunits: Record "ACA-Units Offered";
        days: Record "TT-Days";
        timeslots: Record "TT-Daily Lessons";
        lecturehalls: Record "ACA-Lecturer Halls Setup";
        lecturers: Record "ACA-Lecturers Units";
        associatedunits: Record acaAssosiateUnits;
        settlementtypes: Record "ACA-Settlement Type";
        stdissues: Record studentIssues;
        AttendanceDetails: Record "Class Attendance Details";
        unitsOnOffer: Record "ACA-Units Offered";
        clinicals: Record "Clinical rotation";
        NoSeriesMgt: Codeunit 396;
        counties: Record County;
        studymodes: Record "ACA-Student Types";
        relationships: Record Relative;
        discontinue: Record "defferedStudents";
        CurrentSem: Record "ACA-Semesters";
        UnitSubjects: Record "ACA-Units/Subjects";
        EmployeeCard: Record 61188;
        marketingstrategies: Record "ACA-Marketing Strategies";
        intakes: Record "ACA-Intake";
        ethnicity: Record "HRM-Ethnicity";
        LecEvaluation: Record "ACA-Lecturers Evaluation";
        Stages: Record "ACA-Programme Stages";
        Programme: Record "ACA-Programme";
        Receiptz: Record "ACA-Receipt";
        GenSetup: Record "ACA-General Set-Up";
        StudCharges: Record "ACA-Std Charges";
        AcademicYr: Record "ACA-Academic Year";
        OnlineUsersz: Record OnlineUsers;
        LedgerEntries: Record "Detailed Cust. Ledg. Entry";
        StudentUnitBaskets: Record "ACA-Student Units Reservour";
        CourseReg1: Record "ACA-EXAM. Course Registration";
        ClearanceHeader: Record "ACA-Clearance Header";
        AdminSetup: Record "ACA-Adm. Number Setup";
        semesters: Record "ACA-Programme Semesters";
        Programmeetups: Record "Programme Setups";
        centralsetup: Record "ACA-Academics Central Setups";
        campus: Record "Dimension Value";
        religions: Record "ACA-Religions";
        xyForm: Record "ACA-XY-FORM";
        AcaSpecialExamsDetails: Record "Aca-Special Exams Details";


        FILESPATH: Label 'C:\inetpub\wwwroot\KUPORTALS\StudentPortal\Downloads\';
        FILESPATH_A: Label 'C:\inetpub\wwwroot\KUPORTALS\StaffPortal\Downloads';//'C:\inetpub\wwwroot\StaffPortal\Downloads\';
        FILESPATH_SSP: Label 'C:\inetpub\wwwroot\KUPORTALS\StaffPortal\Downloads';//'C:\inetpub\wwwroot\StaffPortal\Downloads\';
        FILESPATH_APP: Label 'C:\inetpub\wwwroot\KUPORTALS\ApplicationsPortal\Documents\';


    procedure GetExamCard(StudentNo: Text; prog: Text; Sem: Code[20]; filenameFromApp: Text) Message: Text
    var
        filename: Text;
        reportResult: Boolean;
    begin
        filename := FILESPATH + filenameFromApp;

        // Check if the file already exists, if so, delete it
        IF EXISTS(filename) THEN
            ERASE(filename);

        // Set filters for attendance to check if attendance records are filled
        examAttendance.Reset();
        examAttendance.SetRange(examAttendance."Student No.", StudentNo);
        examAttendance.SetRange(examAttendance."Programme Code", prog);
        examAttendance.SetRange(examAttendance."Semester Code", Sem);

        // Check if any attendance record exists for this student, program, and semester
        IF examAttendance.Find('-') THEN BEGIN
            // Attendance exists, so proceed to generate the exam card report
            CourseRegistration.RESET();
            CourseRegistration.SETRANGE(CourseRegistration."Student No.", StudentNo);
            CourseRegistration.SETRANGE(CourseRegistration.Semester, Sem);
            // Find the first course registration and generate the report as PDF
            IF CourseRegistration.FINDFIRST THEN BEGIN
                REPORT.SAVEASPDF(report::"Exam Card Final", filename, CourseRegistration);
                Message := 'Exam card generated successfully.';
            END ELSE BEGIN
                // No course registration found
                Message := 'No courses found for the student in the specified semester.';
            END;

        END ELSE BEGIN

            CourseRegistration.RESET();
            CourseRegistration.SETRANGE(CourseRegistration."Student No.", StudentNo);
            CourseRegistration.SETRANGE(CourseRegistration.Semester, Sem);
            if CourseRegistration.FINDFIRST() then begin
                studentUnits.SetRange(studentUnits."Student No.", StudentNo);
                studentUnits.SetRange(studentUnits.Semester, Sem);
                studentUnits.SetRange(studentUnits."Reg. Transacton ID", CourseRegistration."Reg. Transacton ID");
                if studentUnits.FindSet() then begin
                    repeat
                        examAttendance."Programme Code" := prog;
                        examAttendance."Student No." := StudentNo;
                        examAttendance."Unit Code" := studentUnits.Unit;
                        examAttendance."Semester Code" := Sem;
                        examAttendance.Insert();
                    until studentUnits.Next() = 0;

                end;

                IF CourseRegistration.FINDSET THEN BEGIN

                    REPORT.SAVEASPDF(report::"Exam Card Final", filename, CourseRegistration);
                    Message := 'Exam card generated successfully after adding registered courses.';
                END ELSE BEGIN
                    Message := 'No courses registered to add to the exam card.';
                END;

            end;

        END;

        EXIT(Message);
    end;

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

    procedure CheckIsSemPosted(studentNo: Text; Semester: Text): Boolean
    var
        posted: Boolean;

    begin
        posted := false;
        CourseRegistration.Reset();
        CourseRegistration.SetRange(CourseRegistration."Student No.", studentNo);
        CourseRegistration.SetRange(CourseRegistration.Semester, Semester);
        CourseRegistration.SetRange(CourseRegistration.Posted, true);

        If CourseRegistration.Find('-') then begin
            posted := true;
        end;
        Exit(posted);

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

    procedure GetStudentStatus(StudentNo: Text) Message: Text
    begin
        Customer.Reset();
        Customer.SetRange(Customer."No.", StudentNo);
        if Customer.FINDFIRST then begin
            Message := 'SUCCESS' + '::' + Format(Customer.Status);
        end;
        Exit(Message);

    end;

    procedure GenerateStudentProformaInvoice2("StudentNo": Code[20]; filenameFromApp: Text)
    var
        filename: Text;
    begin
        filename := FILESPATH + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        CourseRegistration.RESET;
        CourseRegistration.SETRANGE(CourseRegistration."Student No.", StudentNo);
        IF CourseRegistration.FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(Report::"Student Proforma Invoice2", filename, CourseRegistration);
        END;
    end;

    procedure GetClinicalShedule(StudentNo: Text; currentSem: Text) Message: Text
    begin
        group.Reset();
        group.SetRange(group.StudentNo, StudentNo);
        group.setRange(group.Block, currentSem);

        if group.Find('-') then begin
            clinicals.Reset();
            clinicals.SetRange(clinicals.Group, group.GroupId);
            clinicals.SetRange(clinicals.Block, group.Block);
            if clinicals.Find('-') then begin
                repeat
                    Message += 'SUCCESS' + '::' + clinicals.Group + '::' + Format(clinicals."Starting Date") + '::' + Format(clinicals."Ending Date") + '::' + clinicals.Areas + '::' + Format(clinicals."Assessment Start date") + '::' + Format(clinicals."Assessment End Date") + '[]';
                until clinicals.Next() = 0;

            end
        end;


    end;

    procedure SeenGroup(StudentNo: Text; currentSem: Text) Message: Boolean
    begin
        Message := true;
        group.Reset();
        group.SetRange(group.StudentNo, StudentNo);
        group.setRange(group.Block, currentSem);
        group.setRange(group.Viewed, false);

        if group.FindFirst then begin
            Message := False;
        end;
        exit(Message);

    end;

    procedure IsStudentExempt(StudentNo: Text) Message: Boolean
    begin
        Message := false;
        Customer.Reset();
        Customer.SetRange(Customer."No.", StudentNo);
        Customer.SetRange(Customer."Customer Posting Group", 'STUDENT');
        Customer.SetRange(Customer."Fee Cleared", true);
        if Customer.Find('-') then begin

            Message := true;
        end;
        exit(Message);

    end;

    procedure GetFeePercentage() Message: Text
    begin
        CurrentSem.Reset();
        CurrentSem.SetRange(CurrentSem."Current Semester", true);
        if CurrentSem.FindFirst() then begin
            Message := Format(CurrentSem."Semester Fee Percentage");
        end;

    end;



    procedure GetClassAttendance(studentNo: text; Sem: Text) Message: Text
    begin
        AttendanceDetails.Reset();
        AttendanceDetails.SetRange(AttendanceDetails."Student No.", studentNo);
        AttendanceDetails.setRange(AttendanceDetails.Semester, sem);
        if AttendanceDetails.Find('-') then Begin
            Message += 'SUCCESS' + '::' + AttendanceDetails."Unit Code" + '::' + Format(AttendanceDetails."Attendance Date") + '::' + Format(AttendanceDetails."Present Counting") + '::' + Format(AttendanceDetails."Absent Counting") + '::' + Format(AttendanceDetails.Counting) + ':::';
        End;
    end;

    procedure GetStudentUnits(program: Text) Message: Text
    begin
        UnitSubjects.Reset();
        UnitSubjects.SetRange(UnitSubjects."Programme Code", program);

        if UnitSubjects.Find('-') then begin
            repeat
                Message += 'SUCCESS' + '::' + UnitSubjects.Code + '::' + UnitSubjects.Desription + '[]';
            until UnitSubjects.Next() = 0;
        end;
        exit(Message);

    end;

    procedure UnitsToRegister(progCode: Text) Message: Text
    begin
        unitsOnOffer.Reset();
        unitsOnOffer.SetRange(unitsOnOffer.Semester, CurrentSemester());
        unitsOnOffer.SetRange(unitsOnOffer.Programs, progCode);
        if unitsOnOffer.Find('-') then begin
            repeat
                Message += 'SUCCESS' + '::' + unitsOnOffer."Unit Base Code" + '::' + GetUnitName(unitsOnOffer."Unit Base Code") + '::' + unitsOnOffer.Campus + '::' + GetLectureName(unitsOnOffer.Lecturer) + '::' + unitsOnOffer."Lecture Hall" + '::' + unitsOnOffer.TimeSlot + '::' + unitsOnOffer.Day + '[]';
            until unitsOnOffer.Next = 0;
        end
    end;

    // procedure GetTmetable(progcode:Text)Message:Text
    // begin
    //     unitsOnOffer.Reset();
    //     unitsOnOffer.SetRange(unitsOnOffer.Semester, CurrentSemester());
    //     unitsOnOffer.SetRange(unitsOnOffer.Programme, progCode);
    // end;
    procedure GetStudentFullName(StudentNo: Text) Message: Text
    var
        FullDetails: Integer;
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", StudentNo);
        IF Customer.FIND('-') THEN BEGIN
            Message := Customer."No." + '::' + Customer.Name + '::' + Customer."E-Mail" + '::' + Customer."ID No" + '::' + FORMAT(Customer.Gender) + '::' + FORMAT(Customer."Date Of Birth") + '::' + Customer."Post Code" + '::' + Customer.Address;

        END
    end;

    procedure DiscontinueDeferment(StudentNo: Text; dept: Text; program: Text; stage: text; requestType: Option; startDate: Date; mobileNo: Text; endDate: Date; reason: Option; block: Text; ExtndedReason: Text) Message: Text
    var
        No: Text;
    begin
        No := NoSeriesMgt.GetNextNo('DEF', TODAY, TRUE);

        discontinue.Reset();
        discontinue.SetRange(discontinue.studentNo, StudentNo);
        discontinue.SetRange(discontinue.Semeter, block);

        if discontinue.FindFirst() then begin
            Message := 'You have already initiated a deferment/discontinuation for this block';

        end else begin

            discontinue.Department := dept;
            discontinue.studentNo := StudentNo;
            discontinue.studentName := GetStudentName(StudentNo);
            discontinue."No. Series" := 'DEF';
            discontinue.deffermentReason := ExtndedReason;
            discontinue."Request No" := No;
            discontinue."Reason for Calling off" := reason;
            discontinue."Request Type" := requestType;
            discontinue.Semeter := block;
            discontinue."Deferment  Starting Date" := startDate;
            discontinue."Deferment  End Date" := endDate;
            discontinue.programme := program;
            discontinue.stage := stage;
            discontinue."Mobile No" := mobileNo;

            if discontinue.Insert() then begin
                Message := 'SUCCESS';
            end

        end;

    end;

    procedure GetDeferments(studentNo: Text) Message: Text
    begin
        discontinue.Reset();
        discontinue.SetRange(discontinue.studentNo);
        if discontinue.Find('-') then begin
            repeat
                Message += 'Success' + '::' + Format(discontinue."Deferment  Starting Date") + '::' + Format(discontinue."Deferment  End Date") + '::' + Format(discontinue.status) + '[]';
            until discontinue.Next() = 0;
        end;
    end;

    procedure GetStudentName(StudentNo: Text) Message: Text
    var
        FullDetails: Integer;
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", StudentNo);
        IF Customer.FIND('-') THEN BEGIN
            Message := Customer.Name;
        END
    end;

    procedure CurrentSemester() Message: Text
    begin
        CurrentSem.RESET;
        CurrentSem.SETRANGE("Current Semester", TRUE);
        IF CurrentSem.FIND('-') THEN BEGIN
            Message := CurrentSem.Code;
        END;
    end;

    procedure GetUnitName(unitCode: Text) Name: Text
    begin
        UnitSubjects.Reset();
        UnitSubjects.setRange(UnitSubjects.Code, unitCode);
        if UnitSubjects.FindFirst() then begin
            Name := UnitSubjects.Desription;
        end;
        Exit(Name);
    end;


    procedure GetLectureName(number: Text) Name: Text
    begin
        EmployeeCard.Reset();
        EmployeeCard.SetRange(EmployeeCard."No.", number);
        if EmployeeCard.FindFirst() then begin
            Name := EmployeeCard."First Name" + ' ' + EmployeeCard."Last Name";
        end;
        exit(Name);
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

    procedure CheckValidOnlineUserzEmail(email: Text) Msg: Text
    begin
        OnlineUsersz.Reset();
        OnlineUsersz.SetRange(OnlineUsersz."Email Address", email);
        if OnlineUsersz.Find('-') then begin
            Msg := 'Yes::' + OnlineUsersz.Password;
        end;
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
        UnitSubjects.RESET;
        UnitSubjects.SETRANGE("Programme Code", ProgCode);
        UnitSubjects.SETRANGE("Stage Code", StageCode);
        UnitSubjects.SETRANGE("Time Table", TRUE);
        UnitSubjects.SETRANGE("Old Unit", FALSE);
        IF UnitSubjects.FIND('-') THEN BEGIN
            Message := UnitSubjects.Code + '::' + UnitSubjects.Desription;
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

    procedure GetStudentGender(username: Text) Message: Text
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", username);
        IF Customer.FIND('-') THEN BEGIN
            Message := FORMAT(Customer.Gender);
        END;
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

    procedure GetCurrentAcademicYear() Message: Text
    begin
        AcademicYr.RESET;
        AcademicYr.SETRANGE(Current, TRUE);
        IF AcademicYr.FIND('-') THEN BEGIN
            Message := AcademicYr.Code;
        END;
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

    procedure ApplyForSpecial(StudentNo: Text; AcademicYr: Text; Sem: Text; Stage: Text; prog: Text; unitCode: text; currentSem: Text; currentACyr: text) Message: Text
    var

    begin
        AcaSpecialExamsDetails.Reset();
        AcaSpecialExamsDetails.SetRange(AcaSpecialExamsDetails.Programme, prog);
        AcaSpecialExamsDetails.SetRange(AcaSpecialExamsDetails."Student No.", StudentNo);
        AcaSpecialExamsDetails.SetRange(AcaSpecialExamsDetails."Unit Code", unitCode);
        if AcaSpecialExamsDetails.FindFirst() then begin
            Message := 'You Have already submitted request for this unit';

        end else begin
            AcaSpecialExamsDetails."Academic Year" := AcademicYr;
            AcaSpecialExamsDetails.Semester := Sem;
            AcaSpecialExamsDetails."Student No." := StudentNo;
            AcaSpecialExamsDetails."Unit Code" := unitCode;
            AcaSpecialExamsDetails."Unit Description" := GetUnitName(unitCode);
            AcaSpecialExamsDetails.Stage := Stage;
            AcaSpecialExamsDetails."Current Academic Year" := currentACyr;
            AcaSpecialExamsDetails."Current Semester" := currentSem;
            AcaSpecialExamsDetails.Programme := prog;

            if AcaSpecialExamsDetails.Insert() then begin
                Message := 'SUCCESS';
            end;
            exit(Message);

        end;

    end;

    procedure GetSpecialExams(StudentNo: Text; currentSem: Text; currentAcyr: Text) Message: Text
    begin
        AcaSpecialExamsDetails.SetRange(AcaSpecialExamsDetails."Student No.", StudentNo);
        AcaSpecialExamsDetails.Reset();
        AcaSpecialExamsDetails.SetRange(AcaSpecialExamsDetails."Current Academic Year", currentAcyr);
        AcaSpecialExamsDetails.SetRange(AcaSpecialExamsDetails."Current Semester", currentSem);

        if AcaSpecialExamsDetails.Find('-') then begin
            repeat
                Message += 'SUCCESS' + '::' + AcaSpecialExamsDetails."Unit Code" + '::' + AcaSpecialExamsDetails."Unit Description" + '::' + Format(AcaSpecialExamsDetails.Status) + '[]';
            until AcaSpecialExamsDetails.Next() = 0;

        end else begin
            Message := 'ERROR';
        end;
        exit(Message);

    end;

    procedure FillXYForm(studentNo: Text; AcademicYr: Text; Program: Text; UnitCode: Text; date: Date; Time: Text; Duration: text; Coverage: Text) Message: Text
    var
        formId: Text;
    begin
        formId := NoSeriesMgt.GetNextNo('XYFORM', TODAY, TRUE);
        xyForm.Reset();
        xyForm.SetRange(xyForm.UnitCode, UnitCode);
        xyForm.SetRange(xyForm.StudentNo, studentNo);
        if xyForm.FindFirst() then begin
            Message := 'You have already filled in the form!';
        end else begin
            xyForm.StudentNo := studentNo;
            xyForm."Student Name" := GetStudentName(studentNo);
            xyForm.Date := date;
            xyForm.Duration := Duration;
            xyForm.Coverage := Coverage;
            xyForm.AcademicYr := AcademicYr;
            xyForm.Program := Program;
            xyForm.UnitCode := UnitCode;
            xyForm."Unit Description" := GetUnitName(UnitCode);
            xyForm."Form Id" := formId;


            if xyForm.Insert() then begin
                Message := 'SUCCESS';
            end else begin
                Message := 'Error';
            end;
            exit(Message);

        end;
        ;

    end;
    // procedure GetStudentName(StudentNo: Text) Message: Text
    // var
    //     FullDetails: Integer;
    // begin
    //     Customer.RESET;
    //     Customer.SETRANGE(Customer."No.", StudentNo);
    //     IF Customer.FIND('-') THEN BEGIN
    //         Message := Customer.Name;
    //     END
    // end;

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


    procedure IsUnitRegistered(unitCode: Text; studentNo: Text; semester: Text) message: Boolean
    begin

        studentUnits.Reset();
        StudentUnits.SetRange(StudentUnits."Student No.", studentNo);
        StudentUnits.SetRange(StudentUnits.Unit, unitcode);
        StudentUnits.SetRange(StudentUnits."Semester Registered");
        if StudentUnits.FIND('-') then begin
            message := true;
        end else
            message := false;
        exit(message);
    end;

    procedure DeleteUnit(unitCode: Text; stage: Text; studentNo: Text; programme: Text) Message: Text

    begin
        StudentUnits.Reset();
        StudentUnits.SetRange("Student No.", studentNo);
        StudentUnits.SetRange(stage, stage);
        StudentUnits.SetRange("Unit", unitCode);
        StudentUnits.SetRange("Programme", programme);

        if StudentUnits.Find('-') then begin
            StudentUnits.Delete();
            Message := 'SUCCESS';
        end else begin
            Message := 'Unit not found';
        end;
    end;


    procedure PreRegisterStudents2(studentNo: Text; stage: Text; semester: Text; Programme: Text; AcademicYear: Text; settlementType: Text; ProgrammeOption: Code[20]) CourseRegId: Code[30]
    var
        Progs: Code[20];
    begin
        GenSetup.GET;
        CLEAR(Progs);
        IF EVALUATE(Progs, Programme) THEN;
        CourseRegistration.RESET;
        CourseRegistration.SETRANGE(CourseRegistration."Student No.", studentNo);
        CourseRegistration.SETRANGE(CourseRegistration.Programmes, Progs);
        CourseRegistration.SETRANGE(CourseRegistration.Semester, semester);
        CourseRegistration.SETRANGE(CourseRegistration.Reversed, FALSE);

        IF CourseRegistration.FIND('-') THEN
            ERROR('You have already registered for Semester %1, Year %2', semester, CourseRegistration.Stage);

        CourseRegistration.INIT;
        CourseRegId := NoSeriesMgt.GetNextNo(GenSetup."Registration Nos.", TODAY, TRUE);
        CourseRegistration."Reg. Transacton ID" := CourseRegId;
        CourseRegistration."Student No." := studentNo;
        CourseRegistration.Options := ProgrammeOption;
        CourseRegistration.Programmes := Progs;
        CourseRegistration.VALIDATE(Programmes);
        CourseRegistration.Stage := stage;
        //CourseRegistration.VALIDATE(Stage);
        //CourseRegistration."Date Registered":=TODAY;
        //CourseRegistration.Semester:=semester;
        //CourseRegistration."Academic Year":=AcademicYear;
        CourseRegistration.VALIDATE("Settlement Type", settlementType);
        CourseRegistration.INSERT(TRUE);
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
        AdmissionFormHeader.RESET;
        AdmissionFormHeader.SETRANGE(AdmissionFormHeader."Index Number", index);
        IF AdmissionFormHeader.FIND('-') THEN BEGIN
            if AdmissionFormHeader."Settlement Type" = '4YR-HEF' then begin
                REPORT.SAVEASPDF(66680, filename, AdmissionFormHeader);
            end else begin
                REPORT.SAVEASPDF(report::"Bachelors Admission Letter", filename, AdmissionFormHeader);
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
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", Username);
        IF Customer.FIND('-') THEN BEGIN
            IF (Customer."Changed Password" = TRUE) THEN BEGIN
                IF (Customer.Password = UserPassword) THEN BEGIN
                    IF (Customer.Status = Customer.Status::Disciplinary) THEN BEGIN
                        Message := 'Your account has been blocked due to disciplinary issues!' + '::'
                    END ELSE BEGIN
                        FullNames := Customer.Name;
                        Message := TXTCorrectDetails + '::' + FORMAT(Customer."Changed Password") + '::' + Customer."No." + '::' + Customer.Name + '::' + FORMAT(Customer.Status);

                    END;
                END ELSE BEGIN
                    Message := TXTIncorrectDetails + '::' + FORMAT(Customer."Changed Password");
                END
            END ELSE BEGIN
                IF (Customer."ID No" = UserPassword) THEN BEGIN
                    Message := TXTCorrectDetails + '::' + FORMAT(Customer."Changed Password") + '::' + Customer."No." + '::' + Customer.Name + '::' + FORMAT(Customer.Status);
                END ELSE BEGIN
                    Message := TXTIncorrectDetails + '::' + FORMAT(Customer."Changed Password");
                END
            END
        END ELSE BEGIN
            Message := TXTIncorrectDetails + '::' + FORMAT(Customer.Status);
        END

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

    procedure GetFees(StudentNo: Text) Message: Text
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", StudentNo);
        IF Customer.FIND('-') THEN BEGIN
            Customer.CALCFIELDS("Debit Amount", "Credit Amount", Balance);
            Message := FORMAT(Customer."Debit Amount") + '::' + FORMAT(Customer."Credit Amount") + '::' + FORMAT(Customer.Balance);

        END
    end;

    procedure GetStudentCampus(username: Text) Message: Text
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", username);
        IF Customer.FIND('-') THEN BEGIN
            Message := Customer."Global Dimension 1 Code";

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

    procedure UpdateStudentProfile(username: Text; genderz: Integer; DoB: Date; Countyz: Text; Tribes: Text; Disabled: Integer)
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", username);
        IF Customer.FIND('-') THEN BEGIN
            Customer.Gender := genderz;
            Customer."Date Of Birth" := DoB;
            Customer.County := Countyz;
            Customer.Tribe := Tribes;
            Customer."Disability Status" := Disabled;
            Customer.MODIFY;
            MESSAGE('Updated Successfully');
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
            REPORT.SAVEASPDF(report::"Provisional College Transcript", filename, CourseReg1);
        END;
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

    procedure GetRegisteredUnits(studentNo: Text; stage: Text; semester: Text; Programme: Text) Message: Text
    begin
        StudentUnits.Reset();
        StudentUnits.SetRange(StudentUnits."Student No.", studentNo);
        StudentUnits.SetRange(StudentUnits.stage, stage);
        StudentUnits.SetRange(StudentUnits.Semester, semester);
        StudentUnits.SetRange(StudentUnits.Programme, Programme);
        if StudentUnits.FIND('-') THEN BEGIN
            repeat

                Message += StudentUnits.Unit + '::' + StudentUnits."Unit Description" + '[]';

            until StudentUnits.NEXT = 0;

        END;
        exit(Message);
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

    procedure SubmitForClearance(username: Text; Programmm: Text) Message: Text
    var
        NextJobapplicationNo: Text;
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

    procedure ApplyClinicalAbscence(StudentNo: Text; DateFro: Date; DateTo: Date; Reason: Option; DetailedReason: Text; Prog: Text) Message: Text
    var
        clinicalAbs: Record "Student Absence Request";
    begin
        clinicalAbs.Reset();
        clinicalAbs."Admission Number" := StudentNo;
        clinicalAbs."Date From" := DateFro;
        clinicalAbs."Date To" := DateTo;
        clinicalAbs."Reason for Absence" := Reason;
        clinicalAbs."Other Reason (Specify)" := DetailedReason;
        clinicalAbs."Student Name" := GetStudentName(StudentNo);

        if clinicalAbs.Insert() then begin
            Message := 'SUCCESS';

        end;
        exit(Message);

    end;


    procedure GetUniversityMailPass(username: Text) Message: Text
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", username);
        IF Customer.FIND('-') THEN BEGIN
            Message := Customer."University Email" + '::' + Customer."Email Password" + '::' + Customer."Phone No.";

        END
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

    procedure KuccpsProfileUpdated(username: Text) Message: Text
    begin
        KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(KUCCPSRaw.Index, username);
        IF KUCCPSRaw.FIND('-') THEN BEGIN
            Message := FORMAT(KUCCPSRaw.Updated);
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

    procedure GetSSDetails(username: text) Message: Text
    begin
        OnlineUsersz.RESET;
        OnlineUsersz.SETRANGE(OnlineUsersz."Email Address", username);
        IF OnlineUsersz.FIND('-') THEN BEGIN
            Message := OnlineUsersz."First Name" + ' ::' + OnlineUsersz."Middle Name" + ' ::' + OnlineUsersz."Last Name" + ' ::' + OnlineUsersz."Phone No" + ' ::' + FORMAT(OnlineUsersz.Gender) + ' ::';
        END;
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

    procedure GenerateAdmnNo(username: Text) admNo: Text
    var
        NewAdminCode: Text;
    begin
        AdmissionFormHeader.RESET;
        AdmissionFormHeader.SETRANGE(AdmissionFormHeader."Index Number", username);
        IF AdmissionFormHeader.FIND('-') THEN BEGIN
            AdminSetup.RESET;
            AdminSetup.SETRANGE(AdminSetup.Degree, AdmissionFormHeader."First Degree Choice");
            IF AdminSetup.FIND('-') THEN BEGIN
                NewAdminCode := NoSeriesMgt.GetNextNo(AdminSetup."No. Series", TODAY, TRUE);
                AdmissionFormHeader."Admission No" := NewAdminCode;
                AdmissionFormHeader.MODIFY;

                KUCCPSRaw.Reset();
                KUCCPSRaw.SETRANGE(Index, username);
                IF KUCCPSRaw.FIND('-') THEN BEGIN
                    KUCCPSRaw.Admin := NewAdminCode;
                    KUCCPSRaw.MODIFY;
                END;
                admNo := NewAdminCode;
            END ELSE BEGIN
                ERROR('The Admission Number Setup For Programme ' + FORMAT(AdmissionFormHeader."Admitted Degree") + ' Does Not Exist');
            END;
            MESSAGE('Admission number generated successfully!');
        end;
    END;

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

    procedure CheckValidOnlineAccount(username: Text) Message: Boolean
    begin
        OnlineUsersz.RESET;
        OnlineUsersz.SETRANGE(OnlineUsersz."Email Address", username);
        IF OnlineUsersz.FIND('-') THEN BEGIN
            Message := true;
        END
    end;

    procedure CheckOnlineLogin(username: Text; passrd: Text) Message: Text
    var
        TXTIncorrectDetails: Label 'Incorrect Username or Password';
        TXTCorrectDetails: Label 'Login';
        FullNames: Text;
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

    procedure CheckOnlineAccountStatus(username: Text) Message: Text
    begin
        OnlineUsersz.RESET;
        OnlineUsersz.SETRANGE(OnlineUsersz."Email Address", username);
        IF OnlineUsersz.FIND('-') THEN BEGIN
            Message := FORMAT(OnlineUsersz.Confirmed);
        END
    end;

    procedure GetMyApplications(username: Text) apps: Text
    var
        progname: Text;
    begin
        AdmissionFormHeader.RESET;
        AdmissionFormHeader.SETRANGE(AdmissionFormHeader.Email, username);
        IF AdmissionFormHeader.FIND('-') THEN BEGIN
            REPEAT
                Programme.RESET;
                Programme.SETRANGE(Programme.Code, AdmissionFormHeader."First Degree Choice");
                IF Programme.FIND('-') THEN BEGIN
                    progname := Programme.Description;
                END;
                apps := apps + AdmissionFormHeader."Application No." + ' ::' + progname + ' ::' + FORMAT(AdmissionFormHeader."Application Date") + ' ::' + FORMAT(AdmissionFormHeader.Status) + ' ::' + FORMAT(AdmissionFormHeader."Finance Cleared") + '::' + AdmissionFormHeader.Nationality + ' :::';
            UNTIL AdmissionFormHeader.Next = 0;
        END;
    end;

    procedure GetMyReturnedApplications(username: Text) apps: Text
    var
        progname: Text;
    begin
        AdmissionFormHeader.RESET;
        AdmissionFormHeader.SETRANGE(AdmissionFormHeader.Email, username);
        AdmissionFormHeader.SETRANGE(AdmissionFormHeader.returned, true);
        IF AdmissionFormHeader.FIND('-') THEN BEGIN
            REPEAT
                Programme.RESET;
                Programme.SETRANGE(Programme.Code, AdmissionFormHeader."First Degree Choice");
                IF Programme.FIND('-') THEN BEGIN
                    progname := Programme.Description;
                END;
                apps := apps + AdmissionFormHeader."Application No." + ' ::' + progname + ' ::' + FORMAT(AdmissionFormHeader."Application Date") + ' ::' + FORMAT(AdmissionFormHeader.Status) + ' :::';
            UNTIL AdmissionFormHeader.Next = 0;
        END;
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

        AdmissionFormHeader.RESET;
        AdmissionFormHeader.SETRANGE(AdmissionFormHeader."Application No.", appNo);
        AdmissionFormHeader.SETRANGE(AdmissionFormHeader.Status, AdmissionFormHeader.Status::"Provisional Admission");
        IF AdmissionFormHeader.FIND('-') THEN BEGIN
            recRef.GetTable(AdmissionFormHeader);
            tmpBlob.CreateOutStream(OutStr);
            Report.SaveAs(66679, '', format::Pdf, OutStr, recRef);
            tmpBlob.CreateInStream(InStr);
            txtB64 := cnv64.ToBase64(InStr, true);
            bigtext.AddText(txtB64);
        END;
        EXIT(filename);
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

    procedure UpdateKUCCPSProfile(index: code[20]; fname: text; mmname: text; lname: text; gender: option; dob: Date; nationality: text; county: text; idNo: code[20]; passPort: code[20];
birthCert: code[20]; religion: text; denomination: text; diocese: text; congregation: option; inst: text; protCongregation: Option; maritalStat: Option;
disability: option; disTyp: Option; knewThru: Text; ethnic: Text; phoneNo: Text; altPhoneNo: text; email: Text;
postAddress: Text; town: text; kinName: Text; kinEmail: text; kinPhoneNo: Text; kinRel: Text; fpName: Text; fpmob: text; fpEmail: Text; fpRel: Text;
highSchool: Text; hschF: Date; hschT: Date) Message: Text
    begin
        AdmissionFormHeader.Init;
        AdmissionFormHeader."Application No." := NoSeriesMgt.GetNextNo('APPNO', 0D, TRUE);
        AdmissionFormHeader."First Name" := fname;
        AdmissionFormHeader."Other Names" := mmname;
        AdmissionFormHeader.Surname := lname;
        AdmissionFormHeader."Index Number" := index;
        AdmissionFormHeader.Gender := gender;
        AdmissionFormHeader."Date Of Birth" := dob;
        AdmissionFormHeader.Nationality := Nationality;
        AdmissionFormHeader.County := county;
        AdmissionFormHeader."ID Number" := idNo;
        AdmissionFormHeader."Passport Number" := passPort;
        AdmissionFormHeader."Birth Cert No" := birthCert;
        AdmissionFormHeader.Religion := religion;
        AdmissionFormHeader.Denomination := denomination;
        AdmissionFormHeader.Congregation := congregation;
        AdmissionFormHeader.Diocese := diocese;
        AdmissionFormHeader."Order/Instutute" := inst;
        AdmissionFormHeader."Protestant Congregation" := protCongregation;
        AdmissionFormHeader."Marital Status" := maritalStat;
        AdmissionFormHeader.Disability := disability;
        AdmissionFormHeader."Nature of Disability" := disTyp;
        AdmissionFormHeader."Knew College Thru" := knewThru;
        AdmissionFormHeader.Ethnicity := ethnic;
        AdmissionFormHeader."Telephone No. 1" := phoneNo;
        AdmissionFormHeader."Telephone No. 2" := altPhoneNo;
        AdmissionFormHeader.Email := email;
        AdmissionFormHeader."Address for Correspondence1" := postAddress;
        AdmissionFormHeader."Address for Correspondence3" := town;
        AdmissionFormHeader."Next of kin Name" := kinName;
        AdmissionFormHeader."Next Of Kin Email" := email;
        AdmissionFormHeader."Next of kin Mobile" := kinPhoneNo;
        AdmissionFormHeader."Next of Kin R/Ship" := kinRel;
        AdmissionFormHeader."Fee payer Names" := fpName;
        AdmissionFormHeader."Fee payer mobile" := fpmob;
        AdmissionFormHeader."Fee payer Email" := fpEmail;
        AdmissionFormHeader."Fee payer R/Ship" := fpRel;
        AdmissionFormHeader."Former School Code" := highSchool;
        AdmissionFormHeader."Date of Admission" := hschF;
        AdmissionFormHeader."Date of Completion" := hschT;
        AdmissionFormHeader."Settlement Type" := '4YR-HEF';
        AdmissionFormHeader."Intake Code" := 'SEPT-DEC24';
        AdmissionFormHeader."Mode of Study" := 'FULL TIME';
        AdmissionFormHeader."Admitted To Stage" := 'Y1S1';
        /*AcademicYr.Reset;
        AcademicYr.SetRange(Current, True);
        if AcademicYr.Find('-') then begin
            AdmissionFormHeader."Academic Year" := AcademicYr.Code;
        end;*/
        AdmissionFormHeader."Academic Year" := '2024/2025';
        AdmissionFormHeader."Programme Level" := AdmissionFormHeader."Programme Level"::Diploma;
        Semesters.Reset;
        Semesters.SetRange(Current, True);
        If semesters.Find('-') then begin
            AdmissionFormHeader."Admitted Semester" := Semesters.Semester;
        end;
        AdmissionFormHeader."Application Date" := Today;
        KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(KUCCPSRaw.Index, index);
        IF KUCCPSRaw.FIND('-') THEN BEGIN
            AdmissionFormHeader."Year of Examination" := KUCCPSRaw."OLevel Year Completed";
            Programme.RESET;
            Programme.SETRANGE(Programme.Code, KUCCPSRaw.Prog);
            IF Programme.FIND('-') THEN BEGIN
                AdmissionFormHeader."First Degree Choice" := Programme.Code;
                //AdmissionFormHeader."Programme Faculty" := Programme.Faculty;
                AdmissionFormHeader.programName := Programme.Description;
                AdmissionFormHeader."Programme Department" := Programme."Department Code";
            end;
        end;
        AdmissionFormHeader.Status := AdmissionFormHeader.Status::Open;
        AdmissionFormHeader.Insert;
        KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(KUCCPSRaw.Index, index);
        IF KUCCPSRaw.FIND('-') THEN BEGIN
            KUCCPSRaw.Updated := TRUE;
            KUCCPSRaw.MODIFY;
        end;
        Message := 'Details updated successfully!!!';
    end;

    procedure SSApplication(index: code[20]; fname: text; mmname: text; lname: text; gender: option; dob: Date; nationality: text; county: text; idNo: code[20]; passPort: code[20];
            birthCert: code[20]; religion: text; denomination: text; diocese: text; congregation: option; inst: text; protCongregation: Option; maritalStat: Option;
            disability: option; disTyp: Option; knewThru: Text; formerStud: boolean; formerregno: text; prevedlvl: option; phoneNo: Text; altPhoneNo: text; email: Text;
            postAddress: Text; town: text; programlevel: option;
            intakecode: text; appliedprogram: text; campus: code[20]; modeofstudy: text; highSchool: Text; hschF: Date; hschT: Date; examination: text;
            examinationbody: text; yearofexam: text; meangrade: text; coluniatt: text; coluniattF: Date; colunattTo: Date; highschcertatt: Boolean; rsltslipatt: Boolean;
            undegradcertatt: Boolean; mststrascrptsatt: Boolean; transfercaseatt: Boolean; transferletteratt: Boolean;
            highschcertpath: Text; rsltslippath: Text; undegradcertpath: Text; mststrascrptspath: Text) Message: Text
    var
        Programme: Record "ACA-Programme";
        colfrom: Date;
        colto: Date;
        appno: Text;
    begin
        CLEAR(appno);
        appno := NoSeriesMgt.GetNextNo('APP', 0D, TRUE);
        IF coluniattF = Today THEN begin
            colfrom := 0D;
        end;
        IF colunattTo = Today THEN begin
            colto := 0D;
        end;
        AdmissionFormHeader.Init;
        AdmissionFormHeader."Application No." := appno;
        AdmissionFormHeader."First Name" := fname;
        AdmissionFormHeader."Other Names" := mmname;
        AdmissionFormHeader.Surname := lname;
        AdmissionFormHeader."Index Number" := index;
        AdmissionFormHeader.Gender := gender;
        AdmissionFormHeader."Date Of Birth" := dob;
        AdmissionFormHeader.Nationality := Nationality;
        AdmissionFormHeader.County := county;
        AdmissionFormHeader."ID Number" := idNo;
        AdmissionFormHeader."Passport Number" := passPort;
        AdmissionFormHeader."Birth Cert No" := birthCert;
        AdmissionFormHeader.Religion := religion;
        AdmissionFormHeader.Denomination := denomination;
        AdmissionFormHeader.Congregation := congregation;
        AdmissionFormHeader.Diocese := diocese;
        AdmissionFormHeader."Order/Instutute" := inst;
        AdmissionFormHeader."Protestant Congregation" := protCongregation;
        AdmissionFormHeader."Marital Status" := maritalStat;
        AdmissionFormHeader.Disability := disability;
        AdmissionFormHeader."Nature of Disability" := disTyp;
        AdmissionFormHeader."Knew College Thru" := knewThru;
        AdmissionFormHeader."Telephone No. 1" := phoneNo;
        AdmissionFormHeader."Telephone No. 2" := altPhoneNo;
        AdmissionFormHeader.Email := email;
        AdmissionFormHeader."Address for Correspondence1" := postAddress;
        AdmissionFormHeader."Address for Correspondence3" := town;
        /*AdmissionFormHeader."Next of kin Name" := kinName;
        AdmissionFormHeader."Next Of Kin Email" := kinEmail;
        AdmissionFormHeader."Next of kin Mobile" := kinPhoneNo;
        AdmissionFormHeader."Next of Kin R/Ship" := kinRel;
        AdmissionFormHeader."Fee payer Names" := fpName;
        AdmissionFormHeader."Fee payer mobile" := fpmob;
        AdmissionFormHeader."Fee payer Email" := fpEmail;
        AdmissionFormHeader."Fee payer R/Ship" := fpRel;*/
        AdmissionFormHeader."Former School Code" := highSchool;
        AdmissionFormHeader."Date of Admission" := hschF;
        AdmissionFormHeader."Date of Completion" := hschT;
        AdmissionFormHeader."Year of Examination" := yearofexam;
        AdmissionFormHeader."Examination Body" := examinationbody;
        AdmissionFormHeader."Mean Grade Acquired" := meangrade;
        AdmissionFormHeader."Country of Origin" := nationality;
        AdmissionFormHeader."Settlement Type" := 'SSS';
        AdmissionFormHeader.Campus := 'LANGATA';
        AdmissionFormHeader."Application Date" := Today;
        AdmissionFormHeader."Previous Education Level" := prevedlvl;
        //AdmissionFormHeader."Admitted Semester" := startingsem;
        AdmissionFormHeader."Intake Code" := intakecode;
        AdmissionFormHeader."College/UNV attended" := coluniatt;
        AdmissionFormHeader."College/Unv attend final date" := colto;
        AdmissionFormHeader."College/Unv attend start date" := colfrom;
        AdmissionFormHeader."Programme Level" := programlevel;
        AdmissionFormHeader."Mode of Study" := modeofstudy;
        AdmissionFormHeader."First Degree Choice" := appliedprogram;
        AdmissionFormHeader.Campus := campus;
        //AdmissionFormHeader."First Choice Stage" := firststage;
        //AdmissionFormHeader."First Choice Semester" := startingsem;
        AdmissionFormHeader."High Sch. Cert attched" := highschcertatt;
        AdmissionFormHeader."High Sch. Rslt Slip Attached" := rsltslipatt;
        AdmissionFormHeader."Undergrad Cert attached" := undegradcertatt;
        AdmissionFormHeader."Master Transcript attached" := mststrascrptsatt;
        AdmissionFormHeader."Transfer Case" := transfercaseatt;
        AdmissionFormHeader."Transfer Letter Attached" := transferletteratt;
        AdmissionFormHeader."High School Certificate" := highschcertpath;
        AdmissionFormHeader."High School Result slip" := rsltslippath;
        AdmissionFormHeader."Under Graduate Certificate" := undegradcertpath;
        AdmissionFormHeader."Masters Transcript" := mststrascrptspath;
        Programme.RESET;
        Programme.SETRANGE(Programme.Code, appliedprogram);
        IF Programme.FIND('-') THEN BEGIN
            //AdmissionFormHeader."Programme Faculty" := Programme.Faculty;
            AdmissionFormHeader.programName := Programme.Description;
            AdmissionFormHeader."Programme Department" := Programme."Department Code";
        end;
        AdmissionFormHeader.Status := AdmissionFormHeader.Status::Open;
        AdmissionFormHeader.Insert;
        Message := appno;//'Application submitted successfully.';
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

    procedure EditSSApplication(appno: code[50]; appliedprogram: Code[20]; highschcertatt: Boolean; rsltslipatt: Boolean; undegradcertatt: Boolean; mststrascrptsatt: Boolean; transfercaseatt: Boolean; transferletteratt: Boolean; highschcertpath: Text; rsltslippath: Text; undegradcertpath: Text; mststrascrptspath: Text) Message: Text
    var
        Programme: Record "ACA-Programme";
    begin
        AdmissionFormHeader.reset;
        AdmissionFormHeader.Setrange("Application No.", appno);
        if AdmissionFormHeader.FIND('-') THEN begin
            AdmissionFormHeader."First Degree Choice" := appliedprogram;
            AdmissionFormHeader."High Sch. Cert attched" := highschcertatt;
            AdmissionFormHeader."High Sch. Rslt Slip Attached" := rsltslipatt;
            AdmissionFormHeader."Undergrad Cert attached" := undegradcertatt;
            AdmissionFormHeader."Master Transcript attached" := mststrascrptsatt;
            AdmissionFormHeader."Transfer Case" := transfercaseatt;
            AdmissionFormHeader."Transfer Letter Attached" := transferletteratt;
            AdmissionFormHeader."High School Certificate" := highschcertpath;
            AdmissionFormHeader."High School Result slip" := rsltslippath;
            AdmissionFormHeader."Under Graduate Certificate" := undegradcertpath;
            AdmissionFormHeader."Masters Transcript" := mststrascrptspath;
            Programme.RESET;
            Programme.SETRANGE(Programme.Code, appliedprogram);
            IF Programme.FIND('-') THEN begin
                //AdmissionFormHeader."Programme Faculty" := Programme.Faculty;
                AdmissionFormHeader.programName := Programme.Description;
                AdmissionFormHeader."Programme Department" := Programme."Department Code";
            end;
            AdmissionFormHeader.returned := false;
            AdmissionFormHeader.Modify;
            Message := 'Your Application has been edited successfully!!';
        end;
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

    procedure GetProgramme(progcode: Option; studymode: code[20]; campus: code[20]; intake: code[20]) Message: Text
    begin
        Programme.RESET;
        Programme.SETRANGE(Programme.Levels, progcode);
        Programme.SETRANGE(Programme."Program Status", Programme."Program Status"::Active);
        IF Programme.FIND('-') THEN BEGIN
            REPEAT
                Programmeetups.Reset;
                Programmeetups.SetRange(Code, Programme.Code);
                Programmeetups.SetRange(Campus, campus);
                Programmeetups.SetRange(Modeofstudy, studymode);
                Programmeetups.SetRange(Semester, intake);
                if Programmeetups.Find('-') then begin
                    Message += Programme.Code + ' ::' + Programme.Description + ' :::';
                end;
            UNTIL Programme.NEXT = 0;
        END;
    end;

    procedure GetProgramme(progCode: Option; studyMode: Text; Campus: Text; intake: Text) Result: Text
    begin
        Programmeetups.Reset();
        Programmeetups.SetRange(Programmeetups.semester, intake);
        Programmeetups.SetRange(Programmeetups.Code, Format(progCode));
        if Programmeetups.FIND('-') then begin
            Result := Format(Programmeetups.Code);

            Programme.Reset();
            Programme.SETRANGE(Programme.Levels, progCode);
            Programme.SETRANGE(Programme."Program Status", Programme."Program Status"::Active);
            IF Programme.FIND('-') THEN BEGIN

                repeat

                    Result += Programme.Code + ' ::' + Programme.Description + ' :::';

                until Programme.Next = 0;

            end

        END;
        exit(Result);

    end;

    procedure GetProgramme2(progCode: Option; studyMode: Text; Campus: Text; intake: Text) Result: Text
    begin
        Programmeetups.Reset();
        Programmeetups.SetRange(Programmeetups.semester, intake);
        Programmeetups.SetRange(Programmeetups.Code, Format(progCode));
        if Programmeetups.FIND('-') then begin
            Result := Format(Programmeetups.Code);

            Programme.Reset();
            Programme.SETRANGE(Programme.Levels, progCode);
            Programme.SETRANGE(Programme."Program Status", Programme."Program Status"::Active);
            IF Programme.FIND('-') THEN BEGIN

                repeat

                    Result += Programme.Code + ' ::' + Programme.Description + ' :::';

                until Programme.Next = 0;

            end

        END;
        exit(Result);

    end;

    procedure GetAppliedLevelProgramme(appno: Code[50]) Message: Text
    begin
        AdmissionFormHeader.reset;
        AdmissionFormHeader.SetRange("Application No.", appno);
        IF AdmissionFormHeader.FIND('-') THEN BEGIN
            Programme.RESET;
            Programme.SETRANGE(Programme.Levels, AdmissionFormHeader."Programme Level");
            Programme.SETRANGE(Programme."Program Status", Programme."Program Status"::Active);
            IF Programme.FIND('-') THEN BEGIN
                REPEAT
                    Message := Message + Programme.Code + ' ::' + Programme.Description + ' :::';
                UNTIL Programme.NEXT = 0;
            END;
        END;
    end;

    procedure Getsemestersesters(Progz: Code[50]) Message: Text
    begin
        Programme.RESET;
        Programme.SETRANGE(Code, Progz);
        Programme.SETRANGE("Use Stage Semesters", true);
        IF Programme.FIND('-') THEN BEGIN
            semesters.RESET;
            semesters.SETRANGE(semesters."Programme Code", Progz);
            semesters.SETRANGE(semesters.Current, TRUE);
            IF semesters.FIND('-') THEN BEGIN
                Message := semesters.Semester;
            END;
        END ELSE BEGIN
            CurrentSem.RESET;
            CurrentSem.SETRANGE("Current Semester", true);
            IF CurrentSem.FIND('-') THEN BEGIN
                Message := CurrentSem.Code;
            END;
        END;
    end;
    //  procedure GetAppliedLevelProgramme(appno: Code[50]) Message: Text
    //     begin
    //         AdmissionFormHeader.reset;
    //         AdmissionFormHeader.SetRange("Application No.", appno);
    //         IF AdmissionFormHeader.FIND('-') THEN BEGIN
    //             Programme.RESET;
    //             Programme.SETRANGE(Programme.Levels, AdmissionFormHeader."Programme Level");
    //             Programme.SETRANGE(Programme."Program Status", Programme."Program Status"::Active);
    //             IF Programme.FIND('-') THEN BEGIN
    //                 REPEAT
    //                     Message := Message + Programme.Code + ' ::' + Programme.Description + ' :::';
    //                 UNTIL Programme.NEXT = 0;
    //             END;
    //         END;
    //     end;

    procedure GetRelationships() Message: Text
    begin
        relationships.RESET;
        IF relationships.FIND('-') THEN BEGIN
            REPEAT
                Message := Message + relationships.Code + ' ::' + relationships.Description + ' :::';
            UNTIL relationships.NEXT = 0;
        END;
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

    // procedure GetSSDetails(username: text) Message: Text
    // begin
    //     OnlineUsersz.RESET;
    //     OnlineUsersz.SETRANGE(OnlineUsersz."Email Address", username);
    //     IF OnlineUsersz.FIND('-') THEN BEGIN
    //         Message := OnlineUsersz."First Name" + ' ::' + OnlineUsersz."Middle Name" + ' ::' + OnlineUsersz."Last Name" + ' ::' + OnlineUsersz."Phone No" + ' ::' + FORMAT(OnlineUsersz.Gender) + ' ::';
    //     END;
    // end;

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

    procedure GetApplicationFee(appno: Code[20]) appfee: Decimal
    begin
        AdmissionFormHeader.reset;
        AdmissionFormHeader.SETRANGE(AdmissionFormHeader."Application No.", appno);
        IF AdmissionFormHeader.FIND('-') THEN begin
            Programme.Reset;
            Programme.SetRange(Programme.Code, AdmissionFormHeader."First Degree Choice");
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
            AdmissionFormHeader.reset;
            AdmissionFormHeader.SetRange("Application No.", appno);
            IF AdmissionFormHeader.FIND('-') THEN begin
                AdmissionFormHeader."Finance Cleared" := true;
                AdmissionFormHeader.modify;
            end;
            Msg := true;
        end;
    end;

    procedure GetProgramCode(index: Text) Message: Text
    begin
        KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(Index, index);
        IF KUCCPSRaw.FIND('-') THEN BEGIN
            Message := KUCCPSRaw.prog;

        END
    end;



}
