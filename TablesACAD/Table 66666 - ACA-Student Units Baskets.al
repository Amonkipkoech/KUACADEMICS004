table 66666 "ACA-Student Units Baskets"
{
    DrillDownPageID = 68779;
    LookupPageID = 68779;

    fields
    {
        field(1; "Reg. Transacton ID"; Code[20])
        {
            Editable = true;
        }
        field(2; "Student No."; Code[20])
        {
            Editable = true;
            NotBlank = true;
        }
        field(3; Semester; Code[20])
        {
            Editable = true;
            NotBlank = false;
        }
        field(4; Programmes; Code[20])
        {
            Editable = true;
            NotBlank = false;
        }
        field(5; "Register for"; Option)
        {
            Editable = false;
            NotBlank = false;
            OptionCaption = 'Stage,Unit/Subject,Supplimentary,Special';
            OptionMembers = Stage,"Unit/Subject",Supplimentary,Special;
        }
        field(6; Stage; Code[20])
        {
            Editable = true;
            NotBlank = false;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD(Programmes));
        }
        field(7; Unit; Code[20])
        {
            Editable = true;
            NotBlank = false;
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
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD(Programmes),
                                                           "Stage Code" = FIELD(Stage));
            ValidateTableRelation = false;
        }
        field(11; "Semester Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme Semesters".Semester WHERE("Programme Code" = FIELD("Programme Filter"));
        }
        field(12; "Unit Type"; Option)
        {
            Editable = false;
            OptionCaption = 'Core,Elective,Required';
            OptionMembers = Core,Elective,Required;
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
        field(15; "Category Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Exam Category".Code;
        }
        field(16; UnitCount; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE(Programme = FIELD(Programmes),
                                                           Stage = FIELD(Stage),
                                                           Semester = FIELD(Semester),
                                                           Unit = FIELD(Unit)));
            FieldClass = FlowField;
        }
        field(17; "Total Score"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Results".Contribution WHERE("Student No." = FIELD("Student No."),
                                                                     Programmes = FIELD(Programmes),
                                                                     Semester = FIELD(Semester),
                                                                     Unit = FIELD(Unit),
                                                                     Semester = FIELD(Semester),
                                                                     Cancelled = CONST(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; Exempted; Boolean)
        {
        }
        field(19; Attendance; Decimal)
        {
        }
        field(20; "Allow Supplementary"; Boolean)
        {
        }
        field(21; "Sat Supplementary"; Boolean)
        {
        }
        field(22; "Repeat Unit"; Boolean)
        {
        }
        field(50; Remarks; Text[200])
        {
        }
        field(51; "Unit Stage"; Code[20])
        {
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD(Programmes));
        }
        field(52; Failed; Boolean)
        {
        }
        field(55; "Course Type"; Option)
        {
            OptionCaption = 'Core,Elective,Required';
            OptionMembers = Core,Elective,Required;
        }
        field(56; Audit; Boolean)
        {
        }
        field(57; Status; Option)
        {
            OptionCaption = ' ,Intent,Submitted,Dispatch B.O.E,B.O.E Report,Schedule Defence,Defence,Cert. of Corr.,Binding,SGS Board Approval,Senate Approval';
            OptionMembers = " ",Intent,Submitted,"Dispatch B.O.E","B.O.E Report","Schedule Defence",Defence,"Cert. of Corr.",Binding,"SGS Board Approval","Senate Approval";
        }
        field(58; "Details Count"; Integer)
        {
            CalcFormula = Count("ACA-Post Grad Change History" WHERE("Student No" = FIELD("Student No."),
                                                                      "Programme Code" = FIELD(Programmes),
                                                                      "Stage Code" = FIELD(Stage),
                                                                      Code = FIELD(Unit)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(59; "No. Of Units"; Decimal)
        {
        }
        field(60; "Project Status"; Option)
        {
            OptionCaption = '  ,Proposal,Faculty/School Approval,Research,Exam';
            OptionMembers = "  ",Proposal,"Faculty/School Approval",Research,Exam;
        }
        field(61; "Final Score"; Decimal)
        {
            FieldClass = Normal;
        }
        field(62; "Created by"; Code[50])
        {
        }
        field(63; "Edited By"; Code[50])
        {
        }
        field(64; "Date created"; Date)
        {
        }
        field(65; "Date Edited"; Date)
        {
        }
        field(66; "Cummulative Year Filter"; Code[20])
        {
            Caption = 'Cummulative Year Filter';
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD("Programme Filter"));
        }
        field(67; "Total Marks"; Decimal)
        {
        }
        field(68; "External Unit"; Boolean)
        {
            FieldClass = FlowFilter;
        }
        field(69; "External Units"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = ' ,External';
            OptionMembers = " ",External;
        }
        field(70; "System Created"; Boolean)
        {
        }
        field(71; Multiple; Boolean)
        {
        }
        field(72; "Entry No."; Integer)
        {
        }
        field(73; "Student Class"; Code[20])
        {
            TableRelation = "ACA-Units Classes".Code WHERE(Programmes = FIELD(Programmes),
                                                            Stage = FIELD(Stage),
                                                            Code = FIELD(Unit));
        }
        field(74; ENo; Integer)
        {
        }
        field(75; "System Taken"; Boolean)
        {
        }
        field(76; "Repeat Marks"; Decimal)
        {
        }
        field(77; "Re-Take"; Boolean)
        {
        }
        field(78; "Proposal Status"; Option)
        {
            OptionCaption = ' ,SGS Board Approval,Senate Approval,SGS Research Refund';
            OptionMembers = " ","SGS Board Approval","Senate Approval","SGS Research Refund";
        }
        field(79; "Proposal Date"; Date)
        {
        }
        field(80; "Senate-Proposal"; Date)
        {
        }
        field(81; Research; Date)
        {
        }
        field(82; "Senate-Research"; Date)
        {
        }
        field(83; Examiners; Date)
        {
        }
        field(84; Defense; Date)
        {
        }
        field(85; "Category Code"; Code[20])
        {
            FieldClass = Normal;
            TableRelation = "ACA-Exam Category".Code;
        }
        field(86; "Progress Report"; Option)
        {
            OptionCaption = ' ,1st Progress,2nd Progress,3rd Progress,4th Progress';
            OptionMembers = " ","1st Progress","2nd Progress","3rd Progress","4th Progress";
        }
        field(87; "Progress Date"; Date)
        {
        }
        field(88; "Defence OutCome"; Option)
        {
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
        }
        field(89; Description; Text[250])
        {
        }
        field(90; "Student Type"; Option)
        {
            OptionCaption = 'Full Time,Part Time,Distance Learning';
            OptionMembers = "Full Time","Part Time","Distance Learning";
        }
        field(94; "Main Programme"; Code[20])
        {
            CalcFormula = Lookup("ACA-Course Registration".Programmes WHERE("Student No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(95; "Registered Programe"; Code[20])
        {
            CalcFormula = Lookup("ACA-Course Registration".Programmes WHERE("Student No." = FIELD("Student No."),
                                                                            Semester = FIELD(Semester),
                                                                            Programmes = FILTER(<> '')));
            FieldClass = FlowField;
        }
        field(96; "Semester Registered"; Boolean)
        {
            CalcFormula = Lookup("ACA-Course Registration".Registered WHERE("Student No." = FIELD("Student No."),
                                                                             Semester = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(20015; "Marks Status"; Option)
        {
            OptionCaption = ' ,Y,S,I,F,NDP';
            OptionMembers = " ",Y,S,I,F,NDP;
        }
        field(20016; "Student Name"; Text[100])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(20023; "CAT-1"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Results".Contribution WHERE(Exam = FILTER('CAT|CAT1|CAT 1'),
                                                                     Programmes = FIELD(Programmes),
                                                                     "Student No." = FIELD("Student No."),
                                                                     Unit = FIELD(Unit),
                                                                     Semester = FIELD(Semester),
                                                                     ExamType = FILTER('CAT|CAT1|CAT 1')));
            FieldClass = FlowField;
        }
        field(20024; "CAT-2"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Results".Contribution WHERE(Exam = FILTER('CAT|CAT2|CAT 2'),
                                                                     Programmes = FIELD(Programmes),
                                                                     "Student No." = FIELD("Student No."),
                                                                     Unit = FIELD(Unit),
                                                                     Semester = FIELD(Semester),
                                                                     ExamType = FILTER('CAT|CAT2|CAT 2')));
            FieldClass = FlowField;
        }
        field(20025; "Result Status"; Code[50])
        {
        }
        field(20026; "Registration Status"; Option)
        {
            CalcFormula = Lookup("ACA-Course Registration"."Registration Status" WHERE("Student No." = FIELD("Student No."),
                                                                                        Programmes = FIELD(Programmes),
                                                                                        Stage = FIELD(Stage),
                                                                                        Semester = FIELD(Semester)));
            FieldClass = FlowField;
            OptionCaption = ' ,Specials,Academic Leave,WithHold,Deregister,Discontinue,Nullification';
            OptionMembers = " ",Specials,"Academic Leave",WithHold,Deregister,Discontinue,Nullification;
        }
        field(20027; "Ass Total Marks"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Results".Contribution WHERE(Exam = CONST('ASSIGNMENT'),
                                                                     Programmes = FIELD(Programmes),
                                                                     "Student No." = FIELD("Student No."),
                                                                     Unit = FIELD(Unit),
                                                                     Semester = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(20028; "CAT Total Marks"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Results".Contribution WHERE(Exam = FILTER('CAT|CATS'),
                                                                     Programmes = FIELD(Programmes),
                                                                     "Student No." = FIELD("Student No."),
                                                                     Unit = FIELD(Unit),
                                                                     Semester = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(20029; "Exam Marks"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Results".Contribution WHERE(Exam = FILTER('EXAM'),
                                                                     Programmes = FIELD(Programmes),
                                                                     "Student No." = FIELD("Student No."),
                                                                     Unit = FIELD(Unit),
                                                                     Semester = FIELD(Semester),
                                                                     Cancelled = CONST(false)));
            FieldClass = FlowField;
        }
        field(20030; Category; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Exams Setup".Category;
        }
        field(20031; "Exam Type"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Exams Setup".Code;
        }
        field(20032; "Exam Period"; Code[20])
        {
            TableRelation = "ACA-Exam Periods".Code;
        }
        field(20033; "Exam Status"; Option)
        {
            OptionCaption = 'Lecturer,Faculty,Moderators';
            OptionMembers = Lecturer,Faculty,Moderators;
        }
        field(20034; "Staff Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "HRM-Employee (D)"."No." WHERE(Lecturer = CONST(true));
        }
        field(20035; Lecturer; Code[30])
        {
            CalcFormula = Lookup("ACA-Lecturers Units - Old".Lecturer WHERE(Programme = FIELD(Programmes),
                                                                             Stage = FIELD(Stage),
                                                                             Unit = FIELD(Unit),
                                                                             Semester = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(20036; Grade; Code[50])
        {
        }
        field(20037; "Supp Taken"; Boolean)
        {
        }
        field(20038; "Failed Units Count"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Unit = FIELD(Unit),
                                                           Failed = CONST(true)));
            FieldClass = FlowField;
        }
        field(20039; "Unit Reg Count"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Unit = FIELD(Unit)));
            FieldClass = FlowField;
        }
        field(20040; "Exam Period Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Exam Periods".Code;
        }
        field(20041; "Unit Fees"; Decimal)
        {
            CalcFormula = Lookup("ACA-Fee By Stage"."Break Down" WHERE("Programme Code" = FIELD(Programmes),
                                                                        "Stage Code" = FIELD(Stage),
                                                                        Semester = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(20042; "Actual Fees"; Decimal)
        {
        }
        field(20043; "Reg Reversed"; Boolean)
        {
            CalcFormula = Lookup("ACA-Course Registration".Reversed WHERE("Student No." = FIELD("Student No."),
                                                                           "Reg. Transacton ID" = FIELD("Reg. Transacton ID")));
            FieldClass = FlowField;
        }
        field(20044; "Units Reg. Status"; Option)
        {
            OptionCaption = ' ,Specials,Academic Leave,WithHold,Deregister,Discontinue,Nullification,Deffer';
            OptionMembers = " ",Specials,"Academic Leave",WithHold,Deregister,Discontinue,Nullification,Deffer;
        }
        field(50000; Reversed; Boolean)
        {
        }
        field(50001; "Unit Name"; Text[100])
        {
        }
        field(50002; "Session Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Student Types".Code;
        }
        field(50003; "Lecturer Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "HRM-Employee (D)"."No." WHERE(Lecturer = CONST(true));
        }
        field(50004; "Intake Code"; Code[20])
        {
            CalcFormula = Lookup("ACA-Course Registration"."Intake Code" WHERE("Student No." = FIELD("Student No."),
                                                                                "Reg. Transacton ID" = FIELD("Reg. Transacton ID"),
                                                                                Programmes = FIELD(Programmes),
                                                                                Stage = FIELD(Stage)));
            FieldClass = FlowField;
        }
        field(50005; "Unit Description"; Text[150])
        {
            CalcFormula = Lookup("ACA-Units/Subjects".Desription WHERE("Programme Code" = FIELD(Programmes),
                                                                      "Stage Code" = FIELD(Stage),
                                                                      Code = FIELD(Unit)));
            FieldClass = FlowField;
        }
#pragma warning disable AL0603
        field(50006; Blocked; Option)
#pragma warning restore AL0603
        {
            CalcFormula = Lookup(Customer.Blocked WHERE("No." = FIELD("Student No.")));
            Caption = 'Blocked';
            FieldClass = FlowField;
            OptionCaption = ' ,Ship,Invoice,All';
            OptionMembers = " ",Ship,Invoice,All;
        }
        field(50007; "Session Code"; Code[20])
        {
            CalcFormula = Lookup("ACA-Course Registration".Session WHERE("Student No." = FIELD("Student No."),
                                                                          "Reg. Transacton ID" = FIELD("Reg. Transacton ID")));
            FieldClass = FlowField;
            TableRelation = "ACA-Intake".Code;
        }
        field(50008; "Cust Exist"; Integer)
        {
            CalcFormula = Count(Customer WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(50009; Registered; Boolean)
        {
            CalcFormula = Lookup("ACA-Course Registration".Registered WHERE("Student No." = FIELD("Student No."),
                                                                             Programmes = FIELD(Programmes),
                                                                             Semester = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(50010; "CF Score"; Decimal)
        {
            Description = 'Stores CF * Score';
        }
        field(50011; "Ignore in Final Average"; Boolean)
        {
            CalcFormula = Lookup("ACA-Units/Subjects"."Ignore in Final Average" WHERE("Programme Code" = FIELD(Programmes),
                                                                                     Code = FIELD(Unit)));
            FieldClass = FlowField;
        }
        field(50012; "Ignore in Cumm  Average"; Boolean)
        {
        }
        field(50013; "Attachment Unit"; Boolean)
        {
        }
        field(50014; "Reg. Results Status"; Code[50])
        {
            CalcFormula = Lookup("ACA-Course Registration"."Exam Status" WHERE("Student No." = FIELD("Student No."),
                                                                                Programmes = FIELD(Programmes),
                                                                                Semester = FIELD(Semester),
                                                                                Stage = FIELD(Stage)));
            FieldClass = FlowField;
        }
        field(50015; "Academic Year"; Code[20])
        {
        }
        field(50017; "Student Code"; Code[20])
        {
        }
        field(50018; "Campus Code"; Code[20])
        {
            CalcFormula = Lookup(Customer."Global Dimension 1 Code" WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(50019; "Campus Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50020; "Reg Option"; Code[20])
        {
            CalcFormula = Lookup("ACA-Course Registration".Options WHERE("Student No." = FIELD("Student No."),
                                                                          Semester = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(50021; Examiner1; Text[30])
        {
        }
        field(50022; Examiner2; Text[30])
        {
        }
        field(50023; Examiner3; Text[30])
        {
        }
        field(50024; Examiner4; Text[30])
        {
        }
        field(50025; Show; Boolean)
        {
        }
        field(50026; "Settlement Type"; Code[20])
        {
            CalcFormula = Lookup("ACA-Course Registration"."Settlement Type" WHERE("Student No." = FIELD("Student No."),
                                                                                    Reversed = CONST(false),
                                                                                    "Settlement Type" = FILTER(<> '')));
            FieldClass = FlowField;
        }
        field(50067; "Credited Hours"; Decimal)
        {
            CalcFormula = Lookup("ACA-Units/Subjects"."Credit Hours" WHERE("Programme Code" = FIELD(Programmes),
                                                                          "Stage Code" = FIELD(Stage),
                                                                          Code = FIELD(Unit)));
            FieldClass = FlowField;
        }
        field(50068; "Unit Points"; Decimal)
        {
        }
        field(50069; "Credit Hours"; Decimal)
        {
        }
        field(50070; "Cancelled Score"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Results".Contribution WHERE("Student No." = FIELD("Student No."),
                                                                     Programmes = FIELD(Programmes),
                                                                     Semester = FIELD(Semester),
                                                                     Unit = FIELD(Unit),
                                                                     Semester = FIELD(Semester),
                                                                     Cancelled = CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50071; Supervisor; Code[20])
        {
            TableRelation = "ACA-Lecturers/Examiners"."No.";
        }
        field(50072; "Released Results"; Boolean)
        {
            CalcFormula = Lookup("ACA-Semesters"."Released Results" WHERE(Code = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(50073; "Old Unit"; Boolean)
        {
        }
        field(50074; "Old Unit Lk"; Boolean)
        {
            CalcFormula = Lookup("ACA-Units/Subjects"."Old Unit" WHERE("Programme Code" = FIELD(Programmes),
                                                                      "Stage Code" = FIELD(Stage),
                                                                      Code = FIELD(Unit)));
            FieldClass = FlowField;
        }
        field(50075; "CATs Marks"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Results".Contribution WHERE(Exam = FILTER('CAT|CAT1|CAT 1|CAT2|CAT 2|CATS'),
                                                                     Programmes = FIELD(Programmes),
                                                                     "Student No." = FIELD("Student No."),
                                                                     Unit = FIELD(Unit),
                                                                     Semester = FIELD(Semester),
                                                                     ExamType = FILTER('CAT|CAT1|CAT 1|CAT2|CAT 2|CATS')));
            FieldClass = FlowField;
        }
        field(50076; "EXAMs Marks"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Results".Contribution WHERE(Exam = FILTER('EXAM|MAIN-EXAM|FINAL-EXAM'),
                                                                     Programmes = FIELD(Programmes),
                                                                     "Student No." = FIELD("Student No."),
                                                                     Unit = FIELD(Unit),
                                                                     Semester = FIELD(Semester),
                                                                     ExamType = FILTER('EXAM|MAIN-EXAM|FINAL-EXAM')));
            FieldClass = FlowField;
        }
        field(50077; "Year Of Study"; Integer)
        {
            CalcFormula = Lookup("ACA-Course Registration"."Year Of Study" WHERE("Student No." = FIELD("Student No."),
                                                                                  Semester = FIELD(Semester),
                                                                                  Programmes = FIELD(Programmes),
                                                                                  Reversed = FILTER(false)));
            FieldClass = FlowField;
        }
        field(50078; "Consolidated Mark Identifier"; Code[2])
        {
        }
        field(50079; Units; Integer)
        {
        }
        field(50080; "Weighted Units"; Decimal)
        {
        }
        field(50081; "CATs Marks Exists"; Boolean)
        {
            CalcFormula = Exist("ACA-Exam Results" WHERE(Exam = FILTER('CAT|CAT1|CAT1|CAT2|CAT2'),
                                                          Programmes = FIELD(Programmes),
                                                          "Student No." = FIELD("Student No."),
                                                          Unit = FIELD(Unit),
                                                          Semester = FIELD(Semester),
                                                          ExamType = FILTER('CAT|CAT1|CAT1|CAT2|CAT2')));
            FieldClass = FlowField;
        }
        field(50082; "EXAMs Marks Exists"; Boolean)
        {
            CalcFormula = Exist("ACA-Exam Results" WHERE(Exam = FILTER('EXAM|MAIN-EXAM|FINAL-EXAM'),
                                                          Programmes = FIELD(Programmes),
                                                          "Student No." = FIELD("Student No."),
                                                          Unit = FIELD(Unit),
                                                          Semester = FIELD(Semester),
                                                          ExamType = FILTER('EXAM|MAIN-EXAM|FINAL-EXAM')));
            FieldClass = FlowField;
        }
        field(50083; "Consolidated Mark Pref."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50084; "Reg. Reversed"; Boolean)
        {
            CalcFormula = Lookup("ACA-Course Registration".Reversed WHERE(Programmes = FIELD(Programmes),
                                                                           "Student No." = FIELD("Student No."),
                                                                           Semester = FIELD(Semester),
                                                                           Stage = FIELD(Stage)));
            FieldClass = FlowField;
        }
        field(50085; Posted; Boolean)
        {
        }
        field(50086; "Reg. Date"; Date)
        {
        }
        field(50087; "Reg. Time"; Time)
        {
        }
        field(50088; New; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50089; HOD; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50090; "Special Exam"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Programmes, Stage, Unit, Semester, "Reg. Transacton ID", "Student No.", ENo, "Academic Year")
        {
            SumIndexFields = "Credit Hours", "Unit Points", "Final Score";
        }
        key(Key2; "Student No.", Unit)
        {
        }
        key(Key3; ENo, "Student No.", Programmes, Stage, Unit, Semester, "Reg. Transacton ID")
        {
        }
        key(Key4; "Reg. Transacton ID", "Student No.", Programmes, Stage, Unit, Semester, Reversed, "Result Status", "Ignore in Cumm  Average", "Supp Taken", "Attachment Unit")
        {
            SumIndexFields = "Final Score", "No. Of Units", "CF Score";
        }
        key(Key5; "Student No.", "Final Score")
        {
        }
        key(Key6; Stage)
        {
        }
        key(Key7; Unit, Stage)
        {
        }
        key(Key8; Unit)
        {
        }
        key(Key9; "Final Score")
        {
        }
        key(Key10; Semester)
        {
        }
        key(Key11; "Total Marks")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Created by" := USERID;
        "Date created" := TODAY;
        "Reg. Date" := TODAY;
        "Reg. Time" := TIME;

        //IF Taken=FALSE THEN
        //ERROR('The Course must be marked Taken!');
    end;

    var
        coreg: Record 61532;
        FeeByStage: Record 61523;
        FeeByUnit: Record 61524;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenSetup: Record 61534;
        StudentCharges: Record 61535;
        TotalCost: Decimal;
        StageCharges: Record 61533;
        NewStudentCharges: Record 61543;
        RecFound: Boolean;
        CoursePrerequisite: Record 61546;
        SPrereq: Record 61547;
        Stages: Record 61516;
        CReg: Record 61532;
        UnitsS: Record 61517;
        StudUnits: Record 61549;
        StudUnits2: Record 61549;
        TTable2: Record 61540;
        Days: Record 61545;
        Lessons: Record 61542;
        TTable: Record 61540;
        UTaken: Integer;
        UFound: Boolean;
        CourseReg: Record 61532;
        Prog: Record 61511;
        ExamR: Record 61548;
        Studnits: Record 61549;
        ExamSetup: Record 61567;
        StatusC: Record 61593;
        ACAUnitsSubjects44: Record 61517;
}

