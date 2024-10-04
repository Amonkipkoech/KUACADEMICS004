table 61036 "ACA-Lecturers Evaluation"
{

    fields
    {
        field(1; Programme; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme";

            trigger OnValidate()
            begin
                AcaUnits.RESET;
                SampleCount := 0;
                AcaUnits.SETRANGE(Semester, Semester);
                AcaUnits.SETRANGE(Programme, Programme);
                AcaUnits.SETRANGE(Unit, Unit);
                //AcaUnits.SETRANGE("Academic Year",);
                IF AcaUnits.FIND('-') THEN BEGIN
                    SampleCount := COUNT();
                    AcaLecEval.SETRANGE("Student No", "Student No");
                    IF AcaLecEval.FIND('-') THEN BEGIN
                        AcaLecEval.Value := SampleCount;
                        AcaLecEval.MODIFY;
                    END;
                END;
            end;
        }
        field(2; Stage; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD(Programme));
        }
        field(3; Unit; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Raw Marks".Name WHERE(Prog = FIELD(Programme),
                                                        "Reg No" = FIELD(Stage));
        }
        field(4; Semester; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Semesters".Code;
        }
        field(5; "Student No"; Code[20])
        {
            NotBlank = true;
            TableRelation = Customer."No." WHERE("Customer Type" = CONST(Student));
        }
        field(6; "Lecturer No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Lecturers Units - Old".Lecturer WHERE(Programme = FIELD(Programme),
                                                                        Stage = FIELD(Stage),
                                                                        Unit = FIELD(Unit),
                                                                        Semester = FIELD(Semester));
        }
        field(7; "Question No"; Code[10])
        {
            NotBlank = true;
            TableRelation = "ACA-Evaluation Questions".ID;
        }
        field(8; Response; Text[250])
        {
            NotBlank = true;
        }
        field(9; "Date Time"; DateTime)
        {
            NotBlank = true;
        }
        field(10; "Response Analysis"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Value; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(12; Choices; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,VP,P,F,G,VG';
            OptionMembers = " ","Strongly Disagree",Disagree,"Neither Agree Nor Disagree",Agree,"Strongly Agree";
        }
        field(13; Category; Option)
        {
            CalcFormula = Lookup("ACA-Evaluation Questions".Category WHERE(ID = FIELD("Question No"),
                                                                            Semester = FIELD(Semester)));
            FieldClass = FlowField;
            OptionMembers = ,"COURSE OUTLINE","CONTENT PRESENTATION","PERSONAL ATTRIBUTES",Numeric,"COMMON AREAS OF ASSESMENT","CLASS MANAGEMENT AND LECTURE ASSESMENT","COURSES WITH PRACTICALS ONLY";
        }
        field(14; "Department Code"; Code[20])
        {
            CalcFormula = Lookup("ACA-Programme"."Department Code" WHERE(Code = FIELD(Programme)));
            FieldClass = FlowField;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('DEPARTMENT'));
        }
        field(15; Campus; code[50])
        {
            CalcFormula = lookup(Customer."Global Dimension 1 Code" where("No." = field("Student No")));
            FieldClass = FlowField;

        }
        field(16; ModeofStudy; code[20])
        {
            CalcFormula = lookup("ACA-Course Registration"."Settlement Type" where(Semester = const('JAN-APR23'), "Student No." = field("Student No")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; Programme, Stage, Unit, Semester, "Student No", "Lecturer No", "Question No")
        {
        }
    }

    fieldgroups
    {
    }

    var
        AcaUnits: Record "ACA-Student Units";
        SampleCount: Integer;
        AcaLecEval: Record "ACA-Lecturers Evaluation";
}

