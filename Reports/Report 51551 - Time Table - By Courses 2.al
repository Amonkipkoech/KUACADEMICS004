report 51551 "Time Table - By Courses 2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Time Table - By Courses 2.rdl';

    dataset
    {
        dataitem("ACA-Day Of Week"; "ACA-Day Of Week")
        {
            RequestFilterFields = Exams, "Programme Filter", "Stage Filter", "Unit Filter", "Class Filter", "Unit Class Filter", "Semester Filter", "Student Type", "Lecturer Filter", "Exam Filter", "Lecture Room Filter";
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
            column(TTType; TTType)
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
            column(L_12_; L[12])
            {
            }
            column(Day_Of_Week_Remarks; Remarks)
            {
            }
            column(Time_Table_Caption; Time_Table_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Programme_Filter_Caption; Programme_Filter_CaptionLbl)
            {
            }
            column(Year_Filter_Caption; Year_Filter_CaptionLbl)
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
            column(Day_Of_Week_Day; Day)
            {
            }
            dataitem("ACA-Units/Subjects"; "ACA-Units/Subjects")
            {
                DataItemTableView = SORTING(Code);
                column(T_1_; T[1])
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
                column(T_4_; T[4])
                {
                }
                column(T_3_; T[3])
                {
                }
                column(T_2_; T[2])
                {
                }
                column(COPYSTR__Units_Subjects__Code_1_3_; COPYSTR("ACA-Units/Subjects".Code, 1, 3))
                {
                }
                column(T_9_; T[9])
                {
                }
                column(Units_Subjects_Code; Code)
                {
                }
                column(Units_Subjects_Programme_Code; "Programme Code")
                {
                }
                column(Units_Subjects_Stage_Code; "Stage Code")
                {
                }
                column(Units_Subjects_Entry_No; "Entry No")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SCode := FALSE;
                    IF PCode <> COPYSTR("ACA-Units/Subjects".Code, 1, 3) THEN BEGIN
                        UnitFilter := COPYSTR("ACA-Units/Subjects".Code, 1, 3) + '*';

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



                        SOutput := FALSE;

                        PrevU := FALSE;
                        PrevP := FALSE;

                        IF PUnit = "ACA-Units/Subjects".Code THEN
                            PrevU := TRUE;

                        PUnit := "ACA-Units/Subjects".Code;

                        IF PProg = "ACA-Units/Subjects"."Programme Code" THEN
                            PrevP := TRUE;

                        PProg := "ACA-Units/Subjects"."Programme Code";


                        //IF (PrevP=TRUE) AND (PrevU=TRUE) THEN
                        //EXIT;


                        TimeTable.RESET;
                        TimeTable.SETRANGE(TimeTable.Released, FALSE);
                        TimeTable.SETRANGE(TimeTable."Day of Week", "ACA-Day Of Week".Day);
                        //TimeTable.SETFILTER(TimeTable.Programme,"Units/Subjects"."Programme Code");
                        TimeTable.SETFILTER(TimeTable.Stage, "ACA-Day Of Week".GETFILTER("ACA-Day Of Week"."Stage Filter"));
                        TimeTable.SETFILTER(TimeTable.Unit, UnitFilter);
                        TimeTable.SETFILTER(TimeTable.Semester, "ACA-Day Of Week".GETFILTER("ACA-Day Of Week"."Semester Filter"));
                        TimeTable.SETFILTER(TimeTable."Lecture Room", "ACA-Day Of Week".GETFILTER("ACA-Day Of Week"."Lecture Room Filter"));
                        TimeTable.SETFILTER(TimeTable.Class, "ACA-Day Of Week".GETFILTER("ACA-Day Of Week"."Class Filter"));
                        TimeTable.SETFILTER(TimeTable."Unit Class", "ACA-Day Of Week".GETFILTER("ACA-Day Of Week"."Unit Class Filter"));
                        TimeTable.SETFILTER(TimeTable.Lecturer, "ACA-Day Of Week".GETFILTER("ACA-Day Of Week"."Lecturer Filter"));
                        TimeTable.SETFILTER(TimeTable.Exam, "ACA-Day Of Week".GETFILTER("ACA-Day Of Week"."Exam Filter"));
                        IF TimeTable.FIND('-') THEN BEGIN
                            REPEAT
                                SOutput := TRUE;
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
                                    IF (TimeTable."Unit Class" = '') AND (TimeTable.Class <> '') THEN BEGIN
                                        T[Lessons."No."] := T[Lessons."No."] + '['
                                         + TimeTable.Unit + ' ' + TimeTable.Class + ' ' + Lec + ' ' + TimeTable."Lecture Room" + '] ';

                                    END ELSE
                                        IF (TimeTable.Class = '') AND (TimeTable."Unit Class" = '') THEN BEGIN
                                            T[Lessons."No."] := T[Lessons."No."] + '[' + TimeTable.Unit + ' ' + Lec + ' ' + TimeTable."Lecture Room" + '] ';


                                        END ELSE BEGIN
                                            T[Lessons."No."] := T[Lessons."No."] + '['
                                             + TimeTable.Unit + ' ' + TimeTable.Class + ' ' + Lec + ' ' + TimeTable."Lecture Room" + ','
                                             + TimeTable."Unit Class" + '] ';
                                        END;

                                END;
                            UNTIL TimeTable.NEXT = 0;
                        END;


                    END ELSE
                        SCode := TRUE;



                    PCode := COPYSTR("ACA-Units/Subjects".Code, 1, 3);
                end;

                trigger OnPreDataItem()
                begin
                    //"Units/Subjects".RESET;
                    //IF "Day Of Week".GETFILTER("Day Of Week"."Programme Filter") <> '' THEN
                    "ACA-Units/Subjects".SETFILTER("ACA-Units/Subjects"."Programme Code", "ACA-Day Of Week".GETFILTER("ACA-Day Of Week"."Programme Filter"));
                    //IF "Day Of Week".GETFILTER("Day Of Week"."Stage Filter") <> '' THEN
                    "ACA-Units/Subjects".SETFILTER("ACA-Units/Subjects"."Stage Code", "ACA-Day Of Week".GETFILTER("ACA-Day Of Week"."Stage Filter"));
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TTType := 'TEACHING';
                IF "ACA-Day Of Week".Exams = TRUE THEN
                    TTType := 'EXAM';
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
        LName: Text[200];
        SOutput: Boolean;
        PUnit: Code[20];
        PrevU: Boolean;
        PrevP: Boolean;
        PProg: Code[20];
        PCode: Code[20];
        SCode: Boolean;
        UnitFilter: Code[20];
        TTType: Text[50];
        Time_Table_CaptionLbl: Label 'Time Table:';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Programme_Filter_CaptionLbl: Label 'Programme Filter:';
        Year_Filter_CaptionLbl: Label 'Year Filter:';
        Unit_Filter_CaptionLbl: Label 'Unit Filter:';
        Semester_Filter_CaptionLbl: Label 'Semester Filter:';
        Lecture_Room_Filter_CaptionLbl: Label 'Lecture Room Filter:';
        Class_Filter_CaptionLbl: Label 'Class Filter:';
}

