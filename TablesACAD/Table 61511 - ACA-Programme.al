table 61511 "ACA-Programme"
{
    DrillDownPageID = 68757;
    LookupPageID = 68757;

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[200])
        {
            NotBlank = true;
        }
        field(3; "Minimum Capacity"; Decimal)
        {
        }
        field(4; "Maximum Capacity"; Decimal)
        {
        }
        field(5; "Billing By"; Option)
        {
            OptionMembers = "By Stage",Subject,Both;
        }
        field(6; "Total Income"; Decimal)
        {
            Editable = false;
        }
        field(7; "Student Registered"; Integer)
        {
            Editable = false;
        }
        field(8; "Semester Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Semesters".Code;
        }
        field(9; Registered; Integer)
        {
            Editable = false;
        }
        field(10; Paid; Integer)
        {
            Editable = false;
        }
        field(11; "Registered Part Time"; Integer)
        {
            Editable = false;
        }
        field(12; "Paid Part Time"; Integer)
        {
            Editable = false;
        }
        field(13; "Registered Full Time"; Integer)
        {
            Editable = false;
        }
        field(14; "Paid Full Time"; Integer)
        {
            Editable = false;
        }
        field(15; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(16; "School Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            var
                DimVal: Record "Dimension Value";
            begin
                DimVal.Reset();
                DimVal.SetRange(DimVal.Code, "School Code");
                if DimVal.Find('-') then begin

                end;
            end;
        }

        field(17; Budget; Integer)
        {
        }
        field(18; "Full Time Budget"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(19; "Part Time Budget"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(20; Status; Option)
        {
            FieldClass = FlowFilter;
            OptionMembers = " ",Registration,Current,Alluminae,Dropped;
        }
        field(21; "Total Income (Rcpt)"; Decimal)
        {
        }
        field(22; "Total Billing"; Decimal)
        {
            Editable = false;
        }
        field(23; Priority; Option)
        {
            OptionCaption = '1,2';
            OptionMembers = "1","2";
        }
        field(24; "Stage Filter"; Code[100])
        {
            Caption = 'Year Filter';
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme Stages"."Programme Code";
        }
        field(25; Faculty; Code[20])
        {
            Caption = 'Faculty Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            begin
                Dimn.SetRange(Dimn.Code, Faculty);
                if Dimn.Find('-') then begin
                    "Faculty Name" := Dimn.Name;
                    "School Code" := Faculty;
                    Modify();
                end;
            end;
        }
        field(26; "Reg Prefix"; Code[20])
        {
        }
        field(27; "Mandatory Units"; Integer)
        {
        }
        field(28; "Base Date"; Date)
        {
        }
        field(29; "Grace Period"; DateFormula)
        {
        }
        field(30; "Student Type Filter"; Code[100])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Settlement Type".Code;
        }
        field(31; "Min No. of Courses"; Integer)
        {
        }
        field(32; "Max No. of Courses"; Integer)
        {
        }
        field(33; Category; Option)
        {
            Caption = 'Level Code';
            OptionCaption = ', ,Certificate,Diploma,Bachelor,Postgraduate Diploma,Masters,Professional,Postgraduate Diploma';
            OptionMembers = ,Certificate,Diploma,Undergraduate,Postgraduate,Professional,"Course List","Postgraduate Diploma";
        }
        field(34; "Unit Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Units/Subjects"."Programme Code" WHERE("Programme Code" = FIELD(Code),
                                                           "Stage Code" = FIELD("Stage Filter"));
        }
        field(35; "Min Pass Units"; Integer)
        {
        }
        field(36; "Time Table"; Boolean)
        {

            trigger OnValidate()
            begin
                Units.RESET;
                Units.SETRANGE(Units."Programme Code", Code);
                IF Units.FIND('-') THEN BEGIN
                    Units.MODIFYALL(Units."Time Table", "Time Table");

                END;
            end;
        }
        field(37; "Status Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = 'Registration,Current,Alluminae,Dropped Out,Differed,Suspended,Expulsion,Discontinued,Deferred,Deceased,Transferred';
            OptionMembers = Registration,Current,Alluminae,"Dropped Out",Differed,Suspended,Expulsion,Discontinued,Deferred,Deceased,Transferred;
        }
        field(38; "Date created"; Date)
        {
        }
        field(39; "No. Of Units Filter"; Integer)
        {
            FieldClass = FlowFilter;
        }
        field(40; "Graduation Units"; Integer)
        {
        }
        field(41; "Minimum Grade"; Code[20])
        {
            TableRelation = "ACA-Applic. Setup Grade".Code;

            trigger OnValidate()
            begin
                IF GradeSetup.GET("Minimum Grade") THEN BEGIN
                    "Minimum Points" := GradeSetup.Points
                END;
            end;
        }
        field(42; "Minimum Points"; Decimal)
        {
        }
        field(43; "Settlement Type Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Settlement Type".Code;
        }
        field(44; "Total Balance"; Decimal)
        {
        }
        field(45; "Campus Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(46; "Opening Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(47; "Department Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                Dimn.SetRange(Dimn.Code, "Department Code");
                if Dimn.Find('-') then begin
                    "Department Name" := Dimn.Name;
                end;
            end;
        }
        field(48; "Male Count"; Integer)
        {
        }
        field(49; "Female Count"; Integer)
        {
        }
        field(50; "Intake Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Intake".Code;
        }
        field(51; "Exam Category"; Code[20])
        {
            TableRelation = "ACA-Exam Category".Code;

            trigger OnValidate()
            begin
                ACAUnitsSubjects.RESET;
                ACAUnitsSubjects.SETRANGE(ACAUnitsSubjects."Programme Code", Code);
                IF ACAUnitsSubjects.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        IF ACAUnitsSubjects."Default Exam Category" <> '' THEN
                            ACAUnitsSubjects."Exam Category" := ACAUnitsSubjects."Default Exam Category"
                        ELSE
                            ACAUnitsSubjects."Exam Category" := "Exam Category";
                        // ACAUnitsSubjects.VALIDATE("Default Exam Category");
                        ACAUnitsSubjects.MODIFY;
                    END;
                    UNTIL ACAUnitsSubjects.NEXT = 0;
                END;
            end;
        }
        field(52; "Program Leader"; Code[20])
        {
            TableRelation = "Programme Leaders"."Programme Leader Staff ID";
            //"HRM-Employee C"."No." WHERE(Status = CONST(Active));

            trigger OnValidate()
            begin
                progLead.Reset;
                progLead.SetRange(progLead."Programme Code", Code);
                if progLead.Find('-') then begin
                    EmpFullName := progLead."Programme Leader Name";
                    "Employee Name" := EmpFullName;
                end;
            end;
        }
        field(53; "Employee Name"; Text[50])
        {
        }
        field(54; Levels; Option)
        {
            OptionMembers = " ",Certificate,Diploma;
        }
        field(96; "Exam Date"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(97; "Programme Units"; Integer)
        {
        }
        field(98; "Total JAB Female"; Integer)
        {
        }
        field(99; "Total JAB Male"; Integer)
        {
        }
        field(100; "Total SSP Female"; Integer)
        {
        }
        field(101; "Total SSP Male"; Integer)
        {
        }
        field(102; "Study Year Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Exam Results".Programmes;
        }
        field(103; "Norminal Registered"; Boolean)
        {
            FieldClass = FlowFilter;
        }
        field(104; "Tuition Fees"; Decimal)
        {
        }
        field(50000; "Campus Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('BUSINESS'));
        }
        field(50002; "Department Name"; Text[150])
        {
            Editable = false;
        }
        field(50004; "Common Units"; Integer)
        {
        }
        field(50005; "Core Units"; Integer)
        {
        }
        field(50006; Electives; Integer)
        {
        }
        field(50007; Department; Code[20])
        {
        }
        field(50008; "Unit Fee"; Decimal)
        {
        }
        field(50009; "Old Code"; Code[20])
        {
        }
        field(50010; "Special Programme"; Boolean)
        {
        }
        field(50011; "Tuition Exists"; Boolean)
        {
        }
        field(50012; "Admissions JAB"; Integer)
        {
        }
        field(50013; "Admissions SSP"; Integer)
        {
        }
        field(50014; "Admissions JAB Female"; Integer)
        {
        }
        field(50015; "Admissions JAB Male"; Integer)
        {
        }
        field(50016; "Admissions SSP Female"; Integer)
        {
        }
        field(50017; "Admissions SSP Male"; Integer)
        {
        }
        field(50018; Ecampus; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Main Campus"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Kisumu Campus"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Special Programme Class"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'General,Medicine & Nursing,Engineering';
            OptionMembers = General,"Medicine & Nursing",Engineering;

            trigger OnValidate()
            var
                ACAUnitsSubjects: Record "ACA-Units/Subjects";
            begin
                ACAUnitsSubjects.RESET;
                ACAUnitsSubjects.SETRANGE("Special Programme Class", xRec."Special Programme Class");
                ACAUnitsSubjects.SETRANGE(ACAUnitsSubjects."Programme Code", Rec.Code);
                IF ACAUnitsSubjects.FIND('-') THEN BEGIN
                    REPEAT
                        ACAUnitsSubjects."Special Programme Class" := Rec."Special Programme Class";
                        ACAUnitsSubjects.MODIFY;
                    UNTIL ACAUnitsSubjects.NEXT = 0;
                END;
            end;
        }
        field(50022; "Not Classified"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Show Options on Graduation"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Use Stage Semesters"; Boolean)
        {
            DataClassification = ToBeClassified;
        }//"Programme Leader Staff ID"
        field(50025; "Programme Leader Staff ID"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "Program Status"; Option)
        {
            OptionMembers = " ",Active,Decomissioned;
        }
        field(50027; "Faculty Name"; Text[100])
        {

        }
        field(50028; "Mode of Study"; code[20])
        {
            TableRelation = "ACA-Student Types".Code;
        }
        field(50029; "Iteration"; Option)
        {
            OptionMembers = " ",Yes,No;
        }
        field(50030; ApplicationFee; Decimal)
        {

        }
        field(50031; "Maximum No of Units"; Decimal)
        {

        }



    }

    keys
    {
        key(Key1; "Code")
        {
        }
        key(Key2; Faculty, "Code")
        {
        }
        key(Key3; Category)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        CReg.RESET;
        CReg.SETRANGE(CReg.Programmes, xRec.Code);
        IF CReg.FIND('-') THEN ERROR('Please note that you can not edit used Programme');
    end;

    trigger OnModify()
    begin
        IF xRec.Code <> Code THEN BEGIN
            CReg.RESET;
            CReg.SETRANGE(CReg.Programmes, Code);
            IF CReg.FIND('-') THEN ERROR('Please note that you can not edit used programme');
        END;
    end;

    var
        Units: Record "ACA-Units/Subjects";
        GradeSetup: Record "ACA-Applic. Setup Grade";
        CReg: Record "ACA-Course Registration";
        ACAUnitsSubjects: Record "ACA-Units/Subjects";
        HREmp: Record "HRM-Employee (D)";
        progLead: Record "Programme Leaders";
        EmpFullName: Text;
        Dimn: Record "Dimension Value";
        prog: Record "ACA-Programme";


    procedure ValidateFaculty()
    begin
        prog.Reset();
        prog.SetRange(Status, prog."Program Status"::Active);
        if prog.Find('-') then begin
            repeat
                prog."School Code" := prog.Faculty;
                prog.Modify();
            until prog.Next() = 0;
        end;
        Message('Complete');

    end;

}

