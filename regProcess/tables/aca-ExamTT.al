table 40001 "Exam TimeTable"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Programs; Code[20])
        {
            TableRelation = "ACA-Programme".Code;
            trigger OnValidate()
            begin
                prog.Reset();
                prog.SetRange(Code, Programs);
                if prog.Find('-') then begin
                    "Program Name" := prog.Description;
                end;

            end;

        }
        field(2; "Program Name"; text[200])
        {

        }
        field(3; "Unit Base Code"; Code[20])
        {
            //TableRelation = "ACA-Units/Subjects".Code where("Programme Code" = field(Programs));
            trigger OnValidate()
            begin

            end;

        }
        field(4; Department; code[20])
        {

        }
        field(5; "Final Exam Date"; Date)
        {

        }
        field(6; "final exam day"; code[20])
        {
            TableRelation = "TT-Days"."Day Code";

        }
        field(7; "final Exam Time"; code[20])
        {
            //TableRelation = "EXT-Daily Periods"."Period Code";
        }
        field(8; "Final Exam Room"; code[20])
        {
            TableRelation = "ACA-Lecturer Halls Setup"."Lecture Room Code";
        }
        field(9; "Invigilator 1"; code[20])
        {

        }
        field(10; "Invigilator 2"; code[20])
        {

        }
        field(11; "Invigilator 3"; code[20])
        {

        }
        field(12; "Academic Year"; code[20])
        {
            TableRelation = "ACA-Academic Year".Code;
        }
        field(13; Semester; Code[20])
        {
            TableRelation = "ACA-Semesters";
        }
        field(14; Campus; code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(15; Stream; Text[100])
        {

        }
        field(16; LectureAllocated; Boolean)
        {

        }
        field(17; ModeofStudy; code[20])
        {
            TableRelation = "ACA-Student Types";
        }
        field(18; Lecturer; code[20])
        {
        }
        field(19; "Sitting Capacity"; Integer)
        {
            CalcFormula = lookup("ACA-Lecturer Halls Setup"."Sitting Capacity" where("Lecture Room Code" = field("Lecture Hall")));
            FieldClass = FlowField;
        }
        field(20; "Registered Students"; Integer)
        {
            CalcFormula = count("ACA-Student Units" where(Unit = field("Unit Base Code"), Semester = field(Semester), Stream = field(Stream), "Campus Code" = field(Campus), ModeOfStudy = field(ModeofStudy)));
            FieldClass = FlowField;
        }
        field(21; "Lecture Hall"; code[20])
        {
            TableRelation = "ACA-Lecturer Halls Setup"."Lecture Room Code";

        }
         field(22; Day; Code[20])
        {
            TableRelation = "TT-Days"."Day Code";

        }
        field(23; TimeSlot; code[20])
        {
            TableRelation = "TT-Daily Lessons"."Lesson Code";
        }
    }

    keys
    {
        key(Key1; "Unit Base Code", Programs, ModeofStudy, Stream, Campus, Semester,"final exam day","final Exam Time")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        prog: Record "ACA-Programme";
        units: Record "ACA-Units Offered";
        Halls: Record "ACA-Lecturer Halls Setup";
        unitAss: Record acaAssosiateUnits;
        lecturers: Record "ACA-Lecturers Units";
        CurrentSem: Record "ACA-Semester";
        unitsOff: Record "ACA-Units Offered";
        ass1: Code[20];
        ass2: code[20];
        ass3: Code[20];



}