page 68798 "ACA-Manual Time Table"
{
    PageType = List;
    SourceTable = 61540;

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("Day of Week"; Rec."Day of Week")
                {
                    ApplicationArea = All;
                }
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;
                }
                field(Unit; Rec.Unit)
                {
                    ApplicationArea = All;
                }
                field("Programme Option"; Rec."Programme Option")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                }
                field("Room Type"; Rec."Room Type")
                {
                    ApplicationArea = All;
                }
                field("Lecture Room"; Rec."Lecture Room")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin

                        //Check room reservation
                        LecRooms.RESET;
                        LecRooms.SETRANGE(LecRooms.Code, Rec."Lecture Room");
                        IF LecRooms.FIND('-') THEN BEGIN
                            IF LecRooms."Reserve For" <> '' THEN BEGIN
                                Prog.RESET;
                                Prog.SETRANGE(Prog.Code, Rec.Programme);
                                IF Prog.FIND('-') THEN BEGIN
                                    IF Prog.Faculty <> LecRooms."Reserve For" THEN
                                        ERROR('You can not use this room. Room has been reserved.');
                                END;

                            END;


                            //Check student availability
                            /*
                            TTable2.RESET;
                            TTable2.SETRANGE(TTable2.Released,FALSE);
                            TTable2.SETRANGE(TTable2.Programme,"Programme Code");
                            TTable2.SETRANGE(TTable2.Stage,"Stage Code");
                            TTable2.SETRANGE(TTable2.Semester,GETFILTER("Semester Filter"));
                            TTable2.SETRANGE(TTable2."Day of Week",GETFILTER("Day Filter"));
                            TTable2.SETRANGE(TTable2.Period,CurrForm.Matrix.MatrixRec.Code);
                            TTable2.SETRANGE(TTable2.Class,GETFILTER("Class Filter"));
                            IF TTable2.FIND('-') THEN
                            ERROR('Class already allocated a class at this time.');
                            */


                            TTable2.RESET;
                            TTable2.SETRANGE(TTable2.Released, FALSE);
                            TTable2.SETRANGE(TTable2.Semester, Rec.Semester);
                            TTable2.SETRANGE(TTable2.Period, Rec.Period);
                            TTable2.SETRANGE(TTable2."Day of Week", Rec."Day of Week");
                            TTable2.SETRANGE(TTable2."Lecture Room", Rec."Lecture Room");
                            IF TTable2.FIND('-') THEN BEGIN
                                IF CONFIRM('Lecture room occupied at the specified period/lesson. Do you wish to create a combined lesson?') = FALSE THEN
                                    EXIT;
                            END;

                            Lessons.RESET;
                            Lessons.SETRANGE(Lessons.Code, Rec.Period);
                            IF Lessons.FIND('-') = FALSE THEN
                                ERROR('Lesson not found.');

                            LecUnits.RESET;
                            LecUnits.SETRANGE(LecUnits.Programme, Rec.Programme);
                            LecUnits.SETRANGE(LecUnits.Stage, Rec.Stage);
                            LecUnits.SETRANGE(LecUnits.Unit, Rec.Unit);
                            LecUnits.SETRANGE(LecUnits.Semester, Rec.Semester);
                            //LecUnits.SETRANGE(LecUnits.Class,Class);
                            //LecUnits.SETRANGE(LecUnits."Unit Class","Unit Class");
                            IF LecUnits.FIND('-') THEN BEGIN
                                //Check contract hours
                                LecUnits.CALCFIELDS(LecUnits."Time Table Hours");
                                IF LecUnits."No. Of Hours Contracted" < (LecUnits."Time Table Hours" + Lessons."No Of Hours") THEN BEGIN
                                    IF CONFIRM('Lecturers contracted hours will be exceded. Do you wish to continue?') = FALSE THEN
                                        EXIT;
                                END;

                                //Check availability
                                IF (Lessons."Start Time" < LecUnits."Available From") OR (Lessons."End Time" > LecUnits."Available To") THEN BEGIN
                                    IF CONFIRM('Lecturer not available at this time as per the contract. Do you wish to continue?') = FALSE THEN
                                        EXIT;
                                END;

                                //Check lecturer conflict
                                LecUnitsTaken.RESET;
                                LecUnitsTaken.SETRANGE(LecUnitsTaken.Semester, Rec.Semester);
                                LecUnitsTaken.SETRANGE(LecUnitsTaken.Lecturer, LecUnits.Lecturer);
                                IF LecUnitsTaken.FIND('-') THEN BEGIN
                                    REPEAT
                                        TTable2.RESET;
                                        TTable2.SETRANGE(TTable2.Released, FALSE);
                                        TTable2.SETRANGE(TTable2.Programme, LecUnitsTaken.Programme);
                                        TTable2.SETRANGE(TTable2.Stage, LecUnitsTaken.Stage);
                                        TTable2.SETRANGE(TTable2.Unit, LecUnitsTaken.Unit);
                                        TTable2.SETRANGE(TTable2.Semester, Rec.Semester);
                                        TTable2.SETRANGE(TTable2.Period, Rec.Period);
                                        TTable2.SETRANGE(TTable2."Day of Week", Rec."Day of Week");
                                        TTable2.SETRANGE(TTable2.Class, Rec.Class);
                                        TTable2.SETRANGE(TTable2."Unit Class", Rec."Unit Class");
                                        IF TTable2.FIND('-') THEN BEGIN
                                            IF CONFIRM('Lecturer occupied at the specified period/lesson. Do you wish to create a combined lesson?') = FALSE THEN
                                                EXIT;
                                        END;

                                    UNTIL LecUnitsTaken.NEXT = 0

                                END;
                            END;

                            //If exam, check date
                            IF TTable.Exam <> '' THEN
                                IF Rec.GETFILTER("Exam Date") = '' THEN
                                    ERROR('You must specify the exam date.');



                            TTable2.RESET;
                            TTable2.SETRANGE(TTable2.Released, FALSE);
                            TTable2.SETRANGE(TTable2.Programme, Rec.Programme);
                            TTable2.SETRANGE(TTable2.Stage, Rec.Stage);
                            TTable2.SETRANGE(TTable2.Unit, Rec.Unit);
                            TTable2.SETRANGE(TTable2.Semester, Rec.Semester);
                            TTable2.SETRANGE(TTable2."Day of Week", Rec.Period);
                            TTable2.SETRANGE(TTable2.Class, Rec.Class);
                            TTable2.SETRANGE(TTable2."Unit Class", Rec."Unit Class");
                            TTable2.SETRANGE(TTable2.Exam, Rec.Exam);
                            IF TTable2.COUNT > 3 THEN
                                ERROR('You can not have more than 3 lessons in a day');


                            /*
                            IF "Students Registered" < Capacity THEN
                            MESSAGE('Student registered less than the Minimum capacity for this room.');

                            IF "Students Registered" > Capacity2 THEN
                            MESSAGE('Student registered more than the Maximum capacity for this room.');
                            */


                        END;

                    end;
                }
            }
        }
    }

    actions
    {
    }

    var
        PeriodCode: Boolean;
        TTable: Record "ACA-Time Table";
        Periods: Record "ACA-Day Of Week";
        xPeriodCode: Boolean;
        LecUnits: Record "ACA-Lecturers Units - Old";
        LecUnitsTaken: Record "ACA-Lecturers Units - Old";
        TTable2: Record "ACA-Time Table";
        Capacity: Integer;
        Capacity2: Integer;
        LecRooms: Record "ACA-Lecture Room";
        Lessons: Record "ACA-Lessons";
        LUnits: Record "ACA-Lecturers Units - Old";
        Emp: Record "HRM-Employee (D)";
        Lec: Code[30];
        LecE: Record "HRM-Employee (D)";
        Prog: Record "ACA-Programme";
        Prog2: Record "ACA-Programme";
        Period: Record "ACA-Lessons";
        Department: Code[20];
        RegFT: Integer;
        RegPT: Integer;
        Stages: Record "ACA-Programme Stages";
        ProgStages: Record "ACA-Programme Stages";
        PSemester: Record "ACA-Programme Semesters";
}

