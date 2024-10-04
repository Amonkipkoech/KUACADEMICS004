table 77721 "ACA-Course Reg. Reservour"
{
    DrillDownPageID = 68773;
    LookupPageID = 68773;

    fields
    {
        field(1; "Student No."; Code[20])
        {
            NotBlank = true;
            TableRelation = Customer."No.";
        }
        field(2; Semester; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme Semesters".Semester WHERE("Programme Code" = FIELD(Programmes));
        }
        field(3; Programmes; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme".Code WHERE(Category = FILTER(<> Professional));
        }
        field(4; "Register for"; Option)
        {
            NotBlank = false;
            OptionCaption = 'Stage,Unit/Subject,Supplementary';
            OptionMembers = Stage,"Unit/Subject",Supplementary;
        }
        field(5; Stage; Code[20])
        {
            Caption = 'Year';
            NotBlank = true;

            trigger OnValidate()
            var
                YearOfStudy: Integer;
                ACASemesters: Record "ACA-Semesters";
            begin
            end;
        }
        field(6; Unit; Code[20])
        {
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD(Programmes),
                                                           "Stage Code" = FIELD(Stage));
        }
        field(7; "Settlement Type"; Code[20])
        {
            NotBlank = false;
            TableRelation = "ACA-Settlement Type".Code;
        }
        field(8; "Registration Date"; Date)
        {
            NotBlank = true;
        }
        field(9; Remarks; Text[150])
        {
        }
        field(10; "Reg. Transacton ID"; Code[20])
        {
        }
        field(11; "No. Series"; Code[20])
        {
        }
        field(12; Modules; Integer)
        {
        }
        field(13; "Programme Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme".Code;
        }
        field(14; "Stage Filter"; Code[20])
        {
            Caption = 'Year Filter';
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD("Programme Filter"));
        }
        field(15; "Unit Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD(Programmes),
                                                           "Stage Code" = FIELD("Stage Filter"));
        }
        field(16; "Semester Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Semesters".Code;
        }
        field(17; "Lecture Room Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Lecture Room".Code;
        }
        field(18; "Attending Classes"; Boolean)
        {
        }
        field(19; "Student Type"; Option)
        {
            OptionCaption = 'Full Time,School-Based,Weekend';
            OptionMembers = "Full Time","School-Based",Weekend;
        }
        field(20; Posted; Boolean)
        {
            Editable = false;
        }
        field(21; "Units Taken"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Programme = FIELD(Programmes),
                                                           "Register for" = FIELD("Register for"),
                                                           Stage = FIELD(Stage),
                                                           Reversed = FILTER(false),
                                                           Semester = FIELD(Semester)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(22; "User ID"; Code[50])
        {
        }
        field(23; "Total Paid"; Decimal)
        {
            CalcFormula = Sum("ACA-Receipt".Amount WHERE("Student No." = FIELD("Student No."),
                                                        "Reg ID" = FIELD("Reg. Transacton ID")));
            FieldClass = FlowField;
        }
        field(24; Status; Option)
        {
            CalcFormula = Lookup(Customer.Status WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
            OptionCaption = 'Registration,Current,Alluminae,Dropped Out,Deffered,Suspended,Expelled,Discontinued,Withdrawn,Deceased,Transferred,Academic Leave,Completed';
            OptionMembers = Registration,Current,Alluminae,"Dropped Out",Deffered,Suspended,Expelled,Discontinued,Withdrawn,Deceased,Transferred,"Academic Leave",Completed;
        }
        field(25; "Status Change Date"; Date)
        {
        }
        field(26; "Fees Billed"; Decimal)
        {
            CalcFormula = Sum("ACA-Std Charges".Amount WHERE("Reg. Transacton ID" = FIELD("Reg. Transacton ID"),
                                                              "Tuition Fee" = CONST(true)));
            FieldClass = FlowField;
        }
        field(27; "Total Billed"; Decimal)
        {
            CalcFormula = Sum("ACA-Std Charges".Amount WHERE("Reg. Transacton ID" = FIELD("Reg. Transacton ID"),
                                                              "Student No." = FIELD("Student No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(28; Reversed; Boolean)
        {
        }
        field(29; "Total Units"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           "Reg. Transacton ID" = FIELD("Reg. Transacton ID")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Total Exempted"; Integer)
        {
            CalcFormula = Count("ACA-Std Units Exemptions" WHERE("Student No." = FIELD("Student No."),
                                                                  Programmes = FIELD(Programmes),
                                                                  Stage = FIELD(Stage),
                                                                  Semester = FIELD(Semester),
                                                                  Status = CONST(Approved)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(31; "OLD No."; Code[20])
        {
        }
        field(32; "Unbilled Charges"; Integer)
        {
            CalcFormula = Count("ACA-Std Charges" WHERE("Reg. Transacton ID" = FIELD("Reg. Transacton ID"),
                                                         "Student No." = FIELD("Student No."),
                                                         Recognized = CONST(false)));
            FieldClass = FlowField;
        }
        field(33; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(35; "Student Card"; Decimal)
        {
            CalcFormula = Sum("ACA-Std Charges".Amount WHERE("Student No." = FIELD("Student No."),
                                                              "Reg. Transacton ID" = FIELD("Reg. Transacton ID"),
                                                              Code = CONST('CARD'),
                                                              Recognized = CONST(true)));
            FieldClass = FlowField;
        }
        field(36; "Admission No."; Code[30])
        {
        }
        field(37; "Academic Year"; Code[20])
        {
            Description = 'Stores the reference to the academic year in the database';
            TableRelation = "ACA-Academic Year".Code;
        }
        field(38; "Admission Type"; Option)
        {
            OptionMembers = "JAB/Direct";
        }
        field(39; Options; Code[20])
        {
            TableRelation = "ACA-Programme Options".Code WHERE("Programme Code" = FIELD(Programmes));
        }
        field(47; "Registration Status"; Option)
        {
            OptionCaption = ' ,Specials,Academic Leave,WithHold,Deregister,Discontinue,Nullification';
            OptionMembers = " ",Specials,"Academic Leave",WithHold,Deregister,Discontinue,Nullification;
        }
        field(52; "General Remark"; Code[50])
        {
        }
        field(53; "Allow Adjustment"; Boolean)
        {
        }
        field(54; Transfered; Boolean)
        {
            Editable = true;
        }
        field(55; Registered; Boolean)
        {
        }
        field(56; "Re-sits"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           "Reg. Transacton ID" = FIELD("Reg. Transacton ID"),
                                                           Taken = CONST(true),
                                                           "Repeat Unit" = CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(57; "Cummulative Score"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Results".Contribution WHERE("Student No." = FIELD("Student No."),
                                                                     Programmes = FIELD(Programmes),
                                                                     Stage = FIELD("Cummulative Year Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(58; "Cummulative Units Taken"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Programme = FIELD(Programmes),
                                                           Stage = FIELD("Cummulative Year Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(59; "Options Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme Options".Code WHERE("Programme Code" = FIELD("Programme Filter"));
        }
        field(60; "System Created"; Boolean)
        {
        }
        field(61; Gender; Option)
        {
            CalcFormula = Lookup(Customer.Gender WHERE("No." = FIELD("Student No.")));
            Description = 'to be used in summary by gender report';
            FieldClass = FlowField;
            OptionMembers = " ",Male,Female;
        }
        field(62; Faculty; Code[20])
        {
            CalcFormula = Lookup("ACA-Programme"."Department Code" WHERE(Code = FIELD(Programmes)));
            Description = 'to be used in exam labels';
            FieldClass = FlowField;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DEPARTMENT|DEPARTMENTS'));
        }
        field(63; Session; Code[20])
        {
            Editable = false;
            TableRelation = "ACA-Intake".Code;
        }
        field(64; "Cummulative Year Filter"; Code[20])
        {
            Caption = 'Cummulative Year Filter';
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD("Programme Filter"));
        }
        field(65; "Result Status"; Option)
        {
            OptionCaption = ',Pass,Fail';
            OptionMembers = ,Pass,Fail;
        }
        field(66; "Entry No."; Integer)
        {
        }
        field(67; "Audit Issue"; Boolean)
        {
        }
        field(68; "Date Registered"; Date)
        {
        }
        field(69; "Programme Exam Category"; Code[20])
        {
            CalcFormula = Lookup("ACA-Programme"."Exam Category" WHERE(Code = FIELD(Programmes)));
            FieldClass = FlowField;
        }
        field(70; "Not Billed"; Boolean)
        {
        }
        field(71; "Cust Billed"; Boolean)
        {
            FieldClass = FlowFilter;
        }
        field(72; Marks; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Results".Contribution WHERE(Programmes = FIELD(Programmes),
                                                                     Stage = FIELD(Stage),
                                                                     Semester = FIELD(Semester),
                                                                     "Student No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(73; "Exams Done"; Integer)
        {
            CalcFormula = Count("ACA-Exams" WHERE("Programme Code" = FIELD(Programmes),
                                                 "Stage Code" = FIELD(Stage),
                                                 Code = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(74; "Sem Reg Counter"; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE("Student No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(75; "Check Reg"; Boolean)
        {
        }
        field(76; "Helb Beneficiary"; Integer)
        {
            CalcFormula = Count("Cust. Ledger Entry" WHERE("Customer No." = FIELD("Student No."),
                                                            "Document No." = FILTER('*HELB*')));
            FieldClass = FlowField;
        }
#pragma warning disable AL0603
        field(77; Blocked; Option)
#pragma warning restore AL0603
        {
            CalcFormula = Lookup(Customer.Blocked WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
            OptionCaption = ',Ship,Invoice,All';
            OptionMembers = ,Ship,Invoice,All;
        }
        field(78; "Prog Exist"; Integer)
        {
            CalcFormula = Count("ACA-Programme" WHERE(Code = FIELD(Programmes)));
            FieldClass = FlowField;
        }
        field(79; "Fee Exist"; Integer)
        {
            CalcFormula = Count("ACA-Fee By Stage" WHERE("Programme Code" = FIELD(Programmes),
                                                          "Settlemet Type" = FIELD("Settlement Type"),
                                                          Semester = FIELD(Semester),
                                                          "Stage Code" = FIELD(Stage)));
            FieldClass = FlowField;
        }
        field(80; "Intake Code"; Code[20])
        {
            TableRelation = "ACA-Intake".Code;
        }
        field(81; "Sem Repeated"; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE("Student No." = FIELD("Student No."),
                                                                 Semester = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(82; "Student Status"; Option)
        {
            CalcFormula = Lookup(Customer.Status WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
            OptionCaption = 'Registration,Current,Alluminae,Dropped Out,Differed,Suspended,Expulsion,Discontinued,Deferred,Deceased,Transferred';
            OptionMembers = Registration,Current,Alluminae,"Dropped Out",Differed,Suspended,Expulsion,Discontinued,Deferred,Deceased,Transferred;
        }
        field(83; "Account Count"; Integer)
        {
            CalcFormula = Count(Customer WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(84; "Exam Status"; Code[50])
        {
            TableRelation = "ACA-Results Status".Code;
        }
        field(85; "Units Passed"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Semester = FIELD(Semester),
                                                           Programme = FIELD(Programmes),
                                                           Stage = FIELD(Stage),
                                                           "Result Status" = FILTER('PASS')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(86; "Units Failed"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Semester = FIELD(Semester),
                                                           Programme = FIELD(Programmes),
                                                           Stage = FIELD(Stage),
                                                           "Result Status" = CONST('FAIL')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(87; "Units Repeat"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Semester = FIELD(Semester),
                                                           Programme = FIELD(Programmes),
                                                           Stage = FIELD(Stage),
                                                           "Result Status" = FILTER('REPEAT')));
            FieldClass = FlowField;
        }
        field(89; "Exam Grade"; Code[50])
        {
        }
        field(50000; "Cum Average"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Final Score" WHERE("Student No." = FIELD("Student No."),
                                                                       Semester = FIELD("Semester Filter"),
                                                                       Programme = FIELD("Programme Filter"),
                                                                       Stage = FIELD("Stage Filter"),
                                                                       Reversed = CONST(false),
                                                                       "Attachment Unit" = CONST(false),
                                                                       "Ignore in Cumm  Average" = CONST(false),
                                                                       "Supp Taken" = CONST(false)));
            FieldClass = FlowField;
        }
        field(50001; "Cum Units Done"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Semester = FIELD("Semester Filter"),
                                                           Programme = FIELD(Programmes),
                                                           Stage = FIELD("Stage Filter"),
                                                           Reversed = CONST(false),
                                                           "Attachment Unit" = CONST(false),
                                                           "Ignore in Cumm  Average" = CONST(false),
                                                           "Supp Taken" = CONST(false)));
            FieldClass = FlowField;
        }
        field(50002; "Cum Units Passed"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Programme = FIELD(Programmes),
                                                           Stage = FIELD("Stage Filter"),
                                                           "Result Status" = FILTER('PASS'),
                                                           Semester = FIELD("Semester Filter"),
                                                           Reversed = CONST(false),
                                                           "Supp Taken" = CONST(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; "Cum Units Failed"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Programme = FIELD(Programmes),
                                                           Stage = FIELD("Stage Filter"),
                                                           Failed = CONST(true),
                                                           Semester = FIELD("Semester Filter"),
                                                           Reversed = CONST(false),
                                                           "Supp Taken" = CONST(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "Programme Average"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Final Score" WHERE("Student No." = FIELD("Student No."),
                                                                       Programme = FIELD(Programmes),
                                                                       "Attachment Unit" = CONST(false),
                                                                       "Ignore in Cumm  Average" = CONST(false),
                                                                       "Supp Taken" = CONST(false)));
            FieldClass = FlowField;
        }
        field(50005; "Programme Units Done"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Programme = FIELD("Programme Filter"),
                                                           "Attachment Unit" = CONST(false),
                                                           "Reg Reversed" = CONST(false),
                                                           "Ignore in Final Average" = CONST(false),
                                                           "Supp Taken" = CONST(false)));
            FieldClass = FlowField;
        }
        field(50006; "Trans Count"; Integer)
        {
            CalcFormula = Count("Cust. Ledger Entry" WHERE("Customer No." = FIELD("Student No."),
                                                            "Posting Date" = FILTER('09/01/12..11/27/12')));
            FieldClass = FlowField;
        }
        field(50007; "Current Sem"; Boolean)
        {
            CalcFormula = Lookup("ACA-Semesters"."Current Semester" WHERE(Code = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(50008; "Registered Reason"; Text[100])
        {
        }
        field(50009; "Registered By"; Code[20])
        {
        }
        field(50010; "Study Year"; Code[20])
        {
        }
        field(50011; "Cust Exist"; Integer)
        {
            CalcFormula = Count(Customer WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(50012; "Cumm Score"; Decimal)
        {
        }
        field(50013; "Marks Status"; Option)
        {
            OptionCaption = ' ,R,RP1,RD,RPC,RPD,RPE,RA,RAS,M,TF,TFS,R2,RP12,RD2,RPC2,RPD2,RPE2,RA2,RAS2,M2,TF2,TFS2,R3,RP13,RD3,RPC3,RPD3,RPE3,RA3,RAS3,M3,TF3,TFS3,R4,RP14,RD4,RPC4,RPD4,RPE4,RA4,RAS4,M4,TF4,TFS4,R5,RP15,RD5,RPC5,RPD5,RPE5,RA5,RAS5,M5,TF5,TFS5';
            OptionMembers = " ",R,RP1,RD,RPC,RPD,RPE,RA,RAS,M,TF,TFS,R2,RP12,RD2,RPC2,RPD2,RPE2,RA2,RAS2,M2,TF2,TFS2,R3,RP13,RD3,RPC3,RPD3,RPE3,RA3,RAS3,M3,TF3,TFS3,R4,RP14,RD4,RPC4,RPD4,RPE4,RA4,RAS4,M4,TF4,TFS4,R5,RP15,RD5,RPC5,RPD5,RPE5,RA5,RAS5,M5,TF5,TFS5;
        }
        field(50014; "Units Status Count"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Programme = FIELD(Programmes),
                                                           "Result Status" = FILTER('FAIL')));
            FieldClass = FlowField;
        }
        field(50015; "Sem Pass Count"; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE("Student No." = FIELD("Student No."),
                                                                 Programmes = FIELD(Programmes),
                                                                 "Exam Status" = FILTER('PASS'),
                                                                 Stage = FIELD("Stage Filter"),
                                                                 Semester = FIELD("Semester Filter")));
            FieldClass = FlowField;
        }
        field(50016; "Cum Units Count"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Semester = FIELD("Semester Filter"),
                                                           Programme = FIELD("Programme Filter"),
                                                           Stage = FIELD("Stage Filter"),
                                                           Reversed = CONST(false)));
            FieldClass = FlowField;
        }
        field(50036; "Total CF Count"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."CF Score" WHERE(Programme = FIELD(Programmes),
                                                                    "Student No." = FIELD("Student No."),
                                                                    Stage = FIELD("Stage Filter"),
                                                                    Semester = FIELD("Semester Filter"),
                                                                    "Supp Taken" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(50051; "Current Cumm Score"; Decimal)
        {
        }
        field(50052; "CF Count"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."No. Of Units" WHERE(Programme = FIELD(Programmes),
                                                                        "Student No." = FIELD("Student No."),
                                                                        Stage = FIELD("Stage Filter"),
                                                                        Semester = FIELD("Semester Filter"),
                                                                        "Supp Taken" = FILTER(false),
                                                                        "Attachment Unit" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(50053; "CF Total Score"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."CF Score" WHERE(Programme = FIELD(Programmes),
                                                                    "Student No." = FIELD("Student No."),
                                                                    Stage = FIELD("Stage Filter"),
                                                                    Semester = FIELD("Semester Filter"),
                                                                    "Supp Taken" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(50054; "Current Cumm Grade"; Code[20])
        {
        }
        field(50055; "Cumm Grade"; Code[20])
        {
        }
        field(50056; Names; Text[100])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(50057; "Programme Campus"; Code[20])
        {
            CalcFormula = Lookup("ACA-Programme Stages"."Campus Code" WHERE("Programme Code" = FIELD(Programmes),
                                                                             Code = FIELD(Stage)));
            FieldClass = FlowField;
        }
        field(50059; "Manual Exam Status"; Boolean)
        {
            CalcFormula = Lookup("ACA-Results Status"."Manual Status Processing" WHERE(Code = FIELD("Exam Status")));
            FieldClass = FlowField;
        }
        field(50060; Award; Text[200])
        {
        }
        field(50061; "Campus Filter"; Code[20])
        {
            CalcFormula = Lookup(Customer."Global Dimension 1 Code" WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50062; "Registered Units"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Semester = FIELD("Semester Filter"),
                                                           Stage = FIELD("Stage Filter"),
                                                           "Total Score" = FILTER(> 0)));
            FieldClass = FlowField;
        }
        field(60000; "Average Semester GPA"; Decimal)
        {
            CalcFormula = Average("ACA-Student Units"."Final Score" WHERE(Grade = FILTER(<> ''),
                                                                           "Student No." = FIELD("Student No."),
                                                                           Semester = FIELD(Semester),
                                                                           "Academic Year" = FIELD("Academic Year")));
            DecimalPlaces = 1 : 1;
            FieldClass = FlowField;
        }
        field(60001; "Average Cummulative GPA"; Decimal)
        {
            CalcFormula = Average("ACA-Student Units"."Final Score" WHERE("Student No." = FIELD("Student No."),
                                                                           Grade = FILTER(<> '')));
            DecimalPlaces = 1 : 1;
            FieldClass = FlowField;
        }
        field(60002; "Description of Intake/Semester"; Code[100])
        {
            CalcFormula = Lookup("ACA-Academic Year Schedule"."Description of Intake/Semester" WHERE("Academic Year" = FIELD("Academic Year"),
                                                                                                      Semester = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(60003; "Repeat"; Boolean)
        {
            CalcFormula = Exist("ACA-Student Units" WHERE(Failed = CONST(true),
                                                           "Reg. Transacton ID" = FIELD("Reg. Transacton ID"),
                                                           "Student No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(60004; "Semester Points"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Unit Points" WHERE(Grade = FILTER(<> ''),
                                                                       Grade = FILTER('A|A+|B|B+|C|C+|D|D+|E'),
                                                                       "Student No." = FIELD("Student No."),
                                                                       Semester = FIELD(Semester),
                                                                       "Academic Year" = FIELD("Academic Year")));
            FieldClass = FlowField;
        }
        field(60005; "Semester Hours"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Credit Hours" WHERE(Grade = FILTER(<> ''),
                                                                        Grade = FILTER('A|A+|B|B+|C|C+|D|D+|E|!'),
                                                                        "Student No." = FIELD("Student No."),
                                                                        Semester = FIELD(Semester),
                                                                        "Academic Year" = FIELD("Academic Year")));
            FieldClass = FlowField;
        }
        field(60006; "Cummulative Units"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Programme = FIELD(Programmes),
                                                           Unit = FILTER(<> '')));
            FieldClass = FlowField;
        }
        field(60007; "Cummulative Marks"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Total Marks" WHERE("Student No." = FIELD("Student No."),
                                                                       Programme = FIELD(Programmes),
                                                                       Unit = FILTER(<> '')));
            FieldClass = FlowField;
        }
        field(60008; "Cumm GPA"; Decimal)
        {
        }
        field(60009; "Sem GPA"; Decimal)
        {
        }
        field(60010; "Allow View of Results"; Boolean)
        {
            CalcFormula = Lookup("ACA-Academic Year Schedule"."Allow View of Results" WHERE("Academic Year" = FIELD("Academic Year"),
                                                                                             Semester = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(60011; "Semester Average"; Decimal)
        {
        }
        field(60012; "Cummulative Average"; Decimal)
        {
        }
        field(60013; "Semester Grade"; Code[20])
        {
        }
        field(60014; "Cummulative Grade"; Code[20])
        {
        }
        field(60015; "Campus Code"; Code[20])
        {
            CalcFormula = Lookup(Customer."Global Dimension 1 Code" WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(60016; "Student Name"; Text[250])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(60017; "County Code"; Text[30])
        {
            CalcFormula = Lookup(Customer.County WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
            TableRelation = "ACA-Academics Central Setups"."Title Code" WHERE(Category = FILTER(Counties));
        }
        field(60018; "Cumm Status"; Code[20])
        {
        }
        field(60019; "Sem FAIL Count"; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE("Student No." = FIELD("Student No."),
                                                                 Programmes = FIELD(Programmes),
                                                                 "Exam Status" = FILTER(<> 'PASS'),
                                                                 Stage = FIELD("Stage Filter"),
                                                                 Semester = FIELD("Semester Filter"),
                                                                 Reversed = CONST(false)));
            FieldClass = FlowField;
        }
        field(60020; "School Filter"; Code[20])
        {
            CalcFormula = Lookup("ACA-Programme"."School Code" WHERE(Code = FIELD(Programmes)));
            FieldClass = FlowField;
        }
        field(60021; "Intake Current Stage"; Code[20])
        {
            CalcFormula = Lookup("ACA-Intake".lost WHERE(Code = FIELD(Session)));
            FieldClass = FlowField;
        }
        field(60022; Balance; Decimal)
        {
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Customer No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(60023; "First Time Student"; Boolean)
        {
        }
        field(60024; "Fee Structure Exists"; Integer)
        {
            CalcFormula = Count("ACA-Fee By Stage" WHERE("Programme Code" = FIELD(Programmes),
                                                          "Stage Code" = FIELD(Stage),
                                                          "Settlemet Type" = FIELD("Settlement Type"),
                                                          Semester = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(60025; "Reg Count"; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE("Student No." = FIELD("Student No."),
                                                                 Reversed = CONST(false)));
            FieldClass = FlowField;
        }
        field(60026; "Old Prog Code"; Code[20])
        {
            CalcFormula = Lookup("ACA-Programme"."Old Code" WHERE(Code = FIELD(Programmes)));
            FieldClass = FlowField;
        }
        field(60027; "Class Code"; Code[30])
        {
        }
        field(60028; "Mass Stop"; Boolean)
        {
        }
        field(60029; "Mass Stopped By"; Code[20])
        {
        }
        field(60030; "Mass Stooped Date"; Date)
        {
        }
        field(60031; "Room No"; Code[20])
        {
            CalcFormula = Lookup("ACA-Students Hostel Rooms"."Space No" WHERE(Student = FIELD("Student No."),
                                                                               Cleared = CONST(false)));
            FieldClass = FlowField;
        }
        field(60032; "Hostel No"; Code[20])
        {
            CalcFormula = Lookup("ACA-Students Hostel Rooms"."Hostel No" WHERE(Student = FIELD("Student No."),
                                                                                Cleared = CONST(false)));
            FieldClass = FlowField;
        }
        field(60033; "ID Number"; Code[20])
        {
            CalcFormula = Lookup(Customer."ID No" WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(60034; "Total Billed Accomodation"; Decimal)
        {
            CalcFormula = Sum("ACA-Std Charges".Amount WHERE("Reg. Transacton ID" = FIELD("Reg. Transacton ID"),
                                                              "Student No." = FIELD("Student No."),
                                                              accommodation = CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60035; "Programme Category"; Option)
        {
            CalcFormula = Lookup("ACA-Programme".Category WHERE(Code = FIELD(Programmes)));
            FieldClass = FlowField;
            OptionCaption = ',Certificate ,Diploma,Undergraduate,Postgraduate,Professional,Course List';
            OptionMembers = ,"Certificate ",Diploma,Undergraduate,Postgraduate,Professional,"Course List";
        }
        field(60036; "Year Of Study"; Integer)
        {
        }
        field(60037; "Total Yearly Marks"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Total Marks" WHERE("Student No." = FIELD("Student No."),
                                                                       Programme = FIELD(Programmes),
                                                                       "Year Of Study" = FIELD("Year Of Study"),
                                                                       Unit = FILTER(<> '')));
            FieldClass = FlowField;
        }
        field(60038; "Yearly Average"; Decimal)
        {
        }
        field(60039; "Yearly Grade"; Code[2])
        {
        }
        field(60040; "Yearly Failed Units"; Integer)
        {
            CalcFormula = Sum("ACA-Student Units".Units WHERE("Student No." = FIELD("Student No."),
                                                               Programme = FIELD(Programmes),
                                                               "Year Of Study" = FIELD("Year Of Study"),
                                                               Grade = FILTER('E'),
                                                               "Reg. Reversed" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60041; "Yearly Total Units Taken"; Integer)
        {
            CalcFormula = Sum("ACA-Student Units".Units WHERE("Student No." = FIELD("Student No."),
                                                               Programme = FIELD(Programmes),
                                                               Unit = FILTER(<> ''),
                                                               "Year Of Study" = FIELD("Year Of Study"),
                                                               "Reg. Reversed" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60042; "Yearly Remarks"; Code[250])
        {
        }
        field(60043; "Yearly Passed Units"; Integer)
        {
            CalcFormula = Sum("ACA-Student Units".Units WHERE("Student No." = FIELD("Student No."),
                                                               Programme = FIELD(Programmes),
                                                               "Year Of Study" = FIELD("Year Of Study"),
                                                               Grade = FILTER('A|B|C|D'),
                                                               Unit = FILTER(<> ''),
                                                               "Total Marks" = FILTER(> 0),
                                                               "Reg. Reversed" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60044; "Total Semester Marks"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Total Marks" WHERE("Student No." = FIELD("Student No."),
                                                                       Programme = FIELD(Programmes),
                                                                       Semester = FIELD(Semester),
                                                                       Unit = FILTER(<> '')));
            FieldClass = FlowField;
        }
        field(60047; "Semester Failed Units"; Integer)
        {
            CalcFormula = Sum("ACA-Student Units".Units WHERE("Student No." = FIELD("Student No."),
                                                               Programme = FIELD(Programmes),
                                                               Semester = FIELD(Semester),
                                                               Grade = FILTER(<> 'A'),
                                                               Unit = FILTER(<> ''),
                                                               Grade = FILTER(<> 'B'),
                                                               Grade = FILTER(<> 'C'),
                                                               Grade = FILTER(<> 'D'),
                                                              "Reg. Reversed" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60048; "Semester Total Units Taken"; Integer)
        {
            CalcFormula = Sum("ACA-Student Units".Units WHERE("Student No." = FIELD("Student No."),
                                                               Programme = FIELD(Programmes),
                                                               Semester = FIELD(Semester),
                                                               Unit = FILTER(<> ''),
                                                               "Reg. Reversed" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60049; "Semester Remarks"; Code[250])
        {
        }
        field(60050; "Semester Passed Units"; Integer)
        {
            CalcFormula = Sum("ACA-Student Units".Units WHERE("Student No." = FIELD("Student No."),
                                                               Programme = FIELD(Programmes),
                                                               Semester = FIELD(Semester),
                                                               Grade = FILTER('A|B|C|D'),
                                                               Unit = FILTER(<> ''),
                                                               "Total Marks" = FILTER(> 0),
                                                               "Reg. Reversed" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60051; "Failed Unit"; Text[250])
        {
        }
        field(60053; "Yearly Weighted Total"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Weighted Units" WHERE("Student No." = FIELD("Student No."),
                                                                          Programme = FIELD(Programmes),
                                                                          "Year Of Study" = FIELD("Year Of Study"),
                                                                          "Reg. Reversed" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60054; "Semester Weighted Total"; Decimal)
        {
            CalcFormula = Sum("ACA-Student Units"."Weighted Units" WHERE("Student No." = FIELD("Student No."),
                                                                          Programme = FIELD(Programmes),
                                                                          Semester = FIELD(Semester),
                                                                          "Reg. Reversed" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60055; "Yearly CF% Failed"; Decimal)
        {
        }
        field(60056; "Yearly Curr. Average"; Decimal)
        {
        }
        field(60057; "Semester Curr. Average"; Decimal)
        {
        }
        field(60058; "Semester CF% Failed"; Decimal)
        {
        }
        field(60059; "Transcript Remarks"; Text[250])
        {
        }
        field(60060; "Yearly Failed Courses"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Programme = FIELD(Programmes),
                                                           "Year Of Study" = FIELD("Year Of Study"),
                                                           Grade = FILTER('E'),
                                                           "Reg. Reversed" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60061; "Year of Admission"; Integer)
        {
        }
        field(60062; "Special Exam Exists"; Option)
        {
            CalcFormula = Lookup("ACA-Student Units"."Special Exam" WHERE("Student No." = FIELD("Student No."),
                                                                           Semester = FIELD(Semester)));
            FieldClass = FlowField;
            OptionCaption = ' ,Special,Suspension';
            OptionMembers = " ",Special,Suspension;
        }
    }

    keys
    {
        key(Key1; "Reg. Transacton ID", "Student No.", Programmes, Semester, "Register for", Stage, "Student Type", "Entry No.")
        {
        }
        key(Key2; "Student Type")
        {
        }
        key(Key3; "Student No.")
        {
        }
        key(Key4; "General Remark")
        {
        }
        key(Key5; "Registration Date", Programmes, Stage)
        {
        }
        key(Key6; Stage)
        {
        }
        key(Key7; "Student No.", Programmes, Semester, "Register for", Stage, Unit, "Student Type")
        {
        }
        key(Key8; Stage, "Student No.")
        {
        }
        key(Key9; "Reg. Transacton ID", "Student No.", Programmes, Semester, "Register for", Unit, "Student Type")
        {
        }
        key(Key10; Programmes, "Student No.", "Entry No.")
        {
        }
        key(Key11; "Reg. Transacton ID", "Student No.", Programmes, Semester, "Register for", Stage, Unit, "Student Type")
        {
        }
        key(Key12; "Cumm Score")
        {
        }
        key(Key13; "Settlement Type", "Student No.")
        {
        }
        key(Key14; "Student No.", Stage)
        {
        }
        key(Key15; "Year of Admission", "Student No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        UserSetup: Record 91;
        coReg2: Record 61532;
        coReg1: Record 61532;
        acadYears: Record 61382;
        FeeByStage: Record 61523;
        FeeByUnit: Record 61524;
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        GenSetup: Record 61534;
        StudentCharges: Record 61535;
        TotalCost: Decimal;
        StageCharges: Record 61533;
        NewStudentCharges: Record 61543;
        RecFound: Boolean;
        CoursePrerequisite: Record 61546;
        SPrereq: Record 61547;
        Stages: Record 61516;
        ProgStages: Record 61516;
        StudentUnits: Record 61549;
        StageUnits: Record 61517;
        EStageUnits: Record 61591;
        GenJnl: Record 81;
        Units: Record 61517;
        ExamsByStage: Record 61526;
        ExamsByUnit: Record 61527;
        Charges: Record 61515;
        Sems: Record 61692;
        SemFound: Boolean;
        DueDate: Date;
        Cust: Record 18;
        GenBatches: Record 232;
        window: Dialog;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        SettlementType: Record 61522;
        CReg: Record 61532;
        CustPostGroup: Record 92;
        Programmes: Record 61511;
        CourseReg: Record 61532;
        CourseReg2: Record 61532;
        Found: Boolean;
        LibCode: Text[30];
        LibRefCodes: Record 61562;
        Custs: Record 18;
        UnitType: Text[100];
        TotalUnits: Integer;
        OldStud: Boolean;
        CReg2: Record 61532;
        PSemester: Record 61525;
        StudUnits: Record 61549;
        PStage: Record 61516;
        SFee: Record 61523;
        ExamR: Record 61548;
        Prog: Record 61511;
        Prog2: Record 61511;
        AcademicYear: Record 61382;
        IntakeRec: Record 61383;
        MultipleCombination: Record 61601;
        HostLedger: Record 61163;
        HostStudent: Record 61155;
        StudentUnits_2: Record 61549;
        ValidateUser: Codeunit "Validate User Permissions";
        RecType: Option " ",GL,Cust,Item,Supp,FA,Emp,Sal,CourseReg,prTrans,EmpTrans;
        YearOfAdmin: Integer;

    procedure Check_Units_Exist(StudentNo: Code[20]; StudProg: Code[20]; Stag: Code[20]; Unt: Code[20]) Exists: Boolean
    var
        StudUnits: Record 61549;
    begin
        Exists := FALSE;
        StudUnits.RESET;
        StudUnits.SETRANGE(StudUnits.Programme, StudProg);
        StudUnits.SETRANGE(StudUnits.Stage, Stag);
        StudUnits.SETRANGE(StudUnits.Unit, Unt);
        StudUnits.SETRANGE(StudUnits."Student No.", StudentNo);
        IF StudUnits.FIND('-') THEN
            Exists := TRUE;
    end;
}

