table 65800 "Class Attendance Header"
{

    fields
    {
        field(1; Semester; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Semesters".Code;
        }
        field(2; "Attendance Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Lecturer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HRM-Employee (D)"."No." WHERE(Lecturer = FILTER(true));
        }
        field(4; "Captured By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Class Rep. Reg. No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." WHERE("Customer Posting Group" = FILTER('STUDENT'));

            trigger OnValidate()
            begin
                IF Customer.GET("Class Rep. Reg. No") THEN BEGIN
                    "Class Rep. Mail" := Customer."E-Mail";
                    "Class Rep. Phone" := Customer."Phone No.";
                END;
            end;
        }
        field(6; "Class Rep. Mail"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Class Rep. Phone"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Number Absent"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Class Attendance Details" WHERE(Semester = FIELD(Semester),
                                                                  "Attendance Date" = FIELD("Attendance Date"),
                                                                  "Unit Code" = field("Unit Code"),
                                                                 "Lecturer Code" = FIELD("Lecturer Code"),
                                                                  Present = FILTER(false)));

        }
        field(9; "Number Present"; Integer)
        {
            CalcFormula = Count("Class Attendance Details" WHERE(Semester = FIELD(Semester),
                                                                  "Attendance Date" = FIELD("Attendance Date"),
                                                                  "Unit Code" = FIELD("Unit Code"),
                                                                 "Lecturer Code" = FIELD("Lecturer Code"),
                                                                  Present = FILTER(true)));
            FieldClass = FlowField;
        }
        field(10; "From Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "To Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Class Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Normal Single,Normal Double,Normal Tripple,Lab';
            OptionMembers = "Normal Single","Normal Double","Normal Tripple",Lab;
        }
        field(13; "Unit Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Lecturers Units".Unit WHERE(Lecturer = FIELD("Lecturer Code"),
                                                              Semester = FIELD(Semester));

            trigger OnValidate()
            begin
                TESTFIELD(Semester);
                TESTFIELD("Attendance Date");
                TESTFIELD("Lecturer Code");
                TESTFIELD("Class Rep. Reg. No");

                IF "Unit Code" <> '' THEN BEGIN
                    ClassAttendanceDetails.RESET;
                    ClassAttendanceDetails.SETRANGE(Semester, Rec.Semester);
                    ClassAttendanceDetails.SETRANGE("Lecturer Code", Rec."Lecturer Code");
                    ClassAttendanceDetails.SETRANGE("Unit Code", Rec."Unit Code");
                    ClassAttendanceDetails.SETRANGE("Attendance Date", Rec."Attendance Date");
                    IF ClassAttendanceDetails.FIND() THEN BEGIN
                        ClassAttendanceDetails.DELETEALL;
                    END;
                    CLEAR(countings);
                    ACAStudentUnits.RESET;
                    ACAStudentUnits.SETRANGE(Semester, Rec.Semester);
                    ACAStudentUnits.SETRANGE(Unit, Rec."Unit Code");
                    ACAStudentUnits.SETFILTER(Reversed, '%1', FALSE);
                    IF ACAStudentUnits.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            countings := countings + 1;
                            ClassAttendanceDetails.INIT;
                            ClassAttendanceDetails.Semester := Rec.Semester;
                            ClassAttendanceDetails."Attendance Date" := Rec."Attendance Date";
                            ClassAttendanceDetails."Unit Code" := Rec."Unit Code";
                            ClassAttendanceDetails."Student No." := ACAStudentUnits."Student No.";
                            ClassAttendanceDetails."Lecturer Code" := Rec."Lecturer Code";
                            ClassAttendanceDetails.Counting := countings;
                            ClassAttendanceDetails.Present := TRUE;
                            ClassAttendanceDetails.INSERT;
                        END;
                        UNTIL ACAStudentUnits.NEXT = 0;
                    END;
                END;
            end;
        }
        field(14; "Time"; Code[20])
        {

        }

    }

    keys
    {
        key(Key1; Semester, "Attendance Date", "Lecturer Code", "Unit Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ACASemester: Record "ACA-Semester";
        Customer: Record Customer;
        ClassAttendanceDetails: Record "Class Attendance Details";
        ACAStudentUnits: Record "ACA-Student Units";
        countings: Integer;
}

