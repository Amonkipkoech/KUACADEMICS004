table 77711 "Aca-Result Cancelation Subject"
{
    DrillDownPageID = 77209;
    LookupPageID = 77209;

    fields
    {
        field(1; "Student No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Semester Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Program Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Stage Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Initiated By"; Code[20])
        {
            CalcFormula = Lookup("Aca-Result Cancelation Req. Hd"."Initiated By" WHERE("Student No." = FIELD("Student No."),
                                                                                        "Academic Year" = FIELD("Academic Year"),
                                                                                        "Semester Code" = FIELD("Semester Code"),
                                                                                        "Program Code" = FIELD("Program Code"),
                                                                                        "Stage Code" = FIELD("Stage Code")));
            FieldClass = FlowField;
        }
        field(7; "Approved By"; Code[20])
        {
            CalcFormula = Lookup("Aca-Result Cancelation Req. Hd"."Approved By" WHERE("Student No." = FIELD("Student No."),
                                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                                       "Semester Code" = FIELD("Semester Code"),
                                                                                       "Program Code" = FIELD("Program Code"),
                                                                                       "Stage Code" = FIELD("Stage Code")));
            FieldClass = FlowField;
        }
        field(8; "Initiated Date"; Date)
        {
            CalcFormula = Lookup("Aca-Result Cancelation Req. Hd"."Initiated Date" WHERE("Student No." = FIELD("Student No."),
                                                                                          "Academic Year" = FIELD("Academic Year"),
                                                                                          "Semester Code" = FIELD("Semester Code"),
                                                                                          "Program Code" = FIELD("Program Code"),
                                                                                          "Stage Code" = FIELD("Stage Code")));
            FieldClass = FlowField;
        }
        field(9; "Initiated Time"; Time)
        {
            CalcFormula = Lookup("Aca-Result Cancelation Req. Hd"."Initiated Time" WHERE("Student No." = FIELD("Student No."),
                                                                                          "Academic Year" = FIELD("Academic Year"),
                                                                                          "Semester Code" = FIELD("Semester Code"),
                                                                                          "Program Code" = FIELD("Program Code"),
                                                                                          "Stage Code" = FIELD("Stage Code")));
            FieldClass = FlowField;
        }
        field(10; "Approved Date"; Date)
        {
            CalcFormula = Lookup("Aca-Result Cancelation Req. Hd"."Approved Date" WHERE("Student No." = FIELD("Student No."),
                                                                                         "Academic Year" = FIELD("Academic Year"),
                                                                                         "Semester Code" = FIELD("Semester Code"),
                                                                                         "Program Code" = FIELD("Program Code"),
                                                                                         "Stage Code" = FIELD("Stage Code")));
            FieldClass = FlowField;
        }
        field(11; "Approved Time"; Time)
        {
            CalcFormula = Lookup("Aca-Result Cancelation Req. Hd"."Approved Time" WHERE("Student No." = FIELD("Student No."),
                                                                                         "Academic Year" = FIELD("Academic Year"),
                                                                                         "Semester Code" = FIELD("Semester Code"),
                                                                                         "Program Code" = FIELD("Program Code"),
                                                                                         "Stage Code" = FIELD("Stage Code")));
            FieldClass = FlowField;
        }
        field(14; Status; Option)
        {
            CalcFormula = Lookup("Aca-Result Cancelation Req. Hd".Status WHERE("Student No." = FIELD("Student No."),
                                                                                "Academic Year" = FIELD("Academic Year"),
                                                                                "Semester Code" = FIELD("Semester Code"),
                                                                                "Program Code" = FIELD("Program Code"),
                                                                                "Stage Code" = FIELD("Stage Code")));
            FieldClass = FlowField;
            OptionCaption = 'New,Pending Approval,Approved';
            OptionMembers = New,"Pending Approval",Approved;
        }
        field(15; "Unit Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Student Units".Unit WHERE("Student No." = FIELD("Student No."),
                                                            Semester = FIELD("Semester Code"),
                                                            Programme = FIELD("Program Code"),
                                                            Stage = FIELD("Stage Code"),
                                                            "Academic Year" = FIELD("Academic Year"));
        }
        field(16; "Unit Description"; Text[150])
        {
            CalcFormula = Lookup("ACA-Units/Subjects".Desription WHERE("Programme Code" = FIELD("Program Code"),
                                                                      Code = FIELD("Unit Code")));
            FieldClass = FlowField;
        }
        field(17; Notes; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Exam Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,CAT & Exam,CAT Only,Exam Only';
            OptionMembers = " ","CAT & Exam","CAT Only","Exam Only";
        }
    }

    keys
    {
        key(Key1; "Student No.", "Academic Year", "Semester Code", "Unit Code", "Program Code", "Stage Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Initiated By" := USERID;
        "Initiated Date" := TODAY;
        "Initiated Time" := TIME;
    end;

    trigger OnModify()
    begin
        IF Status = Status::Approved THEN BEGIN
            "Approved By" := USERID;
            "Approved Date" := TODAY;
            "Approved Time" := TIME;
        END;
    end;
}

