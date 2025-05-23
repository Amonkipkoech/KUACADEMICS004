report 51548 "Time Table BU"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Time Table BU.rdl';

    dataset
    {
        dataitem("ACA-Day Of Week"; "ACA-Day Of Week")
        {
            RequestFilterFields = "Programme Filter", "Stage Filter", "Unit Filter", "Class Filter", "Unit Class Filter", "Semester Filter", "Student Type", "Lecturer Filter", "Exam Filter", "Lecture Room Filter", "Department Filter";
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
            column(Day_Of_Week_Day; Day)
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
            column(Master_Time_TableCaption; Master_Time_TableCaptionLbl)
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
                TimeTable.SETFILTER(TimeTable.Department, "ACA-Day Of Week".GETFILTER("ACA-Day Of Week"."Department Filter"));
                TimeTable.SETFILTER(TimeTable.Session, "ACA-Day Of Week".GETFILTER("ACA-Day Of Week"."Student Type"));
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

                        Lessons.RESET;
                        Lessons.SETRANGE(Lessons.Code, TimeTable.Period);
                        IF Lessons.FIND('-') THEN BEGIN
                            IF TimeTable."Unit Class" = '' THEN BEGIN
                                IF STRLEN(T[Lessons."No."]) < 245 THEN
                                    T[Lessons."No."] := T[Lessons."No."] + '[' + TimeTable.Programme + ' ' + TimeTable.Stage + ' ' + TimeTable.Exam
                                     + ' ' + TimeTable.Unit + ' ' + TimeTable.Class + ' ' + Lec + ' ' + TimeTable."Lecture Room" + '] ';

                            END ELSE
                                IF (TimeTable.Class = '') AND (TimeTable.Exam = '') THEN BEGIN
                                    IF STRLEN(T[Lessons."No."]) < 245 THEN
                                        T[Lessons."No."] := T[Lessons."No."] + '[' + TimeTable.Programme + ',' + TimeTable.Stage + ','
                                         + TimeTable.Unit + ',' + Lec + ',' + TimeTable."Lecture Room" + '] ';


                                END ELSE BEGIN
                                    IF STRLEN(T[Lessons."No."]) < 245 THEN
                                        T[Lessons."No."] := T[Lessons."No."] + '(' + TimeTable.Programme + ',' + TimeTable.Stage
                                         + ',' + TimeTable.Unit + ',' + TimeTable.Class + ',' + Lec + ',' + TimeTable."Lecture Room" + ',' + TimeTable.Exam
                                         + ' ' + TimeTable."Unit Class" + ') ';
                                END;

                        END;
                    UNTIL TimeTable.NEXT = 0;
                END;

                //T[Lessons."No."] :=T[Lessons."No."] + '(' + TimeTable.Programme + ',' + TimeTable.Stage
                // + ',' + TimeTable.Unit + ',' + TimeTable.Class + ',' + TimeTable."Lecture Room" + ') ';
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
        Master_Time_TableCaptionLbl: Label 'Master Time Table';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Programme_Filter_CaptionLbl: Label 'Programme Filter:';
        Stage_Filter_CaptionLbl: Label 'Stage Filter:';
        Unit_Filter_CaptionLbl: Label 'Unit Filter:';
        Semester_Filter_CaptionLbl: Label 'Semester Filter:';
        Lecture_Room_Filter_CaptionLbl: Label 'Lecture Room Filter:';
        Class_Filter_CaptionLbl: Label 'Class Filter:';
}

