/// <summary>
/// Page EXT-Timetable Batches (ID 74550).
/// </summary>
page 74550 "EXT-Timetable Batches"
{
    Caption = 'Timetable Batches';
    PageType = List;
    SourceTable = 74550;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Current; Rec.Current)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Timetable Programs")
            {
                Caption = 'Timetable Programs';
                Image = BOM;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 74551;
                RunPageLink = "Academic Year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester);
                ApplicationArea = All;
            }
            action("Timetable Units")
            {
                Caption = 'Timetable Units';
                Image = BusinessRelation;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 74553;
                RunPageLink = "Academic Year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester);
                ApplicationArea = All;
            }
            action("Timetable Lecturers")
            {
                Caption = 'Timetable Lecturers';
                Image = Campaign;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 74554;
                RunPageLink = "Academic Year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester);
                ApplicationArea = All;
            }
            action(Blocks)
            {
                Caption = 'Blocks';
                Image = CalendarChanged;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 74519;
                RunPageLink = "Academic Year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester);
                ApplicationArea = All;
            }
            action(Rooms)
            {
                Caption = 'Lecture Halls';
                Image = Card;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 74520;
                RunPageLink = "Academic year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester);
                ApplicationArea = All;
            }
            action("Dates (Timetable Dates)")
            {
                Caption = 'Dates (Timetable Dates)';
                Image = CalendarWorkcenter;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 74556;
                RunPageLink = "Academic Year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester);
                ApplicationArea = All;
            }
            action("Periods List")
            {
                Caption = 'Periods List';
                Image = CreateRating;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 74555;
                ApplicationArea = All;
            }
            action(GenTT)
            {
                Caption = 'Generate Timetable';
                Image = GetActionMessages;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    TTLecturers: Record 74555;
                    TTProgrammes: Record 74553;
                    TTUnits: Record 74554;
                    LectLoadBatchLines: Record 65202;
                begin
                    Rec.CALCFIELDS(Current);
                    IF Rec.Current = FALSE THEN ERROR('The Semester is already closed');
                    IF CONFIRM('Generate Automatic Constraints, Continue?', FALSE) = FALSE THEN ERROR('Cancelled by user!');
                    //IF CONFIRM('You may be required to regenerate your timetable \after generating your constraints. \Continue?',TRUE)=FALSE THEN  ERROR('Cancelled by user!');

                    //Get Default Catogory
                    /*TTWeightLessonCategories.RESET;
                    TTWeightLessonCategories.SETRANGE(Semester,Rec.Semester);
                    TTWeightLessonCategories.SETRANGE("Default Category",TRUE);
                    IF TTWeightLessonCategories.FIND('-') THEN BEGIN
                      END ELSE ERROR('Defauly Unit Weighting category is not defined!');*/
                    LectLoadBatchLines.RESET;
                    LectLoadBatchLines.SETRANGE(Semester, Rec.Semester);
                    LectLoadBatchLines.SETFILTER(Unit, '<>%1', '');
                    IF LectLoadBatchLines.FIND('-') THEN BEGIN
                        TTLecturers.RESET;
                        TTLecturers.SETRANGE(Semester, Rec.Semester);
                        IF TTLecturers.FIND('-') THEN TTLecturers.DELETEALL;
                        TTProgrammes.RESET;
                        TTProgrammes.SETRANGE(Semester, Rec.Semester);
                        IF TTProgrammes.FIND('-') THEN TTProgrammes.DELETEALL;
                        /*TTUnits.RESET;
                        TTUnits.SETRANGE(Semester,Rec.Semester);
                        TTUnits.SETFILTER("Weighting Category",'<>%1',TTWeightLessonCategories."Category Code");
                        IF TTUnits.FIND('-') THEN TTUnits.DELETEALL;*/
                        REPEAT
                        BEGIN
                            TTLecturers.RESET;
                            TTLecturers.SETRANGE("Academic Year", Rec."Academic Year");
                            TTLecturers.SETRANGE(Semester, Rec.Semester);
                            TTLecturers.SETRANGE("Lecturer Code", LectLoadBatchLines.Lecturer);
                            IF NOT (TTLecturers.FIND('-')) THEN BEGIN
                                //Insert
                                TTLecturers.INIT;
                                TTLecturers."Academic Year" := Rec."Academic Year";
                                TTLecturers.Semester := Rec.Semester;
                                TTLecturers."Lecturer Code" := LectLoadBatchLines.Lecturer;
                                TTLecturers.INSERT;
                            END;
                            TTProgrammes.RESET;
                            TTProgrammes.SETRANGE("Academic Year", Rec."Academic Year");
                            TTProgrammes.SETRANGE(Semester, Rec.Semester);
                            TTProgrammes.SETRANGE("Programme Code", LectLoadBatchLines.Programme);
                            IF NOT (TTProgrammes.FIND('-')) THEN BEGIN
                                //Insert
                                TTProgrammes.INIT;
                                TTProgrammes."Academic Year" := Rec."Academic Year";
                                TTProgrammes.Semester := Rec.Semester;
                                TTProgrammes."Programme Code" := LectLoadBatchLines.Programme;
                                TTProgrammes.INSERT;
                            END;
                            TTUnits.RESET;
                            TTUnits.SETRANGE("Academic Year", Rec."Academic Year");
                            TTUnits.SETRANGE(Semester, Rec.Semester);
                            TTUnits.SETRANGE("Programme Code", LectLoadBatchLines.Programme);
                            TTUnits.SETRANGE("Unit Code", LectLoadBatchLines.Unit);
                            IF NOT (TTUnits.FIND('-')) THEN BEGIN
                                //Insert
                                TTUnits.INIT;
                                TTUnits."Academic Year" := Rec."Academic Year";
                                TTUnits.Semester := Rec.Semester;
                                TTUnits."Programme Code" := LectLoadBatchLines.Programme;
                                TTUnits."Unit Code" := LectLoadBatchLines.Unit;
                                //TTUnits."Weighting Category":=TTWeightLessonCategories."Category Code";
                                TTUnits.INSERT;
                            END;
                        END;
                        UNTIL LectLoadBatchLines.NEXT = 0;
                    END ELSE
                        ERROR('Caurse loading for the current Semester has not been done!');

                    //IF CONFIRM('Re-Generate the timetable Entries?',TRUE)=FALSE THEN EXIT;
                    GenerateEntriesSingles;
                    SpecificConstraintsProgCampuses;
                    SpecificConstraintsLectCampuses;
                    SpecificConstraintsUnitCampuses;
                    SpecificConstraintsUnitRooms;
                    SpecificConstraintsProgDays;
                    SpecificConstraintsLectDays;
                    ThiningSingles;
                    FinalCompilation;


                    MESSAGE('Done!');

                end;
            }
            action(MasterRep1)
            {
                Caption = 'Master Timetable';
                Image = MovementWorksheet;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    TTTimetableFInalCollector.RESET;
                    TTTimetableFInalCollector.SETRANGE(Semester, Rec.Semester);
                    IF TTTimetableFInalCollector.FIND('-') THEN
                        REPORT.RUN(74550, TRUE, FALSE, TTTimetableFInalCollector);
                end;
            }
            action(MasterRep2)
            {
                Caption = 'Master Timetable 2';
                Image = AnalysisViewDimension;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    TTTimetableFInalCollector.RESET;
                    TTTimetableFInalCollector.SETRANGE(Semester, Rec.Semester);
                    IF TTTimetableFInalCollector.FIND('-') THEN
                        REPORT.RUN(74551, TRUE, FALSE, TTTimetableFInalCollector);
                end;
            }
            action(DistribRep)
            {
                Caption = 'Timetable Destribution';
                Image = DistributionGroup;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    EXTUnits: Record 74554;
                begin
                    EXTUnits.RESET;
                    EXTUnits.SETRANGE(Semester, Rec.Semester);
                    IF EXTUnits.FIND('-') THEN
                        REPORT.RUN(74552, TRUE, FALSE, EXTUnits);
                end;
            }
            action("TImetable Preview")
            {
                Caption = 'TImetable Preview';
                Image = PreviewChecks;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page 74560;
                RunPageLink = Semester = FIELD(Semester);
                ApplicationArea = All;
            }
        }
    }

    var
        CountedEntries: Integer;
        TTTimetableFInalCollector: Record 74568;
        EXTUnitSpecRooms: Record 74565;

    local procedure GenerateEntriesSingles()
    var
        TTRooms: Record 74501;
        TTDailyLessons: Record 74552;
        ACALecturersUnits: Record 65202;
        TTTimetableCollectorA: Record 74557;
        LectLoadBatchLines: Record 65201;
        ACAProgramme: Record 61511;
        ACAUnitsSubjects: Record 61517;
        TTUnits: Record 74554;
        TTLessons: Record 74556;
        TTDays: Record 74551;
        progre: Dialog;
        counts: Integer;
        RecCount1: Text[120];
        RecCount2: Text[120];
        RecCount3: Text[120];
        RecCount4: Text[120];
        RecCount5: Text[120];
        RecCount6: Text[120];
        RecCount7: Text[120];
        RecCount8: Text[120];
        RecCount9: Text[120];
        RecCount10: Text[120];
        BufferString: Text[1024];
        Var1: Code[10];

        progDots: Text[50];
        counted: Integer;
        text1: Label '*';
        text2: Label '**';
        text3: Label '***';
        text4: Label '****';
        text5: Label '*****';
        text6: Label '******';
        text7: Label '*******';
        text8: Label '********';
        text9: Label '*********';
        text10: Label '**********';
        UnitSpecRoom: Integer;
        ProgSpecRoom: Integer;
        LectSpecLessons: Integer;
        UnitSpecCampus: Integer;
        ProgSpecCampuses: Integer;
        LectSpecCampuses: Integer;
        LectSpecDays: Integer;
        ProgSpecDays: Integer;
        TTProgSpecCampuses: Record 74558;
        TTProgSpecDays: Record 74559;
        TTUnitSpecCampuses: Record 74564;
        TTUnitSpecRooms: Record 74565;
        TTLectSpecCampuses: Record 74560;
        TTLectSpecDays: Record 74561;
        TTLectSpecLessons: Record 74562;
        recordsFound: Integer;
    begin
        /////////////////////////////////////////////////////////////////////////////////////////////Progress Initiate
        CLEAR(progDots);
        CLEAR(RecCount1);
        CLEAR(RecCount2);
        CLEAR(RecCount3);
        CLEAR(RecCount4);
        CLEAR(RecCount5);
        CLEAR(RecCount6);
        CLEAR(RecCount7);
        CLEAR(RecCount8);
        CLEAR(RecCount9);
        CLEAR(RecCount10);
        CLEAR(counts);
        progre.OPEN('Generating SINGLE Class Entries: #1#############################' +
        '\ ' +
        '\#2###############################################################' +
        '\#3###############################################################' +
        '\#4###############################################################' +
        '\#5###############################################################' +
        '\#6###############################################################' +
        '\#7###############################################################' +
        '\#8###############################################################' +
        '\#9###############################################################' +
        '\#10###############################################################' +
        '\#11###############################################################' +
        '\#12###############################################################' +
        '\#13###############################################################' +
        '\#14###############################################################',
            progDots,
            RecCount1,
            RecCount2,
            RecCount3,
            RecCount4,
            RecCount5,
            RecCount6,
            RecCount7,
            RecCount8,
            RecCount9,
            RecCount10,
            Var1,
            Var1,
            BufferString
        );
        /////////////////////////////////////////////////////////////////////////////////////////////Progress Initiate
        CLEAR(recordsFound);
        TTTimetableCollectorA.RESET;
        TTTimetableCollectorA.SETRANGE(Semester, Rec.Semester);
        IF TTTimetableCollectorA.FIND('-') THEN TTTimetableCollectorA.DELETEALL;
        CLEAR(CountedEntries);
        TTRooms.RESET;
        TTRooms.SETRANGE(Semester, Rec.Semester);
        IF TTRooms.FIND('-') THEN BEGIN

            TTDailyLessons.RESET;
            TTDailyLessons.SETRANGE(Semester, Rec.Semester);
            IF TTDailyLessons.FIND('-') THEN;
            ACALecturersUnits.RESET;
            ACALecturersUnits.SETRANGE(Semester, Rec.Semester);
            IF ACALecturersUnits.FIND('-') THEN;
            recordsFound := ACALecturersUnits.COUNT * TTDailyLessons.COUNT * TTRooms.COUNT;
            REPEAT
            BEGIN
                TTDailyLessons.RESET;
                TTDailyLessons.SETRANGE(Semester, Rec.Semester);
                IF TTDailyLessons.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        TTLessons.RESET;
                        TTLessons.SETRANGE("Period Code", TTDailyLessons."Period Code");
                        IF TTLessons.FIND('-') THEN;
                        TTDays.RESET;
                        TTDays.SETRANGE("Date Code", TTDailyLessons."Date Code");
                        TTDays.SETRANGE(Semester, Rec.Semester);
                        IF TTDays.FIND('-') THEN;
                        ACALecturersUnits.RESET;
                        ACALecturersUnits.SETRANGE(Semester, Rec.Semester);
                        IF ACALecturersUnits.FIND('-') THEN BEGIN
                            REPEAT
                            BEGIN
                                ///////////////////////////////////////////////////////////////////////////////Progress Update
                                CLEAR(Var1);
                                counts := counts + 1;
                                IF ((counted = 21) OR (counted = 11)) THEN BEGIN
                                    IF counted = 21 THEN counted := 0;
                                    //SLEEP(150);
                                END;
                                counted := counted + 1;
                                IF counted = 1 THEN
                                    progDots := text1
                                ELSE
                                    IF counted = 2 THEN
                                        progDots := text2
                                    ELSE
                                        IF counted = 3 THEN
                                            progDots := text3
                                        ELSE
                                            IF counted = 4 THEN
                                                progDots := text4
                                            ELSE
                                                IF counted = 5 THEN
                                                    progDots := text5
                                                ELSE
                                                    IF counted = 6 THEN
                                                        progDots := text6
                                                    ELSE
                                                        IF counted = 7 THEN
                                                            progDots := text7
                                                        ELSE
                                                            IF counted = 8 THEN
                                                                progDots := text8
                                                            ELSE
                                                                IF counted = 9 THEN
                                                                    progDots := text9
                                                                ELSE
                                                                    IF counted = 10 THEN
                                                                        progDots := text10
                                                                    ELSE
                                                                        IF counted = 19 THEN
                                                                            progDots := text1
                                                                        ELSE
                                                                            IF counted = 18 THEN
                                                                                progDots := text2
                                                                            ELSE
                                                                                IF counted = 17 THEN
                                                                                    progDots := text3
                                                                                ELSE
                                                                                    IF counted = 16 THEN
                                                                                        progDots := text4
                                                                                    ELSE
                                                                                        IF counted = 15 THEN
                                                                                            progDots := text5
                                                                                        ELSE
                                                                                            IF counted = 14 THEN
                                                                                                progDots := text6
                                                                                            ELSE
                                                                                                IF counted = 13 THEN
                                                                                                    progDots := text7
                                                                                                ELSE
                                                                                                    IF counted = 12 THEN
                                                                                                        progDots := text8
                                                                                                    ELSE
                                                                                                        IF counted = 11 THEN
                                                                                                            progDots := text9
                                                                                                        ELSE
                                                                                                            progDots := '';

                                IF counts = 1 THEN
                                    RecCount1 := FORMAT(counts) + '). ' + 'Day: ' + FORMAT(TTDays."Date Code") + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                ELSE
                                    IF counts = 2 THEN BEGIN
                                        RecCount2 := FORMAT(counts) + '). ' + 'Day: ' + FORMAT(TTDays."Date Code") + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                    ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                    END
                                    ELSE
                                        IF counts = 3 THEN BEGIN
                                            RecCount3 := FORMAT(counts) + '). ' + 'Day: ' + FORMAT(TTDays."Date Code") + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                        ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                        END
                                        ELSE
                                            IF counts = 4 THEN BEGIN
                                                RecCount4 := FORMAT(counts) + '). ' + 'Day: ' + FORMAT(TTDays."Date Code") + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                            ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                            END
                                            ELSE
                                                IF counts = 5 THEN BEGIN
                                                    RecCount5 := FORMAT(counts) + '). ' + 'Day: ' + FORMAT(TTDays."Date Code") + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                                ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                                END
                                                ELSE
                                                    IF counts = 6 THEN BEGIN
                                                        RecCount6 := FORMAT(counts) + '). ' + 'Day: ' + FORMAT(TTDays."Date Code") + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                                    ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                                    END
                                                    ELSE
                                                        IF counts = 7 THEN BEGIN
                                                            RecCount7 := FORMAT(counts) + '). ' + 'Day: ' + FORMAT(TTDays."Date Code") + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                                        ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                                        END
                                                        ELSE
                                                            IF counts = 8 THEN BEGIN
                                                                RecCount8 := FORMAT(counts) + '). ' + 'Day: ' + FORMAT(TTDays."Date Code") + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                                            ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                                            END
                                                            ELSE
                                                                IF counts = 9 THEN BEGIN
                                                                    RecCount9 := FORMAT(counts) + '). ' + 'Day: ' + FORMAT(TTDays."Date Code") + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                                                ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                                                END
                                                                ELSE
                                                                    IF counts = 10 THEN BEGIN
                                                                        RecCount10 := FORMAT(counts) + '). ' + 'Day: ' + FORMAT(TTDays."Date Code") + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                                                    ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                                                    END ELSE
                                                                        IF counts > 10 THEN BEGIN
                                                                            RecCount1 := RecCount2;
                                                                            RecCount2 := RecCount3;
                                                                            RecCount3 := RecCount4;
                                                                            RecCount4 := RecCount5;
                                                                            RecCount5 := RecCount6;
                                                                            RecCount6 := RecCount7;
                                                                            RecCount7 := RecCount8;
                                                                            RecCount8 := RecCount9;
                                                                            RecCount9 := RecCount10;
                                                                            RecCount10 := FORMAT(counts) + '). ' + 'Day: ' + FORMAT(TTDays."Date Code") + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                                                        ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code";
                                                                        END;
                                CLEAR(BufferString);
                                BufferString := 'Processed : ' + FORMAT(counts) + '; Remaining : ' + FORMAT(recordsFound - counts);

                                progre.UPDATE();
                                // //SLEEP(50);
                                ///////////////////////////////////////////////////////////////////////////////Progress Update
                                //Check for Specific Constraints
                                ProgSpecCampuses := 5;
                                ProgSpecDays := 5;
                                ProgSpecRoom := 5;
                                UnitSpecCampus := 5;
                                UnitSpecRoom := 5;
                                LectSpecCampuses := 5;
                                LectSpecDays := 5;
                                LectSpecLessons := 5;
                                TTProgSpecCampuses.RESET;
                                TTProgSpecCampuses.SETRANGE(Semester, Rec.Semester);
                                TTProgSpecCampuses.SETRANGE("Programme Code", ACALecturersUnits.Programme);
                                TTProgSpecCampuses.SETFILTER("Campus Code", '%1', ACALecturersUnits."Campus Code");
                                IF TTProgSpecCampuses.FIND('-') THEN BEGIN
                                    IF TTProgSpecCampuses."Constraint Category" = TTProgSpecCampuses."Constraint Category"::Avoid THEN
                                        ProgSpecCampuses := 666
                                    ELSE
                                        IF TTProgSpecCampuses."Constraint Category" = TTProgSpecCampuses."Constraint Category"::"Least Preferred" THEN
                                            ProgSpecCampuses := 333
                                        ELSE
                                            IF TTProgSpecCampuses."Constraint Category" = TTProgSpecCampuses."Constraint Category"::Preferred THEN
                                                ProgSpecCampuses := 3
                                            ELSE
                                                IF TTProgSpecCampuses."Constraint Category" = TTProgSpecCampuses."Constraint Category"::Mandatory THEN ProgSpecCampuses := 1;
                                END;

                                TTProgSpecDays.RESET;
                                TTProgSpecDays.SETRANGE(Semester, Rec.Semester);
                                TTProgSpecDays.SETRANGE("Programme Code", ACALecturersUnits.Programme);
                                TTProgSpecDays.SETFILTER("Date Code", '%1', TTDailyLessons."Date Code");
                                IF TTProgSpecDays.FIND('-') THEN BEGIN
                                    IF TTProgSpecDays."Constraint Category" = TTProgSpecDays."Constraint Category"::Avoid THEN
                                        ProgSpecDays := 666
                                    ELSE
                                        IF TTProgSpecDays."Constraint Category" = TTProgSpecDays."Constraint Category"::"Least Preferred" THEN
                                            ProgSpecDays := 333
                                        ELSE
                                            IF TTProgSpecDays."Constraint Category" = TTProgSpecDays."Constraint Category"::Preferred THEN
                                                ProgSpecDays := 3
                                            ELSE
                                                IF TTProgSpecDays."Constraint Category" = TTProgSpecDays."Constraint Category"::Mandatory THEN ProgSpecDays := 1;
                                END;

                                // // // // // //                     TTProgSpecRooms.RESET;
                                // // // // // //                     TTProgSpecRooms.SETRANGE(Semester,Rec.Semester);
                                // // // // // //                     TTProgSpecRooms.SETRANGE("Programme Code",ACALecturersUnits.Programme);
                                // // // // // //                     TTProgSpecRooms.SETFILTER("Room Code",'%1',TTRooms."Room Code");
                                // // // // // //                     IF TTProgSpecRooms.FIND('-') THEN BEGIN
                                // // // // // //                       IF TTProgSpecRooms."Constraint Category"=TTProgSpecRooms."Constraint Category"::Avoid THEN ProgSpecRoom:=666
                                // // // // // //                       ELSE IF TTProgSpecRooms."Constraint Category"=TTProgSpecRooms."Constraint Category"::"Least Preferred" THEN ProgSpecRoom:=333
                                // // // // // //                       ELSE IF TTProgSpecRooms."Constraint Category"=TTProgSpecRooms."Constraint Category"::Preferred THEN ProgSpecRoom:=3
                                // // // // // //                       ELSE IF TTProgSpecRooms."Constraint Category"=TTProgSpecRooms."Constraint Category"::Mandatory THEN ProgSpecRoom:=1;
                                // // // // // //                       END;
                                //---- Lecturer

                                TTLectSpecCampuses.RESET;
                                TTLectSpecCampuses.SETRANGE(Semester, Rec.Semester);
                                TTLectSpecCampuses.SETRANGE("Lecturer Code", ACALecturersUnits.Lecturer);
                                TTLectSpecCampuses.SETFILTER("Campus Code", '%1', ACALecturersUnits."Campus Code");
                                IF TTLectSpecCampuses.FIND('-') THEN BEGIN
                                    IF TTLectSpecCampuses."Constraint Category" = TTLectSpecCampuses."Constraint Category"::Avoid THEN
                                        LectSpecCampuses := 666
                                    ELSE
                                        IF TTLectSpecCampuses."Constraint Category" = TTLectSpecCampuses."Constraint Category"::"Least Preferred" THEN
                                            LectSpecCampuses := 333
                                        ELSE
                                            IF TTLectSpecCampuses."Constraint Category" = TTLectSpecCampuses."Constraint Category"::Preferred THEN
                                                LectSpecCampuses := 3
                                            ELSE
                                                IF TTLectSpecCampuses."Constraint Category" = TTLectSpecCampuses."Constraint Category"::Mandatory THEN LectSpecCampuses := 1;
                                END;

                                TTLectSpecLessons.RESET;
                                TTLectSpecLessons.SETRANGE(Semester, Rec.Semester);
                                TTLectSpecLessons.SETRANGE("Lecturer Code", ACALecturersUnits.Lecturer);
                                TTLectSpecLessons.SETFILTER("Lesson Code", '%1', TTDailyLessons."Period Code");
                                IF TTLectSpecLessons.FIND('-') THEN BEGIN
                                    IF TTLectSpecLessons."Constraint Category" = TTLectSpecLessons."Constraint Category"::Avoid THEN
                                        LectSpecLessons := 666
                                    ELSE
                                        IF TTLectSpecLessons."Constraint Category" = TTLectSpecLessons."Constraint Category"::"Least Preferred" THEN
                                            LectSpecLessons := 333
                                        ELSE
                                            IF TTLectSpecLessons."Constraint Category" = TTLectSpecLessons."Constraint Category"::Preferred THEN
                                                LectSpecLessons := 3
                                            ELSE
                                                IF TTLectSpecLessons."Constraint Category" = TTLectSpecLessons."Constraint Category"::Mandatory THEN LectSpecLessons := 1;
                                END;

                                TTLectSpecDays.RESET;
                                TTLectSpecDays.SETRANGE(Semester, Rec.Semester);
                                TTLectSpecDays.SETRANGE("Lecturer Code", ACALecturersUnits.Lecturer);
                                TTLectSpecDays.SETFILTER("Date Code", '%1', TTDailyLessons."Date Code");
                                IF TTLectSpecDays.FIND('-') THEN BEGIN
                                    IF TTLectSpecDays."Constraint Category" = TTLectSpecDays."Constraint Category"::Avoid THEN
                                        LectSpecDays := 666
                                    ELSE
                                        IF TTLectSpecDays."Constraint Category" = TTLectSpecDays."Constraint Category"::"Least Preferred" THEN
                                            LectSpecDays := 333
                                        ELSE
                                            IF TTLectSpecDays."Constraint Category" = TTLectSpecDays."Constraint Category"::Preferred THEN
                                                LectSpecDays := 3
                                            ELSE
                                                IF TTLectSpecDays."Constraint Category" = TTLectSpecDays."Constraint Category"::Mandatory THEN LectSpecDays := 1;
                                END;

                                TTUnitSpecCampuses.RESET;
                                TTUnitSpecCampuses.SETRANGE(Semester, Rec.Semester);
                                TTUnitSpecCampuses.SETRANGE("Programme Code", ACALecturersUnits.Programme);
                                TTUnitSpecCampuses.SETFILTER("Campus Code", '%1', ACALecturersUnits."Campus Code");
                                TTUnitSpecCampuses.SETFILTER("Unit Code", '%1', ACALecturersUnits.Unit);
                                IF TTUnitSpecCampuses.FIND('-') THEN BEGIN
                                    IF TTUnitSpecCampuses."Constraint Category" = TTUnitSpecCampuses."Constraint Category"::Avoid THEN
                                        UnitSpecCampus := 666
                                    ELSE
                                        IF TTUnitSpecCampuses."Constraint Category" = TTUnitSpecCampuses."Constraint Category"::"Least Preferred" THEN
                                            UnitSpecCampus := 333
                                        ELSE
                                            IF TTUnitSpecCampuses."Constraint Category" = TTUnitSpecCampuses."Constraint Category"::Preferred THEN
                                                UnitSpecCampus := 3
                                            ELSE
                                                IF TTUnitSpecCampuses."Constraint Category" = TTUnitSpecCampuses."Constraint Category"::Mandatory THEN UnitSpecCampus := 1;
                                END;

                                TTUnitSpecRooms.RESET;
                                TTUnitSpecRooms.SETRANGE(Semester, Rec.Semester);
                                TTUnitSpecRooms.SETRANGE("Programme Code", ACALecturersUnits.Programme);
                                TTUnitSpecRooms.SETFILTER("Unit Code", '%1', ACALecturersUnits.Unit);
                                TTUnitSpecRooms.SETFILTER("Room Code", '%1', TTRooms."Room Code");
                                IF TTUnitSpecRooms.FIND('-') THEN BEGIN
                                    IF TTUnitSpecRooms."Constraint Category" = TTUnitSpecRooms."Constraint Category"::Avoid THEN
                                        UnitSpecRoom := 666
                                    ELSE
                                        IF TTUnitSpecRooms."Constraint Category" = TTUnitSpecRooms."Constraint Category"::"Least Preferred" THEN
                                            UnitSpecRoom := 333
                                        ELSE
                                            IF TTUnitSpecRooms."Constraint Category" = TTUnitSpecRooms."Constraint Category"::Preferred THEN
                                                UnitSpecRoom := 3
                                            ELSE
                                                IF TTUnitSpecRooms."Constraint Category" = TTUnitSpecRooms."Constraint Category"::Mandatory THEN UnitSpecRoom := 1;
                                END;
                                LectLoadBatchLines.RESET;
                                LectLoadBatchLines.SETRANGE("Lecturer Code", ACALecturersUnits.Lecturer);
                                LectLoadBatchLines.SETRANGE("Semester Code", Rec.Semester);
                                IF LectLoadBatchLines.FIND('-') THEN;
                                TTUnits.RESET;
                                TTUnits.SETRANGE(Semester, Rec.Semester);
                                TTUnits.SETRANGE("Programme Code", ACALecturersUnits.Programme);
                                TTUnits.SETRANGE("Unit Code", ACALecturersUnits.Unit);
                                IF TTUnits.FIND('-') THEN;

                                TTTimetableCollectorA.RESET;
                                TTTimetableCollectorA.SETRANGE(Programme, ACALecturersUnits.Programme);
                                TTTimetableCollectorA.SETRANGE(Unit, ACALecturersUnits.Unit);
                                TTTimetableCollectorA.SETRANGE(Semester, Rec.Semester);
                                TTTimetableCollectorA.SETRANGE("Lesson Code", TTDailyLessons."Period Code");
                                TTTimetableCollectorA.SETRANGE("Date Code", TTDailyLessons."Date Code");
                                TTTimetableCollectorA.SETRANGE("Lecture Room", TTRooms."Room Code");
                                TTTimetableCollectorA.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                // TTTimetableCollectorA.SETRANGE("Campus Code",ACALecturersUnits.);
                                // TTTimetableCollectorA.SETRANGE(Department,LectLoadBatchLines,Department);
                                TTTimetableCollectorA.SETRANGE("Room Code", TTRooms."Room Code");
                                // TTTimetableCollectorA.SETRANGE("Block/Building",TTRooms."Block Code");
                                TTTimetableCollectorA.SETRANGE("Lesson Category", TTUnits."Weighting Category");
                                // TTTimetableCollectorA.SETRANGE("School or Faculty",LectLoadBatchLines.Faculty);
                                IF TTTimetableCollectorA.FIND('-') THEN BEGIN
                                END ELSE BEGIN
                                    TTTimetableCollectorA.INIT;
                                    TTTimetableCollectorA.Programme := ACALecturersUnits.Programme;
                                    TTTimetableCollectorA.Unit := ACALecturersUnits.Unit;
                                    TTTimetableCollectorA.Semester := Rec.Semester;
                                    TTTimetableCollectorA."Lesson Code" := TTDailyLessons."Period Code";
                                    TTTimetableCollectorA."Lesson Category" := TTUnits."Weighting Category";
                                    TTTimetableCollectorA."Date Code" := TTDailyLessons."Date Code";
                                    TTTimetableCollectorA."Lecture Room" := TTRooms."Room Code";
                                    TTTimetableCollectorA.Lecturer := LectLoadBatchLines."Lecturer Code";
                                    TTTimetableCollectorA.Department := LectLoadBatchLines."Department Code";
                                    TTTimetableCollectorA."Day Order" := TTDays."Day Order";
                                    TTTimetableCollectorA."Lesson Order" := TTLessons."Period Order";
                                    //  TTTimetableCollectorA."Programme Option":=;
                                    TTTimetableCollectorA."Room Type" := TTRooms."Room Type";
                                    TTTimetableCollectorA."Room Code" := TTRooms."Room Code";
                                    TTTimetableCollectorA."Block/Building" := TTRooms."Block Code";
                                    TTTimetableCollectorA."School or Faculty" := LectLoadBatchLines.Faculty;
                                    TTTimetableCollectorA."Campus Code" := ACALecturersUnits."Campus Code";
                                    TTTimetableCollectorA."Programme Campus Priority" := ProgSpecCampuses;
                                    TTTimetableCollectorA."Programme Day Priority" := ProgSpecDays;
                                    TTTimetableCollectorA."Programme Room Priority" := ProgSpecRoom;
                                    TTTimetableCollectorA."Lecturer Campus Priority" := LectSpecCampuses;
                                    TTTimetableCollectorA."Lecturer Day Priority" := LectSpecDays;
                                    TTTimetableCollectorA."Lecturer Lesson Priority" := LectSpecLessons;
                                    TTTimetableCollectorA."Unit Campus Priority" := UnitSpecCampus;
                                    TTTimetableCollectorA."Unit Room Priority" := UnitSpecRoom;
                                    TTTimetableCollectorA."Class Code" := ACALecturersUnits.Class;
                                    IF ((Rec.Semester <> '') AND (TTRooms."Room Code" <> '') AND (LectLoadBatchLines."Lecturer Code" <> '')) THEN BEGIN
                                        CountedEntries := CountedEntries + 1;
                                        TTTimetableCollectorA."Record ID" := CountedEntries;

                                        IF TTRooms."Room Type" <> TTRooms."Room Type"::Class THEN BEGIN
                                            EXTUnitSpecRooms.RESET;
                                            EXTUnitSpecRooms.SETRANGE(Semester, Rec.Semester);
                                            EXTUnitSpecRooms.SETRANGE("Programme Code", ACALecturersUnits.Programme);
                                            EXTUnitSpecRooms.SETRANGE("Unit Code", ACALecturersUnits.Unit);
                                            EXTUnitSpecRooms.SETRANGE("Room Code", TTRooms."Room Code");
                                            IF EXTUnitSpecRooms.FIND('-') THEN TTTimetableCollectorA.INSERT;
                                        END ELSE
                                            TTTimetableCollectorA.INSERT;
                                    END;
                                END;
                            END;

                            UNTIL ACALecturersUnits.NEXT = 0;
                        END;
                    END;
                    UNTIL TTDailyLessons.NEXT = 0;
                END;
            END;
            UNTIL TTRooms.NEXT = 0;
        END;

        progre.CLOSE;
    end;

    local procedure ThiningSingles()
    var
        TTRooms: Record 74501;
        TTDailyLessons: Record 74552;
        ACALecturersUnits: Record 65202;
        ACALecturersUnits2: Record 65202;
        TTTimetableCollectorA: Record 74557;
        TTTimetableCollectorA1: Record 74557;
        TTTimetableCollectorA2: Record 74557;
        LectLoadBatchLines: Record 65201;
        ACAProgramme: Record 61511;
        ACAUnitsSubjects: Record 61517;
        ACAUnitsSubjects2: Record 61517;
        TTUnits: Record 74554;
        TTLessons: Record 74556;
        TTDays: Record 74551;
        Loops: Integer;
        progre: Dialog;
        counts: Integer;
        RecCount1: Text[120];
        RecCount2: Text[120];
        RecCount3: Text[120];
        RecCount4: Text[120];
        RecCount5: Text[120];
        RecCount6: Text[120];
        RecCount7: Text[120];
        RecCount8: Text[120];
        RecCount9: Text[120];
        RecCount10: Text[120];
        BufferString: Text[1024];
        Var1: Code[10];

        progDots: Text[50];
        counted: Integer;
        text1: Label '*';
        text2: Label '**';
        text3: Label '***';
        text4: Label '****';
        text5: Label '*****';
        text6: Label '******';
        text7: Label '*******';
        text8: Label '********';
        text9: Label '*********';
        text10: Label '**********';
        CurrLessonOrder: Integer;
        NextLessonOrder: Integer;
    begin
        /////////////////////////////////////////////////////////////////////////////////////////////Progress Initiate
        CLEAR(progDots);
        CLEAR(RecCount1);
        CLEAR(RecCount2);
        CLEAR(RecCount3);
        CLEAR(RecCount4);
        CLEAR(RecCount5);
        CLEAR(RecCount6);
        CLEAR(RecCount7);
        CLEAR(RecCount8);
        CLEAR(RecCount9);
        CLEAR(RecCount10);
        CLEAR(counts);
        progre.OPEN('Building Timetable:  #1#############################' +
        '\ ' +
        '\#2###############################################################' +
        '\#3###############################################################' +
        '\#4###############################################################' +
        '\#5###############################################################' +
        '\#6###############################################################' +
        '\#7###############################################################' +
        '\#8###############################################################' +
        '\#9###############################################################' +
        '\#10###############################################################' +
        '\#11###############################################################' +
        '\#12###############################################################' +
        '\#13###############################################################' +
        '\#14###############################################################',
            progDots,
            RecCount1,
            RecCount2,
            RecCount3,
            RecCount4,
            RecCount5,
            RecCount6,
            RecCount7,
            RecCount8,
            RecCount9,
            RecCount10,
            Var1,
            Var1,
            BufferString
        );
        /////////////////////////////////////////////////////////////////////////////////////////////Progress Initiate
        ACALecturersUnits.RESET;
        ACALecturersUnits.SETRANGE(Semester, Rec.Semester);
        IF ACALecturersUnits.FIND('-') THEN BEGIN

            REPEAT
            BEGIN
                BEGIN
                    ///////////////////////////////////////////////////////////////////////////////Progress Update
                    CLEAR(Var1);
                    counts := counts + 1;
                    IF ((counted = 21) OR (counted = 11)) THEN BEGIN
                        IF counted = 21 THEN counted := 0;
                        //SLEEP(150);
                    END;
                    counted := counted + 1;
                    IF counted = 1 THEN
                        progDots := text1
                    ELSE
                        IF counted = 2 THEN
                            progDots := text2
                        ELSE
                            IF counted = 3 THEN
                                progDots := text3
                            ELSE
                                IF counted = 4 THEN
                                    progDots := text4
                                ELSE
                                    IF counted = 5 THEN
                                        progDots := text5
                                    ELSE
                                        IF counted = 6 THEN
                                            progDots := text6
                                        ELSE
                                            IF counted = 7 THEN
                                                progDots := text7
                                            ELSE
                                                IF counted = 8 THEN
                                                    progDots := text8
                                                ELSE
                                                    IF counted = 9 THEN
                                                        progDots := text9
                                                    ELSE
                                                        IF counted = 10 THEN
                                                            progDots := text10
                                                        ELSE
                                                            IF counted = 19 THEN
                                                                progDots := text1
                                                            ELSE
                                                                IF counted = 18 THEN
                                                                    progDots := text2
                                                                ELSE
                                                                    IF counted = 17 THEN
                                                                        progDots := text3
                                                                    ELSE
                                                                        IF counted = 16 THEN
                                                                            progDots := text4
                                                                        ELSE
                                                                            IF counted = 15 THEN
                                                                                progDots := text5
                                                                            ELSE
                                                                                IF counted = 14 THEN
                                                                                    progDots := text6
                                                                                ELSE
                                                                                    IF counted = 13 THEN
                                                                                        progDots := text7
                                                                                    ELSE
                                                                                        IF counted = 12 THEN
                                                                                            progDots := text8
                                                                                        ELSE
                                                                                            IF counted = 11 THEN
                                                                                                progDots := text9
                                                                                            ELSE
                                                                                                progDots := '';

                    IF counts = 1 THEN
                        RecCount1 := FORMAT(counts) + '). Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                    ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                    ELSE
                        IF counts = 2 THEN BEGIN
                            RecCount2 := FORMAT(counts) + '). Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                        ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                        END
                        ELSE
                            IF counts = 3 THEN BEGIN
                                RecCount3 := FORMAT(counts) + '). Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                            ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                            END
                            ELSE
                                IF counts = 4 THEN BEGIN
                                    RecCount4 := FORMAT(counts) + '). Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                END
                                ELSE
                                    IF counts = 5 THEN BEGIN
                                        RecCount5 := FORMAT(counts) + '). Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                    ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                    END
                                    ELSE
                                        IF counts = 6 THEN BEGIN
                                            RecCount6 := FORMAT(counts) + '). Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                        ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                        END
                                        ELSE
                                            IF counts = 7 THEN BEGIN
                                                RecCount7 := FORMAT(counts) + '). Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                            ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                            END
                                            ELSE
                                                IF counts = 8 THEN BEGIN
                                                    RecCount8 := FORMAT(counts) + '). Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                                ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                                END
                                                ELSE
                                                    IF counts = 9 THEN BEGIN
                                                        RecCount9 := FORMAT(counts) + '). Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                                    ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                                    END
                                                    ELSE
                                                        IF counts = 10 THEN BEGIN
                                                            RecCount10 := FORMAT(counts) + '). Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                                        ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                                        END ELSE
                                                            IF counts > 10 THEN BEGIN
                                                                RecCount1 := RecCount2;
                                                                RecCount2 := RecCount3;
                                                                RecCount3 := RecCount4;
                                                                RecCount4 := RecCount5;
                                                                RecCount5 := RecCount6;
                                                                RecCount6 := RecCount7;
                                                                RecCount7 := RecCount8;
                                                                RecCount8 := RecCount9;
                                                                RecCount9 := RecCount10;
                                                                RecCount10 := FORMAT(counts) + '). Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                                            ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code";
                                                            END;
                    CLEAR(BufferString);
                    BufferString := 'Total processed = ' + FORMAT(counts);

                    progre.UPDATE();
                    //SLEEP(50);
                    ///////////////////////////////////////////////////////////////////////////////Progress Update
                    TTUnits.RESET;
                    TTUnits.SETRANGE(Semester, Rec.Semester);
                    TTUnits.SETRANGE("Programme Code", ACALecturersUnits.Programme);
                    TTUnits.SETRANGE("Unit Code", ACALecturersUnits.Unit);
                    IF TTUnits.FIND('-') THEN;
                    // // //                    TTWeightLessonCategories.RESET;
                    // // //                    TTWeightLessonCategories.SETRANGE(Semester,Rec.Semester);
                    // // //                    TTWeightLessonCategories.SETRANGE("Category Code",TTUnits."Weighting Category");
                    // // //                    IF TTWeightLessonCategories.FIND('-') THEN BEGIN
                    // // //                      //Thin Singles
                    // // //                      IF TTWeightLessonCategories."Single Classes"= 0 THEN BEGIN
                    // // //                        TTTimetableCollectorA.RESET;
                    // // //                        TTTimetableCollectorA.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // //                        TTTimetableCollectorA.SETRANGE(Unit,ACALecturersUnits.Unit);
                    // // //                        TTTimetableCollectorA.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                    // // //                        TTTimetableCollectorA.SETRANGE(Semester,Rec.Semester);
                    // // //                        IF TTTimetableCollectorA.FIND('-') THEN TTTimetableCollectorA.DELETEALL;
                    // // //                        END ELSE IF TTWeightLessonCategories."Single Classes"= 1 THEN BEGIN
                    TTTimetableCollectorA.RESET;
                    TTTimetableCollectorA.SETRANGE("Class Code", ACALecturersUnits.Class);
                    TTTimetableCollectorA.SETRANGE(Unit, ACALecturersUnits.Unit);
                    TTTimetableCollectorA.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                    TTTimetableCollectorA.SETRANGE(Semester, Rec.Semester);
                    TTTimetableCollectorA.SETRANGE(Allocated, FALSE);
                    TTTimetableCollectorA.SETCURRENTKEY("Day Order", "Lesson Order", "Programme Campus Priority", "Programme Room Priority", "Programme Day Priority", "Lecturer Campus Priority", "Lecturer Day Priority", "Lecturer Lesson Priority",
                    "Unit Campus Priority", "Unit Room Priority");
                    IF TTTimetableCollectorA.FIND('-') THEN BEGIN
                        TTTimetableCollectorA.Allocated := TRUE;
                        TTTimetableCollectorA.MODIFY;
                    END;
                    //-- Delete all Allocations for the Programme and Units in the selected Stage Begin
                    // -Select all Stages and Programmes for the Lecturer and Unit and Class Before Picking Units for the Stage to clear for the given
                    CLEAR(CurrLessonOrder);
                    CLEAR(NextLessonOrder);
                    CurrLessonOrder := TTTimetableCollectorA."Lesson Order";
                    NextLessonOrder := TTTimetableCollectorA."Lesson Order" + 1;
                    // Lesson and Next
                    ACALecturersUnits2.RESET;
                    ACALecturersUnits2.SETRANGE(Semester, Rec.Semester);
                    ACALecturersUnits2.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                    ACALecturersUnits2.SETRANGE(Class, ACALecturersUnits.Class);
                    ACALecturersUnits2.SETRANGE(Unit, ACALecturersUnits.Unit);
                    IF ACALecturersUnits2.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            //Pick all Units in the Stage for the Programme & Delete in the Lesson and Next Lessons
                            ACAUnitsSubjects2.RESET;
                            ACAUnitsSubjects2.SETRANGE("Programme Code", ACALecturersUnits2.Programme);
                            ACAUnitsSubjects2.SETRANGE("Stage Code", ACALecturersUnits2.Stage);
                            IF ACAUnitsSubjects2.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorA1.RESET;
                                    //TTTimetableCollectorA1.SETRANGE("Class Code",ACALecturersUnits2.Class);
                                    TTTimetableCollectorA1.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                    TTTimetableCollectorA1.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                    //  TTTimetableCollectorA1.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                                    TTTimetableCollectorA1.SETRANGE(Semester, Rec.Semester);
                                    TTTimetableCollectorA1.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                    TTTimetableCollectorA1.SETFILTER("Lesson Order", '%1|%2', CurrLessonOrder, NextLessonOrder);
                                    TTTimetableCollectorA1.SETRANGE("Date Code", TTTimetableCollectorA."Date Code");
                                    TTTimetableCollectorA1.SETRANGE(Allocated, FALSE);
                                    IF TTTimetableCollectorA1.FIND('-') THEN TTTimetableCollectorA1.DELETEALL;
                                END;
                                UNTIL ACAUnitsSubjects2.NEXT = 0;
                            END;
                        END;
                        UNTIL ACALecturersUnits2.NEXT = 0;
                    END;
                    //-- Delete all Allocations for the Programme and Units in the selected Stage end
                    // Delete the Unit For the Programme in the whole TT
                    TTTimetableCollectorA1.RESET;
                    TTTimetableCollectorA1.SETRANGE(Programme, ACALecturersUnits.Programme);
                    TTTimetableCollectorA1.SETRANGE(Unit, ACALecturersUnits.Unit);
                    TTTimetableCollectorA1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                    TTTimetableCollectorA1.SETRANGE(Semester, Rec.Semester);
                    TTTimetableCollectorA1.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                    TTTimetableCollectorA1.SETRANGE(Allocated, FALSE);
                    IF TTTimetableCollectorA1.FIND('-') THEN TTTimetableCollectorA1.DELETEALL;
                    // Capture Timetable for the same Class and Unit

                    TTTimetableCollectorA1.RESET;
                    TTTimetableCollectorA1.SETRANGE("Class Code", ACALecturersUnits.Class);
                    TTTimetableCollectorA1.SETRANGE(Unit, ACALecturersUnits.Unit);
                    TTTimetableCollectorA1.SETRANGE("Room Code", TTTimetableCollectorA."Room Code");
                    TTTimetableCollectorA1.SETRANGE("Date Code", TTTimetableCollectorA."Date Code");
                    TTTimetableCollectorA1.SETRANGE("Lesson Code", TTTimetableCollectorA."Lesson Code");
                    TTTimetableCollectorA1.SETRANGE(Semester, Rec.Semester);
                    TTTimetableCollectorA1.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                    TTTimetableCollectorA1.SETRANGE(Allocated, FALSE);
                    IF TTTimetableCollectorA1.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            ///......................................//..................................................
                            TTTimetableCollectorA2.RESET;
                            TTTimetableCollectorA2.SETRANGE("Class Code", ACALecturersUnits.Class);
                            TTTimetableCollectorA2.SETRANGE(Unit, ACALecturersUnits.Unit);
                            TTTimetableCollectorA2.SETRANGE("Room Code", TTTimetableCollectorA."Room Code");
                            TTTimetableCollectorA2.SETRANGE("Date Code", TTTimetableCollectorA."Date Code");
                            TTTimetableCollectorA2.SETRANGE("Lesson Code", TTTimetableCollectorA."Lesson Code");
                            TTTimetableCollectorA2.SETRANGE(Semester, Rec.Semester);
                            TTTimetableCollectorA2.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                            TTTimetableCollectorA2.SETRANGE(Allocated, FALSE);
                            IF TTTimetableCollectorA2.FIND('-') THEN BEGIN
                                TTTimetableCollectorA1.Allocated := TRUE;
                                TTTimetableCollectorA1.MODIFY;

                                TTTimetableCollectorA2.RESET;
                                TTTimetableCollectorA2.SETRANGE(Programme, TTTimetableCollectorA1.Programme);
                                TTTimetableCollectorA2.SETRANGE(Unit, ACALecturersUnits.Unit);
                                TTTimetableCollectorA2.SETRANGE(Lecturer, TTTimetableCollectorA1.Lecturer);
                                TTTimetableCollectorA2.SETRANGE(Semester, Rec.Semester);
                                TTTimetableCollectorA2.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                                TTTimetableCollectorA2.SETRANGE(Allocated, FALSE);
                                IF TTTimetableCollectorA2.FIND('-') THEN TTTimetableCollectorA2.DELETEALL;
                            END;
                            ///..........................................//.......................................
                        END;
                        UNTIL TTTimetableCollectorA1.NEXT = 0;
                    END;

                    //Delete fro the Lecturer in a week
                    TTTimetableCollectorA1.RESET;
                    TTTimetableCollectorA1.SETRANGE("Class Code", ACALecturersUnits.Class);
                    TTTimetableCollectorA1.SETRANGE(Unit, ACALecturersUnits.Unit);
                    TTTimetableCollectorA1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                    TTTimetableCollectorA1.SETRANGE(Semester, Rec.Semester);
                    TTTimetableCollectorA1.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                    TTTimetableCollectorA1.SETRANGE(Allocated, FALSE);
                    IF TTTimetableCollectorA1.FIND('-') THEN TTTimetableCollectorA1.DELETEALL;
                    //Delete fro the Lecturer/Day/Lesson
                    // // // // // // // //                          TTTimetableCollectorA1.RESET;
                    // // // // // // // //                        //TTTimetableCollectorA1.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE("Lesson Code",TTTimetableCollectorA."Lesson Code");
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE(Allocated,FALSE);
                    // // // // // // // //                        IF TTTimetableCollectorA1.FIND('-') THEN TTTimetableCollectorA1.DELETEALL;
                    //Delete fro the Room/Day/Lesson
                    TTTimetableCollectorA1.RESET;
                    // TTTimetableCollectorA1.SETRANGE(Programme,ACALecturersUnits.Programme);
                    TTTimetableCollectorA1.SETRANGE("Date Code", TTTimetableCollectorA."Date Code");
                    TTTimetableCollectorA1.SETRANGE("Lesson Code", TTTimetableCollectorA."Lesson Code");
                    TTTimetableCollectorA1.SETRANGE("Room Code", TTTimetableCollectorA."Room Code");
                    TTTimetableCollectorA1.SETRANGE(Semester, Rec.Semester);
                    TTTimetableCollectorA1.SETRANGE(Allocated, FALSE);
                    IF TTTimetableCollectorA1.FIND('-') THEN TTTimetableCollectorA1.DELETEALL;
                    // // // // // // // //                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Doubles for single Lessons
                    // // // // // // // //                        TTLessons.RESET;
                    // // // // // // // //                        TTLessons.SETRANGE("Lesson Code",TTTimetableCollectorA."Lesson Code");
                    // // // // // // // //                        IF TTLessons.FIND('-') THEN BEGIN
                    // // // // // // // //                          // Delete from Doubles for Lect/Day/Lesson
                    // // // // // // // //                          //For Lesson 1
                    // // // // // // // //                        TTTimetableCollectorDoubles.RESET;
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Lesson 1",TTLessons."Lesson Order");
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                    // // // // // // // //                        //For Lesson 2
                    // // // // // // // //                        TTTimetableCollectorDoubles.RESET;
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Lesson 2",TTLessons."Lesson Order");
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                    // // // // // // // //                        // Delete for the Room/Day/Lesson
                    // // // // // // // //                        //For Lesson 1
                    // // // // // // // //                        TTTimetableCollectorDoubles.RESET;
                    // // // // // // // //                        //TTTimetableCollectorDoubles.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Lesson 1",TTLessons."Lesson Order");
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Room Code",TTTimetableCollectorA."Room Code");
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                    // // // // // // // //                        //For Lesson 2
                    // // // // // // // //                        TTTimetableCollectorDoubles.RESET;
                    // // // // // // // //                       // TTTimetableCollectorDoubles.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Lesson 2",TTLessons."Lesson Order");
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Room Code",TTTimetableCollectorA."Room Code");
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                    // // // // // // // //                          END;
                    // // // // // // // //                          // Delete for the Lecturer/Day/Campus/Unit in that Campus
                    // // // // // // // //                        TTTimetableCollectorDoubles.RESET;
                    // // // // // // // //                       // TTTimetableCollectorDoubles.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE(Unit,ACALecturersUnits.Unit);
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Campus Code",ACALecturersUnits."Campus Code");
                    // // // // // // // //                        IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                    // // // // // // // //                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Doubles for single Lessons
                    // // // // // // // //                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Tripples for single Lessons
                    // // // // // // // //
                    // // // // // // // //                        TTLessons.RESET;
                    // // // // // // // //                        TTLessons.SETRANGE("Lesson Code",TTTimetableCollectorA."Lesson Code");
                    // // // // // // // //                        IF TTLessons.FIND('-') THEN BEGIN
                    // // // // // // // //                          // Delete from Tripples for Lect/Day/Lesson
                    // // // // // // // //                          //For Lesson 1
                    // // // // // // // //                        TTTimetableCollectorTripple.RESET;
                    // // // // // // // //                       // TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Lesson 1",TTLessons."Lesson Order");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                    // // // // // // // //                        //For Lesson 2
                    // // // // // // // //                        TTTimetableCollectorTripple.RESET;
                    // // // // // // // //                      //  TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Lesson 2",TTLessons."Lesson Order");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                    // // // // // // // //                        //For Lesson 3
                    // // // // // // // //                        TTTimetableCollectorTripple.RESET;
                    // // // // // // // //                       // TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Lesson 3",TTLessons."Lesson Order");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                    // // // // // // // //                        // Delete for the Room/Day/Lesson
                    // // // // // // // //                        //For Lesson 1
                    // // // // // // // //                        TTTimetableCollectorTripple.RESET;
                    // // // // // // // //                       // TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Lesson 1",TTLessons."Lesson Order");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Room Code",TTTimetableCollectorA."Room Code");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                    // // // // // // // //                        //For Lesson 2
                    // // // // // // // //                        TTTimetableCollectorTripple.RESET;
                    // // // // // // // //                      //  TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Lesson 2",TTLessons."Lesson Order");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Room Code",TTTimetableCollectorA."Room Code");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                    // // // // // // // //                        //For Lesson 3
                    // // // // // // // //                        TTTimetableCollectorTripple.RESET;
                    // // // // // // // //                       // TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Lesson 3",TTLessons."Lesson Order");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Room Code",TTTimetableCollectorA."Room Code");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                    // // // // // // // //                          END;
                    // // // // // // // //                          // Delete for the Lecturer/Day/Campus/Unit in that Campus
                    // // // // // // // //                        TTTimetableCollectorTripple.RESET;
                    // // // // // // // //                       // TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Unit,ACALecturersUnits.Unit);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Campus Code",ACALecturersUnits."Campus Code");
                    // // // // // // // //                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                    // // // // // // // //                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Tripples for single Lessons
                    // // // // // // // //                        //Delete All Unallocated from The Singles for Lect/Unit/Campus
                    TTTimetableCollectorA1.RESET;
                    TTTimetableCollectorA1.SETRANGE("Class Code", ACALecturersUnits.Class);
                    TTTimetableCollectorA1.SETRANGE(Unit, ACALecturersUnits.Unit);
                    // TTTimetableCollectorA1.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                    TTTimetableCollectorA1.SETRANGE(Semester, Rec.Semester);
                    TTTimetableCollectorA1.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                    TTTimetableCollectorA1.SETRANGE(Allocated, FALSE);
                    IF TTTimetableCollectorA1.FIND('-') THEN TTTimetableCollectorA1.DELETEALL;
                    // // // // // // // //                        END ELSE IF TTWeightLessonCategories."Single Classes"= 2 THEN BEGIN
                    // // // // // // // //                          CLEAR(Loops);
                    // // // // // // // //                          REPEAT
                    // // // // // // // //                            BEGIN
                    // // // // // // // //                            /////////////////////////////////////////////////////////////////////////////////////////////// 2 Singles
                    // // // // // // // //                          TTTimetableCollectorA.RESET;
                    // // // // // // // //                        TTTimetableCollectorA.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorA.SETRANGE(Unit,ACALecturersUnits.Unit);
                    // // // // // // // //                        TTTimetableCollectorA.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                    // // // // // // // //                        TTTimetableCollectorA.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        TTTimetableCollectorA.SETRANGE(Allocated,FALSE);
                    // // // // // // // //                        TTTimetableCollectorA.SETCURRENTKEY("Day Order","Lesson Order","Programme Campus Priority","Programme Room Priority","Programme Day Priority","Lecturer Campus Priority","Lecturer Day Priority","Lecture
                    // // // // // // // //                        "Unit Campus Priority","Unit Room Priority");
                    // // // // // // // //                        IF TTTimetableCollectorA.FIND('-') THEN BEGIN
                    // // // // // // // //                          TTTimetableCollectorA.Allocated:=TRUE;
                    // // // // // // // //                          TTTimetableCollectorA.MODIFY;
                    // // // // // // // //                          END;
                    // // // // // // // //                          //Delete fro the Lecturer in a week
                    // // // // // // // //                          TTTimetableCollectorA1.RESET;
                    // // // // // // // //                        IF Loops=0 THEN
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE(Unit,ACALecturersUnits.Unit);
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE("Campus Code",ACALecturersUnits."Campus Code");
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE(Allocated,FALSE);
                    // // // // // // // //                        IF TTTimetableCollectorA1.FIND('-') THEN TTTimetableCollectorA1.DELETEALL;
                    // // // // // // // //                          //Delete fro the Lecturer/Day/Lesson
                    // // // // // // // //                          TTTimetableCollectorA1.RESET;
                    // // // // // // // //                        //TTTimetableCollectorA1.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE("Lesson Code",TTTimetableCollectorA."Lesson Code");
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE(Allocated,FALSE);
                    // // // // // // // //                        IF TTTimetableCollectorA1.FIND('-') THEN TTTimetableCollectorA1.DELETEALL;
                    // // // // // // // //                          //Delete fro the Room/Day/Lesson
                    // // // // // // // //                          TTTimetableCollectorA1.RESET;
                    // // // // // // // //                       // TTTimetableCollectorA1.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE("Lesson Code",TTTimetableCollectorA."Lesson Code");
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE("Room Code",TTTimetableCollectorA."Room Code");
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE(Allocated,FALSE);
                    // // // // // // // //                        IF TTTimetableCollectorA1.FIND('-') THEN TTTimetableCollectorA1.DELETEALL;
                    // // // // // // // //                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Doubles for single Lessons
                    // // // // // // // //                        TTLessons.RESET;
                    // // // // // // // //                        TTLessons.SETRANGE("Lesson Code",TTTimetableCollectorA."Lesson Code");
                    // // // // // // // //                        IF TTLessons.FIND('-') THEN BEGIN
                    // // // // // // // //                          // Delete from Doubles for Lect/Day/Lesson
                    // // // // // // // //                          //For Lesson 1
                    // // // // // // // //                        TTTimetableCollectorDoubles.RESET;
                    // // // // // // // //                       // TTTimetableCollectorDoubles.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Lesson 1",TTLessons."Lesson Order");
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                    // // // // // // // //                        //For Lesson 2
                    // // // // // // // //                        TTTimetableCollectorDoubles.RESET;
                    // // // // // // // //                      //  TTTimetableCollectorDoubles.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Lesson 2",TTLessons."Lesson Order");
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                    // // // // // // // //                        // Delete for the Room/Day/Lesson
                    // // // // // // // //                        //For Lesson 1
                    // // // // // // // //                        TTTimetableCollectorDoubles.RESET;
                    // // // // // // // //                       // TTTimetableCollectorDoubles.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Lesson 1",TTLessons."Lesson Order");
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Room Code",TTTimetableCollectorA."Room Code");
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                    // // // // // // // //                        //For Lesson 2
                    // // // // // // // //                        TTTimetableCollectorDoubles.RESET;
                    // // // // // // // //                      //  TTTimetableCollectorDoubles.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Lesson 2",TTLessons."Lesson Order");
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Room Code",TTTimetableCollectorA."Room Code");
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                    // // // // // // // //                          END;
                    // // // // // // // //                          // Delete for the Lecturer/Day/Campus/Unit in that Campus
                    // // // // // // // //                        TTTimetableCollectorDoubles.RESET;
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE(Unit,ACALecturersUnits.Unit);
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Campus Code",ACALecturersUnits."Campus Code");
                    // // // // // // // //                        IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                    // // // // // // // //                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Doubles for single Lessons
                    // // // // // // // //                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Tripples for single Lessons
                    // // // // // // // //
                    // // // // // // // //                        TTLessons.RESET;
                    // // // // // // // //                        TTLessons.SETRANGE("Lesson Code",TTTimetableCollectorA."Lesson Code");
                    // // // // // // // //                        IF TTLessons.FIND('-') THEN BEGIN
                    // // // // // // // //                          // Delete from Tripples for Lect/Day/Lesson
                    // // // // // // // //                          //For Lesson 1
                    // // // // // // // //                        TTTimetableCollectorTripple.RESET;
                    // // // // // // // //                       // TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Lesson 1",TTLessons."Lesson Order");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                    // // // // // // // //                        //For Lesson 2
                    // // // // // // // //                        TTTimetableCollectorTripple.RESET;
                    // // // // // // // //                      //  TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Lesson 2",TTLessons."Lesson Order");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                    // // // // // // // //                        //For Lesson 3
                    // // // // // // // //                        TTTimetableCollectorTripple.RESET;
                    // // // // // // // //                       // TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Lesson 3",TTLessons."Lesson Order");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                    // // // // // // // //                        // Delete for the Room/Day/Lesson
                    // // // // // // // //                        //For Lesson 1
                    // // // // // // // //                        TTTimetableCollectorTripple.RESET;
                    // // // // // // // //                      //  TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Lesson 1",TTLessons."Lesson Order");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Room Code",TTTimetableCollectorA."Room Code");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                    // // // // // // // //                        //For Lesson 2
                    // // // // // // // //                        TTTimetableCollectorTripple.RESET;
                    // // // // // // // //                      //  TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Lesson 2",TTLessons."Lesson Order");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Room Code",TTTimetableCollectorA."Room Code");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                    // // // // // // // //                        //For Lesson 3
                    // // // // // // // //                        TTTimetableCollectorTripple.RESET;
                    // // // // // // // //                       // TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Lesson 3",TTLessons."Lesson Order");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Room Code",TTTimetableCollectorA."Room Code");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                    // // // // // // // //                          END;
                    // // // // // // // //                          // Delete for the Lecturer/Day/Campus/Unit in that Campus
                    // // // // // // // //                        TTTimetableCollectorTripple.RESET;
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Unit,ACALecturersUnits.Unit);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Campus Code",ACALecturersUnits."Campus Code");
                    // // // // // // // //                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                    // // // // // // // //                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Tripples for single Lessons
                    // // // // // // // //                        //Delete All Unallocated from The Singles for Lect/Unit/Campus
                    // // // // // // // //                          TTTimetableCollectorA1.RESET;
                    // // // // // // // //                        IF Loops=0 THEN
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE(Unit,ACALecturersUnits.Unit);
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE("Campus Code",ACALecturersUnits."Campus Code");
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE(Allocated,FALSE);
                    // // // // // // // //                        IF TTTimetableCollectorA1.FIND('-') THEN TTTimetableCollectorA1.DELETEALL;
                    // // // // // // // //                            /////////////////////////////////////////////////////////////////////////////////////////////// 2 Singles
                    // // // // // // // //                            Loops:=Loops+1;
                    // // // // // // // //                            END;
                    // // // // // // // //                              UNTIL Loops=2;
                    // // // // // // // //                        END ELSE IF TTWeightLessonCategories."Single Classes"= 3 THEN BEGIN
                    // // // // // // // //                          CLEAR(Loops);
                    // // // // // // // //                          REPEAT
                    // // // // // // // //                            BEGIN
                    // // // // // // // //                            /////////////////////////////////////////////////////////////////////////////////////////////// 3 Singles
                    // // // // // // // //                          TTTimetableCollectorA.RESET;
                    // // // // // // // //                        TTTimetableCollectorA.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorA.SETRANGE(Unit,ACALecturersUnits.Unit);
                    // // // // // // // //                        TTTimetableCollectorA.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                    // // // // // // // //                        TTTimetableCollectorA.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        TTTimetableCollectorA.SETRANGE(Allocated,FALSE);
                    // // // // // // // //                        TTTimetableCollectorA.SETCURRENTKEY("Day Order","Lesson Order","Programme Campus Priority","Programme Room Priority","Programme Day Priority","Lecturer Campus Priority","Lecturer Day Priority","Lecture
                    // // // // // // // //                        "Unit Campus Priority","Unit Room Priority");
                    // // // // // // // //                        IF TTTimetableCollectorA.FIND('-') THEN BEGIN
                    // // // // // // // //                          TTTimetableCollectorA.Allocated:=TRUE;
                    // // // // // // // //                          TTTimetableCollectorA.MODIFY;
                    // // // // // // // //                          END;
                    // // // // // // // //                          //Delete fro the Lecturer in a week
                    // // // // // // // //                          TTTimetableCollectorA1.RESET;
                    // // // // // // // //                        IF ((Loops=0) OR (Loops=1)) THEN
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE(Unit,ACALecturersUnits.Unit);
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE("Campus Code",ACALecturersUnits."Campus Code");
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE(Allocated,FALSE);
                    // // // // // // // //                        IF TTTimetableCollectorA1.FIND('-') THEN TTTimetableCollectorA1.DELETEALL;
                    // // // // // // // //                          //Delete fro the Lecturer/Day/Lesson
                    // // // // // // // //                          TTTimetableCollectorA1.RESET;
                    // // // // // // // //                      //  TTTimetableCollectorA1.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE("Lesson Code",TTTimetableCollectorA."Lesson Code");
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE(Allocated,FALSE);
                    // // // // // // // //                        IF TTTimetableCollectorA1.FIND('-') THEN TTTimetableCollectorA1.DELETEALL;
                    // // // // // // // //                          //Delete fro the Room/Day/Lesson
                    // // // // // // // //                          TTTimetableCollectorA1.RESET;
                    // // // // // // // //                       // TTTimetableCollectorA1.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE("Lesson Code",TTTimetableCollectorA."Lesson Code");
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE("Room Code",TTTimetableCollectorA."Room Code");
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE(Allocated,FALSE);
                    // // // // // // // //                        IF TTTimetableCollectorA1.FIND('-') THEN TTTimetableCollectorA1.DELETEALL;
                    // // // // // // // //                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Doubles for single Lessons
                    // // // // // // // //                        TTLessons.RESET;
                    // // // // // // // //                        TTLessons.SETRANGE("Lesson Code",TTTimetableCollectorA."Lesson Code");
                    // // // // // // // //                        IF TTLessons.FIND('-') THEN BEGIN
                    // // // // // // // //                          // Delete from Doubles for Lect/Day/Lesson
                    // // // // // // // //                          //For Lesson 1
                    // // // // // // // //                        TTTimetableCollectorDoubles.RESET;
                    // // // // // // // //                       // TTTimetableCollectorDoubles.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Lesson 1",TTLessons."Lesson Order");
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                    // // // // // // // //                        //For Lesson 2
                    // // // // // // // //                        TTTimetableCollectorDoubles.RESET;
                    // // // // // // // //                      //  TTTimetableCollectorDoubles.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Lesson 2",TTLessons."Lesson Order");
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                    // // // // // // // //                        // Delete for the Room/Day/Lesson
                    // // // // // // // //                        //For Lesson 1
                    // // // // // // // //                        TTTimetableCollectorDoubles.RESET;
                    // // // // // // // //                      //  TTTimetableCollectorDoubles.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Lesson 1",TTLessons."Lesson Order");
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Room Code",TTTimetableCollectorA."Room Code");
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                    // // // // // // // //                        //For Lesson 2
                    // // // // // // // //                        TTTimetableCollectorDoubles.RESET;
                    // // // // // // // //                       // TTTimetableCollectorDoubles.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Lesson 2",TTLessons."Lesson Order");
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Room Code",TTTimetableCollectorA."Room Code");
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                    // // // // // // // //                          END;
                    // // // // // // // //                          // Delete for the Lecturer/Day/Campus/Unit in that Campus
                    // // // // // // // //                        TTTimetableCollectorDoubles.RESET;
                    // // // // // // // //                      //  TTTimetableCollectorDoubles.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE(Unit,ACALecturersUnits.Unit);
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        TTTimetableCollectorDoubles.SETRANGE("Campus Code",ACALecturersUnits."Campus Code");
                    // // // // // // // //                        IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                    // // // // // // // //                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Doubles for single Lessons
                    // // // // // // // //                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Tripples for single Lessons
                    // // // // // // // //
                    // // // // // // // //                        TTLessons.RESET;
                    // // // // // // // //                        TTLessons.SETRANGE("Lesson Code",TTTimetableCollectorA."Lesson Code");
                    // // // // // // // //                        IF TTLessons.FIND('-') THEN BEGIN
                    // // // // // // // //                          // Delete from Tripples for Lect/Day/Lesson
                    // // // // // // // //                          //For Lesson 1
                    // // // // // // // //                        TTTimetableCollectorTripple.RESET;
                    // // // // // // // //                       // TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Lesson 1",TTLessons."Lesson Order");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                    // // // // // // // //                        //For Lesson 2
                    // // // // // // // //                        TTTimetableCollectorTripple.RESET;
                    // // // // // // // //                      //  TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Lesson 2",TTLessons."Lesson Order");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                    // // // // // // // //                        //For Lesson 3
                    // // // // // // // //                        TTTimetableCollectorTripple.RESET;
                    // // // // // // // //                      //  TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Lesson 3",TTLessons."Lesson Order");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                    // // // // // // // //                        // Delete for the Room/Day/Lesson
                    // // // // // // // //                        //For Lesson 1
                    // // // // // // // //                        TTTimetableCollectorTripple.RESET;
                    // // // // // // // //                       // TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Lesson 1",TTLessons."Lesson Order");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Room Code",TTTimetableCollectorA."Room Code");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                    // // // // // // // //                        //For Lesson 2
                    // // // // // // // //                        TTTimetableCollectorTripple.RESET;
                    // // // // // // // //                       // TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Lesson 2",TTLessons."Lesson Order");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Room Code",TTTimetableCollectorA."Room Code");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                    // // // // // // // //                        //For Lesson 3
                    // // // // // // // //                        TTTimetableCollectorTripple.RESET;
                    // // // // // // // //                       // TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Lesson 3",TTLessons."Lesson Order");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Room Code",TTTimetableCollectorA."Room Code");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                    // // // // // // // //                          END;
                    // // // // // // // //                          // Delete for the Lecturer/Day/Campus/Unit in that Campus
                    // // // // // // // //                        TTTimetableCollectorTripple.RESET;
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Unit,ACALecturersUnits.Unit);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        TTTimetableCollectorTripple.SETRANGE("Campus Code",ACALecturersUnits."Campus Code");
                    // // // // // // // //                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                    // // // // // // // //                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Tripples for single Lessons
                    // // // // // // // //                        //Delete All Unallocated from The Singles for Lect/Unit/Campus
                    // // // // // // // //                          TTTimetableCollectorA1.RESET;
                    // // // // // // // //                        IF ((Loops=0) OR (Loops=1)) THEN
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE("Date Code",TTTimetableCollectorA."Date Code");
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE(Programme,ACALecturersUnits.Programme);
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE(Unit,ACALecturersUnits.Unit);
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE(Semester,Rec.Semester);
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE("Campus Code",ACALecturersUnits."Campus Code");
                    // // // // // // // //                        TTTimetableCollectorA1.SETRANGE(Allocated,FALSE);
                    // // // // // // // //                        IF TTTimetableCollectorA1.FIND('-') THEN TTTimetableCollectorA1.DELETEALL;
                    // // // // // // // //                            /////////////////////////////////////////////////////////////////////////////////////////////// 3 Singles
                    // // // // // // // //                            Loops:=Loops+1;
                    // // // // // // // //                            END;
                    // // // // // // // //                              UNTIL Loops=3;
                    // // // // // // // //                        END;

                END;
            END;
            UNTIL ACALecturersUnits.NEXT = 0;
        END;
        progre.CLOSE;
    end;

    local procedure FinalCompilation()
    var
        TTRooms: Record 74501;
        TTDailyLessons: Record 74552;
        ACALecturersUnits: Record 65202;
        TTTimetableCollectorA: Record 74557;
        TTTimetableCollectorA1: Record 74557;
        LectLoadBatchLines: Record 65201;
        ACAProgramme: Record 61511;
        ACAUnitsSubjects: Record 61517;
        TTUnits: Record 74554;
        TTLessons: Record 74556;
        TTDays: Record 74551;
        Loops: Integer;
        TTTimetableFInalCollector: Record 74568;
        progre: Dialog;
        counts: Integer;
        RecCount1: Text[120];
        RecCount2: Text[120];
        RecCount3: Text[120];
        RecCount4: Text[120];
        RecCount5: Text[120];
        RecCount6: Text[120];
        RecCount7: Text[120];
        RecCount8: Text[120];
        RecCount9: Text[120];
        RecCount10: Text[120];
        BufferString: Text[1024];
        Var1: Code[10];

        progDots: Text[50];
        counted: Integer;
        text1: Label '*';
        text2: Label '**';
        text3: Label '***';
        text4: Label '****';
        text5: Label '*****';
        text6: Label '******';
        text7: Label '*******';
        text8: Label '********';
        text9: Label '*********';
        text10: Label '**********';
    begin
        /////////////////////////////////////////////////////////////////////////////////////////////Progress Initiate
        CLEAR(progDots);
        CLEAR(RecCount1);
        CLEAR(RecCount2);
        CLEAR(RecCount3);
        CLEAR(RecCount4);
        CLEAR(RecCount5);
        CLEAR(RecCount6);
        CLEAR(RecCount7);
        CLEAR(RecCount8);
        CLEAR(RecCount9);
        CLEAR(RecCount10);
        CLEAR(counts);
        progre.OPEN('Finalizing Singles:  #1#############################' +
        '\ ' +
        '\#2###############################################################' +
        '\#3###############################################################' +
        '\#4###############################################################' +
        '\#5###############################################################' +
        '\#6###############################################################' +
        '\#7###############################################################' +
        '\#8###############################################################' +
        '\#9###############################################################' +
        '\#10###############################################################' +
        '\#11###############################################################' +
        '\#12###############################################################' +
        '\#13###############################################################' +
        '\#14###############################################################',
            progDots,
            RecCount1,
            RecCount2,
            RecCount3,
            RecCount4,
            RecCount5,
            RecCount6,
            RecCount7,
            RecCount8,
            RecCount9,
            RecCount10,
            Var1,
            Var1,
            BufferString
        );
        /////////////////////////////////////////////////////////////////////////////////////////////Progress Initiate
        TTTimetableFInalCollector.RESET;
        TTTimetableFInalCollector.SETRANGE(Semester, Rec.Semester);
        IF TTTimetableFInalCollector.FIND('-') THEN TTTimetableFInalCollector.DELETEALL;
        CLEAR(CountedEntries);
        //Capture the Singles
        TTTimetableCollectorA.RESET;
        TTTimetableCollectorA.SETRANGE(Semester, Rec.Semester);
        TTTimetableCollectorA.SETRANGE(Allocated, TRUE);
        IF TTTimetableCollectorA.FIND('-') THEN BEGIN
            REPEAT
            BEGIN


                ///////////////////////////////////////////////////////////////////////////////Progress Update
                CLEAR(Var1);
                counts := counts + 1;
                IF ((counted = 21) OR (counted = 11)) THEN BEGIN
                    IF counted = 21 THEN counted := 0;
                    //SLEEP(150);
                END;
                counted := counted + 1;
                IF counted = 1 THEN
                    progDots := text1
                ELSE
                    IF counted = 2 THEN
                        progDots := text2
                    ELSE
                        IF counted = 3 THEN
                            progDots := text3
                        ELSE
                            IF counted = 4 THEN
                                progDots := text4
                            ELSE
                                IF counted = 5 THEN
                                    progDots := text5
                                ELSE
                                    IF counted = 6 THEN
                                        progDots := text6
                                    ELSE
                                        IF counted = 7 THEN
                                            progDots := text7
                                        ELSE
                                            IF counted = 8 THEN
                                                progDots := text8
                                            ELSE
                                                IF counted = 9 THEN
                                                    progDots := text9
                                                ELSE
                                                    IF counted = 10 THEN
                                                        progDots := text10
                                                    ELSE
                                                        IF counted = 19 THEN
                                                            progDots := text1
                                                        ELSE
                                                            IF counted = 18 THEN
                                                                progDots := text2
                                                            ELSE
                                                                IF counted = 17 THEN
                                                                    progDots := text3
                                                                ELSE
                                                                    IF counted = 16 THEN
                                                                        progDots := text4
                                                                    ELSE
                                                                        IF counted = 15 THEN
                                                                            progDots := text5
                                                                        ELSE
                                                                            IF counted = 14 THEN
                                                                                progDots := text6
                                                                            ELSE
                                                                                IF counted = 13 THEN
                                                                                    progDots := text7
                                                                                ELSE
                                                                                    IF counted = 12 THEN
                                                                                        progDots := text8
                                                                                    ELSE
                                                                                        IF counted = 11 THEN
                                                                                            progDots := text9
                                                                                        ELSE
                                                                                            progDots := '';

                IF counts = 1 THEN
                    RecCount1 := FORMAT(counts) + '). Lecturer: ' + TTTimetableCollectorA.Lecturer + '; Programme: ' + TTTimetableCollectorA.Programme + '; Unit: ' +
                TTTimetableCollectorA.Unit + '; Campus: ' + TTTimetableCollectorA."Campus Code"
                ELSE
                    IF counts = 2 THEN BEGIN
                        RecCount2 := FORMAT(counts) + '). Lecturer: ' + TTTimetableCollectorA.Lecturer + '; Programme: ' + TTTimetableCollectorA.Programme + '; Unit: ' +
                    TTTimetableCollectorA.Unit + '; Campus: ' + TTTimetableCollectorA."Campus Code"
                    END
                    ELSE
                        IF counts = 3 THEN BEGIN
                            RecCount3 := FORMAT(counts) + '). Lecturer: ' + TTTimetableCollectorA.Lecturer + '; Programme: ' + TTTimetableCollectorA.Programme + '; Unit: ' +
                        TTTimetableCollectorA.Unit + '; Campus: ' + TTTimetableCollectorA."Campus Code"
                        END
                        ELSE
                            IF counts = 4 THEN BEGIN
                                RecCount4 := FORMAT(counts) + '). Lecturer: ' + TTTimetableCollectorA.Lecturer + '; Programme: ' + TTTimetableCollectorA.Programme + '; Unit: ' +
                            TTTimetableCollectorA.Unit + '; Campus: ' + TTTimetableCollectorA."Campus Code"
                            END
                            ELSE
                                IF counts = 5 THEN BEGIN
                                    RecCount5 := FORMAT(counts) + '). Lecturer: ' + TTTimetableCollectorA.Lecturer + '; Programme: ' + TTTimetableCollectorA.Programme + '; Unit: ' +
                                TTTimetableCollectorA.Unit + '; Campus: ' + TTTimetableCollectorA."Campus Code"
                                END
                                ELSE
                                    IF counts = 6 THEN BEGIN
                                        RecCount6 := FORMAT(counts) + '). Lecturer: ' + TTTimetableCollectorA.Lecturer + '; Programme: ' + TTTimetableCollectorA.Programme + '; Unit: ' +
                                    TTTimetableCollectorA.Unit + '; Campus: ' + TTTimetableCollectorA."Campus Code"
                                    END
                                    ELSE
                                        IF counts = 7 THEN BEGIN
                                            RecCount7 := FORMAT(counts) + '). Lecturer: ' + TTTimetableCollectorA.Lecturer + '; Programme: ' + TTTimetableCollectorA.Programme + '; Unit: ' +
                                        TTTimetableCollectorA.Unit + '; Campus: ' + TTTimetableCollectorA."Campus Code"
                                        END
                                        ELSE
                                            IF counts = 8 THEN BEGIN
                                                RecCount8 := FORMAT(counts) + '). Lecturer: ' + TTTimetableCollectorA.Lecturer + '; Programme: ' + TTTimetableCollectorA.Programme + '; Unit: ' +
                                            TTTimetableCollectorA.Unit + '; Campus: ' + TTTimetableCollectorA."Campus Code"
                                            END
                                            ELSE
                                                IF counts = 9 THEN BEGIN
                                                    RecCount9 := FORMAT(counts) + '). Lecturer: ' + TTTimetableCollectorA.Lecturer + '; Programme: ' + TTTimetableCollectorA.Programme + '; Unit: ' +
                                                TTTimetableCollectorA.Unit + '; Campus: ' + TTTimetableCollectorA."Campus Code"
                                                END
                                                ELSE
                                                    IF counts = 10 THEN BEGIN
                                                        RecCount10 := FORMAT(counts) + '). Lecturer: ' + TTTimetableCollectorA.Lecturer + '; Programme: ' + TTTimetableCollectorA.Programme + '; Unit: ' +
                                                    TTTimetableCollectorA.Unit + '; Campus: ' + TTTimetableCollectorA."Campus Code"
                                                    END ELSE
                                                        IF counts > 10 THEN BEGIN
                                                            RecCount1 := RecCount2;
                                                            RecCount2 := RecCount3;
                                                            RecCount3 := RecCount4;
                                                            RecCount4 := RecCount5;
                                                            RecCount5 := RecCount6;
                                                            RecCount6 := RecCount7;
                                                            RecCount7 := RecCount8;
                                                            RecCount8 := RecCount9;
                                                            RecCount9 := RecCount10;
                                                            RecCount10 := FORMAT(counts) + '). Lecturer: ' + TTTimetableCollectorA.Lecturer + '; Programme: ' + TTTimetableCollectorA.Programme + '; Unit: ' +
                                                        TTTimetableCollectorA.Unit + '; Campus: ' + TTTimetableCollectorA."Campus Code";
                                                        END;
                CLEAR(BufferString);
                BufferString := 'Total Tripples processed = ' + FORMAT(counts);

                progre.UPDATE();
                //SLEEP(50);
                ///////////////////////////////////////////////////////////////////////////////Progress Update
                TTTimetableFInalCollector.RESET;
                TTTimetableFInalCollector.SETRANGE(Programme, TTTimetableCollectorA.Programme);
                TTTimetableFInalCollector.SETRANGE(Unit, TTTimetableCollectorA.Unit);
                TTTimetableFInalCollector.SETRANGE(Semester, Rec.Semester);
                TTTimetableFInalCollector.SETRANGE("Period Code", TTTimetableCollectorA."Lesson Code");
                TTTimetableFInalCollector.SETRANGE("Date Code", TTTimetableCollectorA."Date Code");
                TTTimetableFInalCollector.SETRANGE("Lecture Room", TTTimetableCollectorA."Lecture Room");
                TTTimetableFInalCollector.SETRANGE(Lecturer, TTTimetableCollectorA.Lecturer);
                // TTTimetableFInalCollector.SETRANGE("Campus Code",ACALecturersUnits.);
                // TTTimetableFInalCollector.SETRANGE(Department,LectLoadBatchLines,Department);
                TTTimetableFInalCollector.SETRANGE("Room Code", TTTimetableCollectorA."Room Code");
                TTTimetableFInalCollector.SETRANGE("Block/Building", TTTimetableCollectorA."Block/Building");
                // TTTimetableFInalCollector.SETRANGE("Lesson Category",TTUnits."Weighting Category");
                // TTTimetableFInalCollector.SETRANGE("School or Faculty",LectLoadBatchLines.Faculty);
                IF NOT (TTTimetableFInalCollector.FIND('-')) THEN BEGIN
                    TTTimetableFInalCollector.INIT;
                    TTTimetableFInalCollector.Programme := TTTimetableCollectorA.Programme;
                    TTTimetableFInalCollector.Unit := TTTimetableCollectorA.Unit;
                    TTTimetableFInalCollector.Semester := Rec.Semester;
                    TTTimetableFInalCollector."Period Code" := TTTimetableCollectorA."Lesson Code";
                    TTTimetableFInalCollector."Period Category" := TTTimetableCollectorA."Lesson Category";
                    TTTimetableFInalCollector."Date Code" := TTTimetableCollectorA."Date Code";
                    TTTimetableFInalCollector."Lecture Room" := TTTimetableCollectorA."Room Code";
                    TTTimetableFInalCollector.Lecturer := TTTimetableCollectorA.Lecturer;
                    TTTimetableFInalCollector.Department := TTTimetableCollectorA.Department;
                    TTTimetableFInalCollector."Date Order" := TTTimetableCollectorA."Day Order";
                    TTTimetableFInalCollector."Period Order" := TTTimetableCollectorA."Lesson Order";
                    //  TTTimetableFInalCollector."Programme Option":=;
                    TTTimetableFInalCollector."Room Type" := TTTimetableCollectorA."Room Type";
                    TTTimetableFInalCollector."Room Code" := TTTimetableCollectorA."Room Code";
                    TTTimetableFInalCollector."Block/Building" := TTTimetableCollectorA."Block/Building";
                    TTTimetableFInalCollector."School or Faculty" := TTTimetableCollectorA."School or Faculty";
                    TTTimetableFInalCollector."Campus Code" := TTTimetableCollectorA."Campus Code";
                    TTTimetableFInalCollector."Period Type" := 'SINGLE';
                    IF ((Rec.Semester <> '') AND (TTTimetableCollectorA."Room Code" <> '') AND (TTTimetableCollectorA.Lecturer <> '')) THEN BEGIN
                        CountedEntries := CountedEntries + 1;
                        TTTimetableFInalCollector."Record ID" := CountedEntries;
                        TTTimetableFInalCollector.INSERT;
                    END;
                END;
            END;
            UNTIL TTTimetableCollectorA.NEXT = 0;
        END;
        progre.CLOSE;
        // // // // // // // // // // // // // //  //Capture the Doubles
        // // // // // // // // // // // // // //          /////////////////////////////////////////////////////////////////////////////////////////////Progress Initiate
        // // // // // // // // // // // // // // CLEAR(progDots);
        // // // // // // // // // // // // // // CLEAR(RecCount1);
        // // // // // // // // // // // // // // CLEAR(RecCount2);
        // // // // // // // // // // // // // // CLEAR(RecCount3);
        // // // // // // // // // // // // // // CLEAR(RecCount4);
        // // // // // // // // // // // // // // CLEAR(RecCount5);
        // // // // // // // // // // // // // // CLEAR(RecCount6);
        // // // // // // // // // // // // // // CLEAR(RecCount7);
        // // // // // // // // // // // // // // CLEAR(RecCount8);
        // // // // // // // // // // // // // // CLEAR(RecCount9);
        // // // // // // // // // // // // // // CLEAR(RecCount10);
        // // // // // // // // // // // // // // CLEAR(counts);
        // // // // // // // // // // // // // // progre.OPEN('Finalizing Doubles:  #1#############################'+
        // // // // // // // // // // // // // // '\ '+
        // // // // // // // // // // // // // // '\#2###############################################################'+
        // // // // // // // // // // // // // // '\#3###############################################################'+
        // // // // // // // // // // // // // // '\#4###############################################################'+
        // // // // // // // // // // // // // // '\#5###############################################################'+
        // // // // // // // // // // // // // // '\#6###############################################################'+
        // // // // // // // // // // // // // // '\#7###############################################################'+
        // // // // // // // // // // // // // // '\#8###############################################################'+
        // // // // // // // // // // // // // // '\#9###############################################################'+
        // // // // // // // // // // // // // // '\#10###############################################################'+
        // // // // // // // // // // // // // // '\#11###############################################################'+
        // // // // // // // // // // // // // // '\#12###############################################################'+
        // // // // // // // // // // // // // // '\#13###############################################################'+
        // // // // // // // // // // // // // // '\#14###############################################################',
        // // // // // // // // // // // // // //    progDots,
        // // // // // // // // // // // // // //    RecCount1,
        // // // // // // // // // // // // // //    RecCount2,
        // // // // // // // // // // // // // //    RecCount3,
        // // // // // // // // // // // // // //    RecCount4,
        // // // // // // // // // // // // // //    RecCount5,
        // // // // // // // // // // // // // //    RecCount6,
        // // // // // // // // // // // // // //    RecCount7,
        // // // // // // // // // // // // // //    RecCount8,
        // // // // // // // // // // // // // //    RecCount9,
        // // // // // // // // // // // // // //    RecCount10,
        // // // // // // // // // // // // // //    Var1,
        // // // // // // // // // // // // // //    Var1,
        // // // // // // // // // // // // // //    BufferString
        // // // // // // // // // // // // // // );
        // // // // // // // // // // // // // // /////////////////////////////////////////////////////////////////////////////////////////////Progress Initiate
        // // // // // // // // // // // // // // TTTimetableCollectorDoubles.RESET;
        // // // // // // // // // // // // // // TTTimetableCollectorDoubles.SETRANGE(Semester,Rec.Semester);
        // // // // // // // // // // // // // // TTTimetableCollectorDoubles.SETRANGE(Allocated,TRUE);
        // // // // // // // // // // // // // // IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
        // // // // // // // // // // // // // //  REPEAT
        // // // // // // // // // // // // // //    BEGIN
        // // // // // // // // // // // // // //
        // // // // // // // // // // // // // //                    ///////////////////////////////////////////////////////////////////////////////Progress Update
        // // // // // // // // // // // // // //                    CLEAR(Var1);
        // // // // // // // // // // // // // //    counts:=counts+1;
        // // // // // // // // // // // // // //    IF ((counted=21) OR(counted=11)) THEN BEGIN
        // // // // // // // // // // // // // //    IF counted=21 THEN counted := 0;
        // // // // // // // // // // // // // //    //SLEEP(150);
        // // // // // // // // // // // // // //    END;
        // // // // // // // // // // // // // //    counted:=counted+1;
        // // // // // // // // // // // // // //    IF counted=1 THEN progDots:=text1
        // // // // // // // // // // // // // //    ELSE IF counted=2 THEN progDots:=text2
        // // // // // // // // // // // // // //    ELSE IF counted=3 THEN progDots:=text3
        // // // // // // // // // // // // // //    ELSE IF counted=4 THEN progDots:=text4
        // // // // // // // // // // // // // //    ELSE IF counted=5 THEN progDots:=text5
        // // // // // // // // // // // // // //    ELSE IF counted=6 THEN progDots:=text6
        // // // // // // // // // // // // // //    ELSE IF counted=7 THEN progDots:=text7
        // // // // // // // // // // // // // //    ELSE IF counted=8 THEN progDots:=text8
        // // // // // // // // // // // // // //    ELSE IF counted=9 THEN progDots:=text9
        // // // // // // // // // // // // // //    ELSE IF counted=10 THEN progDots:=text10
        // // // // // // // // // // // // // //    ELSE IF counted=19 THEN progDots:=text1
        // // // // // // // // // // // // // //    ELSE IF counted=18 THEN progDots:=text2
        // // // // // // // // // // // // // //    ELSE IF counted=17 THEN progDots:=text3
        // // // // // // // // // // // // // //    ELSE IF counted=16 THEN progDots:=text4
        // // // // // // // // // // // // // //    ELSE IF counted=15 THEN progDots:=text5
        // // // // // // // // // // // // // //    ELSE IF counted=14 THEN progDots:=text6
        // // // // // // // // // // // // // //    ELSE IF counted=13 THEN progDots:=text7
        // // // // // // // // // // // // // //    ELSE IF counted=12 THEN progDots:=text8
        // // // // // // // // // // // // // //    ELSE IF counted=11 THEN progDots:=text9
        // // // // // // // // // // // // // //    ELSE progDots:='';
        // // // // // // // // // // // // // //
        // // // // // // // // // // // // // //    IF counts=1 THEN
        // // // // // // // // // // // // // //    RecCount1:=FORMAT(counts)+'). Lecturer: '+TTTimetableCollectorDoubles.Lecturer+'; Programme: '+TTTimetableCollectorDoubles.Programme+'; Unit: '+
        // // // // // // // // // // // // // // TTTimetableCollectorDoubles.Unit+'; Campus: '+TTTimetableCollectorDoubles."Campus Code"
        // // // // // // // // // // // // // //    ELSE IF counts=2 THEN BEGIN
        // // // // // // // // // // // // // //    RecCount2:=FORMAT(counts)+'). Lecturer: '+TTTimetableCollectorDoubles.Lecturer+'; Programme: '+TTTimetableCollectorDoubles.Programme+'; Unit: '+
        // // // // // // // // // // // // // // TTTimetableCollectorDoubles.Unit+'; Campus: '+TTTimetableCollectorDoubles."Campus Code"
        // // // // // // // // // // // // // //    END
        // // // // // // // // // // // // // //    ELSE IF counts=3 THEN BEGIN
        // // // // // // // // // // // // // //    RecCount3:=FORMAT(counts)+'). Lecturer: '+TTTimetableCollectorDoubles.Lecturer+'; Programme: '+TTTimetableCollectorDoubles.Programme+'; Unit: '+
        // // // // // // // // // // // // // // TTTimetableCollectorDoubles.Unit+'; Campus: '+TTTimetableCollectorDoubles."Campus Code"
        // // // // // // // // // // // // // //    END
        // // // // // // // // // // // // // //    ELSE IF counts=4 THEN BEGIN
        // // // // // // // // // // // // // //    RecCount4:=FORMAT(counts)+'). Lecturer: '+TTTimetableCollectorDoubles.Lecturer+'; Programme: '+TTTimetableCollectorDoubles.Programme+'; Unit: '+
        // // // // // // // // // // // // // // TTTimetableCollectorDoubles.Unit+'; Campus: '+TTTimetableCollectorDoubles."Campus Code"
        // // // // // // // // // // // // // //    END
        // // // // // // // // // // // // // //    ELSE IF counts=5 THEN BEGIN
        // // // // // // // // // // // // // //    RecCount5:=FORMAT(counts)+'). Lecturer: '+TTTimetableCollectorDoubles.Lecturer+'; Programme: '+TTTimetableCollectorDoubles.Programme+'; Unit: '+
        // // // // // // // // // // // // // // TTTimetableCollectorDoubles.Unit+'; Campus: '+TTTimetableCollectorDoubles."Campus Code"
        // // // // // // // // // // // // // //    END
        // // // // // // // // // // // // // //    ELSE IF counts=6 THEN BEGIN
        // // // // // // // // // // // // // //    RecCount6:=FORMAT(counts)+'). Lecturer: '+TTTimetableCollectorDoubles.Lecturer+'; Programme: '+TTTimetableCollectorDoubles.Programme+'; Unit: '+
        // // // // // // // // // // // // // // TTTimetableCollectorDoubles.Unit+'; Campus: '+TTTimetableCollectorDoubles."Campus Code"
        // // // // // // // // // // // // // //    END
        // // // // // // // // // // // // // //    ELSE IF counts=7 THEN BEGIN
        // // // // // // // // // // // // // //    RecCount7:=FORMAT(counts)+'). Lecturer: '+TTTimetableCollectorDoubles.Lecturer+'; Programme: '+TTTimetableCollectorDoubles.Programme+'; Unit: '+
        // // // // // // // // // // // // // // TTTimetableCollectorDoubles.Unit+'; Campus: '+TTTimetableCollectorDoubles."Campus Code"
        // // // // // // // // // // // // // //    END
        // // // // // // // // // // // // // //    ELSE IF counts=8 THEN BEGIN
        // // // // // // // // // // // // // //    RecCount8:=FORMAT(counts)+'). Lecturer: '+TTTimetableCollectorDoubles.Lecturer+'; Programme: '+TTTimetableCollectorDoubles.Programme+'; Unit: '+
        // // // // // // // // // // // // // // TTTimetableCollectorDoubles.Unit+'; Campus: '+TTTimetableCollectorDoubles."Campus Code"
        // // // // // // // // // // // // // //    END
        // // // // // // // // // // // // // //    ELSE IF counts=9 THEN BEGIN
        // // // // // // // // // // // // // //    RecCount9:=FORMAT(counts)+'). Lecturer: '+TTTimetableCollectorDoubles.Lecturer+'; Programme: '+TTTimetableCollectorDoubles.Programme+'; Unit: '+
        // // // // // // // // // // // // // // TTTimetableCollectorDoubles.Unit+'; Campus: '+TTTimetableCollectorDoubles."Campus Code"
        // // // // // // // // // // // // // //    END
        // // // // // // // // // // // // // //    ELSE IF counts=10 THEN BEGIN
        // // // // // // // // // // // // // //    RecCount10:=FORMAT(counts)+'). Lecturer: '+TTTimetableCollectorDoubles.Lecturer+'; Programme: '+TTTimetableCollectorDoubles.Programme+'; Unit: '+
        // // // // // // // // // // // // // // TTTimetableCollectorDoubles.Unit+'; Campus: '+TTTimetableCollectorDoubles."Campus Code"
        // // // // // // // // // // // // // //    END ELSE IF counts>10 THEN BEGIN
        // // // // // // // // // // // // // //    RecCount1:=RecCount2;
        // // // // // // // // // // // // // //    RecCount2:=RecCount3;
        // // // // // // // // // // // // // //    RecCount3:=RecCount4;
        // // // // // // // // // // // // // //    RecCount4:=RecCount5;
        // // // // // // // // // // // // // //    RecCount5:=RecCount6;
        // // // // // // // // // // // // // //    RecCount6:=RecCount7;
        // // // // // // // // // // // // // //    RecCount7:=RecCount8;
        // // // // // // // // // // // // // //    RecCount8:=RecCount9;
        // // // // // // // // // // // // // //    RecCount9:=RecCount10;
        // // // // // // // // // // // // // //    RecCount10:=FORMAT(counts)+'). Lecturer: '+TTTimetableCollectorDoubles.Lecturer+'; Programme: '+TTTimetableCollectorDoubles.Programme+'; Unit: '+
        // // // // // // // // // // // // // // TTTimetableCollectorDoubles.Unit+'; Campus: '+TTTimetableCollectorDoubles."Campus Code";
        // // // // // // // // // // // // // //    END;
        // // // // // // // // // // // // // //    CLEAR(BufferString);
        // // // // // // // // // // // // // //    BufferString:='Total Tripples processed = '+FORMAT(counts);
        // // // // // // // // // // // // // //
        // // // // // // // // // // // // // //    progre.UPDATE();
        // // // // // // // // // // // // // //     //SLEEP(50);
        // // // // // // // // // // // // // //                    ///////////////////////////////////////////////////////////////////////////////Progress Update
        // // // // // // // // // // // // // //    TTLessons1.RESET;
        // // // // // // // // // // // // // //    TTLessons1.SETRANGE("Lesson Order",TTTimetableCollectorDoubles."Lesson 1");
        // // // // // // // // // // // // // //    IF TTLessons1.FIND('-') THEN  BEGIN
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.RESET;
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE(Programme,TTTimetableCollectorDoubles.Programme);
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE(Unit,TTTimetableCollectorDoubles.Unit);
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE(Semester,Rec.Semester);
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE("Lesson Code",TTLessons1."Lesson Code");
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE("Date Code",TTTimetableCollectorDoubles."Date Code");
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE("Lecture Room",TTTimetableCollectorDoubles."Lecture Room");
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE(Lecturer,TTTimetableCollectorDoubles.Lecturer);
        // // // // // // // // // // // // // //                     // TTTimetableFInalCollector.SETRANGE("Campus Code",ACALecturersUnits.);
        // // // // // // // // // // // // // //                     // TTTimetableFInalCollector.SETRANGE(Department,LectLoadBatchLines,Department);
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE("Room Code",TTTimetableCollectorDoubles."Room Code");
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE("Block/Building",TTTimetableCollectorDoubles."Block/Building");
        // // // // // // // // // // // // // //                     // TTTimetableFInalCollector.SETRANGE("Lesson Category",TTUnits."Weighting Category");
        // // // // // // // // // // // // // //                     // TTTimetableFInalCollector.SETRANGE("School or Faculty",LectLoadBatchLines.Faculty);
        // // // // // // // // // // // // // //                     IF NOT (TTTimetableFInalCollector.FIND('-')) THEN BEGIN
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.INIT;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.Programme:=TTTimetableCollectorDoubles.Programme;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.Unit:=TTTimetableCollectorDoubles.Unit;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.Semester:=Rec.Semester;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Lesson Code":=TTLessons1."Lesson Code";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Lesson Category":=TTTimetableCollectorDoubles."Lesson Category";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Date Code":=TTTimetableCollectorDoubles."Date Code";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Lecture Room":=TTTimetableCollectorDoubles."Room Code";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.Lecturer:=TTTimetableCollectorDoubles.Lecturer;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.Department:=TTTimetableCollectorDoubles.Department;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Day Order":=TTTimetableCollectorDoubles."Day Order";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Lesson Order":=TTLessons1."Lesson Order";
        // // // // // // // // // // // // // //                     //  TTTimetableFInalCollector."Programme Option":=;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Room Type":=TTTimetableCollectorDoubles."Room Type";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Room Code":=TTTimetableCollectorDoubles."Room Code";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Block/Building":=TTTimetableCollectorDoubles."Block/Building";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."School or Faculty":=TTTimetableCollectorDoubles."School or Faculty";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Campus Code":=TTTimetableCollectorDoubles."Campus Code";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Lesson Type":='DOUBLE';
        // // // // // // // // // // // // // //                       IF ((Rec.Semester<>'') AND (TTTimetableCollectorDoubles."Room Code"<>'') AND (TTTimetableCollectorDoubles.Lecturer<>'')) THEN BEGIN
        // // // // // // // // // // // // // //                         CountedEntries:=CountedEntries+1;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Record ID":=CountedEntries;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.INSERT;
        // // // // // // // // // // // // // //                         END;
        // // // // // // // // // // // // // //                       END;
        // // // // // // // // // // // // // //      END;
        // // // // // // // // // // // // // //
        // // // // // // // // // // // // // //    TTLessons2.RESET;
        // // // // // // // // // // // // // //    TTLessons2.SETRANGE("Lesson Order",TTTimetableCollectorDoubles."Lesson 2");
        // // // // // // // // // // // // // //    IF TTLessons2.FIND('-') THEN  BEGIN
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.RESET;
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE(Programme,TTTimetableCollectorDoubles.Programme);
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE(Unit,TTTimetableCollectorDoubles.Unit);
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE(Semester,Rec.Semester);
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE("Lesson Code",TTLessons2."Lesson Code");
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE("Date Code",TTTimetableCollectorDoubles."Date Code");
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE("Lecture Room",TTTimetableCollectorDoubles."Lecture Room");
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE(Lecturer,TTTimetableCollectorDoubles.Lecturer);
        // // // // // // // // // // // // // //                     // TTTimetableFInalCollector.SETRANGE("Campus Code",ACALecturersUnits.);
        // // // // // // // // // // // // // //                     // TTTimetableFInalCollector.SETRANGE(Department,LectLoadBatchLines,Department);
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE("Room Code",TTTimetableCollectorDoubles."Room Code");
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE("Block/Building",TTTimetableCollectorDoubles."Block/Building");
        // // // // // // // // // // // // // //                     // TTTimetableFInalCollector.SETRANGE("Lesson Category",TTUnits."Weighting Category");
        // // // // // // // // // // // // // //                     // TTTimetableFInalCollector.SETRANGE("School or Faculty",LectLoadBatchLines.Faculty);
        // // // // // // // // // // // // // //                     IF NOT (TTTimetableFInalCollector.FIND('-')) THEN BEGIN
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.INIT;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.Programme:=TTTimetableCollectorDoubles.Programme;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.Unit:=TTTimetableCollectorDoubles.Unit;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.Semester:=Rec.Semester;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Lesson Code":=TTLessons2."Lesson Code";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Lesson Category":=TTTimetableCollectorDoubles."Lesson Category";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Date Code":=TTTimetableCollectorDoubles."Date Code";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Lecture Room":=TTTimetableCollectorDoubles."Room Code";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.Lecturer:=TTTimetableCollectorDoubles.Lecturer;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.Department:=TTTimetableCollectorDoubles.Department;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Day Order":=TTTimetableCollectorDoubles."Day Order";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Lesson Order":=TTLessons2."Lesson Order";
        // // // // // // // // // // // // // //                     //  TTTimetableFInalCollector."Programme Option":=;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Room Type":=TTTimetableCollectorDoubles."Room Type";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Room Code":=TTTimetableCollectorDoubles."Room Code";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Block/Building":=TTTimetableCollectorDoubles."Block/Building";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."School or Faculty":=TTTimetableCollectorDoubles."School or Faculty";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Campus Code":=TTTimetableCollectorDoubles."Campus Code";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Lesson Type":='DOUBLE';
        // // // // // // // // // // // // // //                       IF ((Rec.Semester<>'') AND (TTTimetableCollectorDoubles."Room Code"<>'') AND (TTTimetableCollectorDoubles.Lecturer<>'')) THEN BEGIN
        // // // // // // // // // // // // // //                         CountedEntries:=CountedEntries+1;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Record ID":=CountedEntries;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.INSERT;
        // // // // // // // // // // // // // //                         END;
        // // // // // // // // // // // // // //                       END;
        // // // // // // // // // // // // // //      END;
        // // // // // // // // // // // // // //    END;
        // // // // // // // // // // // // // //    UNTIL TTTimetableCollectorDoubles.NEXT=0;
        // // // // // // // // // // // // // //  END;
        // // // // // // // // // // // // // //  progre.CLOSE;
        // // // // // // // // // // // // // //          /////////////////////////////////////////////////////////////////////////////////////////////Progress Initiate
        // // // // // // // // // // // // // // CLEAR(progDots);
        // // // // // // // // // // // // // // CLEAR(RecCount1);
        // // // // // // // // // // // // // // CLEAR(RecCount2);
        // // // // // // // // // // // // // // CLEAR(RecCount3);
        // // // // // // // // // // // // // // CLEAR(RecCount4);
        // // // // // // // // // // // // // // CLEAR(RecCount5);
        // // // // // // // // // // // // // // CLEAR(RecCount6);
        // // // // // // // // // // // // // // CLEAR(RecCount7);
        // // // // // // // // // // // // // // CLEAR(RecCount8);
        // // // // // // // // // // // // // // CLEAR(RecCount9);
        // // // // // // // // // // // // // // CLEAR(RecCount10);
        // // // // // // // // // // // // // // CLEAR(counts);
        // // // // // // // // // // // // // // progre.OPEN('Finalizing Tripples:  #1#############################'+
        // // // // // // // // // // // // // // '\ '+
        // // // // // // // // // // // // // // '\#2###############################################################'+
        // // // // // // // // // // // // // // '\#3###############################################################'+
        // // // // // // // // // // // // // // '\#4###############################################################'+
        // // // // // // // // // // // // // // '\#5###############################################################'+
        // // // // // // // // // // // // // // '\#6###############################################################'+
        // // // // // // // // // // // // // // '\#7###############################################################'+
        // // // // // // // // // // // // // // '\#8###############################################################'+
        // // // // // // // // // // // // // // '\#9###############################################################'+
        // // // // // // // // // // // // // // '\#10###############################################################'+
        // // // // // // // // // // // // // // '\#11###############################################################'+
        // // // // // // // // // // // // // // '\#12###############################################################'+
        // // // // // // // // // // // // // // '\#13###############################################################'+
        // // // // // // // // // // // // // // '\#14###############################################################',
        // // // // // // // // // // // // // //    progDots,
        // // // // // // // // // // // // // //    RecCount1,
        // // // // // // // // // // // // // //    RecCount2,
        // // // // // // // // // // // // // //    RecCount3,
        // // // // // // // // // // // // // //    RecCount4,
        // // // // // // // // // // // // // //    RecCount5,
        // // // // // // // // // // // // // //    RecCount6,
        // // // // // // // // // // // // // //    RecCount7,
        // // // // // // // // // // // // // //    RecCount8,
        // // // // // // // // // // // // // //    RecCount9,
        // // // // // // // // // // // // // //    RecCount10,
        // // // // // // // // // // // // // //    Var1,
        // // // // // // // // // // // // // //    Var1,
        // // // // // // // // // // // // // //    BufferString
        // // // // // // // // // // // // // // );
        // // // // // // // // // // // // // // /////////////////////////////////////////////////////////////////////////////////////////////Progress Initiate
        // // // // // // // // // // // // // //  //Capture the Tripples
        // // // // // // // // // // // // // // TTTimetableCollectorTripple.RESET;
        // // // // // // // // // // // // // // TTTimetableCollectorTripple.SETRANGE(Semester,Rec.Semester);
        // // // // // // // // // // // // // // TTTimetableCollectorTripple.SETRANGE(Allocated,TRUE);
        // // // // // // // // // // // // // // IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
        // // // // // // // // // // // // // //  REPEAT
        // // // // // // // // // // // // // //    BEGIN
        // // // // // // // // // // // // // //
        // // // // // // // // // // // // // //                    ///////////////////////////////////////////////////////////////////////////////Progress Update
        // // // // // // // // // // // // // //                    CLEAR(Var1);
        // // // // // // // // // // // // // //    counts:=counts+1;
        // // // // // // // // // // // // // //    IF ((counted=21) OR(counted=11)) THEN BEGIN
        // // // // // // // // // // // // // //    IF counted=21 THEN counted := 0;
        // // // // // // // // // // // // // //    //SLEEP(150);
        // // // // // // // // // // // // // //    END;
        // // // // // // // // // // // // // //    counted:=counted+1;
        // // // // // // // // // // // // // //    IF counted=1 THEN progDots:=text1
        // // // // // // // // // // // // // //    ELSE IF counted=2 THEN progDots:=text2
        // // // // // // // // // // // // // //    ELSE IF counted=3 THEN progDots:=text3
        // // // // // // // // // // // // // //    ELSE IF counted=4 THEN progDots:=text4
        // // // // // // // // // // // // // //    ELSE IF counted=5 THEN progDots:=text5
        // // // // // // // // // // // // // //    ELSE IF counted=6 THEN progDots:=text6
        // // // // // // // // // // // // // //    ELSE IF counted=7 THEN progDots:=text7
        // // // // // // // // // // // // // //    ELSE IF counted=8 THEN progDots:=text8
        // // // // // // // // // // // // // //    ELSE IF counted=9 THEN progDots:=text9
        // // // // // // // // // // // // // //    ELSE IF counted=10 THEN progDots:=text10
        // // // // // // // // // // // // // //    ELSE IF counted=19 THEN progDots:=text1
        // // // // // // // // // // // // // //    ELSE IF counted=18 THEN progDots:=text2
        // // // // // // // // // // // // // //    ELSE IF counted=17 THEN progDots:=text3
        // // // // // // // // // // // // // //    ELSE IF counted=16 THEN progDots:=text4
        // // // // // // // // // // // // // //    ELSE IF counted=15 THEN progDots:=text5
        // // // // // // // // // // // // // //    ELSE IF counted=14 THEN progDots:=text6
        // // // // // // // // // // // // // //    ELSE IF counted=13 THEN progDots:=text7
        // // // // // // // // // // // // // //    ELSE IF counted=12 THEN progDots:=text8
        // // // // // // // // // // // // // //    ELSE IF counted=11 THEN progDots:=text9
        // // // // // // // // // // // // // //    ELSE progDots:='';
        // // // // // // // // // // // // // //
        // // // // // // // // // // // // // //    IF counts=1 THEN
        // // // // // // // // // // // // // //    RecCount1:=FORMAT(counts)+'). Lecturer: '+TTTimetableCollectorTripple.Lecturer+'; Programme: '+TTTimetableCollectorTripple.Programme+'; Unit: '+
        // // // // // // // // // // // // // // TTTimetableCollectorTripple.Unit+'; Campus: '+TTTimetableCollectorTripple."Campus Code"
        // // // // // // // // // // // // // //    ELSE IF counts=2 THEN BEGIN
        // // // // // // // // // // // // // //    RecCount2:=FORMAT(counts)+'). Lecturer: '+TTTimetableCollectorTripple.Lecturer+'; Programme: '+TTTimetableCollectorTripple.Programme+'; Unit: '+
        // // // // // // // // // // // // // // TTTimetableCollectorTripple.Unit+'; Campus: '+TTTimetableCollectorTripple."Campus Code"
        // // // // // // // // // // // // // //    END
        // // // // // // // // // // // // // //    ELSE IF counts=3 THEN BEGIN
        // // // // // // // // // // // // // //    RecCount3:=FORMAT(counts)+'). Lecturer: '+TTTimetableCollectorTripple.Lecturer+'; Programme: '+TTTimetableCollectorTripple.Programme+'; Unit: '+
        // // // // // // // // // // // // // // TTTimetableCollectorTripple.Unit+'; Campus: '+TTTimetableCollectorTripple."Campus Code"
        // // // // // // // // // // // // // //    END
        // // // // // // // // // // // // // //    ELSE IF counts=4 THEN BEGIN
        // // // // // // // // // // // // // //    RecCount4:=FORMAT(counts)+'). Lecturer: '+TTTimetableCollectorTripple.Lecturer+'; Programme: '+TTTimetableCollectorTripple.Programme+'; Unit: '+
        // // // // // // // // // // // // // // TTTimetableCollectorTripple.Unit+'; Campus: '+TTTimetableCollectorTripple."Campus Code"
        // // // // // // // // // // // // // //    END
        // // // // // // // // // // // // // //    ELSE IF counts=5 THEN BEGIN
        // // // // // // // // // // // // // //    RecCount5:=FORMAT(counts)+'). Lecturer: '+TTTimetableCollectorTripple.Lecturer+'; Programme: '+TTTimetableCollectorTripple.Programme+'; Unit: '+
        // // // // // // // // // // // // // // TTTimetableCollectorTripple.Unit+'; Campus: '+TTTimetableCollectorTripple."Campus Code"
        // // // // // // // // // // // // // //    END
        // // // // // // // // // // // // // //    ELSE IF counts=6 THEN BEGIN
        // // // // // // // // // // // // // //    RecCount6:=FORMAT(counts)+'). Lecturer: '+TTTimetableCollectorTripple.Lecturer+'; Programme: '+TTTimetableCollectorTripple.Programme+'; Unit: '+
        // // // // // // // // // // // // // // TTTimetableCollectorTripple.Unit+'; Campus: '+TTTimetableCollectorTripple."Campus Code"
        // // // // // // // // // // // // // //    END
        // // // // // // // // // // // // // //    ELSE IF counts=7 THEN BEGIN
        // // // // // // // // // // // // // //    RecCount7:=FORMAT(counts)+'). Lecturer: '+TTTimetableCollectorTripple.Lecturer+'; Programme: '+TTTimetableCollectorTripple.Programme+'; Unit: '+
        // // // // // // // // // // // // // // TTTimetableCollectorTripple.Unit+'; Campus: '+TTTimetableCollectorTripple."Campus Code"
        // // // // // // // // // // // // // //    END
        // // // // // // // // // // // // // //    ELSE IF counts=8 THEN BEGIN
        // // // // // // // // // // // // // //    RecCount8:=FORMAT(counts)+'). Lecturer: '+TTTimetableCollectorTripple.Lecturer+'; Programme: '+TTTimetableCollectorTripple.Programme+'; Unit: '+
        // // // // // // // // // // // // // // TTTimetableCollectorTripple.Unit+'; Campus: '+TTTimetableCollectorTripple."Campus Code"
        // // // // // // // // // // // // // //    END
        // // // // // // // // // // // // // //    ELSE IF counts=9 THEN BEGIN
        // // // // // // // // // // // // // //    RecCount9:=FORMAT(counts)+'). Lecturer: '+TTTimetableCollectorTripple.Lecturer+'; Programme: '+TTTimetableCollectorTripple.Programme+'; Unit: '+
        // // // // // // // // // // // // // // TTTimetableCollectorTripple.Unit+'; Campus: '+TTTimetableCollectorTripple."Campus Code"
        // // // // // // // // // // // // // //    END
        // // // // // // // // // // // // // //    ELSE IF counts=10 THEN BEGIN
        // // // // // // // // // // // // // //    RecCount10:=FORMAT(counts)+'). Lecturer: '+TTTimetableCollectorTripple.Lecturer+'; Programme: '+TTTimetableCollectorTripple.Programme+'; Unit: '+
        // // // // // // // // // // // // // // TTTimetableCollectorTripple.Unit+'; Campus: '+TTTimetableCollectorTripple."Campus Code"
        // // // // // // // // // // // // // //    END ELSE IF counts>10 THEN BEGIN
        // // // // // // // // // // // // // //    RecCount1:=RecCount2;
        // // // // // // // // // // // // // //    RecCount2:=RecCount3;
        // // // // // // // // // // // // // //    RecCount3:=RecCount4;
        // // // // // // // // // // // // // //    RecCount4:=RecCount5;
        // // // // // // // // // // // // // //    RecCount5:=RecCount6;
        // // // // // // // // // // // // // //    RecCount6:=RecCount7;
        // // // // // // // // // // // // // //    RecCount7:=RecCount8;
        // // // // // // // // // // // // // //    RecCount8:=RecCount9;
        // // // // // // // // // // // // // //    RecCount9:=RecCount10;
        // // // // // // // // // // // // // //    RecCount10:=FORMAT(counts)+'). Lecturer: '+TTTimetableCollectorTripple.Lecturer+'; Programme: '+TTTimetableCollectorTripple.Programme+'; Unit: '+
        // // // // // // // // // // // // // // TTTimetableCollectorTripple.Unit+'; Campus: '+TTTimetableCollectorTripple."Campus Code";
        // // // // // // // // // // // // // //    END;
        // // // // // // // // // // // // // //    CLEAR(BufferString);
        // // // // // // // // // // // // // //    BufferString:='Total Tripples processed = '+FORMAT(counts);
        // // // // // // // // // // // // // //
        // // // // // // // // // // // // // //    progre.UPDATE();
        // // // // // // // // // // // // // //     //SLEEP(50);
        // // // // // // // // // // // // // //                    ///////////////////////////////////////////////////////////////////////////////Progress Update
        // // // // // // // // // // // // // //    TTLessons1.RESET;
        // // // // // // // // // // // // // //    TTLessons1.SETRANGE("Lesson Order",TTTimetableCollectorTripple."Lesson 1");
        // // // // // // // // // // // // // //    IF TTLessons1.FIND('-') THEN  BEGIN
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.RESET;
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE(Programme,TTTimetableCollectorTripple.Programme);
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE(Unit,TTTimetableCollectorTripple.Unit);
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE(Semester,Rec.Semester);
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE("Lesson Code",TTLessons1."Lesson Code");
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE("Date Code",TTTimetableCollectorTripple."Date Code");
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE("Lecture Room",TTTimetableCollectorTripple."Lecture Room");
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE(Lecturer,TTTimetableCollectorTripple.Lecturer);
        // // // // // // // // // // // // // //                     // TTTimetableFInalCollector.SETRANGE("Campus Code",ACALecturersUnits.);
        // // // // // // // // // // // // // //                     // TTTimetableFInalCollector.SETRANGE(Department,LectLoadBatchLines,Department);
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE("Room Code",TTTimetableCollectorTripple."Room Code");
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE("Block/Building",TTTimetableCollectorTripple."Block/Building");
        // // // // // // // // // // // // // //                     // TTTimetableFInalCollector.SETRANGE("Lesson Category",TTUnits."Weighting Category");
        // // // // // // // // // // // // // //                     // TTTimetableFInalCollector.SETRANGE("School or Faculty",LectLoadBatchLines.Faculty);
        // // // // // // // // // // // // // //                     IF NOT (TTTimetableFInalCollector.FIND('-')) THEN BEGIN
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.INIT;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.Programme:=TTTimetableCollectorTripple.Programme;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.Unit:=TTTimetableCollectorTripple.Unit;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.Semester:=Rec.Semester;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Lesson Code":=TTLessons1."Lesson Code";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Lesson Category":=TTTimetableCollectorTripple."Lesson Category";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Date Code":=TTTimetableCollectorTripple."Date Code";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Lecture Room":=TTTimetableCollectorTripple."Room Code";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.Lecturer:=TTTimetableCollectorTripple.Lecturer;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.Department:=TTTimetableCollectorTripple.Department;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Day Order":=TTTimetableCollectorTripple."Day Order";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Lesson Order":=TTLessons1."Lesson Order";
        // // // // // // // // // // // // // //                     //  TTTimetableFInalCollector."Programme Option":=;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Room Type":=TTTimetableCollectorTripple."Room Type";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Room Code":=TTTimetableCollectorTripple."Room Code";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Block/Building":=TTTimetableCollectorTripple."Block/Building";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."School or Faculty":=TTTimetableCollectorTripple."School or Faculty";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Campus Code":=TTTimetableCollectorTripple."Campus Code";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Lesson Type":='TRIPPLE';
        // // // // // // // // // // // // // //                       IF ((Rec.Semester<>'') AND (TTTimetableCollectorTripple."Room Code"<>'') AND (TTTimetableCollectorTripple.Lecturer<>'')) THEN BEGIN
        // // // // // // // // // // // // // //                         CountedEntries:=CountedEntries+1;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Record ID":=CountedEntries;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.INSERT;
        // // // // // // // // // // // // // //                         END;
        // // // // // // // // // // // // // //                       END;
        // // // // // // // // // // // // // //      END;
        // // // // // // // // // // // // // //
        // // // // // // // // // // // // // //    TTLessons2.RESET;
        // // // // // // // // // // // // // //    TTLessons2.SETRANGE("Lesson Order",TTTimetableCollectorTripple."Lesson 2");
        // // // // // // // // // // // // // //    IF TTLessons2.FIND('-') THEN  BEGIN
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.RESET;
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE(Programme,TTTimetableCollectorTripple.Programme);
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE(Unit,TTTimetableCollectorTripple.Unit);
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE(Semester,Rec.Semester);
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE("Lesson Code",TTLessons2."Lesson Code");
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE("Date Code",TTTimetableCollectorTripple."Date Code");
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE("Lecture Room",TTTimetableCollectorTripple."Lecture Room");
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE(Lecturer,TTTimetableCollectorTripple.Lecturer);
        // // // // // // // // // // // // // //                     // TTTimetableFInalCollector.SETRANGE("Campus Code",ACALecturersUnits.);
        // // // // // // // // // // // // // //                     // TTTimetableFInalCollector.SETRANGE(Department,LectLoadBatchLines,Department);
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE("Room Code",TTTimetableCollectorTripple."Room Code");
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE("Block/Building",TTTimetableCollectorTripple."Block/Building");
        // // // // // // // // // // // // // //                     // TTTimetableFInalCollector.SETRANGE("Lesson Category",TTUnits."Weighting Category");
        // // // // // // // // // // // // // //                     // TTTimetableFInalCollector.SETRANGE("School or Faculty",LectLoadBatchLines.Faculty);
        // // // // // // // // // // // // // //                     IF NOT (TTTimetableFInalCollector.FIND('-')) THEN BEGIN
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.INIT;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.Programme:=TTTimetableCollectorTripple.Programme;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.Unit:=TTTimetableCollectorTripple.Unit;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.Semester:=Rec.Semester;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Lesson Code":=TTLessons2."Lesson Code";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Lesson Category":=TTTimetableCollectorTripple."Lesson Category";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Date Code":=TTTimetableCollectorTripple."Date Code";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Lecture Room":=TTTimetableCollectorTripple."Room Code";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.Lecturer:=TTTimetableCollectorTripple.Lecturer;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.Department:=TTTimetableCollectorTripple.Department;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Day Order":=TTTimetableCollectorTripple."Day Order";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Lesson Order":=TTLessons2."Lesson Order";
        // // // // // // // // // // // // // //                     //  TTTimetableFInalCollector."Programme Option":=;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Room Type":=TTTimetableCollectorTripple."Room Type";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Room Code":=TTTimetableCollectorTripple."Room Code";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Block/Building":=TTTimetableCollectorTripple."Block/Building";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."School or Faculty":=TTTimetableCollectorTripple."School or Faculty";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Campus Code":=TTTimetableCollectorTripple."Campus Code";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Lesson Type":='TRIPPLE';
        // // // // // // // // // // // // // //                       IF ((Rec.Semester<>'') AND (TTTimetableCollectorTripple."Room Code"<>'') AND (TTTimetableCollectorTripple.Lecturer<>'')) THEN BEGIN
        // // // // // // // // // // // // // //                         CountedEntries:=CountedEntries+1;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Record ID":=CountedEntries;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.INSERT;
        // // // // // // // // // // // // // //                         END;
        // // // // // // // // // // // // // //                       END;
        // // // // // // // // // // // // // //      END;
        // // // // // // // // // // // // // //    TTLessons3.RESET;
        // // // // // // // // // // // // // //    TTLessons3.SETRANGE("Lesson Order",TTTimetableCollectorTripple."Lesson 3");
        // // // // // // // // // // // // // //    IF TTLessons3.FIND('-') THEN  BEGIN
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.RESET;
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE(Programme,TTTimetableCollectorTripple.Programme);
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE(Unit,TTTimetableCollectorTripple.Unit);
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE(Semester,Rec.Semester);
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE("Lesson Code",TTLessons3."Lesson Code");
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE("Date Code",TTTimetableCollectorTripple."Date Code");
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE("Lecture Room",TTTimetableCollectorTripple."Lecture Room");
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE(Lecturer,TTTimetableCollectorTripple.Lecturer);
        // // // // // // // // // // // // // //                     // TTTimetableFInalCollector.SETRANGE("Campus Code",ACALecturersUnits.);
        // // // // // // // // // // // // // //                     // TTTimetableFInalCollector.SETRANGE(Department,LectLoadBatchLines,Department);
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE("Room Code",TTTimetableCollectorTripple."Room Code");
        // // // // // // // // // // // // // //                      TTTimetableFInalCollector.SETRANGE("Block/Building",TTTimetableCollectorTripple."Block/Building");
        // // // // // // // // // // // // // //                     // TTTimetableFInalCollector.SETRANGE("Lesson Category",TTUnits."Weighting Category");
        // // // // // // // // // // // // // //                     // TTTimetableFInalCollector.SETRANGE("School or Faculty",LectLoadBatchLines.Faculty);
        // // // // // // // // // // // // // //                     IF NOT (TTTimetableFInalCollector.FIND('-')) THEN BEGIN
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.INIT;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.Programme:=TTTimetableCollectorTripple.Programme;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.Unit:=TTTimetableCollectorTripple.Unit;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.Semester:=Rec.Semester;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Lesson Code":=TTLessons3."Lesson Code";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Lesson Category":=TTTimetableCollectorTripple."Lesson Category";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Date Code":=TTTimetableCollectorTripple."Date Code";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Lecture Room":=TTTimetableCollectorTripple."Room Code";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.Lecturer:=TTTimetableCollectorTripple.Lecturer;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.Department:=TTTimetableCollectorTripple.Department;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Day Order":=TTTimetableCollectorTripple."Day Order";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Lesson Order":=TTLessons3."Lesson Order";
        // // // // // // // // // // // // // //                     //  TTTimetableFInalCollector."Programme Option":=;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Room Type":=TTTimetableCollectorTripple."Room Type";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Room Code":=TTTimetableCollectorTripple."Room Code";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Block/Building":=TTTimetableCollectorTripple."Block/Building";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."School or Faculty":=TTTimetableCollectorTripple."School or Faculty";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Campus Code":=TTTimetableCollectorTripple."Campus Code";
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Lesson Type":='TRIPPLE';
        // // // // // // // // // // // // // //                       IF ((Rec.Semester<>'') AND (TTTimetableCollectorTripple."Room Code"<>'') AND (TTTimetableCollectorTripple.Lecturer<>'')) THEN BEGIN
        // // // // // // // // // // // // // //                         CountedEntries:=CountedEntries+1;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector."Record ID":=CountedEntries;
        // // // // // // // // // // // // // //                       TTTimetableFInalCollector.INSERT;
        // // // // // // // // // // // // // //                         END;
        // // // // // // // // // // // // // //                       END;
        // // // // // // // // // // // // // //      END;
        // // // // // // // // // // // // // //    END;
        // // // // // // // // // // // // // //    UNTIL TTTimetableCollectorTripple.NEXT=0;
        // // // // // // // // // // // // // //  END;
        // // // // // // // // // // // // // //  progre.CLOSE;
    end;

    local procedure SpecificConstraintsProgCampuses()
    var
        TTProgSpecCampuses: Record 74558;
        TTProgSpecDays: Record 74559;
        TTLectSpecCampuses: Record 74560;
        TTLectSpecDays: Record 74561;
        TTLectSpecLessons: Record 74562;
        TTUnitSpecCampuses: Record 74564;
        TTUnitSpecRooms: Record 74565;
        TTTimetableCollectorSingles: Record 74557;
        TTProgrammes: Record 74553;
        TTUnits: Record 74554;
        TTLecturers: Record 74555;
        ToDeleteSingles: Boolean;
        ToDeleteDoubles: Boolean;
        ToDeleteTripples: Boolean;
    begin
        //////////////////////////////////////////////////////////////Prog Spec. Campus on Singles
        TTProgrammes.RESET;
        TTProgrammes.SETRANGE(Semester, Rec.Semester);
        IF TTProgrammes.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                TTProgSpecCampuses.RESET;
                TTProgSpecCampuses.SETRANGE(Semester, Rec.Semester);
                TTProgSpecCampuses.SETRANGE("Programme Code", TTProgrammes."Programme Code");
                TTProgSpecCampuses.SETFILTER("Campus Code", '<>%1', '');
                IF TTProgSpecCampuses.FIND('-') THEN BEGIN
                    //There Exists Programme Specific Campus
                    REPEAT
                    BEGIN
                        IF TTProgSpecCampuses."Constraint Category" = TTProgSpecCampuses."Constraint Category"::Avoid THEN BEGIN
                            //Delete all entries for the Programme and Campus Specified
                            TTTimetableCollectorSingles.RESET;
                            TTTimetableCollectorSingles.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorSingles.SETFILTER("Campus Code", '%1', TTProgSpecCampuses."Campus Code");
                            IF TTTimetableCollectorSingles.FIND('-') THEN TTTimetableCollectorSingles.DELETEALL;
                        END;
                        IF TTProgSpecCampuses."Constraint Category" = TTProgSpecCampuses."Constraint Category"::"Least Preferred" THEN BEGIN
                            //For the Programme and Campus Specified, Set Priority as 10
                            TTTimetableCollectorSingles.RESET;
                            TTTimetableCollectorSingles.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorSingles.SETFILTER("Campus Code", '%1', TTProgSpecCampuses."Campus Code");
                            IF TTTimetableCollectorSingles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorSingles."Programme Campus Priority" := 10;
                                    TTTimetableCollectorSingles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorSingles.NEXT = 0;
                            END;
                        END;

                        IF TTProgSpecCampuses."Constraint Category" = TTProgSpecCampuses."Constraint Category"::Preferred THEN BEGIN
                            //For the Programme and Campus Specified, Set Priority as 1
                            TTTimetableCollectorSingles.RESET;
                            TTTimetableCollectorSingles.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorSingles.SETFILTER("Campus Code", '%1', TTProgSpecCampuses."Campus Code");
                            IF TTTimetableCollectorSingles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorSingles."Programme Campus Priority" := 1;
                                    TTTimetableCollectorSingles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorSingles.NEXT = 0;
                            END;
                        END;

                        IF TTProgSpecCampuses."Constraint Category" = TTProgSpecCampuses."Constraint Category"::Mandatory THEN BEGIN
                            //For the Programme and Campus Specified, Set Priority as 1
                            TTTimetableCollectorSingles.RESET;
                            TTTimetableCollectorSingles.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorSingles.SETFILTER("Campus Code", '%1', TTProgSpecCampuses."Campus Code");
                            IF TTTimetableCollectorSingles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorSingles."Programme Campus Priority" := 1;
                                    TTTimetableCollectorSingles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorSingles.NEXT = 0;
                            END;
                        END;
                    END;
                    UNTIL TTProgSpecCampuses.NEXT = 0;
                END;


                TTTimetableCollectorSingles.RESET;
                TTTimetableCollectorSingles.SETRANGE(Programme, TTProgrammes."Programme Code");
                CLEAR(ToDeleteSingles);
                //// If the Constraints are Nandatory
                TTProgSpecCampuses.RESET;
                TTProgSpecCampuses.SETRANGE(Semester, Rec.Semester);
                TTProgSpecCampuses.SETRANGE("Programme Code", TTProgrammes."Programme Code");
                TTProgSpecCampuses.SETFILTER("Campus Code", '<>%1', '');
                TTProgSpecCampuses.SETFILTER("Constraint Category", '=%1', TTProgSpecCampuses."Constraint Category"::Mandatory);
                IF TTProgSpecCampuses.FIND('-') THEN BEGIN
                    //There Exists Programme Specific Campus Where Category is Mandatory
                    ToDeleteSingles := TRUE;
                    REPEAT
                    BEGIN
                        //Keep filtering where Campus code is Not the one selected...
                        TTTimetableCollectorSingles.SETFILTER("Campus Code", '<>%1', TTProgSpecCampuses."Campus Code");
                    END;
                    UNTIL TTProgSpecCampuses.NEXT = 0;
                    // After Repeated Filtering, Delete All Entries in the Filters
                    IF ToDeleteSingles THEN TTTimetableCollectorSingles.DELETE;
                END;
            END;
            UNTIL TTProgrammes.NEXT = 0;
        END;
        //////////////////////////////////////////////////////////////Prog Spec. Campus on Singles
        // // // // // // //////////////////////////////////////////////////////////////Prog Spec. Campus on Doubles
        // // // // // // TTProgrammes.RESET;
        // // // // // // TTProgrammes.SETRANGE(Semester,Rec.Semester);
        // // // // // // IF TTProgrammes.FIND('-') THEN BEGIN
        // // // // // //  REPEAT
        // // // // // //    BEGIN
        // // // // // // TTProgSpecCampuses.RESET;
        // // // // // // TTProgSpecCampuses.SETRANGE(Semester,Rec.Semester);
        // // // // // // TTProgSpecCampuses.SETRANGE("Programme Code",TTProgrammes."Programme Code");
        // // // // // // TTProgSpecCampuses.SETFILTER("Campus Code",'<>%1','');
        // // // // // // IF TTProgSpecCampuses.FIND('-') THEN BEGIN
        // // // // // //  //There Exists Programme Specific Campus
        // // // // // //  REPEAT
        // // // // // //    BEGIN
        // // // // // //    IF TTProgSpecCampuses."Constraint Category"=TTProgSpecCampuses."Constraint Category"::Avoid THEN BEGIN
        // // // // // //      //Delete all entries for the Programme and Campus Specified
        // // // // // //    TTTimetableCollectorDoubles.RESET;
        // // // // // //    TTTimetableCollectorDoubles.SETRANGE(Programme,TTProgrammes."Programme Code");
        // // // // // //    TTTimetableCollectorDoubles.SETFILTER("Campus Code",'%1',TTProgSpecCampuses."Campus Code");
        // // // // // //    IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
        // // // // // //      END;
        // // // // // //    IF TTProgSpecCampuses."Constraint Category"=TTProgSpecCampuses."Constraint Category"::"Least Preferred" THEN BEGIN
        // // // // // //      //For the Programme and Campus Specified, Set Priority as 10
        // // // // // //    TTTimetableCollectorDoubles.RESET;
        // // // // // //    TTTimetableCollectorDoubles.SETRANGE(Programme,TTProgrammes."Programme Code");
        // // // // // //    TTTimetableCollectorDoubles.SETFILTER("Campus Code",'%1',TTProgSpecCampuses."Campus Code");
        // // // // // //    IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
        // // // // // //    REPEAT
        // // // // // //    BEGIN
        // // // // // //      TTTimetableCollectorDoubles."Programme Campus Priority":=10;
        // // // // // //      TTTimetableCollectorDoubles.MODIFY;
        // // // // // //    END;
        // // // // // //    UNTIL TTTimetableCollectorDoubles.NEXT=0;
        // // // // // //    END;
        // // // // // //      END;
        // // // // // //
        // // // // // //    IF TTProgSpecCampuses."Constraint Category"=TTProgSpecCampuses."Constraint Category"::Preferred THEN BEGIN
        // // // // // //      //For the Programme and Campus Specified, Set Priority as 1
        // // // // // //    TTTimetableCollectorDoubles.RESET;
        // // // // // //    TTTimetableCollectorDoubles.SETRANGE(Programme,TTProgrammes."Programme Code");
        // // // // // //    TTTimetableCollectorDoubles.SETFILTER("Campus Code",'%1',TTProgSpecCampuses."Campus Code");
        // // // // // //    IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
        // // // // // //    REPEAT
        // // // // // //    BEGIN
        // // // // // //      TTTimetableCollectorDoubles."Programme Campus Priority":=1;
        // // // // // //      TTTimetableCollectorDoubles.MODIFY;
        // // // // // //    END;
        // // // // // //    UNTIL TTTimetableCollectorDoubles.NEXT=0;
        // // // // // //    END;
        // // // // // //      END;
        // // // // // //
        // // // // // //    IF TTProgSpecCampuses."Constraint Category"=TTProgSpecCampuses."Constraint Category"::Mandatory THEN BEGIN
        // // // // // //      //For the Programme and Campus Specified, Set Priority as 1
        // // // // // //    TTTimetableCollectorDoubles.RESET;
        // // // // // //    TTTimetableCollectorDoubles.SETRANGE(Programme,TTProgrammes."Programme Code");
        // // // // // //    TTTimetableCollectorDoubles.SETFILTER("Campus Code",'%1',TTProgSpecCampuses."Campus Code");
        // // // // // //    IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
        // // // // // //    REPEAT
        // // // // // //    BEGIN
        // // // // // //      TTTimetableCollectorDoubles."Programme Campus Priority":=1;
        // // // // // //      TTTimetableCollectorDoubles.MODIFY;
        // // // // // //    END;
        // // // // // //    UNTIL TTTimetableCollectorDoubles.NEXT=0;
        // // // // // //    END;
        // // // // // //      END;
        // // // // // //    END;
        // // // // // //    UNTIL TTProgSpecCampuses.NEXT=0;
        // // // // // //  END;
        // // // // // //
        // // // // // //
        // // // // // //    TTTimetableCollectorDoubles.RESET;
        // // // // // //    TTTimetableCollectorDoubles.SETRANGE(Programme,TTProgrammes."Programme Code");
        // // // // // //  CLEAR(ToDeleteDoubles);
        // // // // // //    //// If the Constraints are Nandatory
        // // // // // //  TTProgSpecCampuses.RESET;
        // // // // // // TTProgSpecCampuses.SETRANGE(Semester,Rec.Semester);
        // // // // // // TTProgSpecCampuses.SETRANGE("Programme Code",TTProgrammes."Programme Code");
        // // // // // // TTProgSpecCampuses.SETFILTER("Campus Code",'<>%1','');
        // // // // // // TTProgSpecCampuses.SETFILTER("Constraint Category",'=%1',TTProgSpecCampuses."Constraint Category"::Mandatory);
        // // // // // // IF TTProgSpecCampuses.FIND('-') THEN BEGIN
        // // // // // //  //There Exists Programme Specific Campus Where Category is Mandatory
        // // // // // //    ToDeleteDoubles:=TRUE;
        // // // // // //  REPEAT
        // // // // // //    BEGIN
        // // // // // //    //Keep filtering where Campus code is Not the one selected...
        // // // // // //    TTTimetableCollectorDoubles.SETFILTER("Campus Code",'<>%1',TTProgSpecCampuses."Campus Code");
        // // // // // //    END;
        // // // // // //    UNTIL TTProgSpecCampuses.NEXT=0;
        // // // // // //    // After Repeated Filtering, Delete All Entries in the Filters
        // // // // // //    IF ToDeleteDoubles THEN TTTimetableCollectorDoubles.DELETE;
        // // // // // //  END;
        // // // // // // END;
        // // // // // // UNTIL TTProgrammes.NEXT=0;
        // // // // // // END;
        // // // // // // //////////////////////////////////////////////////////////////Prog Spec. Campus on Doubles
        // // // // // // //////////////////////////////////////////////////////////////Prog Spec. Campus on Tripples
        // // // // // // TTProgrammes.RESET;
        // // // // // // TTProgrammes.SETRANGE(Semester,Rec.Semester);
        // // // // // // IF TTProgrammes.FIND('-') THEN BEGIN
        // // // // // //  REPEAT
        // // // // // //    BEGIN
        // // // // // // TTProgSpecCampuses.RESET;
        // // // // // // TTProgSpecCampuses.SETRANGE(Semester,Rec.Semester);
        // // // // // // TTProgSpecCampuses.SETRANGE("Programme Code",TTProgrammes."Programme Code");
        // // // // // // TTProgSpecCampuses.SETFILTER("Campus Code",'<>%1','');
        // // // // // // IF TTProgSpecCampuses.FIND('-') THEN BEGIN
        // // // // // //  //There Exists Programme Specific Campus
        // // // // // //  REPEAT
        // // // // // //    BEGIN
        // // // // // //    IF TTProgSpecCampuses."Constraint Category"=TTProgSpecCampuses."Constraint Category"::Avoid THEN BEGIN
        // // // // // //      //Delete all entries for the Programme and Campus Specified
        // // // // // //    TTTimetableCollectorTripple.RESET;
        // // // // // //    TTTimetableCollectorTripple.SETRANGE(Programme,TTProgrammes."Programme Code");
        // // // // // //    TTTimetableCollectorTripple.SETFILTER("Campus Code",'%1',TTProgSpecCampuses."Campus Code");
        // // // // // //    IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
        // // // // // //      END;
        // // // // // //    IF TTProgSpecCampuses."Constraint Category"=TTProgSpecCampuses."Constraint Category"::"Least Preferred" THEN BEGIN
        // // // // // //      //For the Programme and Campus Specified, Set Priority as 10
        // // // // // //    TTTimetableCollectorTripple.RESET;
        // // // // // //    TTTimetableCollectorTripple.SETRANGE(Programme,TTProgrammes."Programme Code");
        // // // // // //    TTTimetableCollectorTripple.SETFILTER("Campus Code",'%1',TTProgSpecCampuses."Campus Code");
        // // // // // //    IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
        // // // // // //    REPEAT
        // // // // // //    BEGIN
        // // // // // //      TTTimetableCollectorTripple."Programme Campus Priority":=10;
        // // // // // //      TTTimetableCollectorTripple.MODIFY;
        // // // // // //    END;
        // // // // // //    UNTIL TTTimetableCollectorTripple.NEXT=0;
        // // // // // //    END;
        // // // // // //      END;
        // // // // // //
        // // // // // //    IF TTProgSpecCampuses."Constraint Category"=TTProgSpecCampuses."Constraint Category"::Preferred THEN BEGIN
        // // // // // //      //For the Programme and Campus Specified, Set Priority as 1
        // // // // // //    TTTimetableCollectorTripple.RESET;
        // // // // // //    TTTimetableCollectorTripple.SETRANGE(Programme,TTProgrammes."Programme Code");
        // // // // // //    TTTimetableCollectorTripple.SETFILTER("Campus Code",'%1',TTProgSpecCampuses."Campus Code");
        // // // // // //    IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
        // // // // // //    REPEAT
        // // // // // //    BEGIN
        // // // // // //      TTTimetableCollectorTripple."Programme Campus Priority":=1;
        // // // // // //      TTTimetableCollectorTripple.MODIFY;
        // // // // // //    END;
        // // // // // //    UNTIL TTTimetableCollectorTripple.NEXT=0;
        // // // // // //    END;
        // // // // // //      END;
        // // // // // //
        // // // // // //    IF TTProgSpecCampuses."Constraint Category"=TTProgSpecCampuses."Constraint Category"::Mandatory THEN BEGIN
        // // // // // //      //For the Programme and Campus Specified, Set Priority as 1
        // // // // // //    TTTimetableCollectorTripple.RESET;
        // // // // // //    TTTimetableCollectorTripple.SETRANGE(Programme,TTProgrammes."Programme Code");
        // // // // // //    TTTimetableCollectorTripple.SETFILTER("Campus Code",'%1',TTProgSpecCampuses."Campus Code");
        // // // // // //    IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
        // // // // // //    REPEAT
        // // // // // //    BEGIN
        // // // // // //      TTTimetableCollectorTripple."Programme Campus Priority":=1;
        // // // // // //      TTTimetableCollectorTripple.MODIFY;
        // // // // // //    END;
        // // // // // //    UNTIL TTTimetableCollectorTripple.NEXT=0;
        // // // // // //    END;
        // // // // // //      END;
        // // // // // //    END;
        // // // // // //    UNTIL TTProgSpecCampuses.NEXT=0;
        // // // // // //  END;
        // // // // // //
        // // // // // //
        // // // // // //    TTTimetableCollectorTripple.RESET;
        // // // // // //    TTTimetableCollectorTripple.SETRANGE(Programme,TTProgrammes."Programme Code");
        // // // // // //  CLEAR(ToDeleteTripples);
        // // // // // //    //// If the Constraints are Nandatory
        // // // // // //  TTProgSpecCampuses.RESET;
        // // // // // // TTProgSpecCampuses.SETRANGE(Semester,Rec.Semester);
        // // // // // // TTProgSpecCampuses.SETRANGE("Programme Code",TTProgrammes."Programme Code");
        // // // // // // TTProgSpecCampuses.SETFILTER("Campus Code",'<>%1','');
        // // // // // // TTProgSpecCampuses.SETFILTER("Constraint Category",'=%1',TTProgSpecCampuses."Constraint Category"::Mandatory);
        // // // // // // IF TTProgSpecCampuses.FIND('-') THEN BEGIN
        // // // // // //  //There Exists Programme Specific Campus Where Category is Mandatory
        // // // // // //    ToDeleteTripples:=TRUE;
        // // // // // //  REPEAT
        // // // // // //    BEGIN
        // // // // // //    //Keep filtering where Campus code is Not the one selected...
        // // // // // //    TTTimetableCollectorTripple.SETFILTER("Campus Code",'<>%1',TTProgSpecCampuses."Campus Code");
        // // // // // //    END;
        // // // // // //    UNTIL TTProgSpecCampuses.NEXT=0;
        // // // // // //    // After Repeated Filtering, Delete All Entries in the Filters
        // // // // // //    IF ToDeleteTripples THEN TTTimetableCollectorTripple.DELETE;
        // // // // // //  END;
        // // // // // // END;
        // // // // // // UNTIL TTProgrammes.NEXT=0;
        // // // // // // END;
        // // // // // // //////////////////////////////////////////////////////////////Prog Spec. Campus on Tripples
    end;

    local procedure SpecificConstraintsLectCampuses()
    var
        TTProgSpecCampuses: Record 74558;
        TTProgSpecDays: Record 74559;
        TTLectSpecCampuses: Record 74560;
        TTLectSpecDays: Record 74561;
        TTLectSpecLessons: Record 74562;
        TTUnitSpecCampuses: Record 74564;
        TTUnitSpecRooms: Record 74565;
        TTTimetableCollectorSingles: Record 74557;
        TTProgrammes: Record 74553;
        TTUnits: Record 74554;
        TTLecturers: Record 74555;
        ToDeleteSingles: Boolean;
        ToDeleteDoubles: Boolean;
        ToDeleteTripples: Boolean;
    begin
        //////////////////////////////////////////////////////////////Lect Spec. Campus on Singles
        TTLecturers.RESET;
        TTLecturers.SETRANGE(Semester, Rec.Semester);
        IF TTLecturers.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                TTLectSpecCampuses.RESET;
                TTLectSpecCampuses.SETRANGE(Semester, Rec.Semester);
                TTLectSpecCampuses.SETRANGE("Lecturer Code", TTLecturers."Lecturer Code");
                TTLectSpecCampuses.SETFILTER("Campus Code", '<>%1', '');
                IF TTLectSpecCampuses.FIND('-') THEN BEGIN
                    //There Exists Lect Specific Campus
                    REPEAT
                    BEGIN
                        IF TTLectSpecCampuses."Constraint Category" = TTLectSpecCampuses."Constraint Category"::Avoid THEN BEGIN
                            //Delete all entries for the Lecturer and Campus Specified
                            TTTimetableCollectorSingles.RESET;
                            TTTimetableCollectorSingles.SETRANGE(Lecturer, TTLecturers."Lecturer Code");
                            TTTimetableCollectorSingles.SETFILTER("Campus Code", '%1', TTLectSpecCampuses."Campus Code");
                            IF TTTimetableCollectorSingles.FIND('-') THEN TTTimetableCollectorSingles.DELETEALL;
                        END;
                        IF TTLectSpecCampuses."Constraint Category" = TTLectSpecCampuses."Constraint Category"::"Least Preferred" THEN BEGIN
                            //For the Lect and Campus Specified, Set Priority as 10
                            TTTimetableCollectorSingles.RESET;
                            TTTimetableCollectorSingles.SETRANGE(Lecturer, TTLecturers."Lecturer Code");
                            TTTimetableCollectorSingles.SETFILTER("Campus Code", '%1', TTLectSpecCampuses."Campus Code");
                            IF TTTimetableCollectorSingles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorSingles."Lecturer Campus Priority" := 10;
                                    TTTimetableCollectorSingles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorSingles.NEXT = 0;
                            END;
                        END;

                        IF TTLectSpecCampuses."Constraint Category" = TTLectSpecCampuses."Constraint Category"::Preferred THEN BEGIN
                            //For the Lect and Campus Specified, Set Priority as 1
                            TTTimetableCollectorSingles.RESET;
                            TTTimetableCollectorSingles.SETRANGE(Lecturer, TTLecturers."Lecturer Code");
                            TTTimetableCollectorSingles.SETFILTER("Campus Code", '%1', TTLectSpecCampuses."Campus Code");
                            IF TTTimetableCollectorSingles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorSingles."Lecturer Campus Priority" := 1;
                                    TTTimetableCollectorSingles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorSingles.NEXT = 0;
                            END;
                        END;

                        IF TTLectSpecCampuses."Constraint Category" = TTLectSpecCampuses."Constraint Category"::Mandatory THEN BEGIN
                            //For the Lect and Campus Specified, Set Priority as 1
                            TTTimetableCollectorSingles.RESET;
                            TTTimetableCollectorSingles.SETRANGE(Lecturer, TTLecturers."Lecturer Code");
                            TTTimetableCollectorSingles.SETFILTER("Campus Code", '%1', TTLectSpecCampuses."Campus Code");
                            IF TTTimetableCollectorSingles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorSingles."Lecturer Campus Priority" := 1;
                                    TTTimetableCollectorSingles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorSingles.NEXT = 0;
                            END;
                        END;
                    END;
                    UNTIL TTLectSpecCampuses.NEXT = 0;
                END;


                TTTimetableCollectorSingles.RESET;
                TTTimetableCollectorSingles.SETRANGE(Lecturer, TTLecturers."Lecturer Code");
                CLEAR(ToDeleteSingles);
                //// If the Constraints are Nandatory
                TTLectSpecCampuses.RESET;
                TTLectSpecCampuses.SETRANGE(Semester, Rec.Semester);
                TTLectSpecCampuses.SETRANGE("Lecturer Code", TTLecturers."Lecturer Code");
                TTLectSpecCampuses.SETFILTER("Campus Code", '<>%1', '');
                TTLectSpecCampuses.SETFILTER("Constraint Category", '=%1', TTLectSpecCampuses."Constraint Category"::Mandatory);
                IF TTLectSpecCampuses.FIND('-') THEN BEGIN
                    //There Exists Lect Specific Campus Where Category is Mandatory
                    ToDeleteSingles := TRUE;
                    REPEAT
                    BEGIN
                        //Keep filtering where Campus code is Not the one selected...
                        TTTimetableCollectorSingles.SETFILTER(Lecturer, '<>%1', TTLectSpecCampuses."Lecturer Code");
                    END;
                    UNTIL TTLectSpecCampuses.NEXT = 0;
                    // After Repeated Filtering, Delete All Entries in the Filters
                    IF ToDeleteSingles THEN TTTimetableCollectorSingles.DELETE;
                END;
            END;
            UNTIL TTLecturers.NEXT = 0;
        END;
        //////////////////////////////////////////////////////////////Lect Spec. Campus on Singles
        // // // // // // // //////////////////////////////////////////////////////////////Lect Spec. Campus on Doubles
        // // // // // // // TTLecturers.RESET;
        // // // // // // // TTLecturers.SETRANGE(Semester,Rec.Semester);
        // // // // // // // IF TTLecturers.FIND('-') THEN BEGIN
        // // // // // // //  REPEAT
        // // // // // // //    BEGIN
        // // // // // // // TTLectSpecCampuses.RESET;
        // // // // // // // TTLectSpecCampuses.SETRANGE(Semester,Rec.Semester);
        // // // // // // // TTLectSpecCampuses.SETRANGE("Lecturer Code",TTLecturers."Lecturer Code");
        // // // // // // // TTLectSpecCampuses.SETFILTER("Campus Code",'<>%1','');
        // // // // // // // IF TTLectSpecCampuses.FIND('-') THEN BEGIN
        // // // // // // //  //There Exists Lect Specific Campus
        // // // // // // //  REPEAT
        // // // // // // //    BEGIN
        // // // // // // //    IF TTLectSpecCampuses."Constraint Category"=TTLectSpecCampuses."Constraint Category"::Avoid THEN BEGIN
        // // // // // // //      //Delete all entries for the Lect and Campus Specified
        // // // // // // //    TTTimetableCollectorDoubles.RESET;
        // // // // // // //    TTTimetableCollectorDoubles.SETRANGE(Lecturer,TTLecturers."Lecturer Code");
        // // // // // // //    TTTimetableCollectorDoubles.SETFILTER("Campus Code",'%1',TTLectSpecCampuses."Campus Code");
        // // // // // // //    IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
        // // // // // // //      END;
        // // // // // // //    IF TTLectSpecCampuses."Constraint Category"=TTLectSpecCampuses."Constraint Category"::"Least Preferred" THEN BEGIN
        // // // // // // //      //For the Lect and Campus Specified, Set Priority as 10
        // // // // // // //    TTTimetableCollectorDoubles.RESET;
        // // // // // // //    TTTimetableCollectorDoubles.SETRANGE(Lecturer,TTLecturers."Lecturer Code");
        // // // // // // //    TTTimetableCollectorDoubles.SETFILTER("Campus Code",'%1',TTLectSpecCampuses."Campus Code");
        // // // // // // //    IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
        // // // // // // //    REPEAT
        // // // // // // //    BEGIN
        // // // // // // //      TTTimetableCollectorDoubles."Lecturer Campus Priority":=10;
        // // // // // // //      TTTimetableCollectorDoubles.MODIFY;
        // // // // // // //    END;
        // // // // // // //    UNTIL TTTimetableCollectorDoubles.NEXT=0;
        // // // // // // //    END;
        // // // // // // //      END;
        // // // // // // //
        // // // // // // //    IF TTLectSpecCampuses."Constraint Category"=TTLectSpecCampuses."Constraint Category"::Preferred THEN BEGIN
        // // // // // // //      //For the Lect and Campus Specified, Set Priority as 1
        // // // // // // //    TTTimetableCollectorDoubles.RESET;
        // // // // // // //    TTTimetableCollectorDoubles.SETRANGE(Lecturer,TTLecturers."Lecturer Code");
        // // // // // // //    TTTimetableCollectorDoubles.SETFILTER("Campus Code",'%1',TTLectSpecCampuses."Campus Code");
        // // // // // // //    IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
        // // // // // // //    REPEAT
        // // // // // // //    BEGIN
        // // // // // // //      TTTimetableCollectorDoubles."Lecturer Campus Priority":=1;
        // // // // // // //      TTTimetableCollectorDoubles.MODIFY;
        // // // // // // //    END;
        // // // // // // //    UNTIL TTTimetableCollectorDoubles.NEXT=0;
        // // // // // // //    END;
        // // // // // // //      END;
        // // // // // // //
        // // // // // // //    IF TTLectSpecCampuses."Constraint Category"=TTLectSpecCampuses."Constraint Category"::Mandatory THEN BEGIN
        // // // // // // //      //For the Lect and Campus Specified, Set Priority as 1
        // // // // // // //    TTTimetableCollectorDoubles.RESET;
        // // // // // // //    TTTimetableCollectorDoubles.SETRANGE(Lecturer,TTLecturers."Lecturer Code");
        // // // // // // //    TTTimetableCollectorDoubles.SETFILTER("Campus Code",'%1',TTLectSpecCampuses."Campus Code");
        // // // // // // //    IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
        // // // // // // //    REPEAT
        // // // // // // //    BEGIN
        // // // // // // //      TTTimetableCollectorDoubles."Lecturer Campus Priority":=1;
        // // // // // // //      TTTimetableCollectorDoubles.MODIFY;
        // // // // // // //    END;
        // // // // // // //    UNTIL TTTimetableCollectorDoubles.NEXT=0;
        // // // // // // //    END;
        // // // // // // //      END;
        // // // // // // //    END;
        // // // // // // //    UNTIL TTLectSpecCampuses.NEXT=0;
        // // // // // // //  END;
        // // // // // // //
        // // // // // // //
        // // // // // // //    TTTimetableCollectorDoubles.RESET;
        // // // // // // //    TTTimetableCollectorDoubles.SETRANGE(Lecturer,TTLecturers."Lecturer Code");
        // // // // // // //  CLEAR(ToDeleteDoubles);
        // // // // // // //    //// If the Constraints are Nandatory
        // // // // // // //  TTLectSpecCampuses.RESET;
        // // // // // // // TTLectSpecCampuses.SETRANGE(Semester,Rec.Semester);
        // // // // // // // TTLectSpecCampuses.SETRANGE("Lecturer Code",TTLecturers."Lecturer Code");
        // // // // // // // TTLectSpecCampuses.SETFILTER("Campus Code",'<>%1','');
        // // // // // // // TTLectSpecCampuses.SETFILTER("Constraint Category",'=%1',TTLectSpecCampuses."Constraint Category"::Mandatory);
        // // // // // // // IF TTLectSpecCampuses.FIND('-') THEN BEGIN
        // // // // // // //  //There Exists Lect Specific Campus Where Category is Mandatory
        // // // // // // //    ToDeleteDoubles:=TRUE;
        // // // // // // //  REPEAT
        // // // // // // //    BEGIN
        // // // // // // //    //Keep filtering where Campus code is Not the one selected...
        // // // // // // //    TTTimetableCollectorDoubles.SETFILTER("Campus Code",'<>%1',TTLectSpecCampuses."Campus Code");
        // // // // // // //    END;
        // // // // // // //    UNTIL TTLectSpecCampuses.NEXT=0;
        // // // // // // //    // After Repeated Filtering, Delete All Entries in the Filters
        // // // // // // //    IF ToDeleteDoubles THEN TTTimetableCollectorDoubles.DELETE;
        // // // // // // //  END;
        // // // // // // // END;
        // // // // // // // UNTIL TTLecturers.NEXT=0;
        // // // // // // // END;
        // // // // // // // //////////////////////////////////////////////////////////////Lect Spec. Campus on Doubles
        // // // // // // // //////////////////////////////////////////////////////////////Lect Spec. Campus on Tripples
        // // // // // // // TTLecturers.RESET;
        // // // // // // // TTLecturers.SETRANGE(Semester,Rec.Semester);
        // // // // // // // IF TTLecturers.FIND('-') THEN BEGIN
        // // // // // // //  REPEAT
        // // // // // // //    BEGIN
        // // // // // // // TTLectSpecCampuses.RESET;
        // // // // // // // TTLectSpecCampuses.SETRANGE(Semester,Rec.Semester);
        // // // // // // // TTLectSpecCampuses.SETRANGE("Lecturer Code",TTLecturers."Lecturer Code");
        // // // // // // // TTLectSpecCampuses.SETFILTER("Campus Code",'<>%1','');
        // // // // // // // IF TTLectSpecCampuses.FIND('-') THEN BEGIN
        // // // // // // //  //There Exists Lect Specific Campus
        // // // // // // //  REPEAT
        // // // // // // //    BEGIN
        // // // // // // //    IF TTLectSpecCampuses."Constraint Category"=TTLectSpecCampuses."Constraint Category"::Avoid THEN BEGIN
        // // // // // // //      //Delete all entries for the Lect and Campus Specified
        // // // // // // //    TTTimetableCollectorTripple.RESET;
        // // // // // // //    TTTimetableCollectorTripple.SETRANGE(Lecturer,TTLecturers."Lecturer Code");
        // // // // // // //    TTTimetableCollectorTripple.SETFILTER("Campus Code",'%1',TTLectSpecCampuses."Campus Code");
        // // // // // // //    IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
        // // // // // // //      END;
        // // // // // // //    IF TTLectSpecCampuses."Constraint Category"=TTLectSpecCampuses."Constraint Category"::"Least Preferred" THEN BEGIN
        // // // // // // //      //For the Lecturer and Campus Specified, Set Priority as 10
        // // // // // // //    TTTimetableCollectorTripple.RESET;
        // // // // // // //    TTTimetableCollectorTripple.SETRANGE(Lecturer,TTLecturers."Lecturer Code");
        // // // // // // //    TTTimetableCollectorTripple.SETFILTER("Campus Code",'%1',TTLectSpecCampuses."Campus Code");
        // // // // // // //    IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
        // // // // // // //    REPEAT
        // // // // // // //    BEGIN
        // // // // // // //      TTTimetableCollectorTripple."Lecturer Campus Priority":=10;
        // // // // // // //      TTTimetableCollectorTripple.MODIFY;
        // // // // // // //    END;
        // // // // // // //    UNTIL TTTimetableCollectorTripple.NEXT=0;
        // // // // // // //    END;
        // // // // // // //      END;
        // // // // // // //
        // // // // // // //    IF TTLectSpecCampuses."Constraint Category"=TTLectSpecCampuses."Constraint Category"::Preferred THEN BEGIN
        // // // // // // //      //For the Lecturer nd Campus Specified, Set Priority as 1
        // // // // // // //    TTTimetableCollectorTripple.RESET;
        // // // // // // //    TTTimetableCollectorTripple.SETRANGE(Lecturer,TTLecturers."Lecturer Code");
        // // // // // // //    TTTimetableCollectorTripple.SETFILTER("Campus Code",'%1',TTLectSpecCampuses."Campus Code");
        // // // // // // //    IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
        // // // // // // //    REPEAT
        // // // // // // //    BEGIN
        // // // // // // //      TTTimetableCollectorTripple."Lecturer Campus Priority":=1;
        // // // // // // //      TTTimetableCollectorTripple.MODIFY;
        // // // // // // //    END;
        // // // // // // //    UNTIL TTTimetableCollectorTripple.NEXT=0;
        // // // // // // //    END;
        // // // // // // //      END;
        // // // // // // //
        // // // // // // //    IF TTLectSpecCampuses."Constraint Category"=TTLectSpecCampuses."Constraint Category"::Mandatory THEN BEGIN
        // // // // // // //      //For the Lecturer nd Campus Specified, Set Priority as 1
        // // // // // // //    TTTimetableCollectorTripple.RESET;
        // // // // // // //    TTTimetableCollectorTripple.SETRANGE(Lecturer,TTLecturers."Lecturer Code");
        // // // // // // //    TTTimetableCollectorTripple.SETFILTER("Campus Code",'%1',TTLectSpecCampuses."Campus Code");
        // // // // // // //    IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
        // // // // // // //    REPEAT
        // // // // // // //    BEGIN
        // // // // // // //      TTTimetableCollectorTripple."Lecturer Campus Priority":=1;
        // // // // // // //      TTTimetableCollectorTripple.MODIFY;
        // // // // // // //    END;
        // // // // // // //    UNTIL TTTimetableCollectorTripple.NEXT=0;
        // // // // // // //    END;
        // // // // // // //      END;
        // // // // // // //    END;
        // // // // // // //    UNTIL TTLectSpecCampuses.NEXT=0;
        // // // // // // //  END;
        // // // // // // //
        // // // // // // //
        // // // // // // //    TTTimetableCollectorTripple.RESET;
        // // // // // // //    TTTimetableCollectorTripple.SETRANGE(Lecturer,TTLecturers."Lecturer Code");
        // // // // // // //  CLEAR(ToDeleteTripples);
        // // // // // // //    //// If the Constraints are Nandatory
        // // // // // // //  TTLectSpecCampuses.RESET;
        // // // // // // // TTLectSpecCampuses.SETRANGE(Semester,Rec.Semester);
        // // // // // // // TTLectSpecCampuses.SETRANGE("Lecturer Code",TTLecturers."Lecturer Code");
        // // // // // // // TTLectSpecCampuses.SETFILTER("Campus Code",'<>%1','');
        // // // // // // // TTLectSpecCampuses.SETFILTER("Constraint Category",'=%1',TTLectSpecCampuses."Constraint Category"::Mandatory);
        // // // // // // // IF TTLectSpecCampuses.FIND('-') THEN BEGIN
        // // // // // // //  //There Exists Lecturer Specific Campus Where Category is Mandatory
        // // // // // // //    ToDeleteTripples:=TRUE;
        // // // // // // //  REPEAT
        // // // // // // //    BEGIN
        // // // // // // //    //Keep filtering where Campus code is Not the one selected...
        // // // // // // //    TTTimetableCollectorTripple.SETFILTER("Campus Code",'<>%1',TTLectSpecCampuses."Campus Code");
        // // // // // // //    END;
        // // // // // // //    UNTIL TTLectSpecCampuses.NEXT=0;
        // // // // // // //    // After Repeated Filtering, Delete All Entries in the Filters
        // // // // // // //    IF ToDeleteTripples THEN TTTimetableCollectorTripple.DELETE;
        // // // // // // //  END;
        // // // // // // // END;
        // // // // // // // UNTIL TTLecturers.NEXT=0;
        // // // // // // // END;
        // // // // // // // //////////////////////////////////////////////////////////////Lect Spec. Campus on Tripples
    end;

    local procedure SpecificConstraintsUnitCampuses()
    var
        TTProgSpecCampuses: Record 74558;
        TTProgSpecDays: Record 74559;
        TTLectSpecCampuses: Record 74560;
        TTLectSpecDays: Record 74561;
        TTLectSpecLessons: Record 74562;
        TTUnitSpecCampuses: Record 74564;
        TTUnitSpecRooms: Record 74565;
        TTTimetableCollectorSingles: Record 74557;
        TTProgrammes: Record 74553;
        TTUnits: Record 74554;
        TTLecturers: Record 74555;
        ToDeleteSingles: Boolean;
        ToDeleteDoubles: Boolean;
        ToDeleteTripples: Boolean;
    begin
        //////////////////////////////////////////////////////////////Lect Spec. Campus on Singles
        TTUnits.RESET;
        TTUnits.SETRANGE(Semester, Rec.Semester);
        IF TTUnits.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                TTUnitSpecCampuses.RESET;
                TTUnitSpecCampuses.SETRANGE(Semester, Rec.Semester);
                TTUnitSpecCampuses.SETRANGE("Unit Code", TTUnits."Unit Code");
                TTUnitSpecCampuses.SETFILTER("Campus Code", '<>%1', '');
                IF TTUnitSpecCampuses.FIND('-') THEN BEGIN
                    //There Exists Lect Specific Campus
                    REPEAT
                    BEGIN
                        IF TTUnitSpecCampuses."Constraint Category" = TTUnitSpecCampuses."Constraint Category"::Avoid THEN BEGIN
                            //Delete all entries for the Unit and Campus Specified
                            TTTimetableCollectorSingles.RESET;
                            TTTimetableCollectorSingles.SETRANGE(Unit, TTUnits."Unit Code");
                            TTTimetableCollectorSingles.SETFILTER("Campus Code", '%1', TTUnitSpecCampuses."Campus Code");
                            IF TTTimetableCollectorSingles.FIND('-') THEN TTTimetableCollectorSingles.DELETEALL;
                        END;
                        IF TTUnitSpecCampuses."Constraint Category" = TTUnitSpecCampuses."Constraint Category"::"Least Preferred" THEN BEGIN
                            //For the Lect and Campus Specified, Set Priority as 10
                            TTTimetableCollectorSingles.RESET;
                            TTTimetableCollectorSingles.SETRANGE(Unit, TTUnits."Unit Code");
                            TTTimetableCollectorSingles.SETFILTER("Campus Code", '%1', TTUnitSpecCampuses."Campus Code");
                            IF TTTimetableCollectorSingles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorSingles."Unit Campus Priority" := 10;
                                    TTTimetableCollectorSingles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorSingles.NEXT = 0;
                            END;
                        END;

                        IF TTUnitSpecCampuses."Constraint Category" = TTUnitSpecCampuses."Constraint Category"::Preferred THEN BEGIN
                            //For the Lect and Campus Specified, Set Priority as 1
                            TTTimetableCollectorSingles.RESET;
                            TTTimetableCollectorSingles.SETRANGE(Unit, TTUnits."Unit Code");
                            TTTimetableCollectorSingles.SETFILTER("Campus Code", '%1', TTUnitSpecCampuses."Campus Code");
                            IF TTTimetableCollectorSingles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorSingles."Unit Campus Priority" := 1;
                                    TTTimetableCollectorSingles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorSingles.NEXT = 0;
                            END;
                        END;

                        IF TTUnitSpecCampuses."Constraint Category" = TTUnitSpecCampuses."Constraint Category"::Mandatory THEN BEGIN
                            //For the Lect and Campus Specified, Set Priority as 1
                            TTTimetableCollectorSingles.RESET;
                            TTTimetableCollectorSingles.SETRANGE(Unit, TTUnits."Unit Code");
                            TTTimetableCollectorSingles.SETFILTER("Campus Code", '%1', TTUnitSpecCampuses."Campus Code");
                            IF TTTimetableCollectorSingles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorSingles."Unit Campus Priority" := 1;
                                    TTTimetableCollectorSingles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorSingles.NEXT = 0;
                            END;
                        END;
                    END;
                    UNTIL TTUnitSpecCampuses.NEXT = 0;
                END;


                TTTimetableCollectorSingles.RESET;
                TTTimetableCollectorSingles.SETRANGE(Unit, TTUnits."Unit Code");
                CLEAR(ToDeleteSingles);
                //// If the Constraints are Nandatory
                TTUnitSpecCampuses.RESET;
                TTUnitSpecCampuses.SETRANGE(Semester, Rec.Semester);
                TTUnitSpecCampuses.SETRANGE("Unit Code", TTUnits."Unit Code");
                TTUnitSpecCampuses.SETFILTER("Campus Code", '<>%1', '');
                TTUnitSpecCampuses.SETFILTER("Constraint Category", '=%1', TTUnitSpecCampuses."Constraint Category"::Mandatory);
                IF TTUnitSpecCampuses.FIND('-') THEN BEGIN
                    //There Exists Lect Specific Campus Where Category is Mandatory
                    ToDeleteSingles := TRUE;
                    REPEAT
                    BEGIN
                        //Keep filtering where Campus code is Not the one selected...
                        TTTimetableCollectorSingles.SETFILTER(Unit, '<>%1', TTUnitSpecCampuses."Unit Code");
                    END;
                    UNTIL TTUnitSpecCampuses.NEXT = 0;
                    // After Repeated Filtering, Delete All Entries in the Filters
                    IF ToDeleteSingles THEN TTTimetableCollectorSingles.DELETE;
                END;
            END;
            UNTIL TTUnits.NEXT = 0;
        END;
        //////////////////////////////////////////////////////////////Lect Spec. Campus on Singles
        // // // // // // // // //////////////////////////////////////////////////////////////Lect Spec. Campus on Doubles
        // // // // // // // // TTUnits.RESET;
        // // // // // // // // TTUnits.SETRANGE(Semester,Rec.Semester);
        // // // // // // // // IF TTUnits.FIND('-') THEN BEGIN
        // // // // // // // //  REPEAT
        // // // // // // // //    BEGIN
        // // // // // // // // TTUnitSpecCampuses.RESET;
        // // // // // // // // TTUnitSpecCampuses.SETRANGE(Semester,Rec.Semester);
        // // // // // // // // TTUnitSpecCampuses.SETRANGE("Unit Code",TTUnits."Unit Code");
        // // // // // // // // TTUnitSpecCampuses.SETFILTER("Campus Code",'<>%1','');
        // // // // // // // // IF TTUnitSpecCampuses.FIND('-') THEN BEGIN
        // // // // // // // //  //There Exists Lect Specific Campus
        // // // // // // // //  REPEAT
        // // // // // // // //    BEGIN
        // // // // // // // //    IF TTUnitSpecCampuses."Constraint Category"=TTUnitSpecCampuses."Constraint Category"::Avoid THEN BEGIN
        // // // // // // // //      //Delete all entries for the Lect and Campus Specified
        // // // // // // // //    TTTimetableCollectorDoubles.RESET;
        // // // // // // // //    TTTimetableCollectorDoubles.SETRANGE(Unit,TTUnits."Unit Code");
        // // // // // // // //    TTTimetableCollectorDoubles.SETFILTER("Campus Code",'%1',TTUnitSpecCampuses."Campus Code");
        // // // // // // // //    IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
        // // // // // // // //      END;
        // // // // // // // //    IF TTUnitSpecCampuses."Constraint Category"=TTUnitSpecCampuses."Constraint Category"::"Least Preferred" THEN BEGIN
        // // // // // // // //      //For the Lect and Campus Specified, Set Priority as 10
        // // // // // // // //    TTTimetableCollectorDoubles.RESET;
        // // // // // // // //    TTTimetableCollectorDoubles.SETRANGE(Unit,TTUnits."Unit Code");
        // // // // // // // //    TTTimetableCollectorDoubles.SETFILTER("Campus Code",'%1',TTUnitSpecCampuses."Campus Code");
        // // // // // // // //    IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
        // // // // // // // //    REPEAT
        // // // // // // // //    BEGIN
        // // // // // // // //      TTTimetableCollectorDoubles."Unit Campus Priority":=10;
        // // // // // // // //      TTTimetableCollectorDoubles.MODIFY;
        // // // // // // // //    END;
        // // // // // // // //    UNTIL TTTimetableCollectorDoubles.NEXT=0;
        // // // // // // // //    END;
        // // // // // // // //      END;
        // // // // // // // //
        // // // // // // // //    IF TTUnitSpecCampuses."Constraint Category"=TTUnitSpecCampuses."Constraint Category"::Preferred THEN BEGIN
        // // // // // // // //      //For the Lect and Campus Specified, Set Priority as 1
        // // // // // // // //    TTTimetableCollectorDoubles.RESET;
        // // // // // // // //    TTTimetableCollectorDoubles.SETRANGE(Unit,TTUnits."Unit Code");
        // // // // // // // //    TTTimetableCollectorDoubles.SETFILTER("Campus Code",'%1',TTUnitSpecCampuses."Campus Code");
        // // // // // // // //    IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
        // // // // // // // //    REPEAT
        // // // // // // // //    BEGIN
        // // // // // // // //      TTTimetableCollectorDoubles."Unit Campus Priority":=1;
        // // // // // // // //      TTTimetableCollectorDoubles.MODIFY;
        // // // // // // // //    END;
        // // // // // // // //    UNTIL TTTimetableCollectorDoubles.NEXT=0;
        // // // // // // // //    END;
        // // // // // // // //      END;
        // // // // // // // //
        // // // // // // // //    IF TTUnitSpecCampuses."Constraint Category"=TTUnitSpecCampuses."Constraint Category"::Mandatory THEN BEGIN
        // // // // // // // //      //For the Lect and Campus Specified, Set Priority as 1
        // // // // // // // //    TTTimetableCollectorDoubles.RESET;
        // // // // // // // //    TTTimetableCollectorDoubles.SETRANGE(Unit,TTUnits."Unit Code");
        // // // // // // // //    TTTimetableCollectorDoubles.SETFILTER("Campus Code",'%1',TTUnitSpecCampuses."Campus Code");
        // // // // // // // //    IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
        // // // // // // // //    REPEAT
        // // // // // // // //    BEGIN
        // // // // // // // //      TTTimetableCollectorDoubles."Unit Campus Priority":=1;
        // // // // // // // //      TTTimetableCollectorDoubles.MODIFY;
        // // // // // // // //    END;
        // // // // // // // //    UNTIL TTTimetableCollectorDoubles.NEXT=0;
        // // // // // // // //    END;
        // // // // // // // //      END;
        // // // // // // // //    END;
        // // // // // // // //    UNTIL TTUnitSpecCampuses.NEXT=0;
        // // // // // // // //  END;
        // // // // // // // //
        // // // // // // // //
        // // // // // // // //    TTTimetableCollectorDoubles.RESET;
        // // // // // // // //    TTTimetableCollectorDoubles.SETRANGE(Unit,TTUnits."Unit Code");
        // // // // // // // //  CLEAR(ToDeleteDoubles);
        // // // // // // // //    //// If the Constraints are Nandatory
        // // // // // // // //  TTUnitSpecCampuses.RESET;
        // // // // // // // // TTUnitSpecCampuses.SETRANGE(Semester,Rec.Semester);
        // // // // // // // // TTUnitSpecCampuses.SETRANGE("Unit Code",TTUnits."Unit Code");
        // // // // // // // // TTUnitSpecCampuses.SETFILTER("Campus Code",'<>%1','');
        // // // // // // // // TTUnitSpecCampuses.SETFILTER("Constraint Category",'=%1',TTUnitSpecCampuses."Constraint Category"::Mandatory);
        // // // // // // // // IF TTUnitSpecCampuses.FIND('-') THEN BEGIN
        // // // // // // // //  //There Exists Lect Specific Campus Where Category is Mandatory
        // // // // // // // //    ToDeleteDoubles:=TRUE;
        // // // // // // // //  REPEAT
        // // // // // // // //    BEGIN
        // // // // // // // //    //Keep filtering where Campus code is Not the one selected...
        // // // // // // // //    TTTimetableCollectorDoubles.SETFILTER("Campus Code",'<>%1',TTUnitSpecCampuses."Campus Code");
        // // // // // // // //    END;
        // // // // // // // //    UNTIL TTUnitSpecCampuses.NEXT=0;
        // // // // // // // //    // After Repeated Filtering, Delete All Entries in the Filters
        // // // // // // // //    IF ToDeleteDoubles THEN TTTimetableCollectorDoubles.DELETE;
        // // // // // // // //  END;
        // // // // // // // // END;
        // // // // // // // // UNTIL TTUnits.NEXT=0;
        // // // // // // // // END;
        // // // // // // // // //////////////////////////////////////////////////////////////Lect Spec. Campus on Doubles
        // // // // // // // // //////////////////////////////////////////////////////////////Lect Spec. Campus on Tripples
        // // // // // // // // TTUnits.RESET;
        // // // // // // // // TTUnits.SETRANGE(Semester,Rec.Semester);
        // // // // // // // // IF TTUnits.FIND('-') THEN BEGIN
        // // // // // // // //  REPEAT
        // // // // // // // //    BEGIN
        // // // // // // // // TTUnitSpecCampuses.RESET;
        // // // // // // // // TTUnitSpecCampuses.SETRANGE(Semester,Rec.Semester);
        // // // // // // // // TTUnitSpecCampuses.SETRANGE("Unit Code",TTUnits."Unit Code");
        // // // // // // // // TTUnitSpecCampuses.SETFILTER("Campus Code",'<>%1','');
        // // // // // // // // IF TTUnitSpecCampuses.FIND('-') THEN BEGIN
        // // // // // // // //  //There Exists Lect Specific Campus
        // // // // // // // //  REPEAT
        // // // // // // // //    BEGIN
        // // // // // // // //    IF TTUnitSpecCampuses."Constraint Category"=TTUnitSpecCampuses."Constraint Category"::Avoid THEN BEGIN
        // // // // // // // //      //Delete all entries for the Lect and Campus Specified
        // // // // // // // //    TTTimetableCollectorTripple.RESET;
        // // // // // // // //    TTTimetableCollectorTripple.SETRANGE(Unit,TTUnits."Unit Code");
        // // // // // // // //    TTTimetableCollectorTripple.SETFILTER("Campus Code",'%1',TTUnitSpecCampuses."Campus Code");
        // // // // // // // //    IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
        // // // // // // // //      END;
        // // // // // // // //    IF TTUnitSpecCampuses."Constraint Category"=TTUnitSpecCampuses."Constraint Category"::"Least Preferred" THEN BEGIN
        // // // // // // // //      //For the Unit and Campus Specified, Set Priority as 10
        // // // // // // // //    TTTimetableCollectorTripple.RESET;
        // // // // // // // //    TTTimetableCollectorTripple.SETRANGE(Unit,TTUnits."Unit Code");
        // // // // // // // //    TTTimetableCollectorTripple.SETFILTER("Campus Code",'%1',TTUnitSpecCampuses."Campus Code");
        // // // // // // // //    IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
        // // // // // // // //    REPEAT
        // // // // // // // //    BEGIN
        // // // // // // // //      TTTimetableCollectorTripple."Unit Campus Priority":=10;
        // // // // // // // //      TTTimetableCollectorTripple.MODIFY;
        // // // // // // // //    END;
        // // // // // // // //    UNTIL TTTimetableCollectorTripple.NEXT=0;
        // // // // // // // //    END;
        // // // // // // // //      END;
        // // // // // // // //
        // // // // // // // //    IF TTUnitSpecCampuses."Constraint Category"=TTUnitSpecCampuses."Constraint Category"::Preferred THEN BEGIN
        // // // // // // // //      //For the Unit nd Campus Specified, Set Priority as 1
        // // // // // // // //    TTTimetableCollectorTripple.RESET;
        // // // // // // // //    TTTimetableCollectorTripple.SETRANGE(Unit,TTUnits."Unit Code");
        // // // // // // // //    TTTimetableCollectorTripple.SETFILTER("Campus Code",'%1',TTUnitSpecCampuses."Campus Code");
        // // // // // // // //    IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
        // // // // // // // //    REPEAT
        // // // // // // // //    BEGIN
        // // // // // // // //      TTTimetableCollectorTripple."Unit Campus Priority":=1;
        // // // // // // // //      TTTimetableCollectorTripple.MODIFY;
        // // // // // // // //    END;
        // // // // // // // //    UNTIL TTTimetableCollectorTripple.NEXT=0;
        // // // // // // // //    END;
        // // // // // // // //      END;
        // // // // // // // //
        // // // // // // // //    IF TTUnitSpecCampuses."Constraint Category"=TTUnitSpecCampuses."Constraint Category"::Mandatory THEN BEGIN
        // // // // // // // //      //For the Unit nd Campus Specified, Set Priority as 1
        // // // // // // // //    TTTimetableCollectorTripple.RESET;
        // // // // // // // //    TTTimetableCollectorTripple.SETRANGE(Unit,TTUnits."Unit Code");
        // // // // // // // //    TTTimetableCollectorTripple.SETFILTER("Campus Code",'%1',TTUnitSpecCampuses."Campus Code");
        // // // // // // // //    IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
        // // // // // // // //    REPEAT
        // // // // // // // //    BEGIN
        // // // // // // // //      TTTimetableCollectorTripple."Unit Campus Priority":=1;
        // // // // // // // //      TTTimetableCollectorTripple.MODIFY;
        // // // // // // // //    END;
        // // // // // // // //    UNTIL TTTimetableCollectorTripple.NEXT=0;
        // // // // // // // //    END;
        // // // // // // // //      END;
        // // // // // // // //    END;
        // // // // // // // //    UNTIL TTUnitSpecCampuses.NEXT=0;
        // // // // // // // //  END;
        // // // // // // // //
        // // // // // // // //
        // // // // // // // //    TTTimetableCollectorTripple.RESET;
        // // // // // // // //    TTTimetableCollectorTripple.SETRANGE(Unit,TTUnits."Unit Code");
        // // // // // // // //  CLEAR(ToDeleteTripples);
        // // // // // // // //    //// If the Constraints are Nandatory
        // // // // // // // //  TTUnitSpecCampuses.RESET;
        // // // // // // // // TTUnitSpecCampuses.SETRANGE(Semester,Rec.Semester);
        // // // // // // // // TTUnitSpecCampuses.SETRANGE("Unit Code",TTUnits."Unit Code");
        // // // // // // // // TTUnitSpecCampuses.SETFILTER("Campus Code",'<>%1','');
        // // // // // // // // TTUnitSpecCampuses.SETFILTER("Constraint Category",'=%1',TTUnitSpecCampuses."Constraint Category"::Mandatory);
        // // // // // // // // IF TTUnitSpecCampuses.FIND('-') THEN BEGIN
        // // // // // // // //  //There Exists Unit Specific Campus Where Category is Mandatory
        // // // // // // // //    ToDeleteTripples:=TRUE;
        // // // // // // // //  REPEAT
        // // // // // // // //    BEGIN
        // // // // // // // //    //Keep filtering where Campus code is Not the one selected...
        // // // // // // // //    TTTimetableCollectorTripple.SETFILTER("Campus Code",'<>%1',TTUnitSpecCampuses."Campus Code");
        // // // // // // // //    END;
        // // // // // // // //    UNTIL TTUnitSpecCampuses.NEXT=0;
        // // // // // // // //    // After Repeated Filtering, Delete All Entries in the Filters
        // // // // // // // //    IF ToDeleteTripples THEN TTTimetableCollectorTripple.DELETE;
        // // // // // // // //  END;
        // // // // // // // // END;
        // // // // // // // // UNTIL TTUnits.NEXT=0;
        // // // // // // // // END;
        // // // // // // // // //////////////////////////////////////////////////////////////Lect Spec. Campus on Tripples
    end;

    local procedure SpecificConstraintsUnitRooms()
    var
        TTProgSpecCampuses: Record 74558;
        TTProgSpecDays: Record 74559;
        TTLectSpecCampuses: Record 74560;
        TTLectSpecDays: Record 74561;
        TTLectSpecLessons: Record 74562;
        TTUnitSpecCampuses: Record 74564;
        TTUnitSpecRooms: Record 74565;
        TTTimetableCollectorSingles: Record 74557;
        TTProgrammes: Record 74553;
        TTUnits: Record 74554;
        TTLecturers: Record 74555;
        ToDeleteSingles: Boolean;
        ToDeleteDoubles: Boolean;
        ToDeleteTripples: Boolean;
    begin
        //////////////////////////////////////////////////////////////Lect Spec. Campus on Singles
        TTUnits.RESET;
        TTUnits.SETRANGE(Semester, Rec.Semester);
        IF TTUnits.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                TTUnitSpecRooms.RESET;
                TTUnitSpecRooms.SETRANGE(Semester, Rec.Semester);
                TTUnitSpecRooms.SETRANGE("Unit Code", TTUnits."Unit Code");
                TTUnitSpecRooms.SETFILTER("Room Code", '<>%1', '');
                IF TTUnitSpecRooms.FIND('-') THEN BEGIN
                    //There Exists Lect Specific Campus
                    REPEAT
                    BEGIN
                        IF TTUnitSpecRooms."Constraint Category" = TTUnitSpecRooms."Constraint Category"::Avoid THEN BEGIN
                            //Delete all entries for the Unit and Campus Specified
                            TTTimetableCollectorSingles.RESET;
                            TTTimetableCollectorSingles.SETRANGE(Unit, TTUnits."Unit Code");
                            TTTimetableCollectorSingles.SETFILTER("Room Code", '%1', TTUnitSpecRooms."Room Code");
                            IF TTTimetableCollectorSingles.FIND('-') THEN TTTimetableCollectorSingles.DELETEALL;
                        END;
                        IF TTUnitSpecRooms."Constraint Category" = TTUnitSpecRooms."Constraint Category"::"Least Preferred" THEN BEGIN
                            //For the Lect and Campus Specified, Set Priority as 10
                            TTTimetableCollectorSingles.RESET;
                            TTTimetableCollectorSingles.SETRANGE(Unit, TTUnits."Unit Code");
                            TTTimetableCollectorSingles.SETFILTER("Room Code", '%1', TTUnitSpecRooms."Room Code");
                            IF TTTimetableCollectorSingles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorSingles."Unit Room Priority" := 10;
                                    TTTimetableCollectorSingles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorSingles.NEXT = 0;
                            END;
                        END;

                        IF TTUnitSpecRooms."Constraint Category" = TTUnitSpecRooms."Constraint Category"::Preferred THEN BEGIN
                            //For the Lect and Campus Specified, Set Priority as 1
                            TTTimetableCollectorSingles.RESET;
                            TTTimetableCollectorSingles.SETRANGE(Unit, TTUnits."Unit Code");
                            TTTimetableCollectorSingles.SETFILTER("Room Code", '%1', TTUnitSpecRooms."Room Code");
                            IF TTTimetableCollectorSingles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorSingles."Unit Room Priority" := 1;
                                    TTTimetableCollectorSingles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorSingles.NEXT = 0;
                            END;
                        END;

                        IF TTUnitSpecRooms."Constraint Category" = TTUnitSpecRooms."Constraint Category"::Mandatory THEN BEGIN
                            //For the Lect and Campus Specified, Set Priority as 1
                            TTTimetableCollectorSingles.RESET;
                            TTTimetableCollectorSingles.SETRANGE(Unit, TTUnits."Unit Code");
                            TTTimetableCollectorSingles.SETFILTER("Room Code", '%1', TTUnitSpecRooms."Room Code");
                            IF TTTimetableCollectorSingles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorSingles."Unit Room Priority" := 1;
                                    TTTimetableCollectorSingles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorSingles.NEXT = 0;
                            END;
                        END;
                    END;
                    UNTIL TTUnitSpecRooms.NEXT = 0;
                END;


                TTTimetableCollectorSingles.RESET;
                TTTimetableCollectorSingles.SETRANGE(Unit, TTUnits."Unit Code");
                CLEAR(ToDeleteSingles);
                //// If the Constraints are Nandatory
                TTUnitSpecRooms.RESET;
                TTUnitSpecRooms.SETRANGE(Semester, Rec.Semester);
                TTUnitSpecRooms.SETRANGE("Unit Code", TTUnits."Unit Code");
                TTUnitSpecRooms.SETFILTER("Room Code", '<>%1', '');
                TTUnitSpecRooms.SETFILTER("Constraint Category", '=%1', TTUnitSpecRooms."Constraint Category"::Mandatory);
                IF TTUnitSpecRooms.FIND('-') THEN BEGIN
                    //There Exists Lect Specific Campus Where Category is Mandatory
                    ToDeleteSingles := TRUE;
                    REPEAT
                    BEGIN
                        //Keep filtering where Campus code is Not the one selected...
                        TTTimetableCollectorSingles.SETFILTER(Unit, '<>%1', TTUnitSpecRooms."Unit Code");
                    END;
                    UNTIL TTUnitSpecRooms.NEXT = 0;
                    // After Repeated Filtering, Delete All Entries in the Filters
                    IF ToDeleteSingles THEN TTTimetableCollectorSingles.DELETE;
                END;
            END;
            UNTIL TTUnits.NEXT = 0;
        END;
        //////////////////////////////////////////////////////////////Lect Spec. Campus on Singles
        // // // // // // // //////////////////////////////////////////////////////////////Lect Spec. Campus on Doubles
        // // // // // // // TTUnits.RESET;
        // // // // // // // TTUnits.SETRANGE(Semester,Rec.Semester);
        // // // // // // // IF TTUnits.FIND('-') THEN BEGIN
        // // // // // // //  REPEAT
        // // // // // // //    BEGIN
        // // // // // // // TTUnitSpecRooms.RESET;
        // // // // // // // TTUnitSpecRooms.SETRANGE(Semester,Rec.Semester);
        // // // // // // // TTUnitSpecRooms.SETRANGE("Unit Code",TTUnits."Unit Code");
        // // // // // // // TTUnitSpecRooms.SETFILTER("Room Code",'<>%1','');
        // // // // // // // IF TTUnitSpecRooms.FIND('-') THEN BEGIN
        // // // // // // //  //There Exists Lect Specific Campus
        // // // // // // //  REPEAT
        // // // // // // //    BEGIN
        // // // // // // //    IF TTUnitSpecRooms."Constraint Category"=TTUnitSpecRooms."Constraint Category"::Avoid THEN BEGIN
        // // // // // // //      //Delete all entries for the Lect and Campus Specified
        // // // // // // //    TTTimetableCollectorDoubles.RESET;
        // // // // // // //    TTTimetableCollectorDoubles.SETRANGE(Unit,TTUnits."Unit Code");
        // // // // // // //    TTTimetableCollectorDoubles.SETFILTER("Room Code",'%1',TTUnitSpecRooms."Room Code");
        // // // // // // //    IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
        // // // // // // //      END;
        // // // // // // //    IF TTUnitSpecRooms."Constraint Category"=TTUnitSpecRooms."Constraint Category"::"Least Preferred" THEN BEGIN
        // // // // // // //      //For the Lect and Campus Specified, Set Priority as 10
        // // // // // // //    TTTimetableCollectorDoubles.RESET;
        // // // // // // //    TTTimetableCollectorDoubles.SETRANGE(Unit,TTUnits."Unit Code");
        // // // // // // //    TTTimetableCollectorDoubles.SETFILTER("Room Code",'%1',TTUnitSpecRooms."Room Code");
        // // // // // // //    IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
        // // // // // // //    REPEAT
        // // // // // // //    BEGIN
        // // // // // // //      TTTimetableCollectorDoubles."Unit Room Priority":=10;
        // // // // // // //      TTTimetableCollectorDoubles.MODIFY;
        // // // // // // //    END;
        // // // // // // //    UNTIL TTTimetableCollectorDoubles.NEXT=0;
        // // // // // // //    END;
        // // // // // // //      END;
        // // // // // // //
        // // // // // // //    IF TTUnitSpecRooms."Constraint Category"=TTUnitSpecRooms."Constraint Category"::Preferred THEN BEGIN
        // // // // // // //      //For the Lect and Campus Specified, Set Priority as 1
        // // // // // // //    TTTimetableCollectorDoubles.RESET;
        // // // // // // //    TTTimetableCollectorDoubles.SETRANGE(Unit,TTUnits."Unit Code");
        // // // // // // //    TTTimetableCollectorDoubles.SETFILTER("Room Code",'%1',TTUnitSpecRooms."Room Code");
        // // // // // // //    IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
        // // // // // // //    REPEAT
        // // // // // // //    BEGIN
        // // // // // // //      TTTimetableCollectorDoubles."Unit Room Priority":=1;
        // // // // // // //      TTTimetableCollectorDoubles.MODIFY;
        // // // // // // //    END;
        // // // // // // //    UNTIL TTTimetableCollectorDoubles.NEXT=0;
        // // // // // // //    END;
        // // // // // // //      END;
        // // // // // // //
        // // // // // // //    IF TTUnitSpecRooms."Constraint Category"=TTUnitSpecRooms."Constraint Category"::Mandatory THEN BEGIN
        // // // // // // //      //For the Lect and Campus Specified, Set Priority as 1
        // // // // // // //    TTTimetableCollectorDoubles.RESET;
        // // // // // // //    TTTimetableCollectorDoubles.SETRANGE(Unit,TTUnits."Unit Code");
        // // // // // // //    TTTimetableCollectorDoubles.SETFILTER("Room Code",'%1',TTUnitSpecRooms."Room Code");
        // // // // // // //    IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
        // // // // // // //    REPEAT
        // // // // // // //    BEGIN
        // // // // // // //      TTTimetableCollectorDoubles."Unit Room Priority":=1;
        // // // // // // //      TTTimetableCollectorDoubles.MODIFY;
        // // // // // // //    END;
        // // // // // // //    UNTIL TTTimetableCollectorDoubles.NEXT=0;
        // // // // // // //    END;
        // // // // // // //      END;
        // // // // // // //    END;
        // // // // // // //    UNTIL TTUnitSpecRooms.NEXT=0;
        // // // // // // //  END;
        // // // // // // //
        // // // // // // //
        // // // // // // //    TTTimetableCollectorDoubles.RESET;
        // // // // // // //    TTTimetableCollectorDoubles.SETRANGE(Unit,TTUnits."Unit Code");
        // // // // // // //  CLEAR(ToDeleteDoubles);
        // // // // // // //    //// If the Constraints are Nandatory
        // // // // // // //  TTUnitSpecRooms.RESET;
        // // // // // // // TTUnitSpecRooms.SETRANGE(Semester,Rec.Semester);
        // // // // // // // TTUnitSpecRooms.SETRANGE("Unit Code",TTUnits."Unit Code");
        // // // // // // // TTUnitSpecRooms.SETFILTER("Room Code",'<>%1','');
        // // // // // // // TTUnitSpecRooms.SETFILTER("Constraint Category",'=%1',TTUnitSpecRooms."Constraint Category"::Mandatory);
        // // // // // // // IF TTUnitSpecRooms.FIND('-') THEN BEGIN
        // // // // // // //  //There Exists Lect Specific Campus Where Category is Mandatory
        // // // // // // //    ToDeleteDoubles:=TRUE;
        // // // // // // //  REPEAT
        // // // // // // //    BEGIN
        // // // // // // //    //Keep filtering where Campus code is Not the one selected...
        // // // // // // //    TTTimetableCollectorDoubles.SETFILTER("Room Code",'<>%1',TTUnitSpecRooms."Room Code");
        // // // // // // //    END;
        // // // // // // //    UNTIL TTUnitSpecRooms.NEXT=0;
        // // // // // // //    // After Repeated Filtering, Delete All Entries in the Filters
        // // // // // // //    IF ToDeleteDoubles THEN TTTimetableCollectorDoubles.DELETE;
        // // // // // // //  END;
        // // // // // // // END;
        // // // // // // // UNTIL TTUnits.NEXT=0;
        // // // // // // // END;
        // // // // // // // //////////////////////////////////////////////////////////////Lect Spec. Campus on Doubles
        // // // // // // // //////////////////////////////////////////////////////////////Lect Spec. Campus on Tripples
        // // // // // // // TTUnits.RESET;
        // // // // // // // TTUnits.SETRANGE(Semester,Rec.Semester);
        // // // // // // // IF TTUnits.FIND('-') THEN BEGIN
        // // // // // // //  REPEAT
        // // // // // // //    BEGIN
        // // // // // // // TTUnitSpecRooms.RESET;
        // // // // // // // TTUnitSpecRooms.SETRANGE(Semester,Rec.Semester);
        // // // // // // // TTUnitSpecRooms.SETRANGE("Unit Code",TTUnits."Unit Code");
        // // // // // // // TTUnitSpecRooms.SETFILTER("Room Code",'<>%1','');
        // // // // // // // IF TTUnitSpecRooms.FIND('-') THEN BEGIN
        // // // // // // //  //There Exists Lect Specific Campus
        // // // // // // //  REPEAT
        // // // // // // //    BEGIN
        // // // // // // //    IF TTUnitSpecRooms."Constraint Category"=TTUnitSpecRooms."Constraint Category"::Avoid THEN BEGIN
        // // // // // // //      //Delete all entries for the Lect and Campus Specified
        // // // // // // //    TTTimetableCollectorTripple.RESET;
        // // // // // // //    TTTimetableCollectorTripple.SETRANGE(Unit,TTUnits."Unit Code");
        // // // // // // //    TTTimetableCollectorTripple.SETFILTER("Room Code",'%1',TTUnitSpecRooms."Room Code");
        // // // // // // //    IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
        // // // // // // //      END;
        // // // // // // //    IF TTUnitSpecRooms."Constraint Category"=TTUnitSpecRooms."Constraint Category"::"Least Preferred" THEN BEGIN
        // // // // // // //      //For the Unit and Campus Specified, Set Priority as 10
        // // // // // // //    TTTimetableCollectorTripple.RESET;
        // // // // // // //    TTTimetableCollectorTripple.SETRANGE(Unit,TTUnits."Unit Code");
        // // // // // // //    TTTimetableCollectorTripple.SETFILTER("Room Code",'%1',TTUnitSpecRooms."Room Code");
        // // // // // // //    IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
        // // // // // // //    REPEAT
        // // // // // // //    BEGIN
        // // // // // // //      TTTimetableCollectorTripple."Unit Room Priority":=10;
        // // // // // // //      TTTimetableCollectorTripple.MODIFY;
        // // // // // // //    END;
        // // // // // // //    UNTIL TTTimetableCollectorTripple.NEXT=0;
        // // // // // // //    END;
        // // // // // // //      END;
        // // // // // // //
        // // // // // // //    IF TTUnitSpecRooms."Constraint Category"=TTUnitSpecRooms."Constraint Category"::Preferred THEN BEGIN
        // // // // // // //      //For the Unit nd Campus Specified, Set Priority as 1
        // // // // // // //    TTTimetableCollectorTripple.RESET;
        // // // // // // //    TTTimetableCollectorTripple.SETRANGE(Unit,TTUnits."Unit Code");
        // // // // // // //    TTTimetableCollectorTripple.SETFILTER("Room Code",'%1',TTUnitSpecRooms."Room Code");
        // // // // // // //    IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
        // // // // // // //    REPEAT
        // // // // // // //    BEGIN
        // // // // // // //      TTTimetableCollectorTripple."Unit Room Priority":=1;
        // // // // // // //      TTTimetableCollectorTripple.MODIFY;
        // // // // // // //    END;
        // // // // // // //    UNTIL TTTimetableCollectorTripple.NEXT=0;
        // // // // // // //    END;
        // // // // // // //      END;
        // // // // // // //
        // // // // // // //    IF TTUnitSpecRooms."Constraint Category"=TTUnitSpecRooms."Constraint Category"::Mandatory THEN BEGIN
        // // // // // // //      //For the Unit nd Campus Specified, Set Priority as 1
        // // // // // // //    TTTimetableCollectorTripple.RESET;
        // // // // // // //    TTTimetableCollectorTripple.SETRANGE(Unit,TTUnits."Unit Code");
        // // // // // // //    TTTimetableCollectorTripple.SETFILTER("Room Code",'%1',TTUnitSpecRooms."Room Code");
        // // // // // // //    IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
        // // // // // // //    REPEAT
        // // // // // // //    BEGIN
        // // // // // // //      TTTimetableCollectorTripple."Unit Room Priority":=1;
        // // // // // // //      TTTimetableCollectorTripple.MODIFY;
        // // // // // // //    END;
        // // // // // // //    UNTIL TTTimetableCollectorTripple.NEXT=0;
        // // // // // // //    END;
        // // // // // // //      END;
        // // // // // // //    END;
        // // // // // // //    UNTIL TTUnitSpecRooms.NEXT=0;
        // // // // // // //  END;
        // // // // // // //
        // // // // // // //
        // // // // // // //    TTTimetableCollectorTripple.RESET;
        // // // // // // //    TTTimetableCollectorTripple.SETRANGE(Unit,TTUnits."Unit Code");
        // // // // // // //  CLEAR(ToDeleteTripples);
        // // // // // // //    //// If the Constraints are Nandatory
        // // // // // // //  TTUnitSpecRooms.RESET;
        // // // // // // // TTUnitSpecRooms.SETRANGE(Semester,Rec.Semester);
        // // // // // // // TTUnitSpecRooms.SETRANGE("Unit Code",TTUnits."Unit Code");
        // // // // // // // TTUnitSpecRooms.SETFILTER("Room Code",'<>%1','');
        // // // // // // // TTUnitSpecRooms.SETFILTER("Constraint Category",'=%1',TTUnitSpecRooms."Constraint Category"::Mandatory);
        // // // // // // // IF TTUnitSpecRooms.FIND('-') THEN BEGIN
        // // // // // // //  //There Exists Unit Specific Campus Where Category is Mandatory
        // // // // // // //    ToDeleteTripples:=TRUE;
        // // // // // // //  REPEAT
        // // // // // // //    BEGIN
        // // // // // // //    //Keep filtering where Campus code is Not the one selected...
        // // // // // // //    TTTimetableCollectorTripple.SETFILTER("Room Code",'<>%1',TTUnitSpecRooms."Room Code");
        // // // // // // //    END;
        // // // // // // //    UNTIL TTUnitSpecRooms.NEXT=0;
        // // // // // // //    // After Repeated Filtering, Delete All Entries in the Filters
        // // // // // // //    IF ToDeleteTripples THEN TTTimetableCollectorTripple.DELETE;
        // // // // // // //  END;
        // // // // // // // END;
        // // // // // // // UNTIL TTUnits.NEXT=0;
        // // // // // // // END;
        // // // // // // // //////////////////////////////////////////////////////////////Lect Spec. Campus on Tripples
    end;

    local procedure SpecificConstraintsProgDays()
    var
        TTProgSpecCampuses: Record 74558;
        TTProgSpecDays: Record 74559;
        TTLectSpecCampuses: Record 74560;
        TTLectSpecDays: Record 74561;
        TTLectSpecLessons: Record 74562;
        TTUnitSpecCampuses: Record 74564;
        TTUnitSpecRooms: Record 74565;
        TTTimetableCollectorSingles: Record 74557;
        TTProgrammes: Record 74553;
        TTUnits: Record 74554;
        TTLecturers: Record 74555;
        ToDeleteSingles: Boolean;
        ToDeleteDoubles: Boolean;
        ToDeleteTripples: Boolean;
    begin
        //////////////////////////////////////////////////////////////Prog Spec. Days on Singles
        TTProgrammes.RESET;
        TTProgrammes.SETRANGE(Semester, Rec.Semester);
        IF TTProgrammes.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                TTProgSpecDays.RESET;
                TTProgSpecDays.SETRANGE(Semester, Rec.Semester);
                TTProgSpecDays.SETRANGE("Programme Code", TTProgrammes."Programme Code");
                TTProgSpecDays.SETFILTER("Date Code", '<>%1', 0D);
                IF TTProgSpecDays.FIND('-') THEN BEGIN
                    //There Exists Programme Specific Campus
                    REPEAT
                    BEGIN
                        IF TTProgSpecDays."Constraint Category" = TTProgSpecDays."Constraint Category"::Avoid THEN BEGIN
                            //Delete all entries for the Programme and Campus Specified
                            TTTimetableCollectorSingles.RESET;
                            TTTimetableCollectorSingles.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorSingles.SETFILTER("Date Code", '%1', TTProgSpecDays."Date Code");
                            IF TTTimetableCollectorSingles.FIND('-') THEN TTTimetableCollectorSingles.DELETEALL;
                        END;
                        IF TTProgSpecDays."Constraint Category" = TTProgSpecDays."Constraint Category"::"Least Preferred" THEN BEGIN
                            //For the Programme and Campus Specified, Set Priority as 10
                            TTTimetableCollectorSingles.RESET;
                            TTTimetableCollectorSingles.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorSingles.SETFILTER("Date Code", '%1', TTProgSpecDays."Date Code");
                            IF TTTimetableCollectorSingles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorSingles."Programme Day Priority" := 10;
                                    TTTimetableCollectorSingles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorSingles.NEXT = 0;
                            END;
                        END;

                        IF TTProgSpecDays."Constraint Category" = TTProgSpecDays."Constraint Category"::Preferred THEN BEGIN
                            //For the Programme and Campus Specified, Set Priority as 1
                            TTTimetableCollectorSingles.RESET;
                            TTTimetableCollectorSingles.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorSingles.SETFILTER("Date Code", '%1', TTProgSpecDays."Date Code");
                            IF TTTimetableCollectorSingles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorSingles."Programme Day Priority" := 1;
                                    TTTimetableCollectorSingles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorSingles.NEXT = 0;
                            END;
                        END;

                        IF TTProgSpecDays."Constraint Category" = TTProgSpecDays."Constraint Category"::Mandatory THEN BEGIN
                            //For the Programme and Campus Specified, Set Priority as 1
                            TTTimetableCollectorSingles.RESET;
                            TTTimetableCollectorSingles.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorSingles.SETFILTER("Date Code", '%1', TTProgSpecDays."Date Code");
                            IF TTTimetableCollectorSingles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorSingles."Programme Day Priority" := 1;
                                    TTTimetableCollectorSingles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorSingles.NEXT = 0;
                            END;
                        END;
                    END;
                    UNTIL TTProgSpecDays.NEXT = 0;
                END;


                TTTimetableCollectorSingles.RESET;
                TTTimetableCollectorSingles.SETRANGE(Programme, TTProgrammes."Programme Code");
                CLEAR(ToDeleteSingles);
                //// If the Constraints are Nandatory
                TTProgSpecDays.RESET;
                TTProgSpecDays.SETRANGE(Semester, Rec.Semester);
                TTProgSpecDays.SETRANGE("Programme Code", TTProgrammes."Programme Code");
                TTProgSpecDays.SETFILTER("Date Code", '<>%1', 0D);
                TTProgSpecDays.SETFILTER("Constraint Category", '=%1', TTProgSpecDays."Constraint Category"::Mandatory);
                IF TTProgSpecDays.FIND('-') THEN BEGIN
                    //There Exists Programme Specific Campus Where Category is Mandatory
                    ToDeleteSingles := TRUE;
                    REPEAT
                    BEGIN
                        //Keep filtering where Campus code is Not the one selected...
                        TTTimetableCollectorSingles.SETFILTER("Date Code", '<>%1', TTProgSpecDays."Date Code");
                    END;
                    UNTIL TTProgSpecDays.NEXT = 0;
                    // After Repeated Filtering, Delete All Entries in the Filters
                    IF ToDeleteSingles THEN TTTimetableCollectorSingles.DELETE;
                END;
            END;
            UNTIL TTProgrammes.NEXT = 0;
        END;
        //////////////////////////////////////////////////////////////Prog Spec. Days on Singles
        // // // // // // // //////////////////////////////////////////////////////////////Prog Spec. Days on Doubles
        // // // // // // // TTProgrammes.RESET;
        // // // // // // // TTProgrammes.SETRANGE(Semester,Rec.Semester);
        // // // // // // // IF TTProgrammes.FIND('-') THEN BEGIN
        // // // // // // //  REPEAT
        // // // // // // //    BEGIN
        // // // // // // // TTProgSpecDays.RESET;
        // // // // // // // TTProgSpecDays.SETRANGE(Semester,Rec.Semester);
        // // // // // // // TTProgSpecDays.SETRANGE("Programme Code",TTProgrammes."Programme Code");
        // // // // // // // TTProgSpecDays.SETFILTER("Date Code",'<>%1','');
        // // // // // // // IF TTProgSpecDays.FIND('-') THEN BEGIN
        // // // // // // //  //There Exists Programme Specific Campus
        // // // // // // //  REPEAT
        // // // // // // //    BEGIN
        // // // // // // //    IF TTProgSpecDays."Constraint Category"=TTProgSpecDays."Constraint Category"::Avoid THEN BEGIN
        // // // // // // //      //Delete all entries for the Programme and Campus Specified
        // // // // // // //    TTTimetableCollectorDoubles.RESET;
        // // // // // // //    TTTimetableCollectorDoubles.SETRANGE(Programme,TTProgrammes."Programme Code");
        // // // // // // //    TTTimetableCollectorDoubles.SETFILTER("Date Code",'%1',TTProgSpecDays."Date Code");
        // // // // // // //    IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
        // // // // // // //      END;
        // // // // // // //    IF TTProgSpecDays."Constraint Category"=TTProgSpecDays."Constraint Category"::"Least Preferred" THEN BEGIN
        // // // // // // //      //For the Programme and Campus Specified, Set Priority as 10
        // // // // // // //    TTTimetableCollectorDoubles.RESET;
        // // // // // // //    TTTimetableCollectorDoubles.SETRANGE(Programme,TTProgrammes."Programme Code");
        // // // // // // //    TTTimetableCollectorDoubles.SETFILTER("Date Code",'%1',TTProgSpecDays."Date Code");
        // // // // // // //    IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
        // // // // // // //    REPEAT
        // // // // // // //    BEGIN
        // // // // // // //      TTTimetableCollectorDoubles."Programme Day Priority":=10;
        // // // // // // //      TTTimetableCollectorDoubles.MODIFY;
        // // // // // // //    END;
        // // // // // // //    UNTIL TTTimetableCollectorDoubles.NEXT=0;
        // // // // // // //    END;
        // // // // // // //      END;
        // // // // // // //
        // // // // // // //    IF TTProgSpecDays."Constraint Category"=TTProgSpecDays."Constraint Category"::Preferred THEN BEGIN
        // // // // // // //      //For the Programme and Campus Specified, Set Priority as 1
        // // // // // // //    TTTimetableCollectorDoubles.RESET;
        // // // // // // //    TTTimetableCollectorDoubles.SETRANGE(Programme,TTProgrammes."Programme Code");
        // // // // // // //    TTTimetableCollectorDoubles.SETFILTER("Date Code",'%1',TTProgSpecDays."Date Code");
        // // // // // // //    IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
        // // // // // // //    REPEAT
        // // // // // // //    BEGIN
        // // // // // // //      TTTimetableCollectorDoubles."Programme Day Priority":=1;
        // // // // // // //      TTTimetableCollectorDoubles.MODIFY;
        // // // // // // //    END;
        // // // // // // //    UNTIL TTTimetableCollectorDoubles.NEXT=0;
        // // // // // // //    END;
        // // // // // // //      END;
        // // // // // // //
        // // // // // // //    IF TTProgSpecDays."Constraint Category"=TTProgSpecDays."Constraint Category"::Mandatory THEN BEGIN
        // // // // // // //      //For the Programme and Campus Specified, Set Priority as 1
        // // // // // // //    TTTimetableCollectorDoubles.RESET;
        // // // // // // //    TTTimetableCollectorDoubles.SETRANGE(Programme,TTProgrammes."Programme Code");
        // // // // // // //    TTTimetableCollectorDoubles.SETFILTER("Date Code",'%1',TTProgSpecDays."Date Code");
        // // // // // // //    IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
        // // // // // // //    REPEAT
        // // // // // // //    BEGIN
        // // // // // // //      TTTimetableCollectorDoubles."Programme Day Priority":=1;
        // // // // // // //      TTTimetableCollectorDoubles.MODIFY;
        // // // // // // //    END;
        // // // // // // //    UNTIL TTTimetableCollectorDoubles.NEXT=0;
        // // // // // // //    END;
        // // // // // // //      END;
        // // // // // // //    END;
        // // // // // // //    UNTIL TTProgSpecDays.NEXT=0;
        // // // // // // //  END;
        // // // // // // //
        // // // // // // //
        // // // // // // //    TTTimetableCollectorDoubles.RESET;
        // // // // // // //    TTTimetableCollectorDoubles.SETRANGE(Programme,TTProgrammes."Programme Code");
        // // // // // // //  CLEAR(ToDeleteDoubles);
        // // // // // // //    //// If the Constraints are Nandatory
        // // // // // // //  TTProgSpecDays.RESET;
        // // // // // // // TTProgSpecDays.SETRANGE(Semester,Rec.Semester);
        // // // // // // // TTProgSpecDays.SETRANGE("Programme Code",TTProgrammes."Programme Code");
        // // // // // // // TTProgSpecDays.SETFILTER("Date Code",'<>%1','');
        // // // // // // // TTProgSpecDays.SETFILTER("Constraint Category",'=%1',TTProgSpecDays."Constraint Category"::Mandatory);
        // // // // // // // IF TTProgSpecDays.FIND('-') THEN BEGIN
        // // // // // // //  //There Exists Programme Specific Campus Where Category is Mandatory
        // // // // // // //    ToDeleteDoubles:=TRUE;
        // // // // // // //  REPEAT
        // // // // // // //    BEGIN
        // // // // // // //    //Keep filtering where Campus code is Not the one selected...
        // // // // // // //    TTTimetableCollectorDoubles.SETFILTER("Date Code",'<>%1',TTProgSpecDays."Date Code");
        // // // // // // //    END;
        // // // // // // //    UNTIL TTProgSpecDays.NEXT=0;
        // // // // // // //    // After Repeated Filtering, Delete All Entries in the Filters
        // // // // // // //    IF ToDeleteDoubles THEN TTTimetableCollectorDoubles.DELETE;
        // // // // // // //  END;
        // // // // // // // END;
        // // // // // // // UNTIL TTProgrammes.NEXT=0;
        // // // // // // // END;
        // // // // // // // //////////////////////////////////////////////////////////////Prog Spec. Days on Doubles
        // // // // // // // //////////////////////////////////////////////////////////////Prog Spec. Days on Tripples
        // // // // // // // TTProgrammes.RESET;
        // // // // // // // TTProgrammes.SETRANGE(Semester,Rec.Semester);
        // // // // // // // IF TTProgrammes.FIND('-') THEN BEGIN
        // // // // // // //  REPEAT
        // // // // // // //    BEGIN
        // // // // // // // TTProgSpecDays.RESET;
        // // // // // // // TTProgSpecDays.SETRANGE(Semester,Rec.Semester);
        // // // // // // // TTProgSpecDays.SETRANGE("Programme Code",TTProgrammes."Programme Code");
        // // // // // // // TTProgSpecDays.SETFILTER("Date Code",'<>%1','');
        // // // // // // // IF TTProgSpecDays.FIND('-') THEN BEGIN
        // // // // // // //  //There Exists Programme Specific Campus
        // // // // // // //  REPEAT
        // // // // // // //    BEGIN
        // // // // // // //    IF TTProgSpecDays."Constraint Category"=TTProgSpecDays."Constraint Category"::Avoid THEN BEGIN
        // // // // // // //      //Delete all entries for the Programme and Campus Specified
        // // // // // // //    TTTimetableCollectorTripple.RESET;
        // // // // // // //    TTTimetableCollectorTripple.SETRANGE(Programme,TTProgrammes."Programme Code");
        // // // // // // //    TTTimetableCollectorTripple.SETFILTER("Date Code",'%1',TTProgSpecDays."Date Code");
        // // // // // // //    IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
        // // // // // // //      END;
        // // // // // // //    IF TTProgSpecDays."Constraint Category"=TTProgSpecDays."Constraint Category"::"Least Preferred" THEN BEGIN
        // // // // // // //      //For the Programme and Campus Specified, Set Priority as 10
        // // // // // // //    TTTimetableCollectorTripple.RESET;
        // // // // // // //    TTTimetableCollectorTripple.SETRANGE(Programme,TTProgrammes."Programme Code");
        // // // // // // //    TTTimetableCollectorTripple.SETFILTER("Date Code",'%1',TTProgSpecDays."Date Code");
        // // // // // // //    IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
        // // // // // // //    REPEAT
        // // // // // // //    BEGIN
        // // // // // // //      TTTimetableCollectorTripple."Programme Day Priority":=10;
        // // // // // // //      TTTimetableCollectorTripple.MODIFY;
        // // // // // // //    END;
        // // // // // // //    UNTIL TTTimetableCollectorTripple.NEXT=0;
        // // // // // // //    END;
        // // // // // // //      END;
        // // // // // // //
        // // // // // // //    IF TTProgSpecDays."Constraint Category"=TTProgSpecDays."Constraint Category"::Preferred THEN BEGIN
        // // // // // // //      //For the Programme and Campus Specified, Set Priority as 1
        // // // // // // //    TTTimetableCollectorTripple.RESET;
        // // // // // // //    TTTimetableCollectorTripple.SETRANGE(Programme,TTProgrammes."Programme Code");
        // // // // // // //    TTTimetableCollectorTripple.SETFILTER("Date Code",'%1',TTProgSpecDays."Date Code");
        // // // // // // //    IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
        // // // // // // //    REPEAT
        // // // // // // //    BEGIN
        // // // // // // //      TTTimetableCollectorTripple."Programme Day Priority":=1;
        // // // // // // //      TTTimetableCollectorTripple.MODIFY;
        // // // // // // //    END;
        // // // // // // //    UNTIL TTTimetableCollectorTripple.NEXT=0;
        // // // // // // //    END;
        // // // // // // //      END;
        // // // // // // //
        // // // // // // //    IF TTProgSpecDays."Constraint Category"=TTProgSpecDays."Constraint Category"::Mandatory THEN BEGIN
        // // // // // // //      //For the Programme and Campus Specified, Set Priority as 1
        // // // // // // //    TTTimetableCollectorTripple.RESET;
        // // // // // // //    TTTimetableCollectorTripple.SETRANGE(Programme,TTProgrammes."Programme Code");
        // // // // // // //    TTTimetableCollectorTripple.SETFILTER("Date Code",'%1',TTProgSpecDays."Date Code");
        // // // // // // //    IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
        // // // // // // //    REPEAT
        // // // // // // //    BEGIN
        // // // // // // //      TTTimetableCollectorTripple."Programme Day Priority":=1;
        // // // // // // //      TTTimetableCollectorTripple.MODIFY;
        // // // // // // //    END;
        // // // // // // //    UNTIL TTTimetableCollectorTripple.NEXT=0;
        // // // // // // //    END;
        // // // // // // //      END;
        // // // // // // //    END;
        // // // // // // //    UNTIL TTProgSpecDays.NEXT=0;
        // // // // // // //  END;
        // // // // // // //
        // // // // // // //
        // // // // // // //    TTTimetableCollectorTripple.RESET;
        // // // // // // //    TTTimetableCollectorTripple.SETRANGE(Programme,TTProgrammes."Programme Code");
        // // // // // // //  CLEAR(ToDeleteTripples);
        // // // // // // //    //// If the Constraints are Nandatory
        // // // // // // //  TTProgSpecDays.RESET;
        // // // // // // // TTProgSpecDays.SETRANGE(Semester,Rec.Semester);
        // // // // // // // TTProgSpecDays.SETRANGE("Programme Code",TTProgrammes."Programme Code");
        // // // // // // // TTProgSpecDays.SETFILTER("Date Code",'<>%1','');
        // // // // // // // TTProgSpecDays.SETFILTER("Constraint Category",'=%1',TTProgSpecDays."Constraint Category"::Mandatory);
        // // // // // // // IF TTProgSpecDays.FIND('-') THEN BEGIN
        // // // // // // //  //There Exists Programme Specific Campus Where Category is Mandatory
        // // // // // // //    ToDeleteTripples:=TRUE;
        // // // // // // //  REPEAT
        // // // // // // //    BEGIN
        // // // // // // //    //Keep filtering where Campus code is Not the one selected...
        // // // // // // //    TTTimetableCollectorTripple.SETFILTER("Date Code",'<>%1',TTProgSpecDays."Date Code");
        // // // // // // //    END;
        // // // // // // //    UNTIL TTProgSpecDays.NEXT=0;
        // // // // // // //    // After Repeated Filtering, Delete All Entries in the Filters
        // // // // // // //    IF ToDeleteTripples THEN TTTimetableCollectorTripple.DELETE;
        // // // // // // //  END;
        // // // // // // // END;
        // // // // // // // UNTIL TTProgrammes.NEXT=0;
        // // // // // // // END;
        // // // // // // // //////////////////////////////////////////////////////////////Prog Spec. Days on Tripples
    end;

    local procedure SpecificConstraintsLectDays()
    var
        TTProgSpecCampuses: Record 74558;
        TTProgSpecDays: Record 74559;
        TTLectSpecCampuses: Record 74560;
        TTLectSpecDays: Record 74561;
        TTLectSpecLessons: Record 74562;
        TTUnitSpecCampuses: Record 74564;
        TTUnitSpecRooms: Record 74565;
        TTTimetableCollectorSingles: Record 74557;
        TTProgrammes: Record 74553;
        TTUnits: Record 74554;
        TTLecturers: Record 74555;
        ToDeleteSingles: Boolean;
        ToDeleteDoubles: Boolean;
        ToDeleteTripples: Boolean;
    begin
        //////////////////////////////////////////////////////////////Lect Spec. Days on Singles
        TTLecturers.RESET;
        TTLecturers.SETRANGE(Semester, Rec.Semester);
        IF TTLecturers.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                TTLectSpecDays.RESET;
                TTLectSpecDays.SETRANGE(Semester, Rec.Semester);
                TTLectSpecDays.SETRANGE("Lecturer Code", TTLecturers."Lecturer Code");
                TTLectSpecDays.SETFILTER("Date Code", '<>%1', 0D);
                IF TTLectSpecDays.FIND('-') THEN BEGIN
                    //There Exists Lect Specific Campus
                    REPEAT
                    BEGIN
                        IF TTLectSpecDays."Constraint Category" = TTLectSpecDays."Constraint Category"::Avoid THEN BEGIN
                            //Delete all entries for the Lecturer and Campus Specified
                            TTTimetableCollectorSingles.RESET;
                            TTTimetableCollectorSingles.SETRANGE(Lecturer, TTLecturers."Lecturer Code");
                            TTTimetableCollectorSingles.SETFILTER("Date Code", '%1', TTLectSpecDays."Date Code");
                            IF TTTimetableCollectorSingles.FIND('-') THEN TTTimetableCollectorSingles.DELETEALL;
                        END;
                        IF TTLectSpecDays."Constraint Category" = TTLectSpecDays."Constraint Category"::"Least Preferred" THEN BEGIN
                            //For the Lect and Campus Specified, Set Priority as 10
                            TTTimetableCollectorSingles.RESET;
                            TTTimetableCollectorSingles.SETRANGE(Lecturer, TTLecturers."Lecturer Code");
                            TTTimetableCollectorSingles.SETFILTER("Date Code", '%1', TTLectSpecDays."Date Code");
                            IF TTTimetableCollectorSingles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorSingles."Lecturer Campus Priority" := 10;
                                    TTTimetableCollectorSingles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorSingles.NEXT = 0;
                            END;
                        END;

                        IF TTLectSpecDays."Constraint Category" = TTLectSpecDays."Constraint Category"::Preferred THEN BEGIN
                            //For the Lect and Campus Specified, Set Priority as 1
                            TTTimetableCollectorSingles.RESET;
                            TTTimetableCollectorSingles.SETRANGE(Lecturer, TTLecturers."Lecturer Code");
                            TTTimetableCollectorSingles.SETFILTER("Date Code", '%1', TTLectSpecDays."Date Code");
                            IF TTTimetableCollectorSingles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorSingles."Lecturer Campus Priority" := 1;
                                    TTTimetableCollectorSingles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorSingles.NEXT = 0;
                            END;
                        END;

                        IF TTLectSpecDays."Constraint Category" = TTLectSpecDays."Constraint Category"::Mandatory THEN BEGIN
                            //For the Lect and Campus Specified, Set Priority as 1
                            TTTimetableCollectorSingles.RESET;
                            TTTimetableCollectorSingles.SETRANGE(Lecturer, TTLecturers."Lecturer Code");
                            TTTimetableCollectorSingles.SETFILTER("Date Code", '%1', TTLectSpecDays."Date Code");
                            IF TTTimetableCollectorSingles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorSingles."Lecturer Campus Priority" := 1;
                                    TTTimetableCollectorSingles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorSingles.NEXT = 0;
                            END;
                        END;
                    END;
                    UNTIL TTLectSpecDays.NEXT = 0;
                END;


                TTTimetableCollectorSingles.RESET;
                TTTimetableCollectorSingles.SETRANGE(Lecturer, TTLecturers."Lecturer Code");
                CLEAR(ToDeleteSingles);
                //// If the Constraints are Nandatory
                TTLectSpecDays.RESET;
                TTLectSpecDays.SETRANGE(Semester, Rec.Semester);
                TTLectSpecDays.SETRANGE("Lecturer Code", TTLecturers."Lecturer Code");
                TTLectSpecDays.SETFILTER("Date Code", '<>%1', 0D);
                TTLectSpecDays.SETFILTER("Constraint Category", '=%1', TTLectSpecDays."Constraint Category"::Mandatory);
                IF TTLectSpecDays.FIND('-') THEN BEGIN
                    //There Exists Lect Specific Campus Where Category is Mandatory
                    ToDeleteSingles := TRUE;
                    REPEAT
                    BEGIN
                        //Keep filtering where Campus code is Not the one selected...
                        TTTimetableCollectorSingles.SETFILTER(Lecturer, '<>%1', TTLectSpecDays."Lecturer Code");
                    END;
                    UNTIL TTLectSpecDays.NEXT = 0;
                    // After Repeated Filtering, Delete All Entries in the Filters
                    IF ToDeleteSingles THEN TTTimetableCollectorSingles.DELETE;
                END;
            END;
            UNTIL TTLecturers.NEXT = 0;
        END;
        //////////////////////////////////////////////////////////////Lect Spec. Days on Singles
        // // // // // // // //////////////////////////////////////////////////////////////Lect Spec. Days on Doubles
        // // // // // // // TTLecturers.RESET;
        // // // // // // // TTLecturers.SETRANGE(Semester,Rec.Semester);
        // // // // // // // IF TTLecturers.FIND('-') THEN BEGIN
        // // // // // // //  REPEAT
        // // // // // // //    BEGIN
        // // // // // // // TTLectSpecDays.RESET;
        // // // // // // // TTLectSpecDays.SETRANGE(Semester,Rec.Semester);
        // // // // // // // TTLectSpecDays.SETRANGE("Lecturer Code",TTLecturers."Lecturer Code");
        // // // // // // // TTLectSpecDays.SETFILTER("Date Code",'<>%1','');
        // // // // // // // IF TTLectSpecDays.FIND('-') THEN BEGIN
        // // // // // // //  //There Exists Lect Specific Campus
        // // // // // // //  REPEAT
        // // // // // // //    BEGIN
        // // // // // // //    IF TTLectSpecDays."Constraint Category"=TTLectSpecDays."Constraint Category"::Avoid THEN BEGIN
        // // // // // // //      //Delete all entries for the Lect and Campus Specified
        // // // // // // //    TTTimetableCollectorDoubles.RESET;
        // // // // // // //    TTTimetableCollectorDoubles.SETRANGE(Lecturer,TTLecturers."Lecturer Code");
        // // // // // // //    TTTimetableCollectorDoubles.SETFILTER("Date Code",'%1',TTLectSpecDays."Date Code");
        // // // // // // //    IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
        // // // // // // //      END;
        // // // // // // //    IF TTLectSpecDays."Constraint Category"=TTLectSpecDays."Constraint Category"::"Least Preferred" THEN BEGIN
        // // // // // // //      //For the Lect and Campus Specified, Set Priority as 10
        // // // // // // //    TTTimetableCollectorDoubles.RESET;
        // // // // // // //    TTTimetableCollectorDoubles.SETRANGE(Lecturer,TTLecturers."Lecturer Code");
        // // // // // // //    TTTimetableCollectorDoubles.SETFILTER("Date Code",'%1',TTLectSpecDays."Date Code");
        // // // // // // //    IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
        // // // // // // //    REPEAT
        // // // // // // //    BEGIN
        // // // // // // //      TTTimetableCollectorDoubles."Lecturer Campus Priority":=10;
        // // // // // // //      TTTimetableCollectorDoubles.MODIFY;
        // // // // // // //    END;
        // // // // // // //    UNTIL TTTimetableCollectorDoubles.NEXT=0;
        // // // // // // //    END;
        // // // // // // //      END;
        // // // // // // //
        // // // // // // //    IF TTLectSpecDays."Constraint Category"=TTLectSpecDays."Constraint Category"::Preferred THEN BEGIN
        // // // // // // //      //For the Lect and Campus Specified, Set Priority as 1
        // // // // // // //    TTTimetableCollectorDoubles.RESET;
        // // // // // // //    TTTimetableCollectorDoubles.SETRANGE(Lecturer,TTLecturers."Lecturer Code");
        // // // // // // //    TTTimetableCollectorDoubles.SETFILTER("Date Code",'%1',TTLectSpecDays."Date Code");
        // // // // // // //    IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
        // // // // // // //    REPEAT
        // // // // // // //    BEGIN
        // // // // // // //      TTTimetableCollectorDoubles."Lecturer Campus Priority":=1;
        // // // // // // //      TTTimetableCollectorDoubles.MODIFY;
        // // // // // // //    END;
        // // // // // // //    UNTIL TTTimetableCollectorDoubles.NEXT=0;
        // // // // // // //    END;
        // // // // // // //      END;
        // // // // // // //
        // // // // // // //    IF TTLectSpecDays."Constraint Category"=TTLectSpecDays."Constraint Category"::Mandatory THEN BEGIN
        // // // // // // //      //For the Lect and Campus Specified, Set Priority as 1
        // // // // // // //    TTTimetableCollectorDoubles.RESET;
        // // // // // // //    TTTimetableCollectorDoubles.SETRANGE(Lecturer,TTLecturers."Lecturer Code");
        // // // // // // //    TTTimetableCollectorDoubles.SETFILTER("Date Code",'%1',TTLectSpecDays."Date Code");
        // // // // // // //    IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
        // // // // // // //    REPEAT
        // // // // // // //    BEGIN
        // // // // // // //      TTTimetableCollectorDoubles."Lecturer Campus Priority":=1;
        // // // // // // //      TTTimetableCollectorDoubles.MODIFY;
        // // // // // // //    END;
        // // // // // // //    UNTIL TTTimetableCollectorDoubles.NEXT=0;
        // // // // // // //    END;
        // // // // // // //      END;
        // // // // // // //    END;
        // // // // // // //    UNTIL TTLectSpecDays.NEXT=0;
        // // // // // // //  END;
        // // // // // // //
        // // // // // // //
        // // // // // // //    TTTimetableCollectorDoubles.RESET;
        // // // // // // //    TTTimetableCollectorDoubles.SETRANGE(Lecturer,TTLecturers."Lecturer Code");
        // // // // // // //  CLEAR(ToDeleteDoubles);
        // // // // // // //    //// If the Constraints are Nandatory
        // // // // // // //  TTLectSpecDays.RESET;
        // // // // // // // TTLectSpecDays.SETRANGE(Semester,Rec.Semester);
        // // // // // // // TTLectSpecDays.SETRANGE("Lecturer Code",TTLecturers."Lecturer Code");
        // // // // // // // TTLectSpecDays.SETFILTER("Date Code",'<>%1','');
        // // // // // // // TTLectSpecDays.SETFILTER("Constraint Category",'=%1',TTLectSpecDays."Constraint Category"::Mandatory);
        // // // // // // // IF TTLectSpecDays.FIND('-') THEN BEGIN
        // // // // // // //  //There Exists Lect Specific Campus Where Category is Mandatory
        // // // // // // //    ToDeleteDoubles:=TRUE;
        // // // // // // //  REPEAT
        // // // // // // //    BEGIN
        // // // // // // //    //Keep filtering where Campus code is Not the one selected...
        // // // // // // //    TTTimetableCollectorDoubles.SETFILTER("Date Code",'<>%1',TTLectSpecDays."Date Code");
        // // // // // // //    END;
        // // // // // // //    UNTIL TTLectSpecDays.NEXT=0;
        // // // // // // //    // After Repeated Filtering, Delete All Entries in the Filters
        // // // // // // //    IF ToDeleteDoubles THEN TTTimetableCollectorDoubles.DELETE;
        // // // // // // //  END;
        // // // // // // // END;
        // // // // // // // UNTIL TTLecturers.NEXT=0;
        // // // // // // // END;
        // // // // // // // //////////////////////////////////////////////////////////////Lect Spec. Days on Doubles
        // // // // // // // //////////////////////////////////////////////////////////////Lect Spec. Days on Tripples
        // // // // // // // TTLecturers.RESET;
        // // // // // // // TTLecturers.SETRANGE(Semester,Rec.Semester);
        // // // // // // // IF TTLecturers.FIND('-') THEN BEGIN
        // // // // // // //  REPEAT
        // // // // // // //    BEGIN
        // // // // // // // TTLectSpecDays.RESET;
        // // // // // // // TTLectSpecDays.SETRANGE(Semester,Rec.Semester);
        // // // // // // // TTLectSpecDays.SETRANGE("Lecturer Code",TTLecturers."Lecturer Code");
        // // // // // // // TTLectSpecDays.SETFILTER("Date Code",'<>%1','');
        // // // // // // // IF TTLectSpecDays.FIND('-') THEN BEGIN
        // // // // // // //  //There Exists Lect Specific Campus
        // // // // // // //  REPEAT
        // // // // // // //    BEGIN
        // // // // // // //    IF TTLectSpecDays."Constraint Category"=TTLectSpecDays."Constraint Category"::Avoid THEN BEGIN
        // // // // // // //      //Delete all entries for the Lect and Campus Specified
        // // // // // // //    TTTimetableCollectorTripple.RESET;
        // // // // // // //    TTTimetableCollectorTripple.SETRANGE(Lecturer,TTLecturers."Lecturer Code");
        // // // // // // //    TTTimetableCollectorTripple.SETFILTER("Date Code",'%1',TTLectSpecDays."Date Code");
        // // // // // // //    IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
        // // // // // // //      END;
        // // // // // // //    IF TTLectSpecDays."Constraint Category"=TTLectSpecDays."Constraint Category"::"Least Preferred" THEN BEGIN
        // // // // // // //      //For the Lecturer and Campus Specified, Set Priority as 10
        // // // // // // //    TTTimetableCollectorTripple.RESET;
        // // // // // // //    TTTimetableCollectorTripple.SETRANGE(Lecturer,TTLecturers."Lecturer Code");
        // // // // // // //    TTTimetableCollectorTripple.SETFILTER("Date Code",'%1',TTLectSpecDays."Date Code");
        // // // // // // //    IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
        // // // // // // //    REPEAT
        // // // // // // //    BEGIN
        // // // // // // //      TTTimetableCollectorTripple."Lecturer Campus Priority":=10;
        // // // // // // //      TTTimetableCollectorTripple.MODIFY;
        // // // // // // //    END;
        // // // // // // //    UNTIL TTTimetableCollectorTripple.NEXT=0;
        // // // // // // //    END;
        // // // // // // //      END;
        // // // // // // //
        // // // // // // //    IF TTLectSpecDays."Constraint Category"=TTLectSpecDays."Constraint Category"::Preferred THEN BEGIN
        // // // // // // //      //For the Lecturer nd Campus Specified, Set Priority as 1
        // // // // // // //    TTTimetableCollectorTripple.RESET;
        // // // // // // //    TTTimetableCollectorTripple.SETRANGE(Lecturer,TTLecturers."Lecturer Code");
        // // // // // // //    TTTimetableCollectorTripple.SETFILTER("Date Code",'%1',TTLectSpecDays."Date Code");
        // // // // // // //    IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
        // // // // // // //    REPEAT
        // // // // // // //    BEGIN
        // // // // // // //      TTTimetableCollectorTripple."Lecturer Campus Priority":=1;
        // // // // // // //      TTTimetableCollectorTripple.MODIFY;
        // // // // // // //    END;
        // // // // // // //    UNTIL TTTimetableCollectorTripple.NEXT=0;
        // // // // // // //    END;
        // // // // // // //      END;
        // // // // // // //
        // // // // // // //    IF TTLectSpecDays."Constraint Category"=TTLectSpecDays."Constraint Category"::Mandatory THEN BEGIN
        // // // // // // //      //For the Lecturer nd Campus Specified, Set Priority as 1
        // // // // // // //    TTTimetableCollectorTripple.RESET;
        // // // // // // //    TTTimetableCollectorTripple.SETRANGE(Lecturer,TTLecturers."Lecturer Code");
        // // // // // // //    TTTimetableCollectorTripple.SETFILTER("Date Code",'%1',TTLectSpecDays."Date Code");
        // // // // // // //    IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
        // // // // // // //    REPEAT
        // // // // // // //    BEGIN
        // // // // // // //      TTTimetableCollectorTripple."Lecturer Campus Priority":=1;
        // // // // // // //      TTTimetableCollectorTripple.MODIFY;
        // // // // // // //    END;
        // // // // // // //    UNTIL TTTimetableCollectorTripple.NEXT=0;
        // // // // // // //    END;
        // // // // // // //      END;
        // // // // // // //    END;
        // // // // // // //    UNTIL TTLectSpecDays.NEXT=0;
        // // // // // // //  END;
        // // // // // // //
        // // // // // // //
        // // // // // // //    TTTimetableCollectorTripple.RESET;
        // // // // // // //    TTTimetableCollectorTripple.SETRANGE(Lecturer,TTLecturers."Lecturer Code");
        // // // // // // //  CLEAR(ToDeleteTripples);
        // // // // // // //    //// If the Constraints are Nandatory
        // // // // // // //  TTLectSpecDays.RESET;
        // // // // // // // TTLectSpecDays.SETRANGE(Semester,Rec.Semester);
        // // // // // // // TTLectSpecDays.SETRANGE("Lecturer Code",TTLecturers."Lecturer Code");
        // // // // // // // TTLectSpecDays.SETFILTER("Date Code",'<>%1','');
        // // // // // // // TTLectSpecDays.SETFILTER("Constraint Category",'=%1',TTLectSpecDays."Constraint Category"::Mandatory);
        // // // // // // // IF TTLectSpecDays.FIND('-') THEN BEGIN
        // // // // // // //  //There Exists Lecturer Specific Campus Where Category is Mandatory
        // // // // // // //    ToDeleteTripples:=TRUE;
        // // // // // // //  REPEAT
        // // // // // // //    BEGIN
        // // // // // // //    //Keep filtering where Campus code is Not the one selected...
        // // // // // // //    TTTimetableCollectorTripple.SETFILTER("Date Code",'<>%1',TTLectSpecDays."Date Code");
        // // // // // // //    END;
        // // // // // // //    UNTIL TTLectSpecDays.NEXT=0;
        // // // // // // //    // After Repeated Filtering, Delete All Entries in the Filters
        // // // // // // //    IF ToDeleteTripples THEN TTTimetableCollectorTripple.DELETE;
        // // // // // // //  END;
        // // // // // // // END;
        // // // // // // // UNTIL TTLecturers.NEXT=0;
        // // // // // // // END;
        // // // // // // // //////////////////////////////////////////////////////////////Lect Spec. Days on Tripples
    end;
}

