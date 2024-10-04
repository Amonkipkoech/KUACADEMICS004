report 78007 "ACA-Supp. Exams Processing"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {
            DataItemTableView = WHERE(Reversed = FILTER(false),
                                      Status = FILTER(Deceased | Registration | Current));
            RequestFilterFields = "Student No.", Programmes, Stage, Semester;
            dataitem("ACA-Student Units"; "ACA-Student Units")
            {
                DataItemLink = "Student No." = FIELD("Student No."),
                               Programme = FIELD(Programmes);
                DataItemTableView = WHERE("Reg. Reversed" = FILTER(false));

                trigger OnAfterGetRecord()
                var
                    ACAExamGraddingSetup: Record 61599;
                    ACAProgramme: Record 61511;
                begin
                    "ACA-Student Units".CALCFIELDS("ACA-Student Units"."No of Supplementaries", "ACA-Student Units"."Supp. Exam Score");
                    ACAProgramme.RESET;
                    ACAProgramme.SETRANGE(Code, "ACA-Student Units".Programme);
                    IF ACAProgramme.FIND('-') THEN ACAProgramme.TESTFIELD("Exam Category");

                    stud_Units2.RESET;
                    stud_Units2.SETRANGE("Reg. Reversed", FALSE);
                    stud_Units2.SETRANGE("Student No.", "ACA-Student Units"."Student No.");
                    stud_Units2.SETRANGE(Semester, "ACA-Student Units".Semester);
                    stud_Units2.SETRANGE(Unit, "ACA-Student Units".Unit);
                    //stud_Units2.SETRANGE("Reg. Transacton ID","ACA-Student Units"."Reg. Transacton ID");
                    IF stud_Units2.FIND('-') THEN BEGIN
                        // IF (("ACA-Student Units"."Supp. Exam Score"=0) OR ("ACA-Student Units"."No of Supplementaries"=0)) THEN BEGIN
                        //IF ("ACA-Student Units"."Supp. Exam Score"=0) THEN BEGIN
                        stud_Units2."Supp. Exam Marks" := "ACA-Student Units"."Total Marks";
                        stud_Units2."Supp. Academic Year" := "ACA-Student Units"."Academic Year";
                        // stud_Units2."Supp. Exam Score":="ACA-Student Units"."Total Marks";
                        stud_Units2."Supp. Final Score" := "ACA-Student Units"."Total Marks";
                        stud_Units2."Supp. Total Score" := "ACA-Student Units"."Total Marks";
                        stud_Units2."Supp. Total Marks" := "ACA-Student Units"."Total Marks";
                        stud_Units2."Supp. Grade" := "ACA-Student Units".Grade;
                        ACAExamGraddingSetup.RESET;
                        ACAExamGraddingSetup.SETRANGE(Grade, "ACA-Student Units".Grade);
                        ACAExamGraddingSetup.SETRANGE(Category, ACAProgramme."Exam Category");
                        IF ACAExamGraddingSetup.FIND('-') THEN
                            stud_Units2."Supp. Failed" := ACAExamGraddingSetup.Failed;
                        stud_Units2."Supp. Weighted Units" := "ACA-Student Units"."Total Marks" * "ACA-Student Units"."Credit Hours";
                        stud_Units2.MODIFY;
                        // END;
                    END;
                end;
            }
            dataitem("Aca-Special Exams Details"; "Aca-Special Exams Details")
            {
                DataItemLink = "Student No." = FIELD("Student No."),
                               Programme = FIELD(Programmes),
                               Semester = FIELD(Semester);

                trigger OnAfterGetRecord()
                var
                    "ACA-Student Units": Record 61549;
                begin
                    //ExamProcess.UpdateStudentUvbnits("Student Units"."Student No.","Student Units".Programme,"Student Units".Semester,"Student Units".Stage);
                    // // // // // // CLEAR(TotMarks);
                    progress.UPDATE(1, "ACA-Course Registration"."Student No.");
                    progress.UPDATE(2, "Aca-Special Exams Details".Programme);
                    progress.UPDATE(3, "Aca-Special Exams Details"."Unit Code");
                    // EResults.RESET;
                    // EResults.SETFILTER(EResults."Student No.","Student Units"."Student No.");
                    // EResults.SETFILTER(EResults.Programme,"Student Units".Programme);
                    // EResults.SETFILTER(EResults.Unit,"Student Units".Unit);
                    //  EResults.SETFILTER(EResults.Semester,"Student Units".Semester);
                    //  EResults.SETFILTER(EResults."Reg. Transaction ID","Student Units"."Reg. Transacton ID");
                    // IF EResults.FIND('-') THEN BEGIN
                    // REPEAT
                    // BEGIN
                    //    EResults.VALIDATE(EResults.Score);
                    // EResults.CALCFIELDS(EResults.Stager);
                    // EResults.SETCURRENTKEY(EResults."Student No.",EResults.Programme,EResults.Stage,EResults.Unit,
                    // EResults.Semester,EResults.Exam,EResults."Reg. Transaction ID",EResults."Re-Sited",
                    //  EResults."Entry No");
                    //  IF EResults.Stage<>EResults.Stager THEN BEGIN
                    // EResults.Stage:=EResults.Stager;
                    //   EResults.RENAME(EResults."Student No.",EResults.Programme,EResults.Stager,EResults.Unit,
                    //  EResults.Semester,EResults.Exam,EResults."Reg. Transaction ID",EResults."Re-Sited",
                    //  EResults."Entry No");

                    // EResults.MODIFY;
                    // END;
                    // TotMarks:=TotMarks+EResults.Contribution;

                    // END;
                    // UNTIL EResults.NEXT=0;
                    // END;
                    // ERROR(FORMAT(TotMarks));
                    //CALCFIELDS("ACA-Student Units"."Total Score");

                    // "ACA-Student Units"."Final Score":="ACA-Student Units"."Total Score";
                    // "ACA-Student Units"."Total Marks":="ACA-Student Units"."Total Score";
                    // "ACA-Student Units".MODIFY;
                    // // // // // // //  TotMarks:="Aca-Special Exams Details"."Total Marks";

                    //CALCFIELDS("Student Units"."Credited Hours",
                    //"Student Units"."CATs Marks","Student Units"."EXAMs Marks");
                    //IF   "Student Units"."Credited Hours"<>0 THEN
                    // "Student Units"."Credit Hours":="Student Units"."Credited Hours";
                    //IF UnitsR.GET("Aca-Special Exams Details".Programme,"Aca-Special Exams Details".Stage,"ACA-Student Units".Unit) THEN //BEGIN
                    //"ACA-Student Units"."No. Of Units":=UnitsR."No. Units";
                    //"Student Units"."Unit Type":=UnitsR."Unit Type";
                    //END;
                    // // // // // // //  "Units/Subj".RESET;
                    // // // // // // //  "Units/Subj".SETRANGE("Units/Subj"."Programme Code","Aca-Special Exams Details".Programme);
                    // // // // // // //  "Units/Subj".SETRANGE("Units/Subj".Code,"Aca-Special Exams Details"."Unit Code");
                    // // // // // // //  "Units/Subj".SETRANGE("Units/Subj"."Stage Code","Aca-Special Exams Details".Stage);
                    // // // // // // //  IF "Units/Subj".FIND('-') THEN;
                    // "ACA-Student Units".Description:="Units/Subj".Desription;

                    // "ACA-Student Units".CALCFIELDS("ACA-Student Units"."Total Score");
                    //"Student Units".CALCFIELDS("Student Units"."Ignore in Final Average");
                    // "ACA-Student Units"."Ignore in Cumm  Average":="ACA-Student Units"."Ignore in Final Average";
                    // "ACA-Student Units".MODIFY;
                    // CLEAR(TotMarks);
                    // TotMarks:="Student Units"."Total Score";
                    // // // // // //  IF (GetGradeStatus(TotMarks,"ACA-Student Units".Programme,"ACA-Student Units".Unit)) OR
                    // // // // // //  ("ACA-Student Units"."Final Score"=0)  THEN BEGIN
                    // // // // // //  "ACA-Student Units"."Result Status":='FAIL';
                    // // // // // //  "ACA-Student Units".Failed:=TRUE;
                    // // // // // //  END ELSE BEGIN
                    // // // // // //  "ACA-Student Units"."Result Status":='PASS';
                    // // // // // //  END;
                    // // //  CLEAR(Gradeaqq2);
                    // // //  "ACA-Student Units".Grade:=GetGrade(
                    // // //  TotMarks,"ACA-Student Units".Programme,"ACA-Student Units".Unit);
                    // // //  "ACA-Student Units".Grade:=GetGrade("ACA-Student Units"."Total Score","ACA-Student Units".Programme,"ACA-Student Units".Unit);
                    // // //  Gradeaqq2:=GetGrade("ACA-Student Units"."Final Score","ACA-Student Units".Programme,"ACA-Student Units".Unit);
                    // // //  MODIFY;
                    // "Student Units"."GPA Points":=GetGPAPoints("Student Units"."Final Score","Student Units".Unit);
                    //"Student Units"."Unit Points":=((GetGPAPoints("Student Units"."Final Score","Student Units".Unit))*
                    //  ("Student Units"."Credit Hours"));


                    //"Student Units".SETCURRENTKEY(Programme,Stage,Unit,Semester,"Reg. Transacton ID","Student No.",ENo
                    //);
                    // "Student Units".RENAME(
                    //"Student Units".Programme,"Student Units".Stage,"Student Units".Unit,
                    //"Student Units".Semester,"Student Units"."Reg. Transacton ID","Student Units"."Student No.",
                    //"Student Units".ENo,
                    // GetGrade("Student Units"."Final Score",
                    // "Student Units".Unit),
                    //"Student Units"."Academic Year"
                    // );

                    //"Student Units".MODIFY;

                    // Update Supplimentary
                    // // // // // // IF "ACA-Student Units"."Register for"="ACA-Student Units"."Register for"::Supplimentary THEN BEGIN
                    // // // // // // StudUnits.RESET;
                    // // // // // // StudUnits.SETRANGE(StudUnits."Student No.","ACA-Student Units"."Student No.");
                    // // // // // // StudUnits.SETRANGE(StudUnits.Unit,"ACA-Student Units".Unit);
                    // // // // // // StudUnits.SETRANGE(StudUnits."Re-Take",FALSE);
                    // // // // // // StudUnits.SETRANGE(StudUnits."Supp Taken",FALSE);
                    // // // // // // IF StudUnits.FIND('-') THEN BEGIN
                    // // // // // // REPEAT
                    // // // // // // StudUnits."Supp Taken":=TRUE;
                    // // // // // // StudUnits.MODIFY;
                    // // // // // // UNTIL StudUnits.NEXT=0;
                    // // // // // // END;
                    // // // // // // END;

                    // // // // // // // // // EResults.RESET;
                    // // // // // // // // // EResults.SETRANGE(EResults."Student No.","ACA-Student Units"."Student No.");
                    // // // // // // // // // EResults.SETRANGE(EResults.Unit,"ACA-Student Units".Unit);
                    // // // // // // // // // EResults.SETRANGE(EResults.Programme,"ACA-Student Units".Programme);
                    // // // // // // // // // EResults.SETRANGE(EResults.Stage,"ACA-Student Units".Stage);
                    // // // // // // // // // EResults.SETRANGE(EResults.Semester,"ACA-Student Units".Semester);
                    // // // // // // // // // EResults.SETRANGE(EResults."Re-Take",FALSE);
                    // // // // // // // // // IF EResults.FIND('-') THEN BEGIN
                    // // // // // // // // // REPEAT
                    // // // // // // // // // EResults.CALCFIELDS(EResults."Re-Sit");
                    // // // // // // // // // EResults."Re-Sited":=EResults."Re-Sit";
                    // // // // // // // // // EResults.MODIFY;
                    // // // // // // // // // UNTIL EResults.NEXT=0;
                    // // // // // // // // // END;

                    "ACA-Student Units".RESET;
                    "ACA-Student Units".SETRANGE("ACA-Student Units"."Student No.", "Aca-Special Exams Details"."Student No.");
                    "ACA-Student Units".SETRANGE("ACA-Student Units".Semester, "Aca-Special Exams Details".Semester);
                    "ACA-Student Units".SETRANGE("ACA-Student Units".Unit, "Aca-Special Exams Details"."Unit Code");
                    IF "ACA-Student Units".FIND('-') THEN BEGIN
                        "ACA-Student Units"."Supp. Cons. Mark Pref." := '';
                        IF "ACA-Student Units"."Supp. Failed" = TRUE THEN
                            "ACA-Student Units"."Supp. Cons. Mark Pref." := '^';
                        // "ACA-Student Units".Failed :=TRUE;;
                        // // // // // // // "ACA-Student Units".CALCFIELDS("ACA-Student Units"."CATs Marks Exists","ACA-Student Units"."EXAMs Marks Exists");
                        // // // // // // // IF (("ACA-Student Units"."CATs Marks Exists"=FALSE) AND ("ACA-Student Units"."EXAMs Marks Exists"=FALSE)) THEN BEGIN
                        // // // // // // // "ACA-Student Units"."Consolidated Mark Pref." :='x';
                        // // // // // // //  END ELSE IF (("ACA-Student Units"."CATs Marks Exists"=TRUE) AND ("ACA-Student Units"."EXAMs Marks Exists"=FALSE)) THEN BEGIN
                        // // // // // // // "ACA-Student Units"."Consolidated Mark Pref." :='c';
                        // // // // // // //  END ELSE IF (("ACA-Student Units"."CATs Marks Exists"=FALSE) AND ("ACA-Student Units"."EXAMs Marks Exists"=TRUE)) THEN BEGIN
                        // // // // // // // "ACA-Student Units"."Consolidated Mark Pref." :='e';
                        // // // // // // //  END;
                        "ACA-Student Units".MODIFY;
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                // ExamProcess.UpdateCourseReg("Course Registration"."Student No.","Course Registration".Programme,"Course Registration".Stage,"Course Registration".Semester);
                CLEAR(sName);
                cust.RESET;
                cust.SETRANGE(cust."No.", "ACA-Course Registration"."Student No.");
                IF cust.FIND('-') THEN
                    sName := cust.Name;
            end;

            trigger OnPostDataItem()
            begin
                // ExamProcess.UpdateCourseReg("Course Registration"."Student No.","Course Registration".Programme,"Course Registration".Stage,"Course Registration".Semester);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        progress.CLOSE;
    end;

    trigger OnPreReport()
    begin
        progress.OPEN('Processing 6 of 7.\Computing Transcript Parameters..\This may take long depending on the class size.....' +
        '\No.: #1############################################\Prog.: #2############################################\Unit: #3############################################');
    end;

    var

        TotalCatMarks: Decimal;
        TotalCatContributions: Decimal;
        TotalMainExamContributions: Decimal;
        TotalExamMark: Decimal;
        FinalExamMark: Decimal;
        FinalCATMarks: Decimal;
        Gradez: Code[10];
        TotalMarks: Decimal;

        Gradeaqq2: Code[10];
        TotMarks: Decimal;
        sName: Code[250];
        cust: Record 18;
        progress: Dialog;

        stud_Units2: Record 61549;
}

