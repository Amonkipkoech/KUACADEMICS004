page 74500 "TT-Timetable Batches"
{
    Caption = 'Timetable Batches';
    PageType = List;
    SourceTable = 74505;

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
                RunObject = Page "TT-Timetable Programs";
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
                RunObject = Page "TT-Timetable Units";
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
                RunObject = Page "TT-Timetable Lecturers";
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
                RunObject = Page "TT-Blocks";
                RunPageLink = "Academic Year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester);
                ApplicationArea = All;
            }
            action(Rooms)
            {
                Caption = 'Lecturer Hall';
                Image = Card;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "TT-Rooms";
                RunPageLink = "Academic Year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester);
                ApplicationArea = All;
            }
            action(Days)
            {
                Caption = 'Days of the week';
                Image = CalendarWorkcenter;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 74523;
                RunPageLink = "Academic Year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester);
                ApplicationArea = All;
            }
            action("Lesson Weighting")
            {
                Caption = 'Lesson Weighting';
                Image = CreateBins;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 74527;
                RunPageLink = "Academic Year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester);
                ApplicationArea = All;
            }
            action("Lessons List")
            {
                Caption = 'Lessons List';
                Image = CreateRating;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 74529;
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
                    TTLecturers: Record "TT-Lecturers";
                    TTProgrammes: Record "TT-Programmes";
                    TTUnits: Record "TT-Units";
                    LectLoadBatchLines: Record "ACA-Lecturers Units";
                    TTWeightLessonCategories: Record "TT-Weight Lesson Categories";
                begin
                    Rec.CALCFIELDS(Current);
                    //IF Rec.Current = FALSE THEN ERROR('The Semester is already closed');
                    IF CONFIRM('Generate Automatic Constraints, Continue?', True) = FALSE THEN ERROR('Cancelled by user!');
                    //IF CONFIRM('You may be required to regenerate your timetable \after generating your constraints. \Continue?',TRUE)=FALSE THEN  ERROR('Cancelled by user!');

                    //Get Default Catogory
                    TTWeightLessonCategories.RESET;
                    TTWeightLessonCategories.SETRANGE(Semester, Rec.Semester);
                    TTWeightLessonCategories.SETRANGE("Default Category", TRUE);
                    IF TTWeightLessonCategories.FIND('-') THEN BEGIN
                    END ELSE
                        ERROR('Defauly Unit Weighting category is not defined!');
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
                                TTUnits."Weighting Category" := TTWeightLessonCategories."Category Code";
                                TTUnits.INSERT;
                            END;
                        END;
                        UNTIL LectLoadBatchLines.NEXT = 0;
                    END ELSE
                        ERROR('Caurse loading for the current Semester has not been done!');

                    //IF CONFIRM('Re-Generate the timetable Entries?',TRUE)=FALSE THEN EXIT;
                    GenerateEntriesSingles;
                    GenerateEntriesDoubles;
                    GenerateEntriesTripple;
                    // // // // //         SpecificConstraintsProgCampuses;
                    // // // // //         SpecificConstraintsLectCampuses;
                    // // // // //         SpecificConstraintsUnitCampuses;
                    // // // // //         SpecificConstraintsProgRooms;
                    // // // // //         SpecificConstraintsUnitRooms;
                    // // // // //         SpecificConstraintsProgDays;
                    // // // // //         SpecificConstraintsLectDays;
                    ThiningSingles;
                    ThiningDoubles;
                    ThiningTripples;
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
                        REPORT.RUN(74500, TRUE, FALSE, TTTimetableFInalCollector);
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
                    REPORT.RUN(Report::"TT-Master Timetable (Final) 2", TRUE, FALSE, TTTimetableFInalCollector);
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
                    TTUnits: Record "TT-Units";
                begin
                    TTUnits.RESET;
                    TTUnits.SETRANGE(Semester, Rec.Semester);
                    IF TTUnits.FIND('-') THEN
                        REPORT.RUN(74502, TRUE, FALSE, TTUnits);
                end;
            }
            action("TImetable Preview")
            {
                Caption = 'TImetable Preview';
                Image = PreviewChecks;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page 74530;
                RunPageLink = Semester = FIELD(Semester);
                ApplicationArea = All;
            }
        }
    }

    var
        CountedEntries: Integer;
        TTTimetableFInalCollector: Record 74523;
        TTUnitSpecRooms111: Record 74514;
        TTRooms2: Record "TT-Rooms";

    local procedure GenerateEntriesSingles()
    var
        TTRooms: Record "TT-Rooms";
        TTDailyLessons: Record "TT-Daily Lessons";
        ACALecturersUnits: Record "ACA-Lecturers Units";
        TTTimetableCollectorA: Record "TT-Timetable Collector Singles";
        LectLoadBatchLines: Record "Lect Load Batch Lines";
        ACAProgramme: Record "ACA-Programme";
        ACAUnitsSubjects: Record "ACA-Units/Subjects";
        TTUnits: Record "TT-Units";
        TTLessons: Record "TT-Lessons";
        TTDays: Record "TT-Days";
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
        //prempTrns: Record 61091;
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
        TTProgSpecCampuses: Record 74507;
        TTProgSpecDays: Record 74508;
        TTProgSpecRooms: Record 74509;
        TTUnitSpecCampuses: Record 74513;
        TTUnitSpecRooms: Record 74514;
        TTLectSpecCampuses: Record 74510;
        TTLectSpecDays: Record 74511;
        TTLectSpecLessons: Record 74512;
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
        TTTimetableCollectorA.RESET;
        TTTimetableCollectorA.SETRANGE(Semester, Rec.Semester);
        IF TTTimetableCollectorA.FIND('-') THEN TTTimetableCollectorA.DELETEALL;
        CLEAR(CountedEntries);
        TTRooms.RESET;
        TTRooms.SETRANGE(Semester, Rec.Semester);
        IF TTRooms.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                TTDailyLessons.RESET;
                TTDailyLessons.SETRANGE(Semester, Rec.Semester);
                IF TTDailyLessons.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        TTLessons.RESET;
                        TTLessons.SETRANGE("Lesson Code", TTDailyLessons."Lesson Code");
                        IF TTLessons.FIND('-') THEN;
                        TTDays.RESET;
                        TTDays.SETRANGE("Day Code", TTDailyLessons."Day Code");
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
                                    RecCount1 := FORMAT(counts) + '). ' + 'Day: ' + TTDays."Day Code" + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code" + '; Stream: ' + ACALecturersUnits.Class
                                ELSE
                                    IF counts = 2 THEN BEGIN
                                        RecCount2 := FORMAT(counts) + '). ' + 'Day: ' + TTDays."Day Code" + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                    ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code" + '; Stream: ' + ACALecturersUnits.Class
                                    END
                                    ELSE
                                        IF counts = 3 THEN BEGIN
                                            RecCount3 := FORMAT(counts) + '). ' + 'Day: ' + TTDays."Day Code" + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                        ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code" + '; Stream: ' + ACALecturersUnits.Class
                                        END
                                        ELSE
                                            IF counts = 4 THEN BEGIN
                                                RecCount4 := FORMAT(counts) + '). ' + 'Day: ' + TTDays."Day Code" + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                            ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code" + '; Stream: ' + ACALecturersUnits.Class
                                            END
                                            ELSE
                                                IF counts = 5 THEN BEGIN
                                                    RecCount5 := FORMAT(counts) + '). ' + 'Day: ' + TTDays."Day Code" + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                                ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code" + '; Stream: ' + ACALecturersUnits.Class
                                                END
                                                ELSE
                                                    IF counts = 6 THEN BEGIN
                                                        RecCount6 := FORMAT(counts) + '). ' + 'Day: ' + TTDays."Day Code" + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                                    ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code" + '; Stream: ' + ACALecturersUnits.Class
                                                    END
                                                    ELSE
                                                        IF counts = 7 THEN BEGIN
                                                            RecCount7 := FORMAT(counts) + '). ' + 'Day: ' + TTDays."Day Code" + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                                        ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code" + '; Stream: ' + ACALecturersUnits.Class
                                                        END
                                                        ELSE
                                                            IF counts = 8 THEN BEGIN
                                                                RecCount8 := FORMAT(counts) + '). ' + 'Day: ' + TTDays."Day Code" + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                                            ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code" + '; Stream: ' + ACALecturersUnits.Class
                                                            END
                                                            ELSE
                                                                IF counts = 9 THEN BEGIN
                                                                    RecCount9 := FORMAT(counts) + '). ' + 'Day: ' + TTDays."Day Code" + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                                                ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code" + '; Stream: ' + ACALecturersUnits.Class
                                                                END
                                                                ELSE
                                                                    IF counts = 10 THEN BEGIN
                                                                        RecCount10 := FORMAT(counts) + '). ' + 'Day: ' + TTDays."Day Code" + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                                                    ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code" + '; Stream: ' + ACALecturersUnits.Class
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
                                                                            RecCount10 := FORMAT(counts) + '). ' + 'Day: ' + TTDays."Day Code" + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                                                        ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code" + '; Stream: ' + ACALecturersUnits.Class;
                                                                        END;
                                CLEAR(BufferString);
                                BufferString := 'Total Records processed = ' + FORMAT(counts);

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
                                TTProgSpecDays.SETFILTER("Day Code", '%1', TTDailyLessons."Day Code");
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

                                TTProgSpecRooms.RESET;
                                TTProgSpecRooms.SETRANGE(Semester, Rec.Semester);
                                TTProgSpecRooms.SETRANGE("Programme Code", ACALecturersUnits.Programme);
                                TTProgSpecRooms.SETFILTER("Room Code", '%1', TTRooms."Room Code");
                                IF TTProgSpecRooms.FIND('-') THEN BEGIN
                                    IF TTProgSpecRooms."Constraint Category" = TTProgSpecRooms."Constraint Category"::Avoid THEN
                                        ProgSpecRoom := 666
                                    ELSE
                                        IF TTProgSpecRooms."Constraint Category" = TTProgSpecRooms."Constraint Category"::"Least Preferred" THEN
                                            ProgSpecRoom := 333
                                        ELSE
                                            IF TTProgSpecRooms."Constraint Category" = TTProgSpecRooms."Constraint Category"::Preferred THEN
                                                ProgSpecRoom := 3
                                            ELSE
                                                IF TTProgSpecRooms."Constraint Category" = TTProgSpecRooms."Constraint Category"::Mandatory THEN ProgSpecRoom := 1;
                                END;
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
                                TTLectSpecLessons.SETFILTER("Lesson Code", '%1', TTDailyLessons."Lesson Code");
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
                                TTLectSpecDays.SETFILTER("Day Code", '%1', TTDailyLessons."Day Code");
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
                                TTTimetableCollectorA.SETRANGE("Lesson Code", TTDailyLessons."Lesson Code");
                                TTTimetableCollectorA.SETRANGE("Day of Week", TTDailyLessons."Day Code");
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
                                    TTTimetableCollectorA."Lesson Code" := TTDailyLessons."Lesson Code";
                                    TTTimetableCollectorA."Lesson Category" := TTUnits."Weighting Category";
                                    TTTimetableCollectorA."Day of Week" := TTDailyLessons."Day Code";
                                    TTTimetableCollectorA."Lecture Room" := TTRooms."Room Code";
                                    TTTimetableCollectorA.Lecturer := LectLoadBatchLines."Lecturer Code";
                                    TTTimetableCollectorA.Department := LectLoadBatchLines."Department Code";
                                    TTTimetableCollectorA."Day Order" := TTDays."Day Order";
                                    TTTimetableCollectorA."Lesson Order" := TTLessons."Lesson Order";
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
                                        IF TTRooms."Room Type" <> TTRooms."Room Type"::Class THEN BEGIN
                                            TTUnitSpecRooms111.RESET;
                                            TTUnitSpecRooms111.SETRANGE(Semester, Rec.Semester);
                                            TTUnitSpecRooms111.SETRANGE("Programme Code", ACALecturersUnits.Programme);
                                            TTUnitSpecRooms111.SETRANGE("Unit Code", ACALecturersUnits.Unit);
                                            TTUnitSpecRooms111.SETRANGE("Room Code", TTRooms."Room Code");
                                            IF TTUnitSpecRooms111.FIND('-') THEN BEGIN
                                                CountedEntries := CountedEntries + 1;
                                                TTTimetableCollectorA."Record ID" := CountedEntries;
                                                TTTimetableCollectorA.INSERT;
                                            END;
                                        END ELSE BEGIN
                                            CountedEntries := CountedEntries + 1;
                                            TTTimetableCollectorA."Record ID" := CountedEntries;
                                            TTTimetableCollectorA.INSERT;
                                        END;
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

    local procedure GenerateEntriesDoubles()
    var
        TTRooms: Record "TT-Rooms";
        TTDailyLessons: Record 74503;
        ACALecturersUnits: Record "ACA-Lecturers Units";
        TTTimetableCollectorDoubles: Record 74521;
        LectLoadBatchLines: Record 65201;
        ACAProgramme: Record 61511;
        ACAUnitsSubjects: Record 61517;
        TTUnits: Record "TT-Units";
        TTLessons: Record 74520;
        TTDays: Record 74502;
        TTLessons1: Record 74520;
        TTLessons2: Record 74520;
        TTLessons3: Record 74520;
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
        //prempTrns: Record 61091;
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
        progre.OPEN('Generating Entries for Doubles:  #1#############################' +
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
        TTTimetableCollectorDoubles.RESET;
        TTTimetableCollectorDoubles.SETRANGE(Semester, Rec.Semester);
        IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
        CLEAR(CountedEntries);
        TTRooms.RESET;
        TTRooms.SETRANGE(Semester, Rec.Semester);
        IF TTRooms.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                TTDays.RESET;
                //TTDays.SETRANGE("Day Code",TTDailyLessons."Day Code");
                TTDays.SETRANGE(Semester, Rec.Semester);
                IF TTDays.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        TTDailyLessons.RESET;
                        TTDailyLessons.SETRANGE(Semester, Rec.Semester);
                        TTDailyLessons.SETRANGE("Day Code", TTDays."Day Code");
                        IF TTDailyLessons.FIND('-') THEN BEGIN
                            REPEAT
                            BEGIN
                                TTLessons.RESET;
                                TTLessons.SETRANGE("Lesson Code", TTDailyLessons."Lesson Code");
                                IF TTLessons.FIND('-') THEN;

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
                                            RecCount1 := FORMAT(counts) + '). ' + 'Day: ' + TTDays."Day Code" + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                        ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                        ELSE
                                            IF counts = 2 THEN BEGIN
                                                RecCount2 := FORMAT(counts) + '). ' + 'Day: ' + TTDays."Day Code" + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                            ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                            END
                                            ELSE
                                                IF counts = 3 THEN BEGIN
                                                    RecCount3 := FORMAT(counts) + '). ' + 'Day: ' + TTDays."Day Code" + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                                ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                                END
                                                ELSE
                                                    IF counts = 4 THEN BEGIN
                                                        RecCount4 := FORMAT(counts) + '). ' + 'Day: ' + TTDays."Day Code" + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                                    ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                                    END
                                                    ELSE
                                                        IF counts = 5 THEN BEGIN
                                                            RecCount5 := FORMAT(counts) + '). ' + 'Day: ' + TTDays."Day Code" + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                                        ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                                        END
                                                        ELSE
                                                            IF counts = 6 THEN BEGIN
                                                                RecCount6 := FORMAT(counts) + '). ' + 'Day: ' + TTDays."Day Code" + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                                            ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                                            END
                                                            ELSE
                                                                IF counts = 7 THEN BEGIN
                                                                    RecCount7 := FORMAT(counts) + '). ' + 'Day: ' + TTDays."Day Code" + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                                                ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                                                END
                                                                ELSE
                                                                    IF counts = 8 THEN BEGIN
                                                                        RecCount8 := FORMAT(counts) + '). ' + 'Day: ' + TTDays."Day Code" + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                                                    ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                                                    END
                                                                    ELSE
                                                                        IF counts = 9 THEN BEGIN
                                                                            RecCount9 := FORMAT(counts) + '). ' + 'Day: ' + TTDays."Day Code" + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                                                        ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                                                        END
                                                                        ELSE
                                                                            IF counts = 10 THEN BEGIN
                                                                                RecCount10 := FORMAT(counts) + '). ' + 'Day: ' + TTDays."Day Code" + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
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
                                                                                    RecCount10 := FORMAT(counts) + '). ' + 'Day: ' + TTDays."Day Code" + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                                                                ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code";
                                                                                END;
                                        CLEAR(BufferString);
                                        BufferString := 'Total Records processed = ' + FORMAT(counts);

                                        progre.UPDATE();
                                        //SLEEP(50);
                                        ///////////////////////////////////////////////////////////////////////////////Progress Update
                                        LectLoadBatchLines.RESET;
                                        LectLoadBatchLines.SETRANGE("Lecturer Code", ACALecturersUnits.Lecturer);
                                        LectLoadBatchLines.SETRANGE("Semester Code", Rec.Semester);
                                        IF LectLoadBatchLines.FIND('-') THEN;
                                        TTUnits.RESET;
                                        TTUnits.SETRANGE(Semester, Rec.Semester);
                                        TTUnits.SETRANGE("Programme Code", ACALecturersUnits.Programme);
                                        TTUnits.SETRANGE("Unit Code", ACALecturersUnits.Unit);
                                        IF TTUnits.FIND('-') THEN;

                                        //IF TTLessons."Lesson Order"=1, then insert for 1, &2
                                        IF TTLessons."Lesson Order" = 1 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 2);
                                            IF TTLessons2.FIND('-') THEN BEGIN
                                                // // // // //                          //Insert a Doubles Combination Here

                                                CountedEntries := GenerateEntriesDoublesInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 1, 2, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                 ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                 LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, ACALecturersUnits.Class);

                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 2, 3

                                        //IF TTLessons."Lesson Order"=2, then insert for 2, & 3
                                        IF TTLessons."Lesson Order" = 2 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 3);
                                            IF TTLessons2.FIND('-') THEN BEGIN
                                                // // // // //                          //Insert a Doubles Combination Here

                                                CountedEntries := GenerateEntriesDoublesInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 2, 3, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                 ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                 LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, ACALecturersUnits.Class);

                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 2, 3

                                        ////////////////////////////////////////////////////////////////////////////////// 3, 4

                                        //IF TTLessons."Lesson Order"=3, then insert for 3, & 4
                                        IF TTLessons."Lesson Order" = 3 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 4);
                                            IF TTLessons2.FIND('-') THEN BEGIN
                                                // // // // //                          //Insert a Doubles Combination Here

                                                CountedEntries := GenerateEntriesDoublesInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 3, 4, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                 ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                 LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, ACALecturersUnits.Class);

                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 3, 4

                                        ////////////////////////////////////////////////////////////////////////////////// 4, 5

                                        //IF TTLessons."Lesson Order"=4, then insert for 4, & 5
                                        IF TTLessons."Lesson Order" = 4 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 5);
                                            IF TTLessons2.FIND('-') THEN BEGIN
                                                // // // // //                          //Insert a Doubles Combination Here

                                                CountedEntries := GenerateEntriesDoublesInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 4, 5, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                 ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                 LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, ACALecturersUnits.Class);

                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 4, 5
                                        ////////////////////////////////////////////////////////////////////////////////// 5, 6

                                        //IF TTLessons."Lesson Order"=5, then insert for 5, & 6
                                        IF TTLessons."Lesson Order" = 5 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 6);
                                            IF TTLessons2.FIND('-') THEN BEGIN
                                                // // // // //                          //Insert a Doubles Combination Here

                                                CountedEntries := GenerateEntriesDoublesInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 5, 6, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                 ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                 LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, ACALecturersUnits.Class);

                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 5, 6
                                        ////////////////////////////////////////////////////////////////////////////////// 6, 7

                                        //IF TTLessons."Lesson Order"=6, then insert for 6, & 7
                                        IF TTLessons."Lesson Order" = 6 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 7);
                                            IF TTLessons2.FIND('-') THEN BEGIN
                                                // // // // //                          //Insert a Doubles Combination Here

                                                CountedEntries := GenerateEntriesDoublesInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 6, 7, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                 ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                 LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, ACALecturersUnits.Class);

                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 6, 7
                                        ////////////////////////////////////////////////////////////////////////////////// 7, 8

                                        //IF TTLessons."Lesson Order"=7, then insert for 7, & 8
                                        IF TTLessons."Lesson Order" = 7 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 8);
                                            IF TTLessons2.FIND('-') THEN BEGIN
                                                // // // // //                          //Insert a Doubles Combination Here

                                                CountedEntries := GenerateEntriesDoublesInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 7, 8, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                 ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                 LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, ACALecturersUnits.Class);

                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 7, 8
                                        ////////////////////////////////////////////////////////////////////////////////// 8, 9

                                        //IF TTLessons."Lesson Order"=8, then insert for 8, & 9
                                        IF TTLessons."Lesson Order" = 8 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 9);
                                            IF TTLessons2.FIND('-') THEN BEGIN
                                                // // // // //                          //Insert a Doubles Combination Here

                                                CountedEntries := GenerateEntriesDoublesInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 8, 9, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                 ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                 LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, ACALecturersUnits.Class);

                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 8, 9
                                        ////////////////////////////////////////////////////////////////////////////////// 9, 10

                                        //IF TTLessons."Lesson Order"=9, then insert for 9, & 10
                                        IF TTLessons."Lesson Order" = 9 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 10);
                                            IF TTLessons2.FIND('-') THEN BEGIN
                                                // // // // //                          //Insert a Doubles Combination Here

                                                CountedEntries := GenerateEntriesDoublesInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 9, 10, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                 ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                 LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, ACALecturersUnits.Class);

                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 9, 10
                                        ////////////////////////////////////////////////////////////////////////////////// 10, 11

                                        //IF TTLessons."Lesson Order"=10, then insert for 10, & 11
                                        IF TTLessons."Lesson Order" = 10 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 11);
                                            IF TTLessons2.FIND('-') THEN BEGIN
                                                // // // // //                          //Insert a Doubles Combination Here

                                                CountedEntries := GenerateEntriesDoublesInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 10, 11, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                 ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                 LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, ACALecturersUnits.Class);

                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 10, 11
                                        ////////////////////////////////////////////////////////////////////////////////// 11, 12

                                        //IF TTLessons."Lesson Order"=11, then insert for 11, & 12
                                        IF TTLessons."Lesson Order" = 11 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 12);
                                            IF TTLessons2.FIND('-') THEN BEGIN
                                                // // // // //                          //Insert a Doubles Combination Here

                                                CountedEntries := GenerateEntriesDoublesInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 11, 12, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                 ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                 LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, ACALecturersUnits.Class);

                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 11, 12
                                        ////////////////////////////////////////////////////////////////////////////////// 12, 13

                                        //IF TTLessons."Lesson Order"=12, then insert for 12, & 13
                                        IF TTLessons."Lesson Order" = 12 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 13);
                                            IF TTLessons2.FIND('-') THEN BEGIN

                                                CountedEntries := GenerateEntriesDoublesInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 12, 13, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                 ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                 LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, ACALecturersUnits.Class);

                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 12, 13
                                        ////////////////////////////////////////////////////////////////////////////////// 13, 14

                                        //IF TTLessons."Lesson Order"=13, then insert for 13, & 14
                                        IF TTLessons."Lesson Order" = 13 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 14);
                                            IF TTLessons2.FIND('-') THEN BEGIN

                                                CountedEntries := GenerateEntriesDoublesInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 13, 14, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                 ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                 LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, ACALecturersUnits.Class);

                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 13, 14
                                        ////////////////////////////////////////////////////////////////////////////////// 14, 15

                                        //IF TTLessons."Lesson Order"=14, then insert for 14, & 15
                                        IF TTLessons."Lesson Order" = 14 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 15);
                                            IF TTLessons2.FIND('-') THEN BEGIN

                                                CountedEntries := GenerateEntriesDoublesInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 14, 15, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                 ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                 LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, ACALecturersUnits.Class);

                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 14, 15
                                        ////////////////////////////////////////////////////////////////////////////////// 15, 16

                                        //IF TTLessons."Lesson Order"=15, then insert for 15, & 16
                                        IF TTLessons."Lesson Order" = 15 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 16);
                                            IF TTLessons2.FIND('-') THEN BEGIN

                                                CountedEntries := GenerateEntriesDoublesInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 15, 16, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                 ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                 LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, ACALecturersUnits.Class);

                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 15, 16
                                        ////////////////////////////////////////////////////////////////////////////////// 16, 17

                                        //IF TTLessons."Lesson Order"=16, then insert for 16, & 17
                                        IF TTLessons."Lesson Order" = 16 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 17);
                                            IF TTLessons2.FIND('-') THEN BEGIN

                                                CountedEntries := GenerateEntriesDoublesInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 16, 17, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                 ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                 LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, ACALecturersUnits.Class);

                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 16, 17
                                        ////////////////////////////////////////////////////////////////////////////////// 17, 18

                                        //IF TTLessons."Lesson Order"=17, then insert for 17, & 18
                                        IF TTLessons."Lesson Order" = 17 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 18);
                                            IF TTLessons2.FIND('-') THEN BEGIN

                                                CountedEntries := GenerateEntriesDoublesInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 17, 18, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                 ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                 LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, ACALecturersUnits.Class);

                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 17, 18
                                        ////////////////////////////////////////////////////////////////////////////////// 18, 19

                                        //IF TTLessons."Lesson Order"=18, then insert for 18, & 19
                                        IF TTLessons."Lesson Order" = 18 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 19);
                                            IF TTLessons2.FIND('-') THEN BEGIN

                                                CountedEntries := GenerateEntriesDoublesInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 18, 19, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                 ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                 LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, ACALecturersUnits.Class);

                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 18, 19
                                        ////////////////////////////////////////////////////////////////////////////////// 19, 20

                                        //IF TTLessons."Lesson Order"=19, then insert for 19, & 20
                                        IF TTLessons."Lesson Order" = 19 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 20);
                                            IF TTLessons2.FIND('-') THEN BEGIN

                                                CountedEntries := GenerateEntriesDoublesInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 19, 20, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                 ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                 LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, ACALecturersUnits.Class);

                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 19, 20
                                        ////////////////////////////////////////////////////////////////////////////////// 20, 21

                                        //IF TTLessons."Lesson Order"=20, then insert for 20, & 21
                                        IF TTLessons."Lesson Order" = 20 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 21);
                                            IF TTLessons2.FIND('-') THEN BEGIN

                                                CountedEntries := GenerateEntriesDoublesInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 20, 21, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                 ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                 LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, ACALecturersUnits.Class);

                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 20, 21
                                    END;
                                    UNTIL ACALecturersUnits.NEXT = 0;
                                END;
                            END;
                            UNTIL TTDailyLessons.NEXT = 0;
                        END;
                    END;
                    UNTIL TTDays.NEXT = 0;
                END;
            END;
            UNTIL TTRooms.NEXT = 0;
        END;

        progre.CLOSE;
    end;

    local procedure GenerateEntriesDoublesInsert(Progz: Code[20]; Unitz: Code[20]; Semz: Code[20]; Less1: Integer; Less2: Integer; DayCode: Code[20]; RoomCode: Code[20]; Lect: Code[20]; BlockCode: Code[20]; UnitCategory: Code[20]; Dept: Code[20]; DayOrder: Integer; RoomType: Option Class,Hall,Lab; Faculty: Code[20]; Campus: Code[20]; Counts: Integer; ClassCode: Code[20]) CountedEntries: Integer
    var
        TTRooms: Record "TT-Rooms";
        TTDailyLessons: Record 74503;
        ACALecturersUnits: Record "ACA-Lecturers Units";
        TTTimetableCollectorDoubles: Record 74521;
        LectLoadBatchLines: Record 65201;
        ACAProgramme: Record 61511;
        ACAUnitsSubjects: Record 61517;
        TTUnits: Record "TT-Units";
        TTLessons: Record 74520;
        TTDays: Record 74502;
        TTLessons1: Record 74520;
        TTLessons2: Record 74520;
        TTLessons3: Record 74520;
        UnitSpecRoom: Integer;
        ProgSpecRoom: Integer;
        LectSpecLessons: Integer;
        UnitSpecCampus: Integer;
        ProgSpecCampuses: Integer;
        LectSpecCampuses: Integer;
        LectSpecDays: Integer;
        ProgSpecDays: Integer;
        TTProgSpecCampuses: Record 74507;
        TTProgSpecDays: Record 74508;
        TTProgSpecRooms: Record 74509;
        TTUnitSpecCampuses: Record 74513;
        TTUnitSpecRooms: Record 74514;
        TTLectSpecCampuses: Record 74510;
        TTLectSpecDays: Record 74511;
        TTLectSpecLessons: Record 74512;
    begin

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
        TTProgSpecCampuses.SETRANGE(Semester, Semz);
        TTProgSpecCampuses.SETRANGE("Programme Code", Progz);
        TTProgSpecCampuses.SETFILTER("Campus Code", '%1', Campus);
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
        TTProgSpecDays.SETRANGE(Semester, Semz);
        TTProgSpecDays.SETRANGE("Programme Code", Progz);
        TTProgSpecDays.SETFILTER("Day Code", '%1', DayCode);
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

        TTProgSpecRooms.RESET;
        TTProgSpecRooms.SETRANGE(Semester, Semz);
        TTProgSpecRooms.SETRANGE("Programme Code", Progz);
        TTProgSpecRooms.SETFILTER("Room Code", '%1', RoomCode);
        IF TTProgSpecRooms.FIND('-') THEN BEGIN
            IF TTProgSpecRooms."Constraint Category" = TTProgSpecRooms."Constraint Category"::Avoid THEN
                ProgSpecRoom := 666
            ELSE
                IF TTProgSpecRooms."Constraint Category" = TTProgSpecRooms."Constraint Category"::"Least Preferred" THEN
                    ProgSpecRoom := 333
                ELSE
                    IF TTProgSpecRooms."Constraint Category" = TTProgSpecRooms."Constraint Category"::Preferred THEN
                        ProgSpecRoom := 3
                    ELSE
                        IF TTProgSpecRooms."Constraint Category" = TTProgSpecRooms."Constraint Category"::Mandatory THEN ProgSpecRoom := 1;
        END;
        //---- Lecturer

        TTLectSpecCampuses.RESET;
        TTLectSpecCampuses.SETRANGE(Semester, Semz);
        TTLectSpecCampuses.SETRANGE("Lecturer Code", Lect);
        TTLectSpecCampuses.SETFILTER("Campus Code", '%1', Campus);
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
        /*
        TTLectSpecLessons.RESET;
        TTLectSpecLessons.SETRANGE(Semester,Semz);
        TTLectSpecLessons.SETRANGE("Lecturer Code",Lect);
        TTLectSpecLessons.SETFILTER("Lesson Code",'%1|%2',Less1,Less2);
        IF TTLectSpecLessons.FIND('-') THEN BEGIN
          IF TTLectSpecLessons."Constraint Category"=TTLectSpecLessons."Constraint Category"::Avoid THEN LectSpecLessons:=666
          ELSE IF TTLectSpecLessons."Constraint Category"=TTLectSpecLessons."Constraint Category"::"Least Preferred" THEN LectSpecLessons:=333
          ELSE IF TTLectSpecLessons."Constraint Category"=TTLectSpecLessons."Constraint Category"::Preferred THEN LectSpecLessons:=3
          ELSE IF TTLectSpecLessons."Constraint Category"=TTLectSpecLessons."Constraint Category"::Mandatory THEN LectSpecLessons:=1;
          END;
         */
        TTLectSpecDays.RESET;
        TTLectSpecDays.SETRANGE(Semester, Semz);
        TTLectSpecDays.SETRANGE("Lecturer Code", Lect);
        TTLectSpecDays.SETFILTER("Day Code", '%1', DayCode);
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
        TTUnitSpecCampuses.SETRANGE(Semester, Semz);
        TTUnitSpecCampuses.SETRANGE("Programme Code", Progz);
        TTUnitSpecCampuses.SETFILTER("Campus Code", '%1', Campus);
        TTUnitSpecCampuses.SETFILTER("Unit Code", '%1', Unitz);
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
        TTUnitSpecRooms.SETRANGE(Semester, Semz);
        TTUnitSpecRooms.SETRANGE("Programme Code", Progz);
        TTUnitSpecRooms.SETFILTER("Unit Code", '%1', Unitz);
        TTUnitSpecRooms.SETFILTER("Room Code", '%1', RoomCode);
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



        CountedEntries := Counts;
        TTTimetableCollectorDoubles.RESET;
        TTTimetableCollectorDoubles.SETRANGE(Programme, Progz);
        TTTimetableCollectorDoubles.SETRANGE(Unit, Unitz);
        TTTimetableCollectorDoubles.SETRANGE(Semester, Semz);
        TTTimetableCollectorDoubles.SETRANGE("Lesson 1", Less1);
        TTTimetableCollectorDoubles.SETRANGE("Lesson 2", Less2);
        TTTimetableCollectorDoubles.SETRANGE("Day of Week", DayCode);
        TTTimetableCollectorDoubles.SETRANGE("Lecture Room", RoomCode);
        TTTimetableCollectorDoubles.SETRANGE(Lecturer, Lect);
        // TTTimetableCollectorA.SETRANGE("Campus Code",ACALecturersUnits.);
        // TTTimetableCollectorA.SETRANGE(Department,LectLoadBatchLines,Department);
        TTTimetableCollectorDoubles.SETRANGE("Room Code", RoomCode);
        //  TTTimetableCollectorDoubles.SETRANGE("Block/Building",BlockCode);
        TTTimetableCollectorDoubles.SETRANGE("Lesson Category", TTUnits."Weighting Category");
        // TTTimetableCollectorA.SETRANGE("School or Faculty",LectLoadBatchLines.Faculty);
        // Progz,Unitz,Semz,Less1,Less2,DayCode,RoomCode,Lect,BlockCode,UnitCategory,Dept,DayOrder,RoomType,Faculty,Campus,Counts
        IF NOT (TTTimetableCollectorDoubles.FIND('-')) THEN BEGIN
            TTTimetableCollectorDoubles.INIT;
            TTTimetableCollectorDoubles.Programme := Progz;
            TTTimetableCollectorDoubles.Unit := Unitz;
            TTTimetableCollectorDoubles.Semester := Semz;
            TTTimetableCollectorDoubles."Lesson 1" := Less1;
            TTTimetableCollectorDoubles."Lesson 2" := Less2;
            TTTimetableCollectorDoubles."Lesson Category" := UnitCategory;
            TTTimetableCollectorDoubles."Day of Week" := DayCode;
            TTTimetableCollectorDoubles."Lecture Room" := RoomCode;
            TTTimetableCollectorDoubles.Lecturer := Lect;
            TTTimetableCollectorDoubles.Department := Dept;
            TTTimetableCollectorDoubles."Day Order" := DayOrder;
            //  TTTimetableCollectorA."Programme Option":=;
            TTTimetableCollectorDoubles."Room Type" := RoomType;
            TTTimetableCollectorDoubles."Room Code" := RoomCode;
            TTTimetableCollectorDoubles."Block/Building" := BlockCode;
            TTTimetableCollectorDoubles."School or Faculty" := Faculty;
            TTTimetableCollectorDoubles."Campus Code" := Campus;
            TTTimetableCollectorDoubles."Programme Campus Priority" := ProgSpecCampuses;
            TTTimetableCollectorDoubles."Programme Day Priority" := ProgSpecDays;
            TTTimetableCollectorDoubles."Programme Room Priority" := ProgSpecRoom;
            TTTimetableCollectorDoubles."Lecturer Campus Priority" := LectSpecCampuses;
            TTTimetableCollectorDoubles."Lecturer Day Priority" := LectSpecDays;
            TTTimetableCollectorDoubles."Lecturer Lesson Priority" := LectSpecLessons;
            TTTimetableCollectorDoubles."Unit Campus Priority" := UnitSpecCampus;
            TTTimetableCollectorDoubles."Unit Room Priority" := UnitSpecRoom;
            TTTimetableCollectorDoubles."Class Code" := ClassCode;
            IF ((Semz <> '') AND (RoomCode <> '') AND (Lect <> '')) THEN BEGIN
                TTRooms2.RESET;
                TTRooms2.SETRANGE(Semester, Rec.Semester);
                TTRooms2.SETRANGE("Room Code", RoomCode);
                TTRooms2.SETRANGE("Block Code", BlockCode);
                IF TTRooms2.FIND('-') THEN BEGIN
                    IF TTRooms2."Room Type" <> TTRooms2."Room Type"::Class THEN BEGIN
                        TTUnitSpecRooms111.RESET;
                        TTUnitSpecRooms111.SETRANGE(Semester, Rec.Semester);
                        TTUnitSpecRooms111.SETRANGE("Programme Code", Progz);
                        TTUnitSpecRooms111.SETRANGE("Unit Code", Unitz);
                        TTUnitSpecRooms111.SETRANGE("Room Code", TTRooms2."Room Code");
                        IF TTUnitSpecRooms111.FIND('-') THEN BEGIN
                            CountedEntries := CountedEntries + 1;
                            TTTimetableCollectorDoubles."Record ID" := CountedEntries;
                            TTTimetableCollectorDoubles.INSERT;
                        END;
                    END ELSE BEGIN
                        CountedEntries := CountedEntries + 1;
                        TTTimetableCollectorDoubles."Record ID" := CountedEntries;
                        TTTimetableCollectorDoubles.INSERT;
                    END;
                END;
            END;
        END;

    end;

    local procedure GenerateEntriesTripple()
    var
        TTRooms: Record "TT-Rooms";
        TTDailyLessons: Record 74503;
        ACALecturersUnits: Record "ACA-Lecturers Units";
        TTTimetableCollectorDoubles: Record 74522;
        LectLoadBatchLines: Record 65201;
        ACAProgramme: Record 61511;
        ACAUnitsSubjects: Record 61517;
        TTUnits: Record "TT-Units";
        TTLessons: Record 74520;
        TTDays: Record 74502;
        TTLessons1: Record 74520;
        TTLessons2: Record 74520;
        TTLessons3: Record 74520;
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
        //prempTrns: Record 61091;
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
        progre.OPEN('Generating Entries for Tripples:  #1#############################' +
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
        TTTimetableCollectorDoubles.RESET;
        TTTimetableCollectorDoubles.SETRANGE(Semester, Rec.Semester);
        IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
        CLEAR(CountedEntries);
        TTRooms.RESET;
        TTRooms.SETRANGE(Semester, Rec.Semester);
        IF TTRooms.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                TTDays.RESET;
                //TTDays.SETRANGE("Day Code",TTDailyLessons."Day Code");
                TTDays.SETRANGE(Semester, Rec.Semester);
                IF TTDays.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        TTDailyLessons.RESET;
                        TTDailyLessons.SETRANGE(Semester, Rec.Semester);
                        TTDailyLessons.SETRANGE("Day Code", TTDays."Day Code");
                        IF TTDailyLessons.FIND('-') THEN BEGIN
                            REPEAT
                            BEGIN
                                TTLessons.RESET;
                                TTLessons.SETRANGE("Lesson Code", TTDailyLessons."Lesson Code");
                                IF TTLessons.FIND('-') THEN;

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
                                            RecCount1 := FORMAT(counts) + '). ' + 'Day: ' + TTDays."Day Code" + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                        ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                        ELSE
                                            IF counts = 2 THEN BEGIN
                                                RecCount2 := FORMAT(counts) + '). ' + 'Day: ' + TTDays."Day Code" + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                            ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                            END
                                            ELSE
                                                IF counts = 3 THEN BEGIN
                                                    RecCount3 := FORMAT(counts) + '). ' + 'Day: ' + TTDays."Day Code" + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                                ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                                END
                                                ELSE
                                                    IF counts = 4 THEN BEGIN
                                                        RecCount4 := FORMAT(counts) + '). ' + 'Day: ' + TTDays."Day Code" + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                                    ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                                    END
                                                    ELSE
                                                        IF counts = 5 THEN BEGIN
                                                            RecCount5 := FORMAT(counts) + '). ' + 'Day: ' + TTDays."Day Code" + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                                        ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                                        END
                                                        ELSE
                                                            IF counts = 6 THEN BEGIN
                                                                RecCount6 := FORMAT(counts) + '). ' + 'Day: ' + TTDays."Day Code" + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                                            ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                                            END
                                                            ELSE
                                                                IF counts = 7 THEN BEGIN
                                                                    RecCount7 := FORMAT(counts) + '). ' + 'Day: ' + TTDays."Day Code" + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                                                ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                                                END
                                                                ELSE
                                                                    IF counts = 8 THEN BEGIN
                                                                        RecCount8 := FORMAT(counts) + '). ' + 'Day: ' + TTDays."Day Code" + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                                                    ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                                                    END
                                                                    ELSE
                                                                        IF counts = 9 THEN BEGIN
                                                                            RecCount9 := FORMAT(counts) + '). ' + 'Day: ' + TTDays."Day Code" + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                                                        ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code"
                                                                        END
                                                                        ELSE
                                                                            IF counts = 10 THEN BEGIN
                                                                                RecCount10 := FORMAT(counts) + '). ' + 'Day: ' + TTDays."Day Code" + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
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
                                                                                    RecCount10 := FORMAT(counts) + '). ' + 'Day: ' + TTDays."Day Code" + '; Lecturer: ' + ACALecturersUnits.Lecturer + '; Programme: ' + ACALecturersUnits.Programme + '; Unit: ' +
                                                                                ACALecturersUnits.Unit + '; Campus: ' + ACALecturersUnits."Campus Code";
                                                                                END;
                                        CLEAR(BufferString);
                                        BufferString := 'Total Tripples processed = ' + FORMAT(counts);

                                        progre.UPDATE();
                                        //SLEEP(50);
                                        ///////////////////////////////////////////////////////////////////////////////Progress Update
                                        LectLoadBatchLines.RESET;
                                        LectLoadBatchLines.SETRANGE("Lecturer Code", ACALecturersUnits.Lecturer);
                                        LectLoadBatchLines.SETRANGE("Semester Code", Rec.Semester);
                                        IF LectLoadBatchLines.FIND('-') THEN;
                                        TTUnits.RESET;
                                        TTUnits.SETRANGE(Semester, Rec.Semester);
                                        TTUnits.SETRANGE("Programme Code", ACALecturersUnits.Programme);
                                        TTUnits.SETRANGE("Unit Code", ACALecturersUnits.Unit);
                                        IF TTUnits.FIND('-') THEN;

                                        //IF TTLessons."Lesson Order"=1, then insert for 1, &2
                                        IF TTLessons."Lesson Order" = 1 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 2);
                                            IF TTLessons2.FIND('-') THEN BEGIN
                                                TTLessons3.RESET;
                                                TTLessons3.SETRANGE("Lesson Order", 3);
                                                IF TTLessons3.FIND('-') THEN BEGIN
                                                    //Insert a Tripple Combination Here

                                                    CountedEntries := GenerateEntriesTrippleInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 1, 2, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                     ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                     LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, 3, ACALecturersUnits.Class);
                                                END;

                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 2, 3

                                        //IF TTLessons."Lesson Order"=2, then insert for 2, & 3
                                        IF TTLessons."Lesson Order" = 2 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 3);
                                            IF TTLessons2.FIND('-') THEN BEGIN
                                                TTLessons3.RESET;
                                                TTLessons3.SETRANGE("Lesson Order", 4);
                                                IF TTLessons3.FIND('-') THEN BEGIN
                                                    //Insert a Tripple Combination Here

                                                    CountedEntries := GenerateEntriesTrippleInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 2, 3, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                     ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                     LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, 4, ACALecturersUnits.Class);
                                                END;
                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 2, 3

                                        ////////////////////////////////////////////////////////////////////////////////// 3, 4

                                        //IF TTLessons."Lesson Order"=3, then insert for 3, & 4
                                        IF TTLessons."Lesson Order" = 3 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 4);
                                            IF TTLessons2.FIND('-') THEN BEGIN
                                                TTLessons3.RESET;
                                                TTLessons3.SETRANGE("Lesson Order", 5);
                                                IF TTLessons3.FIND('-') THEN BEGIN
                                                    //Insert a Tripple Combination Here

                                                    CountedEntries := GenerateEntriesTrippleInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 3, 4, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                     ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                     LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, 5, ACALecturersUnits.Class);
                                                END;
                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 3, 4

                                        ////////////////////////////////////////////////////////////////////////////////// 4, 5

                                        //IF TTLessons."Lesson Order"=4, then insert for 4, & 5
                                        IF TTLessons."Lesson Order" = 4 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 5);
                                            IF TTLessons2.FIND('-') THEN BEGIN
                                                TTLessons3.RESET;
                                                TTLessons3.SETRANGE("Lesson Order", 6);
                                                IF TTLessons3.FIND('-') THEN BEGIN
                                                    //Insert a Tripple Combination Here

                                                    CountedEntries := GenerateEntriesTrippleInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 4, 5, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                     ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                     LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, 6, ACALecturersUnits.Class);
                                                END;
                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 4, 5
                                        ////////////////////////////////////////////////////////////////////////////////// 5, 6

                                        //IF TTLessons."Lesson Order"=5, then insert for 5, & 6
                                        IF TTLessons."Lesson Order" = 5 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 6);
                                            IF TTLessons2.FIND('-') THEN BEGIN
                                                TTLessons3.RESET;
                                                TTLessons3.SETRANGE("Lesson Order", 7);
                                                IF TTLessons3.FIND('-') THEN BEGIN
                                                    //Insert a Tripple Combination Here

                                                    CountedEntries := GenerateEntriesTrippleInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 5, 6, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                     ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                     LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, 7, ACALecturersUnits.Class);
                                                END;
                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 5, 6
                                        ////////////////////////////////////////////////////////////////////////////////// 6, 7

                                        //IF TTLessons."Lesson Order"=6, then insert for 6, & 7
                                        IF TTLessons."Lesson Order" = 6 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 7);
                                            IF TTLessons2.FIND('-') THEN BEGIN
                                                TTLessons3.RESET;
                                                TTLessons3.SETRANGE("Lesson Order", 8);
                                                IF TTLessons3.FIND('-') THEN BEGIN
                                                    //Insert a Tripple Combination Here

                                                    CountedEntries := GenerateEntriesTrippleInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 6, 7, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                     ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                     LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, 8, ACALecturersUnits.Class);
                                                END;
                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 6, 7
                                        ////////////////////////////////////////////////////////////////////////////////// 7, 8

                                        //IF TTLessons."Lesson Order"=7, then insert for 7, & 8
                                        IF TTLessons."Lesson Order" = 7 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 8);
                                            IF TTLessons2.FIND('-') THEN BEGIN
                                                TTLessons3.RESET;
                                                TTLessons3.SETRANGE("Lesson Order", 9);
                                                IF TTLessons3.FIND('-') THEN BEGIN
                                                    //Insert a Tripple Combination Here

                                                    CountedEntries := GenerateEntriesTrippleInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 7, 8, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                     ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                     LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, 9, ACALecturersUnits.Class);
                                                END;
                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 7, 8
                                        ////////////////////////////////////////////////////////////////////////////////// 8, 9

                                        //IF TTLessons."Lesson Order"=8, then insert for 8, & 9
                                        IF TTLessons."Lesson Order" = 8 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 9);
                                            IF TTLessons2.FIND('-') THEN BEGIN
                                                TTLessons3.RESET;
                                                TTLessons3.SETRANGE("Lesson Order", 10);
                                                IF TTLessons3.FIND('-') THEN BEGIN
                                                    //Insert a Tripple Combination Here

                                                    CountedEntries := GenerateEntriesTrippleInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 8, 9, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                     ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                     LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, 10, ACALecturersUnits.Class);
                                                END;
                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 8, 9
                                        ////////////////////////////////////////////////////////////////////////////////// 9, 10

                                        //IF TTLessons."Lesson Order"=9, then insert for 9, & 10
                                        IF TTLessons."Lesson Order" = 9 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 10);
                                            IF TTLessons2.FIND('-') THEN BEGIN
                                                TTLessons3.RESET;
                                                TTLessons3.SETRANGE("Lesson Order", 11);
                                                IF TTLessons3.FIND('-') THEN BEGIN
                                                    //Insert a Tripple Combination Here

                                                    CountedEntries := GenerateEntriesTrippleInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 9, 10, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                     ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                     LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, 11, ACALecturersUnits.Class);
                                                END;
                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 9, 10
                                        ////////////////////////////////////////////////////////////////////////////////// 10, 11

                                        //IF TTLessons."Lesson Order"=10, then insert for 10, & 11
                                        IF TTLessons."Lesson Order" = 10 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 11);
                                            IF TTLessons2.FIND('-') THEN BEGIN
                                                TTLessons3.RESET;
                                                TTLessons3.SETRANGE("Lesson Order", 12);
                                                IF TTLessons3.FIND('-') THEN BEGIN
                                                    //Insert a Tripple Combination Here

                                                    CountedEntries := GenerateEntriesTrippleInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 10, 11, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                     ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                     LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, 12, ACALecturersUnits.Class);
                                                END;
                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 10, 11
                                        ////////////////////////////////////////////////////////////////////////////////// 11, 12

                                        //IF TTLessons."Lesson Order"=11, then insert for 11, & 12
                                        IF TTLessons."Lesson Order" = 11 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 12);
                                            IF TTLessons2.FIND('-') THEN BEGIN
                                                TTLessons3.RESET;
                                                TTLessons3.SETRANGE("Lesson Order", 13);
                                                IF TTLessons3.FIND('-') THEN BEGIN
                                                    //Insert a Tripple Combination Here

                                                    CountedEntries := GenerateEntriesTrippleInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 11, 12, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                     ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                     LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, 13, ACALecturersUnits.Class);
                                                END;
                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 11, 12
                                        ////////////////////////////////////////////////////////////////////////////////// 12, 13,14

                                        //IF TTLessons."Lesson Order"=12, then insert for 12, & 13
                                        IF TTLessons."Lesson Order" = 12 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 13);
                                            IF TTLessons2.FIND('-') THEN BEGIN
                                                TTLessons3.RESET;
                                                TTLessons3.SETRANGE("Lesson Order", 14);
                                                IF TTLessons3.FIND('-') THEN BEGIN
                                                    //Insert a Tripple Combination Here

                                                    CountedEntries := GenerateEntriesTrippleInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 12, 13, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                     ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                     LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, 14, ACALecturersUnits.Class);
                                                END;
                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 12, 13,14
                                        ////////////////////////////////////////////////////////////////////////////////// 13, 14,15

                                        //IF TTLessons."Lesson Order"=13, then insert for 13, & 14,15
                                        IF TTLessons."Lesson Order" = 13 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 14);
                                            IF TTLessons2.FIND('-') THEN BEGIN
                                                TTLessons3.RESET;
                                                TTLessons3.SETRANGE("Lesson Order", 15);
                                                IF TTLessons3.FIND('-') THEN BEGIN
                                                    //Insert a Tripple Combination Here

                                                    CountedEntries := GenerateEntriesTrippleInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 13, 14, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                     ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                     LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, 15, ACALecturersUnits.Class);
                                                END;
                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 13, 14,15
                                        ////////////////////////////////////////////////////////////////////////////////// 14, 15,16

                                        //IF TTLessons."Lesson Order"=14, then insert for 14, & 15,16
                                        IF TTLessons."Lesson Order" = 14 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 15);
                                            IF TTLessons2.FIND('-') THEN BEGIN
                                                TTLessons3.RESET;
                                                TTLessons3.SETRANGE("Lesson Order", 16);
                                                IF TTLessons3.FIND('-') THEN BEGIN
                                                    //Insert a Tripple Combination Here

                                                    CountedEntries := GenerateEntriesTrippleInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 14, 15, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                     ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                     LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, 16, ACALecturersUnits.Class);
                                                END;
                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 14, 15,16
                                        ////////////////////////////////////////////////////////////////////////////////// 15, 16,17

                                        //IF TTLessons."Lesson Order"=15, then insert for 15, & 16,17
                                        IF TTLessons."Lesson Order" = 15 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 16);
                                            IF TTLessons2.FIND('-') THEN BEGIN
                                                TTLessons3.RESET;
                                                TTLessons3.SETRANGE("Lesson Order", 17);
                                                IF TTLessons3.FIND('-') THEN BEGIN
                                                    //Insert a Tripple Combination Here

                                                    CountedEntries := GenerateEntriesTrippleInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 15, 16, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                     ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                     LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, 17, ACALecturersUnits.Class);
                                                END;
                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 15, 16,17
                                        ////////////////////////////////////////////////////////////////////////////////// 16, 17,18

                                        //IF TTLessons."Lesson Order"=16, then insert for 16, & 17,18
                                        IF TTLessons."Lesson Order" = 16 THEN BEGIN
                                            TTLessons2.RESET;
                                            TTLessons2.SETRANGE("Lesson Order", 17);
                                            IF TTLessons2.FIND('-') THEN BEGIN
                                                TTLessons3.RESET;
                                                TTLessons3.SETRANGE("Lesson Order", 18);
                                                IF TTLessons3.FIND('-') THEN BEGIN
                                                    //Insert a Tripple Combination Here

                                                    CountedEntries := GenerateEntriesTrippleInsert(ACALecturersUnits.Programme, ACALecturersUnits.Unit, Rec.Semester, 16, 17, TTDailyLessons."Day Code", TTRooms."Room Code",
                                                     ACALecturersUnits.Lecturer, TTRooms."Block Code", TTUnits."Weighting Category", LectLoadBatchLines."Department Code", TTDays."Day Order", TTRooms."Room Type",
                                                     LectLoadBatchLines.Faculty, ACALecturersUnits."Campus Code", CountedEntries, 18, ACALecturersUnits.Class);
                                                END;
                                            END;
                                        END;
                                        ////////////////////////////////////////////////////////////////////////////////// 16, 17,18
                                    END;
                                    UNTIL ACALecturersUnits.NEXT = 0;
                                END;
                            END;
                            UNTIL TTDailyLessons.NEXT = 0;
                        END;
                    END;
                    UNTIL TTDays.NEXT = 0;
                END;
            END;
            UNTIL TTRooms.NEXT = 0;
        END;
        progre.CLOSE;
    end;

    local procedure GenerateEntriesTrippleInsert(Progz: Code[20]; Unitz: Code[20]; Semz: Code[20]; Less1: Integer; Less2: Integer; DayCode: Code[20]; RoomCode: Code[20]; Lect: Code[20]; BlockCode: Code[20]; UnitCategory: Code[20]; Dept: Code[20]; DayOrder: Integer; RoomType: Option Class,Hall,Lab; Faculty: Code[20]; Campus: Code[20]; Counts: Integer; Less3: Integer; ClassCode: Code[20]) CountedEntries: Integer
    var
        TTRooms: Record "TT-Rooms";
        TTDailyLessons: Record 74503;
        ACALecturersUnits: Record "ACA-Lecturers Units";
        TTTimetableCollectorTripple: Record 74522;
        LectLoadBatchLines: Record 65201;
        ACAProgramme: Record 61511;
        ACAUnitsSubjects: Record 61517;
        TTUnits: Record "TT-Units";
        TTLessons: Record 74520;
        TTDays: Record 74502;
        TTLessons1: Record 74520;
        TTLessons2: Record 74520;
        TTLessons3: Record 74520;
        UnitSpecRoom: Integer;
        ProgSpecRoom: Integer;
        LectSpecLessons: Integer;
        UnitSpecCampus: Integer;
        ProgSpecCampuses: Integer;
        LectSpecCampuses: Integer;
        LectSpecDays: Integer;
        ProgSpecDays: Integer;
        TTProgSpecCampuses: Record 74507;
        TTProgSpecDays: Record 74508;
        TTProgSpecRooms: Record 74509;
        TTUnitSpecCampuses: Record 74513;
        TTUnitSpecRooms: Record 74514;
        TTLectSpecCampuses: Record 74510;
        TTLectSpecDays: Record 74511;
        TTLectSpecLessons: Record 74512;
    begin

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
        TTProgSpecCampuses.SETRANGE(Semester, Semz);
        TTProgSpecCampuses.SETRANGE("Programme Code", Progz);
        TTProgSpecCampuses.SETFILTER("Campus Code", '%1', Campus);
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
        TTProgSpecDays.SETRANGE(Semester, Semz);
        TTProgSpecDays.SETRANGE("Programme Code", Progz);
        TTProgSpecDays.SETFILTER("Day Code", '%1', DayCode);
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

        TTProgSpecRooms.RESET;
        TTProgSpecRooms.SETRANGE(Semester, Semz);
        TTProgSpecRooms.SETRANGE("Programme Code", Progz);
        TTProgSpecRooms.SETFILTER("Room Code", '%1', RoomCode);
        IF TTProgSpecRooms.FIND('-') THEN BEGIN
            IF TTProgSpecRooms."Constraint Category" = TTProgSpecRooms."Constraint Category"::Avoid THEN
                ProgSpecRoom := 666
            ELSE
                IF TTProgSpecRooms."Constraint Category" = TTProgSpecRooms."Constraint Category"::"Least Preferred" THEN
                    ProgSpecRoom := 333
                ELSE
                    IF TTProgSpecRooms."Constraint Category" = TTProgSpecRooms."Constraint Category"::Preferred THEN
                        ProgSpecRoom := 3
                    ELSE
                        IF TTProgSpecRooms."Constraint Category" = TTProgSpecRooms."Constraint Category"::Mandatory THEN ProgSpecRoom := 1;
        END;
        //---- Lecturer

        TTLectSpecCampuses.RESET;
        TTLectSpecCampuses.SETRANGE(Semester, Semz);
        TTLectSpecCampuses.SETRANGE("Lecturer Code", Lect);
        TTLectSpecCampuses.SETFILTER("Campus Code", '%1', Campus);
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
        /*
        TTLectSpecLessons.RESET;
        TTLectSpecLessons.SETRANGE(Semester,Semz);
        TTLectSpecLessons.SETRANGE("Lecturer Code",Lect);
        TTLectSpecLessons.SETFILTER("Lesson Code",'%1|%2',Less1,Less2);
        IF TTLectSpecLessons.FIND('-') THEN BEGIN
          IF TTLectSpecLessons."Constraint Category"=TTLectSpecLessons."Constraint Category"::Avoid THEN LectSpecLessons:=666
          ELSE IF TTLectSpecLessons."Constraint Category"=TTLectSpecLessons."Constraint Category"::"Least Preferred" THEN LectSpecLessons:=333
          ELSE IF TTLectSpecLessons."Constraint Category"=TTLectSpecLessons."Constraint Category"::Preferred THEN LectSpecLessons:=3
          ELSE IF TTLectSpecLessons."Constraint Category"=TTLectSpecLessons."Constraint Category"::Mandatory THEN LectSpecLessons:=1;
          END;
         */
        TTLectSpecDays.RESET;
        TTLectSpecDays.SETRANGE(Semester, Semz);
        TTLectSpecDays.SETRANGE("Lecturer Code", Lect);
        TTLectSpecDays.SETFILTER("Day Code", '%1', DayCode);
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
        TTUnitSpecCampuses.SETRANGE(Semester, Semz);
        TTUnitSpecCampuses.SETRANGE("Programme Code", Progz);
        TTUnitSpecCampuses.SETFILTER("Campus Code", '%1', Campus);
        TTUnitSpecCampuses.SETFILTER("Unit Code", '%1', Unitz);
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
        TTUnitSpecRooms.SETRANGE(Semester, Semz);
        TTUnitSpecRooms.SETRANGE("Programme Code", Progz);
        TTUnitSpecRooms.SETFILTER("Unit Code", '%1', Unitz);
        TTUnitSpecRooms.SETFILTER("Room Code", '%1', RoomCode);
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




        CountedEntries := Counts;
        TTTimetableCollectorTripple.RESET;
        TTTimetableCollectorTripple.SETRANGE(Programme, Progz);
        TTTimetableCollectorTripple.SETRANGE(Unit, Unitz);
        TTTimetableCollectorTripple.SETRANGE(Semester, Semz);
        TTTimetableCollectorTripple.SETRANGE("Lesson 1", Less1);
        TTTimetableCollectorTripple.SETRANGE("Lesson 2", Less2);
        TTTimetableCollectorTripple.SETRANGE("Lesson 3", Less3);
        TTTimetableCollectorTripple.SETRANGE("Day of Week", DayCode);
        TTTimetableCollectorTripple.SETRANGE("Lecture Room", RoomCode);
        TTTimetableCollectorTripple.SETRANGE(Lecturer, Lect);
        // TTTimetableCollectorA.SETRANGE("Campus Code",ACALecturersUnits.);
        // TTTimetableCollectorA.SETRANGE(Department,LectLoadBatchLines,Department);
        TTTimetableCollectorTripple.SETRANGE("Room Code", RoomCode);
        // TTTimetableCollectorTripple.SETRANGE("Block/Building",BlockCode);
        TTTimetableCollectorTripple.SETRANGE("Lesson Category", TTUnits."Weighting Category");
        // TTTimetableCollectorA.SETRANGE("School or Faculty",LectLoadBatchLines.Faculty);
        // Progz,Unitz,Semz,Less1,Less2,DayCode,RoomCode,Lect,BlockCode,UnitCategory,Dept,DayOrder,RoomType,Faculty,Campus,Counts
        IF NOT (TTTimetableCollectorTripple.FIND('-')) THEN BEGIN
            TTTimetableCollectorTripple.INIT;
            TTTimetableCollectorTripple.Programme := Progz;
            TTTimetableCollectorTripple.Unit := Unitz;
            TTTimetableCollectorTripple.Semester := Semz;
            TTTimetableCollectorTripple."Lesson 1" := Less1;
            TTTimetableCollectorTripple."Lesson 2" := Less2;
            TTTimetableCollectorTripple."Lesson 3" := Less3;
            TTTimetableCollectorTripple."Lesson Category" := UnitCategory;
            TTTimetableCollectorTripple."Day of Week" := DayCode;
            TTTimetableCollectorTripple."Lecture Room" := RoomCode;
            TTTimetableCollectorTripple.Lecturer := Lect;
            TTTimetableCollectorTripple.Department := Dept;
            TTTimetableCollectorTripple."Day Order" := DayOrder;
            //  TTTimetableCollectorA."Programme Option":=;
            TTTimetableCollectorTripple."Room Type" := RoomType;
            TTTimetableCollectorTripple."Room Code" := RoomCode;
            TTTimetableCollectorTripple."Block/Building" := BlockCode;
            TTTimetableCollectorTripple."School or Faculty" := Faculty;
            TTTimetableCollectorTripple."Campus Code" := Campus;
            TTTimetableCollectorTripple."Programme Campus Priority" := ProgSpecCampuses;
            TTTimetableCollectorTripple."Programme Day Priority" := ProgSpecDays;
            TTTimetableCollectorTripple."Programme Room Priority" := ProgSpecRoom;
            TTTimetableCollectorTripple."Lecturer Campus Priority" := LectSpecCampuses;
            TTTimetableCollectorTripple."Lecturer Day Priority" := LectSpecDays;
            TTTimetableCollectorTripple."Lecturer Lesson Priority" := LectSpecLessons;
            TTTimetableCollectorTripple."Unit Campus Priority" := UnitSpecCampus;
            TTTimetableCollectorTripple."Unit Room Priority" := UnitSpecRoom;
            TTTimetableCollectorTripple."Class Code" := ClassCode;
            IF ((Semz <> '') AND (RoomCode <> '') AND (Lect <> '')) THEN BEGIN

                TTRooms2.RESET;
                TTRooms2.SETRANGE(Semester, Rec.Semester);
                TTRooms2.SETRANGE("Room Code", RoomCode);
                TTRooms2.SETRANGE("Block Code", BlockCode);
                IF TTRooms2.FIND('-') THEN BEGIN
                    IF TTRooms2."Room Type" <> TTRooms2."Room Type"::Class THEN BEGIN
                        TTUnitSpecRooms111.RESET;
                        TTUnitSpecRooms111.SETRANGE(Semester, Rec.Semester);
                        TTUnitSpecRooms111.SETRANGE("Programme Code", Progz);
                        TTUnitSpecRooms111.SETRANGE("Unit Code", Unitz);
                        TTUnitSpecRooms111.SETRANGE("Room Code", TTRooms2."Room Code");
                        IF TTUnitSpecRooms111.FIND('-') THEN BEGIN
                            CountedEntries := CountedEntries + 1;
                            TTTimetableCollectorTripple."Record ID" := CountedEntries;
                            TTTimetableCollectorTripple.INSERT;
                        END;
                    END ELSE BEGIN
                        CountedEntries := CountedEntries + 1;
                        TTTimetableCollectorTripple."Record ID" := CountedEntries;
                        TTTimetableCollectorTripple.INSERT;
                    END;
                END;
                // //                         CountedEntries:=CountedEntries+1;
                // //                       TTTimetableCollectorTripple."Record ID":=CountedEntries;
                // //                       TTTimetableCollectorTripple.INSERT;
            END;
        END;

    end;

    local procedure ThiningSingles()
    var
        TTRooms: Record "TT-Rooms";
        TTDailyLessons: Record 74503;
        ACALecturersUnits: Record "ACA-Lecturers Units";
        ACALecturersUnits2: Record "ACA-Lecturers Units";
        LectLoadBatchLines: Record 65201;
        ACAProgramme: Record 61511;
        ACAUnitsSubjects: Record 61517;
        ACAUnitsSubjects2: Record 61517;
        TTUnits: Record "TT-Units";
        TTLessons: Record 74520;
        TTDays: Record 74502;
        TTLessons1: Record 74520;
        TTLessons2: Record 74520;
        TTLessons3: Record 74520;
        TTWeightLessonCategories: Record "TT-Weight Lesson Categories";
        TTTimetableCollectorA: Record 74500;
        TTTimetableCollectorA1: Record 74500;
        TTTimetableCollectorA2: Record 74500;
        TTTimetableCollectorA3: Record 74500;
        TTTimetableCollectorDoubles: Record 74521;
        TTTimetableCollectorDoubles1: Record 74521;
        TTTimetableCollectorDoubles2: Record 74521;
        TTTimetableCollectorTripple: Record 74522;
        TTTimetableCollectorTripple1: Record 74522;
        TTTimetableCollectorTripple2: Record 74522;
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
        //prempTrns: Record 61091;
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
        progre.OPEN('Building Timetable for Singles:  #1#############################' +
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
                BufferString := 'Total Tripples processed = ' + FORMAT(counts);

                progre.UPDATE();
                //SLEEP(50);
                ///////////////////////////////////////////////////////////////////////////////Progress Update
                TTUnits.RESET;
                TTUnits.SETRANGE(Semester, Rec.Semester);
                TTUnits.SETRANGE("Programme Code", ACALecturersUnits.Programme);
                TTUnits.SETRANGE("Unit Code", ACALecturersUnits.Unit);
                IF TTUnits.FIND('-') THEN;
                TTWeightLessonCategories.RESET;
                TTWeightLessonCategories.SETRANGE(Semester, Rec.Semester);
                TTWeightLessonCategories.SETRANGE("Category Code", TTUnits."Weighting Category");
                IF TTWeightLessonCategories.FIND('-') THEN BEGIN
                    //Thin Singles
                    IF TTWeightLessonCategories."Single Classes" = 0 THEN BEGIN
                        TTTimetableCollectorA.RESET;
                        TTTimetableCollectorA.SETRANGE(Programme, ACALecturersUnits.Programme);
                        TTTimetableCollectorA.SETRANGE(Unit, ACALecturersUnits.Unit);
                        TTTimetableCollectorA.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                        TTTimetableCollectorA.SETRANGE(Semester, Rec.Semester);
                        IF TTTimetableCollectorA.FIND('-') THEN TTTimetableCollectorA.DELETEALL;
                    END ELSE
                        IF TTWeightLessonCategories."Single Classes" = 1 THEN BEGIN
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
                            /////////..............................//...................................................................
                            //****************************************************************************************************************************** Delete Collisions on Student Unts
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
                                    // Pick all Units in the Stage for the Programme & Delete in the Lesson and Next Lessons
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
                                            TTTimetableCollectorA1.SETFILTER("Lesson Order", '%1', CurrLessonOrder);
                                            TTTimetableCollectorA1.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                            TTTimetableCollectorA1.SETRANGE(Allocated, FALSE);
                                            IF TTTimetableCollectorA1.FIND('-') THEN TTTimetableCollectorA1.DELETEALL;
                                        END;
                                        UNTIL ACAUnitsSubjects2.NEXT = 0;
                                    END;
                                END;
                                UNTIL ACALecturersUnits2.NEXT = 0;
                            END;
                            //-- Delete all Allocations for the Programme and Units in the selected Stage end
                            //******************************************************************************************************************************
                            //****************************************************************************************************************************** Delete Collisions on Student Unts
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
                                    // Pick all Units in the Stage for the Programme & Delete in the Lesson and Next Lessons
                                    ACAUnitsSubjects2.RESET;
                                    ACAUnitsSubjects2.SETRANGE("Programme Code", ACALecturersUnits2.Programme);
                                    ACAUnitsSubjects2.SETRANGE("Stage Code", ACALecturersUnits2.Stage);
                                    IF ACAUnitsSubjects2.FIND('-') THEN BEGIN
                                        REPEAT
                                        BEGIN
                                            //Delete for 1st Lesson
                                            TTTimetableCollectorDoubles.RESET;
                                            TTTimetableCollectorDoubles.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                            TTTimetableCollectorDoubles.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                            TTTimetableCollectorDoubles.SETRANGE(Semester, Rec.Semester);
                                            TTTimetableCollectorDoubles.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                            TTTimetableCollectorDoubles.SETFILTER("Lesson 1", '%1', CurrLessonOrder);
                                            TTTimetableCollectorDoubles.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                            TTTimetableCollectorDoubles.SETRANGE(Allocated, FALSE);
                                            IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                                            //Delete for 2nd Lesson
                                            TTTimetableCollectorDoubles.RESET;
                                            TTTimetableCollectorDoubles.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                            TTTimetableCollectorDoubles.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                            TTTimetableCollectorDoubles.SETRANGE(Semester, Rec.Semester);
                                            TTTimetableCollectorDoubles.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                            TTTimetableCollectorDoubles.SETFILTER("Lesson 2", '%1', CurrLessonOrder);
                                            TTTimetableCollectorDoubles.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                            TTTimetableCollectorDoubles.SETRANGE(Allocated, FALSE);
                                            IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                                        END;
                                        UNTIL ACAUnitsSubjects2.NEXT = 0;
                                    END;
                                END;
                                UNTIL ACALecturersUnits2.NEXT = 0;
                            END;
                            //-- Delete all Allocations for the Programme and Units in the selected Stage end
                            //******************************************************************************************************************************
                            //****************************************************************************************************************************** Delete Collisions on Student Unts
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
                                    // Pick all Units in the Stage for the Programme & Delete in the Lesson and Next Lessons
                                    ACAUnitsSubjects2.RESET;
                                    ACAUnitsSubjects2.SETRANGE("Programme Code", ACALecturersUnits2.Programme);
                                    ACAUnitsSubjects2.SETRANGE("Stage Code", ACALecturersUnits2.Stage);
                                    IF ACAUnitsSubjects2.FIND('-') THEN BEGIN
                                        REPEAT
                                        BEGIN
                                            //Delete for 1st Lesson
                                            TTTimetableCollectorTripple.RESET;
                                            TTTimetableCollectorTripple.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                            TTTimetableCollectorTripple.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                            TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                            TTTimetableCollectorTripple.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                            TTTimetableCollectorTripple.SETFILTER("Lesson 1", '%1', CurrLessonOrder);
                                            TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                            TTTimetableCollectorTripple.SETRANGE(Allocated, FALSE);
                                            IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                            //Delete for 2nd Lesson
                                            TTTimetableCollectorTripple.RESET;
                                            TTTimetableCollectorTripple.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                            TTTimetableCollectorTripple.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                            TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                            TTTimetableCollectorTripple.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                            TTTimetableCollectorTripple.SETFILTER("Lesson 2", '%1', CurrLessonOrder);
                                            TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                            TTTimetableCollectorTripple.SETRANGE(Allocated, FALSE);
                                            IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                            //Delete for 3rd Lesson
                                            TTTimetableCollectorTripple.RESET;
                                            TTTimetableCollectorTripple.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                            TTTimetableCollectorTripple.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                            TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                            TTTimetableCollectorTripple.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                            TTTimetableCollectorTripple.SETFILTER("Lesson 3", '%1', CurrLessonOrder);
                                            TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                            TTTimetableCollectorTripple.SETRANGE(Allocated, FALSE);
                                            IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                        END;
                                        UNTIL ACAUnitsSubjects2.NEXT = 0;
                                    END;
                                END;
                                UNTIL ACALecturersUnits2.NEXT = 0;
                            END;
                            //-- Delete all Allocations for the Programme and Units in the selected Stage end
                            //******************************************************************************************************************************
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
                            TTTimetableCollectorA1.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
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
                                    TTTimetableCollectorA2.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                    TTTimetableCollectorA2.SETRANGE("Lesson Code", TTTimetableCollectorA."Lesson Code");
                                    TTTimetableCollectorA2.SETRANGE(Semester, Rec.Semester);
                                    TTTimetableCollectorA2.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                                    TTTimetableCollectorA2.SETRANGE(Allocated, FALSE);
                                    IF TTTimetableCollectorA2.FIND('-') THEN BEGIN
                                        TTTimetableCollectorA2.Allocated := TRUE;
                                        TTTimetableCollectorA2.MODIFY;
                                    END;
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
                                //END;
                                UNTIL TTTimetableCollectorA1.NEXT = 0;
                            END;

                            /////////..............................//...................................................................
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
                            TTTimetableCollectorA1.RESET;
                            //TTTimetableCollectorA1.SETRANGE(Programme,ACALecturersUnits.Programme);
                            TTTimetableCollectorA1.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                            TTTimetableCollectorA1.SETRANGE("Lesson Code", TTTimetableCollectorA."Lesson Code");
                            TTTimetableCollectorA1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                            TTTimetableCollectorA1.SETRANGE(Semester, Rec.Semester);
                            TTTimetableCollectorA1.SETRANGE(Allocated, FALSE);
                            IF TTTimetableCollectorA1.FIND('-') THEN TTTimetableCollectorA1.DELETEALL;
                            //Delete fro the Room/Day/Lesson
                            TTTimetableCollectorA1.RESET;
                            // TTTimetableCollectorA1.SETRANGE(Programme,ACALecturersUnits.Programme);
                            TTTimetableCollectorA1.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                            TTTimetableCollectorA1.SETRANGE("Lesson Code", TTTimetableCollectorA."Lesson Code");
                            TTTimetableCollectorA1.SETRANGE("Room Code", TTTimetableCollectorA."Room Code");
                            TTTimetableCollectorA1.SETRANGE(Semester, Rec.Semester);
                            TTTimetableCollectorA1.SETRANGE(Allocated, FALSE);
                            IF TTTimetableCollectorA1.FIND('-') THEN TTTimetableCollectorA1.DELETEALL;
                            //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Doubles for single Lessons
                            TTLessons.RESET;
                            TTLessons.SETRANGE("Lesson Code", TTTimetableCollectorA."Lesson Code");
                            IF TTLessons.FIND('-') THEN BEGIN
                                // Delete from Doubles for Lect/Day/Lesson
                                //For Lesson 1
                                TTTimetableCollectorDoubles.RESET;
                                //TTTimetableCollectorDoubles.SETRANGE("Class Code",ACALecturersUnits.Class);
                                TTTimetableCollectorDoubles.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                TTTimetableCollectorDoubles.SETRANGE("Lesson 1", TTLessons."Lesson Order");
                                TTTimetableCollectorDoubles.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                TTTimetableCollectorDoubles.SETRANGE(Semester, Rec.Semester);
                                IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                                //For Lesson 2
                                TTTimetableCollectorDoubles.RESET;
                                //  TTTimetableCollectorDoubles.SETRANGE("Class Code",ACALecturersUnits.Class);
                                TTTimetableCollectorDoubles.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                TTTimetableCollectorDoubles.SETRANGE("Lesson 2", TTLessons."Lesson Order");
                                TTTimetableCollectorDoubles.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                TTTimetableCollectorDoubles.SETRANGE(Semester, Rec.Semester);
                                IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                                // Delete for the Room/Day/Lesson
                                //For Lesson 1
                                TTTimetableCollectorDoubles.RESET;
                                //TTTimetableCollectorDoubles.SETRANGE(Programme,ACALecturersUnits.Programme);
                                TTTimetableCollectorDoubles.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                TTTimetableCollectorDoubles.SETRANGE("Lesson 1", TTLessons."Lesson Order");
                                TTTimetableCollectorDoubles.SETRANGE("Room Code", TTTimetableCollectorA."Room Code");
                                TTTimetableCollectorDoubles.SETRANGE(Semester, Rec.Semester);
                                IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                                //For Lesson 2
                                TTTimetableCollectorDoubles.RESET;
                                // TTTimetableCollectorDoubles.SETRANGE(Programme,ACALecturersUnits.Programme);
                                TTTimetableCollectorDoubles.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                TTTimetableCollectorDoubles.SETRANGE("Lesson 2", TTLessons."Lesson Order");
                                TTTimetableCollectorDoubles.SETRANGE("Room Code", TTTimetableCollectorA."Room Code");
                                TTTimetableCollectorDoubles.SETRANGE(Semester, Rec.Semester);
                                IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                            END;
                            // Delete for the Lecturer/Day/Campus/Unit in that Campus
                            TTTimetableCollectorDoubles.RESET;
                            // TTTimetableCollectorDoubles.SETRANGE(Programme,ACALecturersUnits.Programme);
                            TTTimetableCollectorDoubles.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                            TTTimetableCollectorDoubles.SETRANGE(Unit, ACALecturersUnits.Unit);
                            TTTimetableCollectorDoubles.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                            TTTimetableCollectorDoubles.SETRANGE(Semester, Rec.Semester);
                            TTTimetableCollectorDoubles.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                            IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                            //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Doubles for single Lessons
                            //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Tripples for single Lessons

                            TTLessons.RESET;
                            TTLessons.SETRANGE("Lesson Code", TTTimetableCollectorA."Lesson Code");
                            IF TTLessons.FIND('-') THEN BEGIN

                                // Delete from Tripples for Lect/Day/Lesson
                                //For Lesson 1
                                TTTimetableCollectorTripple.RESET;
                                // TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                                TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                TTTimetableCollectorTripple.SETRANGE("Lesson 1", TTLessons."Lesson Order");
                                TTTimetableCollectorTripple.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                //For Lesson 2
                                TTTimetableCollectorTripple.RESET;
                                //  TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                                TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                TTTimetableCollectorTripple.SETRANGE("Lesson 2", TTLessons."Lesson Order");
                                TTTimetableCollectorTripple.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                //For Lesson 3
                                TTTimetableCollectorTripple.RESET;
                                // TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                                TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                TTTimetableCollectorTripple.SETRANGE("Lesson 3", TTLessons."Lesson Order");
                                TTTimetableCollectorTripple.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                // Delete for the Room/Day/Lesson
                                //For Lesson 1
                                TTTimetableCollectorTripple.RESET;
                                // TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                                TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                TTTimetableCollectorTripple.SETRANGE("Lesson 1", TTLessons."Lesson Order");
                                TTTimetableCollectorTripple.SETRANGE("Room Code", TTTimetableCollectorA."Room Code");
                                TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                //For Lesson 2
                                TTTimetableCollectorTripple.RESET;
                                //  TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                                TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                TTTimetableCollectorTripple.SETRANGE("Lesson 2", TTLessons."Lesson Order");
                                TTTimetableCollectorTripple.SETRANGE("Room Code", TTTimetableCollectorA."Room Code");
                                TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                //For Lesson 3
                                TTTimetableCollectorTripple.RESET;
                                // TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                                TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                TTTimetableCollectorTripple.SETRANGE("Lesson 3", TTLessons."Lesson Order");
                                TTTimetableCollectorTripple.SETRANGE("Room Code", TTTimetableCollectorA."Room Code");
                                TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                            END;
                            // Delete for the Lecturer/Day/Campus/Unit in that Campus
                            TTTimetableCollectorTripple.RESET;
                            // TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                            TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                            TTTimetableCollectorTripple.SETRANGE(Unit, ACALecturersUnits.Unit);
                            TTTimetableCollectorTripple.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                            TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                            TTTimetableCollectorTripple.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                            IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                            //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Tripples for single Lessons
                            //Delete All Unallocated from The Singles for Lect/Unit/Campus
                            TTTimetableCollectorA1.RESET;
                            TTTimetableCollectorA1.SETRANGE("Class Code", ACALecturersUnits.Class);
                            TTTimetableCollectorA1.SETRANGE(Unit, ACALecturersUnits.Unit);
                            TTTimetableCollectorA1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                            TTTimetableCollectorA1.SETRANGE(Semester, Rec.Semester);
                            TTTimetableCollectorA1.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                            TTTimetableCollectorA1.SETRANGE(Allocated, FALSE);
                            IF TTTimetableCollectorA1.FIND('-') THEN TTTimetableCollectorA1.DELETEALL;
                        END ELSE
                            IF TTWeightLessonCategories."Single Classes" = 2 THEN BEGIN
                                CLEAR(Loops);
                                REPEAT
                                BEGIN
                                    /////////////////////////////////////////////////////////////////////////////////////////////// 2 Singles
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

                                    //****************************************************************************************************************************** Delete Collisions on Student Unts
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
                                            // Pick all Units in the Stage for the Programme & Delete in the Lesson and Next Lessons
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
                                                    TTTimetableCollectorA1.SETFILTER("Lesson Order", '%1', CurrLessonOrder);
                                                    TTTimetableCollectorA1.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                                    TTTimetableCollectorA1.SETRANGE(Allocated, FALSE);
                                                    IF TTTimetableCollectorA1.FIND('-') THEN TTTimetableCollectorA1.DELETEALL;
                                                END;
                                                UNTIL ACAUnitsSubjects2.NEXT = 0;
                                            END;
                                        END;
                                        UNTIL ACALecturersUnits2.NEXT = 0;
                                    END;
                                    //-- Delete all Allocations for the Programme and Units in the selected Stage end
                                    //******************************************************************************************************************************
                                    //****************************************************************************************************************************** Delete Collisions on Student Unts
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
                                            // Pick all Units in the Stage for the Programme & Delete in the Lesson and Next Lessons
                                            ACAUnitsSubjects2.RESET;
                                            ACAUnitsSubjects2.SETRANGE("Programme Code", ACALecturersUnits2.Programme);
                                            ACAUnitsSubjects2.SETRANGE("Stage Code", ACALecturersUnits2.Stage);
                                            IF ACAUnitsSubjects2.FIND('-') THEN BEGIN
                                                REPEAT
                                                BEGIN
                                                    //Delete for 1st Lesson
                                                    TTTimetableCollectorDoubles.RESET;
                                                    TTTimetableCollectorDoubles.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                                    TTTimetableCollectorDoubles.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                                    TTTimetableCollectorDoubles.SETRANGE(Semester, Rec.Semester);
                                                    TTTimetableCollectorDoubles.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                                    TTTimetableCollectorDoubles.SETFILTER("Lesson 1", '%1', CurrLessonOrder);
                                                    TTTimetableCollectorDoubles.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                                    TTTimetableCollectorDoubles.SETRANGE(Allocated, FALSE);
                                                    IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                                                    //Delete for 2nd Lesson
                                                    TTTimetableCollectorDoubles.RESET;
                                                    TTTimetableCollectorDoubles.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                                    TTTimetableCollectorDoubles.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                                    TTTimetableCollectorDoubles.SETRANGE(Semester, Rec.Semester);
                                                    TTTimetableCollectorDoubles.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                                    TTTimetableCollectorDoubles.SETFILTER("Lesson 2", '%1', CurrLessonOrder);
                                                    TTTimetableCollectorDoubles.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                                    TTTimetableCollectorDoubles.SETRANGE(Allocated, FALSE);
                                                    IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                                                END;
                                                UNTIL ACAUnitsSubjects2.NEXT = 0;
                                            END;
                                        END;
                                        UNTIL ACALecturersUnits2.NEXT = 0;
                                    END;
                                    //-- Delete all Allocations for the Programme and Units in the selected Stage end
                                    //******************************************************************************************************************************
                                    //****************************************************************************************************************************** Delete Collisions on Student Unts
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
                                            // Pick all Units in the Stage for the Programme & Delete in the Lesson and Next Lessons
                                            ACAUnitsSubjects2.RESET;
                                            ACAUnitsSubjects2.SETRANGE("Programme Code", ACALecturersUnits2.Programme);
                                            ACAUnitsSubjects2.SETRANGE("Stage Code", ACALecturersUnits2.Stage);
                                            IF ACAUnitsSubjects2.FIND('-') THEN BEGIN
                                                REPEAT
                                                BEGIN
                                                    //Delete for 1st Lesson
                                                    TTTimetableCollectorTripple.RESET;
                                                    TTTimetableCollectorTripple.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                                    TTTimetableCollectorTripple.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                                    TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                                    TTTimetableCollectorTripple.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                                    TTTimetableCollectorTripple.SETFILTER("Lesson 1", '%1', CurrLessonOrder);
                                                    TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                                    TTTimetableCollectorTripple.SETRANGE(Allocated, FALSE);
                                                    IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                                    //Delete for 2nd Lesson
                                                    TTTimetableCollectorTripple.RESET;
                                                    TTTimetableCollectorTripple.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                                    TTTimetableCollectorTripple.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                                    TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                                    TTTimetableCollectorTripple.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                                    TTTimetableCollectorTripple.SETFILTER("Lesson 2", '%1', CurrLessonOrder);
                                                    TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                                    TTTimetableCollectorTripple.SETRANGE(Allocated, FALSE);
                                                    IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                                    //Delete for 3rd Lesson
                                                    TTTimetableCollectorTripple.RESET;
                                                    TTTimetableCollectorTripple.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                                    TTTimetableCollectorTripple.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                                    TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                                    TTTimetableCollectorTripple.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                                    TTTimetableCollectorTripple.SETFILTER("Lesson 3", '%1', CurrLessonOrder);
                                                    TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                                    TTTimetableCollectorTripple.SETRANGE(Allocated, FALSE);
                                                    IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                                END;
                                                UNTIL ACAUnitsSubjects2.NEXT = 0;
                                            END;
                                        END;
                                        UNTIL ACALecturersUnits2.NEXT = 0;
                                    END;
                                    //-- Delete all Allocations for the Programme and Units in the selected Stage end
                                    //******************************************************************************************************************************
                                    //Delete fro the Lecturer in a week

                                    /////////..............................//...................................................................

                                    // Delete the Unit For the Programme in the whole TT
                                    TTTimetableCollectorA1.RESET;
                                    IF Loops = 0 THEN
                                        TTTimetableCollectorA1.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
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
                                    IF Loops = 0 THEN
                                        TTTimetableCollectorA1.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                    TTTimetableCollectorA1.SETRANGE(Unit, ACALecturersUnits.Unit);
                                    TTTimetableCollectorA1.SETRANGE("Room Code", TTTimetableCollectorA."Room Code");
                                    TTTimetableCollectorA1.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
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
                                            IF Loops = 0 THEN
                                                TTTimetableCollectorA2.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                            TTTimetableCollectorA2.SETRANGE(Unit, ACALecturersUnits.Unit);
                                            TTTimetableCollectorA2.SETRANGE("Room Code", TTTimetableCollectorA."Room Code");
                                            TTTimetableCollectorA2.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                            TTTimetableCollectorA2.SETRANGE("Lesson Code", TTTimetableCollectorA."Lesson Code");
                                            TTTimetableCollectorA2.SETRANGE(Semester, Rec.Semester);
                                            TTTimetableCollectorA2.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                                            TTTimetableCollectorA2.SETRANGE(Allocated, FALSE);
                                            IF TTTimetableCollectorA2.FIND('-') THEN BEGIN
                                                TTTimetableCollectorA1.Allocated := TRUE;
                                                TTTimetableCollectorA1.MODIFY;

                                                TTTimetableCollectorA2.RESET;
                                                TTTimetableCollectorA2.SETRANGE(Programme, TTTimetableCollectorA1.Programme);
                                                IF Loops = 0 THEN
                                                    TTTimetableCollectorA2.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
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

                                    /////////..............................//...................................................................
                                    TTTimetableCollectorA1.RESET;
                                    IF Loops = 0 THEN
                                        TTTimetableCollectorA1.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                    TTTimetableCollectorA1.SETRANGE(Programme, ACALecturersUnits.Programme);
                                    TTTimetableCollectorA1.SETRANGE(Unit, ACALecturersUnits.Unit);
                                    TTTimetableCollectorA1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                    TTTimetableCollectorA1.SETRANGE(Semester, Rec.Semester);
                                    TTTimetableCollectorA1.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                                    TTTimetableCollectorA1.SETRANGE(Allocated, FALSE);
                                    IF TTTimetableCollectorA1.FIND('-') THEN TTTimetableCollectorA1.DELETEALL;
                                    //Delete fro the Lecturer/Day/Lesson
                                    TTTimetableCollectorA1.RESET;
                                    //TTTimetableCollectorA1.SETRANGE(Programme,ACALecturersUnits.Programme);
                                    TTTimetableCollectorA1.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                    TTTimetableCollectorA1.SETRANGE("Lesson Code", TTTimetableCollectorA."Lesson Code");
                                    TTTimetableCollectorA1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                    TTTimetableCollectorA1.SETRANGE(Semester, Rec.Semester);
                                    TTTimetableCollectorA1.SETRANGE(Allocated, FALSE);
                                    IF TTTimetableCollectorA1.FIND('-') THEN TTTimetableCollectorA1.DELETEALL;
                                    //Delete fro the Room/Day/Lesson
                                    TTTimetableCollectorA1.RESET;
                                    // TTTimetableCollectorA1.SETRANGE(Programme,ACALecturersUnits.Programme);
                                    TTTimetableCollectorA1.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                    TTTimetableCollectorA1.SETRANGE("Lesson Code", TTTimetableCollectorA."Lesson Code");
                                    TTTimetableCollectorA1.SETRANGE("Room Code", TTTimetableCollectorA."Room Code");
                                    TTTimetableCollectorA1.SETRANGE(Semester, Rec.Semester);
                                    TTTimetableCollectorA1.SETRANGE(Allocated, FALSE);
                                    IF TTTimetableCollectorA1.FIND('-') THEN TTTimetableCollectorA1.DELETEALL;
                                    //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Doubles for single Lessons
                                    TTLessons.RESET;
                                    TTLessons.SETRANGE("Lesson Code", TTTimetableCollectorA."Lesson Code");
                                    IF TTLessons.FIND('-') THEN BEGIN
                                        // Delete from Doubles for Lect/Day/Lesson
                                        //For Lesson 1
                                        TTTimetableCollectorDoubles.RESET;
                                        // TTTimetableCollectorDoubles.SETRANGE(Programme,ACALecturersUnits.Programme);
                                        TTTimetableCollectorDoubles.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                        TTTimetableCollectorDoubles.SETRANGE("Lesson 1", TTLessons."Lesson Order");
                                        TTTimetableCollectorDoubles.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                        TTTimetableCollectorDoubles.SETRANGE(Semester, Rec.Semester);
                                        IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                                        //For Lesson 2
                                        TTTimetableCollectorDoubles.RESET;
                                        //  TTTimetableCollectorDoubles.SETRANGE(Programme,ACALecturersUnits.Programme);
                                        TTTimetableCollectorDoubles.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                        TTTimetableCollectorDoubles.SETRANGE("Lesson 2", TTLessons."Lesson Order");
                                        TTTimetableCollectorDoubles.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                        TTTimetableCollectorDoubles.SETRANGE(Semester, Rec.Semester);
                                        IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                                        // Delete for the Room/Day/Lesson
                                        //For Lesson 1
                                        TTTimetableCollectorDoubles.RESET;
                                        // TTTimetableCollectorDoubles.SETRANGE(Programme,ACALecturersUnits.Programme);
                                        TTTimetableCollectorDoubles.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                        TTTimetableCollectorDoubles.SETRANGE("Lesson 1", TTLessons."Lesson Order");
                                        TTTimetableCollectorDoubles.SETRANGE("Room Code", TTTimetableCollectorA."Room Code");
                                        TTTimetableCollectorDoubles.SETRANGE(Semester, Rec.Semester);
                                        IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                                        //For Lesson 2
                                        TTTimetableCollectorDoubles.RESET;
                                        //  TTTimetableCollectorDoubles.SETRANGE(Programme,ACALecturersUnits.Programme);
                                        TTTimetableCollectorDoubles.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                        TTTimetableCollectorDoubles.SETRANGE("Lesson 2", TTLessons."Lesson Order");
                                        TTTimetableCollectorDoubles.SETRANGE("Room Code", TTTimetableCollectorA."Room Code");
                                        TTTimetableCollectorDoubles.SETRANGE(Semester, Rec.Semester);
                                        IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                                    END;
                                    // Delete for the Lecturer/Day/Campus/Unit in that Campus
                                    TTTimetableCollectorDoubles.RESET;
                                    TTTimetableCollectorDoubles.SETRANGE("Class Code", ACALecturersUnits.Class);
                                    TTTimetableCollectorDoubles.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                    TTTimetableCollectorDoubles.SETRANGE(Unit, ACALecturersUnits.Unit);
                                    TTTimetableCollectorDoubles.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                    TTTimetableCollectorDoubles.SETRANGE(Semester, Rec.Semester);
                                    TTTimetableCollectorDoubles.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                                    IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                                    //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Doubles for single Lessons
                                    //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Tripples for single Lessons

                                    TTLessons.RESET;
                                    TTLessons.SETRANGE("Lesson Code", TTTimetableCollectorA."Lesson Code");
                                    IF TTLessons.FIND('-') THEN BEGIN
                                        // Delete from Tripples for Lect/Day/Lesson
                                        //For Lesson 1
                                        TTTimetableCollectorTripple.RESET;
                                        // TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                                        TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                        TTTimetableCollectorTripple.SETRANGE("Lesson 1", TTLessons."Lesson Order");
                                        TTTimetableCollectorTripple.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                        TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                        //For Lesson 2
                                        TTTimetableCollectorTripple.RESET;
                                        //  TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                                        TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                        TTTimetableCollectorTripple.SETRANGE("Lesson 2", TTLessons."Lesson Order");
                                        TTTimetableCollectorTripple.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                        TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                        //For Lesson 3
                                        TTTimetableCollectorTripple.RESET;
                                        // TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                                        TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                        TTTimetableCollectorTripple.SETRANGE("Lesson 3", TTLessons."Lesson Order");
                                        TTTimetableCollectorTripple.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                        TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                        // Delete for the Room/Day/Lesson
                                        //For Lesson 1
                                        TTTimetableCollectorTripple.RESET;
                                        //  TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                                        TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                        TTTimetableCollectorTripple.SETRANGE("Lesson 1", TTLessons."Lesson Order");
                                        TTTimetableCollectorTripple.SETRANGE("Room Code", TTTimetableCollectorA."Room Code");
                                        TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                        //For Lesson 2
                                        TTTimetableCollectorTripple.RESET;
                                        //  TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                                        TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                        TTTimetableCollectorTripple.SETRANGE("Lesson 2", TTLessons."Lesson Order");
                                        TTTimetableCollectorTripple.SETRANGE("Room Code", TTTimetableCollectorA."Room Code");
                                        TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                        //For Lesson 3
                                        TTTimetableCollectorTripple.RESET;
                                        // TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                                        TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                        TTTimetableCollectorTripple.SETRANGE("Lesson 3", TTLessons."Lesson Order");
                                        TTTimetableCollectorTripple.SETRANGE("Room Code", TTTimetableCollectorA."Room Code");
                                        TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                    END;
                                    // Delete for the Lecturer/Day/Campus/Unit in that Campus
                                    TTTimetableCollectorTripple.RESET;
                                    TTTimetableCollectorTripple.SETRANGE("Class Code", ACALecturersUnits.Class);
                                    TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                    TTTimetableCollectorTripple.SETRANGE(Unit, ACALecturersUnits.Unit);
                                    TTTimetableCollectorTripple.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                    TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                    TTTimetableCollectorTripple.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                                    IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                    //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Tripples for single Lessons
                                    //Delete All Unallocated from The Singles for Lect/Unit/Campus
                                    TTTimetableCollectorA1.RESET;
                                    IF Loops = 0 THEN
                                        TTTimetableCollectorA1.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                    TTTimetableCollectorA1.SETRANGE("Class Code", ACALecturersUnits.Class);
                                    TTTimetableCollectorA1.SETRANGE(Unit, ACALecturersUnits.Unit);
                                    TTTimetableCollectorA1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                    TTTimetableCollectorA1.SETRANGE(Semester, Rec.Semester);
                                    TTTimetableCollectorA1.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                                    TTTimetableCollectorA1.SETRANGE(Allocated, FALSE);
                                    IF TTTimetableCollectorA1.FIND('-') THEN TTTimetableCollectorA1.DELETEALL;
                                    /////////////////////////////////////////////////////////////////////////////////////////////// 2 Singles
                                    Loops := Loops + 1;
                                END;
                                UNTIL Loops = 2;
                            END ELSE
                                IF TTWeightLessonCategories."Single Classes" = 3 THEN BEGIN
                                    CLEAR(Loops);
                                    REPEAT
                                    BEGIN
                                        /////////////////////////////////////////////////////////////////////////////////////////////// 3 Singles
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
                                        //****************************************************************************************************************************** Delete Collisions on Student Unts
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
                                                // Pick all Units in the Stage for the Programme & Delete in the Lesson and Next Lessons
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
                                                        TTTimetableCollectorA1.SETFILTER("Lesson Order", '%1', CurrLessonOrder);
                                                        TTTimetableCollectorA1.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                                        TTTimetableCollectorA1.SETRANGE(Allocated, FALSE);
                                                        IF TTTimetableCollectorA1.FIND('-') THEN TTTimetableCollectorA1.DELETEALL;
                                                    END;
                                                    UNTIL ACAUnitsSubjects2.NEXT = 0;
                                                END;
                                            END;
                                            UNTIL ACALecturersUnits2.NEXT = 0;
                                        END;
                                        //-- Delete all Allocations for the Programme and Units in the selected Stage end
                                        //******************************************************************************************************************************
                                        //****************************************************************************************************************************** Delete Collisions on Student Unts
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
                                                // Pick all Units in the Stage for the Programme & Delete in the Lesson and Next Lessons
                                                ACAUnitsSubjects2.RESET;
                                                ACAUnitsSubjects2.SETRANGE("Programme Code", ACALecturersUnits2.Programme);
                                                ACAUnitsSubjects2.SETRANGE("Stage Code", ACALecturersUnits2.Stage);
                                                IF ACAUnitsSubjects2.FIND('-') THEN BEGIN
                                                    REPEAT
                                                    BEGIN
                                                        //Delete for 1st Lesson
                                                        TTTimetableCollectorDoubles.RESET;
                                                        TTTimetableCollectorDoubles.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                                        TTTimetableCollectorDoubles.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                                        TTTimetableCollectorDoubles.SETRANGE(Semester, Rec.Semester);
                                                        TTTimetableCollectorDoubles.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                                        TTTimetableCollectorDoubles.SETFILTER("Lesson 1", '%1', CurrLessonOrder);
                                                        TTTimetableCollectorDoubles.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                                        TTTimetableCollectorDoubles.SETRANGE(Allocated, FALSE);
                                                        IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                                                        //Delete for 2nd Lesson
                                                        TTTimetableCollectorDoubles.RESET;
                                                        TTTimetableCollectorDoubles.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                                        TTTimetableCollectorDoubles.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                                        TTTimetableCollectorDoubles.SETRANGE(Semester, Rec.Semester);
                                                        TTTimetableCollectorDoubles.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                                        TTTimetableCollectorDoubles.SETFILTER("Lesson 2", '%1', CurrLessonOrder);
                                                        TTTimetableCollectorDoubles.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                                        TTTimetableCollectorDoubles.SETRANGE(Allocated, FALSE);
                                                        IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                                                    END;
                                                    UNTIL ACAUnitsSubjects2.NEXT = 0;
                                                END;
                                            END;
                                            UNTIL ACALecturersUnits2.NEXT = 0;
                                        END;
                                        //-- Delete all Allocations for the Programme and Units in the selected Stage end
                                        //******************************************************************************************************************************
                                        //****************************************************************************************************************************** Delete Collisions on Student Unts
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
                                                // Pick all Units in the Stage for the Programme & Delete in the Lesson and Next Lessons
                                                ACAUnitsSubjects2.RESET;
                                                ACAUnitsSubjects2.SETRANGE("Programme Code", ACALecturersUnits2.Programme);
                                                ACAUnitsSubjects2.SETRANGE("Stage Code", ACALecturersUnits2.Stage);
                                                IF ACAUnitsSubjects2.FIND('-') THEN BEGIN
                                                    REPEAT
                                                    BEGIN
                                                        //Delete for 1st Lesson
                                                        TTTimetableCollectorTripple.RESET;
                                                        TTTimetableCollectorTripple.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                                        TTTimetableCollectorTripple.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                                        TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                                        TTTimetableCollectorTripple.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                                        TTTimetableCollectorTripple.SETFILTER("Lesson 1", '%1', CurrLessonOrder);
                                                        TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                                        TTTimetableCollectorTripple.SETRANGE(Allocated, FALSE);
                                                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                                        //Delete for 2nd Lesson
                                                        TTTimetableCollectorTripple.RESET;
                                                        TTTimetableCollectorTripple.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                                        TTTimetableCollectorTripple.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                                        TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                                        TTTimetableCollectorTripple.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                                        TTTimetableCollectorTripple.SETFILTER("Lesson 2", '%1', CurrLessonOrder);
                                                        TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                                        TTTimetableCollectorTripple.SETRANGE(Allocated, FALSE);
                                                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                                        //Delete for 3rd Lesson
                                                        TTTimetableCollectorTripple.RESET;
                                                        TTTimetableCollectorTripple.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                                        TTTimetableCollectorTripple.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                                        TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                                        TTTimetableCollectorTripple.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                                        TTTimetableCollectorTripple.SETFILTER("Lesson 3", '%1', CurrLessonOrder);
                                                        TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                                        TTTimetableCollectorTripple.SETRANGE(Allocated, FALSE);
                                                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                                    END;
                                                    UNTIL ACAUnitsSubjects2.NEXT = 0;
                                                END;
                                            END;
                                            UNTIL ACALecturersUnits2.NEXT = 0;
                                        END;
                                        //-- Delete all Allocations for the Programme and Units in the selected Stage end
                                        //******************************************************************************************************************************
                                        //Delete fro the Lecturer in a week
                                        TTTimetableCollectorA1.RESET;
                                        IF ((Loops = 0) OR (Loops = 1)) THEN
                                            TTTimetableCollectorA1.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                        TTTimetableCollectorA1.SETRANGE("Class Code", ACALecturersUnits.Class);
                                        TTTimetableCollectorA1.SETRANGE(Unit, ACALecturersUnits.Unit);
                                        TTTimetableCollectorA1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                        TTTimetableCollectorA1.SETRANGE(Semester, Rec.Semester);
                                        TTTimetableCollectorA1.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                                        TTTimetableCollectorA1.SETRANGE(Allocated, FALSE);
                                        IF TTTimetableCollectorA1.FIND('-') THEN TTTimetableCollectorA1.DELETEALL;
                                        //Delete fro the Lecturer/Day/Lesson
                                        TTTimetableCollectorA1.RESET;
                                        //  TTTimetableCollectorA1.SETRANGE(Programme,ACALecturersUnits.Programme);
                                        TTTimetableCollectorA1.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                        TTTimetableCollectorA1.SETRANGE("Lesson Code", TTTimetableCollectorA."Lesson Code");
                                        TTTimetableCollectorA1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                        TTTimetableCollectorA1.SETRANGE(Semester, Rec.Semester);
                                        TTTimetableCollectorA1.SETRANGE(Allocated, FALSE);
                                        IF TTTimetableCollectorA1.FIND('-') THEN TTTimetableCollectorA1.DELETEALL;
                                        //Delete fro the Room/Day/Lesson
                                        TTTimetableCollectorA1.RESET;
                                        // TTTimetableCollectorA1.SETRANGE(Programme,ACALecturersUnits.Programme);
                                        TTTimetableCollectorA1.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                        TTTimetableCollectorA1.SETRANGE("Lesson Code", TTTimetableCollectorA."Lesson Code");
                                        TTTimetableCollectorA1.SETRANGE("Room Code", TTTimetableCollectorA."Room Code");
                                        TTTimetableCollectorA1.SETRANGE(Semester, Rec.Semester);
                                        TTTimetableCollectorA1.SETRANGE(Allocated, FALSE);
                                        IF TTTimetableCollectorA1.FIND('-') THEN TTTimetableCollectorA1.DELETEALL;
                                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Doubles for single Lessons
                                        TTLessons.RESET;
                                        TTLessons.SETRANGE("Lesson Code", TTTimetableCollectorA."Lesson Code");
                                        IF TTLessons.FIND('-') THEN BEGIN
                                            // Delete from Doubles for Lect/Day/Lesson
                                            //For Lesson 1
                                            TTTimetableCollectorDoubles.RESET;
                                            // TTTimetableCollectorDoubles.SETRANGE(Programme,ACALecturersUnits.Programme);
                                            TTTimetableCollectorDoubles.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                            TTTimetableCollectorDoubles.SETRANGE("Lesson 1", TTLessons."Lesson Order");
                                            TTTimetableCollectorDoubles.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                            TTTimetableCollectorDoubles.SETRANGE(Semester, Rec.Semester);
                                            IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                                            //For Lesson 2
                                            TTTimetableCollectorDoubles.RESET;
                                            //  TTTimetableCollectorDoubles.SETRANGE(Programme,ACALecturersUnits.Programme);
                                            TTTimetableCollectorDoubles.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                            TTTimetableCollectorDoubles.SETRANGE("Lesson 2", TTLessons."Lesson Order");
                                            TTTimetableCollectorDoubles.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                            TTTimetableCollectorDoubles.SETRANGE(Semester, Rec.Semester);
                                            IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                                            // Delete for the Room/Day/Lesson
                                            //For Lesson 1
                                            TTTimetableCollectorDoubles.RESET;
                                            //  TTTimetableCollectorDoubles.SETRANGE(Programme,ACALecturersUnits.Programme);
                                            TTTimetableCollectorDoubles.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                            TTTimetableCollectorDoubles.SETRANGE("Lesson 1", TTLessons."Lesson Order");
                                            TTTimetableCollectorDoubles.SETRANGE("Room Code", TTTimetableCollectorA."Room Code");
                                            TTTimetableCollectorDoubles.SETRANGE(Semester, Rec.Semester);
                                            IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                                            //For Lesson 2
                                            TTTimetableCollectorDoubles.RESET;
                                            // TTTimetableCollectorDoubles.SETRANGE(Programme,ACALecturersUnits.Programme);
                                            TTTimetableCollectorDoubles.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                            TTTimetableCollectorDoubles.SETRANGE("Lesson 2", TTLessons."Lesson Order");
                                            TTTimetableCollectorDoubles.SETRANGE("Room Code", TTTimetableCollectorA."Room Code");
                                            TTTimetableCollectorDoubles.SETRANGE(Semester, Rec.Semester);
                                            IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                                        END;
                                        // Delete for the Lecturer/Day/Campus/Unit in that Campus
                                        TTTimetableCollectorDoubles.RESET;
                                        //  TTTimetableCollectorDoubles.SETRANGE(Programme,ACALecturersUnits.Programme);
                                        TTTimetableCollectorDoubles.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                        TTTimetableCollectorDoubles.SETRANGE(Unit, ACALecturersUnits.Unit);
                                        TTTimetableCollectorDoubles.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                        TTTimetableCollectorDoubles.SETRANGE(Semester, Rec.Semester);
                                        TTTimetableCollectorDoubles.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                                        IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Doubles for single Lessons
                                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Tripples for single Lessons

                                        TTLessons.RESET;
                                        TTLessons.SETRANGE("Lesson Code", TTTimetableCollectorA."Lesson Code");
                                        IF TTLessons.FIND('-') THEN BEGIN
                                            // Delete from Tripples for Lect/Day/Lesson
                                            //For Lesson 1
                                            TTTimetableCollectorTripple.RESET;
                                            // TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                                            TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                            TTTimetableCollectorTripple.SETRANGE("Lesson 1", TTLessons."Lesson Order");
                                            TTTimetableCollectorTripple.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                            TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                            IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                            //For Lesson 2
                                            TTTimetableCollectorTripple.RESET;
                                            //  TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                                            TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                            TTTimetableCollectorTripple.SETRANGE("Lesson 2", TTLessons."Lesson Order");
                                            TTTimetableCollectorTripple.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                            TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                            IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                            //For Lesson 3
                                            TTTimetableCollectorTripple.RESET;
                                            //  TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                                            TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                            TTTimetableCollectorTripple.SETRANGE("Lesson 3", TTLessons."Lesson Order");
                                            TTTimetableCollectorTripple.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                            TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                            IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                            // Delete for the Room/Day/Lesson
                                            //For Lesson 1
                                            TTTimetableCollectorTripple.RESET;
                                            // TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                                            TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                            TTTimetableCollectorTripple.SETRANGE("Lesson 1", TTLessons."Lesson Order");
                                            TTTimetableCollectorTripple.SETRANGE("Room Code", TTTimetableCollectorA."Room Code");
                                            TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                            IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                            //For Lesson 2
                                            TTTimetableCollectorTripple.RESET;
                                            // TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                                            TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                            TTTimetableCollectorTripple.SETRANGE("Lesson 2", TTLessons."Lesson Order");
                                            TTTimetableCollectorTripple.SETRANGE("Room Code", TTTimetableCollectorA."Room Code");
                                            TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                            IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                            //For Lesson 3
                                            TTTimetableCollectorTripple.RESET;
                                            // TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                                            TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                            TTTimetableCollectorTripple.SETRANGE("Lesson 3", TTLessons."Lesson Order");
                                            TTTimetableCollectorTripple.SETRANGE("Room Code", TTTimetableCollectorA."Room Code");
                                            TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                            IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                        END;
                                        // Delete for the Lecturer/Day/Campus/Unit in that Campus
                                        TTTimetableCollectorTripple.RESET;
                                        TTTimetableCollectorTripple.SETRANGE("Class Code", ACALecturersUnits.Class);
                                        TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                        TTTimetableCollectorTripple.SETRANGE(Unit, ACALecturersUnits.Unit);
                                        TTTimetableCollectorTripple.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                        TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                        TTTimetableCollectorTripple.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Tripples for single Lessons
                                        //Delete All Unallocated from The Singles for Lect/Unit/Campus
                                        TTTimetableCollectorA1.RESET;
                                        IF ((Loops = 0) OR (Loops = 1)) THEN
                                            TTTimetableCollectorA1.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
                                        TTTimetableCollectorA1.SETRANGE("Class Code", ACALecturersUnits.Class);
                                        TTTimetableCollectorA1.SETRANGE(Unit, ACALecturersUnits.Unit);
                                        TTTimetableCollectorA1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                        TTTimetableCollectorA1.SETRANGE(Semester, Rec.Semester);
                                        TTTimetableCollectorA1.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                                        TTTimetableCollectorA1.SETRANGE(Allocated, FALSE);
                                        IF TTTimetableCollectorA1.FIND('-') THEN TTTimetableCollectorA1.DELETEALL;
                                        /////////////////////////////////////////////////////////////////////////////////////////////// 3 Singles
                                        Loops := Loops + 1;
                                    END;
                                    UNTIL Loops = 3;
                                END;

                END;
            END;
            UNTIL ACALecturersUnits.NEXT = 0;
        END;
        progre.CLOSE;
    end;

    local procedure ThiningDoubles()
    var
        TTRooms: Record "TT-Rooms";
        TTDailyLessons: Record 74503;
        ACALecturersUnits: Record "ACA-Lecturers Units";
        ACALecturersUnits2: Record "ACA-Lecturers Units";
        LectLoadBatchLines: Record 65201;
        ACAProgramme: Record 61511;
        ACAUnitsSubjects: Record 61517;
        ACAUnitsSubjects2: Record 61517;
        TTUnits: Record "TT-Units";
        TTLessons: Record 74520;
        TTDays: Record 74502;
        TTLessons1: Record 74520;
        TTLessons2: Record 74520;
        TTLessons3: Record 74520;
        TTWeightLessonCategories: Record "TT-Weight Lesson Categories";
        TTTimetableCollectorA: Record 74500;
        TTTimetableCollectorA1: Record 74500;
        TTTimetableCollectorA2: Record 74500;
        TTTimetableCollectorA3: Record 74500;
        TTTimetableCollectorDoubles: Record 74521;
        TTTimetableCollectorDoubles1: Record 74521;
        TTTimetableCollectorDoubles2: Record 74521;
        TTTimetableCollectorTripple: Record 74522;
        TTTimetableCollectorTripple1: Record 74522;
        TTTimetableCollectorTripple2: Record 74522;
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
        //prempTrns: Record 61091;
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
        progre.OPEN('Building Timetable for Doubles:  #1#############################' +
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
                BufferString := 'Total Tripples processed = ' + FORMAT(counts);

                progre.UPDATE();
                //SLEEP(50);
                ///////////////////////////////////////////////////////////////////////////////Progress Update
                TTUnits.RESET;
                TTUnits.SETRANGE(Semester, Rec.Semester);
                TTUnits.SETRANGE("Programme Code", ACALecturersUnits.Programme);
                TTUnits.SETRANGE("Unit Code", ACALecturersUnits.Unit);
                IF TTUnits.FIND('-') THEN;
                TTWeightLessonCategories.RESET;
                TTWeightLessonCategories.SETRANGE(Semester, Rec.Semester);
                TTWeightLessonCategories.SETRANGE("Category Code", TTUnits."Weighting Category");
                IF TTWeightLessonCategories.FIND('-') THEN BEGIN
                    //Thin Doubles
                    IF TTWeightLessonCategories."Double Classes" = 0 THEN BEGIN
                        TTTimetableCollectorDoubles.RESET;
                        TTTimetableCollectorDoubles.SETRANGE(Programme, ACALecturersUnits.Programme);
                        TTTimetableCollectorDoubles.SETRANGE(Unit, ACALecturersUnits.Unit);
                        TTTimetableCollectorDoubles.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                        TTTimetableCollectorDoubles.SETRANGE(Semester, Rec.Semester);
                        IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                    END ELSE
                        IF TTWeightLessonCategories."Double Classes" = 1 THEN BEGIN
                            TTTimetableCollectorDoubles.RESET;
                            TTTimetableCollectorDoubles.SETRANGE("Class Code", ACALecturersUnits.Class);
                            TTTimetableCollectorDoubles.SETRANGE(Unit, ACALecturersUnits.Unit);
                            TTTimetableCollectorDoubles.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                            TTTimetableCollectorDoubles.SETRANGE(Semester, Rec.Semester);
                            TTTimetableCollectorDoubles.SETRANGE(Allocated, FALSE);
                            TTTimetableCollectorDoubles.SETCURRENTKEY("Day Order", "Lesson 1", "Lesson 2", "Programme Campus Priority", "Programme Room Priority",
                            "Programme Day Priority", "Lecturer Campus Priority", "Lecturer Day Priority", "Lecturer Lesson Priority", "Unit Campus Priority", "Unit Room Priority");
                            IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
                                TTTimetableCollectorDoubles.Allocated := TRUE;
                                TTTimetableCollectorDoubles.MODIFY;
                            END;


                            //****************************************************************************************************************************** Delete Collisions on Student Unts
                            //-- Delete all Allocations for the Programme and Units in the selected Stage Begin
                            // -Select all Stages and Programmes for the Lecturer and Unit and Class Before Picking Units for the Stage to clear for the given
                            // Lesson and Next
                            ACALecturersUnits2.RESET;
                            ACALecturersUnits2.SETRANGE(Semester, Rec.Semester);
                            ACALecturersUnits2.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                            ACALecturersUnits2.SETRANGE(Class, ACALecturersUnits.Class);
                            ACALecturersUnits2.SETRANGE(Unit, ACALecturersUnits.Unit);
                            IF ACALecturersUnits2.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    // Pick all Units in the Stage for the Programme & Delete in the Lesson and Next Lessons
                                    ACAUnitsSubjects2.RESET;
                                    ACAUnitsSubjects2.SETRANGE("Programme Code", ACALecturersUnits2.Programme);
                                    ACAUnitsSubjects2.SETRANGE("Stage Code", ACALecturersUnits2.Stage);
                                    IF ACAUnitsSubjects2.FIND('-') THEN BEGIN
                                        REPEAT
                                        BEGIN
                                            //Delete for 1st Lesson
                                            TTTimetableCollectorDoubles1.RESET;
                                            TTTimetableCollectorDoubles1.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                            TTTimetableCollectorDoubles1.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                            TTTimetableCollectorDoubles1.SETRANGE(Semester, Rec.Semester);
                                            TTTimetableCollectorDoubles1.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                            TTTimetableCollectorDoubles1.SETFILTER("Lesson 1", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                            TTTimetableCollectorDoubles1.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                            TTTimetableCollectorDoubles1.SETRANGE(Allocated, FALSE);
                                            IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                                            //Delete for 2nd Lesson
                                            TTTimetableCollectorDoubles1.RESET;
                                            TTTimetableCollectorDoubles1.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                            TTTimetableCollectorDoubles1.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                            TTTimetableCollectorDoubles1.SETRANGE(Semester, Rec.Semester);
                                            TTTimetableCollectorDoubles1.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                            TTTimetableCollectorDoubles1.SETFILTER("Lesson 2", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                            TTTimetableCollectorDoubles1.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                            TTTimetableCollectorDoubles1.SETRANGE(Allocated, FALSE);
                                            IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                                        END;
                                        UNTIL ACAUnitsSubjects2.NEXT = 0;
                                    END;
                                END;
                                UNTIL ACALecturersUnits2.NEXT = 0;
                            END;
                            //-- Delete all Allocations for the Programme and Units in the selected Stage end
                            //******************************************************************************************************************************
                            //****************************************************************************************************************************** Delete Collisions on Student Unts
                            //-- Delete all Allocations for the Programme and Units in the selected Stage Begin
                            // -Select all Stages and Programmes for the Lecturer and Unit and Class Before Picking Units for the Stage to clear for the given
                            // Lesson and Next
                            ACALecturersUnits2.RESET;
                            ACALecturersUnits2.SETRANGE(Semester, Rec.Semester);
                            ACALecturersUnits2.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                            ACALecturersUnits2.SETRANGE(Class, ACALecturersUnits.Class);
                            ACALecturersUnits2.SETRANGE(Unit, ACALecturersUnits.Unit);
                            IF ACALecturersUnits2.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    // Pick all Units in the Stage for the Programme & Delete in the Lesson and Next Lessons
                                    ACAUnitsSubjects2.RESET;
                                    ACAUnitsSubjects2.SETRANGE("Programme Code", ACALecturersUnits2.Programme);
                                    ACAUnitsSubjects2.SETRANGE("Stage Code", ACALecturersUnits2.Stage);
                                    IF ACAUnitsSubjects2.FIND('-') THEN BEGIN
                                        REPEAT
                                        BEGIN
                                            //Delete for 1st Lesson
                                            TTTimetableCollectorTripple.RESET;
                                            TTTimetableCollectorTripple.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                            TTTimetableCollectorTripple.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                            TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                            TTTimetableCollectorTripple.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                            TTTimetableCollectorTripple.SETFILTER("Lesson 1", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                            TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                            TTTimetableCollectorTripple.SETRANGE(Allocated, FALSE);
                                            IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                            //Delete for 2nd Lesson
                                            TTTimetableCollectorTripple.RESET;
                                            TTTimetableCollectorTripple.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                            TTTimetableCollectorTripple.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                            TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                            TTTimetableCollectorTripple.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                            TTTimetableCollectorTripple.SETFILTER("Lesson 2", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                            TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                            TTTimetableCollectorTripple.SETRANGE(Allocated, FALSE);
                                            IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                            //Delete for 3rd Lesson
                                            TTTimetableCollectorTripple.RESET;
                                            TTTimetableCollectorTripple.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                            TTTimetableCollectorTripple.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                            TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                            TTTimetableCollectorTripple.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                            TTTimetableCollectorTripple.SETFILTER("Lesson 3", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                            TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                            TTTimetableCollectorTripple.SETRANGE(Allocated, FALSE);
                                            IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                        END;
                                        UNTIL ACAUnitsSubjects2.NEXT = 0;
                                    END;
                                END;
                                UNTIL ACALecturersUnits2.NEXT = 0;
                            END;
                            //-- Delete all Allocations for the Programme and Units in the selected Stage end
                            //******************************************************************************************************************************
                            /////////..............................//...................................................................

                            // Delete the Unit For the Programme in the whole TT
                            TTTimetableCollectorDoubles1.RESET;
                            TTTimetableCollectorDoubles1.SETRANGE(Programme, ACALecturersUnits.Programme);
                            TTTimetableCollectorDoubles1.SETRANGE(Unit, ACALecturersUnits.Unit);
                            TTTimetableCollectorDoubles1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                            TTTimetableCollectorDoubles1.SETRANGE(Semester, Rec.Semester);
                            TTTimetableCollectorDoubles1.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                            TTTimetableCollectorDoubles1.SETRANGE(Allocated, FALSE);
                            IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                            // Capture Timetable for the same Class and Unit

                            TTTimetableCollectorDoubles1.RESET;
                            TTTimetableCollectorDoubles1.SETRANGE("Class Code", ACALecturersUnits.Class);
                            TTTimetableCollectorDoubles1.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                            TTTimetableCollectorDoubles1.SETRANGE(Unit, ACALecturersUnits.Unit);
                            TTTimetableCollectorDoubles1.SETRANGE("Room Code", TTTimetableCollectorDoubles."Room Code");
                            //TTTimetableCollectorDoubles1.SETRANGE("Date Code",TTTimetableCollectorDoubles."Date Code");
                            TTTimetableCollectorDoubles1.SETRANGE("Lesson 1", TTTimetableCollectorDoubles."Lesson 1");
                            TTTimetableCollectorDoubles1.SETRANGE("Lesson 2", TTTimetableCollectorDoubles."Lesson 2");
                            TTTimetableCollectorDoubles1.SETRANGE(Semester, Rec.Semester);
                            TTTimetableCollectorDoubles1.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                            TTTimetableCollectorDoubles1.SETRANGE(Allocated, FALSE);
                            IF TTTimetableCollectorDoubles1.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    ///......................................//..................................................
                                    TTTimetableCollectorDoubles2.RESET;
                                    TTTimetableCollectorDoubles2.SETRANGE("Class Code", ACALecturersUnits.Class);
                                    TTTimetableCollectorDoubles2.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                    TTTimetableCollectorDoubles2.SETRANGE(Unit, ACALecturersUnits.Unit);
                                    TTTimetableCollectorDoubles2.SETRANGE("Room Code", TTTimetableCollectorDoubles."Room Code");
                                    // TTTimetableCollectorDoubles2.SETRANGE("Date Code",TTTimetableCollectorDoubles."Date Code");
                                    TTTimetableCollectorDoubles2.SETRANGE("Lesson 1", TTTimetableCollectorDoubles."Lesson 1");
                                    TTTimetableCollectorDoubles2.SETRANGE("Lesson 2", TTTimetableCollectorDoubles."Lesson 2");
                                    TTTimetableCollectorDoubles2.SETRANGE(Semester, Rec.Semester);
                                    TTTimetableCollectorDoubles2.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                                    TTTimetableCollectorDoubles2.SETRANGE(Allocated, FALSE);
                                    IF TTTimetableCollectorDoubles2.FIND('-') THEN BEGIN
                                        TTTimetableCollectorDoubles1.Allocated := TRUE;
                                        TTTimetableCollectorDoubles1.MODIFY;

                                        TTTimetableCollectorDoubles2.RESET;
                                        TTTimetableCollectorDoubles2.SETRANGE(Programme, TTTimetableCollectorDoubles1.Programme);
                                        TTTimetableCollectorDoubles2.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                        TTTimetableCollectorDoubles2.SETRANGE(Unit, ACALecturersUnits.Unit);
                                        TTTimetableCollectorDoubles2.SETRANGE(Lecturer, TTTimetableCollectorDoubles1.Lecturer);
                                        TTTimetableCollectorDoubles2.SETRANGE(Semester, Rec.Semester);
                                        TTTimetableCollectorDoubles2.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                                        TTTimetableCollectorDoubles2.SETRANGE(Allocated, FALSE);
                                        IF TTTimetableCollectorDoubles2.FIND('-') THEN TTTimetableCollectorDoubles2.DELETEALL;
                                    END;
                                    ///..........................................//.......................................
                                END;
                                UNTIL TTTimetableCollectorDoubles1.NEXT = 0;
                            END;

                            /////////..............................//...................................................................
                            //Delete fro the Lecturer in a week
                            TTTimetableCollectorDoubles1.RESET;
                            TTTimetableCollectorDoubles1.SETRANGE("Class Code", ACALecturersUnits.Class);
                            TTTimetableCollectorDoubles1.SETRANGE(Unit, ACALecturersUnits.Unit);
                            TTTimetableCollectorDoubles1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                            TTTimetableCollectorDoubles1.SETRANGE(Semester, Rec.Semester);
                            TTTimetableCollectorDoubles1.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                            TTTimetableCollectorDoubles1.SETRANGE(Allocated, FALSE);
                            IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                            //Delete fro the Lecturer/Day/Lesson
                            // // //
                            //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Doubles for Double Lessons
                            // // // // // // // // //                        TTLessons.RESET;
                            // // // // // // // // //                        TTLessons.SETRANGE("Lesson Code",TTTimetableCollectorA."Lesson Code");
                            // // // // // // // // //                        IF TTLessons.FIND('-') THEN BEGIN
                            // Delete from Doubles for Lect/Day/Lesson
                            //For Lesson 1
                            TTTimetableCollectorDoubles1.RESET;
                            // TTTimetableCollectorDoubles1.SETRANGE(Programme,ACALecturersUnits.Programme);
                            TTTimetableCollectorDoubles1.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                            TTTimetableCollectorDoubles1.SETFILTER("Lesson 1", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                            TTTimetableCollectorDoubles1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                            TTTimetableCollectorDoubles1.SETRANGE(Semester, Rec.Semester);
                            TTTimetableCollectorDoubles1.SETRANGE(Allocated, FALSE);
                            IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                            //For Lesson 2
                            TTTimetableCollectorDoubles1.RESET;
                            //  TTTimetableCollectorDoubles1.SETRANGE(Programme,ACALecturersUnits.Programme);
                            TTTimetableCollectorDoubles1.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                            TTTimetableCollectorDoubles1.SETRANGE("Lesson 2", TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                            TTTimetableCollectorDoubles1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                            TTTimetableCollectorDoubles1.SETRANGE(Semester, Rec.Semester);
                            TTTimetableCollectorDoubles1.SETRANGE(Allocated, FALSE);
                            IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                            // Delete for the Room/Day/Lesson
                            //For Lesson 1
                            TTTimetableCollectorDoubles1.RESET;
                            //  TTTimetableCollectorDoubles1.SETRANGE(Programme,ACALecturersUnits.Programme);
                            TTTimetableCollectorDoubles1.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                            TTTimetableCollectorDoubles1.SETFILTER("Lesson 1", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                            TTTimetableCollectorDoubles1.SETRANGE("Room Code", TTTimetableCollectorDoubles."Room Code");
                            TTTimetableCollectorDoubles1.SETRANGE(Semester, Rec.Semester);
                            TTTimetableCollectorDoubles1.SETRANGE(Allocated, FALSE);
                            IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                            //For Lesson 2
                            TTTimetableCollectorDoubles1.RESET;
                            // TTTimetableCollectorDoubles1.SETRANGE(Programme,ACALecturersUnits.Programme);
                            TTTimetableCollectorDoubles1.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                            TTTimetableCollectorDoubles1.SETFILTER("Lesson 2", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                            TTTimetableCollectorDoubles1.SETRANGE("Room Code", TTTimetableCollectorDoubles."Room Code");
                            TTTimetableCollectorDoubles1.SETRANGE(Semester, Rec.Semester);
                            TTTimetableCollectorDoubles1.SETRANGE(Allocated, FALSE);
                            IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                            //       END;
                            // Delete for the Lecturer/Day/Campus/Unit in that Campus
                            TTTimetableCollectorDoubles1.RESET;
                            TTTimetableCollectorDoubles1.SETRANGE("Class Code", ACALecturersUnits.Class);
                            TTTimetableCollectorDoubles1.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                            TTTimetableCollectorDoubles1.SETRANGE(Unit, ACALecturersUnits.Unit);
                            TTTimetableCollectorDoubles1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                            TTTimetableCollectorDoubles1.SETRANGE(Semester, Rec.Semester);
                            TTTimetableCollectorDoubles1.SETRANGE(Allocated, FALSE);
                            TTTimetableCollectorDoubles1.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                            IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                            //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Doubles for Double Lessons
                            //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Tripples for Double Lessons
                            // // // //
                            // // // //                        TTLessons.RESET;
                            // // // //                        TTLessons.SETRANGE("Lesson Code",TTTimetableCollectorA."Lesson Code");
                            // // // //                        IF TTLessons.FIND('-') THEN BEGIN
                            // Delete from Tripples for Lect/Day/Lesson
                            //For Lesson 1
                            TTTimetableCollectorTripple.RESET;
                            //  TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                            TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                            TTTimetableCollectorTripple.SETFILTER("Lesson 1", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                            TTTimetableCollectorTripple.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                            TTTimetableCollectorTripple.SETRANGE(Allocated, FALSE);
                            TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                            IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                            //For Lesson 2
                            TTTimetableCollectorTripple.RESET;
                            //  TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                            TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                            TTTimetableCollectorTripple.SETFILTER("Lesson 2", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                            TTTimetableCollectorTripple.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                            TTTimetableCollectorTripple.SETRANGE(Allocated, FALSE);
                            TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                            IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                            //For Lesson 3
                            TTTimetableCollectorTripple.RESET;
                            // TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                            TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                            TTTimetableCollectorTripple.SETFILTER("Lesson 3", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                            TTTimetableCollectorTripple.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                            TTTimetableCollectorTripple.SETRANGE(Allocated, FALSE);
                            TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                            IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                            // Delete for the Room/Day/Lesson
                            //For Lesson 1
                            TTTimetableCollectorTripple.RESET;
                            //   TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                            TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                            TTTimetableCollectorTripple.SETFILTER("Lesson 1", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                            TTTimetableCollectorTripple.SETRANGE("Room Code", TTTimetableCollectorDoubles."Room Code");
                            TTTimetableCollectorTripple.SETRANGE(Allocated, FALSE);
                            TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                            IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                            //For Lesson 2
                            TTTimetableCollectorTripple.RESET;
                            //   TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                            TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                            TTTimetableCollectorTripple.SETFILTER("Lesson 2", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                            TTTimetableCollectorTripple.SETRANGE("Room Code", TTTimetableCollectorDoubles."Room Code");
                            TTTimetableCollectorTripple.SETRANGE(Allocated, FALSE);
                            TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                            IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                            //For Lesson 3
                            TTTimetableCollectorTripple.RESET;
                            //  TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                            TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                            TTTimetableCollectorTripple.SETFILTER("Lesson 3", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                            TTTimetableCollectorTripple.SETRANGE("Room Code", TTTimetableCollectorDoubles."Room Code");
                            TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                            TTTimetableCollectorTripple.SETRANGE(Allocated, FALSE);
                            IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                            /////                          END;
                            // Delete for the Lecturer/Day/Campus/Unit in that Campus
                            TTTimetableCollectorTripple.RESET;
                            TTTimetableCollectorTripple.SETRANGE("Class Code", ACALecturersUnits.Class);
                            TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                            TTTimetableCollectorTripple.SETRANGE(Unit, ACALecturersUnits.Unit);
                            TTTimetableCollectorTripple.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                            TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                            TTTimetableCollectorTripple.SETRANGE(Allocated, FALSE);
                            TTTimetableCollectorTripple.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                            IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                            //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Tripples for single Lessons
                            //Delete All Unallocated from The Doubles for Lect/Unit/Campus
                            TTTimetableCollectorDoubles1.RESET;
                            TTTimetableCollectorDoubles1.SETRANGE("Class Code", ACALecturersUnits.Class);
                            TTTimetableCollectorDoubles1.SETRANGE(Unit, ACALecturersUnits.Unit);
                            TTTimetableCollectorDoubles1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                            TTTimetableCollectorDoubles1.SETRANGE(Semester, Rec.Semester);
                            TTTimetableCollectorDoubles1.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                            TTTimetableCollectorDoubles1.SETRANGE(Allocated, FALSE);
                            IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                        END ELSE
                            IF TTWeightLessonCategories."Double Classes" = 2 THEN BEGIN
                                CLEAR(Loops);
                                REPEAT
                                BEGIN
                                    /////////////////////////////////////////////////////////////////////////////////////////////// 2 Doubles
                                    TTTimetableCollectorDoubles.RESET;
                                    TTTimetableCollectorDoubles.SETRANGE("Class Code", ACALecturersUnits.Class);
                                    TTTimetableCollectorDoubles.SETRANGE(Unit, ACALecturersUnits.Unit);
                                    TTTimetableCollectorDoubles.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                    TTTimetableCollectorDoubles.SETRANGE(Semester, Rec.Semester);
                                    TTTimetableCollectorDoubles.SETRANGE(Allocated, FALSE);
                                    TTTimetableCollectorDoubles.SETCURRENTKEY("Day Order", "Lesson 1", "Lesson 2", "Programme Campus Priority", "Programme Room Priority",
                                    "Programme Day Priority",
                                    "Lecturer Campus Priority", "Lecturer Day Priority", "Lecturer Lesson Priority", "Unit Campus Priority", "Unit Room Priority");
                                    IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
                                        TTTimetableCollectorDoubles.Allocated := TRUE;
                                        TTTimetableCollectorDoubles.MODIFY;
                                    END;


                                    //****************************************************************************************************************************** Delete Collisions on Student Unts
                                    //-- Delete all Allocations for the Programme and Units in the selected Stage Begin
                                    // -Select all Stages and Programmes for the Lecturer and Unit and Class Before Picking Units for the Stage to clear for the given
                                    // Lesson and Next
                                    ACALecturersUnits2.RESET;
                                    ACALecturersUnits2.SETRANGE(Semester, Rec.Semester);
                                    ACALecturersUnits2.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                    ACALecturersUnits2.SETRANGE(Class, ACALecturersUnits.Class);
                                    ACALecturersUnits2.SETRANGE(Unit, ACALecturersUnits.Unit);
                                    IF ACALecturersUnits2.FIND('-') THEN BEGIN
                                        REPEAT
                                        BEGIN
                                            // Pick all Units in the Stage for the Programme & Delete in the Lesson and Next Lessons
                                            ACAUnitsSubjects2.RESET;
                                            ACAUnitsSubjects2.SETRANGE("Programme Code", ACALecturersUnits2.Programme);
                                            ACAUnitsSubjects2.SETRANGE("Stage Code", ACALecturersUnits2.Stage);
                                            IF ACAUnitsSubjects2.FIND('-') THEN BEGIN
                                                REPEAT
                                                BEGIN
                                                    //Delete for 1st Lesson
                                                    TTTimetableCollectorDoubles1.RESET;
                                                    TTTimetableCollectorDoubles1.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                                    TTTimetableCollectorDoubles1.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                                    TTTimetableCollectorDoubles1.SETRANGE(Semester, Rec.Semester);
                                                    TTTimetableCollectorDoubles1.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                                    TTTimetableCollectorDoubles1.SETFILTER("Lesson 1", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                                    TTTimetableCollectorDoubles1.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                                    TTTimetableCollectorDoubles1.SETRANGE(Allocated, FALSE);
                                                    IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                                                    //Delete for 2nd Lesson
                                                    TTTimetableCollectorDoubles1.RESET;
                                                    TTTimetableCollectorDoubles1.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                                    TTTimetableCollectorDoubles1.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                                    TTTimetableCollectorDoubles1.SETRANGE(Semester, Rec.Semester);
                                                    TTTimetableCollectorDoubles1.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                                    TTTimetableCollectorDoubles1.SETFILTER("Lesson 2", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                                    TTTimetableCollectorDoubles1.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                                    TTTimetableCollectorDoubles1.SETRANGE(Allocated, FALSE);
                                                    IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                                                END;
                                                UNTIL ACAUnitsSubjects2.NEXT = 0;
                                            END;
                                        END;
                                        UNTIL ACALecturersUnits2.NEXT = 0;
                                    END;
                                    //-- Delete all Allocations for the Programme and Units in the selected Stage end
                                    //******************************************************************************************************************************
                                    //****************************************************************************************************************************** Delete Collisions on Student Unts
                                    //-- Delete all Allocations for the Programme and Units in the selected Stage Begin
                                    // -Select all Stages and Programmes for the Lecturer and Unit and Class Before Picking Units for the Stage to clear for the given
                                    // Lesson and Next
                                    ACALecturersUnits2.RESET;
                                    ACALecturersUnits2.SETRANGE(Semester, Rec.Semester);
                                    ACALecturersUnits2.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                    ACALecturersUnits2.SETRANGE(Class, ACALecturersUnits.Class);
                                    ACALecturersUnits2.SETRANGE(Unit, ACALecturersUnits.Unit);
                                    IF ACALecturersUnits2.FIND('-') THEN BEGIN
                                        REPEAT
                                        BEGIN
                                            // Pick all Units in the Stage for the Programme & Delete in the Lesson and Next Lessons
                                            ACAUnitsSubjects2.RESET;
                                            ACAUnitsSubjects2.SETRANGE("Programme Code", ACALecturersUnits2.Programme);
                                            ACAUnitsSubjects2.SETRANGE("Stage Code", ACALecturersUnits2.Stage);
                                            IF ACAUnitsSubjects2.FIND('-') THEN BEGIN
                                                REPEAT
                                                BEGIN
                                                    //Delete for 1st Lesson
                                                    TTTimetableCollectorTripple.RESET;
                                                    TTTimetableCollectorTripple.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                                    TTTimetableCollectorTripple.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                                    TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                                    TTTimetableCollectorTripple.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                                    TTTimetableCollectorTripple.SETFILTER("Lesson 1", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                                    TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                                    TTTimetableCollectorTripple.SETRANGE(Allocated, FALSE);
                                                    IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                                    //Delete for 2nd Lesson
                                                    TTTimetableCollectorTripple.RESET;
                                                    TTTimetableCollectorTripple.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                                    TTTimetableCollectorTripple.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                                    TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                                    TTTimetableCollectorTripple.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                                    TTTimetableCollectorTripple.SETFILTER("Lesson 2", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                                    TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                                    TTTimetableCollectorTripple.SETRANGE(Allocated, FALSE);
                                                    IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                                    //Delete for 3rd Lesson
                                                    TTTimetableCollectorTripple.RESET;
                                                    TTTimetableCollectorTripple.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                                    TTTimetableCollectorTripple.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                                    TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                                    TTTimetableCollectorTripple.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                                    TTTimetableCollectorTripple.SETFILTER("Lesson 3", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                                    TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                                    TTTimetableCollectorTripple.SETRANGE(Allocated, FALSE);
                                                    IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                                END;
                                                UNTIL ACAUnitsSubjects2.NEXT = 0;
                                            END;
                                        END;
                                        UNTIL ACALecturersUnits2.NEXT = 0;
                                    END;
                                    //-- Delete all Allocations for the Programme and Units in the selected Stage end
                                    //******************************************************************************************************************************
                                    /////////..............................//...................................................................

                                    // Delete the Unit For the Programme in the whole TT
                                    TTTimetableCollectorDoubles1.RESET;
                                    IF Loops = 0 THEN
                                        TTTimetableCollectorDoubles1.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                    TTTimetableCollectorDoubles1.SETRANGE(Programme, ACALecturersUnits.Programme);
                                    TTTimetableCollectorDoubles1.SETRANGE(Unit, ACALecturersUnits.Unit);
                                    TTTimetableCollectorDoubles1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                    TTTimetableCollectorDoubles1.SETRANGE(Semester, Rec.Semester);
                                    TTTimetableCollectorDoubles1.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                                    TTTimetableCollectorDoubles1.SETRANGE(Allocated, FALSE);
                                    IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                                    // Capture Timetable for the same Class and Unit

                                    TTTimetableCollectorDoubles1.RESET;
                                    TTTimetableCollectorDoubles1.SETRANGE("Class Code", ACALecturersUnits.Class);
                                    IF Loops = 0 THEN
                                        TTTimetableCollectorDoubles1.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                    TTTimetableCollectorDoubles1.SETRANGE(Unit, ACALecturersUnits.Unit);
                                    TTTimetableCollectorDoubles1.SETRANGE("Room Code", TTTimetableCollectorDoubles."Room Code");
                                    TTTimetableCollectorDoubles1.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                    TTTimetableCollectorDoubles1.SETFILTER("Lesson 1", '%1', TTTimetableCollectorDoubles."Lesson 1");
                                    TTTimetableCollectorDoubles1.SETFILTER("Lesson 2", '%1', TTTimetableCollectorDoubles."Lesson 2");
                                    TTTimetableCollectorDoubles1.SETRANGE(Semester, Rec.Semester);
                                    TTTimetableCollectorDoubles1.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                                    TTTimetableCollectorDoubles1.SETRANGE(Allocated, FALSE);
                                    IF TTTimetableCollectorDoubles1.FIND('-') THEN BEGIN
                                        REPEAT
                                        BEGIN
                                            ///......................................//..................................................
                                            TTTimetableCollectorDoubles2.RESET;
                                            TTTimetableCollectorDoubles2.SETRANGE("Class Code", ACALecturersUnits.Class);
                                            IF Loops = 0 THEN
                                                TTTimetableCollectorDoubles2.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                            TTTimetableCollectorDoubles2.SETRANGE(Unit, ACALecturersUnits.Unit);
                                            TTTimetableCollectorDoubles2.SETRANGE("Room Code", TTTimetableCollectorDoubles."Room Code");
                                            TTTimetableCollectorDoubles2.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                            TTTimetableCollectorDoubles2.SETFILTER("Lesson 1", '%1', TTTimetableCollectorDoubles."Lesson 1");
                                            TTTimetableCollectorDoubles2.SETFILTER("Lesson 2", '%1', TTTimetableCollectorDoubles."Lesson 2");
                                            TTTimetableCollectorDoubles2.SETRANGE(Semester, Rec.Semester);
                                            TTTimetableCollectorDoubles2.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                                            TTTimetableCollectorDoubles2.SETRANGE(Allocated, FALSE);
                                            IF TTTimetableCollectorDoubles2.FIND('-') THEN BEGIN
                                                TTTimetableCollectorDoubles1.Allocated := TRUE;
                                                TTTimetableCollectorDoubles1.MODIFY;

                                                TTTimetableCollectorDoubles2.RESET;
                                                TTTimetableCollectorDoubles2.SETRANGE(Programme, TTTimetableCollectorDoubles1.Programme);
                                                IF Loops = 0 THEN
                                                    TTTimetableCollectorDoubles2.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                                TTTimetableCollectorDoubles2.SETRANGE(Unit, ACALecturersUnits.Unit);
                                                TTTimetableCollectorDoubles2.SETRANGE(Lecturer, TTTimetableCollectorDoubles1.Lecturer);
                                                TTTimetableCollectorDoubles2.SETRANGE(Semester, Rec.Semester);
                                                TTTimetableCollectorDoubles2.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                                                TTTimetableCollectorDoubles2.SETRANGE(Allocated, FALSE);
                                                IF TTTimetableCollectorDoubles2.FIND('-') THEN TTTimetableCollectorDoubles2.DELETEALL;
                                            END;
                                            ///..........................................//.......................................
                                        END;
                                        UNTIL TTTimetableCollectorDoubles1.NEXT = 0;
                                    END;

                                    /////////..............................//...................................................................
                                    //Delete fro the Lecturer in a week
                                    TTTimetableCollectorDoubles1.RESET;
                                    IF Loops = 0 THEN
                                        TTTimetableCollectorDoubles1.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                    TTTimetableCollectorDoubles1.SETRANGE("Class Code", ACALecturersUnits.Class);
                                    TTTimetableCollectorDoubles1.SETRANGE(Unit, ACALecturersUnits.Unit);
                                    TTTimetableCollectorDoubles1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                    TTTimetableCollectorDoubles1.SETRANGE(Semester, Rec.Semester);
                                    TTTimetableCollectorDoubles1.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                                    TTTimetableCollectorDoubles1.SETRANGE(Allocated, FALSE);
                                    IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                                    //Delete fro the Lecturer/Day/Lesson

                                    //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Doubles for single Lessons
                                    // // // // // // //                        TTLessons.RESET;
                                    // // // // // // //                        TTLessons.SETRANGE("Lesson Code",TTTimetableCollectorA."Lesson Code");
                                    // // // // // // //                        IF TTLessons.FIND('-') THEN BEGIN
                                    // Delete from Doubles for Lect/Day/Lesson
                                    //For Lesson 1
                                    TTTimetableCollectorDoubles1.RESET;
                                    //  TTTimetableCollectorDoubles1.SETRANGE(Programme,ACALecturersUnits.Programme);
                                    TTTimetableCollectorDoubles1.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                    TTTimetableCollectorDoubles1.SETFILTER("Lesson 1", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                    TTTimetableCollectorDoubles1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                    TTTimetableCollectorDoubles1.SETRANGE(Semester, Rec.Semester);
                                    TTTimetableCollectorDoubles1.SETRANGE(Allocated, FALSE);
                                    IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                                    //For Lesson 2
                                    TTTimetableCollectorDoubles1.RESET;
                                    // TTTimetableCollectorDoubles1.SETRANGE(Programme,ACALecturersUnits.Programme);
                                    TTTimetableCollectorDoubles1.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                    TTTimetableCollectorDoubles1.SETFILTER("Lesson 2", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                    TTTimetableCollectorDoubles1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                    TTTimetableCollectorDoubles1.SETRANGE(Semester, Rec.Semester);
                                    TTTimetableCollectorDoubles1.SETRANGE(Allocated, FALSE);
                                    IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                                    // Delete for the Room/Day/Lesson
                                    //For Lesson 1
                                    TTTimetableCollectorDoubles1.RESET;
                                    //  TTTimetableCollectorDoubles1.SETRANGE(Programme,ACALecturersUnits.Programme);
                                    TTTimetableCollectorDoubles1.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                    TTTimetableCollectorDoubles1.SETFILTER("Lesson 1", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                    TTTimetableCollectorDoubles1.SETRANGE("Room Code", TTTimetableCollectorDoubles."Room Code");
                                    TTTimetableCollectorDoubles1.SETRANGE(Semester, Rec.Semester);
                                    TTTimetableCollectorDoubles1.SETRANGE(Allocated, FALSE);
                                    IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                                    //For Lesson 2
                                    TTTimetableCollectorDoubles1.RESET;
                                    //  TTTimetableCollectorDoubles1.SETRANGE(Programme,ACALecturersUnits.Programme);
                                    TTTimetableCollectorDoubles1.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                    TTTimetableCollectorDoubles1.SETFILTER("Lesson 2", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                    TTTimetableCollectorDoubles1.SETRANGE("Room Code", TTTimetableCollectorDoubles."Room Code");
                                    TTTimetableCollectorDoubles1.SETRANGE(Semester, Rec.Semester);
                                    TTTimetableCollectorDoubles1.SETRANGE(Allocated, FALSE);
                                    IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                                    //  END;
                                    // Delete for the Lecturer/Day/Campus/Unit in that Campus
                                    TTTimetableCollectorDoubles1.RESET;
                                    TTTimetableCollectorDoubles1.SETRANGE("Class Code", ACALecturersUnits.Class);
                                    TTTimetableCollectorDoubles1.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                    TTTimetableCollectorDoubles1.SETRANGE(Unit, ACALecturersUnits.Unit);
                                    TTTimetableCollectorDoubles1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                    TTTimetableCollectorDoubles1.SETRANGE(Semester, Rec.Semester);
                                    TTTimetableCollectorDoubles1.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                                    TTTimetableCollectorDoubles1.SETRANGE(Allocated, FALSE);
                                    IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                                    //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Doubles for Double Lessons
                                    //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Tripples for Double Lessons

                                    // // // // // //                        TTLessons.RESET;
                                    // // // // // //                        TTLessons.SETRANGE("Lesson Code",TTTimetableCollectorA."Lesson Code");
                                    // // // // // //                        IF TTLessons.FIND('-') THEN BEGIN
                                    // Delete from Tripples for Lect/Day/Lesson
                                    //For Lesson 1
                                    TTTimetableCollectorTripple.RESET;
                                    // TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                                    TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                    TTTimetableCollectorTripple.SETFILTER("Lesson 1", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                    TTTimetableCollectorTripple.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                    TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                    TTTimetableCollectorTripple.SETRANGE(Allocated, FALSE);
                                    IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                    //For Lesson 2
                                    TTTimetableCollectorTripple.RESET;
                                    // TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                                    TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                    TTTimetableCollectorTripple.SETFILTER("Lesson 2", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                    TTTimetableCollectorTripple.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                    TTTimetableCollectorTripple.SETRANGE(Allocated, FALSE);
                                    TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                    IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                    //For Lesson 3
                                    TTTimetableCollectorTripple.RESET;
                                    // TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                                    TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                    TTTimetableCollectorTripple.SETFILTER("Lesson 3", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                    TTTimetableCollectorTripple.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                    TTTimetableCollectorTripple.SETRANGE(Allocated, FALSE);
                                    TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                    IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                    // Delete for the Room/Day/Lesson
                                    //For Lesson 1
                                    TTTimetableCollectorTripple.RESET;
                                    //  TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                                    TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                    TTTimetableCollectorTripple.SETFILTER("Lesson 1", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                    TTTimetableCollectorTripple.SETRANGE("Room Code", TTTimetableCollectorDoubles."Room Code");
                                    TTTimetableCollectorTripple.SETRANGE(Allocated, FALSE);
                                    TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                    IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                    //For Lesson 2
                                    TTTimetableCollectorTripple.RESET;
                                    //  TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                                    TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                    TTTimetableCollectorTripple.SETFILTER("Lesson 2", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                    TTTimetableCollectorTripple.SETRANGE("Room Code", TTTimetableCollectorDoubles."Room Code");
                                    TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                    IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                    //For Lesson 3
                                    TTTimetableCollectorTripple.RESET;
                                    //  TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                                    TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                    TTTimetableCollectorTripple.SETFILTER("Lesson 3", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                    TTTimetableCollectorTripple.SETRANGE("Room Code", TTTimetableCollectorDoubles."Room Code");
                                    TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                    IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                    ////////                          END;
                                    // Delete for the Lecturer/Day/Campus/Unit in that Campus
                                    TTTimetableCollectorTripple.RESET;
                                    TTTimetableCollectorTripple.SETRANGE("Class Code", ACALecturersUnits.Class);
                                    TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                    TTTimetableCollectorTripple.SETRANGE(Unit, ACALecturersUnits.Unit);
                                    TTTimetableCollectorTripple.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                    TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                    TTTimetableCollectorTripple.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                                    IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                    //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Tripples for single Lessons
                                    //Delete All Unallocated from The Doubles for Lect/Unit/Campus
                                    TTTimetableCollectorDoubles1.RESET;
                                    IF Loops = 0 THEN
                                        TTTimetableCollectorDoubles1.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                    TTTimetableCollectorDoubles1.SETRANGE("Class Code", ACALecturersUnits.Class);
                                    TTTimetableCollectorDoubles1.SETRANGE(Unit, ACALecturersUnits.Unit);
                                    TTTimetableCollectorDoubles1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                    TTTimetableCollectorDoubles1.SETRANGE(Semester, Rec.Semester);
                                    TTTimetableCollectorDoubles1.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                                    TTTimetableCollectorDoubles1.SETRANGE(Allocated, FALSE);
                                    IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                                    /////////////////////////////////////////////////////////////////////////////////////////////// 2 Doubles
                                    Loops := Loops + 1;
                                END;
                                UNTIL Loops = 2;
                            END ELSE
                                IF TTWeightLessonCategories."Double Classes" = 3 THEN BEGIN
                                    CLEAR(Loops);
                                    REPEAT
                                    BEGIN
                                        /////////////////////////////////////////////////////////////////////////////////////////////// 3 Doubles
                                        TTTimetableCollectorDoubles.RESET;
                                        TTTimetableCollectorDoubles.SETRANGE("Class Code", ACALecturersUnits.Class);
                                        TTTimetableCollectorDoubles.SETRANGE(Unit, ACALecturersUnits.Unit);
                                        TTTimetableCollectorDoubles.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                        TTTimetableCollectorDoubles.SETRANGE(Semester, Rec.Semester);
                                        TTTimetableCollectorDoubles.SETRANGE(Allocated, FALSE);
                                        TTTimetableCollectorDoubles.SETCURRENTKEY("Day Order", "Lesson 1", "Lesson 2", "Programme Campus Priority",
                                        "Programme Room Priority", "Programme Day Priority", "Lecturer Campus Priority",
                                        "Lecturer Day Priority", "Lecturer Lesson Priority", "Unit Campus Priority", "Unit Room Priority");
                                        IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
                                            TTTimetableCollectorDoubles.Allocated := TRUE;
                                            TTTimetableCollectorDoubles.MODIFY;
                                        END;


                                        //****************************************************************************************************************************** Delete Collisions on Student Unts
                                        //-- Delete all Allocations for the Programme and Units in the selected Stage Begin
                                        // -Select all Stages and Programmes for the Lecturer and Unit and Class Before Picking Units for the Stage to clear for the given
                                        // Lesson and Next
                                        ACALecturersUnits2.RESET;
                                        ACALecturersUnits2.SETRANGE(Semester, Rec.Semester);
                                        ACALecturersUnits2.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                        ACALecturersUnits2.SETRANGE(Class, ACALecturersUnits.Class);
                                        ACALecturersUnits2.SETRANGE(Unit, ACALecturersUnits.Unit);
                                        IF ACALecturersUnits2.FIND('-') THEN BEGIN
                                            REPEAT
                                            BEGIN
                                                // Pick all Units in the Stage for the Programme & Delete in the Lesson and Next Lessons
                                                ACAUnitsSubjects2.RESET;
                                                ACAUnitsSubjects2.SETRANGE("Programme Code", ACALecturersUnits2.Programme);
                                                ACAUnitsSubjects2.SETRANGE("Stage Code", ACALecturersUnits2.Stage);
                                                IF ACAUnitsSubjects2.FIND('-') THEN BEGIN
                                                    REPEAT
                                                    BEGIN
                                                        //Delete for 1st Lesson
                                                        TTTimetableCollectorDoubles1.RESET;
                                                        TTTimetableCollectorDoubles1.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                                        TTTimetableCollectorDoubles1.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                                        TTTimetableCollectorDoubles1.SETRANGE(Semester, Rec.Semester);
                                                        TTTimetableCollectorDoubles1.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                                        TTTimetableCollectorDoubles1.SETFILTER("Lesson 1", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                                        TTTimetableCollectorDoubles1.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                                        TTTimetableCollectorDoubles1.SETRANGE(Allocated, FALSE);
                                                        IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                                                        //Delete for 2nd Lesson
                                                        TTTimetableCollectorDoubles1.RESET;
                                                        TTTimetableCollectorDoubles1.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                                        TTTimetableCollectorDoubles1.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                                        TTTimetableCollectorDoubles1.SETRANGE(Semester, Rec.Semester);
                                                        TTTimetableCollectorDoubles1.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                                        TTTimetableCollectorDoubles1.SETFILTER("Lesson 2", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                                        TTTimetableCollectorDoubles1.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                                        TTTimetableCollectorDoubles1.SETRANGE(Allocated, FALSE);
                                                        IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                                                    END;
                                                    UNTIL ACAUnitsSubjects2.NEXT = 0;
                                                END;
                                            END;
                                            UNTIL ACALecturersUnits2.NEXT = 0;
                                        END;
                                        //-- Delete all Allocations for the Programme and Units in the selected Stage end
                                        //******************************************************************************************************************************
                                        //****************************************************************************************************************************** Delete Collisions on Student Unts
                                        //-- Delete all Allocations for the Programme and Units in the selected Stage Begin
                                        // -Select all Stages and Programmes for the Lecturer and Unit and Class Before Picking Units for the Stage to clear for the given
                                        // Lesson and Next
                                        ACALecturersUnits2.RESET;
                                        ACALecturersUnits2.SETRANGE(Semester, Rec.Semester);
                                        ACALecturersUnits2.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                        ACALecturersUnits2.SETRANGE(Class, ACALecturersUnits.Class);
                                        ACALecturersUnits2.SETRANGE(Unit, ACALecturersUnits.Unit);
                                        IF ACALecturersUnits2.FIND('-') THEN BEGIN
                                            REPEAT
                                            BEGIN
                                                // Pick all Units in the Stage for the Programme & Delete in the Lesson and Next Lessons
                                                ACAUnitsSubjects2.RESET;
                                                ACAUnitsSubjects2.SETRANGE("Programme Code", ACALecturersUnits2.Programme);
                                                ACAUnitsSubjects2.SETRANGE("Stage Code", ACALecturersUnits2.Stage);
                                                IF ACAUnitsSubjects2.FIND('-') THEN BEGIN
                                                    REPEAT
                                                    BEGIN
                                                        //Delete for 1st Lesson
                                                        TTTimetableCollectorTripple.RESET;
                                                        TTTimetableCollectorTripple.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                                        TTTimetableCollectorTripple.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                                        TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                                        TTTimetableCollectorTripple.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                                        TTTimetableCollectorTripple.SETFILTER("Lesson 1", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                                        TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                                        TTTimetableCollectorTripple.SETRANGE(Allocated, FALSE);
                                                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                                        //Delete for 2nd Lesson
                                                        TTTimetableCollectorTripple.RESET;
                                                        TTTimetableCollectorTripple.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                                        TTTimetableCollectorTripple.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                                        TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                                        TTTimetableCollectorTripple.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                                        TTTimetableCollectorTripple.SETFILTER("Lesson 2", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                                        TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                                        TTTimetableCollectorTripple.SETRANGE(Allocated, FALSE);
                                                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                                        //Delete for 3rd Lesson
                                                        TTTimetableCollectorTripple.RESET;
                                                        TTTimetableCollectorTripple.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                                        TTTimetableCollectorTripple.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                                        TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                                        TTTimetableCollectorTripple.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                                        TTTimetableCollectorTripple.SETFILTER("Lesson 3", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                                        TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                                        TTTimetableCollectorTripple.SETRANGE(Allocated, FALSE);
                                                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                                    END;
                                                    UNTIL ACAUnitsSubjects2.NEXT = 0;
                                                END;
                                            END;
                                            UNTIL ACALecturersUnits2.NEXT = 0;
                                        END;
                                        //-- Delete all Allocations for the Programme and Units in the selected Stage end
                                        //******************************************************************************************************************************
                                        //Delete fro the Lecturer in a week
                                        TTTimetableCollectorDoubles1.RESET;
                                        IF ((Loops = 0) OR (Loops = 1)) THEN
                                            TTTimetableCollectorDoubles1.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                        TTTimetableCollectorDoubles1.SETRANGE("Class Code", ACALecturersUnits.Class);
                                        TTTimetableCollectorDoubles1.SETRANGE(Unit, ACALecturersUnits.Unit);
                                        TTTimetableCollectorDoubles1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                        TTTimetableCollectorDoubles1.SETRANGE(Semester, Rec.Semester);
                                        TTTimetableCollectorDoubles1.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                                        TTTimetableCollectorDoubles1.SETRANGE(Allocated, FALSE);
                                        IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                                        //Delete fro the Lecturer/Day/Lesson

                                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Doubles for single Lessons
                                        // // // // // // //                        TTLessons.RESET;
                                        // // // // // // //                        TTLessons.SETRANGE("Lesson Code",TTTimetableCollectorA."Lesson Code");
                                        // // // // // // //                        IF TTLessons.FIND('-') THEN BEGIN
                                        // Delete from Doubles for Lect/Day/Lesson
                                        //For Lesson 1
                                        TTTimetableCollectorDoubles1.RESET;
                                        //   TTTimetableCollectorDoubles1.SETRANGE(Programme,ACALecturersUnits.Programme);
                                        TTTimetableCollectorDoubles1.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                        TTTimetableCollectorDoubles1.SETFILTER("Lesson 1", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                        TTTimetableCollectorDoubles1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                        TTTimetableCollectorDoubles1.SETRANGE(Semester, Rec.Semester);
                                        TTTimetableCollectorDoubles1.SETRANGE(Allocated, FALSE);
                                        IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                                        //For Lesson 2
                                        TTTimetableCollectorDoubles1.RESET;
                                        //  TTTimetableCollectorDoubles1.SETRANGE(Programme,ACALecturersUnits.Programme);
                                        TTTimetableCollectorDoubles1.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                        TTTimetableCollectorDoubles1.SETFILTER("Lesson 2", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                        TTTimetableCollectorDoubles1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                        TTTimetableCollectorDoubles1.SETRANGE(Semester, Rec.Semester);
                                        TTTimetableCollectorDoubles1.SETRANGE(Allocated, FALSE);
                                        IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                                        // Delete for the Room/Day/Lesson
                                        //For Lesson 1
                                        TTTimetableCollectorDoubles1.RESET;
                                        // TTTimetableCollectorDoubles1.SETRANGE(Programme,ACALecturersUnits.Programme);
                                        TTTimetableCollectorDoubles1.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                        TTTimetableCollectorDoubles1.SETFILTER("Lesson 1", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                        TTTimetableCollectorDoubles1.SETRANGE("Room Code", TTTimetableCollectorDoubles."Room Code");
                                        TTTimetableCollectorDoubles1.SETRANGE(Semester, Rec.Semester);
                                        TTTimetableCollectorDoubles1.SETRANGE(Allocated, FALSE);
                                        IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                                        //For Lesson 2
                                        TTTimetableCollectorDoubles1.RESET;
                                        // TTTimetableCollectorDoubles1.SETRANGE(Programme,ACALecturersUnits.Programme);
                                        TTTimetableCollectorDoubles1.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                        TTTimetableCollectorDoubles1.SETFILTER("Lesson 2", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                        TTTimetableCollectorDoubles1.SETRANGE("Room Code", TTTimetableCollectorDoubles."Room Code");
                                        TTTimetableCollectorDoubles1.SETRANGE(Semester, Rec.Semester);
                                        TTTimetableCollectorDoubles1.SETRANGE(Allocated, FALSE);
                                        IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                                        //  END;
                                        // Delete for the Lecturer/Day/Campus/Unit in that Campus
                                        TTTimetableCollectorDoubles1.RESET;
                                        TTTimetableCollectorDoubles1.SETRANGE("Class Code", ACALecturersUnits.Class);
                                        TTTimetableCollectorDoubles1.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                        TTTimetableCollectorDoubles1.SETRANGE(Unit, ACALecturersUnits.Unit);
                                        TTTimetableCollectorDoubles1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                        TTTimetableCollectorDoubles1.SETRANGE(Semester, Rec.Semester);
                                        TTTimetableCollectorDoubles1.SETRANGE(Allocated, FALSE);
                                        TTTimetableCollectorDoubles1.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                                        IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Doubles for Double Lessons
                                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Tripples for Double Lessons

                                        // // // // // //                        TTLessons.RESET;
                                        // // // // // //                        TTLessons.SETRANGE("Lesson Code",TTTimetableCollectorA."Lesson Code");
                                        // // // // // //                        IF TTLessons.FIND('-') THEN BEGIN
                                        // Delete from Tripples for Lect/Day/Lesson
                                        //For Lesson 1
                                        TTTimetableCollectorTripple.RESET;
                                        //  TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                                        TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                        TTTimetableCollectorTripple.SETFILTER("Lesson 1", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                        TTTimetableCollectorTripple.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                        TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                        //For Lesson 2
                                        TTTimetableCollectorTripple.RESET;
                                        //  TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                                        TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                        TTTimetableCollectorTripple.SETFILTER("Lesson 2", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                        TTTimetableCollectorTripple.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                        TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                        //For Lesson 3
                                        TTTimetableCollectorTripple.RESET;
                                        //  TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                                        TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                        TTTimetableCollectorTripple.SETFILTER("Lesson 3", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                        TTTimetableCollectorTripple.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                        TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                        // Delete for the Room/Day/Lesson
                                        //For Lesson 1
                                        TTTimetableCollectorTripple.RESET;
                                        //  TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                                        TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                        TTTimetableCollectorTripple.SETFILTER("Lesson 1", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                        TTTimetableCollectorTripple.SETRANGE("Room Code", TTTimetableCollectorDoubles."Room Code");
                                        TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                        //For Lesson 2
                                        TTTimetableCollectorTripple.RESET;
                                        //  TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                                        TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                        TTTimetableCollectorTripple.SETFILTER("Lesson 2", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                        TTTimetableCollectorTripple.SETRANGE("Room Code", TTTimetableCollectorDoubles."Room Code");
                                        TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                        //For Lesson 3
                                        TTTimetableCollectorTripple.RESET;
                                        //  TTTimetableCollectorTripple.SETRANGE(Programme,ACALecturersUnits.Programme);
                                        TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                        TTTimetableCollectorTripple.SETFILTER("Lesson 3", '%1|%2', TTTimetableCollectorDoubles."Lesson 1", TTTimetableCollectorDoubles."Lesson 2");
                                        TTTimetableCollectorTripple.SETRANGE("Room Code", TTTimetableCollectorDoubles."Room Code");
                                        TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                        ////////                          END;
                                        // Delete for the Lecturer/Day/Campus/Unit in that Campus
                                        TTTimetableCollectorTripple.RESET;
                                        TTTimetableCollectorTripple.SETRANGE("Class Code", ACALecturersUnits.Class);
                                        TTTimetableCollectorTripple.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                        TTTimetableCollectorTripple.SETRANGE(Unit, ACALecturersUnits.Unit);
                                        TTTimetableCollectorTripple.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                        TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                        TTTimetableCollectorTripple.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Tripples for single Lessons
                                        //Delete All Unallocated from The Doubles for Lect/Unit/Campus
                                        TTTimetableCollectorDoubles1.RESET;
                                        IF ((Loops = 0) OR (Loops = 1)) THEN
                                            TTTimetableCollectorDoubles1.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                                        TTTimetableCollectorDoubles1.SETRANGE("Class Code", ACALecturersUnits.Class);
                                        TTTimetableCollectorDoubles1.SETRANGE(Unit, ACALecturersUnits.Unit);
                                        TTTimetableCollectorDoubles1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                        TTTimetableCollectorDoubles1.SETRANGE(Semester, Rec.Semester);
                                        TTTimetableCollectorDoubles1.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                                        TTTimetableCollectorDoubles1.SETRANGE(Allocated, FALSE);
                                        IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                                        /////////////////////////////////////////////////////////////////////////////////////////////// 3 Doubles
                                        Loops := Loops + 1;
                                    END;
                                    UNTIL Loops = 3;
                                END;

                END;
            END;
            UNTIL ACALecturersUnits.NEXT = 0;
        END;
        progre.CLOSE;
    end;

    local procedure ThiningTripples()
    var
        TTRooms: Record "TT-Rooms";
        TTDailyLessons: Record 74503;
        ACALecturersUnits: Record "ACA-Lecturers Units";
        ACALecturersUnits2: Record "ACA-Lecturers Units";
        LectLoadBatchLines: Record 65201;
        ACAProgramme: Record 61511;
        ACAUnitsSubjects: Record 61517;
        ACAUnitsSubjects2: Record 61517;
        TTUnits: Record "TT-Units";
        TTLessons: Record 74520;
        TTDays: Record 74502;
        TTLessons1: Record 74520;
        TTLessons2: Record 74520;
        TTLessons3: Record 74520;
        TTWeightLessonCategories: Record "TT-Weight Lesson Categories";
        TTTimetableCollectorA: Record 74500;
        TTTimetableCollectorA1: Record 74500;
        TTTimetableCollectorA2: Record 74500;
        TTTimetableCollectorA3: Record 74500;
        TTTimetableCollectorDoubles: Record 74521;
        TTTimetableCollectorDoubles1: Record 74521;
        TTTimetableCollectorDoubles2: Record 74521;
        TTTimetableCollectorTripple: Record 74522;
        TTTimetableCollectorTripple1: Record 74522;
        TTTimetableCollectorTripple2: Record 74522;
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
        //prempTrns: Record 61091;
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
        progre.OPEN('Building Timetable for Tripples:  #1#############################' +
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
                BufferString := 'Total Tripples processed = ' + FORMAT(counts);

                progre.UPDATE();
                //SLEEP(50);
                ///////////////////////////////////////////////////////////////////////////////Progress Update
                TTUnits.RESET;
                TTUnits.SETRANGE(Semester, Rec.Semester);
                TTUnits.SETRANGE("Programme Code", ACALecturersUnits.Programme);
                TTUnits.SETRANGE("Unit Code", ACALecturersUnits.Unit);
                IF TTUnits.FIND('-') THEN;
                TTWeightLessonCategories.RESET;
                TTWeightLessonCategories.SETRANGE(Semester, Rec.Semester);
                TTWeightLessonCategories.SETRANGE("Category Code", TTUnits."Weighting Category");
                IF TTWeightLessonCategories.FIND('-') THEN BEGIN
                    //Thin Singles
                    IF TTWeightLessonCategories."Triple Classes" = 0 THEN BEGIN
                        TTTimetableCollectorTripple.RESET;
                        TTTimetableCollectorTripple.SETRANGE(Programme, ACALecturersUnits.Programme);
                        TTTimetableCollectorTripple.SETRANGE(Unit, ACALecturersUnits.Unit);
                        TTTimetableCollectorTripple.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                        TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                    END ELSE
                        IF TTWeightLessonCategories."Triple Classes" = 1 THEN BEGIN
                            TTTimetableCollectorTripple.RESET;
                            TTTimetableCollectorTripple.SETRANGE("Class Code", ACALecturersUnits.Class);
                            TTTimetableCollectorTripple.SETRANGE(Unit, ACALecturersUnits.Unit);
                            TTTimetableCollectorTripple.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                            TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                            TTTimetableCollectorTripple.SETRANGE(Allocated, FALSE);
                            TTTimetableCollectorTripple.SETCURRENTKEY("Day Order", "Lesson 1", "Lesson 2", "Lesson 3", "Programme Campus Priority", "Programme Room Priority",
    "Programme Day Priority", "Lecturer Campus Priority", "Lecturer Day Priority",
    "Lecturer Lesson Priority", "Unit Campus Priority", "Unit Room Priority");
                            IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
                                TTTimetableCollectorTripple.Allocated := TRUE;
                                TTTimetableCollectorTripple.MODIFY;
                            END;

                            //****************************************************************************************************************************** Delete Collisions on Student Unts
                            //-- Delete all Allocations for the Programme and Units in the selected Stage Begin
                            // -Select all Stages and Programmes for the Lecturer and Unit and Class Before Picking Units for the Stage to clear for the given
                            // Lesson and Next
                            ACALecturersUnits2.RESET;
                            ACALecturersUnits2.SETRANGE(Semester, Rec.Semester);
                            ACALecturersUnits2.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                            ACALecturersUnits2.SETRANGE(Class, ACALecturersUnits.Class);
                            ACALecturersUnits2.SETRANGE(Unit, ACALecturersUnits.Unit);
                            IF ACALecturersUnits2.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    // Pick all Units in the Stage for the Programme & Delete in the Lesson and Next Lessons
                                    ACAUnitsSubjects2.RESET;
                                    ACAUnitsSubjects2.SETRANGE("Programme Code", ACALecturersUnits2.Programme);
                                    ACAUnitsSubjects2.SETRANGE("Stage Code", ACALecturersUnits2.Stage);
                                    IF ACAUnitsSubjects2.FIND('-') THEN BEGIN
                                        REPEAT
                                        BEGIN
                                            //Delete for 1st Lesson
                                            TTTimetableCollectorTripple1.RESET;
                                            TTTimetableCollectorTripple1.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                            TTTimetableCollectorTripple1.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                            TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                                            TTTimetableCollectorTripple1.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                            TTTimetableCollectorTripple1.SETFILTER("Lesson 1", '%1|%2|%3', TTTimetableCollectorTripple."Lesson 1", TTTimetableCollectorTripple."Lesson 2", TTTimetableCollectorTripple."Lesson 3");
                                            TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                                            TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                                            IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                                            //Delete for 2nd Lesson
                                            TTTimetableCollectorTripple1.RESET;
                                            TTTimetableCollectorTripple1.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                            TTTimetableCollectorTripple1.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                            TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                                            TTTimetableCollectorTripple1.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                            TTTimetableCollectorTripple1.SETFILTER("Lesson 2", '%1|%2|%3', TTTimetableCollectorTripple."Lesson 1", TTTimetableCollectorTripple."Lesson 2", TTTimetableCollectorTripple."Lesson 3");
                                            TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                                            TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                                            IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                                            //Delete for 3rd Lesson
                                            TTTimetableCollectorTripple1.RESET;
                                            TTTimetableCollectorTripple1.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                            TTTimetableCollectorTripple1.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                            TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                                            TTTimetableCollectorTripple1.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                            TTTimetableCollectorTripple1.SETFILTER("Lesson 3", '%1|%2|%3', TTTimetableCollectorTripple."Lesson 1", TTTimetableCollectorTripple."Lesson 2", TTTimetableCollectorTripple."Lesson 3");
                                            TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                                            TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                                            IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                                        END;
                                        UNTIL ACAUnitsSubjects2.NEXT = 0;
                                    END;
                                END;
                                UNTIL ACALecturersUnits2.NEXT = 0;
                            END;
                            //-- Delete all Allocations for the Programme and Units in the selected Stage end
                            //******************************************************************************************************************************
                            /////////..............................//...................................................................

                            // Delete the Unit For the Programme in the whole TT
                            TTTimetableCollectorTripple1.RESET;
                            TTTimetableCollectorTripple1.SETRANGE(Programme, ACALecturersUnits.Programme);
                            TTTimetableCollectorTripple1.SETRANGE(Unit, ACALecturersUnits.Unit);
                            TTTimetableCollectorTripple1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                            TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                            TTTimetableCollectorTripple1.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                            TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                            IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                            // Capture Timetable for the same Class and Unit

                            TTTimetableCollectorTripple1.RESET;
                            TTTimetableCollectorTripple1.SETRANGE("Class Code", ACALecturersUnits.Class);
                            TTTimetableCollectorTripple1.SETRANGE(Unit, ACALecturersUnits.Unit);
                            TTTimetableCollectorTripple1.SETRANGE("Room Code", TTTimetableCollectorTripple."Room Code");
                            TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                            TTTimetableCollectorTripple1.SETFILTER("Lesson 1", '%1', TTTimetableCollectorTripple."Lesson 1");
                            TTTimetableCollectorTripple1.SETFILTER("Lesson 2", '%1', TTTimetableCollectorTripple."Lesson 2");
                            TTTimetableCollectorTripple1.SETFILTER("Lesson 3", '%1', TTTimetableCollectorTripple."Lesson 3");
                            TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                            TTTimetableCollectorTripple1.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                            TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                            IF TTTimetableCollectorTripple1.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    ///......................................//..................................................
                                    TTTimetableCollectorTripple2.RESET;
                                    TTTimetableCollectorTripple2.SETRANGE("Class Code", ACALecturersUnits.Class);
                                    TTTimetableCollectorTripple2.SETRANGE(Unit, ACALecturersUnits.Unit);
                                    TTTimetableCollectorTripple2.SETRANGE("Room Code", TTTimetableCollectorTripple."Room Code");
                                    TTTimetableCollectorTripple2.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                                    TTTimetableCollectorTripple2.SETFILTER("Lesson 1", '%1', TTTimetableCollectorTripple."Lesson 1");
                                    TTTimetableCollectorTripple2.SETFILTER("Lesson 2", '%1', TTTimetableCollectorTripple."Lesson 2");
                                    TTTimetableCollectorTripple2.SETFILTER("Lesson 3", '%1', TTTimetableCollectorTripple."Lesson 3");
                                    TTTimetableCollectorTripple2.SETRANGE(Semester, Rec.Semester);
                                    TTTimetableCollectorTripple2.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                                    TTTimetableCollectorTripple2.SETRANGE(Allocated, FALSE);
                                    IF TTTimetableCollectorTripple2.FIND('-') THEN BEGIN
                                        TTTimetableCollectorTripple1.Allocated := TRUE;
                                        TTTimetableCollectorTripple1.MODIFY;

                                        TTTimetableCollectorTripple2.RESET;
                                        TTTimetableCollectorTripple2.SETRANGE(Programme, TTTimetableCollectorTripple1.Programme);
                                        TTTimetableCollectorTripple2.SETRANGE(Unit, ACALecturersUnits.Unit);
                                        TTTimetableCollectorTripple2.SETRANGE(Lecturer, TTTimetableCollectorTripple1.Lecturer);
                                        TTTimetableCollectorTripple2.SETRANGE(Semester, Rec.Semester);
                                        TTTimetableCollectorTripple2.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                                        TTTimetableCollectorTripple2.SETRANGE(Allocated, FALSE);
                                        IF TTTimetableCollectorTripple2.FIND('-') THEN TTTimetableCollectorTripple2.DELETEALL;
                                    END;
                                    ///..........................................//.......................................
                                END;
                                UNTIL TTTimetableCollectorTripple1.NEXT = 0;
                            END;

                            /////////..............................//...................................................................
                            //Delete fro the Lecturer in a week
                            TTTimetableCollectorTripple1.RESET;
                            TTTimetableCollectorTripple1.SETRANGE("Class Code", ACALecturersUnits.Class);
                            TTTimetableCollectorTripple1.SETRANGE(Unit, ACALecturersUnits.Unit);
                            TTTimetableCollectorTripple1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                            TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                            TTTimetableCollectorTripple1.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                            TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                            IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                            //Delete fro the Lecturer/Day/Lesson
                            // // // // // // // // // // // // // // // // // // //
                            // // // // // // // // // // // // // // // //                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Doubles for Double Lessons
                            // // // // // // // // // // // // // // // // // // // // // // // // //                        TTLessons.RESET;
                            // // // // // // // // // // // // // // // // // // // // // // // // //                        TTLessons.SETRANGE("Lesson Code",TTTimetableCollectorA."Lesson Code");
                            // // // // // // // // // // // // // // // // // // // // // // // // //                        IF TTLessons.FIND('-') THEN BEGIN
                            // // // // // // // // // // // // // // // //                          // Delete from Doubles for Lect/Day/Lesson
                            // // // // // // // // // // // // // // // //                          //For Lesson 1
                            // // // // // // // // // // // // // // // //                        TTTimetableCollectorDoubles1.RESET;
                            // // // // // // // // // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Programme,ACALecturersUnits.Programme);
                            // // // // // // // // // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE("Day of Week",TTTimetableCollectorDoubles."Day of Week");
                            // // // // // // // // // // // // // // // //                        TTTimetableCollectorDoubles1.SETFILTER("Lesson 1",'%1|%2',TTTimetableCollectorDoubles."Lesson 1",TTTimetableCollectorDoubles."Lesson 2");
                            // // // // // // // // // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                            // // // // // // // // // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Semester,Rec.Semester);
                            // // // // // // // // // // // // // // // //                        IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                            // // // // // // // // // // // // // // // //                        //For Lesson 2
                            // // // // // // // // // // // // // // // //                        TTTimetableCollectorDoubles1.RESET;
                            // // // // // // // // // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Programme,ACALecturersUnits.Programme);
                            // // // // // // // // // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE("Day of Week",TTTimetableCollectorDoubles."Day of Week");
                            // // // // // // // // // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE("Lesson 2",TTTimetableCollectorDoubles."Lesson 1",TTTimetableCollectorDoubles."Lesson 2");
                            // // // // // // // // // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                            // // // // // // // // // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Semester,Rec.Semester);
                            // // // // // // // // // // // // // // // //                        IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                            // // // // // // // // // // // // // // // //                        // Delete for the Room/Day/Lesson
                            // // // // // // // // // // // // // // // //                        //For Lesson 1
                            // // // // // // // // // // // // // // // //                        TTTimetableCollectorDoubles1.RESET;
                            // // // // // // // // // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Programme,ACALecturersUnits.Programme);
                            // // // // // // // // // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE("Day of Week",TTTimetableCollectorDoubles."Day of Week");
                            // // // // // // // // // // // // // // // //                        TTTimetableCollectorDoubles1.SETFILTER("Lesson 1",'%1|%2',TTTimetableCollectorDoubles."Lesson 1",TTTimetableCollectorDoubles."Lesson 2");
                            // // // // // // // // // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE("Room Code",TTTimetableCollectorDoubles."Room Code");
                            // // // // // // // // // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Semester,Rec.Semester);
                            // // // // // // // // // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Allocated,FALSE);
                            // // // // // // // // // // // // // // // //                        IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                            // // // // // // // // // // // // // // // //                        //For Lesson 2
                            // // // // // // // // // // // // // // // //                        TTTimetableCollectorDoubles1.RESET;
                            // // // // // // // // // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Programme,ACALecturersUnits.Programme);
                            // // // // // // // // // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE("Day of Week",TTTimetableCollectorDoubles."Day of Week");
                            // // // // // // // // // // // // // // // //                        TTTimetableCollectorDoubles1.SETFILTER("Lesson 2",'%1|%2',TTTimetableCollectorDoubles."Lesson 1",TTTimetableCollectorDoubles."Lesson 2");
                            // // // // // // // // // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE("Room Code",TTTimetableCollectorDoubles."Room Code");
                            // // // // // // // // // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Semester,Rec.Semester);
                            // // // // // // // // // // // // // // // //                        IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                            // // // // // // // // // // // // // // // //                   //       END;
                            // // // // // // // // // // // // // // // //                          // Delete for the Lecturer/Day/Campus/Unit in that Campus
                            // // // // // // // // // // // // // // // //                        TTTimetableCollectorDoubles1.RESET;
                            // // // // // // // // // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Programme,ACALecturersUnits.Programme);
                            // // // // // // // // // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE("Day of Week",TTTimetableCollectorDoubles."Day of Week");
                            // // // // // // // // // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Unit,ACALecturersUnits.Unit);
                            // // // // // // // // // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                            // // // // // // // // // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Semester,Rec.Semester);
                            // // // // // // // // // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE("Campus Code",ACALecturersUnits."Campus Code");
                            // // // // // // // // // // // // // // // //                        IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                            //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Doubles for Double Lessons
                            //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Tripples for Tripple Lessons
                            // // // //
                            // // // //                        TTLessons.RESET;
                            // // // //                        TTLessons.SETRANGE("Lesson Code",TTTimetableCollectorA."Lesson Code");
                            // // // //                        IF TTLessons.FIND('-') THEN BEGIN
                            // Delete from Tripples for Lect/Day/Lesson
                            //For Lesson 1
                            TTTimetableCollectorTripple1.RESET;
                            //   TTTimetableCollectorTripple1.SETRANGE(Programme,ACALecturersUnits.Programme);
                            TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                            TTTimetableCollectorTripple1.SETFILTER("Lesson 1", '%1|%2|%3', TTTimetableCollectorTripple."Lesson 1", TTTimetableCollectorTripple."Lesson 2", TTTimetableCollectorTripple."Lesson 3");
                            TTTimetableCollectorTripple1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                            TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                            TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                            IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                            //For Lesson 2
                            TTTimetableCollectorTripple1.RESET;
                            // TTTimetableCollectorTripple1.SETRANGE(Programme,ACALecturersUnits.Programme);
                            TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                            TTTimetableCollectorTripple1.SETFILTER("Lesson 2", '%1|%2|%3', TTTimetableCollectorTripple."Lesson 1", TTTimetableCollectorTripple."Lesson 2", TTTimetableCollectorTripple."Lesson 3");
                            TTTimetableCollectorTripple1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                            TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                            TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                            IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                            //For Lesson 3
                            TTTimetableCollectorTripple1.RESET;
                            //  TTTimetableCollectorTripple1.SETRANGE(Programme,ACALecturersUnits.Programme);
                            TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                            TTTimetableCollectorTripple1.SETFILTER("Lesson 3", '%1|%2|%3', TTTimetableCollectorTripple."Lesson 1", TTTimetableCollectorTripple."Lesson 2", TTTimetableCollectorTripple."Lesson 3");
                            TTTimetableCollectorTripple1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                            TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                            TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                            IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                            // Delete for the Room/Day/Lesson
                            //For Lesson 1
                            TTTimetableCollectorTripple1.RESET;
                            //  TTTimetableCollectorTripple1.SETRANGE(Programme,ACALecturersUnits.Programme);
                            TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                            TTTimetableCollectorTripple1.SETFILTER("Lesson 1", '%1|%2|%3', TTTimetableCollectorTripple."Lesson 1", TTTimetableCollectorTripple."Lesson 2", TTTimetableCollectorTripple."Lesson 3");
                            TTTimetableCollectorTripple1.SETRANGE("Room Code", TTTimetableCollectorTripple."Room Code");
                            TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                            TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                            IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                            //For Lesson 2
                            TTTimetableCollectorTripple1.RESET;
                            // TTTimetableCollectorTripple1.SETRANGE(Programme,ACALecturersUnits.Programme);
                            TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                            TTTimetableCollectorTripple1.SETFILTER("Lesson 2", '%1|%2|%3', TTTimetableCollectorTripple."Lesson 1", TTTimetableCollectorTripple."Lesson 2", TTTimetableCollectorTripple."Lesson 3");
                            TTTimetableCollectorTripple1.SETRANGE("Room Code", TTTimetableCollectorTripple."Room Code");
                            TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                            TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                            IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                            //For Lesson 3
                            TTTimetableCollectorTripple1.RESET;
                            // TTTimetableCollectorTripple1.SETRANGE(Programme,ACALecturersUnits.Programme);
                            TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                            TTTimetableCollectorTripple1.SETFILTER("Lesson 3", '%1|%2|%3', TTTimetableCollectorTripple."Lesson 1", TTTimetableCollectorTripple."Lesson 2", TTTimetableCollectorTripple."Lesson 3");
                            TTTimetableCollectorTripple1.SETRANGE("Room Code", TTTimetableCollectorTripple."Room Code");
                            TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                            TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                            IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                            /////                          END;
                            // Delete for the Lecturer/Day/Campus/Unit in that Campus
                            TTTimetableCollectorTripple1.RESET;
                            TTTimetableCollectorTripple1.SETRANGE("Class Code", ACALecturersUnits.Class);
                            TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                            TTTimetableCollectorTripple1.SETRANGE(Unit, ACALecturersUnits.Unit);
                            TTTimetableCollectorTripple1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                            TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                            TTTimetableCollectorTripple1.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                            TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                            IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                            //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Tripples for Tripple Lessons
                            //Delete All Unallocated from The Tripples for Lect/Unit/Campus
                            TTTimetableCollectorTripple.RESET;
                            TTTimetableCollectorTripple.SETRANGE("Class Code", ACALecturersUnits.Class);
                            TTTimetableCollectorTripple.SETRANGE(Unit, ACALecturersUnits.Unit);
                            TTTimetableCollectorTripple.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                            TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                            TTTimetableCollectorTripple.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                            TTTimetableCollectorTripple.SETRANGE(Allocated, FALSE);
                            IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                        END ELSE
                            IF TTWeightLessonCategories."Triple Classes" = 2 THEN BEGIN
                                CLEAR(Loops);
                                REPEAT
                                BEGIN
                                    /////////////////////////////////////////////////////////////////////////////////////////////// 2 Tripples
                                    TTTimetableCollectorTripple.RESET;
                                    TTTimetableCollectorTripple.SETRANGE("Class Code", ACALecturersUnits.Class);
                                    TTTimetableCollectorTripple.SETRANGE(Unit, ACALecturersUnits.Unit);
                                    TTTimetableCollectorTripple.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                    TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                    TTTimetableCollectorTripple.SETRANGE(Allocated, FALSE);
                                    TTTimetableCollectorTripple.SETCURRENTKEY("Day Order", "Lesson 1", "Lesson 2", "Lesson 3", "Programme Campus Priority", "Programme Room Priority",
            "Programme Day Priority", "Lecturer Campus Priority", "Lecturer Day Priority",
            "Lecturer Lesson Priority", "Unit Campus Priority", "Unit Room Priority");
                                    IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
                                        TTTimetableCollectorTripple.Allocated := TRUE;
                                        TTTimetableCollectorTripple.MODIFY;
                                    END;

                                    //****************************************************************************************************************************** Delete Collisions on Student Unts
                                    //-- Delete all Allocations for the Programme and Units in the selected Stage Begin
                                    // -Select all Stages and Programmes for the Lecturer and Unit and Class Before Picking Units for the Stage to clear for the given
                                    // Lesson and Next
                                    ACALecturersUnits2.RESET;
                                    ACALecturersUnits2.SETRANGE(Semester, Rec.Semester);
                                    ACALecturersUnits2.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                    ACALecturersUnits2.SETRANGE(Class, ACALecturersUnits.Class);
                                    ACALecturersUnits2.SETRANGE(Unit, ACALecturersUnits.Unit);
                                    IF ACALecturersUnits2.FIND('-') THEN BEGIN
                                        REPEAT
                                        BEGIN
                                            // Pick all Units in the Stage for the Programme & Delete in the Lesson and Next Lessons
                                            ACAUnitsSubjects2.RESET;
                                            ACAUnitsSubjects2.SETRANGE("Programme Code", ACALecturersUnits2.Programme);
                                            ACAUnitsSubjects2.SETRANGE("Stage Code", ACALecturersUnits2.Stage);
                                            IF ACAUnitsSubjects2.FIND('-') THEN BEGIN
                                                REPEAT
                                                BEGIN
                                                    //Delete for 1st Lesson
                                                    TTTimetableCollectorTripple1.RESET;
                                                    TTTimetableCollectorTripple1.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                                    TTTimetableCollectorTripple1.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                                    TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                                                    TTTimetableCollectorTripple1.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                                    TTTimetableCollectorTripple1.SETFILTER("Lesson 1", '%1|%2|%3', TTTimetableCollectorTripple."Lesson 1", TTTimetableCollectorTripple."Lesson 2", TTTimetableCollectorTripple."Lesson 3");
                                                    TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                                                    TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                                                    IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                                                    //Delete for 2nd Lesson
                                                    TTTimetableCollectorTripple1.RESET;
                                                    TTTimetableCollectorTripple1.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                                    TTTimetableCollectorTripple1.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                                    TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                                                    TTTimetableCollectorTripple1.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                                    TTTimetableCollectorTripple1.SETFILTER("Lesson 2", '%1|%2|%3', TTTimetableCollectorTripple."Lesson 1", TTTimetableCollectorTripple."Lesson 2", TTTimetableCollectorTripple."Lesson 3");
                                                    TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                                                    TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                                                    IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                                                    //Delete for 3rd Lesson
                                                    TTTimetableCollectorTripple1.RESET;
                                                    TTTimetableCollectorTripple1.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                                    TTTimetableCollectorTripple1.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                                    TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                                                    TTTimetableCollectorTripple1.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                                    TTTimetableCollectorTripple1.SETFILTER("Lesson 3", '%1|%2|%3', TTTimetableCollectorTripple."Lesson 1", TTTimetableCollectorTripple."Lesson 2", TTTimetableCollectorTripple."Lesson 3");
                                                    TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                                                    TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                                                    IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                                                END;
                                                UNTIL ACAUnitsSubjects2.NEXT = 0;
                                            END;
                                        END;
                                        UNTIL ACALecturersUnits2.NEXT = 0;
                                    END;
                                    //-- Delete all Allocations for the Programme and Units in the selected Stage end
                                    //******************************************************************************************************************************
                                    //Delete fro the Lecturer in a week
                                    TTTimetableCollectorTripple1.RESET;
                                    IF Loops = 0 THEN
                                        TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                                    TTTimetableCollectorTripple1.SETRANGE("Class Code", ACALecturersUnits.Class);
                                    TTTimetableCollectorTripple1.SETRANGE(Unit, ACALecturersUnits.Unit);
                                    TTTimetableCollectorTripple1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                    TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                                    TTTimetableCollectorTripple1.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                                    TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                                    IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                                    //Delete fro the Lecturer/Day/Lesson

                                    //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Doubles for single Lessons
                                    // // // // // // //                        TTLessons.RESET;
                                    // // // // // // //                        TTLessons.SETRANGE("Lesson Code",TTTimetableCollectorA."Lesson Code");
                                    // // // // // // //                        IF TTLessons.FIND('-') THEN BEGIN
                                    // Delete from Doubles for Lect/Day/Lesson
                                    // // // // // // // //                          //For Lesson 1
                                    // // // // // // // //                        TTTimetableCollectorDoubles1.RESET;
                                    // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Programme,ACALecturersUnits.Programme);
                                    // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE("Day of Week",TTTimetableCollectorDoubles."Day of Week");
                                    // // // // // // // //                        TTTimetableCollectorDoubles1.SETFILTER("Lesson 1",'%1|%2',TTTimetableCollectorDoubles."Lesson 1",TTTimetableCollectorDoubles."Lesson 2");
                                    // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                                    // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Semester,Rec.Semester);
                                    // // // // // // // //                        IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                                    // // // // // // // //                        //For Lesson 2
                                    // // // // // // // //                        TTTimetableCollectorDoubles1.RESET;
                                    // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Programme,ACALecturersUnits.Programme);
                                    // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE("Day of Week",TTTimetableCollectorDoubles."Day of Week");
                                    // // // // // // // //                        TTTimetableCollectorDoubles1.SETFILTER("Lesson 2",'%1|%2',TTTimetableCollectorDoubles."Lesson 1",TTTimetableCollectorDoubles."Lesson 2");
                                    // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                                    // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Semester,Rec.Semester);
                                    // // // // // // // //                        IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                                    // // // // // // // //                        // Delete for the Room/Day/Lesson
                                    // // // // // // // //                        //For Lesson 1
                                    // // // // // // // //                        TTTimetableCollectorDoubles1.RESET;
                                    // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Programme,ACALecturersUnits.Programme);
                                    // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE("Day of Week",TTTimetableCollectorDoubles."Day of Week");
                                    // // // // // // // //                        TTTimetableCollectorDoubles1.SETFILTER("Lesson 1",'%1|%2',TTTimetableCollectorDoubles."Lesson 1",TTTimetableCollectorDoubles."Lesson 2");
                                    // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE("Room Code",TTTimetableCollectorDoubles."Room Code");
                                    // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Semester,Rec.Semester);
                                    // // // // // // // //                        IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                                    // // // // // // // //                        //For Lesson 2
                                    // // // // // // // //                        TTTimetableCollectorDoubles1.RESET;
                                    // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Programme,ACALecturersUnits.Programme);
                                    // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE("Day of Week",TTTimetableCollectorDoubles."Day of Week");
                                    // // // // // // // //                        TTTimetableCollectorDoubles1.SETFILTER("Lesson 2",'%1|%2',TTTimetableCollectorDoubles."Lesson 1",TTTimetableCollectorDoubles."Lesson 2");
                                    // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE("Room Code",TTTimetableCollectorDoubles."Room Code");
                                    // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Semester,Rec.Semester);
                                    // // // // // // // //                        IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                                    // // // // // // // //                        //  END;
                                    // // // // // // // //                          // Delete for the Lecturer/Day/Campus/Unit in that Campus
                                    // // // // // // // //                        TTTimetableCollectorDoubles1.RESET;
                                    // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Programme,ACALecturersUnits.Programme);
                                    // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE("Day of Week",TTTimetableCollectorDoubles."Day of Week");
                                    // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Unit,ACALecturersUnits.Unit);
                                    // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                                    // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Semester,Rec.Semester);
                                    // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE("Campus Code",ACALecturersUnits."Campus Code");
                                    // // // // // // // //                        IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                                    //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Doubles for Double Lessons
                                    //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Tripples for Double Lessons

                                    // // // // // //                        TTLessons.RESET;
                                    // // // // // //                        TTLessons.SETRANGE("Lesson Code",TTTimetableCollectorA."Lesson Code");
                                    // // // // // //                        IF TTLessons.FIND('-') THEN BEGIN
                                    // Delete from Tripples for Lect/Day/Lesson
                                    //For Lesson 1
                                    TTTimetableCollectorTripple1.RESET;
                                    //  TTTimetableCollectorTripple1.SETRANGE(Programme,ACALecturersUnits.Programme);
                                    TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                                    TTTimetableCollectorTripple1.SETFILTER("Lesson 1", '%1|%2|%3', TTTimetableCollectorTripple."Lesson 1", TTTimetableCollectorTripple."Lesson 2", TTTimetableCollectorTripple."Lesson 3");
                                    TTTimetableCollectorTripple1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                    TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                                    TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                                    IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                                    //For Lesson 2
                                    TTTimetableCollectorTripple1.RESET;
                                    //  TTTimetableCollectorTripple1.SETRANGE(Programme,ACALecturersUnits.Programme);
                                    TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                                    TTTimetableCollectorTripple1.SETFILTER("Lesson 2", '%1|%2|%3', TTTimetableCollectorTripple."Lesson 1", TTTimetableCollectorTripple."Lesson 2", TTTimetableCollectorTripple."Lesson 3");
                                    TTTimetableCollectorTripple1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                    TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                                    TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                                    IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                                    //For Lesson 3
                                    TTTimetableCollectorTripple1.RESET;
                                    // TTTimetableCollectorTripple1.SETRANGE(Programme,ACALecturersUnits.Programme);
                                    TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                                    TTTimetableCollectorTripple1.SETFILTER("Lesson 3", '%1|%2|%3', TTTimetableCollectorTripple."Lesson 1", TTTimetableCollectorTripple."Lesson 2", TTTimetableCollectorTripple."Lesson 3");
                                    TTTimetableCollectorTripple1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                    TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                                    TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                                    IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                                    // Delete for the Room/Day/Lesson
                                    //For Lesson 1
                                    TTTimetableCollectorTripple1.RESET;
                                    // TTTimetableCollectorTripple1.SETRANGE(Programme,ACALecturersUnits.Programme);
                                    TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                                    TTTimetableCollectorTripple1.SETFILTER("Lesson 1", '%1|%2|%3', TTTimetableCollectorTripple."Lesson 1", TTTimetableCollectorTripple."Lesson 2", TTTimetableCollectorTripple."Lesson 3");
                                    TTTimetableCollectorTripple1.SETRANGE("Room Code", TTTimetableCollectorTripple."Room Code");
                                    TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                                    TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                                    IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                                    //For Lesson 2
                                    TTTimetableCollectorTripple1.RESET;
                                    //   TTTimetableCollectorTripple1.SETRANGE(Programme,ACALecturersUnits.Programme);
                                    TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                                    TTTimetableCollectorTripple1.SETFILTER("Lesson 2", '%1|%2|%3', TTTimetableCollectorTripple."Lesson 1", TTTimetableCollectorTripple."Lesson 2", TTTimetableCollectorTripple."Lesson 3");
                                    TTTimetableCollectorTripple1.SETRANGE("Room Code", TTTimetableCollectorTripple."Room Code");
                                    TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                                    TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                                    IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                                    //For Lesson 3
                                    TTTimetableCollectorTripple1.RESET;
                                    //   TTTimetableCollectorTripple1.SETRANGE(Programme,ACALecturersUnits.Programme);
                                    TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                                    TTTimetableCollectorTripple1.SETFILTER("Lesson 3", '%1|%2|%3', TTTimetableCollectorTripple."Lesson 1", TTTimetableCollectorTripple."Lesson 2", TTTimetableCollectorTripple."Lesson 3");
                                    TTTimetableCollectorTripple1.SETRANGE("Room Code", TTTimetableCollectorTripple."Room Code");
                                    TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                                    TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                                    IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                                    ////////                          END;
                                    // Delete for the Lecturer/Day/Campus/Unit in that Campus
                                    TTTimetableCollectorTripple1.RESET;
                                    TTTimetableCollectorTripple1.SETRANGE("Class Code", ACALecturersUnits.Class);
                                    TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                                    TTTimetableCollectorTripple1.SETRANGE(Unit, ACALecturersUnits.Unit);
                                    TTTimetableCollectorTripple1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                    TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                                    TTTimetableCollectorTripple1.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                                    TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                                    IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                                    //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Tripples for Triple Lessons
                                    //Delete All Unallocated from The Doubles for Lect/Unit/Campus
                                    TTTimetableCollectorTripple1.RESET;
                                    IF Loops = 0 THEN
                                        TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                                    TTTimetableCollectorTripple1.SETRANGE("Class Code", ACALecturersUnits.Class);
                                    TTTimetableCollectorTripple1.SETRANGE(Unit, ACALecturersUnits.Unit);
                                    TTTimetableCollectorTripple1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                    TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                                    TTTimetableCollectorTripple1.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                                    TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                                    IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                                    /////////////////////////////////////////////////////////////////////////////////////////////// 2 Tripples
                                    Loops := Loops + 1;
                                END;
                                UNTIL Loops = 2;
                            END ELSE
                                IF TTWeightLessonCategories."Triple Classes" = 3 THEN BEGIN
                                    CLEAR(Loops);
                                    REPEAT
                                    BEGIN
                                        /////////////////////////////////////////////////////////////////////////////////////////////// 3 Tripples
                                        TTTimetableCollectorTripple.RESET;
                                        TTTimetableCollectorTripple.SETRANGE("Class Code", ACALecturersUnits.Class);
                                        TTTimetableCollectorTripple.SETRANGE(Unit, ACALecturersUnits.Unit);
                                        TTTimetableCollectorTripple.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                        TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
                                        TTTimetableCollectorTripple.SETRANGE(Allocated, FALSE);
                                        TTTimetableCollectorTripple.SETCURRENTKEY("Day Order", "Lesson 1", "Lesson 2", "Lesson 3", "Programme Campus Priority", "Programme Room Priority",
                "Programme Day Priority", "Lecturer Campus Priority", "Lecturer Day Priority",
                "Lecturer Lesson Priority", "Unit Campus Priority", "Unit Room Priority");
                                        IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
                                            TTTimetableCollectorTripple.Allocated := TRUE;
                                            TTTimetableCollectorTripple.MODIFY;
                                        END;

                                        //****************************************************************************************************************************** Delete Collisions on Student Unts
                                        //-- Delete all Allocations for the Programme and Units in the selected Stage Begin
                                        // -Select all Stages and Programmes for the Lecturer and Unit and Class Before Picking Units for the Stage to clear for the given
                                        // Lesson and Next
                                        ACALecturersUnits2.RESET;
                                        ACALecturersUnits2.SETRANGE(Semester, Rec.Semester);
                                        ACALecturersUnits2.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                        ACALecturersUnits2.SETRANGE(Class, ACALecturersUnits.Class);
                                        ACALecturersUnits2.SETRANGE(Unit, ACALecturersUnits.Unit);
                                        IF ACALecturersUnits2.FIND('-') THEN BEGIN
                                            REPEAT
                                            BEGIN
                                                // Pick all Units in the Stage for the Programme & Delete in the Lesson and Next Lessons
                                                ACAUnitsSubjects2.RESET;
                                                ACAUnitsSubjects2.SETRANGE("Programme Code", ACALecturersUnits2.Programme);
                                                ACAUnitsSubjects2.SETRANGE("Stage Code", ACALecturersUnits2.Stage);
                                                IF ACAUnitsSubjects2.FIND('-') THEN BEGIN
                                                    REPEAT
                                                    BEGIN
                                                        //Delete for 1st Lesson
                                                        TTTimetableCollectorTripple1.RESET;
                                                        TTTimetableCollectorTripple1.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                                        TTTimetableCollectorTripple1.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                                        TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                                                        TTTimetableCollectorTripple1.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                                        TTTimetableCollectorTripple1.SETFILTER("Lesson 1", '%1|%2|%3', TTTimetableCollectorTripple."Lesson 1", TTTimetableCollectorTripple."Lesson 2", TTTimetableCollectorTripple."Lesson 3");
                                                        TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                                                        TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                                                        IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                                                        //Delete for 2nd Lesson
                                                        TTTimetableCollectorTripple1.RESET;
                                                        TTTimetableCollectorTripple1.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                                        TTTimetableCollectorTripple1.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                                        TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                                                        TTTimetableCollectorTripple1.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                                        TTTimetableCollectorTripple1.SETFILTER("Lesson 2", '%1|%2|%3', TTTimetableCollectorTripple."Lesson 1", TTTimetableCollectorTripple."Lesson 2", TTTimetableCollectorTripple."Lesson 3");
                                                        TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                                                        TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                                                        IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                                                        //Delete for 3rd Lesson
                                                        TTTimetableCollectorTripple1.RESET;
                                                        TTTimetableCollectorTripple1.SETRANGE(Programme, ACALecturersUnits2.Programme);
                                                        TTTimetableCollectorTripple1.SETRANGE(Unit, ACAUnitsSubjects2.Code);
                                                        TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                                                        TTTimetableCollectorTripple1.SETRANGE("Campus Code", ACALecturersUnits2."Campus Code");
                                                        TTTimetableCollectorTripple1.SETFILTER("Lesson 3", '%1|%2|%3', TTTimetableCollectorTripple."Lesson 1", TTTimetableCollectorTripple."Lesson 2", TTTimetableCollectorTripple."Lesson 3");
                                                        TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                                                        TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                                                        IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                                                    END;
                                                    UNTIL ACAUnitsSubjects2.NEXT = 0;
                                                END;
                                            END;
                                            UNTIL ACALecturersUnits2.NEXT = 0;
                                        END;
                                        //-- Delete all Allocations for the Programme and Units in the selected Stage end
                                        //******************************************************************************************************************************
                                        //Delete fro the Lecturer in a week
                                        TTTimetableCollectorTripple1.RESET;
                                        IF ((Loops = 0) OR (Loops = 1)) THEN
                                            TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                                        TTTimetableCollectorTripple1.SETRANGE("Class Code", ACALecturersUnits.Class);
                                        TTTimetableCollectorTripple1.SETRANGE(Unit, ACALecturersUnits.Unit);
                                        TTTimetableCollectorTripple1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                        TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                                        TTTimetableCollectorTripple1.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                                        TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                                        IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                                        //Delete fro the Lecturer/Day/Lesson

                                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Doubles for Tripple Lessons
                                        // // // // // // //                        TTLessons.RESET;
                                        // // // // // // //                        TTLessons.SETRANGE("Lesson Code",TTTimetableCollectorA."Lesson Code");
                                        // // // // // // //                        IF TTLessons.FIND('-') THEN BEGIN
                                        // Delete from Doubles for Lect/Day/Lesson
                                        // // // // // // // //                          //For Lesson 1
                                        // // // // // // // //                        TTTimetableCollectorDoubles1.RESET;
                                        // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Programme,ACALecturersUnits.Programme);
                                        // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE("Day of Week",TTTimetableCollectorDoubles."Day of Week");
                                        // // // // // // // //                        TTTimetableCollectorDoubles1.SETFILTER("Lesson 1",'%1|%2',TTTimetableCollectorDoubles."Lesson 1",TTTimetableCollectorDoubles."Lesson 2");
                                        // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                                        // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Semester,Rec.Semester);
                                        // // // // // // // //                        IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                                        // // // // // // // //                        //For Lesson 2
                                        // // // // // // // //                        TTTimetableCollectorDoubles1.RESET;
                                        // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Programme,ACALecturersUnits.Programme);
                                        // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE("Day of Week",TTTimetableCollectorDoubles."Day of Week");
                                        // // // // // // // //                        TTTimetableCollectorDoubles1.SETFILTER("Lesson 2",'%1|%2',TTTimetableCollectorDoubles."Lesson 1",TTTimetableCollectorDoubles."Lesson 2");
                                        // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                                        // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Semester,Rec.Semester);
                                        // // // // // // // //                        IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                                        // // // // // // // //                        // Delete for the Room/Day/Lesson
                                        // // // // // // // //                        //For Lesson 1
                                        // // // // // // // //                        TTTimetableCollectorDoubles1.RESET;
                                        // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Programme,ACALecturersUnits.Programme);
                                        // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE("Day of Week",TTTimetableCollectorDoubles."Day of Week");
                                        // // // // // // // //                        TTTimetableCollectorDoubles1.SETFILTER("Lesson 1",'%1|%2',TTTimetableCollectorDoubles."Lesson 1",TTTimetableCollectorDoubles."Lesson 2");
                                        // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE("Room Code",TTTimetableCollectorDoubles."Room Code");
                                        // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Semester,Rec.Semester);
                                        // // // // // // // //                        IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                                        // // // // // // // //                        //For Lesson 2
                                        // // // // // // // //                        TTTimetableCollectorDoubles1.RESET;
                                        // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Programme,ACALecturersUnits.Programme);
                                        // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE("Day of Week",TTTimetableCollectorDoubles."Day of Week");
                                        // // // // // // // //                        TTTimetableCollectorDoubles1.SETFILTER("Lesson 2",'%1|%2',TTTimetableCollectorDoubles."Lesson 1",TTTimetableCollectorDoubles."Lesson 2");
                                        // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE("Room Code",TTTimetableCollectorDoubles."Room Code");
                                        // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Semester,Rec.Semester);
                                        // // // // // // // //                        IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                                        // // // // // // // //                        //  END;
                                        // // // // // // // //                          // Delete for the Lecturer/Day/Campus/Unit in that Campus
                                        // // // // // // // //                        TTTimetableCollectorDoubles1.RESET;
                                        // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Programme,ACALecturersUnits.Programme);
                                        // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE("Day of Week",TTTimetableCollectorDoubles."Day of Week");
                                        // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Unit,ACALecturersUnits.Unit);
                                        // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Lecturer,ACALecturersUnits.Lecturer);
                                        // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE(Semester,Rec.Semester);
                                        // // // // // // // //                        TTTimetableCollectorDoubles1.SETRANGE("Campus Code",ACALecturersUnits."Campus Code");
                                        // // // // // // // //                        IF TTTimetableCollectorDoubles1.FIND('-') THEN TTTimetableCollectorDoubles1.DELETEALL;
                                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Doubles for Tripple Lessons
                                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Tripples for Tripple Lessons

                                        // // // // // //                        TTLessons.RESET;
                                        // // // // // //                        TTLessons.SETRANGE("Lesson Code",TTTimetableCollectorA."Lesson Code");
                                        // // // // // //                        IF TTLessons.FIND('-') THEN BEGIN
                                        // Delete from Tripples for Lect/Day/Lesson
                                        //For Lesson 1
                                        TTTimetableCollectorTripple1.RESET;
                                        //    TTTimetableCollectorTripple1.SETRANGE(Programme,ACALecturersUnits.Programme);
                                        TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                                        TTTimetableCollectorTripple1.SETFILTER("Lesson 1", '%1|%2|%3', TTTimetableCollectorTripple."Lesson 1", TTTimetableCollectorTripple."Lesson 2", TTTimetableCollectorTripple."Lesson 3");
                                        TTTimetableCollectorTripple1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                        TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                                        TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                                        IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                                        //For Lesson 2
                                        TTTimetableCollectorTripple1.RESET;
                                        //  TTTimetableCollectorTripple1.SETRANGE(Programme,ACALecturersUnits.Programme);
                                        TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                                        TTTimetableCollectorTripple1.SETFILTER("Lesson 2", '%1|%2|%3', TTTimetableCollectorTripple."Lesson 1", TTTimetableCollectorTripple."Lesson 2", TTTimetableCollectorTripple."Lesson 3");
                                        TTTimetableCollectorTripple1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                        TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                                        TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                                        IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                                        //For Lesson 3
                                        TTTimetableCollectorTripple1.RESET;
                                        //   TTTimetableCollectorTripple1.SETRANGE(Programme,ACALecturersUnits.Programme);
                                        TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                                        TTTimetableCollectorTripple1.SETFILTER("Lesson 3", '%1|%2|%3', TTTimetableCollectorTripple."Lesson 1", TTTimetableCollectorTripple."Lesson 2", TTTimetableCollectorTripple."Lesson 3");
                                        TTTimetableCollectorTripple1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                        TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                                        TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                                        IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                                        // Delete for the Room/Day/Lesson
                                        //For Lesson 1
                                        TTTimetableCollectorTripple1.RESET;
                                        //    TTTimetableCollectorTripple1.SETRANGE(Programme,ACALecturersUnits.Programme);
                                        TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                                        TTTimetableCollectorTripple1.SETFILTER("Lesson 1", '%1|%2|%3', TTTimetableCollectorTripple."Lesson 1", TTTimetableCollectorTripple."Lesson 2", TTTimetableCollectorTripple."Lesson 3");
                                        TTTimetableCollectorTripple1.SETRANGE("Room Code", TTTimetableCollectorTripple."Room Code");
                                        TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                                        TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                                        IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                                        //For Lesson 2
                                        TTTimetableCollectorTripple1.RESET;
                                        //   TTTimetableCollectorTripple1.SETRANGE(Programme,ACALecturersUnits.Programme);
                                        TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                                        TTTimetableCollectorTripple1.SETFILTER("Lesson 2", '%1|%2|%3', TTTimetableCollectorTripple."Lesson 1", TTTimetableCollectorTripple."Lesson 2", TTTimetableCollectorTripple."Lesson 3");
                                        TTTimetableCollectorTripple1.SETRANGE("Room Code", TTTimetableCollectorTripple."Room Code");
                                        TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                                        TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                                        IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                                        //For Lesson 3
                                        TTTimetableCollectorTripple1.RESET;
                                        //   TTTimetableCollectorTripple1.SETRANGE(Programme,ACALecturersUnits.Programme);
                                        TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                                        TTTimetableCollectorTripple1.SETFILTER("Lesson 3", '%1|%2|%3', TTTimetableCollectorTripple."Lesson 1", TTTimetableCollectorTripple."Lesson 2", TTTimetableCollectorTripple."Lesson 3");
                                        TTTimetableCollectorTripple1.SETRANGE("Room Code", TTTimetableCollectorTripple."Room Code");
                                        TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                                        TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                                        IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                                        ////////                          END;
                                        // Delete for the Lecturer/Day/Campus/Unit in that Campus
                                        TTTimetableCollectorTripple1.RESET;
                                        TTTimetableCollectorTripple1.SETRANGE("Class Code", ACALecturersUnits.Class);
                                        TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                                        TTTimetableCollectorTripple1.SETRANGE(Unit, ACALecturersUnits.Unit);
                                        TTTimetableCollectorTripple1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                        TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                                        TTTimetableCollectorTripple1.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                                        TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                                        IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Thinning on the Tripples for Tripple Lessons
                                        //Delete All Unallocated from The Tripple for Lect/Unit/Campus
                                        TTTimetableCollectorTripple1.RESET;
                                        IF ((Loops = 0) OR (Loops = 1)) THEN
                                            TTTimetableCollectorTripple1.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                                        TTTimetableCollectorTripple1.SETRANGE("Class Code", ACALecturersUnits.Class);
                                        TTTimetableCollectorTripple1.SETRANGE(Unit, ACALecturersUnits.Unit);
                                        TTTimetableCollectorTripple1.SETRANGE(Lecturer, ACALecturersUnits.Lecturer);
                                        TTTimetableCollectorTripple1.SETRANGE(Semester, Rec.Semester);
                                        TTTimetableCollectorTripple1.SETRANGE("Campus Code", ACALecturersUnits."Campus Code");
                                        TTTimetableCollectorTripple1.SETRANGE(Allocated, FALSE);
                                        IF TTTimetableCollectorTripple1.FIND('-') THEN TTTimetableCollectorTripple1.DELETEALL;
                                        /////////////////////////////////////////////////////////////////////////////////////////////// 3 Tripple
                                        Loops := Loops + 1;
                                    END;
                                    UNTIL Loops = 3;
                                END;

                END;
            END;
            UNTIL ACALecturersUnits.NEXT = 0;
        END;
        progre.CLOSE;
    end;

    local procedure FinalCompilation()
    var
        TTRooms: Record "TT-Rooms";
        TTDailyLessons: Record 74503;
        ACALecturersUnits: Record "ACA-Lecturers Units";
        LectLoadBatchLines: Record 65201;
        ACAProgramme: Record 61511;
        ACAUnitsSubjects: Record 61517;
        TTUnits: Record "TT-Units";
        TTLessons: Record 74520;
        TTDays: Record 74502;
        TTLessons1: Record 74520;
        TTLessons2: Record 74520;
        TTLessons3: Record 74520;
        TTWeightLessonCategories: Record "TT-Weight Lesson Categories";
        TTTimetableCollectorA: Record 74500;
        TTTimetableCollectorA1: Record 74500;
        TTTimetableCollectorA2: Record 74500;
        TTTimetableCollectorA3: Record 74500;
        TTTimetableCollectorDoubles: Record 74521;
        TTTimetableCollectorDoubles1: Record 74521;
        TTTimetableCollectorDoubles2: Record 74521;
        TTTimetableCollectorTripple: Record 74522;
        TTTimetableCollectorTripple1: Record 74522;
        TTTimetableCollectorTripple2: Record 74522;
        Loops: Integer;
        TTTimetableFInalCollector: Record 74523;
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
        //prempTrns: Record 61091;
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
                BufferString := 'Total Singles processed = ' + FORMAT(counts);

                progre.UPDATE();
                //SLEEP(50);
                ///////////////////////////////////////////////////////////////////////////////Progress Update
                TTTimetableFInalCollector.RESET;
                TTTimetableFInalCollector.SETRANGE(Programme, TTTimetableCollectorA.Programme);
                TTTimetableFInalCollector.SETRANGE(Unit, TTTimetableCollectorA.Unit);
                TTTimetableFInalCollector.SETRANGE(Semester, Rec.Semester);
                TTTimetableFInalCollector.SETRANGE("Lesson Code", TTTimetableCollectorA."Lesson Code");
                TTTimetableFInalCollector.SETRANGE("Day of Week", TTTimetableCollectorA."Day of Week");
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
                    TTTimetableFInalCollector."Lesson Code" := TTTimetableCollectorA."Lesson Code";
                    TTTimetableFInalCollector."Lesson Category" := TTTimetableCollectorA."Lesson Category";
                    TTTimetableFInalCollector."Day of Week" := TTTimetableCollectorA."Day of Week";
                    TTTimetableFInalCollector."Lecture Room" := TTTimetableCollectorA."Room Code";
                    TTTimetableFInalCollector.Lecturer := TTTimetableCollectorA.Lecturer;
                    TTTimetableFInalCollector.Department := TTTimetableCollectorA.Department;
                    TTTimetableFInalCollector."Day Order" := TTTimetableCollectorA."Day Order";
                    TTTimetableFInalCollector."Lesson Order" := TTTimetableCollectorA."Lesson Order";
                    TTTimetableFInalCollector."Class Code" := TTTimetableCollectorA."Class Code";
                    //  TTTimetableFInalCollector."Programme Option":=;
                    TTTimetableFInalCollector."Room Type" := TTTimetableCollectorA."Room Type";
                    TTTimetableFInalCollector."Room Code" := TTTimetableCollectorA."Room Code";
                    TTTimetableFInalCollector."Block/Building" := TTTimetableCollectorA."Block/Building";
                    TTTimetableFInalCollector."School or Faculty" := TTTimetableCollectorA."School or Faculty";
                    TTTimetableFInalCollector."Campus Code" := TTTimetableCollectorA."Campus Code";
                    TTTimetableFInalCollector."Lesson Type" := 'SINGLE';
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
        //Capture the Doubles
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
        progre.OPEN('Finalizing Doubles:  #1#############################' +
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
        TTTimetableCollectorDoubles.RESET;
        TTTimetableCollectorDoubles.SETRANGE(Semester, Rec.Semester);
        TTTimetableCollectorDoubles.SETRANGE(Allocated, TRUE);
        IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
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
                    RecCount1 := FORMAT(counts) + '). Lecturer: ' + TTTimetableCollectorDoubles.Lecturer + '; Programme: ' + TTTimetableCollectorDoubles.Programme + '; Unit: ' +
                TTTimetableCollectorDoubles.Unit + '; Campus: ' + TTTimetableCollectorDoubles."Campus Code"
                ELSE
                    IF counts = 2 THEN BEGIN
                        RecCount2 := FORMAT(counts) + '). Lecturer: ' + TTTimetableCollectorDoubles.Lecturer + '; Programme: ' + TTTimetableCollectorDoubles.Programme + '; Unit: ' +
                    TTTimetableCollectorDoubles.Unit + '; Campus: ' + TTTimetableCollectorDoubles."Campus Code"
                    END
                    ELSE
                        IF counts = 3 THEN BEGIN
                            RecCount3 := FORMAT(counts) + '). Lecturer: ' + TTTimetableCollectorDoubles.Lecturer + '; Programme: ' + TTTimetableCollectorDoubles.Programme + '; Unit: ' +
                        TTTimetableCollectorDoubles.Unit + '; Campus: ' + TTTimetableCollectorDoubles."Campus Code"
                        END
                        ELSE
                            IF counts = 4 THEN BEGIN
                                RecCount4 := FORMAT(counts) + '). Lecturer: ' + TTTimetableCollectorDoubles.Lecturer + '; Programme: ' + TTTimetableCollectorDoubles.Programme + '; Unit: ' +
                            TTTimetableCollectorDoubles.Unit + '; Campus: ' + TTTimetableCollectorDoubles."Campus Code"
                            END
                            ELSE
                                IF counts = 5 THEN BEGIN
                                    RecCount5 := FORMAT(counts) + '). Lecturer: ' + TTTimetableCollectorDoubles.Lecturer + '; Programme: ' + TTTimetableCollectorDoubles.Programme + '; Unit: ' +
                                TTTimetableCollectorDoubles.Unit + '; Campus: ' + TTTimetableCollectorDoubles."Campus Code"
                                END
                                ELSE
                                    IF counts = 6 THEN BEGIN
                                        RecCount6 := FORMAT(counts) + '). Lecturer: ' + TTTimetableCollectorDoubles.Lecturer + '; Programme: ' + TTTimetableCollectorDoubles.Programme + '; Unit: ' +
                                    TTTimetableCollectorDoubles.Unit + '; Campus: ' + TTTimetableCollectorDoubles."Campus Code"
                                    END
                                    ELSE
                                        IF counts = 7 THEN BEGIN
                                            RecCount7 := FORMAT(counts) + '). Lecturer: ' + TTTimetableCollectorDoubles.Lecturer + '; Programme: ' + TTTimetableCollectorDoubles.Programme + '; Unit: ' +
                                        TTTimetableCollectorDoubles.Unit + '; Campus: ' + TTTimetableCollectorDoubles."Campus Code"
                                        END
                                        ELSE
                                            IF counts = 8 THEN BEGIN
                                                RecCount8 := FORMAT(counts) + '). Lecturer: ' + TTTimetableCollectorDoubles.Lecturer + '; Programme: ' + TTTimetableCollectorDoubles.Programme + '; Unit: ' +
                                            TTTimetableCollectorDoubles.Unit + '; Campus: ' + TTTimetableCollectorDoubles."Campus Code"
                                            END
                                            ELSE
                                                IF counts = 9 THEN BEGIN
                                                    RecCount9 := FORMAT(counts) + '). Lecturer: ' + TTTimetableCollectorDoubles.Lecturer + '; Programme: ' + TTTimetableCollectorDoubles.Programme + '; Unit: ' +
                                                TTTimetableCollectorDoubles.Unit + '; Campus: ' + TTTimetableCollectorDoubles."Campus Code"
                                                END
                                                ELSE
                                                    IF counts = 10 THEN BEGIN
                                                        RecCount10 := FORMAT(counts) + '). Lecturer: ' + TTTimetableCollectorDoubles.Lecturer + '; Programme: ' + TTTimetableCollectorDoubles.Programme + '; Unit: ' +
                                                    TTTimetableCollectorDoubles.Unit + '; Campus: ' + TTTimetableCollectorDoubles."Campus Code"
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
                                                            RecCount10 := FORMAT(counts) + '). Lecturer: ' + TTTimetableCollectorDoubles.Lecturer + '; Programme: ' + TTTimetableCollectorDoubles.Programme + '; Unit: ' +
                                                        TTTimetableCollectorDoubles.Unit + '; Campus: ' + TTTimetableCollectorDoubles."Campus Code";
                                                        END;
                CLEAR(BufferString);
                BufferString := 'Total Tripples processed = ' + FORMAT(counts);

                progre.UPDATE();
                //SLEEP(50);
                ///////////////////////////////////////////////////////////////////////////////Progress Update
                TTLessons1.RESET;
                TTLessons1.SETRANGE("Lesson Order", TTTimetableCollectorDoubles."Lesson 1");
                IF TTLessons1.FIND('-') THEN BEGIN
                    TTTimetableFInalCollector.RESET;
                    TTTimetableFInalCollector.SETRANGE(Programme, TTTimetableCollectorDoubles.Programme);
                    TTTimetableFInalCollector.SETRANGE(Unit, TTTimetableCollectorDoubles.Unit);
                    TTTimetableFInalCollector.SETRANGE(Semester, Rec.Semester);
                    TTTimetableFInalCollector.SETRANGE("Lesson Code", TTLessons1."Lesson Code");
                    TTTimetableFInalCollector.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                    TTTimetableFInalCollector.SETRANGE("Lecture Room", TTTimetableCollectorDoubles."Lecture Room");
                    TTTimetableFInalCollector.SETRANGE(Lecturer, TTTimetableCollectorDoubles.Lecturer);
                    // TTTimetableFInalCollector.SETRANGE("Campus Code",ACALecturersUnits.);
                    // TTTimetableFInalCollector.SETRANGE(Department,LectLoadBatchLines,Department);
                    TTTimetableFInalCollector.SETRANGE("Room Code", TTTimetableCollectorDoubles."Room Code");
                    TTTimetableFInalCollector.SETRANGE("Block/Building", TTTimetableCollectorDoubles."Block/Building");
                    // TTTimetableFInalCollector.SETRANGE("Lesson Category",TTUnits."Weighting Category");
                    // TTTimetableFInalCollector.SETRANGE("School or Faculty",LectLoadBatchLines.Faculty);
                    IF NOT (TTTimetableFInalCollector.FIND('-')) THEN BEGIN
                        TTTimetableFInalCollector.INIT;
                        TTTimetableFInalCollector.Programme := TTTimetableCollectorDoubles.Programme;
                        TTTimetableFInalCollector.Unit := TTTimetableCollectorDoubles.Unit;
                        TTTimetableFInalCollector.Semester := Rec.Semester;
                        TTTimetableFInalCollector."Lesson Code" := TTLessons1."Lesson Code";
                        TTTimetableFInalCollector."Lesson Category" := TTTimetableCollectorDoubles."Lesson Category";
                        TTTimetableFInalCollector."Day of Week" := TTTimetableCollectorDoubles."Day of Week";
                        TTTimetableFInalCollector."Lecture Room" := TTTimetableCollectorDoubles."Room Code";
                        TTTimetableFInalCollector.Lecturer := TTTimetableCollectorDoubles.Lecturer;
                        TTTimetableFInalCollector.Department := TTTimetableCollectorDoubles.Department;
                        TTTimetableFInalCollector."Day Order" := TTTimetableCollectorDoubles."Day Order";
                        TTTimetableFInalCollector."Lesson Order" := TTLessons1."Lesson Order";
                        //  TTTimetableFInalCollector."Programme Option":=;
                        TTTimetableFInalCollector."Room Type" := TTTimetableCollectorDoubles."Room Type";
                        TTTimetableFInalCollector."Class Code" := TTTimetableCollectorDoubles."Class Code";
                        TTTimetableFInalCollector."Room Code" := TTTimetableCollectorDoubles."Room Code";
                        TTTimetableFInalCollector."Block/Building" := TTTimetableCollectorDoubles."Block/Building";
                        TTTimetableFInalCollector."School or Faculty" := TTTimetableCollectorDoubles."School or Faculty";
                        TTTimetableFInalCollector."Campus Code" := TTTimetableCollectorDoubles."Campus Code";
                        TTTimetableFInalCollector."Lesson Type" := 'DOUBLE';
                        IF ((Rec.Semester <> '') AND (TTTimetableCollectorDoubles."Room Code" <> '') AND (TTTimetableCollectorDoubles.Lecturer <> '')) THEN BEGIN
                            CountedEntries := CountedEntries + 1;
                            TTTimetableFInalCollector."Record ID" := CountedEntries;
                            TTTimetableFInalCollector.INSERT;
                        END;
                    END;
                END;

                TTLessons2.RESET;
                TTLessons2.SETRANGE("Lesson Order", TTTimetableCollectorDoubles."Lesson 2");
                IF TTLessons2.FIND('-') THEN BEGIN
                    TTTimetableFInalCollector.RESET;
                    TTTimetableFInalCollector.SETRANGE(Programme, TTTimetableCollectorDoubles.Programme);
                    TTTimetableFInalCollector.SETRANGE(Unit, TTTimetableCollectorDoubles.Unit);
                    TTTimetableFInalCollector.SETRANGE(Semester, Rec.Semester);
                    TTTimetableFInalCollector.SETRANGE("Lesson Code", TTLessons2."Lesson Code");
                    TTTimetableFInalCollector.SETRANGE("Day of Week", TTTimetableCollectorDoubles."Day of Week");
                    TTTimetableFInalCollector.SETRANGE("Lecture Room", TTTimetableCollectorDoubles."Lecture Room");
                    TTTimetableFInalCollector.SETRANGE(Lecturer, TTTimetableCollectorDoubles.Lecturer);
                    // TTTimetableFInalCollector.SETRANGE("Campus Code",ACALecturersUnits.);
                    // TTTimetableFInalCollector.SETRANGE(Department,LectLoadBatchLines,Department);
                    TTTimetableFInalCollector.SETRANGE("Room Code", TTTimetableCollectorDoubles."Room Code");
                    TTTimetableFInalCollector.SETRANGE("Block/Building", TTTimetableCollectorDoubles."Block/Building");
                    // TTTimetableFInalCollector.SETRANGE("Lesson Category",TTUnits."Weighting Category");
                    // TTTimetableFInalCollector.SETRANGE("School or Faculty",LectLoadBatchLines.Faculty);
                    IF NOT (TTTimetableFInalCollector.FIND('-')) THEN BEGIN
                        TTTimetableFInalCollector.INIT;
                        TTTimetableFInalCollector.Programme := TTTimetableCollectorDoubles.Programme;
                        TTTimetableFInalCollector.Unit := TTTimetableCollectorDoubles.Unit;
                        TTTimetableFInalCollector.Semester := Rec.Semester;
                        TTTimetableFInalCollector."Lesson Code" := TTLessons2."Lesson Code";
                        TTTimetableFInalCollector."Lesson Category" := TTTimetableCollectorDoubles."Lesson Category";
                        TTTimetableFInalCollector."Day of Week" := TTTimetableCollectorDoubles."Day of Week";
                        TTTimetableFInalCollector."Lecture Room" := TTTimetableCollectorDoubles."Room Code";
                        TTTimetableFInalCollector.Lecturer := TTTimetableCollectorDoubles.Lecturer;
                        TTTimetableFInalCollector.Department := TTTimetableCollectorDoubles.Department;
                        TTTimetableFInalCollector."Class Code" := TTTimetableCollectorDoubles."Class Code";
                        TTTimetableFInalCollector."Day Order" := TTTimetableCollectorDoubles."Day Order";
                        TTTimetableFInalCollector."Lesson Order" := TTLessons2."Lesson Order";
                        //  TTTimetableFInalCollector."Programme Option":=;
                        TTTimetableFInalCollector."Room Type" := TTTimetableCollectorDoubles."Room Type";
                        TTTimetableFInalCollector."Room Code" := TTTimetableCollectorDoubles."Room Code";
                        TTTimetableFInalCollector."Block/Building" := TTTimetableCollectorDoubles."Block/Building";
                        TTTimetableFInalCollector."School or Faculty" := TTTimetableCollectorDoubles."School or Faculty";
                        TTTimetableFInalCollector."Campus Code" := TTTimetableCollectorDoubles."Campus Code";
                        TTTimetableFInalCollector."Lesson Type" := 'DOUBLE';
                        IF ((Rec.Semester <> '') AND (TTTimetableCollectorDoubles."Room Code" <> '') AND (TTTimetableCollectorDoubles.Lecturer <> '')) THEN BEGIN
                            CountedEntries := CountedEntries + 1;
                            TTTimetableFInalCollector."Record ID" := CountedEntries;
                            TTTimetableFInalCollector.INSERT;
                        END;
                    END;
                END;
            END;
            UNTIL TTTimetableCollectorDoubles.NEXT = 0;
        END;
        progre.CLOSE;
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
        progre.OPEN('Finalizing Tripples:  #1#############################' +
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
        //Capture the Tripples
        TTTimetableCollectorTripple.RESET;
        TTTimetableCollectorTripple.SETRANGE(Semester, Rec.Semester);
        TTTimetableCollectorTripple.SETRANGE(Allocated, TRUE);
        IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
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
                    RecCount1 := FORMAT(counts) + '). Lecturer: ' + TTTimetableCollectorTripple.Lecturer + '; Programme: ' + TTTimetableCollectorTripple.Programme + '; Unit: ' +
                TTTimetableCollectorTripple.Unit + '; Campus: ' + TTTimetableCollectorTripple."Campus Code"
                ELSE
                    IF counts = 2 THEN BEGIN
                        RecCount2 := FORMAT(counts) + '). Lecturer: ' + TTTimetableCollectorTripple.Lecturer + '; Programme: ' + TTTimetableCollectorTripple.Programme + '; Unit: ' +
                    TTTimetableCollectorTripple.Unit + '; Campus: ' + TTTimetableCollectorTripple."Campus Code"
                    END
                    ELSE
                        IF counts = 3 THEN BEGIN
                            RecCount3 := FORMAT(counts) + '). Lecturer: ' + TTTimetableCollectorTripple.Lecturer + '; Programme: ' + TTTimetableCollectorTripple.Programme + '; Unit: ' +
                        TTTimetableCollectorTripple.Unit + '; Campus: ' + TTTimetableCollectorTripple."Campus Code"
                        END
                        ELSE
                            IF counts = 4 THEN BEGIN
                                RecCount4 := FORMAT(counts) + '). Lecturer: ' + TTTimetableCollectorTripple.Lecturer + '; Programme: ' + TTTimetableCollectorTripple.Programme + '; Unit: ' +
                            TTTimetableCollectorTripple.Unit + '; Campus: ' + TTTimetableCollectorTripple."Campus Code"
                            END
                            ELSE
                                IF counts = 5 THEN BEGIN
                                    RecCount5 := FORMAT(counts) + '). Lecturer: ' + TTTimetableCollectorTripple.Lecturer + '; Programme: ' + TTTimetableCollectorTripple.Programme + '; Unit: ' +
                                TTTimetableCollectorTripple.Unit + '; Campus: ' + TTTimetableCollectorTripple."Campus Code"
                                END
                                ELSE
                                    IF counts = 6 THEN BEGIN
                                        RecCount6 := FORMAT(counts) + '). Lecturer: ' + TTTimetableCollectorTripple.Lecturer + '; Programme: ' + TTTimetableCollectorTripple.Programme + '; Unit: ' +
                                    TTTimetableCollectorTripple.Unit + '; Campus: ' + TTTimetableCollectorTripple."Campus Code"
                                    END
                                    ELSE
                                        IF counts = 7 THEN BEGIN
                                            RecCount7 := FORMAT(counts) + '). Lecturer: ' + TTTimetableCollectorTripple.Lecturer + '; Programme: ' + TTTimetableCollectorTripple.Programme + '; Unit: ' +
                                        TTTimetableCollectorTripple.Unit + '; Campus: ' + TTTimetableCollectorTripple."Campus Code"
                                        END
                                        ELSE
                                            IF counts = 8 THEN BEGIN
                                                RecCount8 := FORMAT(counts) + '). Lecturer: ' + TTTimetableCollectorTripple.Lecturer + '; Programme: ' + TTTimetableCollectorTripple.Programme + '; Unit: ' +
                                            TTTimetableCollectorTripple.Unit + '; Campus: ' + TTTimetableCollectorTripple."Campus Code"
                                            END
                                            ELSE
                                                IF counts = 9 THEN BEGIN
                                                    RecCount9 := FORMAT(counts) + '). Lecturer: ' + TTTimetableCollectorTripple.Lecturer + '; Programme: ' + TTTimetableCollectorTripple.Programme + '; Unit: ' +
                                                TTTimetableCollectorTripple.Unit + '; Campus: ' + TTTimetableCollectorTripple."Campus Code"
                                                END
                                                ELSE
                                                    IF counts = 10 THEN BEGIN
                                                        RecCount10 := FORMAT(counts) + '). Lecturer: ' + TTTimetableCollectorTripple.Lecturer + '; Programme: ' + TTTimetableCollectorTripple.Programme + '; Unit: ' +
                                                    TTTimetableCollectorTripple.Unit + '; Campus: ' + TTTimetableCollectorTripple."Campus Code"
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
                                                            RecCount10 := FORMAT(counts) + '). Lecturer: ' + TTTimetableCollectorTripple.Lecturer + '; Programme: ' + TTTimetableCollectorTripple.Programme + '; Unit: ' +
                                                        TTTimetableCollectorTripple.Unit + '; Campus: ' + TTTimetableCollectorTripple."Campus Code";
                                                        END;
                CLEAR(BufferString);
                BufferString := 'Total Tripples processed = ' + FORMAT(counts);

                progre.UPDATE();
                //SLEEP(50);
                ///////////////////////////////////////////////////////////////////////////////Progress Update
                TTLessons1.RESET;
                TTLessons1.SETRANGE("Lesson Order", TTTimetableCollectorTripple."Lesson 1");
                IF TTLessons1.FIND('-') THEN BEGIN
                    TTTimetableFInalCollector.RESET;
                    TTTimetableFInalCollector.SETRANGE(Programme, TTTimetableCollectorTripple.Programme);
                    TTTimetableFInalCollector.SETRANGE(Unit, TTTimetableCollectorTripple.Unit);
                    TTTimetableFInalCollector.SETRANGE(Semester, Rec.Semester);
                    TTTimetableFInalCollector.SETRANGE("Lesson Code", TTLessons1."Lesson Code");
                    TTTimetableFInalCollector.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                    TTTimetableFInalCollector.SETRANGE("Lecture Room", TTTimetableCollectorTripple."Lecture Room");
                    TTTimetableFInalCollector.SETRANGE(Lecturer, TTTimetableCollectorTripple.Lecturer);
                    // TTTimetableFInalCollector.SETRANGE("Campus Code",ACALecturersUnits.);
                    // TTTimetableFInalCollector.SETRANGE(Department,LectLoadBatchLines,Department);
                    TTTimetableFInalCollector.SETRANGE("Room Code", TTTimetableCollectorTripple."Room Code");
                    TTTimetableFInalCollector.SETRANGE("Block/Building", TTTimetableCollectorTripple."Block/Building");
                    // TTTimetableFInalCollector.SETRANGE("Lesson Category",TTUnits."Weighting Category");
                    // TTTimetableFInalCollector.SETRANGE("School or Faculty",LectLoadBatchLines.Faculty);
                    IF NOT (TTTimetableFInalCollector.FIND('-')) THEN BEGIN
                        TTTimetableFInalCollector.INIT;
                        TTTimetableFInalCollector.Programme := TTTimetableCollectorTripple.Programme;
                        TTTimetableFInalCollector.Unit := TTTimetableCollectorTripple.Unit;
                        TTTimetableFInalCollector.Semester := Rec.Semester;
                        TTTimetableFInalCollector."Lesson Code" := TTLessons1."Lesson Code";
                        TTTimetableFInalCollector."Lesson Category" := TTTimetableCollectorTripple."Lesson Category";
                        TTTimetableFInalCollector."Day of Week" := TTTimetableCollectorTripple."Day of Week";
                        TTTimetableFInalCollector."Lecture Room" := TTTimetableCollectorTripple."Room Code";
                        TTTimetableFInalCollector.Lecturer := TTTimetableCollectorTripple.Lecturer;
                        TTTimetableFInalCollector.Department := TTTimetableCollectorTripple.Department;
                        TTTimetableFInalCollector."Day Order" := TTTimetableCollectorTripple."Day Order";
                        TTTimetableFInalCollector."Class Code" := TTTimetableCollectorTripple."Class Code";
                        TTTimetableFInalCollector."Lesson Order" := TTLessons1."Lesson Order";
                        //  TTTimetableFInalCollector."Programme Option":=;
                        TTTimetableFInalCollector."Room Type" := TTTimetableCollectorTripple."Room Type";
                        TTTimetableFInalCollector."Room Code" := TTTimetableCollectorTripple."Room Code";
                        TTTimetableFInalCollector."Block/Building" := TTTimetableCollectorTripple."Block/Building";
                        TTTimetableFInalCollector."School or Faculty" := TTTimetableCollectorTripple."School or Faculty";
                        TTTimetableFInalCollector."Campus Code" := TTTimetableCollectorTripple."Campus Code";
                        TTTimetableFInalCollector."Lesson Type" := 'TRIPPLE';
                        IF ((Rec.Semester <> '') AND (TTTimetableCollectorTripple."Room Code" <> '') AND (TTTimetableCollectorTripple.Lecturer <> '')) THEN BEGIN
                            CountedEntries := CountedEntries + 1;
                            TTTimetableFInalCollector."Record ID" := CountedEntries;
                            TTTimetableFInalCollector.INSERT;
                        END;
                    END;
                END;

                TTLessons2.RESET;
                TTLessons2.SETRANGE("Lesson Order", TTTimetableCollectorTripple."Lesson 2");
                IF TTLessons2.FIND('-') THEN BEGIN
                    TTTimetableFInalCollector.RESET;
                    TTTimetableFInalCollector.SETRANGE(Programme, TTTimetableCollectorTripple.Programme);
                    TTTimetableFInalCollector.SETRANGE(Unit, TTTimetableCollectorTripple.Unit);
                    TTTimetableFInalCollector.SETRANGE(Semester, Rec.Semester);
                    TTTimetableFInalCollector.SETRANGE("Lesson Code", TTLessons2."Lesson Code");
                    TTTimetableFInalCollector.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                    TTTimetableFInalCollector.SETRANGE("Lecture Room", TTTimetableCollectorTripple."Lecture Room");
                    TTTimetableFInalCollector.SETRANGE(Lecturer, TTTimetableCollectorTripple.Lecturer);
                    // TTTimetableFInalCollector.SETRANGE("Campus Code",ACALecturersUnits.);
                    // TTTimetableFInalCollector.SETRANGE(Department,LectLoadBatchLines,Department);
                    TTTimetableFInalCollector.SETRANGE("Room Code", TTTimetableCollectorTripple."Room Code");
                    TTTimetableFInalCollector.SETRANGE("Block/Building", TTTimetableCollectorTripple."Block/Building");
                    // TTTimetableFInalCollector.SETRANGE("Lesson Category",TTUnits."Weighting Category");
                    // TTTimetableFInalCollector.SETRANGE("School or Faculty",LectLoadBatchLines.Faculty);
                    IF NOT (TTTimetableFInalCollector.FIND('-')) THEN BEGIN
                        TTTimetableFInalCollector.INIT;
                        TTTimetableFInalCollector.Programme := TTTimetableCollectorTripple.Programme;
                        TTTimetableFInalCollector.Unit := TTTimetableCollectorTripple.Unit;
                        TTTimetableFInalCollector.Semester := Rec.Semester;
                        TTTimetableFInalCollector."Lesson Code" := TTLessons2."Lesson Code";
                        TTTimetableFInalCollector."Lesson Category" := TTTimetableCollectorTripple."Lesson Category";
                        TTTimetableFInalCollector."Day of Week" := TTTimetableCollectorTripple."Day of Week";
                        TTTimetableFInalCollector."Lecture Room" := TTTimetableCollectorTripple."Room Code";
                        TTTimetableFInalCollector.Lecturer := TTTimetableCollectorTripple.Lecturer;
                        TTTimetableFInalCollector.Department := TTTimetableCollectorTripple.Department;
                        TTTimetableFInalCollector."Day Order" := TTTimetableCollectorTripple."Day Order";
                        TTTimetableFInalCollector."Class Code" := TTTimetableCollectorTripple."Class Code";
                        TTTimetableFInalCollector."Lesson Order" := TTLessons2."Lesson Order";
                        //  TTTimetableFInalCollector."Programme Option":=;
                        TTTimetableFInalCollector."Room Type" := TTTimetableCollectorTripple."Room Type";
                        TTTimetableFInalCollector."Room Code" := TTTimetableCollectorTripple."Room Code";
                        TTTimetableFInalCollector."Block/Building" := TTTimetableCollectorTripple."Block/Building";
                        TTTimetableFInalCollector."School or Faculty" := TTTimetableCollectorTripple."School or Faculty";
                        TTTimetableFInalCollector."Campus Code" := TTTimetableCollectorTripple."Campus Code";
                        TTTimetableFInalCollector."Lesson Type" := 'TRIPPLE';
                        IF ((Rec.Semester <> '') AND (TTTimetableCollectorTripple."Room Code" <> '') AND (TTTimetableCollectorTripple.Lecturer <> '')) THEN BEGIN
                            CountedEntries := CountedEntries + 1;
                            TTTimetableFInalCollector."Record ID" := CountedEntries;
                            TTTimetableFInalCollector.INSERT;
                        END;
                    END;
                END;
                TTLessons3.RESET;
                TTLessons3.SETRANGE("Lesson Order", TTTimetableCollectorTripple."Lesson 3");
                IF TTLessons3.FIND('-') THEN BEGIN
                    TTTimetableFInalCollector.RESET;
                    TTTimetableFInalCollector.SETRANGE(Programme, TTTimetableCollectorTripple.Programme);
                    TTTimetableFInalCollector.SETRANGE(Unit, TTTimetableCollectorTripple.Unit);
                    TTTimetableFInalCollector.SETRANGE(Semester, Rec.Semester);
                    TTTimetableFInalCollector.SETRANGE("Lesson Code", TTLessons3."Lesson Code");
                    TTTimetableFInalCollector.SETRANGE("Day of Week", TTTimetableCollectorTripple."Day of Week");
                    TTTimetableFInalCollector.SETRANGE("Lecture Room", TTTimetableCollectorTripple."Lecture Room");
                    TTTimetableFInalCollector.SETRANGE(Lecturer, TTTimetableCollectorTripple.Lecturer);
                    // TTTimetableFInalCollector.SETRANGE("Campus Code",ACALecturersUnits.);
                    // TTTimetableFInalCollector.SETRANGE(Department,LectLoadBatchLines,Department);
                    TTTimetableFInalCollector.SETRANGE("Room Code", TTTimetableCollectorTripple."Room Code");
                    TTTimetableFInalCollector.SETRANGE("Block/Building", TTTimetableCollectorTripple."Block/Building");
                    // TTTimetableFInalCollector.SETRANGE("Lesson Category",TTUnits."Weighting Category");
                    // TTTimetableFInalCollector.SETRANGE("School or Faculty",LectLoadBatchLines.Faculty);
                    IF NOT (TTTimetableFInalCollector.FIND('-')) THEN BEGIN
                        TTTimetableFInalCollector.INIT;
                        TTTimetableFInalCollector.Programme := TTTimetableCollectorTripple.Programme;
                        TTTimetableFInalCollector.Unit := TTTimetableCollectorTripple.Unit;
                        TTTimetableFInalCollector.Semester := Rec.Semester;
                        TTTimetableFInalCollector."Lesson Code" := TTLessons3."Lesson Code";
                        TTTimetableFInalCollector."Lesson Category" := TTTimetableCollectorTripple."Lesson Category";
                        TTTimetableFInalCollector."Day of Week" := TTTimetableCollectorTripple."Day of Week";
                        TTTimetableFInalCollector."Lecture Room" := TTTimetableCollectorTripple."Room Code";
                        TTTimetableFInalCollector.Lecturer := TTTimetableCollectorTripple.Lecturer;
                        TTTimetableFInalCollector.Department := TTTimetableCollectorTripple.Department;
                        TTTimetableFInalCollector."Day Order" := TTTimetableCollectorTripple."Day Order";
                        TTTimetableFInalCollector."Class Code" := TTTimetableCollectorTripple."Class Code";
                        TTTimetableFInalCollector."Lesson Order" := TTLessons3."Lesson Order";
                        //  TTTimetableFInalCollector."Programme Option":=;
                        TTTimetableFInalCollector."Room Type" := TTTimetableCollectorTripple."Room Type";
                        TTTimetableFInalCollector."Room Code" := TTTimetableCollectorTripple."Room Code";
                        TTTimetableFInalCollector."Block/Building" := TTTimetableCollectorTripple."Block/Building";
                        TTTimetableFInalCollector."School or Faculty" := TTTimetableCollectorTripple."School or Faculty";
                        TTTimetableFInalCollector."Campus Code" := TTTimetableCollectorTripple."Campus Code";
                        TTTimetableFInalCollector."Lesson Type" := 'TRIPPLE';
                        IF ((Rec.Semester <> '') AND (TTTimetableCollectorTripple."Room Code" <> '') AND (TTTimetableCollectorTripple.Lecturer <> '')) THEN BEGIN
                            CountedEntries := CountedEntries + 1;
                            TTTimetableFInalCollector."Record ID" := CountedEntries;
                            TTTimetableFInalCollector.INSERT;
                        END;
                    END;
                END;
            END;
            UNTIL TTTimetableCollectorTripple.NEXT = 0;
        END;
        progre.CLOSE;
    end;

    local procedure SpecificConstraintsProgCampuses()
    var
        TTProgSpecCampuses: Record 74507;
        TTProgSpecRooms: Record 74509;
        TTProgSpecDays: Record 74508;
        TTLectSpecCampuses: Record 74510;
        TTLectSpecDays: Record 74511;
        TTLectSpecLessons: Record 74512;
        TTUnitSpecCampuses: Record 74513;
        TTUnitSpecRooms: Record 74514;
        TTTimetableCollectorSingles: Record 74500;
        TTTimetableCollectorDoubles: Record 74521;
        TTTimetableCollectorTripple: Record 74522;
        TTProgrammes: Record "TT-Programmes";
        TTUnits: Record "TT-Units";
        TTLecturers: Record "TT-Lecturers";
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
                    IF ToDeleteSingles THEN
                        IF TTTimetableCollectorSingles.FIND('-') THEN TTTimetableCollectorSingles.DELETE;
                END;
            END;
            UNTIL TTProgrammes.NEXT = 0;
        END;
        //////////////////////////////////////////////////////////////Prog Spec. Campus on Singles
        //////////////////////////////////////////////////////////////Prog Spec. Campus on Doubles
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
                            TTTimetableCollectorDoubles.RESET;
                            TTTimetableCollectorDoubles.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorDoubles.SETFILTER("Campus Code", '%1', TTProgSpecCampuses."Campus Code");
                            IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                        END;
                        IF TTProgSpecCampuses."Constraint Category" = TTProgSpecCampuses."Constraint Category"::"Least Preferred" THEN BEGIN
                            //For the Programme and Campus Specified, Set Priority as 10
                            TTTimetableCollectorDoubles.RESET;
                            TTTimetableCollectorDoubles.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorDoubles.SETFILTER("Campus Code", '%1', TTProgSpecCampuses."Campus Code");
                            IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorDoubles."Programme Campus Priority" := 10;
                                    TTTimetableCollectorDoubles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorDoubles.NEXT = 0;
                            END;
                        END;

                        IF TTProgSpecCampuses."Constraint Category" = TTProgSpecCampuses."Constraint Category"::Preferred THEN BEGIN
                            //For the Programme and Campus Specified, Set Priority as 1
                            TTTimetableCollectorDoubles.RESET;
                            TTTimetableCollectorDoubles.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorDoubles.SETFILTER("Campus Code", '%1', TTProgSpecCampuses."Campus Code");
                            IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorDoubles."Programme Campus Priority" := 1;
                                    TTTimetableCollectorDoubles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorDoubles.NEXT = 0;
                            END;
                        END;

                        IF TTProgSpecCampuses."Constraint Category" = TTProgSpecCampuses."Constraint Category"::Mandatory THEN BEGIN
                            //For the Programme and Campus Specified, Set Priority as 1
                            TTTimetableCollectorDoubles.RESET;
                            TTTimetableCollectorDoubles.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorDoubles.SETFILTER("Campus Code", '%1', TTProgSpecCampuses."Campus Code");
                            IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorDoubles."Programme Campus Priority" := 1;
                                    TTTimetableCollectorDoubles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorDoubles.NEXT = 0;
                            END;
                        END;
                    END;
                    UNTIL TTProgSpecCampuses.NEXT = 0;
                END;


                TTTimetableCollectorDoubles.RESET;
                TTTimetableCollectorDoubles.SETRANGE(Programme, TTProgrammes."Programme Code");
                CLEAR(ToDeleteDoubles);
                //// If the Constraints are Nandatory
                TTProgSpecCampuses.RESET;
                TTProgSpecCampuses.SETRANGE(Semester, Rec.Semester);
                TTProgSpecCampuses.SETRANGE("Programme Code", TTProgrammes."Programme Code");
                TTProgSpecCampuses.SETFILTER("Campus Code", '<>%1', '');
                TTProgSpecCampuses.SETFILTER("Constraint Category", '=%1', TTProgSpecCampuses."Constraint Category"::Mandatory);
                IF TTProgSpecCampuses.FIND('-') THEN BEGIN
                    //There Exists Programme Specific Campus Where Category is Mandatory
                    ToDeleteDoubles := TRUE;
                    REPEAT
                    BEGIN
                        //Keep filtering where Campus code is Not the one selected...
                        TTTimetableCollectorDoubles.SETFILTER("Campus Code", '<>%1', TTProgSpecCampuses."Campus Code");
                    END;
                    UNTIL TTProgSpecCampuses.NEXT = 0;
                    // After Repeated Filtering, Delete All Entries in the Filters
                    IF ToDeleteDoubles THEN
                        IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETE;
                END;
            END;
            UNTIL TTProgrammes.NEXT = 0;
        END;
        //////////////////////////////////////////////////////////////Prog Spec. Campus on Doubles
        //////////////////////////////////////////////////////////////Prog Spec. Campus on Tripples
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
                            TTTimetableCollectorTripple.RESET;
                            TTTimetableCollectorTripple.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorTripple.SETFILTER("Campus Code", '%1', TTProgSpecCampuses."Campus Code");
                            IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                        END;
                        IF TTProgSpecCampuses."Constraint Category" = TTProgSpecCampuses."Constraint Category"::"Least Preferred" THEN BEGIN
                            //For the Programme and Campus Specified, Set Priority as 10
                            TTTimetableCollectorTripple.RESET;
                            TTTimetableCollectorTripple.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorTripple.SETFILTER("Campus Code", '%1', TTProgSpecCampuses."Campus Code");
                            IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorTripple."Programme Campus Priority" := 10;
                                    TTTimetableCollectorTripple.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorTripple.NEXT = 0;
                            END;
                        END;

                        IF TTProgSpecCampuses."Constraint Category" = TTProgSpecCampuses."Constraint Category"::Preferred THEN BEGIN
                            //For the Programme and Campus Specified, Set Priority as 1
                            TTTimetableCollectorTripple.RESET;
                            TTTimetableCollectorTripple.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorTripple.SETFILTER("Campus Code", '%1', TTProgSpecCampuses."Campus Code");
                            IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorTripple."Programme Campus Priority" := 1;
                                    TTTimetableCollectorTripple.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorTripple.NEXT = 0;
                            END;
                        END;

                        IF TTProgSpecCampuses."Constraint Category" = TTProgSpecCampuses."Constraint Category"::Mandatory THEN BEGIN
                            //For the Programme and Campus Specified, Set Priority as 1
                            TTTimetableCollectorTripple.RESET;
                            TTTimetableCollectorTripple.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorTripple.SETFILTER("Campus Code", '%1', TTProgSpecCampuses."Campus Code");
                            IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorTripple."Programme Campus Priority" := 1;
                                    TTTimetableCollectorTripple.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorTripple.NEXT = 0;
                            END;
                        END;
                    END;
                    UNTIL TTProgSpecCampuses.NEXT = 0;
                END;


                TTTimetableCollectorTripple.RESET;
                TTTimetableCollectorTripple.SETRANGE(Programme, TTProgrammes."Programme Code");
                CLEAR(ToDeleteTripples);
                //// If the Constraints are Nandatory
                TTProgSpecCampuses.RESET;
                TTProgSpecCampuses.SETRANGE(Semester, Rec.Semester);
                TTProgSpecCampuses.SETRANGE("Programme Code", TTProgrammes."Programme Code");
                TTProgSpecCampuses.SETFILTER("Campus Code", '<>%1', '');
                TTProgSpecCampuses.SETFILTER("Constraint Category", '=%1', TTProgSpecCampuses."Constraint Category"::Mandatory);
                IF TTProgSpecCampuses.FIND('-') THEN BEGIN
                    //There Exists Programme Specific Campus Where Category is Mandatory
                    ToDeleteTripples := TRUE;
                    REPEAT
                    BEGIN
                        //Keep filtering where Campus code is Not the one selected...
                        TTTimetableCollectorTripple.SETFILTER("Campus Code", '<>%1', TTProgSpecCampuses."Campus Code");
                    END;
                    UNTIL TTProgSpecCampuses.NEXT = 0;
                    // After Repeated Filtering, Delete All Entries in the Filters
                    IF ToDeleteTripples THEN
                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETE;
                END;
            END;
            UNTIL TTProgrammes.NEXT = 0;
        END;
        //////////////////////////////////////////////////////////////Prog Spec. Campus on Tripples
    end;

    local procedure SpecificConstraintsLectCampuses()
    var
        TTProgSpecCampuses: Record 74507;
        TTProgSpecRooms: Record 74509;
        TTProgSpecDays: Record 74508;
        TTLectSpecCampuses: Record 74510;
        TTLectSpecDays: Record 74511;
        TTLectSpecLessons: Record 74512;
        TTUnitSpecCampuses: Record 74513;
        TTUnitSpecRooms: Record 74514;
        TTTimetableCollectorSingles: Record 74500;
        TTTimetableCollectorDoubles: Record 74521;
        TTTimetableCollectorTripple: Record 74522;
        TTProgrammes: Record "TT-Programmes";
        TTUnits: Record "TT-Units";
        TTLecturers: Record "TT-Lecturers";
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
                    IF ToDeleteSingles THEN
                        IF TTTimetableCollectorSingles.FIND('-') THEN TTTimetableCollectorSingles.DELETE;
                END;
            END;
            UNTIL TTLecturers.NEXT = 0;
        END;
        //////////////////////////////////////////////////////////////Lect Spec. Campus on Singles
        //////////////////////////////////////////////////////////////Lect Spec. Campus on Doubles
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
                            //Delete all entries for the Lect and Campus Specified
                            TTTimetableCollectorDoubles.RESET;
                            TTTimetableCollectorDoubles.SETRANGE(Lecturer, TTLecturers."Lecturer Code");
                            TTTimetableCollectorDoubles.SETFILTER("Campus Code", '%1', TTLectSpecCampuses."Campus Code");
                            IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                        END;
                        IF TTLectSpecCampuses."Constraint Category" = TTLectSpecCampuses."Constraint Category"::"Least Preferred" THEN BEGIN
                            //For the Lect and Campus Specified, Set Priority as 10
                            TTTimetableCollectorDoubles.RESET;
                            TTTimetableCollectorDoubles.SETRANGE(Lecturer, TTLecturers."Lecturer Code");
                            TTTimetableCollectorDoubles.SETFILTER("Campus Code", '%1', TTLectSpecCampuses."Campus Code");
                            IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorDoubles."Lecturer Campus Priority" := 10;
                                    TTTimetableCollectorDoubles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorDoubles.NEXT = 0;
                            END;
                        END;

                        IF TTLectSpecCampuses."Constraint Category" = TTLectSpecCampuses."Constraint Category"::Preferred THEN BEGIN
                            //For the Lect and Campus Specified, Set Priority as 1
                            TTTimetableCollectorDoubles.RESET;
                            TTTimetableCollectorDoubles.SETRANGE(Lecturer, TTLecturers."Lecturer Code");
                            TTTimetableCollectorDoubles.SETFILTER("Campus Code", '%1', TTLectSpecCampuses."Campus Code");
                            IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorDoubles."Lecturer Campus Priority" := 1;
                                    TTTimetableCollectorDoubles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorDoubles.NEXT = 0;
                            END;
                        END;

                        IF TTLectSpecCampuses."Constraint Category" = TTLectSpecCampuses."Constraint Category"::Mandatory THEN BEGIN
                            //For the Lect and Campus Specified, Set Priority as 1
                            TTTimetableCollectorDoubles.RESET;
                            TTTimetableCollectorDoubles.SETRANGE(Lecturer, TTLecturers."Lecturer Code");
                            TTTimetableCollectorDoubles.SETFILTER("Campus Code", '%1', TTLectSpecCampuses."Campus Code");
                            IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorDoubles."Lecturer Campus Priority" := 1;
                                    TTTimetableCollectorDoubles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorDoubles.NEXT = 0;
                            END;
                        END;
                    END;
                    UNTIL TTLectSpecCampuses.NEXT = 0;
                END;


                TTTimetableCollectorDoubles.RESET;
                TTTimetableCollectorDoubles.SETRANGE(Lecturer, TTLecturers."Lecturer Code");
                CLEAR(ToDeleteDoubles);
                //// If the Constraints are Nandatory
                TTLectSpecCampuses.RESET;
                TTLectSpecCampuses.SETRANGE(Semester, Rec.Semester);
                TTLectSpecCampuses.SETRANGE("Lecturer Code", TTLecturers."Lecturer Code");
                TTLectSpecCampuses.SETFILTER("Campus Code", '<>%1', '');
                TTLectSpecCampuses.SETFILTER("Constraint Category", '=%1', TTLectSpecCampuses."Constraint Category"::Mandatory);
                IF TTLectSpecCampuses.FIND('-') THEN BEGIN
                    //There Exists Lect Specific Campus Where Category is Mandatory
                    ToDeleteDoubles := TRUE;
                    REPEAT
                    BEGIN
                        //Keep filtering where Campus code is Not the one selected...
                        TTTimetableCollectorDoubles.SETFILTER("Campus Code", '<>%1', TTLectSpecCampuses."Campus Code");
                    END;
                    UNTIL TTLectSpecCampuses.NEXT = 0;
                    // After Repeated Filtering, Delete All Entries in the Filters
                    IF ToDeleteDoubles THEN IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETE;
                END;
            END;
            UNTIL TTLecturers.NEXT = 0;
        END;
        //////////////////////////////////////////////////////////////Lect Spec. Campus on Doubles
        //////////////////////////////////////////////////////////////Lect Spec. Campus on Tripples
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
                            //Delete all entries for the Lect and Campus Specified
                            TTTimetableCollectorTripple.RESET;
                            TTTimetableCollectorTripple.SETRANGE(Lecturer, TTLecturers."Lecturer Code");
                            TTTimetableCollectorTripple.SETFILTER("Campus Code", '%1', TTLectSpecCampuses."Campus Code");
                            IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                        END;
                        IF TTLectSpecCampuses."Constraint Category" = TTLectSpecCampuses."Constraint Category"::"Least Preferred" THEN BEGIN
                            //For the Lecturer and Campus Specified, Set Priority as 10
                            TTTimetableCollectorTripple.RESET;
                            TTTimetableCollectorTripple.SETRANGE(Lecturer, TTLecturers."Lecturer Code");
                            TTTimetableCollectorTripple.SETFILTER("Campus Code", '%1', TTLectSpecCampuses."Campus Code");
                            IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorTripple."Lecturer Campus Priority" := 10;
                                    TTTimetableCollectorTripple.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorTripple.NEXT = 0;
                            END;
                        END;

                        IF TTLectSpecCampuses."Constraint Category" = TTLectSpecCampuses."Constraint Category"::Preferred THEN BEGIN
                            //For the Lecturer nd Campus Specified, Set Priority as 1
                            TTTimetableCollectorTripple.RESET;
                            TTTimetableCollectorTripple.SETRANGE(Lecturer, TTLecturers."Lecturer Code");
                            TTTimetableCollectorTripple.SETFILTER("Campus Code", '%1', TTLectSpecCampuses."Campus Code");
                            IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorTripple."Lecturer Campus Priority" := 1;
                                    TTTimetableCollectorTripple.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorTripple.NEXT = 0;
                            END;
                        END;

                        IF TTLectSpecCampuses."Constraint Category" = TTLectSpecCampuses."Constraint Category"::Mandatory THEN BEGIN
                            //For the Lecturer nd Campus Specified, Set Priority as 1
                            TTTimetableCollectorTripple.RESET;
                            TTTimetableCollectorTripple.SETRANGE(Lecturer, TTLecturers."Lecturer Code");
                            TTTimetableCollectorTripple.SETFILTER("Campus Code", '%1', TTLectSpecCampuses."Campus Code");
                            IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorTripple."Lecturer Campus Priority" := 1;
                                    TTTimetableCollectorTripple.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorTripple.NEXT = 0;
                            END;
                        END;
                    END;
                    UNTIL TTLectSpecCampuses.NEXT = 0;
                END;


                TTTimetableCollectorTripple.RESET;
                TTTimetableCollectorTripple.SETRANGE(Lecturer, TTLecturers."Lecturer Code");
                CLEAR(ToDeleteTripples);
                //// If the Constraints are Nandatory
                TTLectSpecCampuses.RESET;
                TTLectSpecCampuses.SETRANGE(Semester, Rec.Semester);
                TTLectSpecCampuses.SETRANGE("Lecturer Code", TTLecturers."Lecturer Code");
                TTLectSpecCampuses.SETFILTER("Campus Code", '<>%1', '');
                TTLectSpecCampuses.SETFILTER("Constraint Category", '=%1', TTLectSpecCampuses."Constraint Category"::Mandatory);
                IF TTLectSpecCampuses.FIND('-') THEN BEGIN
                    //There Exists Lecturer Specific Campus Where Category is Mandatory
                    ToDeleteTripples := TRUE;
                    REPEAT
                    BEGIN
                        //Keep filtering where Campus code is Not the one selected...
                        TTTimetableCollectorTripple.SETFILTER("Campus Code", '<>%1', TTLectSpecCampuses."Campus Code");
                    END;
                    UNTIL TTLectSpecCampuses.NEXT = 0;
                    // After Repeated Filtering, Delete All Entries in the Filters
                    IF ToDeleteTripples THEN
                        IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETE;
                END;
            END;
            UNTIL TTLecturers.NEXT = 0;
        END;
        //////////////////////////////////////////////////////////////Lect Spec. Campus on Tripples
    end;

    local procedure SpecificConstraintsUnitCampuses()
    var
        TTProgSpecCampuses: Record 74507;
        TTProgSpecRooms: Record 74509;
        TTProgSpecDays: Record 74508;
        TTLectSpecCampuses: Record 74510;
        TTLectSpecDays: Record 74511;
        TTLectSpecLessons: Record 74512;
        TTUnitSpecCampuses: Record 74513;
        TTUnitSpecRooms: Record 74514;
        TTTimetableCollectorSingles: Record 74500;
        TTTimetableCollectorDoubles: Record 74521;
        TTTimetableCollectorTripple: Record 74522;
        TTProgrammes: Record "TT-Programmes";
        TTUnits: Record "TT-Units";
        TTLecturers: Record "TT-Lecturers";
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
                    IF ToDeleteSingles THEN IF TTTimetableCollectorSingles.FIND('-') THEN TTTimetableCollectorSingles.DELETE;
                END;
            END;
            UNTIL TTUnits.NEXT = 0;
        END;
        //////////////////////////////////////////////////////////////Lect Spec. Campus on Singles
        //////////////////////////////////////////////////////////////Lect Spec. Campus on Doubles
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
                            //Delete all entries for the Lect and Campus Specified
                            TTTimetableCollectorDoubles.RESET;
                            TTTimetableCollectorDoubles.SETRANGE(Unit, TTUnits."Unit Code");
                            TTTimetableCollectorDoubles.SETFILTER("Campus Code", '%1', TTUnitSpecCampuses."Campus Code");
                            IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                        END;
                        IF TTUnitSpecCampuses."Constraint Category" = TTUnitSpecCampuses."Constraint Category"::"Least Preferred" THEN BEGIN
                            //For the Lect and Campus Specified, Set Priority as 10
                            TTTimetableCollectorDoubles.RESET;
                            TTTimetableCollectorDoubles.SETRANGE(Unit, TTUnits."Unit Code");
                            TTTimetableCollectorDoubles.SETFILTER("Campus Code", '%1', TTUnitSpecCampuses."Campus Code");
                            IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorDoubles."Unit Campus Priority" := 10;
                                    TTTimetableCollectorDoubles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorDoubles.NEXT = 0;
                            END;
                        END;

                        IF TTUnitSpecCampuses."Constraint Category" = TTUnitSpecCampuses."Constraint Category"::Preferred THEN BEGIN
                            //For the Lect and Campus Specified, Set Priority as 1
                            TTTimetableCollectorDoubles.RESET;
                            TTTimetableCollectorDoubles.SETRANGE(Unit, TTUnits."Unit Code");
                            TTTimetableCollectorDoubles.SETFILTER("Campus Code", '%1', TTUnitSpecCampuses."Campus Code");
                            IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorDoubles."Unit Campus Priority" := 1;
                                    TTTimetableCollectorDoubles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorDoubles.NEXT = 0;
                            END;
                        END;

                        IF TTUnitSpecCampuses."Constraint Category" = TTUnitSpecCampuses."Constraint Category"::Mandatory THEN BEGIN
                            //For the Lect and Campus Specified, Set Priority as 1
                            TTTimetableCollectorDoubles.RESET;
                            TTTimetableCollectorDoubles.SETRANGE(Unit, TTUnits."Unit Code");
                            TTTimetableCollectorDoubles.SETFILTER("Campus Code", '%1', TTUnitSpecCampuses."Campus Code");
                            IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorDoubles."Unit Campus Priority" := 1;
                                    TTTimetableCollectorDoubles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorDoubles.NEXT = 0;
                            END;
                        END;
                    END;
                    UNTIL TTUnitSpecCampuses.NEXT = 0;
                END;


                TTTimetableCollectorDoubles.RESET;
                TTTimetableCollectorDoubles.SETRANGE(Unit, TTUnits."Unit Code");
                CLEAR(ToDeleteDoubles);
                //// If the Constraints are Nandatory
                TTUnitSpecCampuses.RESET;
                TTUnitSpecCampuses.SETRANGE(Semester, Rec.Semester);
                TTUnitSpecCampuses.SETRANGE("Unit Code", TTUnits."Unit Code");
                TTUnitSpecCampuses.SETFILTER("Campus Code", '<>%1', '');
                TTUnitSpecCampuses.SETFILTER("Constraint Category", '=%1', TTUnitSpecCampuses."Constraint Category"::Mandatory);
                IF TTUnitSpecCampuses.FIND('-') THEN BEGIN
                    //There Exists Lect Specific Campus Where Category is Mandatory
                    ToDeleteDoubles := TRUE;
                    REPEAT
                    BEGIN
                        //Keep filtering where Campus code is Not the one selected...
                        TTTimetableCollectorDoubles.SETFILTER("Campus Code", '<>%1', TTUnitSpecCampuses."Campus Code");
                    END;
                    UNTIL TTUnitSpecCampuses.NEXT = 0;
                    // After Repeated Filtering, Delete All Entries in the Filters
                    IF ToDeleteDoubles THEN IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETE;
                END;
            END;
            UNTIL TTUnits.NEXT = 0;
        END;
        //////////////////////////////////////////////////////////////Lect Spec. Campus on Doubles
        //////////////////////////////////////////////////////////////Lect Spec. Campus on Tripples
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
                            //Delete all entries for the Lect and Campus Specified
                            TTTimetableCollectorTripple.RESET;
                            TTTimetableCollectorTripple.SETRANGE(Unit, TTUnits."Unit Code");
                            TTTimetableCollectorTripple.SETFILTER("Campus Code", '%1', TTUnitSpecCampuses."Campus Code");
                            IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                        END;
                        IF TTUnitSpecCampuses."Constraint Category" = TTUnitSpecCampuses."Constraint Category"::"Least Preferred" THEN BEGIN
                            //For the Unit and Campus Specified, Set Priority as 10
                            TTTimetableCollectorTripple.RESET;
                            TTTimetableCollectorTripple.SETRANGE(Unit, TTUnits."Unit Code");
                            TTTimetableCollectorTripple.SETFILTER("Campus Code", '%1', TTUnitSpecCampuses."Campus Code");
                            IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorTripple."Unit Campus Priority" := 10;
                                    TTTimetableCollectorTripple.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorTripple.NEXT = 0;
                            END;
                        END;

                        IF TTUnitSpecCampuses."Constraint Category" = TTUnitSpecCampuses."Constraint Category"::Preferred THEN BEGIN
                            //For the Unit nd Campus Specified, Set Priority as 1
                            TTTimetableCollectorTripple.RESET;
                            TTTimetableCollectorTripple.SETRANGE(Unit, TTUnits."Unit Code");
                            TTTimetableCollectorTripple.SETFILTER("Campus Code", '%1', TTUnitSpecCampuses."Campus Code");
                            IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorTripple."Unit Campus Priority" := 1;
                                    TTTimetableCollectorTripple.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorTripple.NEXT = 0;
                            END;
                        END;

                        IF TTUnitSpecCampuses."Constraint Category" = TTUnitSpecCampuses."Constraint Category"::Mandatory THEN BEGIN
                            //For the Unit nd Campus Specified, Set Priority as 1
                            TTTimetableCollectorTripple.RESET;
                            TTTimetableCollectorTripple.SETRANGE(Unit, TTUnits."Unit Code");
                            TTTimetableCollectorTripple.SETFILTER("Campus Code", '%1', TTUnitSpecCampuses."Campus Code");
                            IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorTripple."Unit Campus Priority" := 1;
                                    TTTimetableCollectorTripple.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorTripple.NEXT = 0;
                            END;
                        END;
                    END;
                    UNTIL TTUnitSpecCampuses.NEXT = 0;
                END;


                TTTimetableCollectorTripple.RESET;
                TTTimetableCollectorTripple.SETRANGE(Unit, TTUnits."Unit Code");
                CLEAR(ToDeleteTripples);
                //// If the Constraints are Nandatory
                TTUnitSpecCampuses.RESET;
                TTUnitSpecCampuses.SETRANGE(Semester, Rec.Semester);
                TTUnitSpecCampuses.SETRANGE("Unit Code", TTUnits."Unit Code");
                TTUnitSpecCampuses.SETFILTER("Campus Code", '<>%1', '');
                TTUnitSpecCampuses.SETFILTER("Constraint Category", '=%1', TTUnitSpecCampuses."Constraint Category"::Mandatory);
                IF TTUnitSpecCampuses.FIND('-') THEN BEGIN
                    //There Exists Unit Specific Campus Where Category is Mandatory
                    ToDeleteTripples := TRUE;
                    REPEAT
                    BEGIN
                        //Keep filtering where Campus code is Not the one selected...
                        TTTimetableCollectorTripple.SETFILTER("Campus Code", '<>%1', TTUnitSpecCampuses."Campus Code");
                    END;
                    UNTIL TTUnitSpecCampuses.NEXT = 0;
                    // After Repeated Filtering, Delete All Entries in the Filters
                    IF ToDeleteTripples THEN IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETE;
                END;
            END;
            UNTIL TTUnits.NEXT = 0;
        END;
        //////////////////////////////////////////////////////////////Lect Spec. Campus on Tripples
    end;

    local procedure SpecificConstraintsProgRooms()
    var
        TTProgSpecCampuses: Record 74507;
        TTProgSpecRooms: Record 74509;
        TTProgSpecDays: Record 74508;
        TTLectSpecCampuses: Record 74510;
        TTLectSpecDays: Record 74511;
        TTLectSpecLessons: Record 74512;
        TTUnitSpecCampuses: Record 74513;
        TTUnitSpecRooms: Record 74514;
        TTTimetableCollectorSingles: Record 74500;
        TTTimetableCollectorDoubles: Record 74521;
        TTTimetableCollectorTripple: Record 74522;
        TTProgrammes: Record "TT-Programmes";
        TTUnits: Record "TT-Units";
        TTLecturers: Record "TT-Lecturers";
        ToDeleteSingles: Boolean;
        ToDeleteDoubles: Boolean;
        ToDeleteTripples: Boolean;
    begin
        //////////////////////////////////////////////////////////////Prog Spec. Room on Singles
        TTProgrammes.RESET;
        TTProgrammes.SETRANGE(Semester, Rec.Semester);
        IF TTProgrammes.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                TTProgSpecRooms.RESET;
                TTProgSpecRooms.SETRANGE(Semester, Rec.Semester);
                TTProgSpecRooms.SETRANGE("Programme Code", TTProgrammes."Programme Code");
                TTProgSpecRooms.SETFILTER("Room Code", '<>%1', '');
                IF TTProgSpecRooms.FIND('-') THEN BEGIN
                    //There Exists Programme Specific Room
                    REPEAT
                    BEGIN
                        IF TTProgSpecRooms."Constraint Category" = TTProgSpecRooms."Constraint Category"::Avoid THEN BEGIN
                            //Delete all entries for the Programme and Room Specified
                            TTTimetableCollectorSingles.RESET;
                            TTTimetableCollectorSingles.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorSingles.SETFILTER("Room Code", '%1', TTProgSpecRooms."Room Code");
                            IF TTTimetableCollectorSingles.FIND('-') THEN TTTimetableCollectorSingles.DELETEALL;
                        END;
                        IF TTProgSpecRooms."Constraint Category" = TTProgSpecRooms."Constraint Category"::"Least Preferred" THEN BEGIN
                            //For the Programme and Room Specified, Set Priority as 10
                            TTTimetableCollectorSingles.RESET;
                            TTTimetableCollectorSingles.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorSingles.SETFILTER("Room Code", '%1', TTProgSpecRooms."Room Code");
                            IF TTTimetableCollectorSingles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorSingles."Programme Room Priority" := 10;
                                    TTTimetableCollectorSingles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorSingles.NEXT = 0;
                            END;
                        END;

                        IF TTProgSpecRooms."Constraint Category" = TTProgSpecRooms."Constraint Category"::Preferred THEN BEGIN
                            //For the Programme and Room Specified, Set Priority as 1
                            TTTimetableCollectorSingles.RESET;
                            TTTimetableCollectorSingles.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorSingles.SETFILTER("Room Code", '%1', TTProgSpecRooms."Room Code");
                            IF TTTimetableCollectorSingles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorSingles."Programme Room Priority" := 1;
                                    TTTimetableCollectorSingles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorSingles.NEXT = 0;
                            END;
                        END;

                        IF TTProgSpecRooms."Constraint Category" = TTProgSpecRooms."Constraint Category"::Mandatory THEN BEGIN
                            //For the Programme and Room Specified, Set Priority as 1
                            TTTimetableCollectorSingles.RESET;
                            TTTimetableCollectorSingles.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorSingles.SETFILTER("Room Code", '%1', TTProgSpecRooms."Room Code");
                            IF TTTimetableCollectorSingles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorSingles."Programme Room Priority" := 1;
                                    TTTimetableCollectorSingles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorSingles.NEXT = 0;
                            END;
                        END;
                    END;
                    UNTIL TTProgSpecRooms.NEXT = 0;
                END;


                TTTimetableCollectorSingles.RESET;
                TTTimetableCollectorSingles.SETRANGE(Programme, TTProgrammes."Programme Code");
                CLEAR(ToDeleteSingles);
                //// If the Constraints are Nandatory
                TTProgSpecRooms.RESET;
                TTProgSpecRooms.SETRANGE(Semester, Rec.Semester);
                TTProgSpecRooms.SETRANGE("Programme Code", TTProgrammes."Programme Code");
                TTProgSpecRooms.SETFILTER("Room Code", '<>%1', '');
                TTProgSpecRooms.SETFILTER("Constraint Category", '=%1', TTProgSpecRooms."Constraint Category"::Mandatory);
                IF TTProgSpecRooms.FIND('-') THEN BEGIN
                    //There Exists Programme Specific Room Where Category is Mandatory
                    ToDeleteSingles := TRUE;
                    REPEAT
                    BEGIN
                        //Keep filtering where Room code is Not the one selected...
                        TTTimetableCollectorSingles.SETFILTER("Room Code", '<>%1', TTProgSpecRooms."Room Code");
                    END;
                    UNTIL TTProgSpecRooms.NEXT = 0;
                    // After Repeated Filtering, Delete All Entries in the Filters
                    IF ToDeleteSingles THEN IF TTTimetableCollectorSingles.FIND('-') THEN TTTimetableCollectorSingles.DELETE;
                END;
            END;
            UNTIL TTProgrammes.NEXT = 0;
        END;
        //////////////////////////////////////////////////////////////Prog Spec. Room on Singles
        //////////////////////////////////////////////////////////////Prog Spec. Room on Doubles
        TTProgrammes.RESET;
        TTProgrammes.SETRANGE(Semester, Rec.Semester);
        IF TTProgrammes.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                TTProgSpecRooms.RESET;
                TTProgSpecRooms.SETRANGE(Semester, Rec.Semester);
                TTProgSpecRooms.SETRANGE("Programme Code", TTProgrammes."Programme Code");
                TTProgSpecRooms.SETFILTER("Room Code", '<>%1', '');
                IF TTProgSpecRooms.FIND('-') THEN BEGIN
                    //There Exists Programme Specific Room
                    REPEAT
                    BEGIN
                        IF TTProgSpecRooms."Constraint Category" = TTProgSpecRooms."Constraint Category"::Avoid THEN BEGIN
                            //Delete all entries for the Programme and Room Specified
                            TTTimetableCollectorDoubles.RESET;
                            TTTimetableCollectorDoubles.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorDoubles.SETFILTER("Room Code", '%1', TTProgSpecRooms."Room Code");
                            IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                        END;
                        IF TTProgSpecRooms."Constraint Category" = TTProgSpecRooms."Constraint Category"::"Least Preferred" THEN BEGIN
                            //For the Programme and Room Specified, Set Priority as 10
                            TTTimetableCollectorDoubles.RESET;
                            TTTimetableCollectorDoubles.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorDoubles.SETFILTER("Room Code", '%1', TTProgSpecRooms."Room Code");
                            IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorDoubles."Programme Room Priority" := 10;
                                    TTTimetableCollectorDoubles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorDoubles.NEXT = 0;
                            END;
                        END;

                        IF TTProgSpecRooms."Constraint Category" = TTProgSpecRooms."Constraint Category"::Preferred THEN BEGIN
                            //For the Programme and Room Specified, Set Priority as 1
                            TTTimetableCollectorDoubles.RESET;
                            TTTimetableCollectorDoubles.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorDoubles.SETFILTER("Room Code", '%1', TTProgSpecRooms."Room Code");
                            IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorDoubles."Programme Room Priority" := 1;
                                    TTTimetableCollectorDoubles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorDoubles.NEXT = 0;
                            END;
                        END;

                        IF TTProgSpecRooms."Constraint Category" = TTProgSpecRooms."Constraint Category"::Mandatory THEN BEGIN
                            //For the Programme and Room Specified, Set Priority as 1
                            TTTimetableCollectorDoubles.RESET;
                            TTTimetableCollectorDoubles.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorDoubles.SETFILTER("Room Code", '%1', TTProgSpecRooms."Room Code");
                            IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorDoubles."Programme Room Priority" := 1;
                                    TTTimetableCollectorDoubles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorDoubles.NEXT = 0;
                            END;
                        END;
                    END;
                    UNTIL TTProgSpecRooms.NEXT = 0;
                END;


                TTTimetableCollectorDoubles.RESET;
                TTTimetableCollectorDoubles.SETRANGE(Programme, TTProgrammes."Programme Code");
                CLEAR(ToDeleteDoubles);
                //// If the Constraints are Nandatory
                TTProgSpecRooms.RESET;
                TTProgSpecRooms.SETRANGE(Semester, Rec.Semester);
                TTProgSpecRooms.SETRANGE("Programme Code", TTProgrammes."Programme Code");
                TTProgSpecRooms.SETFILTER("Room Code", '<>%1', '');
                TTProgSpecRooms.SETFILTER("Constraint Category", '=%1', TTProgSpecRooms."Constraint Category"::Mandatory);
                IF TTProgSpecRooms.FIND('-') THEN BEGIN
                    //There Exists Programme Specific Room Where Category is Mandatory
                    ToDeleteDoubles := TRUE;
                    REPEAT
                    BEGIN
                        //Keep filtering where Room code is Not the one selected...
                        TTTimetableCollectorDoubles.SETFILTER("Room Code", '<>%1', TTProgSpecRooms."Room Code");
                    END;
                    UNTIL TTProgSpecRooms.NEXT = 0;
                    // After Repeated Filtering, Delete All Entries in the Filters
                    IF ToDeleteDoubles THEN IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETE;
                END;
            END;
            UNTIL TTProgrammes.NEXT = 0;
        END;
        //////////////////////////////////////////////////////////////Prog Spec. Room on Doubles
        //////////////////////////////////////////////////////////////Prog Spec. Room on Tripples
        TTProgrammes.RESET;
        TTProgrammes.SETRANGE(Semester, Rec.Semester);
        IF TTProgrammes.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                TTProgSpecRooms.RESET;
                TTProgSpecRooms.SETRANGE(Semester, Rec.Semester);
                TTProgSpecRooms.SETRANGE("Programme Code", TTProgrammes."Programme Code");
                TTProgSpecRooms.SETFILTER("Room Code", '<>%1', '');
                IF TTProgSpecRooms.FIND('-') THEN BEGIN
                    //There Exists Programme Specific Room
                    REPEAT
                    BEGIN
                        IF TTProgSpecRooms."Constraint Category" = TTProgSpecRooms."Constraint Category"::Avoid THEN BEGIN
                            //Delete all entries for the Programme and Room Specified
                            TTTimetableCollectorTripple.RESET;
                            TTTimetableCollectorTripple.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorTripple.SETFILTER("Room Code", '%1', TTProgSpecRooms."Room Code");
                            IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                        END;
                        IF TTProgSpecRooms."Constraint Category" = TTProgSpecRooms."Constraint Category"::"Least Preferred" THEN BEGIN
                            //For the Programme and Room Specified, Set Priority as 10
                            TTTimetableCollectorTripple.RESET;
                            TTTimetableCollectorTripple.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorTripple.SETFILTER("Room Code", '%1', TTProgSpecRooms."Room Code");
                            IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorTripple."Programme Room Priority" := 10;
                                    TTTimetableCollectorTripple.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorTripple.NEXT = 0;
                            END;
                        END;

                        IF TTProgSpecRooms."Constraint Category" = TTProgSpecRooms."Constraint Category"::Preferred THEN BEGIN
                            //For the Programme and Room Specified, Set Priority as 1
                            TTTimetableCollectorTripple.RESET;
                            TTTimetableCollectorTripple.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorTripple.SETFILTER("Room Code", '%1', TTProgSpecRooms."Room Code");
                            IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorTripple."Programme Room Priority" := 1;
                                    TTTimetableCollectorTripple.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorTripple.NEXT = 0;
                            END;
                        END;

                        IF TTProgSpecRooms."Constraint Category" = TTProgSpecRooms."Constraint Category"::Mandatory THEN BEGIN
                            //For the Programme and Room Specified, Set Priority as 1
                            TTTimetableCollectorTripple.RESET;
                            TTTimetableCollectorTripple.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorTripple.SETFILTER("Room Code", '%1', TTProgSpecRooms."Room Code");
                            IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorTripple."Programme Room Priority" := 1;
                                    TTTimetableCollectorTripple.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorTripple.NEXT = 0;
                            END;
                        END;
                    END;
                    UNTIL TTProgSpecRooms.NEXT = 0;
                END;


                TTTimetableCollectorTripple.RESET;
                TTTimetableCollectorTripple.SETRANGE(Programme, TTProgrammes."Programme Code");
                CLEAR(ToDeleteTripples);
                //// If the Constraints are Nandatory
                TTProgSpecRooms.RESET;
                TTProgSpecRooms.SETRANGE(Semester, Rec.Semester);
                TTProgSpecRooms.SETRANGE("Programme Code", TTProgrammes."Programme Code");
                TTProgSpecRooms.SETFILTER("Room Code", '<>%1', '');
                TTProgSpecRooms.SETFILTER("Constraint Category", '=%1', TTProgSpecRooms."Constraint Category"::Mandatory);
                IF TTProgSpecRooms.FIND('-') THEN BEGIN
                    //There Exists Programme Specific Room Where Category is Mandatory
                    ToDeleteTripples := TRUE;
                    REPEAT
                    BEGIN
                        //Keep filtering where Room code is Not the one selected...
                        TTTimetableCollectorTripple.SETFILTER("Room Code", '<>%1', TTProgSpecRooms."Room Code");
                    END;
                    UNTIL TTProgSpecRooms.NEXT = 0;
                    // After Repeated Filtering, Delete All Entries in the Filters
                    IF ToDeleteTripples THEN IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETE;
                END;
            END;
            UNTIL TTProgrammes.NEXT = 0;
        END;
        //////////////////////////////////////////////////////////////Prog Spec. Room on Tripples
    end;

    local procedure SpecificConstraintsUnitRooms()
    var
        TTProgSpecCampuses: Record 74507;
        TTProgSpecRooms: Record 74509;
        TTProgSpecDays: Record 74508;
        TTLectSpecCampuses: Record 74510;
        TTLectSpecDays: Record 74511;
        TTLectSpecLessons: Record 74512;
        TTUnitSpecCampuses: Record 74513;
        TTUnitSpecRooms: Record 74514;
        TTTimetableCollectorSingles: Record 74500;
        TTTimetableCollectorDoubles: Record 74521;
        TTTimetableCollectorTripple: Record 74522;
        TTProgrammes: Record "TT-Programmes";
        TTUnits: Record "TT-Units";
        TTLecturers: Record "TT-Lecturers";
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
                TTUnitSpecRooms.SETRANGE("Programme Code", TTUnits."Programme Code");
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
                                    TTTimetableCollectorSingles."Unit Room Priority" := 3;
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

                            TTTimetableCollectorSingles.RESET;
                            TTTimetableCollectorSingles.SETRANGE(Unit, TTUnits."Unit Code");
                            TTTimetableCollectorSingles.SETFILTER("Room Code", '<>%1', TTUnitSpecRooms."Room Code");
                            IF TTTimetableCollectorSingles.FIND('-') THEN BEGIN
                                TTTimetableCollectorSingles.DELETEALL;
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
                    IF ToDeleteSingles THEN IF TTTimetableCollectorSingles.FIND('-') THEN TTTimetableCollectorSingles.DELETE;
                END;
            END;
            UNTIL TTUnits.NEXT = 0;
        END;
        //////////////////////////////////////////////////////////////Lect Spec. Campus on Singles
        //////////////////////////////////////////////////////////////Lect Spec. Campus on Doubles
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
                            //Delete all entries for the Lect and Campus Specified
                            TTTimetableCollectorDoubles.RESET;
                            TTTimetableCollectorDoubles.SETRANGE(Unit, TTUnits."Unit Code");
                            TTTimetableCollectorDoubles.SETFILTER("Room Code", '%1', TTUnitSpecRooms."Room Code");
                            IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                        END;
                        IF TTUnitSpecRooms."Constraint Category" = TTUnitSpecRooms."Constraint Category"::"Least Preferred" THEN BEGIN
                            //For the Lect and Campus Specified, Set Priority as 10
                            TTTimetableCollectorDoubles.RESET;
                            TTTimetableCollectorDoubles.SETRANGE(Unit, TTUnits."Unit Code");
                            TTTimetableCollectorDoubles.SETFILTER("Room Code", '%1', TTUnitSpecRooms."Room Code");
                            IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorDoubles."Unit Room Priority" := 10;
                                    TTTimetableCollectorDoubles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorDoubles.NEXT = 0;
                            END;
                        END;

                        IF TTUnitSpecRooms."Constraint Category" = TTUnitSpecRooms."Constraint Category"::Preferred THEN BEGIN
                            //For the Lect and Campus Specified, Set Priority as 1
                            TTTimetableCollectorDoubles.RESET;
                            TTTimetableCollectorDoubles.SETRANGE(Unit, TTUnits."Unit Code");
                            TTTimetableCollectorDoubles.SETFILTER("Room Code", '%1', TTUnitSpecRooms."Room Code");
                            IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorDoubles."Unit Room Priority" := 1;
                                    TTTimetableCollectorDoubles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorDoubles.NEXT = 0;
                            END;
                        END;

                        IF TTUnitSpecRooms."Constraint Category" = TTUnitSpecRooms."Constraint Category"::Mandatory THEN BEGIN
                            //For the Lect and Campus Specified, Set Priority as 1
                            TTTimetableCollectorDoubles.RESET;
                            TTTimetableCollectorDoubles.SETRANGE(Unit, TTUnits."Unit Code");
                            TTTimetableCollectorDoubles.SETFILTER("Room Code", '%1', TTUnitSpecRooms."Room Code");
                            IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorDoubles."Unit Room Priority" := 1;
                                    TTTimetableCollectorDoubles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorDoubles.NEXT = 0;
                            END;

                            TTTimetableCollectorDoubles.RESET;
                            TTTimetableCollectorDoubles.SETRANGE(Unit, TTUnits."Unit Code");
                            TTTimetableCollectorDoubles.SETFILTER("Room Code", '<>%1', TTUnitSpecRooms."Room Code");
                            IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
                                TTTimetableCollectorDoubles.DELETEALL;
                            END;

                        END;
                    END;
                    UNTIL TTUnitSpecRooms.NEXT = 0;
                END;


                TTTimetableCollectorDoubles.RESET;
                TTTimetableCollectorDoubles.SETRANGE(Unit, TTUnits."Unit Code");
                CLEAR(ToDeleteDoubles);
                //// If the Constraints are Nandatory
                TTUnitSpecRooms.RESET;
                TTUnitSpecRooms.SETRANGE(Semester, Rec.Semester);
                TTUnitSpecRooms.SETRANGE("Unit Code", TTUnits."Unit Code");
                TTUnitSpecRooms.SETFILTER("Room Code", '<>%1', '');
                TTUnitSpecRooms.SETFILTER("Constraint Category", '=%1', TTUnitSpecRooms."Constraint Category"::Mandatory);
                IF TTUnitSpecRooms.FIND('-') THEN BEGIN
                    //There Exists Lect Specific Campus Where Category is Mandatory
                    ToDeleteDoubles := TRUE;
                    REPEAT
                    BEGIN
                        //Keep filtering where Campus code is Not the one selected...
                        TTTimetableCollectorDoubles.SETFILTER("Room Code", '<>%1', TTUnitSpecRooms."Room Code");
                    END;
                    UNTIL TTUnitSpecRooms.NEXT = 0;
                    // After Repeated Filtering, Delete All Entries in the Filters
                    IF ToDeleteDoubles THEN IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETE;
                END;
            END;
            UNTIL TTUnits.NEXT = 0;
        END;
        //////////////////////////////////////////////////////////////Lect Spec. Campus on Doubles
        //////////////////////////////////////////////////////////////Lect Spec. Campus on Tripples
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
                            //Delete all entries for the Lect and Campus Specified
                            TTTimetableCollectorTripple.RESET;
                            TTTimetableCollectorTripple.SETRANGE(Unit, TTUnits."Unit Code");
                            TTTimetableCollectorTripple.SETFILTER("Room Code", '%1', TTUnitSpecRooms."Room Code");
                            IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                        END;
                        IF TTUnitSpecRooms."Constraint Category" = TTUnitSpecRooms."Constraint Category"::"Least Preferred" THEN BEGIN
                            //For the Unit and Campus Specified, Set Priority as 10
                            TTTimetableCollectorTripple.RESET;
                            TTTimetableCollectorTripple.SETRANGE(Unit, TTUnits."Unit Code");
                            TTTimetableCollectorTripple.SETFILTER("Room Code", '%1', TTUnitSpecRooms."Room Code");
                            IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorTripple."Unit Room Priority" := 10;
                                    TTTimetableCollectorTripple.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorTripple.NEXT = 0;
                            END;
                        END;

                        IF TTUnitSpecRooms."Constraint Category" = TTUnitSpecRooms."Constraint Category"::Preferred THEN BEGIN
                            //For the Unit nd Campus Specified, Set Priority as 1
                            TTTimetableCollectorTripple.RESET;
                            TTTimetableCollectorTripple.SETRANGE(Unit, TTUnits."Unit Code");
                            TTTimetableCollectorTripple.SETFILTER("Room Code", '%1', TTUnitSpecRooms."Room Code");
                            IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorTripple."Unit Room Priority" := 1;
                                    TTTimetableCollectorTripple.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorTripple.NEXT = 0;
                            END;
                        END;

                        IF TTUnitSpecRooms."Constraint Category" = TTUnitSpecRooms."Constraint Category"::Mandatory THEN BEGIN
                            //For the Unit nd Campus Specified, Set Priority as 1
                            TTTimetableCollectorTripple.RESET;
                            TTTimetableCollectorTripple.SETRANGE(Unit, TTUnits."Unit Code");
                            TTTimetableCollectorTripple.SETFILTER("Room Code", '%1', TTUnitSpecRooms."Room Code");
                            IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorTripple."Unit Room Priority" := 1;
                                    TTTimetableCollectorTripple.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorTripple.NEXT = 0;
                            END;

                            TTTimetableCollectorTripple.RESET;
                            TTTimetableCollectorTripple.SETRANGE(Unit, TTUnits."Unit Code");
                            TTTimetableCollectorTripple.SETFILTER("Room Code", '<>%1', TTUnitSpecRooms."Room Code");
                            IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
                                TTTimetableCollectorTripple.DELETEALL;
                            END;

                        END;
                    END;
                    UNTIL TTUnitSpecRooms.NEXT = 0;
                END;


                TTTimetableCollectorTripple.RESET;
                TTTimetableCollectorTripple.SETRANGE(Unit, TTUnits."Unit Code");
                CLEAR(ToDeleteTripples);
                //// If the Constraints are Nandatory
                TTUnitSpecRooms.RESET;
                TTUnitSpecRooms.SETRANGE(Semester, Rec.Semester);
                TTUnitSpecRooms.SETRANGE("Unit Code", TTUnits."Unit Code");
                TTUnitSpecRooms.SETFILTER("Room Code", '<>%1', '');
                TTUnitSpecRooms.SETFILTER("Constraint Category", '=%1', TTUnitSpecRooms."Constraint Category"::Mandatory);
                IF TTUnitSpecRooms.FIND('-') THEN BEGIN
                    //There Exists Unit Specific Campus Where Category is Mandatory
                    ToDeleteTripples := TRUE;
                    REPEAT
                    BEGIN
                        //Keep filtering where Campus code is Not the one selected...
                        TTTimetableCollectorTripple.SETFILTER("Room Code", '<>%1', TTUnitSpecRooms."Room Code");
                    END;
                    UNTIL TTUnitSpecRooms.NEXT = 0;
                    // After Repeated Filtering, Delete All Entries in the Filters
                    IF ToDeleteTripples THEN IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETE;
                END;
            END;
            UNTIL TTUnits.NEXT = 0;
        END;
        //////////////////////////////////////////////////////////////Lect Spec. Campus on Tripples
    end;

    local procedure SpecificConstraintsProgDays()
    var
        TTProgSpecCampuses: Record 74507;
        TTProgSpecRooms: Record 74509;
        TTProgSpecDays: Record 74508;
        TTLectSpecCampuses: Record 74510;
        TTLectSpecDays: Record 74511;
        TTLectSpecLessons: Record 74512;
        TTUnitSpecCampuses: Record 74513;
        TTUnitSpecRooms: Record 74514;
        TTTimetableCollectorSingles: Record 74500;
        TTTimetableCollectorDoubles: Record 74521;
        TTTimetableCollectorTripple: Record 74522;
        TTProgrammes: Record "TT-Programmes";
        TTUnits: Record "TT-Units";
        TTLecturers: Record "TT-Lecturers";
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
                TTProgSpecDays.SETFILTER("Day Code", '<>%1', '');
                IF TTProgSpecDays.FIND('-') THEN BEGIN
                    //There Exists Programme Specific Campus
                    REPEAT
                    BEGIN
                        IF TTProgSpecDays."Constraint Category" = TTProgSpecDays."Constraint Category"::Avoid THEN BEGIN
                            //Delete all entries for the Programme and Campus Specified
                            TTTimetableCollectorSingles.RESET;
                            TTTimetableCollectorSingles.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorSingles.SETFILTER("Day of Week", '%1', TTProgSpecDays."Day Code");
                            IF TTTimetableCollectorSingles.FIND('-') THEN TTTimetableCollectorSingles.DELETEALL;
                        END;
                        IF TTProgSpecDays."Constraint Category" = TTProgSpecDays."Constraint Category"::"Least Preferred" THEN BEGIN
                            //For the Programme and Campus Specified, Set Priority as 10
                            TTTimetableCollectorSingles.RESET;
                            TTTimetableCollectorSingles.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorSingles.SETFILTER("Day of Week", '%1', TTProgSpecDays."Day Code");
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
                            TTTimetableCollectorSingles.SETFILTER("Day of Week", '%1', TTProgSpecDays."Day Code");
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
                            TTTimetableCollectorSingles.SETFILTER("Day of Week", '%1', TTProgSpecDays."Day Code");
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
                TTProgSpecDays.SETFILTER("Day Code", '<>%1', '');
                TTProgSpecDays.SETFILTER("Constraint Category", '=%1', TTProgSpecDays."Constraint Category"::Mandatory);
                IF TTProgSpecDays.FIND('-') THEN BEGIN
                    //There Exists Programme Specific Campus Where Category is Mandatory
                    ToDeleteSingles := TRUE;
                    REPEAT
                    BEGIN
                        //Keep filtering where Campus code is Not the one selected...
                        TTTimetableCollectorSingles.SETFILTER("Day of Week", '<>%1', TTProgSpecDays."Day Code");
                    END;
                    UNTIL TTProgSpecDays.NEXT = 0;
                    // After Repeated Filtering, Delete All Entries in the Filters
                    IF ToDeleteSingles THEN IF TTTimetableCollectorSingles.FIND('-') THEN TTTimetableCollectorSingles.DELETE;
                END;
            END;
            UNTIL TTProgrammes.NEXT = 0;
        END;
        //////////////////////////////////////////////////////////////Prog Spec. Days on Singles
        //////////////////////////////////////////////////////////////Prog Spec. Days on Doubles
        TTProgrammes.RESET;
        TTProgrammes.SETRANGE(Semester, Rec.Semester);
        IF TTProgrammes.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                TTProgSpecDays.RESET;
                TTProgSpecDays.SETRANGE(Semester, Rec.Semester);
                TTProgSpecDays.SETRANGE("Programme Code", TTProgrammes."Programme Code");
                TTProgSpecDays.SETFILTER("Day Code", '<>%1', '');
                IF TTProgSpecDays.FIND('-') THEN BEGIN
                    //There Exists Programme Specific Campus
                    REPEAT
                    BEGIN
                        IF TTProgSpecDays."Constraint Category" = TTProgSpecDays."Constraint Category"::Avoid THEN BEGIN
                            //Delete all entries for the Programme and Campus Specified
                            TTTimetableCollectorDoubles.RESET;
                            TTTimetableCollectorDoubles.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorDoubles.SETFILTER("Day of Week", '%1', TTProgSpecDays."Day Code");
                            IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                        END;
                        IF TTProgSpecDays."Constraint Category" = TTProgSpecDays."Constraint Category"::"Least Preferred" THEN BEGIN
                            //For the Programme and Campus Specified, Set Priority as 10
                            TTTimetableCollectorDoubles.RESET;
                            TTTimetableCollectorDoubles.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorDoubles.SETFILTER("Day of Week", '%1', TTProgSpecDays."Day Code");
                            IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorDoubles."Programme Day Priority" := 10;
                                    TTTimetableCollectorDoubles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorDoubles.NEXT = 0;
                            END;
                        END;

                        IF TTProgSpecDays."Constraint Category" = TTProgSpecDays."Constraint Category"::Preferred THEN BEGIN
                            //For the Programme and Campus Specified, Set Priority as 1
                            TTTimetableCollectorDoubles.RESET;
                            TTTimetableCollectorDoubles.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorDoubles.SETFILTER("Day of Week", '%1', TTProgSpecDays."Day Code");
                            IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorDoubles."Programme Day Priority" := 1;
                                    TTTimetableCollectorDoubles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorDoubles.NEXT = 0;
                            END;
                        END;

                        IF TTProgSpecDays."Constraint Category" = TTProgSpecDays."Constraint Category"::Mandatory THEN BEGIN
                            //For the Programme and Campus Specified, Set Priority as 1
                            TTTimetableCollectorDoubles.RESET;
                            TTTimetableCollectorDoubles.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorDoubles.SETFILTER("Day of Week", '%1', TTProgSpecDays."Day Code");
                            IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorDoubles."Programme Day Priority" := 1;
                                    TTTimetableCollectorDoubles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorDoubles.NEXT = 0;
                            END;
                        END;
                    END;
                    UNTIL TTProgSpecDays.NEXT = 0;
                END;


                TTTimetableCollectorDoubles.RESET;
                TTTimetableCollectorDoubles.SETRANGE(Programme, TTProgrammes."Programme Code");
                CLEAR(ToDeleteDoubles);
                //// If the Constraints are Nandatory
                TTProgSpecDays.RESET;
                TTProgSpecDays.SETRANGE(Semester, Rec.Semester);
                TTProgSpecDays.SETRANGE("Programme Code", TTProgrammes."Programme Code");
                TTProgSpecDays.SETFILTER("Day Code", '<>%1', '');
                TTProgSpecDays.SETFILTER("Constraint Category", '=%1', TTProgSpecDays."Constraint Category"::Mandatory);
                IF TTProgSpecDays.FIND('-') THEN BEGIN
                    //There Exists Programme Specific Campus Where Category is Mandatory
                    ToDeleteDoubles := TRUE;
                    REPEAT
                    BEGIN
                        //Keep filtering where Campus code is Not the one selected...
                        TTTimetableCollectorDoubles.SETFILTER("Day of Week", '<>%1', TTProgSpecDays."Day Code");
                    END;
                    UNTIL TTProgSpecDays.NEXT = 0;
                    // After Repeated Filtering, Delete All Entries in the Filters
                    IF ToDeleteDoubles THEN IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETE;
                END;
            END;
            UNTIL TTProgrammes.NEXT = 0;
        END;
        //////////////////////////////////////////////////////////////Prog Spec. Days on Doubles
        //////////////////////////////////////////////////////////////Prog Spec. Days on Tripples
        TTProgrammes.RESET;
        TTProgrammes.SETRANGE(Semester, Rec.Semester);
        IF TTProgrammes.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                TTProgSpecDays.RESET;
                TTProgSpecDays.SETRANGE(Semester, Rec.Semester);
                TTProgSpecDays.SETRANGE("Programme Code", TTProgrammes."Programme Code");
                TTProgSpecDays.SETFILTER("Day Code", '<>%1', '');
                IF TTProgSpecDays.FIND('-') THEN BEGIN
                    //There Exists Programme Specific Campus
                    REPEAT
                    BEGIN
                        IF TTProgSpecDays."Constraint Category" = TTProgSpecDays."Constraint Category"::Avoid THEN BEGIN
                            //Delete all entries for the Programme and Campus Specified
                            TTTimetableCollectorTripple.RESET;
                            TTTimetableCollectorTripple.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorTripple.SETFILTER("Day of Week", '%1', TTProgSpecDays."Day Code");
                            IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                        END;
                        IF TTProgSpecDays."Constraint Category" = TTProgSpecDays."Constraint Category"::"Least Preferred" THEN BEGIN
                            //For the Programme and Campus Specified, Set Priority as 10
                            TTTimetableCollectorTripple.RESET;
                            TTTimetableCollectorTripple.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorTripple.SETFILTER("Day of Week", '%1', TTProgSpecDays."Day Code");
                            IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorTripple."Programme Day Priority" := 10;
                                    TTTimetableCollectorTripple.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorTripple.NEXT = 0;
                            END;
                        END;

                        IF TTProgSpecDays."Constraint Category" = TTProgSpecDays."Constraint Category"::Preferred THEN BEGIN
                            //For the Programme and Campus Specified, Set Priority as 1
                            TTTimetableCollectorTripple.RESET;
                            TTTimetableCollectorTripple.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorTripple.SETFILTER("Day of Week", '%1', TTProgSpecDays."Day Code");
                            IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorTripple."Programme Day Priority" := 1;
                                    TTTimetableCollectorTripple.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorTripple.NEXT = 0;
                            END;
                        END;

                        IF TTProgSpecDays."Constraint Category" = TTProgSpecDays."Constraint Category"::Mandatory THEN BEGIN
                            //For the Programme and Campus Specified, Set Priority as 1
                            TTTimetableCollectorTripple.RESET;
                            TTTimetableCollectorTripple.SETRANGE(Programme, TTProgrammes."Programme Code");
                            TTTimetableCollectorTripple.SETFILTER("Day of Week", '%1', TTProgSpecDays."Day Code");
                            IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorTripple."Programme Day Priority" := 1;
                                    TTTimetableCollectorTripple.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorTripple.NEXT = 0;
                            END;
                        END;
                    END;
                    UNTIL TTProgSpecDays.NEXT = 0;
                END;


                TTTimetableCollectorTripple.RESET;
                TTTimetableCollectorTripple.SETRANGE(Programme, TTProgrammes."Programme Code");
                CLEAR(ToDeleteTripples);
                //// If the Constraints are Nandatory
                TTProgSpecDays.RESET;
                TTProgSpecDays.SETRANGE(Semester, Rec.Semester);
                TTProgSpecDays.SETRANGE("Programme Code", TTProgrammes."Programme Code");
                TTProgSpecDays.SETFILTER("Day Code", '<>%1', '');
                TTProgSpecDays.SETFILTER("Constraint Category", '=%1', TTProgSpecDays."Constraint Category"::Mandatory);
                IF TTProgSpecDays.FIND('-') THEN BEGIN
                    //There Exists Programme Specific Campus Where Category is Mandatory
                    ToDeleteTripples := TRUE;
                    REPEAT
                    BEGIN
                        //Keep filtering where Campus code is Not the one selected...
                        TTTimetableCollectorTripple.SETFILTER("Day of Week", '<>%1', TTProgSpecDays."Day Code");
                    END;
                    UNTIL TTProgSpecDays.NEXT = 0;
                    // After Repeated Filtering, Delete All Entries in the Filters
                    IF ToDeleteTripples THEN IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETE;
                END;
            END;
            UNTIL TTProgrammes.NEXT = 0;
        END;
        //////////////////////////////////////////////////////////////Prog Spec. Days on Tripples
    end;

    local procedure SpecificConstraintsLectDays()
    var
        TTProgSpecCampuses: Record 74507;
        TTProgSpecRooms: Record 74509;
        TTProgSpecDays: Record 74508;
        TTLectSpecCampuses: Record 74510;
        TTLectSpecDays: Record 74511;
        TTLectSpecLessons: Record 74512;
        TTUnitSpecCampuses: Record 74513;
        TTUnitSpecRooms: Record 74514;
        TTTimetableCollectorSingles: Record 74500;
        TTTimetableCollectorDoubles: Record 74521;
        TTTimetableCollectorTripple: Record 74522;
        TTProgrammes: Record "TT-Programmes";
        TTUnits: Record "TT-Units";
        TTLecturers: Record "TT-Lecturers";
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
                TTLectSpecDays.SETFILTER("Day Code", '<>%1', '');
                IF TTLectSpecDays.FIND('-') THEN BEGIN
                    //There Exists Lect Specific Campus
                    REPEAT
                    BEGIN
                        IF TTLectSpecDays."Constraint Category" = TTLectSpecDays."Constraint Category"::Avoid THEN BEGIN
                            //Delete all entries for the Lecturer and Campus Specified
                            TTTimetableCollectorSingles.RESET;
                            TTTimetableCollectorSingles.SETRANGE(Lecturer, TTLecturers."Lecturer Code");
                            TTTimetableCollectorSingles.SETFILTER("Day of Week", '%1', TTLectSpecDays."Day Code");
                            IF TTTimetableCollectorSingles.FIND('-') THEN TTTimetableCollectorSingles.DELETEALL;
                        END;
                        IF TTLectSpecDays."Constraint Category" = TTLectSpecDays."Constraint Category"::"Least Preferred" THEN BEGIN
                            //For the Lect and Campus Specified, Set Priority as 10
                            TTTimetableCollectorSingles.RESET;
                            TTTimetableCollectorSingles.SETRANGE(Lecturer, TTLecturers."Lecturer Code");
                            TTTimetableCollectorSingles.SETFILTER("Day of Week", '%1', TTLectSpecDays."Day Code");
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
                            TTTimetableCollectorSingles.SETFILTER("Day of Week", '%1', TTLectSpecDays."Day Code");
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
                            TTTimetableCollectorSingles.SETFILTER("Day of Week", '%1', TTLectSpecDays."Day Code");
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
                TTLectSpecDays.SETFILTER("Day Code", '<>%1', '');
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
                    IF ToDeleteSingles THEN IF TTTimetableCollectorSingles.FIND('-') THEN TTTimetableCollectorSingles.DELETE;
                END;
            END;
            UNTIL TTLecturers.NEXT = 0;
        END;
        //////////////////////////////////////////////////////////////Lect Spec. Days on Singles
        //////////////////////////////////////////////////////////////Lect Spec. Days on Doubles
        TTLecturers.RESET;
        TTLecturers.SETRANGE(Semester, Rec.Semester);
        IF TTLecturers.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                TTLectSpecDays.RESET;
                TTLectSpecDays.SETRANGE(Semester, Rec.Semester);
                TTLectSpecDays.SETRANGE("Lecturer Code", TTLecturers."Lecturer Code");
                TTLectSpecDays.SETFILTER("Day Code", '<>%1', '');
                IF TTLectSpecDays.FIND('-') THEN BEGIN
                    //There Exists Lect Specific Campus
                    REPEAT
                    BEGIN
                        IF TTLectSpecDays."Constraint Category" = TTLectSpecDays."Constraint Category"::Avoid THEN BEGIN
                            //Delete all entries for the Lect and Campus Specified
                            TTTimetableCollectorDoubles.RESET;
                            TTTimetableCollectorDoubles.SETRANGE(Lecturer, TTLecturers."Lecturer Code");
                            TTTimetableCollectorDoubles.SETFILTER("Day of Week", '%1', TTLectSpecDays."Day Code");
                            IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETEALL;
                        END;
                        IF TTLectSpecDays."Constraint Category" = TTLectSpecDays."Constraint Category"::"Least Preferred" THEN BEGIN
                            //For the Lect and Campus Specified, Set Priority as 10
                            TTTimetableCollectorDoubles.RESET;
                            TTTimetableCollectorDoubles.SETRANGE(Lecturer, TTLecturers."Lecturer Code");
                            TTTimetableCollectorDoubles.SETFILTER("Day of Week", '%1', TTLectSpecDays."Day Code");
                            IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorDoubles."Lecturer Campus Priority" := 10;
                                    TTTimetableCollectorDoubles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorDoubles.NEXT = 0;
                            END;
                        END;

                        IF TTLectSpecDays."Constraint Category" = TTLectSpecDays."Constraint Category"::Preferred THEN BEGIN
                            //For the Lect and Campus Specified, Set Priority as 1
                            TTTimetableCollectorDoubles.RESET;
                            TTTimetableCollectorDoubles.SETRANGE(Lecturer, TTLecturers."Lecturer Code");
                            TTTimetableCollectorDoubles.SETFILTER("Day of Week", '%1', TTLectSpecDays."Day Code");
                            IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorDoubles."Lecturer Campus Priority" := 1;
                                    TTTimetableCollectorDoubles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorDoubles.NEXT = 0;
                            END;
                        END;

                        IF TTLectSpecDays."Constraint Category" = TTLectSpecDays."Constraint Category"::Mandatory THEN BEGIN
                            //For the Lect and Campus Specified, Set Priority as 1
                            TTTimetableCollectorDoubles.RESET;
                            TTTimetableCollectorDoubles.SETRANGE(Lecturer, TTLecturers."Lecturer Code");
                            TTTimetableCollectorDoubles.SETFILTER("Day of Week", '%1', TTLectSpecDays."Day Code");
                            IF TTTimetableCollectorDoubles.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorDoubles."Lecturer Campus Priority" := 1;
                                    TTTimetableCollectorDoubles.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorDoubles.NEXT = 0;
                            END;
                        END;
                    END;
                    UNTIL TTLectSpecDays.NEXT = 0;
                END;


                TTTimetableCollectorDoubles.RESET;
                TTTimetableCollectorDoubles.SETRANGE(Lecturer, TTLecturers."Lecturer Code");
                CLEAR(ToDeleteDoubles);
                //// If the Constraints are Nandatory
                TTLectSpecDays.RESET;
                TTLectSpecDays.SETRANGE(Semester, Rec.Semester);
                TTLectSpecDays.SETRANGE("Lecturer Code", TTLecturers."Lecturer Code");
                TTLectSpecDays.SETFILTER("Day Code", '<>%1', '');
                TTLectSpecDays.SETFILTER("Constraint Category", '=%1', TTLectSpecDays."Constraint Category"::Mandatory);
                IF TTLectSpecDays.FIND('-') THEN BEGIN
                    //There Exists Lect Specific Campus Where Category is Mandatory
                    ToDeleteDoubles := TRUE;
                    REPEAT
                    BEGIN
                        //Keep filtering where Campus code is Not the one selected...
                        TTTimetableCollectorDoubles.SETFILTER("Day of Week", '<>%1', TTLectSpecDays."Day Code");
                    END;
                    UNTIL TTLectSpecDays.NEXT = 0;
                    // After Repeated Filtering, Delete All Entries in the Filters
                    IF ToDeleteDoubles THEN IF TTTimetableCollectorDoubles.FIND('-') THEN TTTimetableCollectorDoubles.DELETE;
                END;
            END;
            UNTIL TTLecturers.NEXT = 0;
        END;
        //////////////////////////////////////////////////////////////Lect Spec. Days on Doubles
        //////////////////////////////////////////////////////////////Lect Spec. Days on Tripples
        TTLecturers.RESET;
        TTLecturers.SETRANGE(Semester, Rec.Semester);
        IF TTLecturers.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                TTLectSpecDays.RESET;
                TTLectSpecDays.SETRANGE(Semester, Rec.Semester);
                TTLectSpecDays.SETRANGE("Lecturer Code", TTLecturers."Lecturer Code");
                TTLectSpecDays.SETFILTER("Day Code", '<>%1', '');
                IF TTLectSpecDays.FIND('-') THEN BEGIN
                    //There Exists Lect Specific Campus
                    REPEAT
                    BEGIN
                        IF TTLectSpecDays."Constraint Category" = TTLectSpecDays."Constraint Category"::Avoid THEN BEGIN
                            //Delete all entries for the Lect and Campus Specified
                            TTTimetableCollectorTripple.RESET;
                            TTTimetableCollectorTripple.SETRANGE(Lecturer, TTLecturers."Lecturer Code");
                            TTTimetableCollectorTripple.SETFILTER("Day of Week", '%1', TTLectSpecDays."Day Code");
                            IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETEALL;
                        END;
                        IF TTLectSpecDays."Constraint Category" = TTLectSpecDays."Constraint Category"::"Least Preferred" THEN BEGIN
                            //For the Lecturer and Campus Specified, Set Priority as 10
                            TTTimetableCollectorTripple.RESET;
                            TTTimetableCollectorTripple.SETRANGE(Lecturer, TTLecturers."Lecturer Code");
                            TTTimetableCollectorTripple.SETFILTER("Day of Week", '%1', TTLectSpecDays."Day Code");
                            IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorTripple."Lecturer Campus Priority" := 10;
                                    TTTimetableCollectorTripple.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorTripple.NEXT = 0;
                            END;
                        END;

                        IF TTLectSpecDays."Constraint Category" = TTLectSpecDays."Constraint Category"::Preferred THEN BEGIN
                            //For the Lecturer nd Campus Specified, Set Priority as 1
                            TTTimetableCollectorTripple.RESET;
                            TTTimetableCollectorTripple.SETRANGE(Lecturer, TTLecturers."Lecturer Code");
                            TTTimetableCollectorTripple.SETFILTER("Day of Week", '%1', TTLectSpecDays."Day Code");
                            IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorTripple."Lecturer Campus Priority" := 1;
                                    TTTimetableCollectorTripple.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorTripple.NEXT = 0;
                            END;
                        END;

                        IF TTLectSpecDays."Constraint Category" = TTLectSpecDays."Constraint Category"::Mandatory THEN BEGIN
                            //For the Lecturer nd Campus Specified, Set Priority as 1
                            TTTimetableCollectorTripple.RESET;
                            TTTimetableCollectorTripple.SETRANGE(Lecturer, TTLecturers."Lecturer Code");
                            TTTimetableCollectorTripple.SETFILTER("Day of Week", '%1', TTLectSpecDays."Day Code");
                            IF TTTimetableCollectorTripple.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    TTTimetableCollectorTripple."Lecturer Campus Priority" := 1;
                                    TTTimetableCollectorTripple.MODIFY;
                                END;
                                UNTIL TTTimetableCollectorTripple.NEXT = 0;
                            END;
                        END;
                    END;
                    UNTIL TTLectSpecDays.NEXT = 0;
                END;


                TTTimetableCollectorTripple.RESET;
                TTTimetableCollectorTripple.SETRANGE(Lecturer, TTLecturers."Lecturer Code");
                CLEAR(ToDeleteTripples);
                //// If the Constraints are Nandatory
                TTLectSpecDays.RESET;
                TTLectSpecDays.SETRANGE(Semester, Rec.Semester);
                TTLectSpecDays.SETRANGE("Lecturer Code", TTLecturers."Lecturer Code");
                TTLectSpecDays.SETFILTER("Day Code", '<>%1', '');
                TTLectSpecDays.SETFILTER("Constraint Category", '=%1', TTLectSpecDays."Constraint Category"::Mandatory);
                IF TTLectSpecDays.FIND('-') THEN BEGIN
                    //There Exists Lecturer Specific Campus Where Category is Mandatory
                    ToDeleteTripples := TRUE;
                    REPEAT
                    BEGIN
                        //Keep filtering where Campus code is Not the one selected...
                        TTTimetableCollectorTripple.SETFILTER("Day of Week", '<>%1', TTLectSpecDays."Day Code");
                    END;
                    UNTIL TTLectSpecDays.NEXT = 0;
                    // After Repeated Filtering, Delete All Entries in the Filters
                    IF ToDeleteTripples THEN IF TTTimetableCollectorTripple.FIND('-') THEN TTTimetableCollectorTripple.DELETE;
                END;
            END;
            UNTIL TTLecturers.NEXT = 0;
        END;
        //////////////////////////////////////////////////////////////Lect Spec. Days on Tripples
    end;
}

