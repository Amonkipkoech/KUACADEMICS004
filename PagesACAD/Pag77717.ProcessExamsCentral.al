/// <summary>
/// Page Process Exams Central (ID 77717).
/// </summary>
page 77717 "Process Exams Central"
{
    PageType = Card;
    SourceTable = "ACA-Programme";
    // SourceTableView = WHERE(Code=FILTER('A100'));

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
                }
                field(progy; programs)
                {
                    Caption = 'Programme';
                    TableRelation = "ACA-Programme".Code;
                }
                field(Sem1; Semesters)
                {
                    Caption = 'Semester';
                    TableRelation = "ACA-Semesters".Code;
                }
                field(vo; UnitCode)
                {
                    Caption = 'Unit Code';
                }
                field(StudNo; StudNos)
                {
                    Caption = 'Student No';
                    TableRelation = Customer."No." WHERE("Customer Posting Group" = FILTER('STUDENT'));
                }
                field(v; GradAcademicYear)
                {
                    Caption = 'Grad. Academic Year';
                    Editable = false;
                    Enabled = false;
                    TableRelation = "ACA-Academic Year".Code;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("1")
            {
                Caption = 'Process Graduation';
                Image = EncryptionKeys;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ClassCourseRegistration: Record "ACA-Course Registration";
                    ClassStudentUnits: Record "ACA-Student Units";
                    ClassUnitsSubjects: Record "ACA-Units/Subjects";
                    ClassProgramme: Record "ACA-Programme";
                    ClassProgrammeStages: Record "ACA-Programme Stages";
                    ClassAcademicYear: Record "ACA-Academic Year";
                    ClassSemesters: Record "ACA-Semesters";
                    ClassExamResults: Record "ACA-Exam Results";
                    ClassSpecialExamsDetails: Record "Aca-Special Exams Details";
                    ClassCustomer: Record Customer;
                    ClassClassificationStudents: Record "ACA-Classification Students";
                    ClassClassificationCourseReg: Record "ACA-Classification Course Reg.";
                    ClassClassificationUnits: Record "ACA-Classification Units";
                    ClassExamResultsBuffer2: Record "ACA-Exam Results Buffer 2";
                    ClassDimensionValue: Record "Dimension Value";
                    ClassGradingSystem: Record "ACA-Grading System";
                    ClassClassGradRubrics: Record "ACA-Class/Grad. Rubrics";
                    ClassExamResults2: Record "ACA-Exam Results";
                    TotalRecs: Integer;
                    CountedRecs: Integer;
                    RemeiningRecs: Integer;
                    ACAClassificationStudentsCheck: Record "ACA-Classification Students";
                    ACANotGraduatingReasons: Record "ACA-Not Graduating Reasons";
                    ExpectedElectives: Integer;
                    CountedElectives: Integer;
                    ProgBar2: Dialog;
                    Progyz: Record "ACA-Programme";
                    ACADefinedUnitsperYoS: Record "ACA-Defined Units per YoS";
                    Progs2: Code[1024];
                    Total_First_Year_Courses: Integer;
                    Total_First_Year_Marks: Decimal;
                    New_Total_Marks: Decimal;
                    New_Total_Courses: Integer;
                    New_Classifiable_Average: Decimal;
                    ExistsOption: Option " ","Both Exists","CAT Only","Exam Only","None Exists";
                begin
                    //IF ((USERID<>'COSMAS.MUTHAMIA') AND (USERID<>'WANJALA') AND (USERID<>'OOKOTH') AND (USERID<>'JODERO')) THEN EXIT;
                    //if ((UserId <> 'ikioko') and (UserId <> 'Tom') and (UserId <> 'JODERO')) then exit;

                    if Confirm('Process Graduation?', true) = false then Error('Cancelled by user!');
                    Clear(ProgFIls);
                    Clear(Progs2);
                    ClassStudentUnits.Reset;
                    ClassStudentUnits.SetFilter(Status, '%1|%2|%3', ClassStudentUnits."Registration Status"::Current, ClassStudentUnits."Registration Status"::Registration, ClassStudentUnits."Registration Status"::Deceased);
                    if ((programs <> '') and (Schools = '')) then
                        ProgFIls := programs
                    else
                        if ((programs = '') and (Schools = '')) then Error('Specify at least a programm or a school on the filters!');
                    if Schools <> '' then begin
                        ACAProgramme963.Reset;
                        ACAProgramme963.SetFilter(ACAProgramme963."School Code", Schools);
                        if ACAProgramme963.Find('-') then begin
                            repeat
                            begin
                                if ACAProgramme963.Code <> '' then begin
                                    if ProgFIls = '' then
                                        ProgFIls := ACAProgramme963.Code
                                    else begin
                                        if (StrLen(ProgFIls) + StrLen(ACAProgramme963.Code)) < 1024 then begin
                                            ProgFIls := ProgFIls + '|' + ACAProgramme963.Code;
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
                    end;

                    // Check if for all the Programs within the filter, the final stage has been defined
                    ACAProgramme963.Reset;
                    ACAProgramme963.SetFilter(ACAProgramme963.Code, ProgFIls);
                    if ACAProgramme963.Find('-') then begin
                        repeat
                        begin
                            ACAProgrammeStages.Reset;
                            ACAProgrammeStages.SetRange("Programme Code", ACAProgramme963.Code);
                            ACAProgrammeStages.SetRange("Final Stage", true);
                            if not ACAProgrammeStages.Find('-') then begin
                                ACACourseRegistration.Reset;
                                ACACourseRegistration.SetRange(Programmes, ACAProgramme963.Code);
                                ACACourseRegistration.SetFilter(Status, '%1|%2|%3', ACACourseRegistration.Status::Current, ACACourseRegistration.Status::Registration, ACACourseRegistration.Status::Deceased);
                                if ACACourseRegistration.Find('-') then Error('Programme ''' + ACAProgramme963.Code + ''' has no defined Final Stage');
                            end;
                        end;
                        until ACAProgramme963.Next = 0;
                    end;
                    if Progs2 <> '' then begin
                        ACAProgramme963.Reset;
                        ACAProgramme963.SetFilter(ACAProgramme963.Code, Progs2);
                        if ACAProgramme963.Find('-') then begin
                            repeat
                            begin
                                ACAProgrammeStages.Reset;
                                ACAProgrammeStages.SetRange("Programme Code", ACAProgramme963.Code);
                                ACAProgrammeStages.SetRange("Final Stage", true);
                                if not ACAProgrammeStages.Find('-') then begin
                                    ACACourseRegistration.Reset;
                                    ACACourseRegistration.SetRange(Programmes, ACAProgramme963.Code);
                                    ACACourseRegistration.SetFilter(Status, '%1|%2|%3', ACACourseRegistration.Status::Current, ACACourseRegistration.Status::Registration, ACACourseRegistration.Status::Deceased);
                                    if ACACourseRegistration.Find('-') then Error('Programme ''' + ACAProgramme963.Code + ''' has no defined Final Stage');
                                end;
                            end;
                            until ACAProgramme963.Next = 0;
                        end;
                    end;

                    Clear(TotalRecs);
                    Clear(RemeiningRecs);
                    Clear(CountedRecs);
                    // Clear CLassification For Selected Filters
                    ClassClassificationStudents.Reset;
                    ClassClassificationCourseReg.Reset;
                    ClassClassificationUnits.Reset;
                    ClassClassificationStudents.SetRange("Graduation Academic Year", GradAcademicYear);
                    ClassClassificationCourseReg.SetRange("Graduation Academic Year", GradAcademicYear);
                    ClassClassificationUnits.SetRange("Graduation Academic Year", GradAcademicYear);
                    ClassClassificationStudents.SetFilter(Programme, ProgFIls);
                    ClassClassificationCourseReg.SetFilter(Programme, ProgFIls);
                    ClassClassificationUnits.SetFilter(Programme, ProgFIls);
                    if ClassClassificationStudents.Find('-') then ClassClassificationStudents.DeleteAll;
                    if ClassClassificationCourseReg.Find('-') then ClassClassificationCourseReg.DeleteAll;
                    if ClassClassificationUnits.Find('-') then ClassClassificationUnits.DeleteAll;

                    // Populate Classification Tables Here
                    if StudNos <> '' then
                        ClassStudentUnits.SetFilter("Student No.", StudNos) else
                        ClassStudentUnits.SetFilter(Programme, ProgFIls);
                    ClassStudentUnits.SetFilter("Exists Final Stage", '%1', true);
                    if ClassStudentUnits.Find('-') then begin
                        TotalRecs := ClassStudentUnits.Count;
                        RemeiningRecs := TotalRecs;
                        // Loop through all the Units Reg. for the Students that are Finalists Populating the Classification tables
                        Progressbar.Open('#1#####################################################\' +
                        '#2############################################################\' +
                        '#3###########################################################\' +
                        '#4############################################################\' +
                        '#5###########################################################\' +
                        '#6############################################################');
                        Progressbar.Update(1, 'Processing Graduation values....');
                        Progressbar.Update(2, 'Total Recs.: ' + Format(TotalRecs));
                        repeat
                        begin
                            ClassStudentUnits.CalcFields("Prog. Category");
                            CountedRecs := CountedRecs + 1;
                            RemeiningRecs := RemeiningRecs - 1;
                            // Create Registration Unit entry if Not Exists
                            Progressbar.Update(3, '.....................................................');
                            Progressbar.Update(4, 'Processed: ' + Format(CountedRecs));
                            Progressbar.Update(5, 'Remaining: ' + Format(RemeiningRecs));
                            Progressbar.Update(6, '----------------------------------------------------');
                            //Get best CAT Marks
                            ClassStudentUnits."Unit not in Catalogue" := false;
                            ClassUnitsSubjects.Reset;
                            ClassUnitsSubjects.SetRange("Programme Code", ClassStudentUnits.Programme);
                            ClassUnitsSubjects.SetRange(Code, ClassStudentUnits.Unit);
                            if ClassUnitsSubjects.Find('-') then begin
                                ClassClassificationStudents.Reset;
                                ClassClassificationStudents.SetRange("Student Number", ClassStudentUnits."Student No.");
                                ClassClassificationStudents.SetRange(Programme, ClassStudentUnits.Programme);
                                ClassClassificationStudents.SetRange("Graduation Academic Year", GradAcademicYear);
                                if not ClassClassificationStudents.Find('-') then begin
                                    ClassClassificationStudents.Init;
                                    ClassClassificationStudents."Student Number" := ClassStudentUnits."Student No.";
                                    ClassClassificationStudents.Programme := ClassStudentUnits.Programme;
                                    ClassClassificationStudents."Graduation Academic Year" := GradAcademicYear;
                                    ClassClassificationStudents."Year of Study" := GetYearOfStudy(ClassUnitsSubjects."Stage Code");
                                    ClassClassificationStudents."Program Group" := Format(ClassStudentUnits."Prog. Category");
                                    if ((ClassStudentUnits."Prog. Category" = ClassStudentUnits."Prog. Category"::"Certificate ") or
                                      (ClassStudentUnits."Prog. Category" = ClassStudentUnits."Prog. Category"::"Course List") or
                                      (ClassStudentUnits."Prog. Category" = ClassStudentUnits."Prog. Category"::Professional)) then
                                        ClassClassificationStudents."Program Group Order" := 3
                                    else
                                        if ((ClassStudentUnits."Prog. Category" = ClassStudentUnits."Prog. Category"::Diploma)) then
                                            ClassClassificationStudents."Program Group Order" := 2
                                        else
                                            ClassClassificationStudents."Program Group Order" := 1;
                                    //   ClassClassificationStudents."Programme Option":=FORMAT(ClassStudentUnits."Program Option (Flow)");
                                    ClassClassificationStudents.Insert;
                                end;
                                ClassClassificationUnits.Reset;
                                ClassClassificationUnits.SetRange("Student No.", ClassStudentUnits."Student No.");
                                ClassClassificationUnits.SetRange(Programme, ClassStudentUnits.Programme);
                                ClassClassificationUnits.SetRange("Unit Code", ClassStudentUnits.Unit);
                                ClassClassificationUnits.SetRange("Graduation Academic Year", GradAcademicYear);
                                if not ClassClassificationUnits.Find('-') then begin
                                    ClassClassificationUnits.Init;
                                    ClassClassificationUnits."Student No." := ClassStudentUnits."Student No.";
                                    ClassClassificationUnits.Programme := ClassStudentUnits.Programme;
                                    ClassClassificationUnits."Unit Code" := ClassStudentUnits.Unit;
                                    ClassClassificationUnits."Credit Hourse" := ClassUnitsSubjects."Credit Hours";
                                    ClassClassificationUnits."Unit Type" := Format(ClassUnitsSubjects."Unit Type");
                                    ClassClassificationUnits."Unit Description" := ClassUnitsSubjects.Desription;
                                    ClassClassificationUnits."Year of Study" := GetYearOfStudy(ClassUnitsSubjects."Stage Code");
                                    if ClassClassificationUnits."Year of Study" = 0 then
                                        ClassClassificationUnits."Year of Study" := GetYearOfStudy(ClassUnitsSubjects."Stage Code");
                                    ClassClassificationUnits."Graduation Academic Year" := GradAcademicYear;
                                    if ClassClassificationUnits.Insert then;
                                end;
                            end else begin
                                ClassStudentUnits."Unit not in Catalogue" := true;
                            end;
                            ClassStudentUnits.Modify;
                        end;
                        until ClassStudentUnits.Next = 0;
                        Progressbar.Close;
                    end;

                    // Populate the Academic Results agaist the Units Registered in the Graduation Units
                    ACANotGraduatingReasons.Reset;
                    ACANotGraduatingReasons.SetRange("Graduation Academic Year", GradAcademicYear);
                    Clear(TotalRecs);
                    Clear(CountedRecs);
                    Clear(RemeiningRecs);
                    Clear(ClassClassificationStudents);
                    ClassClassificationStudents.Reset;
                    ClassClassificationStudents.SetFilter("Graduation Academic Year", GradAcademicYear);
                    if StudNos <> '' then
                        ClassClassificationStudents.SetFilter("Student Number", StudNos) else
                        ClassClassificationStudents.SetFilter(Programme, ProgFIls);
                    if ClassClassificationStudents.Find('-') then begin
                        TotalRecs := ClassClassificationStudents.Count;
                        RemeiningRecs := TotalRecs;
                        ProgBar2.Open('#1#####################################################\' +
                        '#2############################################################\' +
                        '#3###########################################################\' +
                        '#4############################################################\' +
                        '#5###########################################################\' +
                        '#6############################################################');
                        ProgBar2.Update(1, '2 of 2 Updating Graduation Items');
                        ProgBar2.Update(2, 'Total Recs.: ' + Format(TotalRecs));
                        repeat
                        begin
                            // For each Record
                            ACADefinedUnitsperYoS.Reset;
                            ACADefinedUnitsperYoS.SetRange(Programmes, ClassClassificationStudents.Programme);
                            if ACADefinedUnitsperYoS.Find('-') then begin
                                repeat
                                begin
                                    ClassClassificationCourseReg.Reset;
                                    ClassClassificationCourseReg.SetRange("Student Number", ClassClassificationStudents."Student Number");
                                    ClassClassificationCourseReg.SetRange(Programme, ClassClassificationStudents.Programme);
                                    ClassClassificationCourseReg.SetRange("Year of Study", ACADefinedUnitsperYoS."Year of Study");
                                    ClassClassificationCourseReg.SetRange("Graduation Academic Year", GradAcademicYear);
                                    if not ClassClassificationCourseReg.Find('-') then begin
                                        ClassClassificationCourseReg.Init;
                                        ClassClassificationCourseReg."Student Number" := ClassClassificationStudents."Student Number";
                                        ClassClassificationCourseReg.Programme := ClassClassificationStudents.Programme;
                                        ClassClassificationCourseReg."Year of Study" := ACADefinedUnitsperYoS."Year of Study";
                                        ClassClassificationCourseReg."Graduation Academic Year" := GradAcademicYear;
                                        ClassClassificationCourseReg.Insert;
                                    end;
                                end;
                                until ACADefinedUnitsperYoS.Next = 0;
                            end;

                            ACANotGraduatingReasons.SetRange("Student No.", ClassClassificationStudents."Student Number");
                            if ACANotGraduatingReasons.Find('-') then ACANotGraduatingReasons.DeleteAll;
                            CountedRecs += 1;
                            RemeiningRecs -= 1;
                            ProgBar2.Update(3, '.....................................................');
                            ProgBar2.Update(4, 'Processed: ' + Format(CountedRecs));
                            ProgBar2.Update(5, 'Remaining: ' + Format(RemeiningRecs));
                            ProgBar2.Update(6, '----------------------------------------------------');
                            if Progyz.Get(ClassClassificationStudents.Programme) then begin
                                ClassClassificationStudents.Department := Progyz."Department Code";
                                ClassClassificationStudents."School Code" := Progyz."School Code";
                            end;
                            ClassClassificationStudents."Department Name" := GetDepartmentNameOrSchool(ClassClassificationStudents.Department);
                            ClassClassificationStudents."School Name" := GetDepartmentNameOrSchool(ClassClassificationStudents."School Code");
                            ClassClassificationStudents."Student Name" := GetStudentName(ClassClassificationStudents."Student Number");
                            ClassClassificationStudents.Cohort := GetCohort(ClassClassificationStudents."Student Number", ClassClassificationStudents.Programme);
                            ClassClassificationStudents."Final Stage" := GetFinalStage(ClassClassificationStudents.Programme);
                            ClassClassificationStudents."Final Academic Year" := GetFinalAcademicYear(ClassClassificationStudents."Student Number", ClassClassificationStudents.Programme);
                            ClassClassificationStudents."Final Year of Study" := GetFinalYearOfStudy(ClassClassificationStudents.Programme);
                            ClassClassificationStudents."Admission Date" := GetAdmissionDate(ClassClassificationStudents."Student Number", ClassClassificationStudents.Programme);
                            ClassClassificationStudents."Admission Academic Year" := GetAdmissionAcademicYear(ClassClassificationStudents."Student Number", ClassClassificationStudents.Programme);
                            ClassClassificationStudents.Graduating := false;
                            ClassClassificationStudents.Classification := '';
                            ClassClassificationCourseReg.Reset;
                            ClassClassificationCourseReg.SetRange("Student Number", ClassClassificationStudents."Student Number");
                            ClassClassificationCourseReg.SetRange(Programme, ClassClassificationStudents.Programme);
                            ClassClassificationCourseReg.SetRange("Graduation Academic Year", GradAcademicYear);
                            if ClassClassificationCourseReg.Find('-') then begin
                                repeat
                                begin
                                    ClassClassificationCourseReg."Department Name" := ClassClassificationStudents."Department Name";
                                    ClassClassificationCourseReg."School Name" := ClassClassificationStudents."School Name";
                                    ClassClassificationCourseReg."Student Name" := ClassClassificationStudents."Student Name";
                                    ClassClassificationCourseReg.Cohort := ClassClassificationStudents.Cohort;
                                    ClassClassificationCourseReg."Final Stage" := ClassClassificationStudents."Final Stage";
                                    ClassClassificationCourseReg."Final Academic Year" := ClassClassificationStudents."Final Academic Year";
                                    ClassClassificationCourseReg."Final Year of Study" := ClassClassificationStudents."Final Year of Study";
                                    ClassClassificationCourseReg."Admission Date" := ClassClassificationStudents."Admission Date";
                                    ClassClassificationCourseReg."Admission Academic Year" := ClassClassificationStudents."Admission Academic Year";
                                    ClassClassificationCourseReg.Graduating := false;
                                    ClassClassificationCourseReg.Classification := '';

                                    ClassClassificationUnits.Reset;
                                    ClassClassificationUnits.SetRange("Student No.", ClassClassificationStudents."Student Number");
                                    ClassClassificationUnits.SetRange(Programme, ClassClassificationStudents.Programme);
                                    ClassClassificationUnits.SetRange("Graduation Academic Year", GradAcademicYear);
                                    // ClassClassificationUnits.SETRANGE("Year of Study",ClassClassificationCourseReg."Year of Study");
                                    if ClassClassificationUnits.Find('-') then begin
                                        repeat
                                        begin
                                            // //              IF ((ClassClassificationUnits."Unit Code"='AAG 303') AND (ClassClassificationUnits."Student No."='AF/00004/016')) THEN
                                            // //              ClassStudentUnits.RESET;
                                            ClassStudentUnits.Reset;
                                            ClassStudentUnits.SetRange("Student No.", ClassClassificationUnits."Student No.");
                                            ClassStudentUnits.SetRange(Programme, ClassClassificationUnits.Programme);
                                            ClassStudentUnits.SetRange("Reg. Reversed", false);
                                            ClassStudentUnits.SetRange(Unit, ClassClassificationUnits."Unit Code");
                                            if ClassStudentUnits.Find('+') then begin
                                                ClassStudentUnits.CalcFields("EXAMs Marks", "CATs Marks", "CATs Marks Exists", "EXAMs Marks Exists");
                                                //Get CAT Marks
                                                // //                ClassExamResults.RESET;
                                                // //                ClassExamResults.SETRANGE("Student No.",ClassClassificationUnits."Student No.");
                                                // //                ClassExamResults.SETRANGE(Unit,ClassClassificationUnits."Unit Code");
                                                // //                ClassExamResults.SETFILTER(Exam,'%1|%2','ASSIGNMENT','CAT');
                                                // //                ClassExamResults.SETCURRENTKEY(Semester);
                                                // //                IF ClassExamResults.FIND('+') THEN BEGIN
                                                if ClassStudentUnits."CATs Marks Exists" then begin
                                                    ClassClassificationUnits."CAT Score" := Format(ClassStudentUnits."CATs Marks");
                                                    ClassClassificationUnits."CAT Score Decimal" := ClassStudentUnits."CATs Marks";
                                                end else begin
                                                    ClassClassificationUnits."CAT Score" := '';
                                                    ClassClassificationUnits."CAT Score Decimal" := 0;
                                                end;
                                                // //                  END;
                                                //Get Exam Marks
                                                // //                ClassExamResults.RESET;
                                                // //                ClassExamResults.SETRANGE("Student No.",ClassClassificationUnits."Student No.");
                                                // //                ClassExamResults.SETRANGE(Unit,ClassClassificationUnits."Unit Code");
                                                // //                ClassExamResults.SETFILTER(Exam,'%1|%2|%3|%4','EXAM','EXAM100','EXAMS','FINAL EXAM');
                                                // //                ClassExamResults.SETCURRENTKEY(Semester);
                                                // //                IF ClassExamResults.FIND('+') THEN BEGIN
                                                if ClassStudentUnits."EXAMs Marks Exists" then begin
                                                    ClassClassificationUnits."Exam Score" := Format(ClassStudentUnits."EXAMs Marks");
                                                    ClassClassificationUnits."Exam Score Decimal" := ClassStudentUnits."EXAMs Marks";
                                                end;
                                                // //                  END;
                                            end;

                                            if ClassClassificationUnits."Exam Score" = '' then begin
                                                ClassExamResults.Reset;
                                                ClassExamResults.SetRange("Student No.", ClassClassificationUnits."Student No.");
                                                ClassExamResults.SetRange(Unit, ClassClassificationUnits."Unit Code");
                                                ClassExamResults.SetFilter(ExamType, '%1|%2|%3|%4|%5|%6', 'EXAM', 'EXAM100', 'EXAMS', 'FINAL EXAM', 'FINAL', 'EXAMS');
                                                ClassExamResults.SetCurrentKey(Semester);
                                                if ClassExamResults.Find('+') then begin
                                                    ClassClassificationUnits."Exam Score" := Format(ClassExamResults.Score);
                                                    ClassClassificationUnits."Exam Score Decimal" := ClassExamResults.Score;
                                                end;
                                            end;

                                            if ClassClassificationUnits."CAT Score" = '' then begin
                                                ClassExamResults.Reset;
                                                ClassExamResults.SetRange("Student No.", ClassClassificationUnits."Student No.");
                                                ClassExamResults.SetRange(Unit, ClassClassificationUnits."Unit Code");
                                                ClassExamResults.SetFilter(ExamType, '%1|%2|%3', 'ASSIGNMENT', 'CAT', 'CATS');
                                                ClassExamResults.SetCurrentKey(Semester);
                                                if ClassExamResults.Find('+') then begin
                                                    ClassClassificationUnits."CAT Score" := Format(ClassExamResults.Score);
                                                    ClassClassificationUnits."CAT Score Decimal" := ClassExamResults.Score;
                                                end;
                                            end;

                                            //Update Tatal Marks
                                            if ((ClassClassificationUnits."Exam Score" = '') and (ClassClassificationUnits."CAT Score" = '')) then begin
                                                ClassClassificationUnits.Pass := false;
                                                ClassClassificationUnits.Grade := '?';
                                            end else
                                                if ((ClassClassificationUnits."Exam Score" <> '') and (ClassClassificationUnits."CAT Score" <> '')) then begin
                                                    // //                 IF ClassClassificationUnits."Student No."='' THEN
                                                    // //                   ClassClassificationUnits.Grade:='ED/03319/015';
                                                    ClassClassificationUnits."Total Score" := Format(ClassClassificationUnits."Exam Score Decimal" + ClassClassificationUnits."CAT Score Decimal");
                                                    ClassClassificationUnits."Total Score Decimal" := ClassClassificationUnits."Exam Score Decimal" + ClassClassificationUnits."CAT Score Decimal";
                                                    ClassClassificationUnits."Weighted Total Score" := ClassClassificationUnits."Credit Hourse" * ClassClassificationUnits."Total Score Decimal";
                                                    ClassClassificationUnits.Grade := GetGrade(ClassClassificationUnits."Total Score Decimal", ClassClassificationUnits."Unit Code", ClassClassificationUnits.Programme);
                                                    ClassClassificationUnits.Pass := GetUnitPassStatus(ClassClassificationUnits."Total Score Decimal", ClassClassificationUnits."Unit Code", ClassClassificationUnits.Programme);
                                                    // IF ClassClassificationUnits.Pass THEN BEGIN
                                                    //  END;
                                                end else begin
                                                    ClassClassificationUnits.Pass := false;
                                                    ClassClassificationUnits.Grade := '!';
                                                    ClassClassificationUnits."Total Score" := Format(ClassClassificationUnits."Exam Score Decimal" + ClassClassificationUnits."CAT Score Decimal");
                                                    ClassClassificationUnits."Total Score Decimal" := ClassClassificationUnits."Exam Score Decimal" + ClassClassificationUnits."CAT Score Decimal";
                                                    ClassClassificationUnits."Weighted Total Score" := ClassClassificationUnits."Credit Hourse" * ClassClassificationUnits."Total Score Decimal";
                                                end;
                                            ClassClassificationUnits.Cohort := ClassClassificationStudents.Cohort;
                                            if ((ClassClassificationUnits."Unit Type" = 'CORE') or (ClassClassificationUnits."Unit Type" = 'REQUIRED')) then
                                                ClassClassificationUnits."Allow In Graduate" := true;

                                            if ClassClassificationUnits.Modify then;
                                        end;
                                        until ClassClassificationUnits.Next = 0;
                                    end;
                                    // Update Course Registration for Graduation
                                    Clear(ExpectedElectives);
                                    ClassClassificationCourseReg.CalcFields("Total Cores Done", "Total Required Done");
                                    ExpectedElectives := RequiredStageUnits(ClassClassificationCourseReg.Programme,
                                    ClassClassificationCourseReg."Year of Study", ClassClassificationCourseReg."Student Number");
                                    ExpectedElectives := ExpectedElectives - ClassClassificationCourseReg."Total Cores Done" - ClassClassificationCourseReg."Total Required Done";
                                    // Update Classifiable Electives
                                    if ExpectedElectives > 0 then begin
                                        ClassClassificationUnits.Reset;
                                        ClassClassificationUnits.SetRange("Student No.", ClassClassificationStudents."Student Number");
                                        ClassClassificationUnits.SetRange(Programme, ClassClassificationStudents.Programme);
                                        ClassClassificationUnits.SetRange("Graduation Academic Year", GradAcademicYear);
                                        ClassClassificationUnits.SetRange("Year of Study", ClassClassificationCourseReg."Year of Study");
                                        ClassClassificationUnits.SetRange("Unit Type", 'ELECTIVE');
                                        ClassClassificationUnits.SetCurrentKey("Total Score");
                                        if ClassClassificationUnits.Find('-') then begin
                                            Clear(CountedElectives);
                                            CountedElectives := ClassClassificationUnits.Count;
                                            repeat
                                            begin
                                                ClassClassificationUnits."Course Cat. Presidence" := CountedElectives;
                                                CountedElectives := CountedElectives - 1;
                                                ClassClassificationUnits.Modify;
                                            end;
                                            until ClassClassificationUnits.Next = 0;
                                        end;
                                        // Get Top Electives and tag for Graduation
                                        ClassClassificationUnits.Reset;
                                        ClassClassificationUnits.SetRange("Student No.", ClassClassificationStudents."Student Number");
                                        ClassClassificationUnits.SetRange(Programme, ClassClassificationStudents.Programme);
                                        ClassClassificationUnits.SetRange("Graduation Academic Year", GradAcademicYear);
                                        ClassClassificationUnits.SetRange("Year of Study", ClassClassificationCourseReg."Year of Study");
                                        ClassClassificationUnits.SetRange("Unit Type", 'ELECTIVE');
                                        ClassClassificationUnits.SetCurrentKey("Course Cat. Presidence");
                                        if ClassClassificationUnits.Find('-') then begin
                                            Clear(CountedElectives);
                                            repeat
                                            begin
                                                CountedElectives := CountedElectives + 1;
                                                ClassClassificationUnits."Allow In Graduate" := true;
                                                ClassClassificationUnits.Modify;
                                            end;
                                            until ((ClassClassificationUnits.Next = 0) or (CountedElectives = ExpectedElectives));
                                        end;
                                    end;

                                    ClassClassificationCourseReg.CalcFields("Total Marks", "Total Courses", "Total Weighted Marks",
                                    "Total Units", "Classified Total Marks", "Total Classified C. Count", "Classified W. Total", "Attained Stage Units");
                                    ClassClassificationCourseReg.CalcFields("CATS Missing", "Exam Missing");
                                    if ClassClassificationCourseReg."Total Courses" <> 0 then
                                        ClassClassificationCourseReg."Normal Average" := ClassClassificationCourseReg."Total Marks" / ClassClassificationCourseReg."Total Courses";
                                    if ClassClassificationCourseReg."Total Units" <> 0 then
                                        ClassClassificationCourseReg."Weighted Average" := ClassClassificationCourseReg."Total Weighted Marks" / ClassClassificationCourseReg."Total Units";
                                    if ClassClassificationCourseReg."Total Classified C. Count" <> 0 then
                                        ClassClassificationCourseReg."Classified Average" := ClassClassificationCourseReg."Classified Total Marks" / ClassClassificationCourseReg."Total Classified C. Count";
                                    if ClassClassificationCourseReg."Total Classified Units" <> 0 then
                                        ClassClassificationCourseReg."Classified W. Average" := ClassClassificationCourseReg."Classified W. Total" / ClassClassificationCourseReg."Total Classified Units";
                                    ClassClassificationCourseReg."Required Stage Units" := RequiredStageUnits(ClassClassificationCourseReg.Programme,
                                    ClassClassificationCourseReg."Year of Study", ClassClassificationCourseReg."Student Number");
                                    if ClassClassificationCourseReg."Required Stage Units" > ClassClassificationCourseReg."Attained Stage Units" then
                                        ClassClassificationCourseReg."Units Deficit" := ClassClassificationCourseReg."Required Stage Units" - ClassClassificationCourseReg."Attained Stage Units";
                                    ClassClassificationCourseReg."Multiple Programe Reg. Exists" := GetMultipleProgramExists(ClassClassificationCourseReg."Student Number");

                                    ClassClassificationCourseReg.CalcFields("CATS Missing", "Exam Missing");
                                    Clear(ExistsOption);
                                    if ((ClassClassificationCourseReg."Exam Missing") and (ClassClassificationCourseReg."CATS Missing")) then
                                        ExistsOption := ExistsOption::"None Exists"
                                    else
                                        if ((ClassClassificationCourseReg."Exam Missing" = true) and (ClassClassificationCourseReg."CATS Missing" = false)) then
                                            ExistsOption := ExistsOption::"Exam Only"
                                        else
                                            if ((ClassClassificationCourseReg."Exam Missing" = false) and (ClassClassificationCourseReg."CATS Missing" = true)) then
                                                ExistsOption := ExistsOption::"CAT Only"
                                            else
                                                if ((ClassClassificationCourseReg."Exam Missing" = false) and (ClassClassificationCourseReg."CATS Missing" = false)) then ExistsOption := ExistsOption::"Both Exists";
                                    ClassClassificationCourseReg."Final Classification" := GetClassification(ClassClassificationCourseReg.Programme, ClassClassificationCourseReg."Classified Average", false, ExistsOption);
                                    ClassClassificationCourseReg."Final Classification Pass" := GetClassPassStatus(ClassClassificationCourseReg."Classified Average", ClassClassificationCourseReg.Programme, ExistsOption);
                                    ClassClassificationCourseReg."Graduation Grade" := GetClassificationGrade(ClassClassificationCourseReg."Normal Average", ClassClassificationCourseReg.Programme, ExistsOption);
                                    ClassClassificationCourseReg."Final Classification Grade" := GetClassificationGrade(ClassClassificationCourseReg."Classified Average", ClassClassificationCourseReg.Programme, ExistsOption);
                                    ClassClassificationCourseReg."Final Classification Order" := GetClassificationOrder(ClassClassificationCourseReg.Programme, ClassClassificationCourseReg."Classified Average", false, ExistsOption);
                                    ClassClassificationCourseReg.Graduating := GetClassPassStatus(ClassClassificationCourseReg."Classified Average", ClassClassificationCourseReg.Programme, ExistsOption);
                                    ClassClassificationCourseReg.Classification := GetClassification(ClassClassificationCourseReg.Programme, ClassClassificationCourseReg."Classified Average", false, ExistsOption);
                                    ClassClassificationCourseReg.Modify;

                                    if ClassClassificationCourseReg."Total Courses" <> 0 then
                                        ClassClassificationCourseReg."Normal Average" := ClassClassificationCourseReg."Total Marks" / ClassClassificationCourseReg."Total Courses";
                                end;
                                until ClassClassificationCourseReg.Next = 0;
                            end;
                            // Update Student Grad. Master
                            Clear(Total_First_Year_Courses);
                            Clear(Total_First_Year_Marks);
                            Clear(New_Total_Courses);
                            Clear(New_Total_Marks);
                            Clear(New_Classifiable_Average);
                            ClassClassificationStudents.CalcFields(ClassClassificationStudents."Prog. Exam Category");
                            ClassClassificationStudents.CalcFields("Total Marks", "Total Courses", "Total Weighted Marks",
                            "Total Units", "Classified Total Marks", "Total Classified C. Count", "Classified W. Total", "Attained Stage Units");
                            if ((ClassClassificationStudents."Program Group" = 'DEGREE') or (ClassClassificationStudents."Program Group" = 'UNDERGRADUATE')) then begin
                                ClassClassificationCourseReg.Reset;
                                ClassClassificationCourseReg.SetRange("Student Number", ClassClassificationStudents."Student Number");
                                ClassClassificationCourseReg.SetRange(Programme, ClassClassificationStudents.Programme);
                                ClassClassificationCourseReg.SetRange("Graduation Academic Year", GradAcademicYear);
                                ClassClassificationCourseReg.SetRange("Year of Study", 1);
                                if ClassClassificationCourseReg.Find('-') then begin
                                    ClassClassificationCourseReg.CalcFields("Total Marks", "Total Courses", "Total Weighted Marks",
                          "Total Units", "Classified Total Marks", "Total Classified C. Count", "Classified W. Total", "Attained Stage Units");
                                    Total_First_Year_Courses := ClassClassificationCourseReg."Total Courses";
                                    Total_First_Year_Marks := ClassClassificationCourseReg."Total Marks";
                                    New_Total_Courses := ClassClassificationStudents."Total Courses" - Total_First_Year_Courses;
                                    New_Total_Marks := ClassClassificationStudents."Total Marks" - Total_First_Year_Marks;
                                end;
                            end else begin
                                New_Total_Courses := ClassClassificationStudents."Total Courses";
                                New_Total_Marks := ClassClassificationStudents."Total Marks";
                            end;

                            if New_Total_Courses > 0 then
                                New_Classifiable_Average := New_Total_Marks / New_Total_Courses;
                            New_Classifiable_Average := Round(New_Classifiable_Average, 0.01, '=');

                            if ClassClassificationStudents."Total Courses" <> 0 then
                                ClassClassificationStudents."Normal Average" := ClassClassificationStudents."Total Marks" / ClassClassificationStudents."Total Courses";
                            if ClassClassificationStudents."Total Units" <> 0 then
                                ClassClassificationStudents."Weighted Average" := ClassClassificationStudents."Total Weighted Marks" / ClassClassificationStudents."Total Units";
                            //          IF ClassClassificationStudents."Total Classified C. Count"<>0 THEN
                            ClassClassificationStudents."Classified Average" := New_Classifiable_Average;
                            if ClassClassificationStudents."Total Classified Units" <> 0 then
                                ClassClassificationStudents."Classified W. Average" := ClassClassificationStudents."Classified W. Total" / ClassClassificationStudents."Total Classified Units";
                            ClassClassificationStudents."Required Stage Units" := RequiredStageUnits(ClassClassificationStudents.Programme,
                            ClassClassificationStudents."Year of Study", ClassClassificationStudents."Student Number");
                            if ClassClassificationStudents."Required Stage Units" > ClassClassificationStudents."Attained Stage Units" then
                                ClassClassificationStudents."Units Deficit" := ClassClassificationStudents."Required Stage Units" - ClassClassificationStudents."Attained Stage Units";

                            ClassClassificationStudents.CalcFields("CATS Missing", "Exam Missing");
                            Clear(ExistsOption);
                            if ((ClassClassificationStudents."Exam Missing") and (ClassClassificationStudents."CATS Missing")) then
                                ExistsOption := ExistsOption::"None Exists"
                            else
                                if ((ClassClassificationStudents."Exam Missing" = true) and (ClassClassificationStudents."CATS Missing" = false)) then
                                    ExistsOption := ExistsOption::"Exam Only"
                                else
                                    if ((ClassClassificationStudents."Exam Missing" = false) and (ClassClassificationStudents."CATS Missing" = true)) then
                                        ExistsOption := ExistsOption::"CAT Only"
                                    else
                                        if ((ClassClassificationStudents."Exam Missing" = false) and (ClassClassificationStudents."CATS Missing" = false)) then ExistsOption := ExistsOption::"Both Exists";

                            ClassClassificationStudents."Final Classification" := GetClassification(ClassClassificationStudents.Programme, New_Classifiable_Average, false, ExistsOption);
                            ClassClassificationStudents."Final Classification Pass" := GetClassPassStatus(New_Classifiable_Average, ClassClassificationStudents.Programme, ExistsOption);
                            ClassClassificationStudents."Graduation Grade" := GetClassificationGrade(New_Classifiable_Average, ClassClassificationStudents.Programme, ExistsOption);
                            ClassClassificationStudents."Final Classification Grade" := GetClassificationGrade(New_Classifiable_Average, ClassClassificationStudents.Programme, ExistsOption);
                            ClassClassificationStudents."Final Classification Order" := GetClassificationOrder(ClassClassificationStudents.Programme, New_Classifiable_Average, false, ExistsOption);
                            ClassClassificationStudents.Graduating := GetClassPassStatus(New_Classifiable_Average, ClassClassificationStudents.Programme, ExistsOption);
                            ClassClassificationStudents.Classification := GetClassification(ClassClassificationStudents.Programme, New_Classifiable_Average, false, ExistsOption);
                            ClassClassificationStudents.Modify;
                            ToGraduate := true;
                            //Less Courses in a Stage/Level
                            if ClassClassificationStudents."Units Deficit" > 0 then begin
                                ToGraduate := false;
                                ACANotGraduatingReasons.Init;
                                ACANotGraduatingReasons."Graduation Academic Year" := GradAcademicYear;
                                ACANotGraduatingReasons."Student No." := ClassClassificationStudents."Student Number";
                                ACANotGraduatingReasons."Reason Code" := 'LESS COURSES';
                                ACANotGraduatingReasons."Reason Details" := 'Deficit on units:\ Ensure the students is registered.';
                                if ACANotGraduatingReasons.Insert then;
                            end;
                            //Failed A Unit

                            ClassClassificationUnits.Reset;
                            ClassClassificationUnits.SetRange("Student No.", ClassClassificationStudents."Student Number");
                            ClassClassificationUnits.SetRange(Programme, ClassClassificationStudents.Programme);
                            ClassClassificationUnits.SetRange("Graduation Academic Year", GradAcademicYear);
                            ClassClassificationUnits.SetRange(Pass, false);
                            if ClassClassificationUnits.Find('-') then begin
                                ToGraduate := false;
                                ACANotGraduatingReasons.Init;
                                ACANotGraduatingReasons."Graduation Academic Year" := GradAcademicYear;
                                ACANotGraduatingReasons."Student No." := ClassClassificationStudents."Student Number";
                                ACANotGraduatingReasons."Reason Code" := 'FAILED COURSES';
                                ACANotGraduatingReasons."Reason Details" := 'Failed Some Courses:\ e.g. ' + ClassClassificationUnits."Unit Code";
                                if ACANotGraduatingReasons.Insert then;
                            end;
                            //Unit Registered not on the Catalog
                            ClassClassificationUnits.Reset;
                            ClassClassificationUnits.SetRange("Student No.", ClassClassificationStudents."Student Number");
                            ClassClassificationUnits.SetRange(Programme, ClassClassificationStudents.Programme);
                            ClassClassificationUnits.SetRange("Graduation Academic Year", GradAcademicYear);
                            ClassClassificationUnits.SetRange("Unit Exists", false);
                            if ClassClassificationUnits.Find('-') then begin
                                ToGraduate := false;
                                ACANotGraduatingReasons.Init;
                                ACANotGraduatingReasons."Graduation Academic Year" := GradAcademicYear;
                                ACANotGraduatingReasons."Student No." := ClassClassificationStudents."Student Number";
                                ACANotGraduatingReasons."Reason Code" := 'UNIT NOT IN CATALOG';
                                ACANotGraduatingReasons."Reason Details" := 'Some Registered Units are Missing in the Course Catalog:\ e.g. ' + ClassClassificationUnits."Unit Code";
                                if ACANotGraduatingReasons.Insert then;
                            end;
                            //Multiple Programs Registered
                            ACAClassificationStudentsCheck.Reset;
                            ACAClassificationStudentsCheck.SetRange("Student Number", ClassClassificationStudents."Student Number");
                            if ACAClassificationStudentsCheck.Find('-') then begin
                                if ACAClassificationStudentsCheck.Count > 1 then begin
                                    ToGraduate := false;
                                    ACANotGraduatingReasons.Init;
                                    ACANotGraduatingReasons."Graduation Academic Year" := GradAcademicYear;
                                    ACANotGraduatingReasons."Student No." := ClassClassificationStudents."Student Number";
                                    ACANotGraduatingReasons."Reason Code" := 'MULTIPLE COURSE REG';
                                    ACANotGraduatingReasons."Reason Details" := 'Multiple Course Registration identified with Multiple Programs';
                                    if ACANotGraduatingReasons.Insert then;
                                end;
                            end;
                            // Missing Both CAT and Exam
                            ClassClassificationUnits.Reset;
                            ClassClassificationUnits.SetRange("Student No.", ClassClassificationStudents."Student Number");
                            ClassClassificationUnits.SetRange(Programme, ClassClassificationStudents.Programme);
                            ClassClassificationUnits.SetRange("Graduation Academic Year", GradAcademicYear);
                            ClassClassificationUnits.SetRange(Grade, '?');
                            if ClassClassificationUnits.Find('-') then begin
                                ToGraduate := false;
                                ACANotGraduatingReasons.Init;
                                ACANotGraduatingReasons."Graduation Academic Year" := GradAcademicYear;
                                ACANotGraduatingReasons."Student No." := ClassClassificationStudents."Student Number";
                                ACANotGraduatingReasons."Reason Code" := 'MISSING CAT & EXAM';
                                ACANotGraduatingReasons."Reason Details" := 'CAT & Exam Missing on some units e.g.  ' + ClassClassificationUnits."Unit Code";
                                if ACANotGraduatingReasons.Insert then;
                            end;
                            //Exists With Missing Mark
                            ClassClassificationUnits.Reset;
                            ClassClassificationUnits.SetRange("Student No.", ClassClassificationStudents."Student Number");
                            ClassClassificationUnits.SetRange(Programme, ClassClassificationStudents.Programme);
                            ClassClassificationUnits.SetRange("Graduation Academic Year", GradAcademicYear);
                            ClassClassificationUnits.SetRange(Grade, '!');
                            if ClassClassificationUnits.Find('-') then begin
                                ToGraduate := false;
                                ACANotGraduatingReasons.Init;
                                ACANotGraduatingReasons."Graduation Academic Year" := GradAcademicYear;
                                ACANotGraduatingReasons."Student No." := ClassClassificationStudents."Student Number";
                                ACANotGraduatingReasons."Reason Code" := 'MISSING MARK';
                                ACANotGraduatingReasons."Reason Details" := 'Some CAT and/or Exam Marks Missing\ e.g. ' + ClassClassificationUnits."Unit Code";
                                if ACANotGraduatingReasons.Insert then;
                            end;
                            ClassClassificationStudents.CalcFields("Required Stage Units", "Attained Stage Units", "Failed Courses");
                            // //        IF (ClassClassificationStudents."Required Stage Units">ClassClassificationStudents."Attained Stage Units") THEN
                            // //          ToGraduate:=FALSE;
                            if ClassClassificationStudents."Failed Courses" > 0 then
                                ToGraduate := false;
                            if ClassClassificationStudents."Final Classification" = '' then begin
                                ToGraduate := false;
                                ACANotGraduatingReasons.Init;
                                ACANotGraduatingReasons."Graduation Academic Year" := GradAcademicYear;
                                ACANotGraduatingReasons."Student No." := ClassClassificationStudents."Student Number";
                                ACANotGraduatingReasons."Reason Code" := 'UNKNORN CLASS';
                                ACANotGraduatingReasons."Reason Details" := 'Empty Classifications ';
                                ;
                                if ACANotGraduatingReasons.Insert then;
                            end;
                            //Failed to attained course required in a Year of study

                            ClassClassificationCourseReg.Reset;
                            ClassClassificationCourseReg.SetRange("Student Number", ClassClassificationStudents."Student Number");
                            ClassClassificationCourseReg.SetRange("Graduation Academic Year", GradAcademicYear);
                            if ClassClassificationCourseReg.Find('-') then begin
                                repeat
                                begin
                                    ClassClassificationCourseReg.CalcFields("Attained Stage Units");
                                    if ClassClassificationCourseReg."Attained Stage Units" < ClassClassificationCourseReg."Required Stage Units" then begin
                                        if (ClassClassificationStudents."Required Stage Units" > ClassClassificationStudents."Attained Stage Units") then begin
                                            if (ClassClassificationStudents."Required Stage Units" > ClassClassificationStudents."Attained Stage Units") then begin
                                                ToGraduate := false;
                                                ACANotGraduatingReasons.Init;
                                                ACANotGraduatingReasons."Graduation Academic Year" := GradAcademicYear;
                                                ACANotGraduatingReasons."Student No." := ClassClassificationStudents."Student Number";
                                                ACANotGraduatingReasons."Reason Code" := 'LESS UNITS ATTAINED';
                                                ACANotGraduatingReasons."Reason Details" := 'Did not attain all the required units in Year' + Format(ClassClassificationCourseReg."Year of Study") + '. Required: ' +
                                                Format(ClassClassificationCourseReg."Required Stage Units") + '. Attained: ' + Format(ClassClassificationCourseReg."Attained Stage Units");
                                                if ACANotGraduatingReasons.Insert then;
                                            end;
                                        end;
                                    end;
                                end;
                                until ClassClassificationCourseReg.Next = 0;
                            end;


                            if ToGraduate = false then begin
                                ClassClassificationStudents.Graduating := ToGraduate;
                                ClassClassificationStudents.Classification := 'INCOMPLETE';
                                ClassClassificationStudents."Final Classification" := 'INCOMPLETE';
                                ClassClassificationStudents."Final Classification Pass" := false;
                            end;


                            ClassClassificationCourseReg.Reset;
                            ClassClassificationCourseReg.SetRange("Student Number", ClassClassificationStudents."Student Number");
                            ClassClassificationCourseReg.SetRange(Programme, ClassClassificationStudents.Programme);
                            ClassClassificationCourseReg.SetRange("Graduation Academic Year", GradAcademicYear);
                            if ClassClassificationCourseReg.Find('-') then begin
                                repeat
                                begin
                                    ClassClassificationCourseReg.Graduating := ClassClassificationStudents.Graduating;
                                    ClassClassificationCourseReg.Classification := ClassClassificationStudents.Classification;
                                    ClassClassificationCourseReg."Final Classification" := ClassClassificationStudents."Final Classification";
                                    ClassClassificationCourseReg."Final Classification Pass" := ClassClassificationStudents."Final Classification Pass";
                                    ClassClassificationCourseReg.Modify;
                                end;
                                until ClassClassificationCourseReg.Next = 0;
                            end;
                            ClassClassificationStudents.Modify
                        end;
                        until ClassClassificationStudents.Next = 0;
                        ProgBar2.Close;
                    end;

                    if Progs2 <> '' then begin
                        Clear(ProgFIls);
                        ProgFIls := Progs2;

                        // Check if for all the Programs within the filter, the final stage has been defined
                        ACAProgramme963.Reset;
                        ACAProgramme963.SetFilter(ACAProgramme963.Code, ProgFIls);
                        if ACAProgramme963.Find('-') then begin
                            repeat
                            begin
                                ACAProgrammeStages.Reset;
                                ACAProgrammeStages.SetRange("Programme Code", ACAProgramme963.Code);
                                ACAProgrammeStages.SetRange("Final Stage", true);
                                if not ACAProgrammeStages.Find('-') then begin
                                    ACACourseRegistration.Reset;
                                    ACACourseRegistration.SetRange(Programmes, ACAProgramme963.Code);
                                    ACACourseRegistration.SetFilter(Status, '%1|%2|%3', ACACourseRegistration.Status::Current, ACACourseRegistration.Status::Registration, ACACourseRegistration.Status::Deceased);
                                    if ACACourseRegistration.Find('-') then Error('Programme ''' + ACAProgramme963.Code + ''' has no defined Final Stage');
                                end;
                            end;
                            until ACAProgramme963.Next = 0;
                        end;
                        if Progs2 <> '' then begin
                            ACAProgramme963.Reset;
                            ACAProgramme963.SetFilter(ACAProgramme963.Code, Progs2);
                            if ACAProgramme963.Find('-') then begin
                                repeat
                                begin
                                    ACAProgrammeStages.Reset;
                                    ACAProgrammeStages.SetRange("Programme Code", ACAProgramme963.Code);
                                    ACAProgrammeStages.SetRange("Final Stage", true);
                                    if not ACAProgrammeStages.Find('-') then begin
                                        ACACourseRegistration.Reset;
                                        ACACourseRegistration.SetRange(Programmes, ACAProgramme963.Code);
                                        ACACourseRegistration.SetFilter(Status, '%1|%2|%3', ACACourseRegistration.Status::Current, ACACourseRegistration.Status::Registration, ACACourseRegistration.Status::Deceased);
                                        if ACACourseRegistration.Find('-') then Error('Programme ''' + ACAProgramme963.Code + ''' has no defined Final Stage');
                                    end;
                                end;
                                until ACAProgramme963.Next = 0;
                            end;
                        end;

                        Clear(TotalRecs);
                        Clear(RemeiningRecs);
                        Clear(CountedRecs);
                        // Clear CLassification For Selected Filters
                        ClassClassificationStudents.Reset;
                        ClassClassificationCourseReg.Reset;
                        ClassClassificationUnits.Reset;
                        ClassClassificationStudents.SetRange("Graduation Academic Year", GradAcademicYear);
                        ClassClassificationCourseReg.SetRange("Graduation Academic Year", GradAcademicYear);
                        ClassClassificationUnits.SetRange("Graduation Academic Year", GradAcademicYear);
                        ClassClassificationStudents.SetFilter(Programme, ProgFIls);
                        ClassClassificationCourseReg.SetFilter(Programme, ProgFIls);
                        ClassClassificationUnits.SetFilter(Programme, ProgFIls);
                        if ClassClassificationStudents.Find('-') then ClassClassificationStudents.DeleteAll;
                        if ClassClassificationCourseReg.Find('-') then ClassClassificationCourseReg.DeleteAll;
                        if ClassClassificationUnits.Find('-') then ClassClassificationUnits.DeleteAll;

                        // Populate Classification Tables Here
                        if StudNos <> '' then
                            ClassStudentUnits.SetFilter("Student No.", StudNos) else
                            ClassStudentUnits.SetFilter(Programme, ProgFIls);
                        ClassStudentUnits.SetFilter("Exists Final Stage", '%1', true);
                        if ClassStudentUnits.Find('-') then begin
                            TotalRecs := ClassStudentUnits.Count;
                            RemeiningRecs := TotalRecs;
                            // Loop through all the Units Reg. for the Students that are Finalists Populating the Classification tables
                            Progressbar.Open('#1#####################################################\' +
                            '#2############################################################\' +
                            '#3###########################################################\' +
                            '#4############################################################\' +
                            '#5###########################################################\' +
                            '#6############################################################');
                            Progressbar.Update(1, 'Processing Graduation values....');
                            Progressbar.Update(2, 'Total Recs.: ' + Format(TotalRecs));
                            repeat
                            begin
                                ClassStudentUnits.CalcFields("Program Option (Flow)", "Prog. Category");
                                CountedRecs := CountedRecs + 1;
                                RemeiningRecs := RemeiningRecs - 1;
                                // Create Registration Unit entry if Not Exists
                                Progressbar.Update(3, '.....................................................');
                                Progressbar.Update(4, 'Processed: ' + Format(CountedRecs));
                                Progressbar.Update(5, 'Remaining: ' + Format(RemeiningRecs));
                                Progressbar.Update(6, '----------------------------------------------------');
                                //Get best CAT Marks
                                ClassStudentUnits."Unit not in Catalogue" := false;
                                ClassUnitsSubjects.Reset;
                                ClassUnitsSubjects.SetRange("Programme Code", ClassStudentUnits.Programme);
                                ClassUnitsSubjects.SetRange(Code, ClassStudentUnits.Unit);
                                if ClassUnitsSubjects.Find('-') then begin
                                    ClassClassificationStudents.Reset;
                                    ClassClassificationStudents.SetRange("Student Number", ClassStudentUnits."Student No.");
                                    ClassClassificationStudents.SetRange(Programme, ClassStudentUnits.Programme);
                                    ClassClassificationStudents.SetRange("Graduation Academic Year", GradAcademicYear);
                                    if not ClassClassificationStudents.Find('-') then begin
                                        ClassClassificationStudents.Init;
                                        ClassClassificationStudents."Student Number" := ClassStudentUnits."Student No.";
                                        ClassClassificationStudents.Programme := ClassStudentUnits.Programme;
                                        ClassClassificationStudents."Graduation Academic Year" := GradAcademicYear;
                                        ClassClassificationStudents."Year of Study" := GetYearOfStudy(ClassUnitsSubjects."Stage Code");
                                        ClassClassificationStudents."Program Group" := Format(ClassStudentUnits."Prog. Category");
                                        if ((ClassStudentUnits."Prog. Category" = ClassStudentUnits."Prog. Category"::"Certificate ") or
                                          (ClassStudentUnits."Prog. Category" = ClassStudentUnits."Prog. Category"::"Course List") or
                                          (ClassStudentUnits."Prog. Category" = ClassStudentUnits."Prog. Category"::Professional)) then
                                            ClassClassificationStudents."Program Group Order" := 3
                                        else
                                            if ((ClassStudentUnits."Prog. Category" = ClassStudentUnits."Prog. Category"::Diploma)) then
                                                ClassClassificationStudents."Program Group Order" := 2
                                            else
                                                ClassClassificationStudents."Program Group Order" := 1;
                                        ClassClassificationStudents."Programme Option" := Format(ClassStudentUnits."Program Option (Flow)");
                                        ClassClassificationStudents.Insert;
                                    end;
                                    ClassClassificationUnits.Reset;
                                    ClassClassificationUnits.SetRange("Student No.", ClassStudentUnits."Student No.");
                                    ClassClassificationUnits.SetRange(Programme, ClassStudentUnits.Programme);
                                    ClassClassificationUnits.SetRange("Unit Code", ClassStudentUnits.Unit);
                                    ClassClassificationUnits.SetRange("Graduation Academic Year", GradAcademicYear);
                                    if not ClassClassificationUnits.Find('-') then begin
                                        ClassClassificationUnits.Init;
                                        ClassClassificationUnits."Student No." := ClassStudentUnits."Student No.";
                                        ClassClassificationUnits.Programme := ClassStudentUnits.Programme;
                                        ClassClassificationUnits."Unit Code" := ClassStudentUnits.Unit;
                                        ClassClassificationUnits."Credit Hourse" := ClassUnitsSubjects."Credit Hours";
                                        ClassClassificationUnits."Unit Type" := Format(ClassUnitsSubjects."Unit Type");
                                        ClassClassificationUnits."Unit Description" := ClassUnitsSubjects.Desription;
                                        ClassClassificationUnits."Year of Study" := GetYearOfStudy(ClassUnitsSubjects."Stage Code");
                                        if ClassClassificationUnits."Year of Study" = 0 then
                                            ClassClassificationUnits."Year of Study" := GetYearOfStudy(ClassUnitsSubjects."Stage Code");
                                        ClassClassificationUnits."Graduation Academic Year" := GradAcademicYear;
                                        if ClassClassificationUnits.Insert then;
                                    end;
                                end else begin
                                    ClassStudentUnits."Unit not in Catalogue" := true;
                                end;
                                ClassStudentUnits.Modify;
                            end;
                            until ClassStudentUnits.Next = 0;
                            Progressbar.Close;
                        end;

                        // Populate the Academic Results agaist the Units Registered in the Graduation Units
                        ACANotGraduatingReasons.Reset;
                        ACANotGraduatingReasons.SetRange("Graduation Academic Year", GradAcademicYear);
                        Clear(TotalRecs);
                        Clear(CountedRecs);
                        Clear(RemeiningRecs);
                        Clear(ClassClassificationStudents);
                        ClassClassificationStudents.Reset;
                        ClassClassificationStudents.SetFilter("Graduation Academic Year", GradAcademicYear);
                        if StudNos <> '' then
                            ClassClassificationStudents.SetFilter("Student Number", StudNos) else
                            ClassClassificationStudents.SetFilter(Programme, ProgFIls);
                        if ClassClassificationStudents.Find('-') then begin
                            TotalRecs := ClassClassificationStudents.Count;
                            RemeiningRecs := TotalRecs;
                            ProgBar2.Open('#1#####################################################\' +
                            '#2############################################################\' +
                            '#3###########################################################\' +
                            '#4############################################################\' +
                            '#5###########################################################\' +
                            '#6############################################################');
                            ProgBar2.Update(1, '2 of 2 Updating Graduation Items');
                            ProgBar2.Update(2, 'Total Recs.: ' + Format(TotalRecs));
                            repeat
                            begin
                                // For each Record
                                ACADefinedUnitsperYoS.Reset;
                                ACADefinedUnitsperYoS.SetRange(Programmes, ClassClassificationStudents.Programme);
                                if ACADefinedUnitsperYoS.Find('-') then begin
                                    repeat
                                    begin
                                        ClassClassificationCourseReg.Reset;
                                        ClassClassificationCourseReg.SetRange("Student Number", ClassClassificationStudents."Student Number");
                                        ClassClassificationCourseReg.SetRange(Programme, ClassClassificationStudents.Programme);
                                        ClassClassificationCourseReg.SetRange("Year of Study", ACADefinedUnitsperYoS."Year of Study");
                                        ClassClassificationCourseReg.SetRange("Graduation Academic Year", GradAcademicYear);
                                        if not ClassClassificationCourseReg.Find('-') then begin
                                            ClassClassificationCourseReg.Init;
                                            ClassClassificationCourseReg."Student Number" := ClassClassificationStudents."Student Number";
                                            ClassClassificationCourseReg.Programme := ClassClassificationStudents.Programme;
                                            ClassClassificationCourseReg."Year of Study" := ACADefinedUnitsperYoS."Year of Study";
                                            ClassClassificationCourseReg."Graduation Academic Year" := GradAcademicYear;
                                            ClassClassificationCourseReg.Insert;
                                        end;
                                    end;
                                    until ACADefinedUnitsperYoS.Next = 0;
                                end;

                                ACANotGraduatingReasons.SetRange("Student No.", ClassClassificationStudents."Student Number");
                                if ACANotGraduatingReasons.Find('-') then ACANotGraduatingReasons.DeleteAll;
                                CountedRecs += 1;
                                RemeiningRecs -= 1;
                                ProgBar2.Update(3, '.....................................................');
                                ProgBar2.Update(4, 'Processed: ' + Format(CountedRecs));
                                ProgBar2.Update(5, 'Remaining: ' + Format(RemeiningRecs));
                                ProgBar2.Update(6, '----------------------------------------------------');
                                if Progyz.Get(ClassClassificationStudents.Programme) then begin
                                    ClassClassificationStudents.Department := Progyz."Department Code";
                                    ClassClassificationStudents."School Code" := Progyz."School Code";
                                end;
                                ClassClassificationStudents."Department Name" := GetDepartmentNameOrSchool(ClassClassificationStudents.Department);
                                ClassClassificationStudents."School Name" := GetDepartmentNameOrSchool(ClassClassificationStudents."School Code");
                                ClassClassificationStudents."Student Name" := GetStudentName(ClassClassificationStudents."Student Number");
                                ClassClassificationStudents.Cohort := GetCohort(ClassClassificationStudents."Student Number", ClassClassificationStudents.Programme);
                                ClassClassificationStudents."Final Stage" := GetFinalStage(ClassClassificationStudents.Programme);
                                ClassClassificationStudents."Final Academic Year" := GetFinalAcademicYear(ClassClassificationStudents."Student Number", ClassClassificationStudents.Programme);
                                ClassClassificationStudents."Final Year of Study" := GetFinalYearOfStudy(ClassClassificationStudents.Programme);
                                ClassClassificationStudents."Admission Date" := GetAdmissionDate(ClassClassificationStudents."Student Number", ClassClassificationStudents.Programme);
                                ClassClassificationStudents."Admission Academic Year" := GetAdmissionAcademicYear(ClassClassificationStudents."Student Number", ClassClassificationStudents.Programme);
                                ClassClassificationStudents.Graduating := false;
                                ClassClassificationStudents.Classification := '';
                                ClassClassificationCourseReg.Reset;
                                ClassClassificationCourseReg.SetRange("Student Number", ClassClassificationStudents."Student Number");
                                ClassClassificationCourseReg.SetRange(Programme, ClassClassificationStudents.Programme);
                                ClassClassificationCourseReg.SetRange("Graduation Academic Year", GradAcademicYear);
                                if ClassClassificationCourseReg.Find('-') then begin
                                    repeat
                                    begin
                                        ClassClassificationCourseReg."Department Name" := ClassClassificationStudents."Department Name";
                                        ClassClassificationCourseReg."School Name" := ClassClassificationStudents."School Name";
                                        ClassClassificationCourseReg."Student Name" := ClassClassificationStudents."Student Name";
                                        ClassClassificationCourseReg.Cohort := ClassClassificationStudents.Cohort;
                                        ClassClassificationCourseReg."Final Stage" := ClassClassificationStudents."Final Stage";
                                        ClassClassificationCourseReg."Final Academic Year" := ClassClassificationStudents."Final Academic Year";
                                        ClassClassificationCourseReg."Final Year of Study" := ClassClassificationStudents."Final Year of Study";
                                        ClassClassificationCourseReg."Admission Date" := ClassClassificationStudents."Admission Date";
                                        ClassClassificationCourseReg."Admission Academic Year" := ClassClassificationStudents."Admission Academic Year";
                                        ClassClassificationCourseReg.Graduating := false;
                                        ClassClassificationCourseReg.Classification := '';

                                        ClassClassificationUnits.Reset;
                                        ClassClassificationUnits.SetRange("Student No.", ClassClassificationStudents."Student Number");
                                        ClassClassificationUnits.SetRange(Programme, ClassClassificationStudents.Programme);
                                        ClassClassificationUnits.SetRange("Graduation Academic Year", GradAcademicYear);
                                        // ClassClassificationUnits.SETRANGE("Year of Study",ClassClassificationCourseReg."Year of Study");
                                        if ClassClassificationUnits.Find('-') then begin
                                            repeat
                                            begin
                                                // //              IF ((ClassClassificationUnits."Unit Code"='AAG 303') AND (ClassClassificationUnits."Student No."='AF/00004/016')) THEN
                                                // //              ClassStudentUnits.RESET;
                                                ClassStudentUnits.Reset;
                                                ClassStudentUnits.SetRange("Student No.", ClassClassificationUnits."Student No.");
                                                ClassStudentUnits.SetRange(Programme, ClassClassificationUnits.Programme);
                                                ClassStudentUnits.SetRange("Reg. Reversed", false);
                                                ClassStudentUnits.SetRange(Unit, ClassClassificationUnits."Unit Code");
                                                if ClassStudentUnits.Find('+') then begin
                                                    ClassStudentUnits.CalcFields("EXAMs Marks", "CATs Marks", "CATs Marks Exists", "EXAMs Marks Exists");
                                                    //Get CAT Marks
                                                    // //                ClassExamResults.RESET;
                                                    // //                ClassExamResults.SETRANGE("Student No.",ClassClassificationUnits."Student No.");
                                                    // //                ClassExamResults.SETRANGE(Unit,ClassClassificationUnits."Unit Code");
                                                    // //                ClassExamResults.SETFILTER(Exam,'%1|%2','ASSIGNMENT','CAT');
                                                    // //                ClassExamResults.SETCURRENTKEY(Semester);
                                                    // //                IF ClassExamResults.FIND('+') THEN BEGIN
                                                    if ClassStudentUnits."CATs Marks Exists" then begin
                                                        ClassClassificationUnits."CAT Score" := Format(ClassStudentUnits."CATs Marks");
                                                        ClassClassificationUnits."CAT Score Decimal" := ClassStudentUnits."CATs Marks";
                                                    end else begin
                                                        ClassClassificationUnits."CAT Score" := '';
                                                        ClassClassificationUnits."CAT Score Decimal" := 0;
                                                    end;
                                                    // //                  END;
                                                    //Get Exam Marks
                                                    // //                ClassExamResults.RESET;
                                                    // //                ClassExamResults.SETRANGE("Student No.",ClassClassificationUnits."Student No.");
                                                    // //                ClassExamResults.SETRANGE(Unit,ClassClassificationUnits."Unit Code");
                                                    // //                ClassExamResults.SETFILTER(Exam,'%1|%2|%3|%4','EXAM','EXAM100','EXAMS','FINAL EXAM');
                                                    // //                ClassExamResults.SETCURRENTKEY(Semester);
                                                    // //                IF ClassExamResults.FIND('+') THEN BEGIN
                                                    if ClassStudentUnits."EXAMs Marks Exists" then begin
                                                        ClassClassificationUnits."Exam Score" := Format(ClassStudentUnits."EXAMs Marks");
                                                        ClassClassificationUnits."Exam Score Decimal" := ClassStudentUnits."EXAMs Marks";
                                                    end;
                                                    // //                  END;
                                                end;

                                                if ClassClassificationUnits."Exam Score" = '' then begin
                                                    ClassExamResults.Reset;
                                                    ClassExamResults.SetRange("Student No.", ClassClassificationUnits."Student No.");
                                                    ClassExamResults.SetRange(Unit, ClassClassificationUnits."Unit Code");
                                                    ClassExamResults.SetFilter(ExamType, '%1|%2|%3|%4|%5|%6', 'EXAM', 'EXAM100', 'EXAMS', 'FINAL EXAM', 'FINAL', 'EXAMS');
                                                    ClassExamResults.SetCurrentKey(Semester);
                                                    if ClassExamResults.Find('+') then begin
                                                        ClassClassificationUnits."Exam Score" := Format(ClassExamResults.Score);
                                                        ClassClassificationUnits."Exam Score Decimal" := ClassExamResults.Score;
                                                    end;
                                                end;

                                                if ClassClassificationUnits."CAT Score" = '' then begin
                                                    ClassExamResults.Reset;
                                                    ClassExamResults.SetRange("Student No.", ClassClassificationUnits."Student No.");
                                                    ClassExamResults.SetRange(Unit, ClassClassificationUnits."Unit Code");
                                                    ClassExamResults.SetFilter(ExamType, '%1|%2|%3', 'ASSIGNMENT', 'CAT', 'CATS');
                                                    ClassExamResults.SetCurrentKey(Semester);
                                                    if ClassExamResults.Find('+') then begin
                                                        ClassClassificationUnits."CAT Score" := Format(ClassExamResults.Score);
                                                        ClassClassificationUnits."CAT Score Decimal" := ClassExamResults.Score;
                                                    end;
                                                end;

                                                //Update Tatal Marks
                                                if ((ClassClassificationUnits."Exam Score" = '') and (ClassClassificationUnits."CAT Score" = '')) then begin
                                                    ClassClassificationUnits.Pass := false;
                                                    ClassClassificationUnits.Grade := '?';
                                                end else
                                                    if ((ClassClassificationUnits."Exam Score" <> '') and (ClassClassificationUnits."CAT Score" <> '')) then begin
                                                        ClassClassificationUnits."Total Score" := Format(ClassClassificationUnits."Exam Score Decimal" + ClassClassificationUnits."CAT Score Decimal");
                                                        ClassClassificationUnits."Total Score Decimal" := ClassClassificationUnits."Exam Score Decimal" + ClassClassificationUnits."CAT Score Decimal";
                                                        ClassClassificationUnits."Weighted Total Score" := ClassClassificationUnits."Credit Hourse" * ClassClassificationUnits."Total Score Decimal";
                                                        ClassClassificationUnits.Grade := GetGrade(ClassClassificationUnits."Total Score Decimal", ClassClassificationUnits."Unit Code", ClassClassificationUnits.Programme);
                                                        ClassClassificationUnits.Pass := GetUnitPassStatus(ClassClassificationUnits."Total Score Decimal", ClassClassificationUnits."Unit Code", ClassClassificationUnits.Programme);
                                                        // IF ClassClassificationUnits.Pass THEN BEGIN
                                                        //  END;
                                                    end else begin
                                                        ClassClassificationUnits.Pass := false;
                                                        ClassClassificationUnits.Grade := '!';
                                                        ClassClassificationUnits."Total Score" := Format(ClassClassificationUnits."Exam Score Decimal" + ClassClassificationUnits."CAT Score Decimal");
                                                        ClassClassificationUnits."Total Score Decimal" := ClassClassificationUnits."Exam Score Decimal" + ClassClassificationUnits."CAT Score Decimal";
                                                        ClassClassificationUnits."Weighted Total Score" := ClassClassificationUnits."Credit Hourse" * ClassClassificationUnits."Total Score Decimal";
                                                    end;
                                                ClassClassificationUnits.Cohort := ClassClassificationStudents.Cohort;
                                                if ((ClassClassificationUnits."Unit Type" = 'CORE') or (ClassClassificationUnits."Unit Type" = 'REQUIRED')) then
                                                    ClassClassificationUnits."Allow In Graduate" := true;

                                                if ClassClassificationUnits.Modify then;
                                            end;
                                            until ClassClassificationUnits.Next = 0;
                                        end;
                                        // Update Course Registration for Graduation
                                        Clear(ExpectedElectives);
                                        ClassClassificationCourseReg.CalcFields("Total Cores Done", "Total Required Done");
                                        ExpectedElectives := RequiredStageUnits(ClassClassificationCourseReg.Programme,
                                        ClassClassificationCourseReg."Year of Study", ClassClassificationCourseReg."Student Number");
                                        ExpectedElectives := ExpectedElectives - ClassClassificationCourseReg."Total Cores Done" - ClassClassificationCourseReg."Total Required Done";
                                        // Update Classifiable Electives
                                        if ExpectedElectives > 0 then begin
                                            ClassClassificationUnits.Reset;
                                            ClassClassificationUnits.SetRange("Student No.", ClassClassificationStudents."Student Number");
                                            ClassClassificationUnits.SetRange(Programme, ClassClassificationStudents.Programme);
                                            ClassClassificationUnits.SetRange("Graduation Academic Year", GradAcademicYear);
                                            ClassClassificationUnits.SetRange("Year of Study", ClassClassificationCourseReg."Year of Study");
                                            ClassClassificationUnits.SetRange("Unit Type", 'ELECTIVE');
                                            ClassClassificationUnits.SetCurrentKey("Total Score");
                                            if ClassClassificationUnits.Find('-') then begin
                                                Clear(CountedElectives);
                                                CountedElectives := ClassClassificationUnits.Count;
                                                repeat
                                                begin
                                                    ClassClassificationUnits."Course Cat. Presidence" := CountedElectives;
                                                    CountedElectives := CountedElectives - 1;
                                                    ClassClassificationUnits.Modify;
                                                end;
                                                until ClassClassificationUnits.Next = 0;
                                            end;
                                            // Get Top Electives and tag for Graduation
                                            ClassClassificationUnits.Reset;
                                            ClassClassificationUnits.SetRange("Student No.", ClassClassificationStudents."Student Number");
                                            ClassClassificationUnits.SetRange(Programme, ClassClassificationStudents.Programme);
                                            ClassClassificationUnits.SetRange("Graduation Academic Year", GradAcademicYear);
                                            ClassClassificationUnits.SetRange("Year of Study", ClassClassificationCourseReg."Year of Study");
                                            ClassClassificationUnits.SetRange("Unit Type", 'ELECTIVE');
                                            ClassClassificationUnits.SetCurrentKey("Course Cat. Presidence");
                                            if ClassClassificationUnits.Find('-') then begin
                                                Clear(CountedElectives);
                                                repeat
                                                begin
                                                    CountedElectives := CountedElectives + 1;
                                                    ClassClassificationUnits."Allow In Graduate" := true;
                                                    ClassClassificationUnits.Modify;
                                                end;
                                                until ((ClassClassificationUnits.Next = 0) or (CountedElectives = ExpectedElectives));
                                            end;
                                        end;

                                        ClassClassificationCourseReg.CalcFields("Total Marks", "Total Courses", "Total Weighted Marks",
                                        "Total Units", "Classified Total Marks", "Total Classified C. Count", "Classified W. Total", "Attained Stage Units");
                                        if ClassClassificationCourseReg."Total Courses" <> 0 then
                                            ClassClassificationCourseReg."Normal Average" := ClassClassificationCourseReg."Total Marks" / ClassClassificationCourseReg."Total Courses";
                                        if ClassClassificationCourseReg."Total Units" <> 0 then
                                            ClassClassificationCourseReg."Weighted Average" := ClassClassificationCourseReg."Total Weighted Marks" / ClassClassificationCourseReg."Total Units";
                                        if ClassClassificationCourseReg."Total Classified C. Count" <> 0 then
                                            ClassClassificationCourseReg."Classified Average" := ClassClassificationCourseReg."Classified Total Marks" / ClassClassificationCourseReg."Total Classified C. Count";
                                        if ClassClassificationCourseReg."Total Classified Units" <> 0 then
                                            ClassClassificationCourseReg."Classified W. Average" := ClassClassificationCourseReg."Classified W. Total" / ClassClassificationCourseReg."Total Classified Units";
                                        ClassClassificationCourseReg."Required Stage Units" := RequiredStageUnits(ClassClassificationCourseReg.Programme,
                                        ClassClassificationCourseReg."Year of Study", ClassClassificationCourseReg."Student Number");
                                        if ClassClassificationCourseReg."Required Stage Units" > ClassClassificationCourseReg."Attained Stage Units" then
                                            ClassClassificationCourseReg."Units Deficit" := ClassClassificationCourseReg."Required Stage Units" - ClassClassificationCourseReg."Attained Stage Units";
                                        ClassClassificationCourseReg."Multiple Programe Reg. Exists" := GetMultipleProgramExists(ClassClassificationCourseReg."Student Number");

                                        ClassClassificationCourseReg.CalcFields("CATS Missing", "Exam Missing");
                                        Clear(ExistsOption);
                                        if ((ClassClassificationCourseReg."Exam Missing") and (ClassClassificationCourseReg."CATS Missing")) then
                                            ExistsOption := ExistsOption::"None Exists"
                                        else
                                            if ((ClassClassificationCourseReg."Exam Missing" = true) and (ClassClassificationCourseReg."CATS Missing" = false)) then
                                                ExistsOption := ExistsOption::"Exam Only"
                                            else
                                                if ((ClassClassificationCourseReg."Exam Missing" = false) and (ClassClassificationCourseReg."CATS Missing" = true)) then
                                                    ExistsOption := ExistsOption::"CAT Only"
                                                else
                                                    if ((ClassClassificationCourseReg."Exam Missing" = false) and (ClassClassificationCourseReg."CATS Missing" = false)) then ExistsOption := ExistsOption::"Both Exists";
                                        ClassClassificationCourseReg."Final Classification" := GetClassification(ClassClassificationCourseReg.Programme, ClassClassificationCourseReg."Classified Average", false, ExistsOption);
                                        ClassClassificationCourseReg."Final Classification Pass" := GetClassPassStatus(ClassClassificationCourseReg."Classified Average", ClassClassificationCourseReg.Programme, ExistsOption);
                                        ClassClassificationCourseReg."Graduation Grade" := GetClassificationGrade(ClassClassificationCourseReg."Normal Average", ClassClassificationCourseReg.Programme, ExistsOption);
                                        ClassClassificationCourseReg."Final Classification Grade" := GetClassificationGrade(ClassClassificationCourseReg."Classified Average", ClassClassificationCourseReg.Programme, ExistsOption);
                                        ClassClassificationCourseReg."Final Classification Order" := GetClassificationOrder(ClassClassificationCourseReg.Programme, ClassClassificationCourseReg."Classified Average", false, ExistsOption);
                                        ClassClassificationCourseReg.Graduating := GetClassPassStatus(ClassClassificationCourseReg."Classified Average", ClassClassificationCourseReg.Programme, ExistsOption);
                                        ClassClassificationCourseReg.Classification := GetClassification(ClassClassificationCourseReg.Programme, ClassClassificationCourseReg."Classified Average", false, ExistsOption);
                                        ClassClassificationCourseReg.Modify;

                                        if ClassClassificationCourseReg."Total Courses" <> 0 then
                                            ClassClassificationCourseReg."Normal Average" := ClassClassificationCourseReg."Total Marks" / ClassClassificationCourseReg."Total Courses";
                                    end;
                                    until ClassClassificationCourseReg.Next = 0;
                                end;
                                // Update Student Grad. Master
                                Clear(Total_First_Year_Courses);
                                Clear(Total_First_Year_Marks);
                                Clear(New_Total_Courses);
                                Clear(New_Total_Marks);
                                Clear(New_Classifiable_Average);
                                ClassClassificationStudents.CalcFields(ClassClassificationStudents."Prog. Exam Category");
                                ClassClassificationStudents.CalcFields("Total Marks", "Total Courses", "Total Weighted Marks",
                                "Total Units", "Classified Total Marks", "Total Classified C. Count", "Classified W. Total", "Attained Stage Units");
                                if ((ClassClassificationStudents."Program Group" = 'DEGREE') or (ClassClassificationStudents."Program Group" = 'UNDERGRADUATE')) then begin
                                    ClassClassificationCourseReg.Reset;
                                    ClassClassificationCourseReg.SetRange("Student Number", ClassClassificationStudents."Student Number");
                                    ClassClassificationCourseReg.SetRange(Programme, ClassClassificationStudents.Programme);
                                    ClassClassificationCourseReg.SetRange("Graduation Academic Year", GradAcademicYear);
                                    ClassClassificationCourseReg.SetRange("Year of Study", 1);
                                    if ClassClassificationCourseReg.Find('-') then begin
                                        ClassClassificationCourseReg.CalcFields("Total Marks", "Total Courses", "Total Weighted Marks",
                              "Total Units", "Classified Total Marks", "Total Classified C. Count", "Classified W. Total", "Attained Stage Units");
                                        Total_First_Year_Courses := ClassClassificationCourseReg."Total Courses";
                                        Total_First_Year_Marks := ClassClassificationCourseReg."Total Marks";
                                        New_Total_Courses := ClassClassificationStudents."Total Courses" - Total_First_Year_Courses;
                                        New_Total_Marks := ClassClassificationStudents."Total Marks" - Total_First_Year_Marks;
                                    end;
                                end else begin
                                    New_Total_Courses := ClassClassificationStudents."Total Courses";
                                    New_Total_Marks := ClassClassificationStudents."Total Marks";
                                end;

                                if New_Total_Courses > 0 then
                                    New_Classifiable_Average := New_Total_Marks / New_Total_Courses;
                                New_Classifiable_Average := Round(New_Classifiable_Average, 0.01, '=');

                                if ClassClassificationStudents."Total Courses" <> 0 then
                                    ClassClassificationStudents."Normal Average" := ClassClassificationStudents."Total Marks" / ClassClassificationStudents."Total Courses";
                                if ClassClassificationStudents."Total Units" <> 0 then
                                    ClassClassificationStudents."Weighted Average" := ClassClassificationStudents."Total Weighted Marks" / ClassClassificationStudents."Total Units";
                                //          IF ClassClassificationStudents."Total Classified C. Count"<>0 THEN
                                ClassClassificationStudents."Classified Average" := New_Classifiable_Average;
                                if ClassClassificationStudents."Total Classified Units" <> 0 then
                                    ClassClassificationStudents."Classified W. Average" := ClassClassificationStudents."Classified W. Total" / ClassClassificationStudents."Total Classified Units";
                                ClassClassificationStudents."Required Stage Units" := RequiredStageUnits(ClassClassificationStudents.Programme,
                                ClassClassificationStudents."Year of Study", ClassClassificationStudents."Student Number");
                                if ClassClassificationStudents."Required Stage Units" > ClassClassificationStudents."Attained Stage Units" then
                                    ClassClassificationStudents."Units Deficit" := ClassClassificationStudents."Required Stage Units" - ClassClassificationStudents."Attained Stage Units";

                                ClassClassificationStudents.CalcFields("CATS Missing", "Exam Missing");
                                Clear(ExistsOption);
                                if ((ClassClassificationStudents."Exam Missing") and (ClassClassificationStudents."CATS Missing")) then
                                    ExistsOption := ExistsOption::"None Exists"
                                else
                                    if ((ClassClassificationStudents."Exam Missing" = true) and (ClassClassificationStudents."CATS Missing" = false)) then
                                        ExistsOption := ExistsOption::"Exam Only"
                                    else
                                        if ((ClassClassificationStudents."Exam Missing" = false) and (ClassClassificationStudents."CATS Missing" = true)) then
                                            ExistsOption := ExistsOption::"CAT Only"
                                        else
                                            if ((ClassClassificationStudents."Exam Missing" = false) and (ClassClassificationStudents."CATS Missing" = false)) then ExistsOption := ExistsOption::"Both Exists";

                                ClassClassificationStudents."Final Classification" := GetClassification(ClassClassificationStudents.Programme, New_Classifiable_Average, false, ExistsOption);
                                ClassClassificationStudents."Final Classification Pass" := GetClassPassStatus(New_Classifiable_Average, ClassClassificationStudents.Programme, ExistsOption);
                                ClassClassificationStudents."Graduation Grade" := GetClassificationGrade(New_Classifiable_Average, ClassClassificationStudents.Programme, ExistsOption);
                                ClassClassificationStudents."Final Classification Grade" := GetClassificationGrade(New_Classifiable_Average, ClassClassificationStudents.Programme, ExistsOption);
                                ClassClassificationStudents."Final Classification Order" := GetClassificationOrder(ClassClassificationStudents.Programme, New_Classifiable_Average, false, ExistsOption);
                                ClassClassificationStudents.Graduating := GetClassPassStatus(New_Classifiable_Average, ClassClassificationStudents.Programme, ExistsOption);
                                ClassClassificationStudents.Classification := GetClassification(ClassClassificationStudents.Programme, New_Classifiable_Average, false, ExistsOption);
                                ClassClassificationStudents.Modify;
                                ToGraduate := true;
                                //Less Courses in a Stage/Level
                                if ClassClassificationStudents."Units Deficit" > 0 then begin
                                    ToGraduate := false;
                                    ACANotGraduatingReasons.Init;
                                    ACANotGraduatingReasons."Graduation Academic Year" := GradAcademicYear;
                                    ACANotGraduatingReasons."Student No." := ClassClassificationStudents."Student Number";
                                    ACANotGraduatingReasons."Reason Code" := 'LESS COURSES';
                                    ACANotGraduatingReasons."Reason Details" := 'Deficit on units:\ Ensure the students is registered.';
                                    if ACANotGraduatingReasons.Insert then;
                                end;
                                //Failed A Unit

                                ClassClassificationUnits.Reset;
                                ClassClassificationUnits.SetRange("Student No.", ClassClassificationStudents."Student Number");
                                ClassClassificationUnits.SetRange(Programme, ClassClassificationStudents.Programme);
                                ClassClassificationUnits.SetRange("Graduation Academic Year", GradAcademicYear);
                                ClassClassificationUnits.SetRange(Pass, false);
                                if ClassClassificationUnits.Find('-') then begin
                                    ToGraduate := false;
                                    ACANotGraduatingReasons.Init;
                                    ACANotGraduatingReasons."Graduation Academic Year" := GradAcademicYear;
                                    ACANotGraduatingReasons."Student No." := ClassClassificationStudents."Student Number";
                                    ACANotGraduatingReasons."Reason Code" := 'FAILED COURSES';
                                    ACANotGraduatingReasons."Reason Details" := 'Failed Some Courses:\ e.g. ' + ClassClassificationUnits."Unit Code";
                                    if ACANotGraduatingReasons.Insert then;
                                end;
                                //Unit Registered not on the Catalog
                                ClassClassificationUnits.Reset;
                                ClassClassificationUnits.SetRange("Student No.", ClassClassificationStudents."Student Number");
                                ClassClassificationUnits.SetRange(Programme, ClassClassificationStudents.Programme);
                                ClassClassificationUnits.SetRange("Graduation Academic Year", GradAcademicYear);
                                ClassClassificationUnits.SetRange("Unit Exists", false);
                                if ClassClassificationUnits.Find('-') then begin
                                    ToGraduate := false;
                                    ACANotGraduatingReasons.Init;
                                    ACANotGraduatingReasons."Graduation Academic Year" := GradAcademicYear;
                                    ACANotGraduatingReasons."Student No." := ClassClassificationStudents."Student Number";
                                    ACANotGraduatingReasons."Reason Code" := 'UNIT NOT IN CATALOG';
                                    ACANotGraduatingReasons."Reason Details" := 'Some Registered Units are Missing in the Course Catalog:\ e.g. ' + ClassClassificationUnits."Unit Code";
                                    if ACANotGraduatingReasons.Insert then;
                                end;
                                //Multiple Programs Registered
                                ACAClassificationStudentsCheck.Reset;
                                ACAClassificationStudentsCheck.SetRange("Student Number", ClassClassificationStudents."Student Number");
                                if ACAClassificationStudentsCheck.Find('-') then begin
                                    if ACAClassificationStudentsCheck.Count > 1 then begin
                                        ToGraduate := false;
                                        ACANotGraduatingReasons.Init;
                                        ACANotGraduatingReasons."Graduation Academic Year" := GradAcademicYear;
                                        ACANotGraduatingReasons."Student No." := ClassClassificationStudents."Student Number";
                                        ACANotGraduatingReasons."Reason Code" := 'MULTIPLE COURSE REG';
                                        ACANotGraduatingReasons."Reason Details" := 'Multiple Course Registration identified with Multiple Programs';
                                        if ACANotGraduatingReasons.Insert then;
                                    end;
                                end;
                                // Missing Both CAT and Exam
                                ClassClassificationUnits.Reset;
                                ClassClassificationUnits.SetRange("Student No.", ClassClassificationStudents."Student Number");
                                ClassClassificationUnits.SetRange(Programme, ClassClassificationStudents.Programme);
                                ClassClassificationUnits.SetRange("Graduation Academic Year", GradAcademicYear);
                                ClassClassificationUnits.SetRange(Grade, '?');
                                if ClassClassificationUnits.Find('-') then begin
                                    ToGraduate := false;
                                    ACANotGraduatingReasons.Init;
                                    ACANotGraduatingReasons."Graduation Academic Year" := GradAcademicYear;
                                    ACANotGraduatingReasons."Student No." := ClassClassificationStudents."Student Number";
                                    ACANotGraduatingReasons."Reason Code" := 'MISSING CAT & EXAM';
                                    ACANotGraduatingReasons."Reason Details" := 'CAT & Exam Missing on some units e.g.  ' + ClassClassificationUnits."Unit Code";
                                    if ACANotGraduatingReasons.Insert then;
                                end;
                                //Exists With Missing Mark
                                ClassClassificationUnits.Reset;
                                ClassClassificationUnits.SetRange("Student No.", ClassClassificationStudents."Student Number");
                                ClassClassificationUnits.SetRange(Programme, ClassClassificationStudents.Programme);
                                ClassClassificationUnits.SetRange("Graduation Academic Year", GradAcademicYear);
                                ClassClassificationUnits.SetRange(Grade, '!');
                                if ClassClassificationUnits.Find('-') then begin
                                    ToGraduate := false;
                                    ACANotGraduatingReasons.Init;
                                    ACANotGraduatingReasons."Graduation Academic Year" := GradAcademicYear;
                                    ACANotGraduatingReasons."Student No." := ClassClassificationStudents."Student Number";
                                    ACANotGraduatingReasons."Reason Code" := 'MISSING MARK';
                                    ACANotGraduatingReasons."Reason Details" := 'Some CAT and/or Exam Marks Missing\ e.g. ' + ClassClassificationUnits."Unit Code";
                                    if ACANotGraduatingReasons.Insert then;
                                end;
                                ClassClassificationStudents.CalcFields("Required Stage Units", "Attained Stage Units", "Failed Courses");
                                // //        IF (ClassClassificationStudents."Required Stage Units">ClassClassificationStudents."Attained Stage Units") THEN
                                // //          ToGraduate:=FALSE;
                                if ClassClassificationStudents."Failed Courses" > 0 then
                                    ToGraduate := false;
                                if ClassClassificationStudents."Final Classification" = '' then begin
                                    ToGraduate := false;
                                    ACANotGraduatingReasons.Init;
                                    ACANotGraduatingReasons."Graduation Academic Year" := GradAcademicYear;
                                    ACANotGraduatingReasons."Student No." := ClassClassificationStudents."Student Number";
                                    ACANotGraduatingReasons."Reason Code" := 'UNKNORN CLASS';
                                    ACANotGraduatingReasons."Reason Details" := 'Empty Classifications ';
                                    ;
                                    if ACANotGraduatingReasons.Insert then;
                                end;
                                //Failed to attained course required in a Year of study

                                ClassClassificationCourseReg.Reset;
                                ClassClassificationCourseReg.SetRange("Student Number", ClassClassificationStudents."Student Number");
                                ClassClassificationCourseReg.SetRange("Graduation Academic Year", GradAcademicYear);
                                if ClassClassificationCourseReg.Find('-') then begin
                                    repeat
                                    begin
                                        ClassClassificationCourseReg.CalcFields("Attained Stage Units");
                                        if ClassClassificationCourseReg."Attained Stage Units" < ClassClassificationCourseReg."Required Stage Units" then begin
                                            if (ClassClassificationStudents."Required Stage Units" > ClassClassificationStudents."Attained Stage Units") then begin
                                                if (ClassClassificationStudents."Required Stage Units" > ClassClassificationStudents."Attained Stage Units") then begin
                                                    ToGraduate := false;
                                                    ACANotGraduatingReasons.Init;
                                                    ACANotGraduatingReasons."Graduation Academic Year" := GradAcademicYear;
                                                    ACANotGraduatingReasons."Student No." := ClassClassificationStudents."Student Number";
                                                    ACANotGraduatingReasons."Reason Code" := 'LESS UNITS ATTAINED';
                                                    ACANotGraduatingReasons."Reason Details" := 'Did not attain all the required units in Year' + Format(ClassClassificationCourseReg."Year of Study") + '. Required: ' +
                                                    Format(ClassClassificationCourseReg."Required Stage Units") + '. Attained: ' + Format(ClassClassificationCourseReg."Attained Stage Units");
                                                    if ACANotGraduatingReasons.Insert then;
                                                end;
                                            end;
                                        end;
                                    end;
                                    until ClassClassificationCourseReg.Next = 0;
                                end;


                                if ToGraduate = false then begin
                                    ClassClassificationStudents.Graduating := ToGraduate;
                                    ClassClassificationStudents.Classification := 'INCOMPLETE';
                                    ClassClassificationStudents."Final Classification" := 'INCOMPLETE';
                                    ClassClassificationStudents."Final Classification Pass" := false;
                                end;


                                ClassClassificationCourseReg.Reset;
                                ClassClassificationCourseReg.SetRange("Student Number", ClassClassificationStudents."Student Number");
                                ClassClassificationCourseReg.SetRange(Programme, ClassClassificationStudents.Programme);
                                ClassClassificationCourseReg.SetRange("Graduation Academic Year", GradAcademicYear);
                                if ClassClassificationCourseReg.Find('-') then begin
                                    repeat
                                    begin
                                        ClassClassificationCourseReg.Graduating := ClassClassificationStudents.Graduating;
                                        ClassClassificationCourseReg.Classification := ClassClassificationStudents.Classification;
                                        ClassClassificationCourseReg."Final Classification" := ClassClassificationStudents."Final Classification";
                                        ClassClassificationCourseReg."Final Classification Pass" := ClassClassificationStudents."Final Classification Pass";
                                        ClassClassificationCourseReg.Modify;
                                    end;
                                    until ClassClassificationCourseReg.Next = 0;
                                end;
                                ClassClassificationStudents.Modify
                            end;
                            until ClassClassificationStudents.Next = 0;
                            ProgBar2.Close;
                        end;
                    end;
                    Message('Processing completed successfully!');

                    UpdateFilters(UserId, programs, Semesters, GradAcademicYear);
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
            Semesters := ACAExamProcessingFilterLog."Semester Code";
            programs := ACAExamProcessingFilterLog."Programme Code";
            //GradAcademicYear:=ACAExamProcessingFilterLog."Graduation Year";
        end;
        ACAAcademicYear963.Reset;
        ACAAcademicYear963.SetRange("Graduating Group", true);
        if not ACAAcademicYear963.Find('-') then Error('Graduating group is not defined!');
        GradAcademicYear := ACAAcademicYear963.Code;
    end;

    var
        programs: Code[1024];
        Semesters: Code[1024];
        Stages: Code[1024];
        StudNos: Code[1024];
        ACAExamResultsBuffer2: Record "ACA-Exam Results Buffer 2";
        ACACourseRegistration: Record "ACA-Course Registration";
        ACAExamResults: Record "ACA-Exam Results";
        SemesterFilter: Text[1024];
        AcaSpecialExamsResults: Record "Aca-Special Exams Results";
        GradAcademicYear: Code[20];
        ACACourseRegistration5: Record "ACA-Course Registration";
        Progrezz: Dialog;
        ACAProgramme963: Record "ACA-Programme";
        ACAAcademicYear963: Record "ACA-Academic Year";
        Schools: Code[20];
        UnitCode: Code[1024];
        ACAProgrammeStages: Record "ACA-Programme Stages";
        ProgFIls: Text[1024];
        Progressbar: Dialog;
        ToGraduate: Boolean;
        ProgFilters: Text[1024];

    local procedure UpdateFilters(UserCode: Code[50]; ProgCodes: Code[1024]; SemCodes: Code[1024]; GradYearOfStudy: Code[1024])
    var
        ACAExamProcessingFilterLog: Record "ACA-Exam Processing Filter Log";
    begin
        ACAExamProcessingFilterLog.Reset;
        ACAExamProcessingFilterLog.SetRange("User ID", UserCode);
        if ACAExamProcessingFilterLog.Find('-') then begin
            //Exists, Update
            ACAExamProcessingFilterLog."Programme Code" := ProgCodes;
            ACAExamProcessingFilterLog."Semester Code" := Semesters;
            ACAExamProcessingFilterLog."Graduation Year" := GradAcademicYear;
            ACAExamProcessingFilterLog.Modify;
        end else begin
            // Doesent Exists, Insert
            ACAExamProcessingFilterLog.Init;
            ACAExamProcessingFilterLog."User ID" := UserCode;
            ACAExamProcessingFilterLog."Programme Code" := ProgCodes;
            ACAExamProcessingFilterLog."Semester Code" := Semesters;
            ACAExamProcessingFilterLog."Graduation Year" := GradAcademicYear;
            ACAExamProcessingFilterLog.Insert;
        end;
    end;

    procedure GetGrade(EXAMMark: Decimal; UnitG: Code[20]; Proga: Code[20]) xGrade: Text[100]
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
        EXAMMark := Round(EXAMMark, 0.1, '=');
        Clear(Marks);
        Marks := EXAMMark;
        GradeCategory := '';
        UnitsRR.Reset;
        UnitsRR.SetRange(UnitsRR."Programme Code", Proga);
        UnitsRR.SetRange(UnitsRR.Code, UnitG);
        //UnitsRR.SETRANGE(UnitsRR."Stage Code","Student Units".Stage);
        if UnitsRR.Find('-') then begin
            if UnitsRR."Default Exam Category" <> '' then begin
                GradeCategory := UnitsRR."Default Exam Category";
            end else begin
                ProgrammeRec.Reset;
                if ProgrammeRec.Get(Proga) then
                    GradeCategory := ProgrammeRec."Exam Category";
                if ((GradeCategory = '') or (GradeCategory = ' ')) then GradeCategory := 'DEFAULT';
            end;
        end;

        xGrade := '';
        //IF Marks > 0 THEN BEGIN
        Gradings.Reset;
        Gradings.SetRange(Gradings.Category, GradeCategory);
        Gradings.SetFilter(Gradings."Lower Limit", '<%1|=%2', Marks, Marks);
        Gradings.SetFilter(Gradings."Upper Limit", '>%1|=%2', Marks, Marks);
        Gradings.SetFilter(Gradings."Results Exists Status", '%1', Gradings."Results Exists Status"::"Both Exists");
        // // LastGrade:='';
        // // LastRemark:='';
        // // LastScore:=0;
        if Gradings.Find('-') then begin
            // // ExitDo:=FALSE;
            // // //REPEAT
            // // LastScore:=Gradings."Up to";
            // // IF Marks < LastScore THEN BEGIN
            // // IF ExitDo = FALSE THEN BEGIN
            xGrade := Gradings.Grade;
            // IF Gradings.Failed=FALSE THEN
            // LastRemark:='PASS'
            // ELSE
            // LastRemark:='FAIL';
            // ExitDo:=TRUE;
            // END;
            // END;
            //
            //
            // END;

        end;
    end;

    procedure GetUnitPassStatus(EXAMMark: Decimal; UnitG: Code[20]; Proga: Code[20]) Passed: Boolean
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
        EXAMMark := Round(EXAMMark, 0.1, '=');
        Marks := EXAMMark;
        GradeCategory := '';
        UnitsRR.Reset;
        UnitsRR.SetRange(UnitsRR."Programme Code", Proga);
        UnitsRR.SetRange(UnitsRR.Code, UnitG);
        //UnitsRR.SETRANGE(UnitsRR."Stage Code","Student Units".Stage);
        if UnitsRR.Find('-') then begin
            if UnitsRR."Default Exam Category" <> '' then begin
                GradeCategory := UnitsRR."Default Exam Category";
            end else begin
                ProgrammeRec.Reset;
                if ProgrammeRec.Get(Proga) then
                    GradeCategory := ProgrammeRec."Exam Category";
                if GradeCategory = '' then GradeCategory := 'DEFAULT';
            end;
        end;
        Passed := false;
        if Marks > 0 then begin
            Gradings.Reset;
            Gradings.SetRange(Gradings.Category, GradeCategory);
            Gradings.SetFilter(Gradings."Lower Limit", '<%1|=%2', Marks, Marks);
            Gradings.SetFilter(Gradings."Upper Limit", '>%1|=%2', Marks, Marks);
            Gradings.SetFilter(Gradings."Results Exists Status", '%1', Gradings."Results Exists Status"::"Both Exists");
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

        end else begin
            Passed := false;
        end;
    end;

    local procedure GetStudentName(StudNo: Code[20]) StudName: Text[250]
    var
        Customer: Record Customer;
    begin
        Customer.Reset;
        Customer.SetRange("No.", StudNo);
        if Customer.Find('-') then
            StudName := Customer.Name;
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
        ClassClassificationStudents: Record "ACA-Classification Students";
        ClassClassificationCourseReg: Record "ACA-Classification Course Reg.";
        ClassClassificationUnits: Record "ACA-Classification Units";
    begin
        ClassClassificationStudents.Reset;
        ClassClassificationStudents.SetRange("Student Number", StudNoz);
        if ClassClassificationStudents.Find('-') then
            if ClassClassificationStudents.Count > 1 then Multiples := true else Multiples := false;
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
            Cohort := ACAProgrammeGraduationGroup."Graduation Academic Year";
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

        if ExpectedUnits = 0 then begin
            AcacourseReg.Reset;
            AcacourseReg.SetRange("Student No.", StudNo);
            AcacourseReg.SetRange(Programmes, ProgCode);
            AcacourseReg.SetRange("Year Of Study", YoS);
            if AcacourseReg.Find('-') then
                if ACADefinedUnitsperYoS.Find('-') then ExpectedUnits := ACADefinedUnitsperYoS."Number of Units";
        end;
    end;

    local procedure GetClassification(ProgCode: Code[20]; AverageScore: Decimal; HasIrregularity: Boolean; MarksStatus: Option " ","Both Exists","CAT Only","Exam Only","None Exists") Classification: Code[100]
    var
        ACAClassGradRubrics: Record "ACA-Class/Grad. Rubrics";
        ACAGradingSystemSetup: Record "ACA-Exam Gradding Setup";
        Programz1: Record "ACA-Programme";
    begin
        Clear(Classification);
        AverageScore := Round(AverageScore, 0.1, '=');
        Programz1.Reset;
        Programz1.SetRange(Code, ProgCode);
        if Programz1.Find('-') then;
        ACAGradingSystemSetup.Reset;
        ACAGradingSystemSetup.SetRange(Category, Programz1."Exam Category");
        ACAGradingSystemSetup.SetFilter("Lower Limit", '=%1|<%2', AverageScore, AverageScore);
        ACAGradingSystemSetup.SetFilter("Upper Limit", '>%2|=%1', AverageScore, AverageScore);
        ACAGradingSystemSetup.SetRange("Results Exists Status", MarksStatus);
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
            if ((Programz1."Special Programme Class" = Programz1."Special Programme Class"::"Medicine & Nursing") or
              (Programz1.Category = Programz1.Category::Postgraduate)) then
                if not ACAGradingSystemSetup.Failed then Classification := 'PASS';
        end;
    end;

    procedure GetClassificationGrade(EXAMMark: Decimal; Proga: Code[20]; MarksStatus: Option " ","Both Exists","CAT Only","Exam Only","None Exists") xGrade: Text[100]
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
        EXAMMark := Round(EXAMMark, 0.1, '=');
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
            Gradings.SetRange("Results Exists Status", MarksStatus);
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

    procedure GetClassPassStatus(EXAMMark: Decimal; Proga: Code[20]; MarksStatus: Option " ","Both Exists","CAT Only","Exam Only","None Exists") Passed: Boolean
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
        EXAMMark := Round(EXAMMark, 0.1, '=');
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
            Gradings.SetRange("Results Exists Status", MarksStatus);
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

    local procedure GetClassificationOrder(ProgramCode: Code[100]; AverageScore: Decimal; HasIrregularity: Boolean; MarksStatus: Option " ","Both Exists","CAT Only","Exam Only","None Exists") ClassOrder: Integer
    var
        ACAClassGradRubrics: Record "ACA-Class/Grad. Rubrics";
        ACAProgramme123: Record "ACA-Programme";
        ACAGradingSystemSetup: Record "ACA-Exam Gradding Setup";
        Classification: Code[50];
    begin
        Clear(Classification);

        AverageScore := Round(AverageScore, 0.1, '=');
        ACAProgramme123.Reset;
        ACAProgramme123.SetRange(Code, ProgramCode);
        if ACAProgramme123.Find('-') then begin
            ACAGradingSystemSetup.Reset;
            ACAGradingSystemSetup.SetRange(Category, ACAProgramme123."Exam Category");
            ACAGradingSystemSetup.SetFilter("Lower Limit", '=%1|<%2', AverageScore, AverageScore);
            ACAGradingSystemSetup.SetFilter("Upper Limit", '>%2|=%1', AverageScore, AverageScore);
            ACAGradingSystemSetup.SetRange("Results Exists Status", MarksStatus);
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
}

