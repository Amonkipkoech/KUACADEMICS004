table 78003 "Aca-Special Exams Results"
{

    fields
    {
        field(1; Programmes; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "ACA-Programme".Code;
        }
        field(2; Stage; Code[50])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD(Programmes));
        }
        field(3; Unit; Code[50])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "ACA-Units/Subjects".Code;

            trigger OnValidate()
            var
                ACACourseRegistration: Record "ACA-Course Registration";
            begin
            end;
        }
        field(4; Semester; Code[50])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "ACA-Semesters";
        }
        field(5; Score; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            NotBlank = true;

            trigger OnValidate()
            var
                AcaSpecialExamsDetails: Record "Aca-Special Exams Details";
            begin
                // update trans_Reg
                stud_Units.RESET;
                stud_Units.SETRANGE("Student No.", Rec."Student No.");
                stud_Units.SETRANGE(Unit, Rec.Unit);
                stud_Units.SETRANGE("Reg Reversed", FALSE);
                IF stud_Units.FIND('-') THEN BEGIN
                    Course_Reg.RESET;
                    Course_Reg.SETRANGE(Course_Reg."Student No.", stud_Units."Student No.");
                    Course_Reg.SETRANGE(Course_Reg.Programmes, stud_Units.Programme);
                    Course_Reg.SETRANGE(Course_Reg.Semester, stud_Units.Semester);
                    //Course_Reg.SETRANGE(Course_Reg."Academic Year","Academic Year");
                    Course_Reg.SETRANGE(Course_Reg.Stage, stud_Units.Stage);
                    IF Course_Reg.FIND('-') THEN BEGIN

                    END;
                END;

                prog.RESET;
                prog.SETRANGE(Code, Programmes);
                IF NOT prog.FIND('-') THEN ERROR('Invalid Program!');
                ACAUnitsSubjects.RESET;
                ACAUnitsSubjects.SETRANGE(Code, Rec.Unit);
                ACAUnitsSubjects.SETRANGE("Programme Code", Rec.Programmes);
                IF ACAUnitsSubjects.FIND('-') THEN BEGIN
                END;

                IF prog."Exam Category" = '' THEN
                    IF ACAUnitsSubjects."Default Exam Category" = '' THEN ERROR('Exam category is missing on the program!');
                SExams.RESET;
                SExams.SETFILTER(SExams.Code, 'EXAM|FINAL EXAM');
                IF ACAUnitsSubjects."Default Exam Category" <> '' THEN
                    SExams.SETRANGE(Category, ACAUnitsSubjects."Default Exam Category")
                ELSE
                    SExams.SETRANGE(Category, prog."Exam Category");
                IF SExams.FIND('-') THEN BEGIN

                    IF Score > SExams."Max. Score" THEN
                        ERROR('Score can not be greater than the maximum score.');
                    IF Score > 0 THEN BEGIN
                        Percentage := (Score / SExams."Max. Score") * 100;
                        //Contribution:=Percentage*(SExams."% Contrib. Final Score"/100);
                        Contribution := Score;
                        Gradings.RESET;
                        prog.RESET;
                        IF prog.GET(Programmes) THEN;
                        IF prog."Exam Category" = '' THEN BEGIN
                            IF ACAUnitsSubjects."Default Exam Category" = '' THEN
                                Gradings.SETRANGE(Gradings.Category, 'DEFAULT') ELSE
                                Gradings.SETRANGE(Gradings.Category, ACAUnitsSubjects."Default Exam Category");
                        END
                        ELSE BEGIN
                            IF ACAUnitsSubjects."Default Exam Category" <> '' THEN
                                Gradings.SETRANGE(Gradings.Category, ACAUnitsSubjects."Default Exam Category") ELSE
                                Gradings.SETRANGE(Gradings.Category, prog."Exam Category");
                        END;
                        Gradings.SETFILTER("Lower Limit", '=%1|<%2', Score, Score);
                        Gradings.SETFILTER("Upper Limit", '=%1|>%2', Score, Score);
                        LastGrade := '';
                        LastScore := 0;
                        IF Gradings.FIND('-') THEN BEGIN
                            Grade := Gradings.Grade;

                        END;


                    END ELSE BEGIN
                        Percentage := 0;
                        Contribution := 0;
                        Grade := '';
                    END;

                END;

                //
                // Course_Reg.RESET;
                // Course_Reg.SETRANGE(Course_Reg."Student No.",stud_Units."Student No.");
                // Course_Reg.SETRANGE(Course_Reg.Programme,stud_Units.Programme);
                // Course_Reg.SETRANGE(Course_Reg.Semester,stud_Units.Semester);
                // //Course_Reg.SETRANGE(Course_Reg."Academic Year","Academic Year");
                // Course_Reg.SETRANGE(Course_Reg.Stage,stud_Units.Stage);
                // IF Course_Reg.FIND('-') THEN BEGIN

                AcaSpecialExamsDetails.RESET;
                AcaSpecialExamsDetails.SETRANGE(AcaSpecialExamsDetails."Student No.", Rec."Student No.");
                AcaSpecialExamsDetails.SETRANGE(AcaSpecialExamsDetails."Current Academic Year", Rec."Current Academic Year");
                AcaSpecialExamsDetails.SETRANGE(AcaSpecialExamsDetails."Unit Code", Rec.Unit);
                //AcaSpecialExamsDetails.SETRANGE(AcaSpecialExamsDetails.Semester,Semester);
                //AcaSpecialExamsDetails.SETRANGE(AcaSpecialExamsDetails."Student No.","Student No.");
                IF AcaSpecialExamsDetails.FIND('-') THEN BEGIN
                    stud_Units.CALCFIELDS(stud_Units."CATs Marks");
                    IF AcaSpecialExamsDetails.Catogory = AcaSpecialExamsDetails.Catogory::Special THEN BEGIN
                        AcaSpecialExamsDetails."CAT Marks" := stud_Units."CATs Marks";
                        AcaSpecialExamsDetails."Exam Marks" := Contribution + stud_Units."CATs Marks";
                        AcaSpecialExamsDetails."Total Marks" := Contribution + stud_Units."CATs Marks";
                        AcaSpecialExamsDetails.Grade := GetGrade(0, stud_Units."CATs Marks", Contribution, Rec.Programmes);
                        // stud_Units."Old Unit":=GetGrade(stud_Units."CAT-1",stud_Units."CAT-2",stud_Units."EXAMs Marks",Course_Reg.Programme);
                        // stud_Units."Academic Year":="Academic Year";
                        AcaSpecialExamsDetails.MODIFY;
                    END ELSE
                        IF AcaSpecialExamsDetails.Catogory = AcaSpecialExamsDetails.Catogory::Supplementary THEN BEGIN
                            AcaSpecialExamsDetails."CAT Marks" := stud_Units."CATs Marks";
                            IF prog."Exam Category" = 'NURSING' THEN BEGIN
                                IF ((Contribution > 50) OR (Contribution = 50)) THEN BEGIN
                                    AcaSpecialExamsDetails."Total Marks" := 50;
                                END ELSE BEGIN
                                    AcaSpecialExamsDetails."Total Marks" := Contribution;//;
                                END;
                            END ELSE BEGIN
                                IF ((Contribution > 40) OR (Contribution = 40)) THEN BEGIN
                                    AcaSpecialExamsDetails."Total Marks" := 40;
                                END ELSE BEGIN
                                    AcaSpecialExamsDetails."Total Marks" := Contribution;//;
                                END;
                            END;
                            AcaSpecialExamsDetails."Exam Marks" := Contribution;
                            AcaSpecialExamsDetails.Grade := GetGrade(0, 0, AcaSpecialExamsDetails."Total Marks", Rec.Programmes);
                            // stud_Units."Old Unit":=GetGrade(stud_Units."CAT-1",stud_Units."CAT-2",stud_Units."EXAMs Marks",Course_Reg.Programme);
                            // stud_Units."Academic Year":="Academic Year";
                            AcaSpecialExamsDetails.MODIFY;
                        END;

                    // END;
                END;
                ////////////////////////////// Update Special Exam Tables

                AcaSpecialExamsDetails.RESET;
                AcaSpecialExamsDetails.SETRANGE(AcaSpecialExamsDetails."Student No.", Rec."Student No.");
                AcaSpecialExamsDetails.SETRANGE(AcaSpecialExamsDetails."Current Academic Year", Rec."Current Academic Year");
                AcaSpecialExamsDetails.SETRANGE(AcaSpecialExamsDetails."Unit Code", Rec.Unit);
                IF AcaSpecialExamsDetails.FIND('-') THEN BEGIN
                    Course_Reg2.RESET;
                    Course_Reg2.SETRANGE(Course_Reg2."Student No.", "Student No.");
                    Course_Reg2.SETRANGE(Course_Reg2.Programmes, Programmes);
                    Course_Reg2.SETRANGE(Course_Reg2.Semester, Semester);
                    Course_Reg2.SETRANGE(Course_Reg2.Stage, Stage);
                    IF Course_Reg2.FIND('-') THEN BEGIN

                        stud_Units2.RESET;
                        stud_Units2.SETRANGE(stud_Units2.Programme, stud_Units.Programme);
                        stud_Units2.SETRANGE(stud_Units2.Stage, stud_Units.Stage);
                        stud_Units2.SETRANGE(stud_Units2.Unit, stud_Units.Unit);
                        stud_Units2.SETRANGE(stud_Units2.Semester, stud_Units.Semester);
                        stud_Units2.SETRANGE(stud_Units2."Student No.", stud_Units."Student No.");
                        stud_Units2.SETRANGE(stud_Units2.Reversed, FALSE);
                        IF stud_Units2.FIND('-') THEN BEGIN
                            stud_Units2."Supp. Exam Marks" := Contribution;
                            stud_Units2."Supp. Academic Year" := AcaSpecialExamsDetails."Current Academic Year";
                            stud_Units2."Supp. Exam Score" := Contribution;
                            stud_Units2."Supp. Final Score" := AcaSpecialExamsDetails."Total Marks";
                            stud_Units2."Supp. Total Score" := AcaSpecialExamsDetails."Total Marks";
                            stud_Units2."Supp. Total Marks" := AcaSpecialExamsDetails."Total Marks";
                            stud_Units2."Supp. Grade" := GetGrade(0, 0, AcaSpecialExamsDetails."Total Marks", AcaSpecialExamsDetails.Programme);
                            stud_Units2.MODIFY;
                        END;

                    END;
                END;
            end;
        }
        field(6; Exam; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Reg. Transaction ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Student No."; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = Customer."No." WHERE("Customer Posting Group" = FILTER('STUDENT'));
        }
        field(9; Grade; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Grading System".Grade WHERE("Programme Code" = FIELD(Programmes));
        }
        field(10; Percentage; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Contribution; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; "Exam Category"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(19; ExamType; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Admission No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(22; Reported; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Lecturer Names"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(24; UserID; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Academic Year"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Academic Year".Code;
        }
        field(50019; "Exam Session"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Exam Sessions Management"."Exam Session" WHERE(Category = FILTER("Special Exams"));
        }
        field(50020; Catogory; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Special,Supplementary';
            OptionMembers = " ",Special,Supplementary;
        }
        field(50021; "Current Academic Year"; Code[20])
        {
        }
        field(50022; "Capture Date"; Date)
        {
        }
        field(50023; "Modified Date"; Date)
        {
        }
        field(50024; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Programmes, Stage, Unit, Semester, "Student No.", "Academic Year")
        {
        }
    }

    fieldgroups
    {
    }

    var
        SExams: Record "ACA-Exams Setup";
        Gradings: Record "ACA-Exam Gradding Setup";
        LastGrade: Code[20];
        LastScore: Decimal;
        ExitDo: Boolean;
        Gradings2: Record "ACA-Exam Gradding Setup";
        EResults: Record "ACA-Exam Results";
        Exams: Record "ACA-Exams Setup";
        Course_Reg: Record "ACA-Course Registration";
        stud_Units: Record "ACA-Student Units";
        prog: Record "ACA-Programme";
        Course_Reg2: Record "ACA-Course Registration";
        stud_Units2: Record "ACA-Student Units";
        ACAGeneralSetUp: Record "ACA-General Set-Up";
        ACAUnitsSubjects: Record "ACA-Units/Subjects";
        ACAStdCharges: Record "ACA-Std Charges";
        ACACharge: Record "ACA-Charge";
        AcaSpecialExamsDetails: Record "Aca-Special Exams Details";
        NoSeriesManagement: Codeunit 396;

    procedure GetGrade(CAT1: Decimal; CAT2: Decimal; FinalM: Decimal; progz: Code[100]) xGrade: Text[100]
    var
        UnitsRR: Record "ACA-Units/Subjects";
        ProgrammeRec: Record "ACA-Programme";
        LastGrade: Code[20];
        LastRemark: Code[20];
        ExitDo: Boolean;
        LastScore: Decimal;
        Gradings: Record "ACA-Exam Gradding Setup";
        Gradings2: Record "ACA-Exam Gradding Setup";
        GLabel: array[6] of Code[20];
        i: Integer;
        GLabel2: array[6] of Code[100];
        FStatus: Boolean;
        Grd: Code[80];
        Grade: Code[20];
        GradeCategory: Code[50];
        Marks: Decimal;
    begin
        GradeCategory := '';
        CLEAR(Marks);
        Gradings.RESET;
        Marks := CAT1 + CAT2 + FinalM;
        ProgrammeRec.RESET;
        IF ProgrammeRec.GET(progz) THEN
            GradeCategory := ProgrammeRec."Exam Category";
        IF GradeCategory = '' THEN GradeCategory := 'DEFAULT';
        xGrade := '';
        IF Marks > 0 THEN BEGIN
            IF GradeCategory = '' THEN
                Gradings.SETRANGE(Gradings.Category, 'DEFAULT')
            ELSE
                Gradings.SETRANGE(Gradings.Category, ProgrammeRec."Exam Category");
            Gradings.SETFILTER("Lower Limit", '=%1|<%2', Marks, Marks);
            Gradings.SETFILTER("Upper Limit", '=%1|>%2', Marks, Marks);
            //LastGrade:='';
            //LastScore:=0;
            IF Gradings.FIND('-') THEN BEGIN
                xGrade := Gradings.Grade;

            END;

            // // Marks:=CAT1+CAT2+FinalM;
            // // Gradings.RESET;
            // // Gradings.SETRANGE(Gradings.Category,GradeCategory);
            // // LastGrade:='';
            // // LastRemark:='';
            // // LastScore:=0;
            // // IF Gradings.FIND('-') THEN BEGIN
            // // ExitDo:=FALSE;
            // // REPEAT
            // // LastScore:=Gradings."Up to";
            // // IF Marks < LastScore THEN BEGIN
            // // IF ExitDo = FALSE THEN BEGIN
            // // xGrade:=Gradings.Grade;
            // // IF Gradings.Failed=FALSE THEN
            // // LastRemark:='PASS'
            // // ELSE
            // // LastRemark:='FAIL';
            // // ExitDo:=TRUE;
            // // END;
            // // END;
            // //
            // // UNTIL Gradings.NEXT = 0;
            // //
            // //
            // // END;

        END ELSE BEGIN
            xGrade := '';
            //Remarks:='Not Done';
        END;
        /*
        IF ((CAT1=0) AND (CAT2=0) AND (FinalM=0)) THEN xGrade:='?' ELSE
        //IF ((CAT1=0) OR (CAT2=0) OR (FinalM=0)) THEN xGrade:='!'
        */

    end;
}

