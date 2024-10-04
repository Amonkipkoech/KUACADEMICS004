report 78049 "ACA-Subjects Update"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/UpdateExam Category.rdl';

    dataset
    {
        dataitem(subjects; "ACA-Units/Subjects")
        {

            column(ProgrammeCode_subjects; "Programme Code")
            {
            }
            column(StageCode_subjects; "Stage Code")
            {
            }
            column(Code_subjects; "Code")
            {
            }
            column(Desription_subjects; Desription)
            {
            }
            column(CreditHours_subjects; "Credit Hours")
            {
            }
            column(Amount_subjects; Amount)
            {
            }
            column(GLAccount_subjects; "G/L Account")
            {
            }
            column(Department_subjects; Department)
            {
            }
            column(Remarks_subjects; Remarks)
            {
            }
            column(TotalIncome_subjects; "Total Income")
            {
            }
            column(StudentsRegistered_subjects; "Students Registered")
            {
            }
            column(UnitType_subjects; "Unit Type")
            {
            }
            column(StudentType_subjects; "Student Type")
            {
            }
            column(Allocation_subjects; Allocation)
            {
            }
            column(Tested_subjects; Tested)
            {
            }
            column(Prerequisite_subjects; Prerequisite)
            {
            }
            column(LessonFilter_subjects; "Lesson Filter")
            {
            }
            column(CommonUnit_subjects; "Common Unit")
            {
            }
            column(NoUnits_subjects; "No. Units")
            {
            }
            column(ProgrammeOption_subjects; "Programme Option")
            {
            }
            column(TotalScore_subjects; "Total Score")
            {
            }
            column(UnitRegistered_subjects; "Unit Registered")
            {
            }
            column(ReSit_subjects; "Re-Sit")
            {
            }
            column(Audit_subjects; Audit)
            {
            }
            column(Submited_subjects; Submited)
            {
            }
            column(ExamStatus_subjects; "Exam Status")
            {
            }
            column(PrintedCopies_subjects; "Printed Copies")
            {
            }
            column(IssuedCopies_subjects; "Issued Copies")
            {
            }
            column(ReturnedCopies_subjects; "Returned Copies")
            {
            }
            column(ExamRemarks_subjects; "Exam Remarks")
            {
            }
            column(DetailsCount_subjects; "Details Count")
            {
            }
            column(NotAllocated_subjects; "Not Allocated")
            {
            }
            column(TimetablePriority_subjects; "Timetable Priority")
            {
            }
            column(NormalSlots_subjects; "Normal Slots")
            {
            }
            column(LabSlots_subjects; "Lab Slots")
            {
            }
            column(SlotsVarience_subjects; "Slots Varience")
            {
            }
            column(TimeTable_subjects; "Time Table")
            {
            }
            column(ExamNotAllocated_subjects; "Exam Not Allocated")
            {
            }
            column(ExamSlotsVarience_subjects; "Exam Slots Varience")
            {
            }
            column(Show_subjects; Show)
            {
            }
            column(EstimateReg_subjects; "Estimate Reg")
            {
            }
            column(ExamsDone_subjects; "Exams Done")
            {
            }
            column(DefaultExamCategory_subjects; "Default Exam Category")
            {
            }
            column(ProgrammeName_subjects; "Programme Name")
            {
            }
            column(LecturerCode_subjects; "Lecturer Code")
            {
            }
            column(NewUnit_subjects; "New Unit")
            {
            }
            column(ProgrammeCodelkup_subjects; "Programme Code lkup")
            {
            }
            column(LecturerLkup_subjects; "Lecturer Lkup")
            {
            }
            column(EntryNo_subjects; "Entry No")
            {
            }
            column(Attachment_subjects; Attachment)
            {
            }
            column(Research_subjects; Research)
            {
            }
            column(CombinationCount_subjects; "Combination Count")
            {
            }
            column(Prerequisite2_subjects; "Prerequisite 2")
            {
            }
            column(UsedCount_subjects; "Used Count")
            {
            }
            column(ScoreBuffer_subjects; "Score Buffer")
            {
            }
            column(Project_subjects; Project)
            {
            }
            column(IgnoreinFinalAverage_subjects; "Ignore in Final Average")
            {
            }
            column(FailedTotalScore_subjects; "Failed Total Score")
            {
            }
            column(TimeTabledCount_subjects; "Time Tabled Count")
            {
            }
            column(OldUnit_subjects; "Old Unit")
            {
            }
            column(UnitClassSize_subjects; "Unit Class Size")
            {
            }
            column(ReservedRoom_subjects; "Reserved Room")
            {
            }
            column(TimeTableCode_subjects; "Time Table Code")
            {
            }
            column(LecturerRoom_subjects; "Lecturer Room")
            {
            }
            column(TimeTabledUsedCount_subjects; "Time Tabled Used Count")
            {
            }
            column(LecturerUnitSet_subjects; LecturerUnitSet)
            {
            }
            column(CorectedUnitCode_subjects; "Corected Unit Code")
            {
            }
            column(RepeatitionCount_subjects; "Repeatition Count")
            {
            }
            column(MedicalUnit_subjects; "Medical Unit")
            {
            }
            column(TotalCreditHours_subjects; "Total Credit Hours")
            {
            }
            column(SpecialProgrammeClass_subjects; "Special Programme Class")
            {
            }
            column(ExamCategory_subjects; "Exam Category")
            {
            }
            column(SchoolCode_subjects; "School Code")
            {
            }
            column(YearofStudy_subjects; "Year of Study")
            {
            }
            column(AcademicHours_subjects; "Academic Hours")
            {
            }
            column(KeyCourse_subjects; "Key Course")
            {
            }
            column(UnitBaseCode_subjects; "Unit Base Code")
            {
            }
            column(UnitBaseTitle_subjects; "Unit Base Title")
            {
            }

            trigger OnAfterGetRecord()
            begin
                subjects2.Reset();
                subjects2.SetRange("Code", subjects."Code");
                subjects2.SetRange("Programme Code", subjects."Programme Code");
                // subjects2.SetRange("Stage Code", subjects."Stage Code");
                if subjects2.Find('-') then begin
                    repeat
                        acaprog.Reset();
                        acaprog.SetRange("Code", subjects2."Programme Code");
                        if acaprog.Find('-') then begin
                            if subjects2."Default Exam Category" = '' then begin
                                subjects2."Default Exam Category" := acaprog."Exam Category";
                                subjects2."Exam Category" := acaprog."Exam Category";
                                subjects2.Modify();
                            end;

                        end;
                    until subjects2.Next() = 0;

                end;

            end;
        }

    }

    var
        acaprog: Record "ACA-Programme";
        subjects2: record "ACA-Units/Subjects";
}