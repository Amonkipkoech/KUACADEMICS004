table 61516 "ACA-Programme Stages"
{
    DrillDownPageID = 68742;
    LookupPageID = 68742;

    fields
    {
        field(1; "Programme Code"; Code[20])
        {
            NotBlank = false;
            TableRelation = "ACA-Programme".Code;
        }
        field(2; "Code"; Code[20])
        {
            NotBlank = false;

            trigger OnValidate()
            begin
                IF Prog.GET("Programme Code") THEN
                    Department := Prog."School Code";
                CLEAR(YearOfStudy);
                IF EVALUATE(YearOfStudy, COPYSTR(Rec.Code, 2, 1)) THEN BEGIN

                END;

                IF YearOfStudy <> 0 THEN BEGIN
                    "Year of Study" := YearOfStudy;
                END;
            end;
        }
        field(3; Description; Text[150])
        {
        }
        field(4; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(5; Department; Code[20])
        {
        }
        field(6; Remarks; Text[150])
        {
        }
        field(7; "Total Income"; Decimal)
        {
            CalcFormula = Sum("ACA-Std Charges"."Amount Paid" WHERE(Programme = FIELD("Programme Code"),
                                                                     Stage = FIELD(Code),
                                                                     Semester = FIELD("Semester Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Student Registered"; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE(Programmes = FIELD("Programme Code"),
                                                                 Stage = FIELD(Code),
                                                                 Semester = FIELD("Semester Filter"),
                                                                 "Registration Date" = FIELD("Date Filter"),
                                                                 Status = FIELD(Status),
                                                                 Reversed = CONST(false)));
            //Session = FIELD("Intake Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Semester Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Semesters".Code;
        }
        field(10; "Modules Registration"; Boolean)
        {
        }
        field(11; "Period (M)"; Integer)
        {
        }
        field(12; "Distribution Full Time (%)"; Decimal)
        {
        }
        field(13; "Distribution Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(14; Registered; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE(Programmes = FIELD("Programme Code"),
                                                                 Stage = FIELD(Code),
                                                                 Semester = FIELD("Semester Filter"),
                                                                 "Registration Date" = FIELD("Date Filter"),
                                                                 Status = FIELD(Status),
                                                                 Reversed = CONST(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; Paid; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE(Programmes = FIELD("Programme Code"),
                                                                 Stage = FIELD(Code),
                                                                 Semester = FIELD("Semester Filter"),
                                                                 "Registration Date" = FIELD("Date Filter"),
                                                                 "Total Paid" = FILTER('>=1,700'),
                                                                 Status = FIELD(Status),
                                                                 Reversed = CONST(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(17; "Registered Part Time"; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE(Programmes = FIELD("Programme Code"),
                                                                 Stage = FIELD(Code),
                                                                 Semester = FIELD("Semester Filter"),
                                                                 "Registration Date" = FIELD("Date Filter"),
                                                                 Status = FIELD(Status),
                                                                 Reversed = CONST(false),
                                                                 //Session = FIELD("Intake Filter"),
                                                                 "Student Type" = CONST("School-Based")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; "Paid Part Time"; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE(Programmes = FIELD("Programme Code"),
                                                                 Stage = FIELD(Code),
                                                                 Semester = FIELD("Semester Filter"),
                                                                 "Registration Date" = FIELD("Date Filter"),
                                                                 "Student Type" = CONST("School-Based"),
                                                                 "Total Paid" = FILTER('>=1,700'),
                                                                 Status = FIELD(Status),
                                                                 Reversed = CONST(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; "Registered Full Time"; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE(Programmes = FIELD("Programme Code"),
                                                                 Stage = FIELD(Code),
                                                                 Semester = FIELD("Semester Filter"),
                                                                 "Registration Date" = FIELD("Date Filter"),
                                                                 "Student Type" = CONST("Full Time"),
                                                                 Status = FIELD(Status),
                                                                 Reversed = CONST(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Paid Full Time"; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE(Programmes = FIELD("Programme Code"),
                                                                 Stage = FIELD(Code),
                                                                 Semester = FIELD("Semester Filter"),
                                                                 "Registration Date" = FIELD("Date Filter"),
                                                                 "Student Type" = CONST("Full Time"),
                                                                 "Total Paid" = FILTER('>=1,700'),
                                                                 Status = FIELD(Status),
                                                                 Reversed = CONST(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; "Distribution Part Time (%)"; Decimal)
        {
        }
        field(22; "Full Time Budget"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(23; "Part Time Budget"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(24; Status; Option)
        {
            FieldClass = FlowFilter;
            OptionMembers = " ",Registration,Current,Alluminae,Dropped;
        }
        field(25; "Ignore No. Of Units"; Boolean)
        {
        }
        field(26; "Total Income1"; Decimal)
        {
            CalcFormula = Sum("ACA-Std Charges"."Amount Paid" WHERE(Programme = FIELD("Programme Code"),
                                                                     Semester = FIELD("Semester Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(27; Minimum; Integer)
        {
        }
        field(28; Maximum; Integer)
        {
        }
        field(29; "Student No."; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = Customer."No.";
        }
        field(30; "Units Taken"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE(Programme = FIELD("Programme Code"),
                                                           "Unit Stage" = FIELD(Code),
                                                           Taken = CONST(true),
                                                           "Student No." = FIELD("Student No."),
                                                           "Reg. Transacton ID" = FIELD("Reg. ID")));
            FieldClass = FlowField;
        }
        field(31; "Reg. ID"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Course Registration"."Reg. Transacton ID";
        }
        field(32; "Do not Graduate"; Boolean)
        {
        }
        field(33; "Student Type Filter"; Code[100])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Settlement Type".Code;
        }
        field(34; "Campus Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(35; "Intake Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Intake".Code;
        }
        field(41; "Failed Count"; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE(Programmes = FIELD("Programme Code"),
                                                                 Semester = FIELD("Semester Filter"),
                                                                 Stage = FIELD(Code)));
            //"Units Failed"=FILTER(<>0),
            // "Units Repeat"=CONST(0)));
            FieldClass = FlowField;
        }
        field(42; "Pass Count"; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE(Programmes = FIELD("Programme Code"),
                                                                 Semester = FIELD("Semester Filter"),
                                                                 Stage = FIELD(Code),
                                                                 //  "Units Failed"=CONST(0),
                                                                 //  "Units Passed"=FILTER(<>0),
                                                                 //  "Units Repeat"=CONST(0),
                                                                 Reversed = CONST(false)));
            FieldClass = FlowField;
        }
        field(43; "Stage Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD("Programme Code"));
        }
        field(44; "Repeat Count"; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE(Programmes = FIELD("Programme Code"),
                                                                 Semester = FIELD("Semester Filter"),
                                                                 Stage = FIELD(Code)));
            //"Units Repeat"=FILTER(<>0)));
            FieldClass = FlowField;
        }
        field(45; "Final Stage"; Boolean)
        {
        }
        field(46; "Academic Leave"; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE(Programmes = FIELD("Programme Code"),
                                                                 Stage = FIELD(Code),
                                                                 Semester = FIELD("Semester Filter"),
                                                                 "Registration Date" = FIELD("Date Filter"),
                                                                 "Registration Status" = CONST("Academic Leave"),
                                                                 Reversed = CONST(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(47; Withheld; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE(Programmes = FIELD("Programme Code"),
                                                                 Stage = FIELD(Code),
                                                                 Semester = FIELD("Semester Filter"),
                                                                 "Registration Date" = FIELD("Date Filter"),
                                                                 "Registration Status" = CONST(WithHold),
                                                                 Reversed = CONST(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(48; Special; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE(Programmes = FIELD("Programme Code"),
                                                                 Stage = FIELD(Code),
                                                                 Semester = FIELD("Semester Filter"),
                                                                 "Registration Date" = FIELD("Date Filter"),
                                                                 "Registration Status" = CONST(Specials),
                                                                 Reversed = CONST(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(49; Discontinue; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE(Programmes = FIELD("Programme Code"),
                                                                 Stage = FIELD(Code),
                                                                 Semester = FIELD("Semester Filter"),
                                                                 "Registration Date" = FIELD("Date Filter"),
                                                                 "Registration Status" = CONST(Discontinue),
                                                                 Reversed = CONST(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50; Nullification; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE(Programmes = FIELD("Programme Code"),
                                                                 Stage = FIELD(Code),
                                                                 Semester = FIELD("Semester Filter"),
                                                                 "Registration Date" = FIELD("Date Filter"),
                                                                 "Registration Status" = CONST(Nullification),
                                                                 Reversed = CONST(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(51; "Next Stage Attachment"; Boolean)
        {
        }
        field(52; "Allow Programme Options"; Boolean)
        {
        }
        field(53; "Include in Time Table"; Boolean)
        {
        }
        field(50000; "Campus Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50001; "Order"; Integer)
        {
        }
        field(50002; "Year of Study"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; extraStage; Boolean)
        {
            
        }
    }

    keys
    {
        key(Key1; "Programme Code", "Code")
        {
            SumIndexFields = "Full Time Budget", "Part Time Budget";
        }
        key(Key2; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Prog: Record 61511;
        YearOfStudy: Integer;
}

