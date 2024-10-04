report 51532 "Time Table - By Lecturer Room"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Time Table - By Lecturer Room.rdl';

    dataset
    {
        dataitem("ACA-Day Of Week"; "ACA-Day Of Week")
        {
            RequestFilterFields = "Lecture Room Filter", "Programme Filter", "Stage Filter", "Unit Filter", "Class Filter", "Unit Class Filter", "Semester Filter", "Student Type", "Lecturer Filter", "Exam Filter";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
#pragma warning disable AL0667
            column(CurrReport_PAGENO; CurrReport.PAGENO)
#pragma warning restore AL0667
            {
            }
            column(USERID; USERID)
            {
            }
            column(GETFILTER__Programme_Filter__; GETFILTER("Programme Filter"))
            {
            }
            column(GETFILTER__Stage_Filter__; GETFILTER("Stage Filter"))
            {
            }
            column(GETFILTER__Unit_Filter__; GETFILTER("Unit Filter"))
            {
            }
            column(GETFILTER__Semester_Filter__; GETFILTER("Semester Filter"))
            {
            }
            column(GETFILTER__Lecture_Room_Filter__; GETFILTER("Lecture Room Filter"))
            {
            }
            column(GETFILTER__Class_Filter__; GETFILTER("Class Filter"))
            {
            }
            column(L_1_; L[1])
            {
            }
            column(L_2_; L[2])
            {
            }
            column(L_3_; L[3])
            {
            }
            column(L_4_; L[4])
            {
            }
            column(L_5_; L[5])
            {
            }
            column(L_6_; L[6])
            {
            }
            column(L_7_; L[7])
            {
            }
            column(L_8_; L[8])
            {
            }
            column(L_9_; L[9])
            {
            }
            column(L_10_; L[10])
            {
            }
            column(L_11_; L[11])
            {
            }
            column(T_1_; T[1])
            {
            }
            column(T_2_; T[2])
            {
            }
            column(T_3_; T[3])
            {
            }
            column(T_4_; T[4])
            {
            }
            column(T_8_; T[8])
            {
            }
            column(T_7_; T[7])
            {
            }
            column(T_6_; T[6])
            {
            }
            column(T_5_; T[5])
            {
            }
            column(T_12_; T[12])
            {
            }
            column(T_11_; T[11])
            {
            }
            column(T_10_; T[10])
            {
            }
            column(Day_Of_Week_Day; Day)
            {
            }
            column(Time_TableCaption; Time_TableCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Programme_Filter_Caption; Programme_Filter_CaptionLbl)
            {
            }
            column(Stage_Filter_Caption; Stage_Filter_CaptionLbl)
            {
            }
            column(Unit_Filter_Caption; Unit_Filter_CaptionLbl)
            {
            }
            column(Semester_Filter_Caption; Semester_Filter_CaptionLbl)
            {
            }
            column(Lecture_Room_Filter_Caption; Lecture_Room_Filter_CaptionLbl)
            {
            }
            column(Class_Filter_Caption; Class_Filter_CaptionLbl)
            {
            }
            column(Day_Of_Week_No_; "No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                T[1] := '';
                T[2] := '';
                T[3] := '';
                T[4] := '';
                T[5] := '';
                T[6] := '';
                T[7] := '';
                T[8] := '';
                T[9] := '';
                T[10] := '';
                T[11] := '';
                T[12] := '';
                T[13] := '';
                T[14] := '';

                TimeTable.RESET;
                TimeTable.SETRANGE(TimeTable.Released, FALSE);
                TimeTable.SETRANGE(TimeTable."Day of Week", "ACA-Day Of Week".Day);
                TimeTable.SETFILTER(TimeTable.Programme, "ACA-Day Of Week".GETFILTER("ACA-Day Of Week"."Programme Filter"));
                TimeTable.SETFILTER(TimeTable.Stage, "ACA-Day Of Week".GETFILTER("ACA-Day Of Week"."Stage Filter"));
                TimeTable.SETFILTER(TimeTable.Unit, "ACA-Day Of Week".GETFILTER("ACA-Day Of Week"."Unit Filter"));
                TimeTable.SETFILTER(TimeTable.Semester, "ACA-Day Of Week".GETFILTER("ACA-Day Of Week"."Semester Filter"));
                TimeTable.SETFILTER(TimeTable."Lecture Room", "ACA-Day Of Week".GETFILTER("ACA-Day Of Week"."Lecture Room Filter"));
                TimeTable.SETFILTER(TimeTable.Class, "ACA-Day Of Week".GETFILTER("ACA-Day Of Week"."Class Filter"));
                TimeTable.SETFILTER(TimeTable."Unit Class", "ACA-Day Of Week".GETFILTER("ACA-Day Of Week"."Unit Class Filter"));
                TimeTable.SETFILTER(TimeTable.Lecturer, "ACA-Day Of Week".GETFILTER("ACA-Day Of Week"."Lecturer Filter"));
                TimeTable.SETFILTER(TimeTable.Exam, "ACA-Day Of Week".GETFILTER("ACA-Day Of Week"."Exam Filter"));
                IF TimeTable.FIND('-') THEN BEGIN
                    REPEAT
                        Lec := '';

                        LUnits.RESET;
                        LUnits.SETRANGE(LUnits.Programme, TimeTable.Programme);
                        LUnits.SETRANGE(LUnits.Stage, TimeTable.Stage);
                        LUnits.SETRANGE(LUnits.Unit, TimeTable.Unit);
                        LUnits.SETRANGE(LUnits.Semester, TimeTable.Semester);
                        LUnits.SETRANGE(LUnits.Class, TimeTable.Class);
                        LUnits.SETRANGE(LUnits."Unit Class", TimeTable."Unit Class");
                        IF LUnits.FIND('-') THEN BEGIN
                            Emp.RESET;
                            Emp.SETRANGE(Emp."No.", LUnits.Lecturer);
                            IF Emp.FIND('-') THEN
                                Lec := Emp."Last Name";
                        END;


                        Units.RESET;
                        Units.SETRANGE(Units."Programme Code", TimeTable.Programme);
                        Units.SETRANGE(Units."Stage Code", TimeTable.Stage);
                        Units.SETRANGE(Units.Code, TimeTable.Unit);
                        IF Units.FIND('-') THEN BEGIN
                            TKey.RESET;
                            TKey.SETRANGE(TKey.Code, TimeTable.Unit);
                            IF TKey.FIND('-') THEN
                                TKey.DELETEALL;

                            TKey.INIT;
                            TKey.Code := TimeTable.Unit;
                            TKey.Description := Units.Desription;
                            TKey.Lecturer := Lec;
                            TKey.INSERT;

                        END;

                        Lessons.RESET;
                        Lessons.SETRANGE(Lessons.Code, TimeTable.Period);
                        IF Lessons.FIND('-') THEN BEGIN
                            IF (TimeTable."Unit Class" = '') AND (TimeTable.Class = '') THEN BEGIN
                                T[Lessons."No."] := T[Lessons."No."] + '[' + TimeTable.Programme + ' ' + TimeTable.Stage + ' '
                                 + TimeTable.Unit + ' ' + Lec + ']';

                            END ELSE
                                IF (TimeTable."Unit Class" = '') AND (TimeTable.Class <> '') THEN BEGIN
                                    T[Lessons."No."] := T[Lessons."No."] + '[' + TimeTable.Programme + ' ' + TimeTable.Stage + ' ' + TimeTable.Class + ' '
                                     + TimeTable.Unit + ' ' + Lec + ']';

                                END ELSE BEGIN
                                    T[Lessons."No."] := T[Lessons."No."] + '[' + TimeTable.Programme + ' ' + TimeTable.Stage
                                     + ' ' + TimeTable.Unit + ' ' + TimeTable.Class + ' ' + Lec + ' '
                                    + TimeTable."Unit Class" + ']';
                                END;

                        END;
                    UNTIL TimeTable.NEXT = 0;
                END;

                //T[Lessons."No."] :=T[Lessons."No."] + '(' + TimeTable.Programme + ',' + TimeTable.Stage
                // + ',' + TimeTable.Unit + ',' + TimeTable.Class + ',' + TimeTable."Lecture Room" + ') ';
            end;
        }
        dataitem("ACA-Timetable Key"; "ACA-Timetable Key")
        {
            column(Timetable_Key_Code; Code)
            {
            }
            column(Timetable_Key__Timetable_Key__Description; "ACA-Timetable Key".Description)
            {
            }
            column(Timetable_Key_Lecturer; Lecturer)
            {
            }
            column(KEY_Caption; KEY_CaptionLbl)
            {
            }

            trigger OnPreDataItem()
            begin
                /*
                "Units/Subjects".RESET;
                "Units/Subjects".SETRANGE("Units/Subjects"."Programme Code","Day Of Week".GETFILTER("Day Of Week"."Programme Filter"));
                "Units/Subjects".SETRANGE("Units/Subjects"."Stage Code","Day Of Week".GETFILTER("Day Of Week"."Stage Filter"));
                */

            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        Lessons.RESET;
        IF Lessons.FIND('-') THEN BEGIN
            REPEAT
                L[Lessons."No."] := Lessons.Code;
            UNTIL Lessons.NEXT = 0;
        END;
    end;

    var
        TimeTable: Record 61540;
        Lessons: Record 61542;
        L: array[14] of Text[100];
        T: array[14] of Text[250];
        CellCont: Text[250];
        i: Integer;
        LUnits: Record 61541;
        Lec: Text[250];
        Emp: Record 61188;
        TKey: Record 61586;
        Units: Record 61517;
        Time_TableCaptionLbl: Label 'Time Table';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Programme_Filter_CaptionLbl: Label 'Programme Filter:';
        Stage_Filter_CaptionLbl: Label 'Stage Filter:';
        Unit_Filter_CaptionLbl: Label 'Unit Filter:';
        Semester_Filter_CaptionLbl: Label 'Semester Filter:';
        Lecture_Room_Filter_CaptionLbl: Label 'Lecture Room Filter:';
        Class_Filter_CaptionLbl: Label 'Class Filter:';
        KEY_CaptionLbl: Label 'KEY:';
}

