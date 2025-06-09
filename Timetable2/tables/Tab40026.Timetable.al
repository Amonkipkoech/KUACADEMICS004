table 40026 Timetable
{
    Caption = 'Timetable';
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
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD(Programs));

            trigger OnValidate()
            var
                HRMEmployee: Record "HRM-Employee (D)";
                TimetableRec: Record Timetable;
            begin
                // Check if the unit is already allocated on the same day, week, and month
                TimetableRec.Reset();
                TimetableRec.SetRange("Academic Year", Rec."Academic Year");
                TimetableRec.SetRange(Semester, Rec.Semester);
                TimetableRec.SetRange(Department, Rec.Department);
                TimetableRec.SetRange(Programs, Rec.Programs);
                TimetableRec.SetRange("Unit Base Code", Rec."Unit Base Code");
                TimetableRec.SetRange(Day, Rec.Day);
                TimetableRec.SetRange(Week, Rec.Week);
                TimetableRec.SetRange(Month, Rec.Month);

                if TimetableRec.FindFirst() then begin
                    Message(
                        'Unit %1 is already allocated on %2 (Week %3, %4).',
                        Rec."Unit Base Code",
                        FORMAT(Rec.Day), FORMAT(Rec.Week), FORMAT(Rec.Month)
                    );
                end;

                // Fetch and assign Lecturer Name (optional and safe)
                if HRMEmployee.Get(Rec.Lecturer) then
                    "Lecturer Name" := StrSubstNo('%1 %2 %3',
                        HRMEmployee."First Name", HRMEmployee."Middle Name", HRMEmployee."Last Name");
            end;
        }

        field(4; Department; code[20])
        {

        }
        field(5; Day; Code[20])
        {
            TableRelation = "TT-Days"."Day Code";

        }
        field(6; TimeSlot; code[20])
        {
            TableRelation = "TT-Daily Lessons"."Lesson Code";
        }
        field(7; Semester; Code[20])
        {
            TableRelation = "ACA-Semesters".Code;
        }
        field(8; "Lecture Hall"; Code[20])
        {
            TableRelation = "ACA-Lecturer Halls Setup"."Lecture Room Code";

            trigger OnValidate()
            var
                LecturerHallSetup: Record "ACA-Lecturer Halls Setup";
                TimetableRec: Record Timetable;
                CleanLectureHall: Code[20];
                ErrorMsg: Text;
            begin
                CleanLectureHall := DelChr("Lecture Hall", '=', ' '); // Trim spaces

                // Check for duplicate bookings
                TimetableRec.Reset();
                TimetableRec.SetRange("Lecture Hall", CleanLectureHall);
                TimetableRec.SetRange(Day, Rec.Day);
                TimetableRec.SetRange(Month, Rec.Month);
                TimetableRec.SetRange("Academic Year", Rec."Academic Year");
                TimetableRec.SetRange(Semester, Rec.Semester);
                TimetableRec.SetRange(TimeSlot, Rec.TimeSlot);

                if TimetableRec.FindFirst() then begin
                    ErrorMsg := StrSubstNo(
                        'Lecture Hall %1 is already booked for %2 %3 in %4 (%5).',
                        CleanLectureHall, Format(Rec.Day), Format(Rec.TimeSlot), Rec.Month, Rec.Semester);
                    "Lecture Hall" := ''; // Clear field
                    Error(ErrorMsg);
                end;
            end;
        }


        field(9; "Sitting Capacity"; Integer)
        {
            // Use FlowField as backup, if needed
            CalcFormula = Lookup("ACA-Lecturer Halls Setup"."Sitting Capacity"
                        WHERE("Lecture Room Code" = FIELD("Lecture Hall")));
            FieldClass = FlowField;
        }

        field(10; "Academic Year"; code[20])
        {
            TableRelation = "ACA-Semesters"."Academic Year";
        }
        field(11; Lecturer; Code[20])
        {
            TableRelation = "HRM-Employee (D)"."No." WHERE(Lecturer = FILTER(true));

            trigger OnValidate()
            var
                HRMEmployee: Record "HRM-Employee (D)";
                TimetableRec: Record Timetable;
            begin
                // Check if the lecturer is already allocated for the same combination
                TimetableRec.Reset();
                TimetableRec.SetRange(Lecturer, Rec.Lecturer);
                TimetableRec.SetRange(Semester, rec.Semester);
                TimetableRec.SetRange("Academic Year", rec."Academic Year");
                TimetableRec.SetRange(Department, rec.Department);
                TimetableRec.SetRange(Day, Rec.Day);
                TimetableRec.SetRange(TimeSlot, Rec.TimeSlot);
                TimetableRec.SetRange(Week, Rec.Week);
                TimetableRec.SetRange(Month, Rec.Month);


                if TimetableRec.FindFirst() then begin
                    if HRMEmployee.Get(Rec.Lecturer) then
                        Error('Lecturer %1 is already allocated a class on %2 during %3 in %4.',
                            HRMEmployee."First Name" + ' ' + HRMEmployee."Middle Name" + ' ' + HRMEmployee."Last Name",
                            FORMAT(Rec.Day), FORMAT(Rec.TimeSlot), FORMAT(Rec.Month));
                end;

                // Fetch Lecturer Name
                if HRMEmployee.Get(Rec.Lecturer) then
                    "Lecturer Name" := StrSubstNo('%1 %2 %3', HRMEmployee."First Name", HRMEmployee."Middle Name", HRMEmployee."Last Name");
            end;
        }

        field(12; ModeofStudy; code[20])
        {
            TableRelation = "ACA-Student Types";
        }
        field(13; Stream; Text[100])
        {

        }
        field(14; "Registered Students"; Integer)
        {
            CalcFormula = count("ACA-Student Units" where(Unit = field("Unit Base Code"), Semester = field(Semester), Stream = field(Stream), "Campus Code" = field(Campus), ModeOfStudy = field(ModeofStudy)));
            FieldClass = FlowField;
        }
        field(15; Campus; code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(16; LectureAllocated; Boolean)
        {

        }
        field(17; "Final Exam Date"; Date)
        {

        }
        field(18; "final exam day"; code[20])
        {
            TableRelation = "TT-Days"."Day Code";

        }
        field(19; "final Exam Time"; code[20])
        {
            TableRelation = "EXT-Daily Periods"."Period Code";
        }
        field(20; "Final Exam Room"; code[20])
        {
            TableRelation = "ACA-Lecturer Halls Setup"."Lecture Room Code";
        }
        field(21; "Invigilator 1"; code[20])
        {

        }
        field(22; "Invigilator 2"; code[20])
        {

        }
        field(23; "Invigilator 3"; code[20])
        {

        }
        field(24; uniqueRecord; Boolean)
        {
            CalcFormula = exist("ACA-Units Offered" where("Unit Base Code" = field("Unit Base Code"), Semester = field(Semester), ModeofStudy = field(ModeofStudy), Day = field(Day), Stream = field(Stream)));
            FieldClass = FlowField;
        }
        field(25; "Date"; Date)
        {

        }
        field(26; "Week2"; Option)
        {
            OptionMembers = " ","WEEK ONE","WEEK TWO","WEEK THREE","WEEK FOUR","WEEK FIVE","WEEK SIX","WEEK SEVEN";

        }
        field(27; "Stage"; Code[20])
        {

        }
        field(35; "Status"; Option)
        {
            OptionMembers = open,"Pending Approval",Rejected,Approved;
        }
        field(36; "Lecturer Name"; Code[50])
        {
            // FieldClass = FlowField;
            // CalcFormula = Lookup("HRM-Employee (D)".name WHERE("No." = FIELD(Lecturer)));
        }
        field(37; "Month"; Option)
        {
            OptionMembers = January,February,March,April,May,June,July,August,September,October,November,December;
        }
        field(38; "Week"; Option)
        {
            OptionMembers = W1,W2,W3,W4,W5,W6,W7,W8,W9,W10,W11,W12,W13,W14,W15,W16,W17,W18,W19,W20,W21,W22,W23,W24,W25,W26,W27,W28,W29,W30,W31,W32,W33,W34,W35,W36,W37,W38,W39,W40,W41,W42,W43,W44,W45,W46,W47,W48,W49,W50,W51,W52,W53;
        }



    }

    keys
    {
        key(Key1; "Unit Base Code", Programs, Day, TimeSlot, Campus, Semester, "Academic Year", Lecturer, Department)
        {
            Clustered = true;
        }

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
        ass4: code[20];
        AllowAccessSetup: boolean;



    // trigger OnInsert()
    // begin
    //     //Error('You are not Allowed');
    // end;

    trigger OnModify()
    var
        usersetup: Record "User Setup";
        Nopermission: Label 'You have insufficient Rights to modify Units Allocation';
    begin
        AllowAccessSetup := true;
        if usersetup.get(UserId) then
            if (usersetup."Can modify unit Alocation") then begin
                AllowAccessSetup := usersetup."Can modify unit Alocation";
                exit
            end;
        Error(Nopermission);
    end;

    trigger OnDelete()
    var
        usersetup: Record "User Setup";
        Nopermission: Label 'You have insufficient Rights to modify Units Allocation';
    begin
        AllowAccessSetup := true;
        if usersetup.get(UserId) then
            if (usersetup."Can modify unit Alocation") then begin
                AllowAccessSetup := usersetup."Can modify unit Alocation";
                exit
            end;
        Error(Nopermission);
    end;

    // trigger OnRename()
    // begin
    //     if UserId <> 'frankie' then Error('You are mot Allowed to Modify!!');
    // end;

    procedure GetCurrentSemester() Message: Text
    begin
        CurrentSem.RESET;
        CurrentSem.SETRANGE("Current Semester", TRUE);
        IF CurrentSem.FIND('-') THEN BEGIN
            Message := CurrentSem.Code;
        END;
    end;

    procedure studentCount() studNo: Decimal
    begin
        unitAss.Reset();
        unitAss.SetRange(unitAss.UnitBaseCode, Rec."Unit Base Code");
        if unitAss.Find('-') then begin
            repeat

            until unitAss.Next() = 0;
        end;
    end;

}
