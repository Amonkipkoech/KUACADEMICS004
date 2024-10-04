table 61553 "ACA-Std Units Exemptions"
{
    DrillDownPageID = 68779;
    LookupPageID = 68779;

    fields
    {
        field(2; "Student No."; Code[20])
        {
            Editable = false;
            NotBlank = true;
            TableRelation = Customer."No.";
        }
        field(3; Semester; Code[20])
        {
            Editable = true;
            NotBlank = true;
            TableRelation = "ACA-Programme Semesters".Semester WHERE("Programme Code" = FIELD(Programmes));
        }
        field(4; Programmes; Code[20])
        {
            Editable = true;
            NotBlank = true;
            TableRelation = "ACA-Programme".Code;
        }
        field(5; "Register for"; Option)
        {
            Editable = false;
            NotBlank = false;
            OptionCaption = 'Stage,Unit/Subject';
            OptionMembers = Stage,"Unit/Subject";
        }
        field(6; Stage; Code[20])
        {
            Editable = true;
            NotBlank = true;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD(Programmes));
        }
        field(7; Unit; Code[20])
        {
            Editable = true;
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD(Programmes),
                                                           "Stage Code" = FIELD(Stage));
        }
        field(8; "Programme Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme".Code;
        }
        field(9; "Stage Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD("Programme Filter"));
        }
        field(10; "Unit Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD("Programme Filter"),
                                                           "Stage Code" = FIELD("Stage Filter"));
        }
        field(11; "Semester Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme Semesters".Semester WHERE("Programme Code" = FIELD("Programme Filter"));
        }
        field(12; "Unit Type"; Option)
        {
            Editable = false;
            OptionCaption = 'Mandatory,Optional';
            OptionMembers = Mandatory,Optional;
        }
        field(13; Taken; Boolean)
        {
        }
        field(14; "Student Type Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = 'FULL TIME,PART TIME';
            OptionMembers = "FULL TIME","PART TIME";
            TableRelation = "ACA-Course Registration"."Student Type";
        }
        field(15; "Application Date"; Date)
        {
        }
        field(16; Status; Option)
        {
            OptionCaption = 'Being Processed,Approved,Rejected,Canceled';
            OptionMembers = "Being Processed",Approved,Rejected,Canceled;

            trigger OnValidate()
            begin
                "Approval Date" := TODAY;
                IF Status = Status::Approved THEN BEGIN
                    CourseReg.RESET;
                    CourseReg.SETRANGE(CourseReg."Student No.", "Student No.");
                    IF CourseReg.FIND('+') THEN BEGIN
                        CourseReg.CALCFIELDS(CourseReg."Units Taken");

                        FeeStruc.RESET;
                        FeeStruc.SETRANGE(FeeStruc."Programme Code", Programmes);
                        FeeStruc.SETRANGE(FeeStruc."Stage Code", Stage);
                        FeeStruc.SETRANGE(FeeStruc.Semester, Semester);
                        FeeStruc.SETRANGE(FeeStruc."Student Type", CourseReg."Student Type");
                        IF FeeStruc.FIND('-') THEN BEGIN
                            FeeStruc.CALCFIELDS(FeeStruc."No Of Units");
                            MESSAGE('%1', FeeStruc."Break Down");
                            MESSAGE('%1', FeeStruc."No Of Units");
                            ExFee := (FeeStruc."Break Down" / FeeStruc."No Of Units") * 1 / 3;
                            //Reduce fee for current units
                            StudUnits.RESET;
                            StudUnits.SETRANGE(StudUnits.Unit, Unit);
                            IF StudUnits.FIND('-') THEN BEGIN
                                StudentCharges.RESET;
                                StudentCharges.SETRANGE(StudentCharges."Reg. Transacton ID", CourseReg."Reg. Transacton ID");
                                StudentCharges.SETRANGE(StudentCharges."Tuition Fee", TRUE);
                                IF StudentCharges.FIND('-') THEN BEGIN
                                    StudentCharges.Amount := StudentCharges.Amount - (FeeStruc."Break Down" / FeeStruc."No Of Units");
                                    StudentCharges.MODIFY;
                                END;

                            END;
                        END;

                        StudentCharges.INIT;
                        StudentCharges.Programme := CourseReg.Programmes;
                        StudentCharges.Stage := CourseReg.Stage;
                        StudentCharges.Semester := CourseReg.Semester;
                        StudentCharges."Student No." := "Student No.";
                        StudentCharges."Reg. Transacton ID" := CourseReg."Reg. Transacton ID";
                        StudentCharges.Date := TODAY;
                        StudentCharges.Code := 'EXEMPT';
                        StudentCharges.VALIDATE(StudentCharges.Code);
                        StudentCharges.Description := StudentCharges.Description + ' - ' + Unit;
                        StudentCharges."Recovered First" := TRUE;
                        StudentCharges."Recovery Priority" := 19;
                        StudentCharges.Charge := TRUE;
                        StudentCharges.Amount := ExFee;
                        StudentCharges."Transacton ID" := '';
                        StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                        StudentCharges.INSERT;

                    END;

                END;
            end;
        }
        field(17; "Approval Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; Programmes, Stage, Unit, Semester, "Student No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        FeeByStage: Record "ACA-Fee By stage";
        FeeByUnit: Record "ACA-Fee By Unit";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenSetup: Record "ACA-General Set-Up";
        StudentCharges: Record "ACA-Std Charges";
        TotalCost: Decimal;
        StageCharges: Record "ACA-Stage Charges";
        NewStudentCharges: Record "ACA-New Student Charges";
        RecFound: Boolean;
        CoursePrerequisite: Record "ACA-Course Prerequisite";
        SPrereq: Record "ACA-Std Prerequisite Approval";
        Stages: Record "ACA-Programme Stages";
        CourseReg: Record "ACA-Course Registration";
        ExFee: Decimal;
        StudUnits: Record "ACA-Student Units";
        FeeStruc: Record "ACA-Fee By Stage";
}

