table 78002 "Aca-Special Exams Details"
{

    fields
    {
        field(1; "Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Semester; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Exam Session"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Exam Sessions Management"."Exam Session" WHERE(Category = FILTER("Special Exams"));
        }
        field(4; "Student No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." WHERE("Customer Posting Group" = FILTER('STUDENT'));
        }
        field(5; Stage; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Programme; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Unit Code"; Code[20])
        {
            TableRelation = "ACA-Units Master Table";
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                ACACourseRegistration: Record "ACA-Course Registration";
            begin
                IF GENGeneralSetUp.FIND('-') THEN BEGIN
                    IF GENGeneralSetUp."Special Exam Fee" <> 0 THEN "Cost Per Exam" := GENGeneralSetUp."Special Exam Fee";
                END;
                IF Catogory = Catogory::Supplementary THEN BEGIN
                    ACAAcademicYear.RESET;
                    ACAAcademicYear.SETRANGE(Current, TRUE);
                    IF ACAAcademicYear.FIND('-') THEN BEGIN
                        Rec."Current Academic Year" := ACAAcademicYear.Code;
                    END;
                    ACAStudentUnits.RESET;
                    ACAStudentUnits.SETRANGE(Unit, Rec."Unit Code");
                    ACAStudentUnits.SETRANGE("Student No.", Rec."Student No.");
                    IF ACAStudentUnits.FIND('+') THEN BEGIN
                        "Academic Year" := ACAStudentUnits."Academic Year";
                        Semester := ACAStudentUnits.Semester;
                        Stage := ACAStudentUnits.Stage;
                        Programme := ACAStudentUnits.Programme;
                        Catogory := Rec.Catogory::Supplementary;
                    END;// ELSE ERROR('The unit selected is not available for Supplementary');
                END;
                // Bill the student for the Unit
                // IF (Catogory <> Catogory::Special) THEN begin
                //     ACAGeneralSetUp.RESET;
                //     IF ACAGeneralSetUp.FIND('-') THEN BEGIN
                //         ACAGeneralSetUp.TESTFIELD("Special Exam Fee");
                //         ACAGeneralSetUp.TESTFIELD("Special Exam Code");
                //         ACAGeneralSetUp.TESTFIELD("Transaction Nos.");
                //         ACAStdCharges.RESET;
                //         ACAStdCharges.SETRANGE("Student No.", Rec."Student No.");
                //         ACAStdCharges.SETRANGE(Code, Rec."Unit Code");
                //         ACAStdCharges.SETRANGE(Semester, Rec.Semester);
                //         IF NOT (ACAStdCharges.FIND('-')) THEN BEGIN
                //             ACACourseRegistration.RESET;
                //             ACACourseRegistration.SETRANGE(Reversed, FALSE);
                //             ACACourseRegistration.SETRANGE("Student No.", Rec."Student No.");
                //             ACACourseRegistration.SetRange(Semester, 'JAN-APR23');
                //             IF ACACourseRegistration.FIND('+') THEN BEGIN
                //                 ACAStdCharges.INIT;
                //                 ACAStdCharges."Transacton ID" := NoSeriesManagement.GetNextNo(ACAGeneralSetUp."Transaction Nos.", TODAY, TRUE);
                //                 ACAStdCharges."Student No." := ACACourseRegistration."Student No.";
                //                 ACAStdCharges."Reg. Transacton ID" := ACACourseRegistration."Reg. Transacton ID";
                //                 ACAStdCharges.Programme := ACACourseRegistration.Programmes;
                //                 ACAStdCharges.Stage := ACACourseRegistration.Stage;
                //                 ACAStdCharges.Semester := ACACourseRegistration.Semester;
                //                 ACAStdCharges.Date := Today;
                //                 ACAStdCharges.Code := ACAGeneralSetUp."Special Exam Code";
                //                 ACAStdCharges."Transaction Type" := ACAStdCharges."Transaction Type"::"Special-Supp Fee";
                //                 ACAStdCharges.Amount := ACAGeneralSetUp."Special Exam Fee";
                //                 ACAStdCharges.INSERT;
                //                 ACAUnitsSubjects.RESET;
                //                 ACAUnitsSubjects.SETRANGE("Programme Code", Rec.Programme);
                //                 ACAUnitsSubjects.SETRANGE(Code, Rec."Unit Code");
                //                 IF ACAUnitsSubjects.FIND('-') THEN BEGIN
                //                     AcaSpecialExamsDetails.Reset();
                //                     AcaSpecialExamsDetails.SetRange("Unit Code", ACAUnitsSubjects.Code);
                //                     if AcaSpecialExamsDetails.Find('-') then begin
                //                         AcaSpecialExamsDetails."Charge Posted" := true;
                //                         AcaSpecialExamsDetails.Modify();
                //                     end;
                //                     ACAStdCharges.Description := 'Supplimentary' + ACAUnitsSubjects.Code + ':' + ACAUnitsSubjects.Desription;
                //                     ACAStdCharges.MODIFY;
                //                     //BillStudent(ACACourseRegistration, ACAUnitsSubjects);
                //                 END;
                //             END;
                //         END;


                //     END ELSE
                //         ERROR('General Setup does not exist!');
                end;


                //Rec.Modify();
            
        }
        field(8; "Unit Description"; Text[150])
        {
            CalcFormula = Lookup("ACA-Units Master Table"."Unit Name" WHERE("Unit Code" = FIELD("Unit Code")));
            FieldClass = FlowField;
        }
        field(10; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Approved,Rejected';
            OptionMembers = New,Approved,Rejected;
        }
        field(11; "CAT Marks"; Decimal)
        {
        }
        field(12; "Exam Marks"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Total Marks"; Decimal)
        {


        }
        field(14; Grade; Code[10])
        {
            CalcFormula = lookup("Final Exam Result2".MeanGrade where(StudentID = field("Student No."), UnitCode = field("Unit Code")));
            FieldClass = FlowField;
        }
        field(15; "Cost Per Exam"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; Catogory; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Special,Supplementary';
            OptionMembers = " ",Special,Supplementary;
        }
        field(17; "Current Academic Year"; Code[20])
        {
        }
        field(18; "Marks Exists"; Boolean)
        {
            CalcFormula = Exist("Aca-Special Exams Results" WHERE("Student No." = FIELD("Student No."),
                                                                   Unit = FIELD("Unit Code"),
                                                                   Semester = FIELD(Semester),
                                                                   Catogory = FILTER('Special')));
            FieldClass = FlowField;
        }
        field(19; "Charge Posted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Current Semester"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21; Campus; code[20])
        {
            CalcFormula = lookup(customer."Global Dimension 1 Code" where("No." = field("Student No.")));
            FieldClass = FlowField;

        }
        field(22; studentName; text[200])
        {
            CalcFormula = lookup(customer.Name where("No." = field("Student No.")));
            FieldClass = FlowField;
        }
        field(23; studyMode; Code[20])
        {
            CalcFormula = lookup("ACA-Course Registration"."Settlement Type" where("Student No." = field("Student No."), Semester = field("Current Semester")));
            FieldClass = FlowField;
        }
        field(24; billed; Boolean)
        {

        }
        field(25; "Total Marks2"; code[20])
        {

            CalcFormula = lookup("Final Exam Result2".MeanScore where(StudentID = field("Student No."), UnitCode = field("Unit Code")));
            FieldClass = FlowField;

        }
    }

    keys
    {
        key(Key1; "Academic Year", Semester, "Exam Session", "Student No.", Stage, Programme, "Unit Code", Catogory, "Current Academic Year", "Current Semester")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF Rec."Marks Exists" THEN ERROR('Marks posted. Deletion is not allowed!.');
    end;

    trigger OnInsert()
    begin
        ACAAcademicYear.RESET;
        ACAAcademicYear.SETRANGE(Current, TRUE);
        IF ACAAcademicYear.FIND('-') THEN BEGIN
            Rec."Current Academic Year" := ACAAcademicYear.Code;
        END;
    end;

    trigger OnModify()
    begin
        IF Rec."Marks Exists" THEN ERROR('Marks posted. Modification is not allowed!.');
    end;

    var
        GENGeneralSetUp: Record "ACA-General Set-Up";
        ACAAcademicYear: Record "ACA-Academic Year";
        ACAStudentUnits: Record "ACA-Student Units";
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

    local procedure BillStudent(CReg: Record "ACA-Course Registration"; ACAUnitsSubjects: Record "ACA-Units/Subjects")
    var
        GenJournalLine: Record "Gen. Journal Line";
        StudentCharges: Record "ACA-Std Charges";
        Sems: Record "ACA-Semesters";
        GenJnl: Record "Gen. Journal Line";
        DueDatez: Date;
        Customersz: Record "Customer";
        Charges: Record "ACA-Charge";
        ProgrammeSetUp: Record "ACA-Programme";
        LineNo: Integer;
    begin
        CLEAR(LineNo);
        LineNo := 100000;
        //Charge Student if not charged
        StudentCharges.RESET;
        StudentCharges.SETRANGE(StudentCharges."Student No.", "Student No.");
        StudentCharges.SETRANGE(StudentCharges.Posted, FALSE);
        StudentCharges.SETRANGE(StudentCharges."Transaction Type", StudentCharges."Transaction Type"::"Special-Supp Fee");
        IF StudentCharges.FIND('-') THEN BEGIN
            // GenJnl.RESET;
            // GenJnl.SETRANGE(GenJnl."Journal Template Name", 'SALES');
            // GenJnl.SETRANGE(GenJnl."Journal Batch Name", 'STUD PAY');
            //IF GenJnl.FIND('+') THEN LineNo := GenJnl."Line No.";//GenJnl.DELETE;

            REPEAT
                Charges.RESET;
                Charges.SETRANGE(Code, StudentCharges.Code);
                IF Charges.FIND('-') THEN;
                DueDatez := StudentCharges.Date;
                IF Sems.GET(StudentCharges.Semester) THEN BEGIN
                    IF Sems.From <> 0D THEN BEGIN
                        IF Sems.From > DueDatez THEN
                            DueDatez := Sems.From;
                    END;
                END;

                IF DueDatez = 0D THEN DueDatez := TODAY;//
                IF Charges."G/L Account" <> ' ' THEN
                    IF Customersz.GET("Student No.") THEN BEGIN

                        LineNo := LineNo + 1;
                        GenJnl.INIT;
                        GenJnl."Line No." := LineNo;
                        GenJnl."Posting Date" := StudentCharges.Date;
                        GenJnl."Document No." := StudentCharges."Transacton ID";
                        GenJnl.VALIDATE(GenJnl."Document No.");
                        GenJnl."Journal Template Name" := 'SALES';
                        GenJnl."Journal Batch Name" := 'STUD PAY';
                        GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                        //GenJnl.Description := 'Supp Billing for ' + ACAUnitsSubjects.Code + ': ' + ACAUnitsSubjects.Desription;
                        // IF Customersz."Bill-to Customer No." <> '' THEN
                        GenJnl."Account No." := Customersz."No.";
                        // ELSE
                        // GenJnl."Account No.":="Student No.";
                        //IF StudentCharges.Amount = 0 THEN StudentCharges.Amount := 200;
                        GenJnl.Amount := StudentCharges.Amount;
                        GenJnl.VALIDATE(GenJnl."Account No.");
                        GenJnl.VALIDATE(GenJnl.Amount);
                        GenJnl.Description := StudentCharges.Description;
                        GenJnl."Bal. Account Type" := GenJnl."Account Type"::"G/L Account";
                        GenJnl."Bal. Account No." := Charges."G/L Account";
                        GenJnl.VALIDATE(GenJnl."Bal. Account No.");

                        CReg.RESET;
                        CReg.SETRANGE(CReg."Student No.", "Student No.");
                        CReg.SETRANGE(CReg.Reversed, FALSE);
                        IF CReg.FIND('+') THEN BEGIN
                            IF ProgrammeSetUp.GET(CReg.Programmes) THEN BEGIN
                                ProgrammeSetUp.TESTFIELD(ProgrammeSetUp."Department Code");
                                //ProgrammeSetUp.TESTFIELD(Cust."Global Dimension 1 Code");
                                GenJnl."Shortcut Dimension 1 Code" := Customersz."Global Dimension 1 Code";
                                GenJnl."Shortcut Dimension 2 Code" := ProgrammeSetUp."Department Code";
                                GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
                                GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                            END;
                        END;

                        GenJnl."Due Date" := DueDatez;
                        GenJnl.VALIDATE(GenJnl."Due Date");
                        GenJnl.INSERT;
                        GenJnl.RESET;
                        GenJnl.SETRANGE("Journal Template Name", 'SALES');
                        GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                        IF GenJnl.FIND('-') THEN BEGIN
                            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post B", GenJnl);
                        END;
                    END;

                StudentCharges.Recognized := TRUE;
                StudentCharges.Posted := true;
                StudentCharges.MODIFY;


            UNTIL StudentCharges.NEXT = 0;


            //Message('Charge Posted');

        END
    end;
}

