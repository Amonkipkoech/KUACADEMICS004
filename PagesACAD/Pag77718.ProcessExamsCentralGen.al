page 77718 "Process Exams Central Gen."
{
    PageType = Card;
    SourceTable = 61511;
    //SourceTableView = WHERE(Code = FILTER('A100'));

    layout
    {
        area(content)
        {
            group(ProgrammeFil)
            {
                Caption = 'Programme Filter';
                field(Schools; Schools)
                {
                    Caption = 'School Filter';
                    TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('FACULTY'));
                    ApplicationArea = All;
                }
                field(progy; programs)
                {
                    Caption = 'Programme';
                    TableRelation = "ACA-Programme".Code;
                    ApplicationArea = All;
                }
                field(UnitCode; UnitCode)
                {
                    Caption = 'Unit Code';
                    ApplicationArea = All;
                }
                field(StudNos; StudNos)
                {
                    Caption = 'Student No';
                    TableRelation = Customer."No." WHERE("Customer Posting Group" = FILTER('STUDENT'));
                    ApplicationArea = All;
                }
                field(AcadYear; AcadYear)
                {
                    Caption = 'Academic Year';
                    TableRelation = "ACA-Academic Year".Code;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(PostMarksNew)
            {
                Caption = 'Process Marks';
                Image = EncryptionKeys;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    AcdYrs: Record "ACA-Academic Year";
                    Custos: Record Customer;
                    usersetup: record "User Setup";
                    StudentUnits: Record "ACA-Student Units";
                    UnitsSubjects: Record "ACA-Units/Subjects";
                    Programme_Fin: Record "ACA-Programme";
                    ProgrammeStages_Fin: Record "ACA-Programme Stages";
                    AcademicYear_Fin: Record "ACA-Academic Year";
                    Semesters_Fin: Record "ACA-Semesters";
                    ExamResults: Record "ACA-Exam Results";
                    ClassSpecialExamsDetails: Record "Aca-Special Exams Details";
                    ClassCustomer: Record Customer;
                    ClassExamResultsBuffer2: Record "ACA-Exam Results Buffer 2";
                    ClassDimensionValue: Record "Dimension Value";
                    ClassGradingSystem: Record "ACA-Grading System";
                    ClassClassGradRubrics: Record "ACA-Class/Grad. Rubrics";
                    ClassExamResults2: Record "ACA-Exam Results";
                    TotalRecs: Integer;
                    CountedRecs: Integer;
                    RemeiningRecs: Integer;
                    ExpectedElectives: Integer;
                    CountedElectives: Integer;
                    ProgBar2: Dialog;
                    Progyz: Record "ACA-Programme";
                    ACADefinedUnitsperYoS: Record "ACA-Defined Units per YoS";
                    ACAExamClassificationUnits: Record "ACA-Exam Classification Units";
                    ACAExamCourseRegistration: Record "ACA-Exam. Course Registration";
                    ACAExamFailedReasons: Record "ACA-Exam Failed Reasons";
                    ACASenateReportsHeader: Record "ACA-Senate Reports Header";
                    ACAExamClassificationStuds: Record "ACA-Exam Classification Studs";
                    ACAExamClassificationStudsCheck: Record "ACA-Exam Classification Studs";
                    ACAExamResultsFin: Record "ACA-Exam Results";
                    ACAResultsStatus: Record "ACA-Results Status";
                    ProgressForCoReg: Dialog;
                    Tens: Text;
                    ACASemesters: Record "ACA-Semesters";
                    ACAExamResults_Fin: Record "ACA-Exam Results";
                    ProgBar22: Dialog;
                    Coregcs: Record "ACA-Course Registration";
                    ACAExamCummulativeResit: Record "ACA-Exam Cummulative Resit";
                    ACAStudentUnitsForResits: Record "ACA-Student Units";
                    SEQUENCES: Integer;
                    CurrStudentNo: Code[20];
                    CountedNos: Integer;
                    CurrSchool: Code[20];
                begin
                    if usersetup.Get(UserId) then begin
                        usersetup.TestField("Can Process Senate Marks");
                    end else
                        error('Accedd Denied!');
                    if Confirm('Process Marks?', true) = false then Error('Cancelled by user!');
                    if AcadYear = '' then Error('Specify Academic Year');

                    Clear(ProgFIls);
                    AcademicYear_Finz.Reset;
                    AcademicYear_Finz.SetFilter(Code, AcadYear);
                    if AcademicYear_Finz.Find('-') then begin
                        repeat
                        begin
                            Clear(GradAcademicYear);
                            GradAcademicYear := AcademicYear_Finz.Code;//AcadYear;

                            // Clear CLassification For Selected Filters
                            ProgFIls := GetProgFilters1(programs, Schools);
                            ACAExamClassificationStuds.Reset;
                            ACAExamCourseRegistration.Reset;
                            ACAExamClassificationUnits.Reset;
                            if StudNos <> '' then begin
                                ACAExamClassificationStuds.SetFilter("Student Number", StudNos);
                                ACAExamCourseRegistration.SetRange("Student Number", StudNos);
                                ACAExamClassificationUnits.SetRange("Student No.", StudNos);
                            end;
                            if GradAcademicYear <> '' then begin
                                ACAExamClassificationStuds.SetFilter("Academic Year", GradAcademicYear);
                                ACAExamCourseRegistration.SetFilter("Academic Year", GradAcademicYear);
                                ACAExamClassificationUnits.SetFilter("Academic Year", GradAcademicYear);
                            end;

                            ACAExamClassificationStuds.SetFilter(Programme, ProgFIls);
                            ACAExamCourseRegistration.SetFilter(Programme, ProgFIls);
                            ACAExamClassificationUnits.SetFilter(Programme, ProgFIls);
                            if ACAExamClassificationStuds.Find('-') then ACAExamClassificationStuds.DeleteAll;
                            if ACAExamCourseRegistration.Find('-') then ACAExamCourseRegistration.DeleteAll;
                            if ACAExamClassificationUnits.Find('-') then ACAExamClassificationUnits.DeleteAll;


                            ACASenateReportsHeader.Reset;
                            ACASenateReportsHeader.SetRange("Academic Year", GradAcademicYear);
                            ACASenateReportsHeader.SetFilter("Programme Code", ProgFIls);
                            if (ACASenateReportsHeader.Find('-')) then ACASenateReportsHeader.DeleteAll;

                            Coregcs.Reset;
                            Coregcs.SetFilter(Programmes, ProgFIls);
                            Coregcs.SetRange("Academic Year", GradAcademicYear);
                            Coregcs.SetRange(Reversed, false);
                            Coregcs.SetFilter(Status, '<>%1', StudentUnits.Status::Alluminae);
                            if StudNos <> '' then begin
                                Coregcs.SetFilter("Student No.", StudNos);
                            end;
                            if Coregcs.Find('-') then begin
                                Clear(TotalRecs);
                                Clear(RemeiningRecs);
                                Clear(CountedRecs);
                                TotalRecs := Coregcs.Count;
                                RemeiningRecs := TotalRecs;
                                // Loop through all Ungraduated Students Units
                                Progressbar.Open('#1#####################################################\' +
                                '#2############################################################\' +
                                '#3###########################################################\' +
                                '#4############################################################\' +
                                '#5###########################################################\' +
                                '#6############################################################');
                                Progressbar.Update(1, 'Processing  values....');
                                Progressbar.Update(2, 'Total Recs.: ' + Format(TotalRecs));
                                repeat
                                begin

                                    CountedRecs := CountedRecs + 1;
                                    RemeiningRecs := RemeiningRecs - 1;
                                    // Create Registration Unit entry if Not Exists
                                    Progressbar.Update(3, '.....................................................');
                                    Progressbar.Update(4, 'Processed: ' + Format(CountedRecs));
                                    Progressbar.Update(5, 'Remaining: ' + Format(RemeiningRecs));
                                    Progressbar.Update(6, '----------------------------------------------------');
                                    Progyz.Reset;
                                    Progyz.SetFilter(Code, Coregcs.Programmes);
                                    if Progyz.Find('-') then begin
                                    end;
                                    Clear(YosStages);
                                    if Coregcs."Year Of Study" = 0 then Coregcs.Validate(Stage);
                                    if Coregcs."Year Of Study" = 1 then
                                        YosStages := 'Y1S1|Y1S2|Y1S3|Y1S4'
                                    else
                                        if Coregcs."Year Of Study" = 2 then
                                            YosStages := 'Y2S1|Y2S2|Y2S3|Y2S4'
                                        else
                                            if Coregcs."Year Of Study" = 3 then
                                                YosStages := 'Y3S1|Y3S2|Y3S3|Y3S4'
                                            else
                                                if Coregcs."Year Of Study" = 4 then
                                                    YosStages := 'Y4S1|Y4S2|Y4S3|Y4S4'
                                                else
                                                    if Coregcs."Year Of Study" = 5 then
                                                        YosStages := 'Y5S1|Y5S2|Y5S3|Y5S4'
                                                    else
                                                        if Coregcs."Year Of Study" = 6 then
                                                            YosStages := 'Y6S1|Y6S2|Y6S3|Y6S4'
                                                        else
                                                            if Coregcs."Year Of Study" = 7 then
                                                                YosStages := 'Y7S1|Y7S2|Y7S3|Y7S4'
                                                            else
                                                                if Coregcs."Year Of Study" = 8 then YosStages := 'Y8S1|Y8S2|Y8S3|Y8S4';

                                    ACAExamCummulativeResit.Reset;
                                    ACAExamCummulativeResit.SetRange("Student Number", StudentUnits."Student No.");
                                    ACAExamCummulativeResit.SetRange("Academic Year", GradAcademicYear);
                                    if ACAExamCummulativeResit.Find('-') then ACAExamCummulativeResit.DeleteAll;

                                    Custos.Reset;
                                    Custos.SetRange("No.", Coregcs."Student No.");
                                    if Custos.Find('-') then
                                        Custos.CalcFields("Senate Classification Based on");

                                    StudentUnits.Reset;
                                    StudentUnits.SetRange("Student No.", Coregcs."Student No.");
                                    if Custos."Senate Classification Based on" = Custos."Senate Classification Based on"::"Year of Study" then
                                        StudentUnits.SetFilter("Unit Stage", YosStages)
                                    else
                                        StudentUnits.SetFilter("Academic Year (Flow)", Coregcs."Academic Year");
                                    if StudentUnits.Find('-') then begin

                                        repeat
                                        begin
                                            StudentUnits.CalcFields(StudentUnits."CATs Marks Exists");
                                            if StudentUnits."CATs Marks Exists" = false then begin
                                                AcdYrs.Reset;
                                                AcdYrs.SetRange(Code, StudentUnits."Academic Year");
                                                AcdYrs.SetRange("Allow CATs Exempt", true);
                                                if AcdYrs.Find('-') then begin
                                                    ExamResults.Init;
                                                    ExamResults."Student No." := StudentUnits."Student No.";
                                                    ExamResults.Programmes := StudentUnits.Programme;
                                                    ExamResults.Stage := StudentUnits.Stage;
                                                    ExamResults.Unit := StudentUnits.Unit;
                                                    ExamResults.Semester := StudentUnits.Semester;
                                                    ExamResults."Academic Year" := StudentUnits."Academic Year";
                                                    ExamResults."Reg. Transaction ID" := StudentUnits."Reg. Transacton ID";
                                                    ExamResults.ExamType := 'CAT';
                                                    ExamResults.Exam := 'CAT';
                                                    ExamResults."Exam Category" := Progyz."Exam Category";
                                                    ExamResults.Score := 0;
                                                    ExamResults."User Name" := 'AUTOPOST';
                                                    ExamResults.Insert;
                                                end;
                                            end;
                                            ExamResults.Reset;
                                            ExamResults.SetRange("Student No.", StudentUnits."Student No.");
                                            ExamResults.SetRange(Unit, StudentUnits.Unit);
                                            if ExamResults.Find('-') then begin
                                                repeat
                                                begin
                                                    if ExamResults.ExamType <> '' then begin
                                                        ExamResults.Exam := ExamResults.ExamType;
                                                        ExamResults.Modify;
                                                    end else
                                                        if ExamResults.Exam <> '' then begin
                                                            if ExamResults.ExamType = '' then begin
                                                                //ExamResults.ExamType:=ExamResults.Exam;
                                                                ExamResults.Rename(ExamResults."Student No.", ExamResults.Programmes, ExamResults.Stage,
                                                                ExamResults.Unit, ExamResults.Semester, ExamResults.Exam, ExamResults."Reg. Transaction ID", ExamResults."Entry No");
                                                            end;
                                                        end;
                                                end;
                                                until ExamResults.Next = 0;
                                            end;
                                            ///////////////////////////////////////////////////////////////// iiiiiiiiiiiiiiiiiiiiiiii Update Units
                                            ExamResults.Reset;
                                            ExamResults.SetFilter("Counted Occurances", '>%1', 1);
                                            ExamResults.SetRange("Student No.", StudentUnits."Student No.");
                                            ExamResults.SetRange(Unit, StudentUnits.Unit);
                                            if ExamResults.Find('-') then begin
                                                repeat
                                                begin
                                                    ACAExamResultsFin.Reset;
                                                    ACAExamResultsFin.SetRange("Student No.", StudentUnits."Student No.");
                                                    ACAExamResultsFin.SetRange(Programmes, StudentUnits.Programme);
                                                    ACAExamResultsFin.SetRange(Unit, StudentUnits.Unit);
                                                    ACAExamResultsFin.SetRange(Semester, StudentUnits.Semester);
                                                    ACAExamResultsFin.SetRange(ExamType, ExamResults.ExamType);
                                                    if ACAExamResultsFin.Find('-') then begin
                                                        ACAExamResultsFin.CalcFields("Counted Occurances");
                                                        if ACAExamResultsFin."Counted Occurances" > 1 then begin
                                                            ACAExamResultsFin.Delete;
                                                        end;
                                                    end;
                                                end;
                                                until ExamResults.Next = 0;
                                            end;
                                            ////////////////////////////////// Remgitove Multiple Occurances of a Mark
                                            ////////////////////////////////////////////////////////////////////////////
                                            // Grad Headers
                                            ACAResultsStatus.Reset;
                                            ACAResultsStatus.SetRange("Special Programme Class", Progyz."Special Programme Class");
                                            ACAResultsStatus.SetRange("Academic Year", GradAcademicYear);
                                            if ACAResultsStatus.Find('-') then begin
                                                repeat
                                                begin
                                                    ACASenateReportsHeader.Reset;
                                                    ACASenateReportsHeader.SetRange("Academic Year", GradAcademicYear);
                                                    ACASenateReportsHeader.SetRange("School Code", Progyz."School Code");
                                                    ACASenateReportsHeader.SetRange("Classification Code", ACAResultsStatus.Code);
                                                    ACASenateReportsHeader.SetRange("Programme Code", Progyz.Code);
                                                    ACASenateReportsHeader.SetRange("Year of Study", Coregcs."Year Of Study");
                                                    if not (ACASenateReportsHeader.Find('-')) then begin
                                                        ACASenateReportsHeader.Init;
                                                        ACASenateReportsHeader."Academic Year" := GradAcademicYear;
                                                        ACASenateReportsHeader."Reporting Academic Year" := GradAcademicYear;
                                                        ACASenateReportsHeader."Rubric Order" := ACAResultsStatus."Order No";
                                                        ACASenateReportsHeader."Programme Code" := Progyz.Code;
                                                        ACASenateReportsHeader."School Code" := Progyz."School Code";
                                                        ACASenateReportsHeader."Year of Study" := Coregcs."Year Of Study";
                                                        ACASenateReportsHeader."Classification Code" := ACAResultsStatus.Code;
                                                        ACASenateReportsHeader."Status Msg6" := ACAResultsStatus."Status Msg6";
                                                        ACASenateReportsHeader."IncludeVariable 1" := ACAResultsStatus."IncludeVariable 1";
                                                        ACASenateReportsHeader."IncludeVariable 2" := ACAResultsStatus."IncludeVariable 2";
                                                        ACASenateReportsHeader."IncludeVariable 3" := ACAResultsStatus."IncludeVariable 3";
                                                        ACASenateReportsHeader."IncludeVariable 4" := ACAResultsStatus."IncludeVariable 4";
                                                        ACASenateReportsHeader."IncludeVariable 5" := ACAResultsStatus."IncludeVariable 5";
                                                        ACASenateReportsHeader."IncludeVariable 6" := ACAResultsStatus."IncludeVariable 6";
                                                        ACASenateReportsHeader."Summary Page Caption" := ACAResultsStatus."Summary Page Caption";
                                                        ACASenateReportsHeader."Include Failed Units Headers" := ACAResultsStatus."Include Failed Units Headers";
                                                        ACASenateReportsHeader."Include Academic Year Caption" := ACAResultsStatus."Include Academic Year Caption";
                                                        ACASenateReportsHeader."Academic Year Text" := ACAResultsStatus."Academic Year Text";
                                                        ACASenateReportsHeader."Status Msg1" := ACAResultsStatus."Status Msg1";
                                                        ACASenateReportsHeader."Status Msg2" := ACAResultsStatus."Status Msg2";
                                                        ACASenateReportsHeader."Status Msg3" := ACAResultsStatus."Status Msg3";
                                                        ACASenateReportsHeader."Status Msg4" := ACAResultsStatus."Status Msg4";
                                                        ACASenateReportsHeader."Status Msg5" := ACAResultsStatus."Status Msg5";
                                                        ACASenateReportsHeader."Status Msg6" := ACAResultsStatus."Status Msg6";
                                                        ACASenateReportsHeader."Grad. Status Msg 1" := ACAResultsStatus."Grad. Status Msg 1";
                                                        ACASenateReportsHeader."Grad. Status Msg 2" := ACAResultsStatus."Grad. Status Msg 2";
                                                        ACASenateReportsHeader."Grad. Status Msg 3" := ACAResultsStatus."Grad. Status Msg 3";
                                                        ACASenateReportsHeader."Grad. Status Msg 4" := ACAResultsStatus."Grad. Status Msg 4";
                                                        ACASenateReportsHeader."Grad. Status Msg 5" := ACAResultsStatus."Grad. Status Msg 5";
                                                        ACASenateReportsHeader."Grad. Status Msg 6" := ACAResultsStatus."Grad. Status Msg 6";
                                                        ACASenateReportsHeader."Finalists Graduation Comments" := ACAResultsStatus."Finalists Grad. Comm. Degree";
                                                        ACASenateReportsHeader."1st Year Grad. Comments" := ACAResultsStatus."1st Year Grad. Comments";
                                                        ACASenateReportsHeader."2nd Year Grad. Comments" := ACAResultsStatus."2nd Year Grad. Comments";
                                                        ACASenateReportsHeader."3rd Year Grad. Comments" := ACAResultsStatus."3rd Year Grad. Comments";
                                                        ACASenateReportsHeader."4th Year Grad. Comments" := ACAResultsStatus."4th Year Grad. Comments";
                                                        ACASenateReportsHeader."5th Year Grad. Comments" := ACAResultsStatus."5th Year Grad. Comments";
                                                        ACASenateReportsHeader."6th Year Grad. Comments" := ACAResultsStatus."6th Year Grad. Comments";
                                                        ACASenateReportsHeader."7th Year Grad. Comments" := ACAResultsStatus."7th Year Grad. Comments";
                                                        ACASenateReportsHeader.Insert;
                                                    end;
                                                end;
                                                until ACAResultsStatus.Next = 0;
                                            end;
                                            ////////////////////////////////////////////////////////////////////////////
                                            ACAExamClassificationStuds.Reset;
                                            ACAExamClassificationStuds.SetRange("Student Number", StudentUnits."Student No.");
                                            ACAExamClassificationStuds.SetRange(Programme, StudentUnits.Programme);
                                            ACAExamClassificationStuds.SetRange("Academic Year", GradAcademicYear);
                                            // ACAExamClassificationStuds.SETRANGE("Reporting Academic Year",GradAcademicYear);
                                            if not ACAExamClassificationStuds.Find('-') then begin
                                                ACAExamClassificationStuds.Init;
                                                ACAExamClassificationStuds."Student Number" := StudentUnits."Student No.";
                                                ACAExamClassificationStuds."Reporting Academic Year" := GradAcademicYear;
                                                ACAExamClassificationStuds."School Code" := Progyz."School Code";
                                                ACAExamClassificationStuds.Department := Progyz."Department Code";
                                                ACAExamClassificationStuds."Programme Option" := Coregcs.Options;
                                                ACAExamClassificationStuds.Programme := StudentUnits.Programme;
                                                ACAExamClassificationStuds."Academic Year" := GradAcademicYear;
                                                ACAExamClassificationStuds."Year of Study" := Coregcs."Year Of Study";
                                                //ACAExamClassificationStuds."Department Name":=GetDepartmentNameOrSchool(Progyz."Department Code");
                                                ACAExamClassificationStuds."School Name" := GetDepartmentNameOrSchool(Progyz."School Code");
                                                ACAExamClassificationStuds."Student Name" := GetStudentName(StudentUnits."Student No.");
                                                ACAExamClassificationStuds.Cohort := GetCohort(StudentUnits."Student No.", StudentUnits.Programme);
                                                ACAExamClassificationStuds."Final Stage" := GetFinalStage(StudentUnits.Programme);
                                                ACAExamClassificationStuds."Final Academic Year" := GetFinalAcademicYear(StudentUnits."Student No.", StudentUnits.Programme);
                                                ACAExamClassificationStuds."Final Year of Study" := GetFinalYearOfStudy(StudentUnits.Programme);
                                                ACAExamClassificationStuds."Admission Date" := GetAdmissionDate(StudentUnits."Student No.", StudentUnits.Programme);
                                                ACAExamClassificationStuds."Admission Academic Year" := GetAdmissionAcademicYear(StudentUnits."Student No.", StudentUnits.Programme);
                                                ACAExamClassificationStuds.Graduating := false;
                                                ACAExamClassificationStuds.Classification := '';
                                                ACAExamClassificationStuds.Insert;

                                                // // // // // // //          ACAExamCummulativeResit.RESET;
                                                // // // // // // //        ACAExamCummulativeResit.SETRANGE("Student Number",StudentUnits."Student No.");
                                                // // // // // // //        ACAExamCummulativeResit.SETRANGE("Academic Year",ACAExamClassificationStuds."Academic Year");
                                                // // // // // // //        IF ACAExamCummulativeResit.FIND('-') THEN ACAExamCummulativeResit.DELETEALL;
                                                // // // // // // //
                                                // // // // // // //        ACAStudentUnitsForResits.RESET;
                                                // // // // // // //        ACAStudentUnitsForResits.SETRANGE("Student No.",StudentUnits."Student No.");
                                                // // // // // // //        ACAStudentUnitsForResits.SETRANGE("Reg. Reversed",FALSE);
                                                // // // // // // //        IF ACAStudentUnitsForResits.FIND('-') THEN BEGIN
                                                // // // // // // //          REPEAT
                                                // // // // // // //              BEGIN
                                                // // // // // // //                ACAStudentUnitsForResits.CALCFIELDS("EXAMs Marks","CATs Marks","CATs Marks Exists","EXAMs Marks Exists");
                                                // // // // // // //                IF ((ACAStudentUnitsForResits."CATs Marks Exists"=FALSE) OR
                                                // // // // // // //                  (ACAStudentUnitsForResits."EXAMs Marks Exists"=FALSE) OR
                                                // // // // // // //                   (((GetUnitPassStatus((GetGrade((ACAStudentUnitsForResits."EXAMs Marks"+ACAStudentUnitsForResits."CATs Marks"),
                                                // // // // // // //              ACAStudentUnitsForResits.Unit,ACAExamClassificationStuds.Programme)),
                                                // // // // // // //              ACAStudentUnitsForResits.Unit,ACAExamClassificationStuds.Programme))=FALSE))) THEN BEGIN
                                                // // // // // // //      UnitsSubjects.RESET;
                                                // // // // // // //      UnitsSubjects.SETRANGE("Programme Code",ACAStudentUnitsForResits.Programme);
                                                // // // // // // //      UnitsSubjects.SETRANGE(Code,ACAStudentUnitsForResits.Unit);
                                                // // // // // // //      IF UnitsSubjects.FIND('-') THEN BEGIN
                                                // // // // // // //
                                                // // // // // // //        IF NOT (GetYearOfStudy(UnitsSubjects."Stage Code")>Coregcs."Year Of Study") THEN BEGIN
                                                // // // // // // //          ACAExamCummulativeResit.RESET;
                                                // // // // // // //        ACAExamCummulativeResit.SETRANGE("Student Number",StudentUnits."Student No.");
                                                // // // // // // //        ACAExamCummulativeResit.SETRANGE("Unit Code",ACAStudentUnitsForResits.Unit);
                                                // // // // // // //        ACAExamCummulativeResit.SETRANGE("Academic Year",Coregcs."Academic Year");
                                                // // // // // // //        IF NOT (ACAExamCummulativeResit.FIND('-')) THEN BEGIN
                                                // // // // // // //            ACAExamCummulativeResit.INIT;
                                                // // // // // // //            ACAExamCummulativeResit."Student Number":=StudentUnits."Student No.";
                                                // // // // // // //            ACAExamCummulativeResit."School Code":=ACAExamClassificationStuds."School Code";
                                                // // // // // // //            ACAExamCummulativeResit."Academic Year":=ACAExamClassificationStuds."Academic Year";
                                                // // // // // // //            ACAExamCummulativeResit."Unit Code":=ACAStudentUnitsForResits.Unit;
                                                // // // // // // //            ACAExamCummulativeResit."Student Name":=ACAExamClassificationStuds."Student Name";
                                                // // // // // // //            ACAExamCummulativeResit.Programme:=ACAExamClassificationStuds.Programme;
                                                // // // // // // //            ACAExamCummulativeResit."School Name":=ACAExamClassificationStuds."School Name";
                                                // // // // // // //            ACAExamCummulativeResit."Unit Description":=UnitsSubjects.Desription;
                                                // // // // // // //            ACAExamCummulativeResit."Credit Hours":=UnitsSubjects."Credit Hours";
                                                // // // // // // //            IF UnitsSubjects."Unit Type"=UnitsSubjects."Unit Type"::Core THEN
                                                // // // // // // //              ACAExamCummulativeResit."Unit Type":='CORE'
                                                // // // // // // //            ELSE IF UnitsSubjects."Unit Type"=UnitsSubjects."Unit Type"::Required THEN
                                                // // // // // // //              ACAExamCummulativeResit."Unit Type":='Required'
                                                // // // // // // //            ELSE IF UnitsSubjects."Unit Type"=UnitsSubjects."Unit Type"::Elective THEN
                                                // // // // // // //              ACAExamCummulativeResit."Unit Type":='Elective';
                                                // // // // // // //
                                                // // // // // // //            ACAExamCummulativeResit.Score:=ACAStudentUnitsForResits."EXAMs Marks"+ACAStudentUnitsForResits."CATs Marks";
                                                // // // // // // //            IF ((ACAStudentUnitsForResits."CATs Marks Exists"=FALSE) OR
                                                // // // // // // //                  (ACAStudentUnitsForResits."EXAMs Marks Exists"=FALSE)) THEN
                                                // // // // // // //            ACAExamCummulativeResit.Grade:='!' ELSE
                                                // // // // // // //            ACAExamCummulativeResit.Grade:=GetGrade((ACAStudentUnitsForResits."EXAMs Marks"+ACAStudentUnitsForResits."CATs Marks"),
                                                // // // // // // //              ACAStudentUnitsForResits.Unit,ACAExamClassificationStuds.Programme);
                                                // // // // // // //              IF ACAExamCummulativeResit.Grade<>'' THEN
                                                // // // // // // //            IF ACAExamCummulativeResit.INSERT THEN;
                                                // // // // // // //
                                                // // // // // // //            END;
                                                // // // // // // //            END;
                                                // // // // // // //        END;
                                                // // // // // // //        END;
                                                // // // // // // //              END;
                                                // // // // // // //            UNTIL ACAStudentUnitsForResits.NEXT=0;
                                                // // // // // // //          END;
                                                // // // // // // //        // Pick all Resits for the Student
                                            end;
                                            /////////////////////////////////////// YoS Tracker
                                            Progyz.Reset;
                                            if Progyz.Get(Coregcs.Programmes) then;
                                            ACAExamCourseRegistration.Reset;
                                            ACAExamCourseRegistration.SetRange("Student Number", Coregcs."Student No.");
                                            ACAExamCourseRegistration.SetRange(Programme, Coregcs.Programmes);
                                            ACAExamCourseRegistration.SetRange("Year of Study", Coregcs."Year Of Study");
                                            ACAExamCourseRegistration.SetRange("Academic Year", GradAcademicYear);
                                            // ACAExamCourseRegistration.SETRANGE("Reporting Academic Year",GradAcademicYear);
                                            if not ACAExamCourseRegistration.Find('-') then begin
                                                ACAExamCourseRegistration.Init;
                                                ACAExamCourseRegistration."Student Number" := Coregcs."Student No.";
                                                ACAExamCourseRegistration.Programme := Coregcs.Programmes;
                                                ACAExamCourseRegistration."Year of Study" := Coregcs."Year Of Study";
                                                ACAExamCourseRegistration."Reporting Academic Year" := GradAcademicYear;
                                                ACAExamCourseRegistration."Academic Year" := Coregcs."Academic Year";
                                                ACAExamCourseRegistration."School Code" := Progyz."School Code";
                                                ACAExamCourseRegistration."Programme Option" := Coregcs.Options;
                                                // ACAExamCourseRegistration.Department:=Progyz."Department Code";
                                                // ACAExamCourseRegistration."Department Name":=ACAExamClassificationStuds."Department Name";
                                                ACAExamCourseRegistration."School Name" := ACAExamClassificationStuds."School Name";
                                                ACAExamCourseRegistration."Student Name" := ACAExamClassificationStuds."Student Name";
                                                ACAExamCourseRegistration.Cohort := ACAExamClassificationStuds.Cohort;
                                                ACAExamCourseRegistration."Final Stage" := ACAExamClassificationStuds."Final Stage";
                                                ACAExamCourseRegistration."Final Academic Year" := ACAExamClassificationStuds."Final Academic Year";
                                                ACAExamCourseRegistration."Final Year of Study" := ACAExamClassificationStuds."Final Year of Study";
                                                ACAExamCourseRegistration."Admission Date" := ACAExamClassificationStuds."Admission Date";
                                                ACAExamCourseRegistration."Admission Academic Year" := ACAExamClassificationStuds."Admission Academic Year";

                                                if ((Progyz.Category = Progyz.Category::Certificate) or
                                                   (Progyz.Category = Progyz.Category::"Course List") or
                                                   (Progyz.Category = Progyz.Category::Professional)) then begin
                                                    ACAExamCourseRegistration."Category Order" := 2;
                                                end else
                                                    if (Progyz.Category = Progyz.Category::Diploma) then begin
                                                        ACAExamCourseRegistration."Category Order" := 3;
                                                    end else
                                                        if (Progyz.Category = Progyz.Category::Postgraduate) then begin
                                                            ACAExamCourseRegistration."Category Order" := 4;
                                                        end else
                                                            if (Progyz.Category = Progyz.Category::Undergraduate) then begin
                                                                ACAExamCourseRegistration."Category Order" := 1;
                                                            end;

                                                ACAExamCourseRegistration.Graduating := false;
                                                ACAExamCourseRegistration.Classification := '';
                                                ACAExamCourseRegistration.Insert;
                                            end;
                                            /////////////////////////////////////// end of YoS Tracker

                                            //Get best CAT Marks
                                            StudentUnits."Unit not in Catalogue" := false;

                                            UnitsSubjects.Reset;
                                            UnitsSubjects.SetRange("Programme Code", StudentUnits.Programme);
                                            UnitsSubjects.SetRange(Code, StudentUnits.Unit);
                                            if UnitsSubjects.Find('-') then begin

                                                ACAExamClassificationUnits.Reset;
                                                ACAExamClassificationUnits.SetRange("Student No.", Coregcs."Student No.");
                                                ACAExamClassificationUnits.SetRange(Programme, Coregcs.Programmes);
                                                ACAExamClassificationUnits.SetRange("Unit Code", StudentUnits.Unit);
                                                //    ACAExamClassificationUnits.SETRANGE("Reporting Academic Year",GradAcademicYear);
                                                ACAExamClassificationUnits.SetRange("Academic Year", GradAcademicYear);
                                                if not ACAExamClassificationUnits.Find('-') then begin
                                                    ACAExamClassificationUnits.Init;
                                                    ACAExamClassificationUnits."Student No." := Coregcs."Student No.";
                                                    ACAExamClassificationUnits.Programme := Coregcs.Programmes;
                                                    ACAExamClassificationUnits."Reporting Academic Year" := GradAcademicYear;
                                                    ACAExamClassificationUnits."School Code" := Progyz."School Code";
                                                    // //            ACAExamClassificationUnits."Department Code":=Progyz."Department Code";
                                                    ACAExamClassificationUnits."Unit Code" := StudentUnits.Unit;
                                                    ACAExamClassificationUnits."Credit Hours" := UnitsSubjects."Credit Hours";
                                                    ACAExamClassificationUnits."Unit Type" := Format(UnitsSubjects."Unit Type");
                                                    ACAExamClassificationUnits."Unit Description" := UnitsSubjects.Desription;
                                                    //            IF ACACourseRegistration."Year Of Study"=0 THEN
                                                    //              ACACourseRegistration."Year Of Study":=GetYearOfStudy(ACACourseRegistration.Stage);
                                                    ACAExamClassificationUnits."Year of Study" := ACAExamCourseRegistration."Year of Study";
                                                    ACAExamClassificationUnits."Academic Year" := GradAcademicYear;

                                                    ExamResults.Reset;
                                                    ExamResults.SetRange("Student No.", StudentUnits."Student No.");
                                                    ExamResults.SetRange(Unit, StudentUnits.Unit);
                                                    if ExamResults.Find('-') then begin
                                                        ExamResults.CalcFields("Number of Repeats", "Number of Resits");
                                                        if ExamResults."Number of Repeats" > 0 then
                                                            ACAExamClassificationUnits."No. of Repeats" := ExamResults."Number of Repeats" - 1;
                                                        if ExamResults."Number of Resits" > 0 then
                                                            ACAExamClassificationUnits."No. of Resits" := ExamResults."Number of Resits" - 1;
                                                    end;

                                                    ACAExamClassificationUnits.Insert;
                                                end;

                                                /////////////////////////// Update Unit Score
                                                ACAExamClassificationUnits.Reset;
                                                ACAExamClassificationUnits.SetRange("Student No.", Coregcs."Student No.");
                                                ACAExamClassificationUnits.SetRange(Programme, Coregcs.Programmes);
                                                ACAExamClassificationUnits.SetRange("Unit Code", StudentUnits.Unit);
                                                ACAExamClassificationUnits.SetRange("Academic Year", GradAcademicYear);
                                                ACAExamClassificationUnits.SetRange("Reporting Academic Year", GradAcademicYear);
                                                if ACAExamClassificationUnits.Find('-') then begin
                                                    // //
                                                    // //              ClassStudentUnits.RESET;
                                                    // //              ClassStudentUnits.SETRANGE("Student No.",ACAExamClassificationUnits."Student No.");
                                                    // //              ClassStudentUnits.SETRANGE(Programme,ACAExamClassificationUnits.Programme);
                                                    // //            //  ClassStudentUnits.SETRANGE("Reg Reversed",FALSE);
                                                    // //              ClassStudentUnits.SETRANGE(Unit,ACAExamClassificationUnits."Unit Code");
                                                    // //              IF ClassStudentUnits.FIND('+') THEN BEGIN
                                                    //Get CAT Marks
                                                    // //                ClassExamResults.RESET;
                                                    // //                ClassExamResults.SETRANGE("Student No.",ACAExamClassificationUnits."Student No.");
                                                    // //                ClassExamResults.SETRANGE(Unit,ACAExamClassificationUnits."Unit Code");
                                                    // //                ClassExamResults.SETFILTER(Exam,'%1|%2','ASSIGNMENT','CAT');
                                                    // //                ClassExamResults.SETCURRENTKEY(Semester);
                                                    // //                IF ClassExamResults.FIND('+') THEN BEGIN
                                                    // // // // // // // //              IF StudentUnits."CATs Marks Exists" THEN BEGIN
                                                    // // // // // // // //                  ACAExamClassificationUnits."CAT Score":=FORMAT(StudentUnits."CATs Marks");
                                                    // // // // // // // //                  ACAExamClassificationUnits."CAT Score Decimal":=StudentUnits."CATs Marks";
                                                    // // // // // // // //                    END;
                                                    // // // // // // // // // //                  END;
                                                    // // // // // // // //              //Get Exam Marks
                                                    // // // // // // // // // //                ClassExamResults.RESET;
                                                    // // // // // // // // // //                ClassExamResults.SETRANGE("Student No.",ACAExamClassificationUnits."Student No.");
                                                    // // // // // // // // // //                ClassExamResults.SETRANGE(Unit,ACAExamClassificationUnits."Unit Code");
                                                    // // // // // // // // // //                ClassExamResults.SETFILTER(Exam,'%1|%2|%3|%4','EXAM','EXAM100','EXAMS','FINAL EXAM');
                                                    // // // // // // // // // //                ClassExamResults.SETCURRENTKEY(Semester);
                                                    // // // // // // // // // //                IF ClassExamResults.FIND('+') THEN BEGIN
                                                    // // // // // // // //              IF StudentUnits."EXAMs Marks Exists" THEN BEGIN
                                                    // // // // // // // //                  ACAExamClassificationUnits."Exam Score":=FORMAT(StudentUnits."EXAMs Marks");
                                                    // // // // // // // //                  ACAExamClassificationUnits."Exam Score Decimal":=StudentUnits."EXAMs Marks";
                                                    // // // // // // // //                  END;
                                                    // //                  END;

                                                    //  IF ACAExamClassificationUnits."Exam Score"='' THEN BEGIN
                                                    ACAExamResults_Fin.Reset;
                                                    ACAExamResults_Fin.SetRange("Student No.", StudentUnits."Student No.");
                                                    ACAExamResults_Fin.SetRange(Unit, StudentUnits.Unit);
                                                    ACAExamResults_Fin.SetFilter(Exam, '%1|%2|%3|%4', 'EXAM', 'EXAM100', 'EXAMS', 'FINAL EXAM');
                                                    ACAExamResults_Fin.SetCurrentKey(Score);
                                                    if ACAExamResults_Fin.Find('+') then begin
                                                        ACAExamClassificationUnits."Exam Score" := Format(ACAExamResults_Fin.Score);
                                                        ACAExamClassificationUnits."Exam Score Decimal" := ACAExamResults_Fin.Score;
                                                    end;
                                                    //     END;

                                                    //   IF ACAExamClassificationUnits."CAT Score"='' THEN BEGIN
                                                    ACAExamResults_Fin.Reset;
                                                    ACAExamResults_Fin.SetRange("Student No.", StudentUnits."Student No.");
                                                    ACAExamResults_Fin.SetRange(Unit, StudentUnits.Unit);
                                                    ACAExamResults_Fin.SetFilter(Exam, '%1|%2|%3', 'ASSIGNMENT', 'CAT', 'CATS');
                                                    ACAExamResults_Fin.SetCurrentKey(Score);
                                                    if ACAExamResults_Fin.Find('+') then begin
                                                        ACAExamClassificationUnits."CAT Score" := Format(ACAExamResults_Fin.Score);
                                                        ACAExamClassificationUnits."CAT Score Decimal" := ACAExamResults_Fin.Score;
                                                    end;
                                                    // END;

                                                    //Update Total Marks
                                                    if ((ACAExamClassificationUnits."Exam Score" = '') and (ACAExamClassificationUnits."CAT Score" = '')) then begin
                                                        // //                    ACAExamClassificationUnits.Pass:=FALSE;
                                                        // //                    ACAExamClassificationUnits.Grade:='?';
                                                        // //                    ACAExamClassificationUnits."Grade Comment":='MISSED';
                                                        // //                    ACAExamClassificationUnits."Comsolidated Prefix":='?';
                                                        ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"None Exists";
                                                    end else
                                                        if ((ACAExamClassificationUnits."Exam Score" = '') and (ACAExamClassificationUnits."CAT Score" <> '')) then begin
                                                            // //                    ACAExamClassificationUnits.Pass:=FALSE;
                                                            // //                    ACAExamClassificationUnits.Grade:='!';
                                                            // //                    ACAExamClassificationUnits."Grade Comment":='INCOMPLETE';
                                                            // //                    ACAExamClassificationUnits."Comsolidated Prefix":='c';
                                                            ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"CAT Only";
                                                        end else
                                                            if ((ACAExamClassificationUnits."Exam Score" <> '') and (ACAExamClassificationUnits."CAT Score" = '')) then begin
                                                                // //                    ACAExamClassificationUnits.Pass:=FALSE;
                                                                // //                    ACAExamClassificationUnits.Grade:='!';
                                                                // //                    ACAExamClassificationUnits."Grade Comment":='INCOMPLETE';
                                                                // //                    ACAExamClassificationUnits."Comsolidated Prefix":='e';
                                                                ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"Exam Only";
                                                            end else
                                                                if ((ACAExamClassificationUnits."Exam Score" <> '') and (ACAExamClassificationUnits."CAT Score" <> '')) then begin
                                                                    ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"Both Exists";
                                                                end;

                                                    if ((ACAExamClassificationUnits."Exam Score" <> '') and (ACAExamClassificationUnits."CAT Score" <> '')) then begin
                                                        // //                 ACAExamClassificationUnits."Grade Comment":=GetGradeComment(ACAExamClassificationUnits."Total Score Decimal",ACAExamClassificationUnits."Unit Code",ACAExamClassificationUnits.Programme);
                                                        ACAExamClassificationUnits."Total Score" := Format(ACAExamClassificationUnits."Exam Score Decimal" + ACAExamClassificationUnits."CAT Score Decimal");
                                                        ACAExamClassificationUnits."Total Score Decimal" := ACAExamClassificationUnits."Exam Score Decimal" + ACAExamClassificationUnits."CAT Score Decimal";
                                                        ACAExamClassificationUnits."Weighted Total Score" := ACAExamClassificationUnits."Credit Hours" * ACAExamClassificationUnits."Total Score Decimal";
                                                        // //                  ACAExamClassificationUnits.Grade:=GetGrade(ACAExamClassificationUnits."Total Score Decimal",ACAExamClassificationUnits."Unit Code",ACAExamClassificationUnits.Programme);
                                                        // //                  ACAExamClassificationUnits.Pass:=GetUnitPassStatus(ACAExamClassificationUnits.Grade,ACAExamClassificationUnits."Unit Code",ACAExamClassificationUnits.Programme);
                                                        // //                  IF ACAExamClassificationUnits.Pass=FALSE THEN BEGIN
                                                        // //                    ACAExamClassificationUnits."Comsolidated Prefix":='^';
                                                        //  END;
                                                    end else begin
                                                        ACAExamClassificationUnits."Total Score" := Format(ACAExamClassificationUnits."Exam Score Decimal" + ACAExamClassificationUnits."CAT Score Decimal");
                                                        ACAExamClassificationUnits."Total Score Decimal" := ACAExamClassificationUnits."Exam Score Decimal" + ACAExamClassificationUnits."CAT Score Decimal";
                                                        ACAExamClassificationUnits."Weighted Total Score" := ACAExamClassificationUnits."Credit Hours" * ACAExamClassificationUnits."Total Score Decimal";
                                                    end;
                                                    ACAExamClassificationUnits."Allow In Graduate" := true;
                                                    /// Update Cummulative Resit
                                                    ACAExamClassificationUnits.CalcFields(Grade, "Grade Comment", "Comsolidated Prefix", Pass);
                                                    if not (ACAExamClassificationUnits.Pass) then begin
                                                        ACAExamCummulativeResit.Reset;
                                                        ACAExamCummulativeResit.SetRange("Student Number", StudentUnits."Student No.");
                                                        ACAExamCummulativeResit.SetRange("Unit Code", ACAExamClassificationUnits."Unit Code");
                                                        ACAExamCummulativeResit.SetRange("Academic Year", Coregcs."Academic Year");
                                                        if not (ACAExamCummulativeResit.Find('-')) then begin
                                                            ACAExamCummulativeResit.Init;
                                                            ACAExamCummulativeResit."Student Number" := StudentUnits."Student No.";
                                                            ACAExamCummulativeResit."School Code" := ACAExamClassificationStuds."School Code";
                                                            ACAExamCummulativeResit."Academic Year" := StudentUnits."Academic Year";
                                                            ACAExamCummulativeResit."Unit Code" := ACAExamClassificationUnits."Unit Code";
                                                            ACAExamCummulativeResit."Student Name" := ACAExamClassificationStuds."Student Name";
                                                            ACAExamCummulativeResit.Programme := StudentUnits.Programme;
                                                            ACAExamCummulativeResit."School Name" := ACAExamClassificationStuds."School Name";
                                                            ACAExamCummulativeResit."Unit Description" := UnitsSubjects.Desription;
                                                            ACAExamCummulativeResit."Credit Hours" := UnitsSubjects."Credit Hours";
                                                            ACAExamCummulativeResit."Unit Type" := ACAExamClassificationUnits."Unit Type";
                                                            ACAExamCummulativeResit.Score := ACAExamClassificationUnits."Total Score Decimal";
                                                            ACAExamCummulativeResit.Grade := ACAExamClassificationUnits.Grade;
                                                            if ACAExamCummulativeResit.Insert then;
                                                        end;
                                                    end;
                                                    if ACAExamClassificationUnits.Modify then;
                                                    //////////////////////////// Update Units Scores.. End
                                                end else begin
                                                    StudentUnits."Unit not in Catalogue" := true;
                                                end;
                                            end;
                                            StudentUnits.Modify;
                                            ///////////////////////////////////////////////////////////////// iiiiiiiiiiiiiiiiiiiiiiii End of Finalize Units
                                        end;

                                        until StudentUnits.Next = 0;
                                    end;

                                end;
                                until Coregcs.Next = 0;
                                Progressbar.Close;
                            end;

                            //Update Senate Header
                            // // // // // // //
                            // // // // // // //            ACASenateReportsHeader.RESET;
                            // // // // // // //            ACASenateReportsHeader.SETFILTER("Programme Code",ProgFIls);
                            // // // // // // //            ACASenateReportsHeader.SETFILTER("Academic Year",GradAcademicYear);
                            // // // // // // //            IF ACASenateReportsHeader.FIND('-') THEN ACASenateReportsHeader.DELETEALL;
                            // // // // // // //
                            // // // // // // // ACAExamCourseRegistration.RESET;
                            // // // // // // // ACAExamCourseRegistration.SETFILTER(Programme,ProgFIls);
                            // // // // // // // ACAExamCourseRegistration.SETFILTER("Academic Year",GradAcademicYear);
                            // // // // // // // IF ACAExamCourseRegistration.FIND('-') THEN BEGIN
                            // // // // // // //  TotalRecs:=ACAExamCourseRegistration.COUNT;
                            // // // // // // //  RemeiningRecs:=TotalRecs;
                            // // // // // // //  ProgBar2.OPEN('#1#####################################################\'+
                            // // // // // // //  '#2############################################################\'+
                            // // // // // // //  '#3###########################################################\'+
                            // // // // // // //  '#4############################################################\'+
                            // // // // // // //  '#5###########################################################\'+
                            // // // // // // //  '#6############################################################');
                            // // // // // // //     ProgBar2.UPDATE(1,'2 of 3 Updating Class Items');
                            // // // // // // //     ProgBar2.UPDATE(2,'Total Recs.: '+FORMAT(TotalRecs));
                            // // // // // // //    REPEAT
                            // // // // // // //      BEGIN
                            // // // // // // // ACAExamFailedReasons.RESET;
                            // // // // // // // ACAExamFailedReasons.SETRANGE("Student No.",ACAExamCourseRegistration."Student Number");
                            // // // // // // // IF ACAExamFailedReasons.FIND('-') THEN ACAExamFailedReasons.DELETEALL;
                            // // // // // // //      CountedRecs+=1;
                            // // // // // // //      RemeiningRecs-=1;
                            // // // // // // //     ProgBar2.UPDATE(3,'.....................................................');
                            // // // // // // //     ProgBar2.UPDATE(4,'Processed: '+FORMAT(CountedRecs));
                            // // // // // // //     ProgBar2.UPDATE(5,'Remaining: '+FORMAT(RemeiningRecs));
                            // // // // // // //     ProgBar2.UPDATE(6,'----------------------------------------------------');
                            // // // // // // //
                            // // // // // // // // //
                            // // // // // // // // //            ACAResultsStatus.RESET;
                            // // // // // // // // //            ACAResultsStatus.SETRANGE("Special Programme Class",Progyz."Special Programme Class");
                            // // // // // // // // //            ACAResultsStatus.SETRANGE("Academic Year",ACAExamCourseRegistration."Academic Year");
                            // // // // // // // // //            IF ACAResultsStatus.FIND('-') THEN BEGIN
                            // // // // // // // // //              REPEAT
                            // // // // // // // // //                  BEGIN
                            // // // // // // // // //                  ACASenateReportsHeader.RESET;
                            // // // // // // // // //                  ACASenateReportsHeader.SETRANGE("Academic Year",ACAExamCourseRegistration."Academic Year");
                            // // // // // // // // //                  ACASenateReportsHeader.SETRANGE("School Code",Progyz."School Code");
                            // // // // // // // // //                  ACASenateReportsHeader.SETRANGE("Classification Code",ACAResultsStatus.Code);
                            // // // // // // // // //                  ACASenateReportsHeader.SETRANGE("Programme Code",Progyz.Code);
                            // // // // // // // // //                  ACASenateReportsHeader.SETRANGE("Year of Study",ACAExamCourseRegistration."Year of Study");
                            // // // // // // // // //                  IF NOT (ACASenateReportsHeader.FIND('-')) THEN BEGIN
                            // // // // // // // // //                    ACASenateReportsHeader.INIT;
                            // // // // // // // // //                    ACASenateReportsHeader."Academic Year":=ACAExamCourseRegistration."Academic Year";
                            // // // // // // // // //                    ACASenateReportsHeader."Reporting Academic Year":=ACAExamCourseRegistration."Academic Year";
                            // // // // // // // // //                    ACASenateReportsHeader."Rubric Order":=ACAResultsStatus."Order No";
                            // // // // // // // // //                    ACASenateReportsHeader."Programme Code":=Progyz.Code;
                            // // // // // // // // //                    ACASenateReportsHeader."School Code":=Progyz."School Code";
                            // // // // // // // // //                    ACASenateReportsHeader."Year of Study":=ACAExamCourseRegistration."Year of Study";
                            // // // // // // // // //                    ACASenateReportsHeader."Classification Code":=ACAResultsStatus.Code;
                            // // // // // // // // //                    ACASenateReportsHeader."Status Msg6":=ACAResultsStatus."Status Msg6";
                            // // // // // // // // //                    ACASenateReportsHeader."IncludeVariable 1":=ACAResultsStatus."IncludeVariable 1";
                            // // // // // // // // //                    ACASenateReportsHeader."IncludeVariable 2":=ACAResultsStatus."IncludeVariable 2";
                            // // // // // // // // //                    ACASenateReportsHeader."IncludeVariable 3":=ACAResultsStatus."IncludeVariable 3";
                            // // // // // // // // //                    ACASenateReportsHeader."IncludeVariable 4":=ACAResultsStatus."IncludeVariable 4";
                            // // // // // // // // //                    ACASenateReportsHeader."IncludeVariable 5":=ACAResultsStatus."IncludeVariable 5";
                            // // // // // // // // //                    ACASenateReportsHeader."IncludeVariable 6":=ACAResultsStatus."IncludeVariable 6";
                            // // // // // // // // //                    ACASenateReportsHeader."Summary Page Caption":=ACAResultsStatus."Summary Page Caption";
                            // // // // // // // // //                    ACASenateReportsHeader."Include Failed Units Headers":=ACAResultsStatus."Include Failed Units Headers";
                            // // // // // // // // //                    ACASenateReportsHeader."Include Academic Year Caption":=ACAResultsStatus."Include Academic Year Caption";
                            // // // // // // // // //                    ACASenateReportsHeader."Academic Year Text":=ACAResultsStatus."Academic Year Text";
                            // // // // // // // // //                    ACASenateReportsHeader."Status Msg1":=ACAResultsStatus."Status Msg1";
                            // // // // // // // // //                    ACASenateReportsHeader."Status Msg2":=ACAResultsStatus."Status Msg2";
                            // // // // // // // // //                    ACASenateReportsHeader."Status Msg3":=ACAResultsStatus."Status Msg3";
                            // // // // // // // // //                    ACASenateReportsHeader."Status Msg4":=ACAResultsStatus."Status Msg4";
                            // // // // // // // // //                    ACASenateReportsHeader."Status Msg5":=ACAResultsStatus."Status Msg5";
                            // // // // // // // // //                    ACASenateReportsHeader."Status Msg6":=ACAResultsStatus."Status Msg6";
                            // // // // // // // // //                    ACASenateReportsHeader."Grad. Status Msg 1":=ACAResultsStatus."Grad. Status Msg 1";
                            // // // // // // // // //                    ACASenateReportsHeader."Grad. Status Msg 2":=ACAResultsStatus."Grad. Status Msg 2";
                            // // // // // // // // //                    ACASenateReportsHeader."Grad. Status Msg 3":=ACAResultsStatus."Grad. Status Msg 3";
                            // // // // // // // // //                    ACASenateReportsHeader."Grad. Status Msg 4":=ACAResultsStatus."Grad. Status Msg 4";
                            // // // // // // // // //                    ACASenateReportsHeader."Grad. Status Msg 5":=ACAResultsStatus."Grad. Status Msg 5";
                            // // // // // // // // //                    ACASenateReportsHeader."Grad. Status Msg 6":=ACAResultsStatus."Grad. Status Msg 6";
                            // // // // // // // // //                    ACASenateReportsHeader."Finalists Graduation Comments":=ACAResultsStatus."Finalists Grad. Comm. Degree";
                            // // // // // // // // //                    ACASenateReportsHeader."1st Year Grad. Comments":=ACAResultsStatus."1st Year Grad. Comments";
                            // // // // // // // // //                    ACASenateReportsHeader."2nd Year Grad. Comments":=ACAResultsStatus."2nd Year Grad. Comments";
                            // // // // // // // // //                    ACASenateReportsHeader."3rd Year Grad. Comments":=ACAResultsStatus."3rd Year Grad. Comments";
                            // // // // // // // // //                    ACASenateReportsHeader."4th Year Grad. Comments":=ACAResultsStatus."4th Year Grad. Comments";
                            // // // // // // // // //                    ACASenateReportsHeader."5th Year Grad. Comments":=ACAResultsStatus."5th Year Grad. Comments";
                            // // // // // // // // //                    ACASenateReportsHeader."6th Year Grad. Comments":=ACAResultsStatus."6th Year Grad. Comments";
                            // // // // // // // // //                    ACASenateReportsHeader."7th Year Grad. Comments":=ACAResultsStatus."7th Year Grad. Comments";
                            // // // // // // // // //                    ACASenateReportsHeader.INSERT;
                            // // // // // // // // //                    END;
                            // // // // // // // // //                  END;
                            // // // // // // // // //                UNTIL ACAResultsStatus.NEXT=0;
                            // // // // // // // // //              END;
                            // // // // // // //      END;
                            // // // // // // //        UNTIL ACAExamCourseRegistration.NEXT=0;
                            // // // // // // //        ProgBar2.CLOSE;
                            // // // // // // //        END;
                            // // // // // // //



                            ////////////////////////////////////////////////////////////////////////////////////////////////////////////
                            ////////////////////////////////////////////////////////////////////////////////////////////////////////////
                            ////////////////////////////////////////////////////////////////////////////////////////////////////////////
                            //......................................................................................Compute Averages Here
                            ////////////////////////////////////////////////////////////////////////////////////////////////////////////
                            ////////////////////////////////////////////////////////////////////////////////////////////////////////////
                            ////////////////////////////////////////////////////////////////////////////////////////////////////////////


                            // Update Averages
                            Clear(TotalRecs);
                            Clear(CountedRecs);
                            Clear(RemeiningRecs);
                            Clear(ACAExamClassificationStuds);
                            ACAExamCourseRegistration.Reset;
                            ACAExamCourseRegistration.SetFilter("Reporting Academic Year", GradAcademicYear);
                            if StudNos <> '' then
                                ACAExamCourseRegistration.SetFilter("Student Number", StudNos) else
                                ACAExamCourseRegistration.SetFilter(Programme, ProgFIls);// Only Apply Prog & School if Student FIlter is not Applied
                            if ACAExamCourseRegistration.Find('-') then begin
                                TotalRecs := ACAExamCourseRegistration.Count;
                                RemeiningRecs := TotalRecs;
                                ProgBar2.Open('#1#####################################################\' +
                                '#2############################################################\' +
                                '#3###########################################################\' +
                                '#4############################################################\' +
                                '#5###########################################################\' +
                                '#6############################################################');
                                ProgBar2.Update(1, '3 of 3 Updating Class Items');
                                ProgBar2.Update(2, 'Total Recs.: ' + Format(TotalRecs));
                                repeat
                                begin
                                    Progyz.Reset;
                                    Progyz.SetRange(Code, ACAExamCourseRegistration.Programme);
                                    if Progyz.Find('-') then;
                                    CountedRecs += 1;
                                    RemeiningRecs -= 1;
                                    ProgBar2.Update(3, '.....................................................');
                                    ProgBar2.Update(4, 'Processed: ' + Format(CountedRecs));
                                    ProgBar2.Update(5, 'Remaining: ' + Format(RemeiningRecs));
                                    ProgBar2.Update(6, '----------------------------------------------------');
                                    ACAExamCourseRegistration.CalcFields("Total Marks", "Total Courses", "Total Weighted Marks",
                                    "Total Units", "Classified Total Marks", "Total Classified C. Count", "Classified W. Total", "Attained Stage Units", Average, "Classified Total Marks");
                                    //   IF ACAExamCourseRegistration."Total Courses"<>0 THEN
                                    ACAExamCourseRegistration."Normal Average" := Round((ACAExamCourseRegistration.Average), 0.01, '=');
                                    // ACAExamCourseRegistration."Normal Average":=ROUND((ACAExamCourseRegistration."Total Marks"/ACAExamCourseRegistration."Total Courses"),0.01,'=');
                                    //          IF ACAExamCourseRegistration."Total Units"<>0 THEN
                                    //          ACAExamCourseRegistration."Weighted Average":=ROUND((ACAExamCourseRegistration."Total Weighted Marks"/ACAExamCourseRegistration."Total Units"),0.01,'=');
                                    if ACAExamCourseRegistration."Total Classified C. Count" <> 0 then
                                        ACAExamCourseRegistration."Classified Average" := Round((ACAExamCourseRegistration."Classified Total Marks" / ACAExamCourseRegistration."Total Classified C. Count"), 0.01, '=');
                                    if ACAExamCourseRegistration."Total Classified Units" <> 0 then
                                        ACAExamCourseRegistration."Classified W. Average" := Round((ACAExamCourseRegistration."Classified W. Total" / ACAExamCourseRegistration."Total Classified Units"), 0.01, '=');
                                    ACAExamCourseRegistration."Required Stage Units" := RequiredStageUnits(ACAExamCourseRegistration.Programme,
                                    ACAExamCourseRegistration."Year of Study", ACAExamCourseRegistration."Student Number");
                                    if ACAExamCourseRegistration."Required Stage Units" > ACAExamCourseRegistration."Attained Stage Units" then
                                        ACAExamCourseRegistration."Units Deficit" := ACAExamCourseRegistration."Required Stage Units" - ACAExamCourseRegistration."Attained Stage Units";
                                    ACAExamCourseRegistration."Multiple Programe Reg. Exists" := GetMultipleProgramExists(ACAExamCourseRegistration."Student Number");

                                    //     IF ((ACAExamCourseRegistration."Student Number"='SC/00002/016') AND (ACAExamCourseRegistration."Academic Year"='2019/2020')) THEN
                                    //       CLEAR(Tens);
                                    ACAExamCourseRegistration."Final Classification" := GetRubric(Progyz, ACAExamCourseRegistration);
                                    ACAExamCourseRegistration."Final Classification Pass" := GetRubricPassStatus(ACAExamCourseRegistration."Final Classification",
                                    ACAExamCourseRegistration."Academic Year", Progyz);
                                    ACAExamCourseRegistration."Final Classification Order" := GetRubricOrder(ACAExamCourseRegistration."Final Classification");
                                    ACAExamCourseRegistration.Graduating := GetRubricPassStatus(ACAExamCourseRegistration."Final Classification",
                                    ACAExamCourseRegistration."Academic Year", Progyz);
                                    ACAExamCourseRegistration.Classification := GetRubric(Progyz, ACAExamCourseRegistration);

                                    // //           IF ((ACAExamCourseRegistration."Total Courses"=0) OR (ACAExamCourseRegistration."Units Deficit">0)) THEN BEGIN
                                    // //             IF ACAExamCourseRegistration.Classification='PASS LIST' THEN BEGIN
                                    // //           ACAExamCourseRegistration."Final Classification":='HALT';
                                    // //           ACAExamCourseRegistration."Final Classification Pass":=FALSE;
                                    // //           ACAExamCourseRegistration."Final Classification Order":=10;
                                    // //           ACAExamCourseRegistration.Graduating:=FALSE;
                                    // //           ACAExamCourseRegistration.Classification:='HALT';
                                    // //               END;
                                    if ACAExamCourseRegistration."Total Courses" = 0 then begin
                                        ACAExamCourseRegistration."Final Classification" := 'HALT';
                                        ACAExamCourseRegistration."Final Classification Pass" := false;
                                        ACAExamCourseRegistration."Final Classification Order" := 10;
                                        ACAExamCourseRegistration.Graduating := false;
                                        ACAExamCourseRegistration.Classification := 'HALT';
                                    end;
                                    // END;
                                    ACAExamCourseRegistration.CalcFields("Total Marks",
                       "Total Weighted Marks",
                       "Total Failed Courses",
                       "Total Failed Units",
                       "Failed Courses",
                       "Failed Units",
                       "Failed Cores",
                       "Failed Required",
                       "Failed Electives",
                       "Total Cores Done",
                       "Total Cores Passed",
                       "Total Required Done",
                       "Total Electives Done",
                       "Tota Electives Passed");
                                    ACAExamCourseRegistration.CalcFields(
                                    "Classified Electives C. Count",
                                    "Classified Electives Units",
                                    "Total Classified C. Count",
                                    "Total Classified Units",
                                    "Classified Total Marks",
                                    "Classified W. Total",
                                    "Total Failed Core Units");
                                    ACAExamCourseRegistration."Cummulative Fails" := GetCummulativeFails(ACAExamCourseRegistration."Student Number", ACAExamCourseRegistration."Year of Study");
                                    ACAExamCourseRegistration."Cumm. Required Stage Units" := GetCummulativeReqStageUnitrs(ACAExamCourseRegistration.Programme, ACAExamCourseRegistration."Year of Study", ACAExamCourseRegistration."Programme Option");
                                    ACAExamCourseRegistration."Cumm Attained Units" := GetCummAttainedUnits(ACAExamCourseRegistration."Student Number", ACAExamCourseRegistration."Year of Study", ACAExamCourseRegistration.Programme);
                                    ACAExamCourseRegistration.Modify;

                                end;
                                until ACAExamCourseRegistration.Next = 0;
                                ProgBar2.Close;
                            end;

                            ACASenateReportsHeader.Reset;
                            ACASenateReportsHeader.SetFilter("Programme Code", ProgFIls);
                            ACASenateReportsHeader.SetFilter("Reporting Academic Year", GradAcademicYear);
                            if ACASenateReportsHeader.Find('-') then begin
                                ProgBar22.Open('#1##########################################');
                                repeat
                                begin
                                    ProgBar22.Update(1, 'Student Number: ' + ACASenateReportsHeader."Programme Code" + ' Class: ' + ACASenateReportsHeader."Classification Code");

                                    ACASenateReportsHeader.CalcFields("School Classification Count", "School Total Passed", "School Total Passed",
"School Total Failed", "Programme Classification Count", "Programme Total Passed", "Programme Total Failed", "School Total Count",
"Prog. Total Count", School_AcadYear_Count, School_AcadYear_Status_Count, School_AcadYearTrans_Count);

                                    if ACASenateReportsHeader."School Total Count" > 0 then
                                        ACASenateReportsHeader."Sch. Class % Value" := Round(((ACASenateReportsHeader."School Classification Count" / ACASenateReportsHeader."School Total Count") * 100), 0.01, '=');
                                    if ACASenateReportsHeader."School Total Count" > 0 then
                                        ACASenateReportsHeader."School % Failed" := Round(((ACASenateReportsHeader."School Total Failed" / ACASenateReportsHeader."School Total Count") * 100), 0.01, '=');
                                    if ACASenateReportsHeader."School Total Count" > 0 then
                                        ACASenateReportsHeader."School % Passed" := Round(((ACASenateReportsHeader."School Total Passed" / ACASenateReportsHeader."School Total Count") * 100), 0.01, '=');

                                    if ACASenateReportsHeader."Prog. Total Count" > 0 then
                                        ACASenateReportsHeader."Prog. Class % Value" := Round(((ACASenateReportsHeader."Programme Classification Count" / ACASenateReportsHeader."Prog. Total Count") * 100), 0.01, '=');
                                    if ACASenateReportsHeader."Prog. Total Count" > 0 then
                                        ACASenateReportsHeader."Programme % Failed" := Round(((ACASenateReportsHeader."Programme Total Failed" / ACASenateReportsHeader."Prog. Total Count") * 100), 0.01, '=');
                                    if ACASenateReportsHeader."Prog. Total Count" > 0 then
                                        ACASenateReportsHeader."Programme % Passed" := Round(((ACASenateReportsHeader."Programme Total Passed" / ACASenateReportsHeader."Prog. Total Count") * 100), 0.01, '=');
                                    ACASenateReportsHeader.Modify;
                                end;
                                until ACASenateReportsHeader.Next = 0;
                                ProgBar22.Close;
                            end;
                            // //
                            // //                CLEAR(SEQUENCES);
                            // //                CLEAR(CountedNos);
                            // //            REPEAT
                            // //              BEGIN
                            // //              CountedNos:=CountedNos+1;
                            // //              CLEAR(CurrSchool);
                            // //        ACAExamCourseRegistration.RESET;
                            // //        ACAExamCourseRegistration.SETRANGE("Year of Study",CountedNos);
                            // //        ACAExamCourseRegistration.SETRANGE("Academic Year",GradAcademicYear);
                            // //        ACAExamCourseRegistration.SETRANGE("Resit Exists",TRUE);
                            // //        ACAExamCourseRegistration.SETCURRENTKEY("Academic Year","Year of Study","Student Number");
                            // //        IF  ACAExamCourseRegistration.FIND('-') THEN BEGIN
                            // //                CLEAR(SEQUENCES);
                            // //          REPEAT
                            // //              BEGIN
                            // //              IF CurrSchool<>ACAExamCourseRegistration."School Code" THEN BEGIN
                            // //                CurrSchool:=ACAExamCourseRegistration."School Code";
                            // //                CLEAR(SEQUENCES);
                            // //
                            // //                END;
                            // //              SEQUENCES:=SEQUENCES+1;
                            // //              ACAExamCourseRegistration."Cumm. Resit Serial":=SEQUENCES;
                            // //              ACAExamCourseRegistration.MODIFY;
                            // //              END;
                            // //            UNTIL ACAExamCourseRegistration.NEXT=0;
                            // //          END;
                            // //          END;
                            // //          UNTIL CountedNos=8;

                            // //
                            // //                CLEAR(SEQUENCES);
                            // //                CLEAR(CurrStudentNo);
                            // //          ACAExamCummulativeResit.RESET;
                            // //        ACAExamCummulativeResit.SETRANGE("Academic Year",GradAcademicYear);
                            // //        ACAExamCummulativeResit.SETFILTER(Programme,ProgFIls);
                            // //        ACAExamCummulativeResit.SETCURRENTKEY(Programme,"Student Number");
                            // //        IF ACAExamCummulativeResit.FIND('-') THEN BEGIN
                            // //          REPEAT
                            // //            BEGIN
                            // //             IF CurrStudentNo<> ACAExamCummulativeResit."Student Number" THEN BEGIN
                            // //               CurrStudentNo:= ACAExamCummulativeResit."Student Number";
                            // //               SEQUENCES:=SEQUENCES+1;
                            // //
                            // //               END;
                            // //               ACAExamCummulativeResit.Serial:=SEQUENCES;
                            // //               ACAExamCummulativeResit.MODIFY;
                            // //            END;
                            // //            UNTIL ACAExamCummulativeResit.NEXT=0;
                            // //          END;








                            if GetProgFilters2(programs, Schools) <> '' then begin
                                Clear(ProgFIls);

                                // Clear CLassification For Selected Filters
                                ProgFIls := GetProgFilters2(programs, Schools);
                                ACAExamClassificationStuds.Reset;
                                ACAExamCourseRegistration.Reset;
                                ACAExamClassificationUnits.Reset;
                                if StudNos <> '' then begin
                                    ACAExamClassificationStuds.SetFilter("Student Number", StudNos);
                                    ACAExamCourseRegistration.SetRange("Student Number", StudNos);
                                    ACAExamClassificationUnits.SetRange("Student No.", StudNos);
                                end;

                                if GradAcademicYear <> '' then begin
                                    ACAExamClassificationStuds.SetFilter("Academic Year", GradAcademicYear);
                                    ACAExamCourseRegistration.SetFilter("Academic Year", GradAcademicYear);
                                    ACAExamClassificationUnits.SetFilter("Academic Year", GradAcademicYear);
                                end;

                                ACAExamClassificationStuds.SetFilter(Programme, ProgFIls);
                                ACAExamCourseRegistration.SetFilter(Programme, ProgFIls);
                                ACAExamClassificationUnits.SetFilter(Programme, ProgFIls);
                                if ACAExamClassificationStuds.Find('-') then ACAExamClassificationStuds.DeleteAll;
                                if ACAExamCourseRegistration.Find('-') then ACAExamCourseRegistration.DeleteAll;
                                if ACAExamClassificationUnits.Find('-') then ACAExamClassificationUnits.DeleteAll;


                                ACASenateReportsHeader.Reset;
                                ACASenateReportsHeader.SetRange("Academic Year", GradAcademicYear);
                                ACASenateReportsHeader.SetFilter("Programme Code", ProgFIls);
                                if (ACASenateReportsHeader.Find('-')) then ACASenateReportsHeader.DeleteAll;

                                Coregcs.Reset;
                                Coregcs.SetFilter(Programmes, ProgFIls);
                                Coregcs.SetRange("Academic Year", GradAcademicYear);
                                Coregcs.SetRange(Reversed, false);
                                Coregcs.SetFilter(Status, '<>%1', StudentUnits.Status::Alluminae);
                                if StudNos <> '' then begin
                                    Coregcs.SetFilter("Student No.", StudNos);
                                end;
                                if Coregcs.Find('-') then begin
                                    Clear(TotalRecs);
                                    Clear(RemeiningRecs);
                                    Clear(CountedRecs);
                                    TotalRecs := Coregcs.Count;
                                    RemeiningRecs := TotalRecs;
                                    // Loop through all Ungraduated Students Units
                                    Progressbar.Open('#1#####################################################\' +
                                    '#2############################################################\' +
                                    '#3###########################################################\' +
                                    '#4############################################################\' +
                                    '#5###########################################################\' +
                                    '#6############################################################');
                                    Progressbar.Update(1, 'Processing  values....');
                                    Progressbar.Update(2, 'Total Recs.: ' + Format(TotalRecs));
                                    repeat
                                    begin

                                        CountedRecs := CountedRecs + 1;
                                        RemeiningRecs := RemeiningRecs - 1;
                                        // Create Registration Unit entry if Not Exists
                                        Progressbar.Update(3, '.....................................................');
                                        Progressbar.Update(4, 'Processed: ' + Format(CountedRecs));
                                        Progressbar.Update(5, 'Remaining: ' + Format(RemeiningRecs));
                                        Progressbar.Update(6, '----------------------------------------------------');
                                        Progyz.Reset;
                                        Progyz.SetFilter(Code, Coregcs.Programmes);
                                        if Progyz.Find('-') then begin
                                        end;
                                        Clear(YosStages);
                                        if Coregcs."Year Of Study" = 0 then Coregcs.Validate(Stage);
                                        if Coregcs."Year Of Study" = 1 then
                                            YosStages := 'Y1S1|Y1S2|Y1S3|Y1S4'
                                        else
                                            if Coregcs."Year Of Study" = 2 then
                                                YosStages := 'Y2S1|Y2S2|Y2S3|Y2S4'
                                            else
                                                if Coregcs."Year Of Study" = 3 then
                                                    YosStages := 'Y3S1|Y3S2|Y3S3|Y3S4'
                                                else
                                                    if Coregcs."Year Of Study" = 4 then
                                                        YosStages := 'Y4S1|Y4S2|Y4S3|Y4S4'
                                                    else
                                                        if Coregcs."Year Of Study" = 5 then
                                                            YosStages := 'Y5S1|Y5S2|Y5S3|Y5S4'
                                                        else
                                                            if Coregcs."Year Of Study" = 6 then
                                                                YosStages := 'Y6S1|Y6S2|Y6S3|Y6S4'
                                                            else
                                                                if Coregcs."Year Of Study" = 7 then
                                                                    YosStages := 'Y7S1|Y7S2|Y7S3|Y7S4'
                                                                else
                                                                    if Coregcs."Year Of Study" = 8 then YosStages := 'Y8S1|Y8S2|Y8S3|Y8S4';

                                        ACAExamCummulativeResit.Reset;
                                        ACAExamCummulativeResit.SetRange("Student Number", StudentUnits."Student No.");
                                        ACAExamCummulativeResit.SetRange("Academic Year", GradAcademicYear);
                                        if ACAExamCummulativeResit.Find('-') then ACAExamCummulativeResit.DeleteAll;

                                        Custos.Reset;
                                        Custos.SetRange("No.", Coregcs."Student No.");
                                        if Custos.Find('-') then;
                                        Custos.CalcFields("Senate Classification Based on");

                                        StudentUnits.Reset;
                                        StudentUnits.SetRange("Student No.", Coregcs."Student No.");
                                        if Custos."Senate Classification Based on" = Custos."Senate Classification Based on"::"Year of Study" then
                                            StudentUnits.SetFilter("Unit Stage", YosStages)
                                        else
                                            StudentUnits.SetFilter("Academic Year (Flow)", Coregcs."Academic Year");

                                        if StudentUnits.Find('-') then begin //sdgfdfg

                                            repeat
                                            begin
                                                StudentUnits.CalcFields(StudentUnits."CATs Marks Exists");
                                                if StudentUnits."CATs Marks Exists" = false then begin
                                                    AcdYrs.Reset;
                                                    AcdYrs.SetRange(Code, StudentUnits."Academic Year");
                                                    AcdYrs.SetRange("Allow CATs Exempt", true);
                                                    if AcdYrs.Find('-') then begin
                                                        ExamResults.Init;
                                                        ExamResults."Student No." := StudentUnits."Student No.";
                                                        ExamResults.Programmes := StudentUnits.Programme;
                                                        ExamResults.Stage := StudentUnits.Stage;
                                                        ExamResults.Unit := StudentUnits.Unit;
                                                        ExamResults.Semester := StudentUnits.Semester;
                                                        ExamResults."Academic Year" := StudentUnits."Academic Year";
                                                        ExamResults."Reg. Transaction ID" := StudentUnits."Reg. Transacton ID";
                                                        ExamResults.ExamType := 'CAT';
                                                        ExamResults.Exam := 'CAT';
                                                        ExamResults."Exam Category" := Progyz."Exam Category";
                                                        ExamResults.Score := 0;
                                                        ExamResults."User Name" := 'AUTOPOST';
                                                        ExamResults.Insert;
                                                    end;
                                                end;
                                                ExamResults.Reset;
                                                ExamResults.SetRange("Student No.", StudentUnits."Student No.");
                                                ExamResults.SetRange(Unit, StudentUnits.Unit);
                                                if ExamResults.Find('-') then begin
                                                    repeat
                                                    begin
                                                        if ExamResults.ExamType <> '' then begin
                                                            ExamResults.Exam := ExamResults.ExamType;
                                                            ExamResults.Modify;
                                                        end else
                                                            if ExamResults.Exam <> '' then begin
                                                                if ExamResults.ExamType = '' then begin
                                                                    //ExamResults.ExamType:=ExamResults.Exam;
                                                                    ExamResults.Rename(ExamResults."Student No.", ExamResults.Programmes, ExamResults.Stage,
                                                                    ExamResults.Unit, ExamResults.Semester, ExamResults.Exam, ExamResults."Reg. Transaction ID", ExamResults."Entry No");
                                                                end;
                                                            end;
                                                    end;
                                                    until ExamResults.Next = 0;
                                                end;
                                                ///////////////////////////////////////////////////////////////// iiiiiiiiiiiiiiiiiiiiiiii Update Units
                                                ExamResults.Reset;
                                                ExamResults.SetFilter("Counted Occurances", '>%1', 1);
                                                ExamResults.SetRange("Student No.", StudentUnits."Student No.");
                                                ExamResults.SetRange(Unit, StudentUnits.Unit);
                                                if ExamResults.Find('-') then begin
                                                    repeat
                                                    begin
                                                        ACAExamResultsFin.Reset;
                                                        ACAExamResultsFin.SetRange("Student No.", StudentUnits."Student No.");
                                                        ACAExamResultsFin.SetRange(Programmes, StudentUnits.Programme);
                                                        ACAExamResultsFin.SetRange(Unit, StudentUnits.Unit);
                                                        ACAExamResultsFin.SetRange(Semester, StudentUnits.Semester);
                                                        ACAExamResultsFin.SetRange(ExamType, ExamResults.ExamType);
                                                        if ACAExamResultsFin.Find('-') then begin
                                                            ACAExamResultsFin.CalcFields("Counted Occurances");
                                                            if ACAExamResultsFin."Counted Occurances" > 1 then begin
                                                                ACAExamResultsFin.Delete;
                                                            end;
                                                        end;
                                                    end;
                                                    until ExamResults.Next = 0;
                                                end;
                                                ////////////////////////////////// Remove Multiple Occurances of a Mark
                                                ////////////////////////////////////////////////////////////////////////////
                                                // Grad Headers

                                                ACAResultsStatus.Reset;
                                                ACAResultsStatus.SetRange("Special Programme Class", Progyz."Special Programme Class");
                                                ACAResultsStatus.SetRange("Academic Year", GradAcademicYear);
                                                if ACAResultsStatus.Find('-') then begin
                                                    repeat
                                                    begin
                                                        ACASenateReportsHeader.Reset;
                                                        ACASenateReportsHeader.SetRange("Academic Year", GradAcademicYear);
                                                        ACASenateReportsHeader.SetRange("School Code", Progyz."School Code");
                                                        ACASenateReportsHeader.SetRange("Classification Code", ACAResultsStatus.Code);
                                                        ACASenateReportsHeader.SetRange("Programme Code", Progyz.Code);
                                                        ACASenateReportsHeader.SetRange("Year of Study", Coregcs."Year Of Study");
                                                        if not (ACASenateReportsHeader.Find('-')) then begin
                                                            ACASenateReportsHeader.Init;
                                                            ACASenateReportsHeader."Academic Year" := GradAcademicYear;
                                                            ACASenateReportsHeader."Reporting Academic Year" := GradAcademicYear;
                                                            ACASenateReportsHeader."Rubric Order" := ACAResultsStatus."Order No";
                                                            ACASenateReportsHeader."Programme Code" := Progyz.Code;
                                                            ACASenateReportsHeader."School Code" := Progyz."School Code";
                                                            ACASenateReportsHeader."Year of Study" := Coregcs."Year Of Study";
                                                            ACASenateReportsHeader."Classification Code" := ACAResultsStatus.Code;
                                                            ACASenateReportsHeader."Status Msg6" := ACAResultsStatus."Status Msg6";
                                                            ACASenateReportsHeader."IncludeVariable 1" := ACAResultsStatus."IncludeVariable 1";
                                                            ACASenateReportsHeader."IncludeVariable 2" := ACAResultsStatus."IncludeVariable 2";
                                                            ACASenateReportsHeader."IncludeVariable 3" := ACAResultsStatus."IncludeVariable 3";
                                                            ACASenateReportsHeader."IncludeVariable 4" := ACAResultsStatus."IncludeVariable 4";
                                                            ACASenateReportsHeader."IncludeVariable 5" := ACAResultsStatus."IncludeVariable 5";
                                                            ACASenateReportsHeader."IncludeVariable 6" := ACAResultsStatus."IncludeVariable 6";
                                                            ACASenateReportsHeader."Summary Page Caption" := ACAResultsStatus."Summary Page Caption";
                                                            ACASenateReportsHeader."Include Failed Units Headers" := ACAResultsStatus."Include Failed Units Headers";
                                                            ACASenateReportsHeader."Include Academic Year Caption" := ACAResultsStatus."Include Academic Year Caption";
                                                            ACASenateReportsHeader."Academic Year Text" := ACAResultsStatus."Academic Year Text";
                                                            ACASenateReportsHeader."Status Msg1" := ACAResultsStatus."Status Msg1";
                                                            ACASenateReportsHeader."Status Msg2" := ACAResultsStatus."Status Msg2";
                                                            ACASenateReportsHeader."Status Msg3" := ACAResultsStatus."Status Msg3";
                                                            ACASenateReportsHeader."Status Msg4" := ACAResultsStatus."Status Msg4";
                                                            ACASenateReportsHeader."Status Msg5" := ACAResultsStatus."Status Msg5";
                                                            ACASenateReportsHeader."Status Msg6" := ACAResultsStatus."Status Msg6";
                                                            ACASenateReportsHeader."Grad. Status Msg 1" := ACAResultsStatus."Grad. Status Msg 1";
                                                            ACASenateReportsHeader."Grad. Status Msg 2" := ACAResultsStatus."Grad. Status Msg 2";
                                                            ACASenateReportsHeader."Grad. Status Msg 3" := ACAResultsStatus."Grad. Status Msg 3";
                                                            ACASenateReportsHeader."Grad. Status Msg 4" := ACAResultsStatus."Grad. Status Msg 4";
                                                            ACASenateReportsHeader."Grad. Status Msg 5" := ACAResultsStatus."Grad. Status Msg 5";
                                                            ACASenateReportsHeader."Grad. Status Msg 6" := ACAResultsStatus."Grad. Status Msg 6";
                                                            ACASenateReportsHeader."Finalists Graduation Comments" := ACAResultsStatus."Finalists Grad. Comm. Degree";
                                                            ACASenateReportsHeader."1st Year Grad. Comments" := ACAResultsStatus."1st Year Grad. Comments";
                                                            ACASenateReportsHeader."2nd Year Grad. Comments" := ACAResultsStatus."2nd Year Grad. Comments";
                                                            ACASenateReportsHeader."3rd Year Grad. Comments" := ACAResultsStatus."3rd Year Grad. Comments";
                                                            ACASenateReportsHeader."4th Year Grad. Comments" := ACAResultsStatus."4th Year Grad. Comments";
                                                            ACASenateReportsHeader."5th Year Grad. Comments" := ACAResultsStatus."5th Year Grad. Comments";
                                                            ACASenateReportsHeader."6th Year Grad. Comments" := ACAResultsStatus."6th Year Grad. Comments";
                                                            ACASenateReportsHeader."7th Year Grad. Comments" := ACAResultsStatus."7th Year Grad. Comments";
                                                            ACASenateReportsHeader.Insert;
                                                        end;
                                                    end;
                                                    until ACAResultsStatus.Next = 0;
                                                end;
                                                ////////////////////////////////////////////////////////////////////////////
                                                ACAExamClassificationStuds.Reset;
                                                ACAExamClassificationStuds.SetRange("Student Number", StudentUnits."Student No.");
                                                ACAExamClassificationStuds.SetRange(Programme, StudentUnits.Programme);
                                                ACAExamClassificationStuds.SetRange("Academic Year", GradAcademicYear);
                                                ACAExamClassificationStuds.SetRange("Reporting Academic Year", GradAcademicYear);
                                                if not ACAExamClassificationStuds.Find('-') then begin
                                                    ACAExamClassificationStuds.Init;
                                                    ACAExamClassificationStuds."Student Number" := StudentUnits."Student No.";
                                                    ACAExamClassificationStuds."Reporting Academic Year" := GradAcademicYear;
                                                    ACAExamClassificationStuds."School Code" := Progyz."School Code";
                                                    ACAExamClassificationStuds.Department := Progyz."Department Code";
                                                    ACAExamClassificationStuds."Programme Option" := Coregcs.Options;
                                                    ACAExamClassificationStuds.Programme := StudentUnits.Programme;
                                                    ACAExamClassificationStuds."Academic Year" := Coregcs."Academic Year";
                                                    ACAExamClassificationStuds."Year of Study" := GetYearOfStudy(StudentUnits.Stage);
                                                    //ACAExamClassificationStuds."Department Name":=GetDepartmentNameOrSchool(Progyz."Department Code");
                                                    ACAExamClassificationStuds."School Name" := GetDepartmentNameOrSchool(Progyz."School Code");
                                                    ACAExamClassificationStuds."Student Name" := GetStudentName(StudentUnits."Student No.");
                                                    ACAExamClassificationStuds.Cohort := GetCohort(StudentUnits."Student No.", StudentUnits.Programme);
                                                    ACAExamClassificationStuds."Final Stage" := GetFinalStage(StudentUnits.Programme);
                                                    ACAExamClassificationStuds."Final Academic Year" := GetFinalAcademicYear(StudentUnits."Student No.", StudentUnits.Programme);
                                                    ACAExamClassificationStuds."Final Year of Study" := GetFinalYearOfStudy(StudentUnits.Programme);
                                                    ACAExamClassificationStuds."Admission Date" := GetAdmissionDate(StudentUnits."Student No.", StudentUnits.Programme);
                                                    ACAExamClassificationStuds."Admission Academic Year" := GetAdmissionAcademicYear(StudentUnits."Student No.", StudentUnits.Programme);
                                                    ACAExamClassificationStuds.Graduating := false;
                                                    ACAExamClassificationStuds.Classification := '';
                                                    if ACAExamClassificationStuds.Insert then;
                                                    // //
                                                    // //          ACAExamCummulativeResit.RESET;
                                                    // //        ACAExamCummulativeResit.SETRANGE("Student Number",StudentUnits."Student No.");
                                                    // //        ACAExamCummulativeResit.SETRANGE("Academic Year",ACAExamClassificationStuds."Academic Year");
                                                    // //        IF ACAExamCummulativeResit.FIND('-') THEN ACAExamCummulativeResit.DELETEALL;
                                                    // //
                                                    // //        ACAStudentUnitsForResits.RESET;
                                                    // //        ACAStudentUnitsForResits.SETRANGE("Student No.",StudentUnits."Student No.");
                                                    // //        ACAStudentUnitsForResits.SETRANGE("Reg. Reversed",FALSE);
                                                    // //        IF ACAStudentUnitsForResits.FIND('-') THEN BEGIN
                                                    // //          REPEAT
                                                    // //              BEGIN
                                                    // //                ACAStudentUnitsForResits.CALCFIELDS("EXAMs Marks","CATs Marks","CATs Marks Exists","EXAMs Marks Exists");
                                                    // //                IF ((ACAStudentUnitsForResits."CATs Marks Exists"=FALSE) OR
                                                    // //                  (ACAStudentUnitsForResits."EXAMs Marks Exists"=FALSE) OR
                                                    // //                   (((GetUnitPassStatus((GetGrade((ACAStudentUnitsForResits."EXAMs Marks"+ACAStudentUnitsForResits."CATs Marks"),
                                                    // //              ACAStudentUnitsForResits.Unit,ACAExamClassificationStuds.Programme)),
                                                    // //              ACAStudentUnitsForResits.Unit,ACAExamClassificationStuds.Programme))=FALSE))) THEN BEGIN
                                                    // //      UnitsSubjects.RESET;
                                                    // //      UnitsSubjects.SETRANGE("Programme Code",ACAStudentUnitsForResits.Programme);
                                                    // //      UnitsSubjects.SETRANGE(Code,ACAStudentUnitsForResits.Unit);
                                                    // //      IF UnitsSubjects.FIND('-') THEN BEGIN
                                                    // //        IF NOT (GetYearOfStudy(UnitsSubjects."Stage Code")>Coregcs."Year Of Study") THEN BEGIN
                                                    // //          ACAExamCummulativeResit.RESET;
                                                    // //        ACAExamCummulativeResit.SETRANGE("Student Number",StudentUnits."Student No.");
                                                    // //        ACAExamCummulativeResit.SETRANGE("Unit Code",ACAStudentUnitsForResits.Unit);
                                                    // //        ACAExamCummulativeResit.SETRANGE("Academic Year",ACAExamClassificationStuds."Academic Year");
                                                    // //        IF NOT (ACAExamCummulativeResit.FIND('-')) THEN BEGIN
                                                    // //            ACAExamCummulativeResit.INIT;
                                                    // //            ACAExamCummulativeResit."Student Number":=StudentUnits."Student No.";
                                                    // //            ACAExamCummulativeResit."School Code":=ACAExamClassificationStuds."School Code";
                                                    // //            ACAExamCummulativeResit."Academic Year":=ACAExamClassificationStuds."Academic Year";
                                                    // //            ACAExamCummulativeResit."Unit Code":=ACAStudentUnitsForResits.Unit;
                                                    // //            ACAExamCummulativeResit."Student Name":=ACAExamClassificationStuds."Student Name";
                                                    // //            ACAExamCummulativeResit.Programme:=ACAExamClassificationStuds.Programme;
                                                    // //            ACAExamCummulativeResit."School Name":=ACAExamClassificationStuds."School Name";
                                                    // //            ACAExamCummulativeResit."Unit Description":=UnitsSubjects.Desription;
                                                    // //            ACAExamCummulativeResit."Credit Hours":=UnitsSubjects."Credit Hours";
                                                    // //            IF UnitsSubjects."Unit Type"=UnitsSubjects."Unit Type"::Core THEN
                                                    // //              ACAExamCummulativeResit."Unit Type":='CORE'
                                                    // //            ELSE IF UnitsSubjects."Unit Type"=UnitsSubjects."Unit Type"::Required THEN
                                                    // //              ACAExamCummulativeResit."Unit Type":='Required'
                                                    // //            ELSE IF UnitsSubjects."Unit Type"=UnitsSubjects."Unit Type"::Elective THEN
                                                    // //              ACAExamCummulativeResit."Unit Type":='Elective';
                                                    // //
                                                    // //            ACAExamCummulativeResit.Score:=ACAStudentUnitsForResits."EXAMs Marks"+ACAStudentUnitsForResits."CATs Marks";
                                                    // //            IF ((ACAStudentUnitsForResits."CATs Marks Exists"=FALSE) OR
                                                    // //                  (ACAStudentUnitsForResits."EXAMs Marks Exists"=FALSE)) THEN
                                                    // //            ACAExamCummulativeResit.Grade:='!' ELSE
                                                    // //            ACAExamCummulativeResit.Grade:=GetGrade((ACAStudentUnitsForResits."EXAMs Marks"+ACAStudentUnitsForResits."CATs Marks"),
                                                    // //              ACAStudentUnitsForResits.Unit,ACAExamClassificationStuds.Programme);
                                                    // //              IF ACAExamCummulativeResit.Grade<>'' THEN
                                                    // //            IF ACAExamCummulativeResit.INSERT THEN;
                                                    // //
                                                    // //            END;
                                                    // //            END;
                                                    // //        END;
                                                    // //        END;
                                                    // //              END;
                                                    // //              END;
                                                    // //            UNTIL ACAStudentUnitsForResits.NEXT=0;
                                                    // //          END;
                                                    // Pick all Resits for the Student
                                                end;
                                                /////////////////////////////////////// YoS Tracker

                                                Progyz.Reset;
                                                if Progyz.Get(Coregcs.Programmes) then;
                                                ACAExamCourseRegistration.Reset;
                                                ACAExamCourseRegistration.SetRange("Student Number", StudentUnits."Student No.");
                                                ACAExamCourseRegistration.SetRange(Programme, StudentUnits.Programme);
                                                ACAExamCourseRegistration.SetRange("Year of Study", Coregcs."Year Of Study");
                                                ACAExamCourseRegistration.SetRange("Academic Year", GradAcademicYear);
                                                ACAExamCourseRegistration.SetRange("Reporting Academic Year", GradAcademicYear);
                                                if not ACAExamCourseRegistration.Find('-') then begin
                                                    ACAExamCourseRegistration.Init;
                                                    ACAExamCourseRegistration."Student Number" := StudentUnits."Student No.";
                                                    ACAExamCourseRegistration.Programme := StudentUnits.Programme;
                                                    ACAExamCourseRegistration."Year of Study" := Coregcs."Year Of Study";
                                                    ACAExamCourseRegistration."Reporting Academic Year" := Coregcs."Academic Year";
                                                    ACAExamCourseRegistration."Academic Year" := Coregcs."Academic Year";
                                                    ACAExamCourseRegistration."School Code" := Progyz."School Code";
                                                    ACAExamCourseRegistration."Programme Option" := Coregcs.Options;
                                                    // ACAExamCourseRegistration.Department:=Progyz."Department Code";
                                                    // ACAExamCourseRegistration."Department Name":=ACAExamClassificationStuds."Department Name";
                                                    ACAExamCourseRegistration."School Name" := ACAExamClassificationStuds."School Name";
                                                    ACAExamCourseRegistration."Student Name" := ACAExamClassificationStuds."Student Name";
                                                    ACAExamCourseRegistration.Cohort := ACAExamClassificationStuds.Cohort;
                                                    ACAExamCourseRegistration."Final Stage" := ACAExamClassificationStuds."Final Stage";
                                                    ACAExamCourseRegistration."Final Academic Year" := ACAExamClassificationStuds."Final Academic Year";
                                                    ACAExamCourseRegistration."Final Year of Study" := ACAExamClassificationStuds."Final Year of Study";
                                                    ACAExamCourseRegistration."Admission Date" := ACAExamClassificationStuds."Admission Date";
                                                    ACAExamCourseRegistration."Admission Academic Year" := ACAExamClassificationStuds."Admission Academic Year";

                                                    if ((Progyz.Category = Progyz.Category::Certificate) or
                                                       (Progyz.Category = Progyz.Category::"Course List") or
                                                       (Progyz.Category = Progyz.Category::Professional)) then begin
                                                        ACAExamCourseRegistration."Category Order" := 2;
                                                    end else
                                                        if (Progyz.Category = Progyz.Category::Diploma) then begin
                                                            ACAExamCourseRegistration."Category Order" := 3;
                                                        end else
                                                            if (Progyz.Category = Progyz.Category::Postgraduate) then begin
                                                                ACAExamCourseRegistration."Category Order" := 4;
                                                            end else
                                                                if (Progyz.Category = Progyz.Category::Undergraduate) then begin
                                                                    ACAExamCourseRegistration."Category Order" := 1;
                                                                end;
                                                    ACAExamCourseRegistration.Graduating := false;
                                                    ACAExamCourseRegistration.Classification := '';
                                                    if ACAExamCourseRegistration.Insert then;
                                                end;
                                                /////////////////////////////////////// end of YoS Tracker
                                                ///////////////////////////////////////////////////////////////// iiiiiiiiiiiiiiiiiiiiiiii Update Units
                                                ExamResults.Reset;
                                                ExamResults.SetFilter("Counted Occurances", '>%1', 1);
                                                ExamResults.SetRange("Student No.", StudentUnits."Student No.");
                                                ExamResults.SetRange(Unit, StudentUnits.Unit);
                                                if ExamResults.Find('-') then begin
                                                    repeat
                                                    begin
                                                        ACAExamResultsFin.Reset;
                                                        ACAExamResultsFin.SetRange("Student No.", StudentUnits."Student No.");
                                                        ACAExamResultsFin.SetRange(Programmes, StudentUnits.Programme);
                                                        ACAExamResultsFin.SetRange(Unit, StudentUnits.Unit);
                                                        ACAExamResultsFin.SetRange(Semester, StudentUnits.Semester);
                                                        ACAExamResultsFin.SetRange(ExamType, ExamResults.ExamType);
                                                        if ACAExamResultsFin.Find('-') then begin
                                                            ACAExamResultsFin.CalcFields("Counted Occurances");
                                                            if ACAExamResultsFin."Counted Occurances" > 1 then begin
                                                                ACAExamResultsFin.Delete;
                                                            end;
                                                        end;
                                                    end;
                                                    until ExamResults.Next = 0;
                                                end;
                                                ////////////////////////////////// Remove Multiple Occurances of a Mark
                                                //Get best CAT Marks
                                                StudentUnits."Unit not in Catalogue" := false;

                                                UnitsSubjects.Reset;
                                                UnitsSubjects.SetRange("Programme Code", StudentUnits.Programme);
                                                UnitsSubjects.SetRange(Code, StudentUnits.Unit);
                                                if UnitsSubjects.Find('-') then begin

                                                    ACAExamClassificationUnits.Reset;
                                                    ACAExamClassificationUnits.SetRange("Student No.", StudentUnits."Student No.");
                                                    ACAExamClassificationUnits.SetRange(Programme, StudentUnits.Programme);
                                                    ACAExamClassificationUnits.SetRange("Unit Code", StudentUnits.Unit);
                                                    ACAExamClassificationUnits.SetRange("Reporting Academic Year", GradAcademicYear);
                                                    ACAExamClassificationUnits.SetRange("Academic Year", GradAcademicYear);
                                                    if not ACAExamClassificationUnits.Find('-') then begin
                                                        ACAExamClassificationUnits.Init;
                                                        ACAExamClassificationUnits."Student No." := StudentUnits."Student No.";
                                                        ACAExamClassificationUnits.Programme := StudentUnits.Programme;
                                                        ACAExamClassificationUnits."Reporting Academic Year" := GradAcademicYear;
                                                        ACAExamClassificationUnits."School Code" := Progyz."School Code";
                                                        // //            ACAExamClassificationUnits."Department Code":=Progyz."Department Code";
                                                        ACAExamClassificationUnits."Unit Code" := StudentUnits.Unit;
                                                        ACAExamClassificationUnits."Credit Hours" := UnitsSubjects."Credit Hours";
                                                        ACAExamClassificationUnits."Unit Type" := Format(UnitsSubjects."Unit Type");
                                                        ACAExamClassificationUnits."Unit Description" := UnitsSubjects.Desription;
                                                        //            IF ACACourseRegistration."Year Of Study"=0 THEN
                                                        //              ACACourseRegistration."Year Of Study":=GetYearOfStudy(ACACourseRegistration.Stage);
                                                        ACAExamClassificationUnits."Year of Study" := ACAExamCourseRegistration."Year of Study";
                                                        ACAExamClassificationUnits."Academic Year" := GradAcademicYear;

                                                        ExamResults.Reset;
                                                        ExamResults.SetRange("Student No.", StudentUnits."Student No.");
                                                        ExamResults.SetRange(Unit, StudentUnits.Unit);
                                                        if ExamResults.Find('-') then begin
                                                            ExamResults.CalcFields("Number of Repeats", "Number of Resits");
                                                            if ExamResults."Number of Repeats" > 0 then
                                                                ACAExamClassificationUnits."No. of Repeats" := ExamResults."Number of Repeats" - 1;
                                                            if ExamResults."Number of Resits" > 0 then
                                                                ACAExamClassificationUnits."No. of Resits" := ExamResults."Number of Resits" - 1;
                                                        end;

                                                        if ACAExamClassificationUnits.Insert then;
                                                    end;

                                                    /////////////////////////// Update Unit Score
                                                    ACAExamClassificationUnits.Reset;
                                                    ACAExamClassificationUnits.SetRange("Student No.", StudentUnits."Student No.");
                                                    ACAExamClassificationUnits.SetRange(Programme, StudentUnits.Programme);
                                                    ACAExamClassificationUnits.SetRange("Unit Code", StudentUnits.Unit);
                                                    ACAExamClassificationUnits.SetRange("Academic Year", GradAcademicYear);
                                                    ACAExamClassificationUnits.SetRange("Reporting Academic Year", GradAcademicYear);
                                                    if ACAExamClassificationUnits.Find('-') then begin
                                                        // //
                                                        // //              ClassStudentUnits.RESET;
                                                        // //              ClassStudentUnits.SETRANGE("Student No.",ACAExamClassificationUnits."Student No.");
                                                        // //              ClassStudentUnits.SETRANGE(Programme,ACAExamClassificationUnits.Programme);
                                                        // //            //  ClassStudentUnits.SETRANGE("Reg Reversed",FALSE);
                                                        // //              ClassStudentUnits.SETRANGE(Unit,ACAExamClassificationUnits."Unit Code");
                                                        // //              IF ClassStudentUnits.FIND('+') THEN BEGIN
                                                        StudentUnits.CalcFields("EXAMs Marks", "CATs Marks", "CATs Marks Exists", "EXAMs Marks Exists");
                                                        //Get CAT Marks
                                                        // //                ClassExamResults.RESET;
                                                        // //                ClassExamResults.SETRANGE("Student No.",ACAExamClassificationUnits."Student No.");
                                                        // //                ClassExamResults.SETRANGE(Unit,ACAExamClassificationUnits."Unit Code");
                                                        // //                ClassExamResults.SETFILTER(Exam,'%1|%2','ASSIGNMENT','CAT');
                                                        // //                ClassExamResults.SETCURRENTKEY(Semester);
                                                        // //                IF ClassExamResults.FIND('+') THEN BEGIN
                                                        // // // // // // //              IF StudentUnits."CATs Marks Exists" THEN BEGIN
                                                        // // // // // // //                  ACAExamClassificationUnits."CAT Score":=FORMAT(StudentUnits."CATs Marks");
                                                        // // // // // // //                  ACAExamClassificationUnits."CAT Score Decimal":=StudentUnits."CATs Marks";
                                                        // // // // // // //                    END;
                                                        // // // // // // // // //                  END;
                                                        // // // // // // //              //Get Exam Marks
                                                        // // // // // // // // //                ClassExamResults.RESET;
                                                        // // // // // // // // //                ClassExamResults.SETRANGE("Student No.",ACAExamClassificationUnits."Student No.");
                                                        // // // // // // // // //                ClassExamResults.SETRANGE(Unit,ACAExamClassificationUnits."Unit Code");
                                                        // // // // // // // // //                ClassExamResults.SETFILTER(Exam,'%1|%2|%3|%4','EXAM','EXAM100','EXAMS','FINAL EXAM');
                                                        // // // // // // // // //                ClassExamResults.SETCURRENTKEY(Semester);
                                                        // // // // // // // // //                IF ClassExamResults.FIND('+') THEN BEGIN
                                                        // // // // // // //              IF StudentUnits."EXAMs Marks Exists" THEN BEGIN
                                                        // // // // // // //                  ACAExamClassificationUnits."Exam Score":=FORMAT(StudentUnits."EXAMs Marks");
                                                        // // // // // // //                  ACAExamClassificationUnits."Exam Score Decimal":=StudentUnits."EXAMs Marks";
                                                        // // // // // // //                  END;
                                                        // //                  END;

                                                        //  IF ACAExamClassificationUnits."Exam Score"='' THEN BEGIN
                                                        ACAExamResults_Fin.Reset;
                                                        ACAExamResults_Fin.SetRange("Student No.", StudentUnits."Student No.");
                                                        ACAExamResults_Fin.SetRange(Unit, StudentUnits.Unit);
                                                        ACAExamResults_Fin.SetFilter(Exam, '%1|%2|%3|%4', 'EXAM', 'EXAM100', 'EXAMS', 'FINAL EXAM');
                                                        ACAExamResults_Fin.SetCurrentKey(Score);
                                                        if ACAExamResults_Fin.Find('+') then begin
                                                            ACAExamClassificationUnits."Exam Score" := Format(ACAExamResults_Fin.Score);
                                                            ACAExamClassificationUnits."Exam Score Decimal" := ACAExamResults_Fin.Score;
                                                        end;
                                                        //     END;

                                                        //   IF ACAExamClassificationUnits."CAT Score"='' THEN BEGIN
                                                        ACAExamResults_Fin.Reset;
                                                        ACAExamResults_Fin.SetRange("Student No.", StudentUnits."Student No.");
                                                        ACAExamResults_Fin.SetRange(Unit, StudentUnits.Unit);
                                                        ACAExamResults_Fin.SetFilter(Exam, '%1|%2', 'ASSIGNMENT', 'CAT');
                                                        ACAExamResults_Fin.SetCurrentKey(Score);
                                                        if ACAExamResults_Fin.Find('+') then begin
                                                            ACAExamClassificationUnits."CAT Score" := Format(ACAExamResults_Fin.Score);
                                                            ACAExamClassificationUnits."CAT Score Decimal" := ACAExamResults_Fin.Score;
                                                        end;
                                                        // END;

                                                        //Update Total Marks
                                                        if ((ACAExamClassificationUnits."Exam Score" = '') and (ACAExamClassificationUnits."CAT Score" = '')) then begin
                                                            // //                    ACAExamClassificationUnits.Pass:=FALSE;
                                                            // //                    ACAExamClassificationUnits.Grade:='?';
                                                            // //                    ACAExamClassificationUnits."Grade Comment":='MISSED';
                                                            // //                    ACAExamClassificationUnits."Comsolidated Prefix":='?';
                                                            ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"None Exists";
                                                        end else
                                                            if ((ACAExamClassificationUnits."Exam Score" = '') and (ACAExamClassificationUnits."CAT Score" <> '')) then begin
                                                                // //                    ACAExamClassificationUnits.Pass:=FALSE;
                                                                // //                    ACAExamClassificationUnits.Grade:='!';
                                                                // //                    ACAExamClassificationUnits."Grade Comment":='INCOMPLETE';
                                                                // //                    ACAExamClassificationUnits."Comsolidated Prefix":='c';
                                                                ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"CAT Only";
                                                            end else
                                                                if ((ACAExamClassificationUnits."Exam Score" <> '') and (ACAExamClassificationUnits."CAT Score" = '')) then begin
                                                                    // //                    ACAExamClassificationUnits.Pass:=FALSE;
                                                                    // //                    ACAExamClassificationUnits.Grade:='!';
                                                                    // //                    ACAExamClassificationUnits."Grade Comment":='INCOMPLETE';
                                                                    // //                    ACAExamClassificationUnits."Comsolidated Prefix":='e';
                                                                    ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"Exam Only";
                                                                end else
                                                                    if ((ACAExamClassificationUnits."Exam Score" <> '') and (ACAExamClassificationUnits."CAT Score" <> '')) then begin
                                                                        ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"Both Exists";
                                                                    end;

                                                        if ((ACAExamClassificationUnits."Exam Score" <> '') and (ACAExamClassificationUnits."CAT Score" <> '')) then begin
                                                            // //                 ACAExamClassificationUnits."Grade Comment":=GetGradeComment(ACAExamClassificationUnits."Total Score Decimal",ACAExamClassificationUnits."Unit Code",ACAExamClassificationUnits.Programme);
                                                            ACAExamClassificationUnits."Total Score" := Format(ACAExamClassificationUnits."Exam Score Decimal" + ACAExamClassificationUnits."CAT Score Decimal");
                                                            ACAExamClassificationUnits."Total Score Decimal" := ACAExamClassificationUnits."Exam Score Decimal" + ACAExamClassificationUnits."CAT Score Decimal";
                                                            ACAExamClassificationUnits."Weighted Total Score" := ACAExamClassificationUnits."Credit Hours" * ACAExamClassificationUnits."Total Score Decimal";
                                                            // //                  ACAExamClassificationUnits.Grade:=GetGrade(ACAExamClassificationUnits."Total Score Decimal",ACAExamClassificationUnits."Unit Code",ACAExamClassificationUnits.Programme);
                                                            // //                  ACAExamClassificationUnits.Pass:=GetUnitPassStatus(ACAExamClassificationUnits.Grade,ACAExamClassificationUnits."Unit Code",ACAExamClassificationUnits.Programme);
                                                            // //                  IF ACAExamClassificationUnits.Pass=FALSE THEN BEGIN
                                                            // //                    ACAExamClassificationUnits."Comsolidated Prefix":='^';
                                                            //END;
                                                        end else begin
                                                            ACAExamClassificationUnits."Total Score" := Format(ACAExamClassificationUnits."Exam Score Decimal" + ACAExamClassificationUnits."CAT Score Decimal");
                                                            ACAExamClassificationUnits."Total Score Decimal" := ACAExamClassificationUnits."Exam Score Decimal" + ACAExamClassificationUnits."CAT Score Decimal";
                                                            ACAExamClassificationUnits."Weighted Total Score" := ACAExamClassificationUnits."Credit Hours" * ACAExamClassificationUnits."Total Score Decimal";
                                                        end;
                                                        ACAExamClassificationUnits."Allow In Graduate" := true;

                                                        /// Update Cummulative Resit
                                                        ACAExamClassificationUnits.CalcFields(Grade, "Grade Comment", "Comsolidated Prefix", Pass);
                                                        if not (ACAExamClassificationUnits.Pass) then begin
                                                            ACAExamCummulativeResit.Reset;
                                                            ACAExamCummulativeResit.SetRange("Student Number", StudentUnits."Student No.");
                                                            ACAExamCummulativeResit.SetRange("Unit Code", ACAExamClassificationUnits."Unit Code");
                                                            ACAExamCummulativeResit.SetRange("Academic Year", Coregcs."Academic Year");
                                                            if not (ACAExamCummulativeResit.Find('-')) then begin
                                                                ACAExamCummulativeResit.Init;
                                                                ACAExamCummulativeResit."Student Number" := StudentUnits."Student No.";
                                                                ACAExamCummulativeResit."School Code" := ACAExamClassificationStuds."School Code";
                                                                ACAExamCummulativeResit."Academic Year" := StudentUnits."Academic Year";
                                                                ACAExamCummulativeResit."Unit Code" := ACAExamClassificationUnits."Unit Code";
                                                                ACAExamCummulativeResit."Student Name" := ACAExamClassificationStuds."Student Name";
                                                                ACAExamCummulativeResit.Programme := StudentUnits.Programme;
                                                                ACAExamCummulativeResit."School Name" := ACAExamClassificationStuds."School Name";
                                                                ACAExamCummulativeResit."Unit Description" := UnitsSubjects.Desription;
                                                                ACAExamCummulativeResit."Credit Hours" := UnitsSubjects."Credit Hours";
                                                                ACAExamCummulativeResit."Unit Type" := ACAExamClassificationUnits."Unit Type";
                                                                ACAExamCummulativeResit.Score := ACAExamClassificationUnits."Total Score Decimal";
                                                                ACAExamCummulativeResit.Grade := ACAExamClassificationUnits.Grade;
                                                                if ACAExamCummulativeResit.Insert then;
                                                            end;
                                                        end;
                                                        if ACAExamClassificationUnits.Modify then;
                                                        //////////////////////////// Update Units Scores.. End
                                                    end else begin
                                                        StudentUnits."Unit not in Catalogue" := true;
                                                    end;
                                                end;
                                                StudentUnits.Modify;
                                                ///////////////////////////////////////////////////////////////// iiiiiiiiiiiiiiiiiiiiiiii End of Finalize Units
                                            end;
                                            until StudentUnits.Next = 0;
                                        end;
                                    end;
                                    until Coregcs.Next = 0;
                                    Progressbar.Close;
                                end;



                                // // // // // //Update Senate Header
                                // // // // //
                                // // // // //            ACASenateReportsHeader.RESET;
                                // // // // //            ACASenateReportsHeader.SETFILTER("Programme Code",ProgFIls);
                                // // // // //            ACASenateReportsHeader.SETFILTER("Reporting Academic Year",GradAcademicYear);
                                // // // // //            IF ACASenateReportsHeader.FIND('-') THEN ACASenateReportsHeader.DELETEALL;
                                // // // // //
                                // // // // // ACAExamCourseRegistration.RESET;
                                // // // // // ACAExamCourseRegistration.SETFILTER(Programme,ProgFIls);
                                // // // // // ACAExamCourseRegistration.SETFILTER("Academic Year",GradAcademicYear);
                                // // // // // IF ACAExamCourseRegistration.FIND('-') THEN BEGIN
                                // // // // //  TotalRecs:=ACAExamCourseRegistration.COUNT;
                                // // // // //  RemeiningRecs:=TotalRecs;
                                // // // // //  ProgBar2.OPEN('#1#####################################################\'+
                                // // // // //  '#2############################################################\'+
                                // // // // //  '#3###########################################################\'+
                                // // // // //  '#4############################################################\'+
                                // // // // //  '#5###########################################################\'+
                                // // // // //  '#6############################################################');
                                // // // // //     ProgBar2.UPDATE(1,'2 of 3 Updating Class Items');
                                // // // // //     ProgBar2.UPDATE(2,'Total Recs.: '+FORMAT(TotalRecs));
                                // // // // //    REPEAT
                                // // // // //      BEGIN
                                // // // // // ACAExamFailedReasons.RESET;
                                // // // // // ACAExamFailedReasons.SETRANGE("Student No.",ACAExamCourseRegistration."Student Number");
                                // // // // // IF ACAExamFailedReasons.FIND('-') THEN ACAExamFailedReasons.DELETEALL;
                                // // // // //      CountedRecs+=1;
                                // // // // //      RemeiningRecs-=1;
                                // // // // //     ProgBar2.UPDATE(3,'.....................................................');
                                // // // // //     ProgBar2.UPDATE(4,'Processed: '+FORMAT(CountedRecs));
                                // // // // //     ProgBar2.UPDATE(5,'Remaining: '+FORMAT(RemeiningRecs));
                                // // // // //     ProgBar2.UPDATE(6,'----------------------------------------------------');
                                // // // // //
                                // // // // //
                                // // // // //            ACAResultsStatus.RESET;
                                // // // // //            ACAResultsStatus.SETRANGE("Special Programme Class",Progyz."Special Programme Class");
                                // // // // //            ACAResultsStatus.SETRANGE("Academic Year",ACAExamCourseRegistration."Academic Year");
                                // // // // //            IF ACAResultsStatus.FIND('-') THEN BEGIN
                                // // // // //              REPEAT
                                // // // // //                  BEGIN
                                // // // // //                  ACASenateReportsHeader.RESET;
                                // // // // //                  ACASenateReportsHeader.SETRANGE("Academic Year",ACAExamCourseRegistration."Academic Year");
                                // // // // //                  ACASenateReportsHeader.SETRANGE("School Code",Progyz."School Code");
                                // // // // //                  ACASenateReportsHeader.SETRANGE("Classification Code",ACAResultsStatus.Code);
                                // // // // //                  ACASenateReportsHeader.SETRANGE("Programme Code",Progyz.Code);
                                // // // // //                  ACASenateReportsHeader.SETRANGE("Year of Study",ACAExamCourseRegistration."Year of Study");
                                // // // // //                  IF NOT (ACASenateReportsHeader.FIND('-')) THEN BEGIN
                                // // // // //                    ACASenateReportsHeader.INIT;
                                // // // // //                    ACASenateReportsHeader."Academic Year":=ACAExamCourseRegistration."Academic Year";
                                // // // // //                    ACASenateReportsHeader."Rubric Order":=ACAResultsStatus."Order No";
                                // // // // //                    ACASenateReportsHeader."Programme Code":=Progyz.Code;
                                // // // // //                    ACASenateReportsHeader."School Code":=Progyz."School Code";
                                // // // // //                    ACASenateReportsHeader."Year of Study":=ACAExamCourseRegistration."Year of Study";
                                // // // // //                    ACASenateReportsHeader."Reporting Academic Year":=ACAExamCourseRegistration."Academic Year";
                                // // // // //                    ACASenateReportsHeader."Classification Code":=ACAResultsStatus.Code;
                                // // // // //                    ACASenateReportsHeader."Status Msg6":=ACAResultsStatus."Status Msg6";
                                // // // // //                    ACASenateReportsHeader."IncludeVariable 1":=ACAResultsStatus."IncludeVariable 1";
                                // // // // //                    ACASenateReportsHeader."IncludeVariable 2":=ACAResultsStatus."IncludeVariable 2";
                                // // // // //                    ACASenateReportsHeader."IncludeVariable 3":=ACAResultsStatus."IncludeVariable 3";
                                // // // // //                    ACASenateReportsHeader."IncludeVariable 4":=ACAResultsStatus."IncludeVariable 4";
                                // // // // //                    ACASenateReportsHeader."IncludeVariable 5":=ACAResultsStatus."IncludeVariable 5";
                                // // // // //                    ACASenateReportsHeader."IncludeVariable 6":=ACAResultsStatus."IncludeVariable 6";
                                // // // // //                    ACASenateReportsHeader."Summary Page Caption":=ACAResultsStatus."Summary Page Caption";
                                // // // // //                    ACASenateReportsHeader."Include Failed Units Headers":=ACAResultsStatus."Include Failed Units Headers";
                                // // // // //                    ACASenateReportsHeader."Include Academic Year Caption":=ACAResultsStatus."Include Academic Year Caption";
                                // // // // //                    ACASenateReportsHeader."Academic Year Text":=ACAResultsStatus."Academic Year Text";
                                // // // // //                    ACASenateReportsHeader."Status Msg1":=ACAResultsStatus."Status Msg1";
                                // // // // //                    ACASenateReportsHeader."Status Msg2":=ACAResultsStatus."Status Msg2";
                                // // // // //                    ACASenateReportsHeader."Status Msg3":=ACAResultsStatus."Status Msg3";
                                // // // // //                    ACASenateReportsHeader."Status Msg4":=ACAResultsStatus."Status Msg4";
                                // // // // //                    ACASenateReportsHeader."Status Msg5":=ACAResultsStatus."Status Msg5";
                                // // // // //                    ACASenateReportsHeader."Status Msg6":=ACAResultsStatus."Status Msg6";
                                // // // // //                    ACASenateReportsHeader."Grad. Status Msg 1":=ACAResultsStatus."Grad. Status Msg 1";
                                // // // // //                    ACASenateReportsHeader."Grad. Status Msg 2":=ACAResultsStatus."Grad. Status Msg 2";
                                // // // // //                    ACASenateReportsHeader."Grad. Status Msg 3":=ACAResultsStatus."Grad. Status Msg 3";
                                // // // // //                    ACASenateReportsHeader."Grad. Status Msg 4":=ACAResultsStatus."Grad. Status Msg 4";
                                // // // // //                    ACASenateReportsHeader."Grad. Status Msg 5":=ACAResultsStatus."Grad. Status Msg 5";
                                // // // // //                    ACASenateReportsHeader."Grad. Status Msg 6":=ACAResultsStatus."Grad. Status Msg 6";
                                // // // // //                    ACASenateReportsHeader."Finalists Graduation Comments":=ACAResultsStatus."Finalists Grad. Comm. Degree";
                                // // // // //                    ACASenateReportsHeader."1st Year Grad. Comments":=ACAResultsStatus."1st Year Grad. Comments";
                                // // // // //                    ACASenateReportsHeader."2nd Year Grad. Comments":=ACAResultsStatus."2nd Year Grad. Comments";
                                // // // // //                    ACASenateReportsHeader."3rd Year Grad. Comments":=ACAResultsStatus."3rd Year Grad. Comments";
                                // // // // //                    ACASenateReportsHeader."4th Year Grad. Comments":=ACAResultsStatus."4th Year Grad. Comments";
                                // // // // //                    ACASenateReportsHeader."5th Year Grad. Comments":=ACAResultsStatus."5th Year Grad. Comments";
                                // // // // //                    ACASenateReportsHeader."6th Year Grad. Comments":=ACAResultsStatus."6th Year Grad. Comments";
                                // // // // //                    ACASenateReportsHeader."7th Year Grad. Comments":=ACAResultsStatus."7th Year Grad. Comments";
                                // // // // //                    ACASenateReportsHeader.INSERT;
                                // // // // //                    END;
                                // // // // //                  END;
                                // // // // //                UNTIL ACAResultsStatus.NEXT=0;
                                // // // // //              END;
                                // // // // //      END;
                                // // // // //        UNTIL ACAExamCourseRegistration.NEXT=0;
                                // // // // //        ProgBar2.CLOSE;
                                // // // // //        END;
                                // // // // //



                                ////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                ////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                ////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                //......................................................................................Compute Averages Here
                                ////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                ////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                ////////////////////////////////////////////////////////////////////////////////////////////////////////////


                                // Update Averages
                                Clear(TotalRecs);
                                Clear(CountedRecs);
                                Clear(RemeiningRecs);
                                Clear(ACAExamClassificationStuds);
                                ACAExamCourseRegistration.Reset;
                                ACAExamCourseRegistration.SetFilter("Reporting Academic Year", GradAcademicYear);
                                if StudNos <> '' then
                                    ACAExamCourseRegistration.SetFilter("Student Number", StudNos) else
                                    ACAExamCourseRegistration.SetFilter(Programme, ProgFIls);// Only Apply Prog & School if Student FIlter is not Applied
                                if ACAExamCourseRegistration.Find('-') then begin
                                    TotalRecs := ACAExamCourseRegistration.Count;
                                    RemeiningRecs := TotalRecs;
                                    ProgBar2.Open('#1#####################################################\' +
                                    '#2############################################################\' +
                                    '#3###########################################################\' +
                                    '#4############################################################\' +
                                    '#5###########################################################\' +
                                    '#6############################################################');
                                    ProgBar2.Update(1, '3 of 3 Updating Class Items');
                                    ProgBar2.Update(2, 'Total Recs.: ' + Format(TotalRecs));
                                    repeat
                                    begin

                                        Progyz.Reset;
                                        Progyz.SetRange(Code, ACAExamCourseRegistration.Programme);
                                        if Progyz.Find('-') then;
                                        CountedRecs += 1;
                                        RemeiningRecs -= 1;
                                        ProgBar2.Update(3, '.....................................................');
                                        ProgBar2.Update(4, 'Processed: ' + Format(CountedRecs));
                                        ProgBar2.Update(5, 'Remaining: ' + Format(RemeiningRecs));
                                        ProgBar2.Update(6, '----------------------------------------------------');
                                        ACAExamCourseRegistration.CalcFields("Total Marks", "Total Courses", "Total Weighted Marks",
                                      "Total Units", "Classified Total Marks", "Total Classified C. Count", "Classified W. Total", "Attained Stage Units", Average, "Weighted Average");
                                        //IF ACAExamCourseRegistration."Total Courses"<>0 THEN
                                        ACAExamCourseRegistration."Normal Average" := Round((ACAExamCourseRegistration.Average), 0.01, '=');
                                        // ACAExamCourseRegistration."Normal Average":=ROUND((ACAExamCourseRegistration."Total Marks"/ACAExamCourseRegistration."Total Courses"),0.01,'=');
                                        //          IF ACAExamCourseRegistration."Total Units"<>0 THEN
                                        //          ACAExamCourseRegistration."Weighted Average":=ROUND((ACAExamCourseRegistration."Total Weighted Marks"/ACAExamCourseRegistration."Total Units"),0.01,'=');
                                        if ACAExamCourseRegistration."Total Classified C. Count" <> 0 then
                                            ACAExamCourseRegistration."Classified Average" := Round((ACAExamCourseRegistration."Classified Total Marks" / ACAExamCourseRegistration."Total Classified C. Count"), 0.01, '=');
                                        if ACAExamCourseRegistration."Total Classified Units" <> 0 then
                                            ACAExamCourseRegistration."Classified W. Average" := Round((ACAExamCourseRegistration."Classified W. Total" / ACAExamCourseRegistration."Total Classified Units"), 0.01, '=');

                                        ACAExamCourseRegistration."Required Stage Units" := RequiredStageUnits(ACAExamCourseRegistration.Programme,
                                        ACAExamCourseRegistration."Year of Study", ACAExamCourseRegistration."Student Number");
                                        if ACAExamCourseRegistration."Required Stage Units" > ACAExamCourseRegistration."Attained Stage Units" then
                                            ACAExamCourseRegistration."Units Deficit" := ACAExamCourseRegistration."Required Stage Units" - ACAExamCourseRegistration."Attained Stage Units";
                                        ACAExamCourseRegistration."Multiple Programe Reg. Exists" := GetMultipleProgramExists(ACAExamCourseRegistration."Student Number");

                                        ACAExamCourseRegistration."Final Classification" := GetRubric(Progyz, ACAExamCourseRegistration);
                                        ACAExamCourseRegistration."Final Classification Pass" := GetRubricPassStatus(ACAExamCourseRegistration."Final Classification",
                                        ACAExamCourseRegistration."Academic Year", Progyz);
                                        ACAExamCourseRegistration."Final Classification Order" := GetRubricOrder(ACAExamCourseRegistration."Final Classification");
                                        ACAExamCourseRegistration.Graduating := GetRubricPassStatus(ACAExamCourseRegistration."Final Classification",
                                        ACAExamCourseRegistration."Academic Year", Progyz);
                                        ACAExamCourseRegistration.Classification := GetRubric(Progyz, ACAExamCourseRegistration);
                                        // //           IF ((ACAExamCourseRegistration."Total Courses"=0) OR (ACAExamCourseRegistration."Units Deficit">0)) THEN BEGIN
                                        // //             IF ACAExamCourseRegistration.Classification='PASS LIST' THEN BEGIN
                                        // //           ACAExamCourseRegistration."Final Classification":='HALT';
                                        // //           ACAExamCourseRegistration."Final Classification Pass":=FALSE;
                                        // //           ACAExamCourseRegistration."Final Classification Order":=10;
                                        // //           ACAExamCourseRegistration.Graduating:=FALSE;
                                        // //           ACAExamCourseRegistration.Classification:='HALT';
                                        // //               END;
                                        if ACAExamCourseRegistration."Total Courses" = 0 then begin
                                            ACAExamCourseRegistration."Final Classification" := 'HALT';
                                            ACAExamCourseRegistration."Final Classification Pass" := false;
                                            ACAExamCourseRegistration."Final Classification Order" := 10;
                                            ACAExamCourseRegistration.Graduating := false;
                                            ACAExamCourseRegistration.Classification := 'HALT';
                                        end;
                                        //   END;
                                        ACAExamCourseRegistration.CalcFields("Total Marks",
                           "Total Weighted Marks",
                           "Total Failed Courses",
                           "Total Failed Units",
                           "Failed Courses",
                           "Failed Units",
                           "Failed Cores",
                           "Failed Required",
                           "Failed Electives",
                           "Total Cores Done",
                           "Total Cores Passed",
                           "Total Required Done",
                           "Total Electives Done",
                           "Tota Electives Passed");
                                        ACAExamCourseRegistration.CalcFields(
                                        "Classified Electives C. Count",
                                        "Classified Electives Units",
                                        "Total Classified C. Count",
                                        "Total Classified Units",
                                        "Classified Total Marks",
                                        "Classified W. Total",
                                        "Total Failed Core Units");
                                        ACAExamCourseRegistration."Cummulative Fails" := GetCummulativeFails(ACAExamCourseRegistration."Student Number", ACAExamCourseRegistration."Year of Study");
                                        ACAExamCourseRegistration."Cumm. Required Stage Units" := GetCummulativeReqStageUnitrs(ACAExamCourseRegistration.Programme, ACAExamCourseRegistration."Year of Study", ACAExamCourseRegistration."Programme Option");
                                        ACAExamCourseRegistration."Cumm Attained Units" := GetCummAttainedUnits(ACAExamCourseRegistration."Student Number", ACAExamCourseRegistration."Year of Study", ACAExamCourseRegistration.Programme);
                                        ACAExamCourseRegistration.Modify;

                                    end;
                                    until ACAExamCourseRegistration.Next = 0;
                                    ProgBar2.Close;
                                end;

                                ACASenateReportsHeader.Reset;
                                ACASenateReportsHeader.SetFilter("Programme Code", ProgFIls);
                                ACASenateReportsHeader.SetFilter("Reporting Academic Year", GradAcademicYear);
                                if ACASenateReportsHeader.Find('-') then begin
                                    ProgBar22.Open('#1##########################################');
                                    repeat
                                    begin
                                        ProgBar22.Update(1, 'Student Number: ' + ACASenateReportsHeader."Programme Code" + ' Class: ' + ACASenateReportsHeader."Classification Code");
                                        ACASenateReportsHeader.CalcFields("School Classification Count", "School Total Passed", "School Total Passed",
"School Total Failed", "Programme Classification Count", "Programme Total Passed", "Programme Total Failed", "School Total Count",
"Prog. Total Count");

                                        ACASenateReportsHeader.CalcFields("School Classification Count", "School Total Passed", "School Total Failed", "School Total Count",
                                        "Programme Classification Count", "Prog. Total Count", "Programme Total Failed", "Programme Total Passed");
                                        if ACASenateReportsHeader."School Total Count" > 0 then
                                            ACASenateReportsHeader."Sch. Class % Value" := Round(((ACASenateReportsHeader."School Classification Count" / ACASenateReportsHeader."School Total Count") * 100), 0.01, '=');
                                        if ACASenateReportsHeader."School Total Count" > 0 then
                                            ACASenateReportsHeader."School % Failed" := Round(((ACASenateReportsHeader."School Total Failed" / ACASenateReportsHeader."School Total Count") * 100), 0.01, '=');
                                        if ACASenateReportsHeader."School Total Count" > 0 then
                                            ACASenateReportsHeader."School % Passed" := Round(((ACASenateReportsHeader."School Total Passed" / ACASenateReportsHeader."School Total Count") * 100), 0.01, '=');
                                        if ACASenateReportsHeader."Prog. Total Count" > 0 then
                                            ACASenateReportsHeader."Prog. Class % Value" := Round(((ACASenateReportsHeader."Programme Classification Count" / ACASenateReportsHeader."Prog. Total Count") * 100), 0.01, '=');
                                        if ACASenateReportsHeader."Prog. Total Count" > 0 then
                                            ACASenateReportsHeader."Programme % Failed" := Round(((ACASenateReportsHeader."Programme Total Failed" / ACASenateReportsHeader."Prog. Total Count") * 100), 0.01, '=');
                                        if ACASenateReportsHeader."Prog. Total Count" > 0 then
                                            ACASenateReportsHeader."Programme % Passed" := Round(((ACASenateReportsHeader."Programme Total Passed" / ACASenateReportsHeader."Prog. Total Count") * 100), 0.01, '=');
                                        ACASenateReportsHeader.Modify;
                                    end;
                                    until ACASenateReportsHeader.Next = 0;
                                    ProgBar22.Close;
                                end;
                                // //
                                // //                CLEAR(SEQUENCES);
                                // //                CLEAR(CountedNos);
                                // //            REPEAT
                                // //              BEGIN
                                // //              CountedNos:=CountedNos+1;
                                // //              CLEAR(CurrSchool);
                                // //        ACAExamCourseRegistration.RESET;
                                // //        ACAExamCourseRegistration.SETRANGE("Year of Study",CountedNos);
                                // //        ACAExamCourseRegistration.SETRANGE("Academic Year",GradAcademicYear);
                                // //        ACAExamCourseRegistration.SETRANGE("Resit Exists",TRUE);
                                // //        ACAExamCourseRegistration.SETCURRENTKEY("Academic Year","Year of Study","Student Number");
                                // //        IF  ACAExamCourseRegistration.FIND('-') THEN BEGIN
                                // //                CLEAR(SEQUENCES);
                                // //          REPEAT
                                // //              BEGIN
                                // //              IF CurrSchool<>ACAExamCourseRegistration."School Code" THEN BEGIN
                                // //                CurrSchool:=ACAExamCourseRegistration."School Code";
                                // //                CLEAR(SEQUENCES);
                                // //
                                // //                END;
                                // //              SEQUENCES:=SEQUENCES+1;
                                // //              ACAExamCourseRegistration."Cumm. Resit Serial":=SEQUENCES;
                                // //              ACAExamCourseRegistration.MODIFY;
                                // //              END;
                                // //            UNTIL ACAExamCourseRegistration.NEXT=0;
                                // //          END;
                                // //          END;
                                // //          UNTIL CountedNos=8;

                                // //
                                // //                CLEAR(SEQUENCES);
                                // //                CLEAR(CurrStudentNo);
                                // //          ACAExamCummulativeResit.RESET;
                                // //        ACAExamCummulativeResit.SETRANGE("Academic Year",GradAcademicYear);
                                // //        ACAExamCummulativeResit.SETFILTER(Programme,ProgFIls);
                                // //        ACAExamCummulativeResit.SETCURRENTKEY(Programme,"Student Number");
                                // //        IF ACAExamCummulativeResit.FIND('-') THEN BEGIN
                                // //          REPEAT
                                // //            BEGIN
                                // //             IF CurrStudentNo<> ACAExamCummulativeResit."Student Number" THEN BEGIN
                                // //               CurrStudentNo:= ACAExamCummulativeResit."Student Number";
                                // //               SEQUENCES:=SEQUENCES+1;
                                // //
                                // //               END;
                                // //               ACAExamCummulativeResit.Serial:=SEQUENCES;
                                // //               ACAExamCummulativeResit.MODIFY;
                                // //            END;
                                // //            UNTIL ACAExamCummulativeResit.NEXT=0;
                                // //          END;



                            end;
                        end;
                        until AcademicYear_Finz.Next = 0;
                    end;
                    Message('Processing completed successfully!');
                    if StrLen(programs) > 249 then programs := CopyStr(programs, 1, 249);
                    ///IF STRLEN(Semesters)>249 THEN Semesters:=COPYSTR(Semesters,1,249);
                    if StrLen(AcadYear) > 249 then GradAcademicYear := CopyStr(AcadYear, 1, 249) else GradAcademicYear := AcadYear;
                    if StrLen(Schools) > 249 then Schools := CopyStr(Schools, 1, 249);

                    UpdateFilters(UserId, programs, GradAcademicYear, Schools);
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        ACAExamProcessingFilterLog: Record "ACA-Exam Processing Filter Log";
    begin
        ACAExamProcessingFilterLog.Reset;
        ACAExamProcessingFilterLog.SetRange("User ID", UserId);
        if ACAExamProcessingFilterLog.Find('-') then begin
            // //    Semesters:=ACAExamProcessingFilterLog."Semester Code";
            programs := ACAExamProcessingFilterLog."Programme Code";
            Schools := ACAExamProcessingFilterLog."School Filters"
            //GradAcademicYear:=ACAExamProcessingFilterLog."Graduation Year";
        end;
        ACAAcademicYear963.Reset;
        ACAAcademicYear963.SetRange("Graduating Group", true);
        if not ACAAcademicYear963.Find('-') then Error('Graduating group is not defined!');
        GradAcademicYear := ACAAcademicYear963.Code;
    end;

    var
        programs: Code[1024];
        AcadYear: Code[1024];
        Stages: Code[1024];
        StudNos: Code[1024];
        ACAExamResultsBuffer2: Record "ACA-Exam Results Buffer 2";
        ACAExamResults: Record "ACA-Exam Results";
        SemesterFilter: Text[1024];
        AcaSpecialExamsResults: Record "Aca-Special Exams Results";
        GradAcademicYear: Code[1024];
        ACACourseRegistration5: Record "ACA-Course Registration";
        Progrezz: Dialog;
        ACAProgramme963: Record "ACA-Programme";
        ACAAcademicYear963: Record "ACA-Academic Year";
        Schools: Code[1024];
        UnitCode: Code[1024];
        ACAProgrammeStages: Record "ACA-Programme Stages";
        ProgFIls: Text[1024];
        Progressbar: Dialog;
        ToGraduate: Boolean;
        AcademicYear_Finz: Record "ACA-Academic Year";
        YosStages: Text[150];

    local procedure UpdateFilters(UserCode: Code[50]; ProgCodes: Code[1024]; GradYearOfStudy: Code[1024]; Schoolscodes: Code[250])
    var
        ACAExamProcessingFilterLog: Record "ACA-Exam Processing Filter Log";
    begin
        ACAExamProcessingFilterLog.Reset;
        ACAExamProcessingFilterLog.SetRange("User ID", UserCode);
        if ACAExamProcessingFilterLog.Find('-') then begin
            //Exists, Update
            ACAExamProcessingFilterLog."Programme Code" := ProgCodes;
            // //  ACAExamProcessingFilterLog."Graduation Year":=GradAcademicYear;
            ACAExamProcessingFilterLog."School Filters" := Schoolscodes;
            ACAExamProcessingFilterLog.Modify;
        end else begin
            // Doesent Exists, Insert
            ACAExamProcessingFilterLog.Init;
            ACAExamProcessingFilterLog."User ID" := UserCode;
            ACAExamProcessingFilterLog."Programme Code" := ProgCodes;
            // //  ACAExamProcessingFilterLog."Semester Code":=Semesters;
            // //  ACAExamProcessingFilterLog."Graduation Year":=GradAcademicYear;
            ACAExamProcessingFilterLog."School Filters" := Schoolscodes;
            ACAExamProcessingFilterLog.Insert;
        end;
    end;

    local procedure GetStudentName(StudNo: Code[20]) StudName: Text[250]
    var
        Customer: Record Customer;
    begin
        Customer.Reset;
        Customer.SetRange("No.", StudNo);
        if Customer.Find('-') then begin
            if StrLen(Customer.Name) > 100 then Customer.Name := CopyStr(Customer.Name, 1, 100);
            Customer.Name := Customer.Name;
            Customer.Modify;
            StudName := Customer.Name;
        end;
    end;

    local procedure GetDepartmentNameOrSchool(DimCode: Code[20]) DimName: Text[150]
    var
        dimVal: Record "Dimension Value";
    begin
        dimVal.Reset;
        dimVal.SetRange(Code, DimCode);
        if dimVal.Find('-') then DimName := dimVal.Name;
    end;

    local procedure GetFinalStage(ProgCode: Code[20]) FinStage: Code[20]
    var
        ACAProgrammeStages: Record "ACA-Programme Stages";
    begin
        Clear(FinStage);
        ACAProgrammeStages.Reset;
        ACAProgrammeStages.SetRange("Programme Code", ProgCode);
        ACAProgrammeStages.SetRange("Final Stage", true);
        if ACAProgrammeStages.Find('-') then begin
            FinStage := ACAProgrammeStages.Code;
        end;
    end;

    local procedure GetFinalYearOfStudy(ProgCode: Code[20]) FinYearOfStudy: Integer
    var
        ACAProgrammeStages: Record "ACA-Programme Stages";
    begin
        Clear(FinYearOfStudy);
        ACAProgrammeStages.Reset;
        ACAProgrammeStages.SetRange("Programme Code", ProgCode);
        ACAProgrammeStages.SetRange("Final Stage", true);
        if ACAProgrammeStages.Find('-') then begin
            if StrLen(ACAProgrammeStages.Code) > 2 then begin
                if Evaluate(FinYearOfStudy, CopyStr(ACAProgrammeStages.Code, 2, 1)) then;
            end;
        end;
    end;

    local procedure GetAdmissionDate(StudNo: Code[20]; ProgCode: Code[20]) AdmissionDate: Date
    var
        coregz: Record "ACA-Course Registration";
    begin
        Clear(AdmissionDate);
        coregz.Reset;
        coregz.SetRange("Student No.", StudNo);
        coregz.SetRange(Programmes, ProgCode);
        coregz.SetRange(Reversed, false);
        if coregz.Find('-') then begin
            AdmissionDate := coregz."Registration Date";
        end;
    end;

    local procedure GetAdmissionAcademicYear(StudNo: Code[20]; ProgCode: Code[20]) AdmissionAcadYear: Code[20]
    var
        coregz: Record "ACA-Course Registration";
    begin
        Clear(AdmissionAcadYear);
        coregz.Reset;
        coregz.SetRange("Student No.", StudNo);
        coregz.SetRange(Programmes, ProgCode);
        coregz.SetRange(Reversed, false);
        if coregz.Find('-') then begin
            AdmissionAcadYear := coregz."Academic Year";
        end;
    end;

    local procedure GetFinalAcademicYear(StudNo: Code[20]; ProgCode: Code[20]) FinalAcadYear: Code[20]
    var
        coregz: Record "ACA-Course Registration";
    begin
        Clear(FinalAcadYear);
        coregz.Reset;
        coregz.SetRange("Student No.", StudNo);
        coregz.SetRange(Programmes, ProgCode);
        coregz.SetRange(Reversed, false);
        if coregz.Find('+') then begin
            FinalAcadYear := coregz."Academic Year";
        end;
    end;

    local procedure GetMultipleProgramExists(StudNoz: Code[20]) Multiples: Boolean
    var
        ACAExamClassificationStuds: Record "ACA-Exam Classification Studs";
        ClassClassificationCourseReg: Record "ACA-Classification Course Reg.";
        ClassClassificationUnits: Record "ACA-Classification Units";
    begin
        ACAExamClassificationStuds.Reset;
        ACAExamClassificationStuds.SetRange("Student Number", StudNoz);
        if ACAExamClassificationStuds.Find('-') then
            if ACAExamClassificationStuds.Count > 1 then Multiples := true else Multiples := false;
    end;

    local procedure GetCohort(StudNo: Code[20]; ProgCode: Code[20]) Cohort: Code[20]
    var
        coregz: Record "ACA-Course Registration";
        ACAProgrammeGraduationGroup: Record "ACA-Programme Graduation Group";
    begin
        Clear(Cohort);
        coregz.Reset;
        coregz.SetRange("Student No.", StudNo);
        coregz.SetRange(Programmes, ProgCode);
        coregz.SetRange(Reversed, false);
        if coregz.Find('-') then begin
            ACAProgrammeGraduationGroup.Reset;
            ACAProgrammeGraduationGroup.SetRange("Programme Code", ProgCode);
            ACAProgrammeGraduationGroup.SetRange("Admission Academic Year", coregz."Academic Year");
            if ACAProgrammeGraduationGroup.Find('-') then
                ACAProgrammeGraduationGroup.TestField("Graduation Academic Year");
            Cohort := ACAProgrammeGraduationGroup."Admission Academic Year";
        end;
    end;

    local procedure RequiredStageUnits(ProgCode: Code[20]; YoS: Integer; StudNo: Code[20]) ExpectedUnits: Decimal
    var
        ACADefinedUnitsperYoS: Record "ACA-Defined Units per YoS";
        AcacourseReg: Record "ACA-Course Registration";
    begin
        ACADefinedUnitsperYoS.Reset;
        ACADefinedUnitsperYoS.SetRange("Year of Study", YoS);
        ACADefinedUnitsperYoS.SetRange(Programmes, ProgCode);
        AcacourseReg.Reset;
        AcacourseReg.SetRange("Student No.", StudNo);
        AcacourseReg.SetRange(Programmes, ProgCode);
        AcacourseReg.SetRange("Year Of Study", YoS);
        if AcacourseReg.Find('-') then
            if AcacourseReg.Options <> '-' then
                ACADefinedUnitsperYoS.SetRange(Options, AcacourseReg.Options);
        if ACADefinedUnitsperYoS.Find('-') then ExpectedUnits := ACADefinedUnitsperYoS."Number of Units";
    end;

    local procedure GetClassification(ProgramCode: Code[100]; AverageScore: Decimal; HasIrregularity: Boolean) Classification: Code[100]
    var
        ACAClassGradRubrics: Record "ACA-Class/Grad. Rubrics";
        ACAProgramme123: Record "ACA-Programme";
        ACAGradingSystemSetup: Record "ACA-Exam Gradding Setup";
    begin
        Clear(Classification);
        ACAProgramme123.Reset;
        ACAProgramme123.SetRange(Code, ProgramCode);
        if ACAProgramme123.Find('-') then begin
            ACAGradingSystemSetup.Reset;
            ACAGradingSystemSetup.SetRange(Category, ACAProgramme123."Exam Category");
            ACAGradingSystemSetup.SetFilter("Lower Limit", '=%1|<%2', AverageScore, AverageScore);
            ACAGradingSystemSetup.SetFilter("Upper Limit", '>%2|=%1', AverageScore, AverageScore);
            if ACAGradingSystemSetup.Find('-') then begin
                if HasIrregularity then begin
                    ACAClassGradRubrics.Reset;
                    ACAClassGradRubrics.SetRange(Code, ACAGradingSystemSetup.Remarks);
                    if ACAClassGradRubrics.Find('-') then begin
                        if ACAClassGradRubrics."Alternate Rubric" <> '' then begin
                            Classification := ACAClassGradRubrics."Alternate Rubric";
                        end else begin
                            Classification := ACAGradingSystemSetup.Remarks;
                        end;
                    end else begin
                        Classification := ACAGradingSystemSetup.Remarks;
                    end;
                end else begin
                    Classification := ACAGradingSystemSetup.Remarks;
                end;
            end;
        end;
    end;

    procedure GetClassificationGrade(EXAMMark: Decimal; Proga: Code[20]) xGrade: Text[100]
    var
        UnitsRR: Record "ACA-Units/Subjects";
        ProgrammeRec: Record "ACA-Programme";
        LastGrade: Code[20];
        LastRemark: Code[20];
        ExitDo: Boolean;
        LastScore: Decimal;
        Gradings: Record "ACA-Exam Gradding Setup";
        Gradings2: Record "ACA-Exam Gradding Setup";
        GradeCategory: Code[20];
        GLabel: array[6] of Code[20];
        i: Integer;
        GLabel2: array[6] of Code[100];
        FStatus: Boolean;
        Grd: Code[80];
        Grade: Code[20];
        Marks: Decimal;
    begin
        Clear(Marks);
        Marks := EXAMMark;
        GradeCategory := '';
        ProgrammeRec.Reset;
        if ProgrammeRec.Get(Proga) then
            GradeCategory := ProgrammeRec."Exam Category";
        if GradeCategory = '' then GradeCategory := 'DEFAULT';
        xGrade := '';
        if Marks > 0 then begin
            Gradings.Reset;
            Gradings.SetRange(Gradings.Category, GradeCategory);
            Gradings.SetFilter(Gradings."Lower Limit", '<%1|=%2', Marks, Marks);
            Gradings.SetFilter(Gradings."Upper Limit", '>%1|=%2', Marks, Marks);
            LastGrade := '';
            LastRemark := '';
            LastScore := 0;
            if Gradings.Find('-') then begin
                ExitDo := false;
                //REPEAT
                LastScore := Gradings."Up to";
                if Marks < LastScore then begin
                    if ExitDo = false then begin
                        xGrade := Gradings.Grade;
                        if Gradings.Failed = false then
                            LastRemark := 'PASS'
                        else
                            LastRemark := 'FAIL';
                        ExitDo := true;
                    end;
                end;


            end;

        end;
    end;

    procedure GetClassPassStatus(EXAMMark: Decimal; Proga: Code[20]) Passed: Boolean
    var
        UnitsRR: Record "ACA-Units/Subjects";
        ProgrammeRec: Record "ACA-Programme";
        LastGrade: Code[20];
        LastRemark: Code[20];
        ExitDo: Boolean;
        LastScore: Decimal;
        Gradings: Record "ACA-Exam Gradding Setup";
        Gradings2: Record "ACA-Exam Gradding Setup";
        GradeCategory: Code[20];
        GLabel: array[6] of Code[20];
        i: Integer;
        GLabel2: array[6] of Code[100];
        FStatus: Boolean;
        Grd: Code[80];
        Grade: Code[20];
        Marks: Decimal;
    begin
        Clear(Marks);
        Marks := EXAMMark;
        GradeCategory := '';
        ProgrammeRec.Reset;
        if ProgrammeRec.Get(Proga) then
            GradeCategory := ProgrammeRec."Exam Category";
        if GradeCategory = '' then GradeCategory := 'DEFAULT';

        Passed := false;
        if Marks > 0 then begin
            Gradings.Reset;
            Gradings.SetRange(Gradings.Category, GradeCategory);
            Gradings.SetFilter(Gradings."Lower Limit", '<%1|=%2', Marks, Marks);
            Gradings.SetFilter(Gradings."Upper Limit", '>%1|=%2', Marks, Marks);
            LastGrade := '';
            LastRemark := '';
            LastScore := 0;
            if Gradings.Find('-') then begin
                ExitDo := false;
                //REPEAT
                LastScore := Gradings."Up to";
                if Marks < LastScore then begin
                    if ExitDo = false then begin
                        if Gradings.Failed then
                            Passed := false else
                            Passed := true;
                        if Gradings.Failed = false then
                            LastRemark := 'PASS'
                        else
                            LastRemark := 'FAIL';
                        ExitDo := true;
                    end;
                end;


            end;

        end;
    end;

    local procedure GetClassificationOrder(ProgramCode: Code[100]; AverageScore: Decimal; HasIrregularity: Boolean) ClassOrder: Integer
    var
        ACAClassGradRubrics: Record "ACA-Class/Grad. Rubrics";
        ACAProgramme123: Record "ACA-Programme";
        ACAGradingSystemSetup: Record "ACA-Exam Gradding Setup";
        Classification: Code[50];
    begin
        Clear(Classification);
        ACAProgramme123.Reset;
        ACAProgramme123.SetRange(Code, ProgramCode);
        if ACAProgramme123.Find('-') then begin
            ACAGradingSystemSetup.Reset;
            ACAGradingSystemSetup.SetRange(Category, ACAProgramme123."Exam Category");
            ACAGradingSystemSetup.SetFilter("Lower Limit", '=%1|<%2', AverageScore, AverageScore);
            ACAGradingSystemSetup.SetFilter("Upper Limit", '>%2|=%1', AverageScore, AverageScore);
            if ACAGradingSystemSetup.Find('-') then begin
                if HasIrregularity then begin
                    ACAClassGradRubrics.Reset;
                    ACAClassGradRubrics.SetRange(Code, ACAGradingSystemSetup.Remarks);
                    if ACAClassGradRubrics.Find('-') then begin
                        if ACAClassGradRubrics."Alternate Rubric" <> '' then begin
                            Classification := ACAClassGradRubrics."Alternate Rubric";
                        end else begin
                            Classification := ACAGradingSystemSetup.Remarks;
                        end;
                    end else begin
                        Classification := ACAGradingSystemSetup.Remarks;
                    end;
                end else begin
                    Classification := ACAGradingSystemSetup.Remarks;
                end;
            end;
        end;
        Clear(ClassOrder);
        ACAClassGradRubrics.Reset;
        ACAClassGradRubrics.SetRange(Code, Classification);
        if ACAClassGradRubrics.Find('-') then
            ClassOrder := ACAClassGradRubrics."Order No";
    end;

    local procedure GetYearOfStudy(StageCode: Code[20]) YearOfStudy: Integer
    var
        ACAProgrammeStages: Record "ACA-Programme Stages";
    begin
        Clear(YearOfStudy);

        if StrLen(StageCode) > 2 then begin
            if Evaluate(YearOfStudy, CopyStr(StageCode, 2, 1)) then;
        end;
    end;

    local procedure GetRubric(ACAProgramme: Record "ACA-Programme"; CoursesRegz: Record "ACA-Exam. Course Registration") StatusRemarks: Text[150]
    var
        Customer: Record Customer;
        LubricIdentified: Boolean;
        ACAResultsStatus: Record "ACA-Results Status";
        YearlyReMarks: Text[250];
    begin
        Clear(StatusRemarks);
        Clear(YearlyReMarks);
        Customer.Reset;
        Customer.SetRange("No.", CoursesRegz."Student Number");
        if Customer.Find('-') then begin
            if ((Customer.Status = Customer.Status::Registration) or (Customer.Status = Customer.Status::Current)) then begin
                Clear(LubricIdentified);
                CoursesRegz.CalcFields("Attained Stage Units", "Failed Cores", "Failed Courses", "Failed Electives", "Failed Required", "Failed Units",
                "Total Failed Units", "Total Marks", "Total Required Done",
                "Total Required Passed", "Total Units", "Total Weighted Marks");
                CoursesRegz.CalcFields("Total Cores Done", "Total Cores Passed", "Total Courses", "Total Electives Done", "Total Failed Courses",
                "Tota Electives Passed", "Total Classified C. Count", "Total Classified Units", "Total Classified Units");
                // // // //          IF CoursesRegz."Units Deficit">0 THEN BEGIN
                // // // //            CoursesRegz."Failed Cores":=CoursesRegz."Failed Cores"+CoursesRegz."Units Deficit";
                // // // //            CoursesRegz."Failed Courses":=CoursesRegz."Failed Courses"+CoursesRegz."Units Deficit";
                // // // //            CoursesRegz."Total Failed Courses":=CoursesRegz."Total Failed Courses"+CoursesRegz."Units Deficit";
                // // // //            CoursesRegz."Total Courses":=CoursesRegz."Total Courses"+CoursesRegz."Units Deficit";
                // // // //            END;
                if CoursesRegz."Total Courses" > 0 then
                    CoursesRegz."% Failed Courses" := (CoursesRegz."Failed Courses" / CoursesRegz."Total Courses") * 100;
                CoursesRegz."% Failed Courses" := Round(CoursesRegz."% Failed Courses", 0.01, '=');
                if CoursesRegz."% Failed Courses" > 100 then CoursesRegz."% Failed Courses" := 100;
                if CoursesRegz."Total Cores Done" > 0 then
                    CoursesRegz."% Failed Cores" := ((CoursesRegz."Failed Cores" / CoursesRegz."Total Cores Done") * 100);
                CoursesRegz."% Failed Cores" := Round(CoursesRegz."% Failed Cores", 0.01, '=');
                if CoursesRegz."% Failed Cores" > 100 then CoursesRegz."% Failed Cores" := 100;
                if CoursesRegz."Total Units" > 0 then
                    CoursesRegz."% Failed Units" := (CoursesRegz."Failed Units" / CoursesRegz."Total Units") * 100;
                CoursesRegz."% Failed Units" := Round(CoursesRegz."% Failed Units", 0.01, '=');
                if CoursesRegz."% Failed Units" > 100 then CoursesRegz."% Failed Units" := 100;
                if CoursesRegz."Total Electives Done" > 0 then
                    CoursesRegz."% Failed Electives" := (CoursesRegz."Failed Electives" / CoursesRegz."Total Electives Done") * 100;
                CoursesRegz."% Failed Electives" := Round(CoursesRegz."% Failed Electives", 0.01, '=');
                if CoursesRegz."% Failed Electives" > 100 then CoursesRegz."% Failed Electives" := 100;
                CoursesRegz.Modify;
                if (CoursesRegz."Student Number" = 'MML/00110/019') then
                    ACAResultsStatus.Reset;
                ACAResultsStatus.Reset;
                ACAResultsStatus.SetFilter("Manual Status Processing", '%1', false);
                ACAResultsStatus.SetRange("Academic Year", CoursesRegz."Academic Year");
                ACAResultsStatus.SetRange("Special Programme Class", ACAProgramme."Special Programme Class");
                // ACAResultsStatus.SETFILTER("Min. Unit Repeat Counts",'=%1|<%2',CoursesRegz."Highest Yearly Repeats",CoursesRegz."Highest Yearly Repeats");
                // ACAResultsStatus.SETFILTER("Max. Unit Repeat Counts",'=%1|>%2',CoursesRegz."Highest Yearly Repeats",CoursesRegz."Highest Yearly Repeats");
                // ACAResultsStatus.SETFILTER("Minimum Units Failed",'=%1|<%2',CoursesRegz."Yearly Failed Units %",CoursesRegz."Yearly Failed Units %");
                // ACAResultsStatus.SETFILTER("Maximum Units Failed",'=%1|>%2',CoursesRegz."Yearly Failed Units %",CoursesRegz."Yearly Failed Units %");
                if ACAProgramme."Special Programme Class" = ACAProgramme."Special Programme Class"::"Medicine & Nursing" then begin
                    if CoursesRegz."% Failed Cores" > 0 then begin
                        ACAResultsStatus.SetFilter("Minimum Core Fails", '=%1|<%2', CoursesRegz."% Failed Cores", CoursesRegz."% Failed Cores");
                        ACAResultsStatus.SetFilter("Maximum Core Fails", '=%1|>%2', CoursesRegz."% Failed Cores", CoursesRegz."% Failed Cores");
                    end else begin
                        ACAResultsStatus.SetFilter("Minimum Units Failed", '=%1|<%2', CoursesRegz."Failed Courses", CoursesRegz."Failed Courses");
                        ACAResultsStatus.SetFilter("Maximum Units Failed", '=%1|>%2', CoursesRegz."Failed Courses", CoursesRegz."Failed Courses");
                    end;
                    //  ACAResultsStatus.SETFILTER("Minimum None-Core Fails",'=%1|<%2',CoursesRegz."Failed Required",CoursesRegz."Failed Required");
                    // ACAResultsStatus.SETFILTER("Maximum None-Core Fails",'=%1|>%2',CoursesRegz."Failed Required",CoursesRegz."Failed Required");
                end
                else begin
                    ACAResultsStatus.SetFilter("Minimum Units Failed", '=%1|<%2', CoursesRegz."Failed Courses", CoursesRegz."Failed Courses");
                    ACAResultsStatus.SetFilter("Maximum Units Failed", '=%1|>%2', CoursesRegz."Failed Courses", CoursesRegz."Failed Courses");
                end;
                // // // // // ELSE BEGIN
                // // // // // ACAResultsStatus.SETFILTER("Minimum Units Failed",'=%1|<%2',YearlyFailedUnits,YearlyFailedUnits);
                // // // // // ACAResultsStatus.SETFILTER("Maximum Units Failed",'=%1|>%2',YearlyFailedUnits,YearlyFailedUnits);
                // // // // //  END;
                ACAResultsStatus.SetCurrentKey("Order No");
                if ACAResultsStatus.Find('-') then begin
                    repeat
                    begin
                        StatusRemarks := ACAResultsStatus.Code;
                        if ACAResultsStatus."Lead Status" <> '' then
                            StatusRemarks := ACAResultsStatus."Lead Status";
                        YearlyReMarks := ACAResultsStatus."Transcript Remarks";
                        LubricIdentified := true;
                    end;
                    until ((ACAResultsStatus.Next = 0) or (LubricIdentified = true))
                end;
            end else begin

                ACAResultsStatus.Reset;
                ACAResultsStatus.SetRange(Status, Customer.Status);
                ACAResultsStatus.SetRange("Academic Year", CoursesRegz."Academic Year");
                ACAResultsStatus.SetRange("Special Programme Class", ACAProgramme."Special Programme Class");
                if ACAResultsStatus.Find('-') then begin
                    StatusRemarks := ACAResultsStatus.Code;
                    YearlyReMarks := ACAResultsStatus."Transcript Remarks";
                end else begin
                    StatusRemarks := UpperCase(Format(Customer.Status));
                    YearlyReMarks := StatusRemarks;
                end;
            end;
        end;
    end;

    local procedure GetRubricPassStatus(RubricCode: Code[50]; AcademicYears: Code[20]; Progyz: Record "ACA-Programme") PassStatus: Boolean
    var
        ACAResultsStatus: Record "ACA-Results Status";
    begin

        ACAResultsStatus.Reset;
        ACAResultsStatus.SetRange(Code, RubricCode);
        ACAResultsStatus.SetRange("Academic Year", AcademicYears);
        ACAResultsStatus.SetRange("Special Programme Class", Progyz."Special Programme Class");
        if ACAResultsStatus.Find('-') then begin
            PassStatus := ACAResultsStatus.Pass;
        end;
    end;

    local procedure GetRubricOrder(RubricCode: Code[50]) RubricOrder: Integer
    var
        ACAResultsStatus: Record "ACA-Results Status";
    begin

        ACAResultsStatus.Reset;
        ACAResultsStatus.SetRange(Code, RubricCode);
        if ACAResultsStatus.Find('-') then begin
            RubricOrder := ACAResultsStatus."Order No";
        end;
    end;

    local procedure GetProgFilters1(Programs: Code[1024]; Schools: Code[1024]) ProgFilters: Code[1024]
    var
        ACAProgramme963: Record "ACA-Programme";
        Progs2: Code[1024];
        exitLoop: Boolean;
    begin
        Clear(Progs2);
        Clear(ProgFilters);
        if ((Schools = '') and (Programs = '')) then Error('Specify a Programme and/or a School filter');
        Clear(exitLoop);
        if Schools <> '' then begin
            ACAProgramme963.Reset;
            ACAProgramme963.SetFilter(ACAProgramme963."School Code", Schools);
            if ACAProgramme963.Find('-') then begin
                repeat
                begin
                    if ACAProgramme963.Code <> '' then begin
                        if ProgFilters = '' then
                            ProgFilters := ACAProgramme963.Code
                        else begin
                            if (StrLen(ProgFilters) + StrLen(ACAProgramme963.Code)) < 1024 then begin
                                ProgFilters := ProgFilters + '|' + ACAProgramme963.Code;
                            end else begin
                                // //                IF Progs2='' THEN Progs2:=ACAProgramme963.Code ELSE BEGIN
                                // //                 IF (STRLEN(Progs2)+STRLEN(ACAProgramme963.Code)) < 1024 THEN BEGIN
                                // //                   Progs2:=Progs2+'|'+ACAProgramme963.Code;
                                // //                   END;
                                // //                  END;

                            end;
                        end;
                    end;
                end;
                until ((ACAProgramme963.Next = 0) or (exitLoop = true));
            end;
        end else
            if Programs <> '' then begin
                ProgFilters := Programs;
            end;
    end;

    local procedure GetProgFilters2(Programs: Code[1024]; Schools: Code[1024]) Progs2: Code[1024]
    var
        ACAProgramme963: Record "ACA-Programme";
        ProgFilters: Code[1024];
    begin
        Clear(Progs2);
        Clear(ProgFilters);
        if ((Schools = '') and (Programs = '')) then Error('Specify a Programme and/or a School filter');

        if Schools <> '' then begin
            ACAProgramme963.Reset;
            ACAProgramme963.SetFilter(ACAProgramme963."School Code", Schools);
            if ACAProgramme963.Find('-') then begin
                repeat
                begin
                    if ACAProgramme963.Code <> '' then begin
                        if ProgFilters = '' then
                            ProgFilters := ACAProgramme963.Code
                        else begin
                            if (StrLen(ProgFilters) + StrLen(ACAProgramme963.Code)) < 1024 then begin
                                ProgFilters := ProgFilters + '|' + ACAProgramme963.Code;
                            end else begin
                                if Progs2 = '' then
                                    Progs2 := ACAProgramme963.Code else begin
                                    if (StrLen(Progs2) + StrLen(ACAProgramme963.Code)) < 1024 then begin
                                        Progs2 := Progs2 + '|' + ACAProgramme963.Code;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
                until ACAProgramme963.Next = 0;
            end;
        end else
            if Programs <> '' then begin
                ProgFilters := Programs;
            end;
    end;

    local procedure GetUnitAcademicYear(ACAExamClassificationUnits9: Record "ACA-Exam Classification Units") AcademicYear: Code[20]
    var
        ACACourseRegistration9: Record "ACA-Course Registration";
    begin
        Clear(AcademicYear);
        ACACourseRegistration9.Reset;
        ACACourseRegistration9.SetRange("Student No.", ACAExamClassificationUnits9."Student No.");
        ACACourseRegistration9.SetRange(Programmes, ACAExamClassificationUnits9.Programme);
        ACACourseRegistration9.SetRange("Year Of Study", ACAExamClassificationUnits9."Year of Study");
        ACACourseRegistration9.SetRange(Reversed, false);
        ACACourseRegistration9.SetFilter("Academic Year", '<>%1', '');
        if ACACourseRegistration9.Find('-') then AcademicYear := ACACourseRegistration9."Academic Year"
    end;

    local procedure FormatNames(CommonName: Text[250]) NewName: Text[250]
    var
        NamesSmall: Text[250];
        FirsName: Text[250];
        SpaceCount: Integer;
        SpaceFound: Boolean;
        Counts: Integer;
        Strlegnth: Integer;
        OtherNames: Text[250];
        FormerCommonName: Text[250];
        OneSpaceFound: Boolean;
        Countings: Integer;
    begin
        Clear(OneSpaceFound);
        Clear(Countings);
        CommonName := ConvertStr(CommonName, ',', ' ');
        FormerCommonName := '';
        repeat
        begin
            Countings += 1;
            if CopyStr(CommonName, Countings, 1) = ' ' then begin
                if OneSpaceFound = false then FormerCommonName := FormerCommonName + CopyStr(CommonName, Countings, 1);
                OneSpaceFound := true
            end else begin
                OneSpaceFound := false;
                FormerCommonName := FormerCommonName + CopyStr(CommonName, Countings, 1)
            end;
        end;
        until Countings = StrLen(CommonName);
        CommonName := FormerCommonName;
        Clear(NamesSmall);
        Clear(FirsName);
        Clear(SpaceCount);
        Clear(SpaceFound);
        Clear(OtherNames);
        if StrLen(CommonName) > 100 then CommonName := CopyStr(CommonName, 1, 100);
        Strlegnth := StrLen(CommonName);
        if StrLen(CommonName) > 4 then begin
            NamesSmall := LowerCase(CommonName);
            repeat
            begin
                SpaceCount += 1;
                if ((CopyStr(NamesSmall, SpaceCount, 1) = '') or (CopyStr(NamesSmall, SpaceCount, 1) = ' ') or (CopyStr(NamesSmall, SpaceCount, 1) = ',')) then SpaceFound := true;
                if not SpaceFound then begin
                    FirsName := FirsName + UpperCase(CopyStr(NamesSmall, SpaceCount, 1));
                end else begin
                    if StrLen(OtherNames) < 150 then begin
                        if ((CopyStr(NamesSmall, SpaceCount, 1) = '') or (CopyStr(NamesSmall, SpaceCount, 1) = ' ') or (CopyStr(NamesSmall, SpaceCount, 1) = ',')) then begin
                            OtherNames := OtherNames + ' ';
                            SpaceCount += 1;
                            OtherNames := OtherNames + UpperCase(CopyStr(NamesSmall, SpaceCount, 1));
                        end else begin
                            OtherNames := OtherNames + CopyStr(NamesSmall, SpaceCount, 1);
                        end;

                    end;
                end;
            end;
            until ((SpaceCount = Strlegnth))
        end;
        Clear(NewName);
        NewName := FirsName + ',' + OtherNames;
    end;

    local procedure GetCummulativeFails(StudNo: Code[20]; YoS: Integer) CumFails: Integer
    var
        AcadClassUnits: Record "ACA-Exam Classification Units";
    begin
        AcadClassUnits.Reset;
        AcadClassUnits.SetRange("Student No.", StudNo);
        AcadClassUnits.SetFilter("Year of Study", '..%1', YoS);
        AcadClassUnits.SetRange(Pass, false);
        if AcadClassUnits.Find('-') then CumFails := AcadClassUnits.Count;
    end;

    local procedure GetCummulativeReqStageUnitrs(Programmez: Code[20]; YoS: Integer; ProgOption: Code[20]) CummReqUNits: Decimal
    var
        ACADefinedUnitsperYoS: Record "ACA-Defined Units per YoS";
    begin
        Clear(CummReqUNits);
        ACADefinedUnitsperYoS.Reset;
        ACADefinedUnitsperYoS.SetRange(Programmes, Programmez);
        ACADefinedUnitsperYoS.SetRange(Options, ProgOption);
        ACADefinedUnitsperYoS.SetFilter("Year of Study", '..%1', YoS);
        if ACADefinedUnitsperYoS.Find('-') then begin
            repeat
            begin
                CummReqUNits := CummReqUNits + ACADefinedUnitsperYoS."Number of Units";
            end;
            until ACADefinedUnitsperYoS.Next = 0;
        end;
    end;

    local procedure GetCummAttainedUnits(StudNo: Code[20]; YoS: Integer; Programmesz: Code[20]) CummAttained: Integer
    var
        AcadClassUnits: Record "ACA-Exam Classification Units";
    begin
        AcadClassUnits.Reset;
        AcadClassUnits.SetRange("Student No.", StudNo);
        AcadClassUnits.SetFilter("Year of Study", '..%1', YoS);
        AcadClassUnits.SetFilter(Programme, '%1', Programmesz);
        if AcadClassUnits.Find('-') then CummAttained := AcadClassUnits.Count;
    end;
}

