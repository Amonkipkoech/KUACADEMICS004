/// <summary>
/// Report Consolidated Marksheet (ID 51579).
/// </summary>
report 51579 "Consolidated Marksheet"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Consolidated Marksheet.rdl';

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {
            DataItemTableView = SORTING("Student No.", Programmes, Semester, "Register for", Stage, Unit, "Student Type");
            RequestFilterFields = "Programme Filter", Stage, "Stage Filter", "Options Filter", "Cummulative Year Filter", "Student No.", Session;
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(SDesc; SDesc)
            {
            }
            column(FDesc; FDesc)
            {
            }
            column(Dept; Dept)
            {
            }
            column(PName; PName)
            {
            }
            column(Comb; Comb)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(USERID; USERID)
            {
            }
#pragma warning disable AL0667
            column(CurrReport_PAGENO; CurrReport.PAGENO)
#pragma warning restore AL0667
            {
            }
            column(Course_Registration_Session; Session)
            {
            }
            column(ColumnH_1_; ColumnH[1])
            {
            }
            column(ColumnH_8_; ColumnH[8])
            {
            }
            column(ColumnH_6_; ColumnH[6])
            {
            }
            column(ColumnH_7_; ColumnH[7])
            {
            }
            column(ColumnH_4_; ColumnH[4])
            {
            }
            column(ColumnH_3_; ColumnH[3])
            {
            }
            column(ColumnH_5_; ColumnH[5])
            {
            }
            column(ColumnH_2_; ColumnH[2])
            {
            }
            column(ColumnH_15_; ColumnH[15])
            {
            }
            column(ColumnH_14_; ColumnH[14])
            {
            }
            column(ColumnH_13_; ColumnH[13])
            {
            }
            column(ColumnH_12_; ColumnH[12])
            {
            }
            column(ColumnH_10_; ColumnH[10])
            {
            }
            column(ColumnH_9_; ColumnH[9])
            {
            }
            column(ColumnH_11_; ColumnH[11])
            {
            }
            column(ColumnH_23_; ColumnH[23])
            {
            }
            column(ColumnH_22_; ColumnH[22])
            {
            }
            column(ColumnH_21_; ColumnH[21])
            {
            }
            column(ColumnH_20_; ColumnH[20])
            {
            }
            column(ColumnH_19_; ColumnH[19])
            {
            }
            column(ColumnH_18_; ColumnH[18])
            {
            }
            column(ColumnH_17_; ColumnH[17])
            {
            }
            column(ColumnH_16_; ColumnH[16])
            {
            }
            column(uColumnV_1_; uColumnV[1])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(uColumnV_2_; uColumnV[2])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(uColumnV_3_; uColumnV[3])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(uColumnV_4_; uColumnV[4])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(uColumnV_5_; uColumnV[5])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(uColumnV_6_; uColumnV[6])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(uColumnV_7_; uColumnV[7])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(uColumnV_8_; uColumnV[8])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(uColumnV_9_; uColumnV[9])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(uColumnV_10_; uColumnV[10])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(uColumnV_11_; uColumnV[11])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(uColumnV_12_; uColumnV[12])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(uColumnV_13_; uColumnV[13])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(uColumnV_14_; uColumnV[14])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(uColumnV_15_; uColumnV[15])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(uColumnV_16_; uColumnV[16])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(uColumnV_17_; uColumnV[17])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(uColumnV_18_; uColumnV[18])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(uColumnV_19_; uColumnV[19])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(uColumnV_20_; uColumnV[20])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(uColumnV_21_; uColumnV[21])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(uColumnV_22_; uColumnV[22])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(uColumnV_23_; uColumnV[23])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(uColumnV_30_; uColumnV[30])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(uColumnV_29_; uColumnV[29])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(uColumnV_28_; uColumnV[28])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(ColumnH_26_; ColumnH[26])
            {
            }
            column(ColumnH_30_; ColumnH[30])
            {
            }
            column(ColumnH_29_; ColumnH[29])
            {
            }
            column(ColumnH_28_; ColumnH[28])
            {
            }
            column(uColumnV_27_; uColumnV[27])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(ColumnH_27_; ColumnH[27])
            {
            }
            column(uColumnV_26_; uColumnV[26])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(ColumnH_25_; ColumnH[25])
            {
            }
            column(uColumnV_25_; uColumnV[25])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(ColumnH_24_; ColumnH[24])
            {
            }
            column(uColumnV_24_; uColumnV[24])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(sColumnV_1_; sColumnV[1])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(sColumnV_2_; sColumnV[2])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(sColumnV_3_; sColumnV[3])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(sColumnV_4_; sColumnV[4])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(sColumnV_5_; sColumnV[5])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(sColumnV_6_; sColumnV[6])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(sColumnV_7_; sColumnV[7])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(sColumnV_8_; sColumnV[8])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(sColumnV_9_; sColumnV[9])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(sColumnV_10_; sColumnV[10])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(sColumnV_11_; sColumnV[11])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(sColumnV_12_; sColumnV[12])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(sColumnV_13_; sColumnV[13])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(sColumnV_14_; sColumnV[14])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(sColumnV_15_; sColumnV[15])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(sColumnV_16_; sColumnV[16])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(sColumnV_17_; sColumnV[17])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(sColumnV_18_; sColumnV[18])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(sColumnV_19_; sColumnV[19])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(sColumnV_20_; sColumnV[20])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(sColumnV_21_; sColumnV[21])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(sColumnV_22_; sColumnV[22])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(sColumnV_23_; sColumnV[23])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(sColumnV_24_; sColumnV[24])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(sColumnV_25_; sColumnV[25])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(sColumnV_26_; sColumnV[26])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(sColumnV_27_; sColumnV[27])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(sColumnV_28_; sColumnV[28])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(sColumnV_29_; sColumnV[29])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(sColumnV_30_; sColumnV[30])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(Course_Registration__Student_No__; "Student No.")
            {
            }
            column(Cust_Name; Cust.Name)
            {
            }
            column(ColumnV_1_; ColumnV[1])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(ColumnV_8_; ColumnV[8])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(ColumnV_7_; ColumnV[7])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(ColumnV_6_; ColumnV[6])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(ColumnV_5_; ColumnV[5])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(ColumnV_4_; ColumnV[4])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(ColumnV_3_; ColumnV[3])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(ColumnV_2_; ColumnV[2])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(ColumnV_14_; ColumnV[14])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(ColumnV_13_; ColumnV[13])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(ColumnV_12_; ColumnV[12])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(ColumnV_11_; ColumnV[11])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(ColumnV_10_; ColumnV[10])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(ColumnV_9_; ColumnV[9])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(ColumnV_23_; ColumnV[23])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(ColumnV_22_; ColumnV[22])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(ColumnV_21_; ColumnV[21])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(ColumnV_20_; ColumnV[20])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(ColumnV_19_; ColumnV[19])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(ColumnV_18_; ColumnV[18])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(ColumnV_17_; ColumnV[17])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(ColumnV_16_; ColumnV[16])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(ColumnV_15_; ColumnV[15])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(SCount; SCount)
            {
            }
            column(ColumnV_30_; ColumnV[30])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(ColumnV_29_; ColumnV[29])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(ColumnV_28_; ColumnV[28])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(ColumnV_27_; ColumnV[27])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(ColumnV_26_; ColumnV[26])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(ColumnV_25_; ColumnV[25])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(ColumnV_24_; ColumnV[24])
            {
                //DecimalPlaces = 0 : 0;
            }
            column(Consolidated_MarksheetCaption; Consolidated_MarksheetCaptionLbl)
            {
            }
            column(Year_of_Study_Caption; Year_of_Study_CaptionLbl)
            {
            }
            column(Faculty_Caption; Faculty_CaptionLbl)
            {
            }
            column(Department_Caption; Department_CaptionLbl)
            {
            }
            column(Programme_of_Study_Caption; Programme_of_Study_CaptionLbl)
            {
            }
            column(Combination_Caption; Combination_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Intake_Caption; Intake_CaptionLbl)
            {
            }
            column(Registration_No_Caption; Registration_No_CaptionLbl)
            {
            }
            column(NamesCaption; NamesCaptionLbl)
            {
            }
            column(UNITS__Caption; UNITS__CaptionLbl)
            {
            }
            column(Serial_No_Caption; Serial_No_CaptionLbl)
            {
            }
            column(Guide_on_remarks_Caption; Guide_on_remarks_CaptionLbl)
            {
            }
            column(DataItem1102760088; pYear)
            {
            }
            column(DataItem1102760089; smks)
            {
            }
            column(DataItem1102760090; mismark)
            {
            }
            column(Course_Registration_Reg__Transacton_ID; "Reg. Transacton ID")
            {
            }
            column(Course_Registration_Programme; Programmes)
            {
            }
            column(Course_Registration_Semester; Semester)
            {
            }
            column(Course_Registration_Register_for; "Register for")
            {
            }
            column(Course_Registration_Stage; Stage)
            {
            }
            column(Course_Registration_Unit; Unit)
            {
            }
            column(Course_Registration_Student_Type; "Student Type")
            {
            }
            column(Course_Registration_Entry_No_; "Entry No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                i := 0;
                TScore := 0;
                RUnits := 0;
                MissingM := FALSE;
                MCourse := FALSE;


                i := 0;
                REPEAT
                    i := i + 1;
                    ColumnV[i] := '';
                UNTIL i = 80;
                i := 0;



                IF Dept = '' THEN BEGIN
                    IF Prog.GET("ACA-Course Registration".Programmes) THEN BEGIN
                        PName := Prog.Description;
                        IF FacultyR.GET(Prog.Faculty) THEN
                            FDesc := FacultyR.Description;

                        DValue.RESET;
                        DValue.SETRANGE(DValue.Code, Prog."School Code");
                        IF DValue.FIND('-') THEN
                            Dept := DValue.Name;

                    END;

                    IF Stages.GET("ACA-Course Registration".Programmes, "ACA-Course Registration".Stage) THEN
                        SDesc := Stages.Description;

                    IF ProgOptions.GET("ACA-Course Registration".Programmes, "ACA-Course Registration".Stage, GETFILTER("Options Filter")) THEN
                        Comb := ProgOptions.Desription;


                END;


                "ACA-Course Registration".CALCFIELDS("ACA-Course Registration"."Units Taken", "ACA-Course Registration"."Units Passed",
                                                 "ACA-Course Registration"."Units Failed", "ACA-Course Registration"."Cummulative Score",
                                                 "ACA-Course Registration"."Cummulative Units Taken");

                UnitsR.RESET;
                UnitsR.SETRANGE(UnitsR.Show, TRUE);
                UnitsR.SETFILTER(UnitsR."Student No. Filter", "ACA-Course Registration"."Student No.");
                UnitsR.SETFILTER(UnitsR."Stage Filter", GETFILTER("Stage Filter"));
                ////UnitsR.SETFILTER(UnitsR."Reg. ID Filter","Course Registration"."Reg. Transacton ID");
                IF UnitsR.FIND('-') THEN BEGIN
                    REPEAT
                        USkip := FALSE;

                        //Check if option

                        /*
                        IF UnitsR."Programme Option" <> '' THEN BEGIN
                        IF UnitsR."Programme Option" <> "Course Registration".Options THEN
                        USkip := TRUE;
                        END;
                        */
                        //Check if option


                        IF USkip = FALSE THEN BEGIN
                            Grade := '';
                            UnitsR.CALCFIELDS(UnitsR."Total Score", UnitsR."Unit Registered", UnitsR."Re-Sit", UnitsR.Audit);
                            //Grades
                            IF UnitsR."Total Score" > 0 THEN BEGIN
                                Gradings.RESET;
                                Gradings.SETRANGE(Gradings.Category, 'DEFAULT');
                                LastGrade := '';
                                LastRemark := '';
                                LastScore := 0;
                                IF Gradings.FIND('-') THEN BEGIN
                                    ExitDo := FALSE;
                                    REPEAT
                                        IF UnitsR."Total Score" < LastScore THEN BEGIN
                                            IF ExitDo = FALSE THEN BEGIN
                                                Grade := LastGrade;
                                                Remarks := LastRemark;
                                                ExitDo := TRUE;
                                            END;
                                        END;
                                        LastGrade := Gradings.Grade;
                                        LastScore := Gradings."Up to";
                                        IF Gradings.Failed = TRUE THEN
                                            LastRemark := 'Supplementary'
                                        ELSE
                                            LastRemark := Gradings.Remarks;

                                    UNTIL Gradings.NEXT = 0;

                                    IF ExitDo = FALSE THEN BEGIN
                                        Gradings2.RESET;
                                        Gradings2.SETRANGE(Gradings2.Category, 'DEFAULT');
                                        IF Gradings2.FIND('+') THEN BEGIN
                                            Grade := Gradings2.Grade;
                                            Remarks := Gradings2.Remarks;
                                        END;

                                    END;
                                END;

                            END ELSE BEGIN
                                Grade := '';
                                Remarks := 'Not Done';
                            END;


                            //Grades
                            //Course Category
                            IF UnitsR."Unit Type" = UnitsR."Unit Type"::Elective THEN
                                CCat := '-'
                            ELSE
                                CCat := '=';

                            IF UnitsR."Re-Sit" > 0 THEN
                                CCat := '+';

                            IF UnitsR.Audit > 0 THEN
                                CCat := '#';


                            //Check if unit done
                            IF UnitsR."Unit Registered" <= 1 THEN
                                CCat := '--';



                            //Course Category


                            i := i + 1;
                            ColumnH[i] := UnitsR.Code;
                            uColumnV[i] := FORMAT(UnitsR."No. Units");
                            sColumnV[i] := COPYSTR(UnitsR."Stage Code", 3, 2);
                            IF UnitsR."Total Score" = 0 THEN
                                IF CCat = '--' THEN
                                    ColumnV[i] := ''
                                ELSE BEGIN
                                    MissingM := TRUE;
                                    MCourse := TRUE;
                                    ColumnV[i] := '---';
                                    RUnits := RUnits + UnitsR."No. Units";



                                END
                            ELSE BEGIN
                                ColumnV[i] := FORMAT(ROUND(UnitsR."Total Score", 1, '=')) + CCat + Grade;
                                TScore := TScore + UnitsR."Total Score";
                                RUnits := RUnits + UnitsR."No. Units";
                            END;

                            IF DMarks = TRUE THEN
                                i := 0;

                        END;
                    UNTIL UnitsR.NEXT = 0;
                END;

                SCount := SCount + 1;



                IF Cust.GET("ACA-Course Registration"."Student No.") THEN

                    //Generate Summary
                    UTaken := 0;
                UPassed := 0;
                UFailed := 0;
                CAve := 0;

                IF DSummary = FALSE THEN BEGIN

                    //Jump one column

                    i := i + 1;
                    ColumnH[i] := '';
                    ColumnV[i] := '';


                    CReg.RESET;
                    CReg.SETRANGE(CReg."Student No.", "ACA-Course Registration"."Student No.");
                    CReg.SETFILTER(CReg.Stage, GETFILTER("ACA-Course Registration"."Stage Filter"));
                    IF CReg.FIND('-') THEN BEGIN
                        REPEAT
                            CReg.CALCFIELDS(CReg."Units Taken", CReg."Units Passed",
                                                             CReg."Units Failed");

                            UTaken := UTaken + CReg."Units Taken";
                            UPassed := UPassed + CReg."Units Passed";
                            UFailed := UFailed + CReg."Units Failed";

                        UNTIL CReg.NEXT = 0;
                    END;




                    i := i + 1;
                    //calculate yearly average GR
                    ColumnH[i] := 'YEAR AVER';
                    IF UTaken > 0 THEN
                        ColumnV[i] := FORMAT(ROUND(TScore / UTaken, 1, '='));

                    //ColumnV[i]:=FORMAT(ROUND(YearScore/CourseCount,1,'='));
                    //CAve:=ROUND(YearScore/CourseCount,1,'=');



                    IF UTaken > 0 THEN BEGIN
                        //Calc Average (best 14 units)
                        CAve := 0;
                        UnitCount := 0;
                        YearScore := 0;
                        CourseCount := 0;
                        DontCont := FALSE;

                        StudUnits2.RESET;
                        StudUnits2.SETCURRENTKEY(StudUnits2."Student No.", StudUnits2."Final Score");
                        StudUnits2.ASCENDING := FALSE;
                        StudUnits2.SETRANGE(StudUnits2."Student No.", "ACA-Course Registration"."Student No.");
                        StudUnits2.SETRANGE(StudUnits2."Unit Type", StudUnits2."Unit Type"::Core);
                        StudUnits2.SETFILTER(StudUnits2.Stage, "ACA-Course Registration".GETFILTER("ACA-Course Registration"."Cummulative Year Filter"));
                        //StudUnits2.SETRANGE(StudUnits2."Reg. Transacton ID","Course Registration"."Reg. Transacton ID");
                        IF StudUnits2.FIND('-') THEN BEGIN
                            REPEAT
                                IF UnitCount < 14 THEN BEGIN
                                    //MESSAGE('%1',StudUnits2."Final Score");

                                    CourseCount := CourseCount + 1;
                                    UnitCount := UnitCount + 1;//StudUnits2."No. Of Units";
                                    YearScore := YearScore + StudUnits2."Final Score";


                                    //ColumnV[i]:=FORMAT(ROUND(YearScore/CourseCount,1,'='));
                                    CAve := ROUND(YearScore / CourseCount, 1, '=');


                                END ELSE
                                    DontCont := TRUE;
                            UNTIL StudUnits2.NEXT = 0;
                        END;

                        IF DontCont = FALSE THEN BEGIN
                            StudUnits2.RESET;
                            StudUnits2.SETCURRENTKEY(StudUnits2."Student No.", StudUnits2."Final Score");
                            StudUnits2.ASCENDING := FALSE;
                            StudUnits2.SETRANGE(StudUnits2."Student No.", "ACA-Course Registration"."Student No.");
                            StudUnits2.SETRANGE(StudUnits2."Unit Type", StudUnits2."Unit Type"::Elective);
                            StudUnits2.SETFILTER(StudUnits2.Stage, "ACA-Course Registration".GETFILTER("ACA-Course Registration"."Cummulative Year Filter"));
                            //StudUnits2.SETRANGE(StudUnits2."Reg. Transacton ID","Course Registration"."Reg. Transacton ID");
                            IF StudUnits2.FIND('-') THEN BEGIN
                                REPEAT
                                    IF UnitCount < 14 THEN BEGIN
                                        //MESSAGE('%1',StudUnits2."Final Score");
                                        CourseCount := CourseCount + 1;
                                        UnitCount := UnitCount + 1;//StudUnits2."No. Of Units";
                                        YearScore := YearScore + StudUnits2."Final Score";

                                        //ColumnV[i]:=FORMAT(ROUND(YearScore/CourseCount,1,'='));
                                        CAve := ROUND(YearScore / CourseCount, 1, '=');

                                    END ELSE
                                        DontCont := TRUE;
                                UNTIL StudUnits2.NEXT = 0;
                            END;
                        END;


                        //Calc Average (best 14 units)


                    END;


                    i := i + 1;
                    ColumnH[i] := '%Unt Passed';
                    IF UTaken > 0 THEN
                        ColumnV[i] := FORMAT(ROUND(UPassed / UTaken * 100, 1, '='));


                    i := i + 1;
                    ColumnH[i] := 'Reg Units';
                    ColumnV[i] := FORMAT(RUnits);

                    i := i + 1;
                    ColumnH[i] := 'Papers Failed';
                    ColumnV[i] := FORMAT(UFailed);

                    i := i + 1;
                    ColumnH[i] := 'Cumm Aver';
                    IF "ACA-Course Registration"."Cummulative Units Taken" > 0 THEN
                        ColumnV[i] := FORMAT(ROUND(CAve, 1, '='));
                    //ColumnV[i]:=FORMAT(ROUND("Course Registration"."Cummulative Score"/"Course Registration"."Cummulative Units Taken",1,'='));
                    //ColumnV[i]:=FORMAT(ROUND("Course Registration"."Cummulative Score"/UTaken,1,'='));

                    i := i + 1;
                    ColumnH[i] := 'Srg Rmk';
                    IF UFailed = 0 THEN BEGIN
                        ColumnV[i] := 'P';
                    END;

                    IF UFailed > 0 THEN BEGIN
                        ColumnV[i] := 'Q';
                    END;

                    IF MCourse = TRUE THEN
                        ColumnV[i] := 'U';


                    IF Prog.GET("ACA-Course Registration".Programmes) THEN BEGIN
                        IF "ACA-Course Registration"."Units Taken" < Prog."Min No. of Courses" THEN
                            ColumnV[i] := '?';
                    END;

                    IF Cust.Status = Cust.Status::Discontinued THEN
                        ColumnV[i] := 'Z';

                    IF (UTaken < 1) OR ((UPassed < 14) AND (ColumnV[i] = 'P')) THEN   //BKK
                        ColumnV[i] := '?';


                    i := i + 1;
                    ColumnH[i] := 'Brd Rmk';
                    ColumnV[i] := '';




                END;
                //Generate Summary

            end;

            trigger OnPreDataItem()
            begin
                SCount := 0;
                Session := CReg.Session;
                "ACA-Course Registration".SETFILTER(Programmes, GETFILTER("Programme Filter"));
                //PKK "Course Registration".SETFILTER(Stage,GETFILTER("Stage Filter"));
                "ACA-Course Registration".SETFILTER(Options, GETFILTER("Options Filter"));

                UnitsR.RESET;
                UnitsR.MODIFYALL(UnitsR.Show, FALSE);

                CReg.RESET;
                CReg.SETFILTER(CReg.Programmes, GETFILTER("Programme Filter"));
                CReg.SETFILTER(CReg.Stage, GETFILTER("Stage Filter"));
                IF CReg.FIND('-') THEN BEGIN
                    REPEAT
                        StudUnits.RESET;
                        StudUnits.SETCURRENTKEY(StudUnits."Reg. Transacton ID", StudUnits."Student No.");
                        StudUnits.SETFILTER(StudUnits."Reg. Transacton ID", CReg."Reg. Transacton ID");
                        StudUnits.SETFILTER(StudUnits."Student No.", CReg."Student No.");
                        StudUnits.SETFILTER(StudUnits.Stage, GETFILTER("Stage Filter"));/*BKK*/
                        StudUnits.SETRANGE(StudUnits.Taken, TRUE);
                        IF StudUnits.FIND('-') THEN BEGIN
                            REPEAT
                                UnitsR.RESET;
                                UnitsR.SETCURRENTKEY(UnitsR."Programme Code", UnitsR."Stage Code", UnitsR.Code);
                                UnitsR.SETRANGE(UnitsR."Programme Code", StudUnits.Programme);
                                UnitsR.SETRANGE(UnitsR."Stage Code", StudUnits.Stage);
                                UnitsR.SETRANGE(UnitsR.Code, StudUnits.Unit);
                                IF UnitsR.FIND('-') THEN BEGIN
                                    IF UnitsR.Show = FALSE THEN BEGIN
                                        UnitsR.Show := TRUE;
                                        UnitsR.MODIFY;
                                    END;
                                END;
                            UNTIL StudUnits.NEXT = 0;
                        END;
                    UNTIL CReg.NEXT = 0;
                END;



                FDesc := '';
                Dept := '';
                SDesc := '';
                Comb := '';

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

    var
        Cust: Record 18;
        Charges: Record 61515;
        ColumnH: array[80] of Text[100];
        ColumnV: array[80] of Text[30];
        i: Integer;
        TColumnV: array[80] of Decimal;
        SCount: Integer;
        UnitsR: Record 61517;
        uColumnV: array[80] of Text[30];
        sColumnV: array[80] of Text[30];
        Prog: Record 61511;
        Stages: Record 61516;
        RFound: Boolean;
        UDesc: Text[200];
        Units: Record 61517;
        Result: Decimal;
        Grade: Text[150];
        Remarks: Text[150];
        Gradings: Record 61569;
        Gradings2: Record 61569;
        TotalScore: Decimal;
        LastGrade: Code[20];
        LastScore: Decimal;
        ExitDo: Boolean;
        Desc: Text[200];
        OScore: Decimal;
        OUnits: Integer;
        MeanScore: Decimal;
        MeanGrade: Code[20];
        LastRemark: Text[200];
        CCat: Text[30];
        TScore: Decimal;
        RUnits: Decimal;
        SkipCount: Integer;
        MissingM: Boolean;
        DValue: Record 349;
        FacultyR: Record 61587;
        FDesc: Text[200];
        Dept: Text[200];
        PName: Text[200];
        SDesc: Text[200];
        Comb: Text[200];
        ProgOptions: Record 61554;
        DMarks: Boolean;
        DSummary: Boolean;
        USkip: Boolean;
        CReg: Record 61532;
        UTaken: Integer;
        UPassed: Integer;
        UFailed: Integer;
        MCourse: Boolean;
        StudUnits: Record 61549;
        StudUnits2: Record 61549;
        UnitCount: Integer;
        YearScore: Decimal;
        CourseCount: Decimal;
        DontCont: Boolean;
        CAve: Decimal;
        Intake: Record 61532;
        CAverage: Decimal;
        Consolidated_MarksheetCaptionLbl: Label 'Consolidated Marksheet';
        Year_of_Study_CaptionLbl: Label 'Year of Study:';
        Faculty_CaptionLbl: Label 'Faculty:';
        Department_CaptionLbl: Label 'Department:';
        Programme_of_Study_CaptionLbl: Label 'Programme of Study:';
        Combination_CaptionLbl: Label 'Combination:';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Intake_CaptionLbl: Label 'Intake:';
        Registration_No_CaptionLbl: Label 'Registration No.';
        NamesCaptionLbl: Label 'Names';
        UNITS__CaptionLbl: Label 'UNITS=>';
        Serial_No_CaptionLbl: Label 'Serial No.';
        Guide_on_remarks_CaptionLbl: Label 'Guide on remarks:';
        pYear: Label 'P - Proceed to next year / Graduate;           Q - Take resit exam in papers failed;           R - Repeat the year;';
        smks: Label 'S - Special Exam;           T - Retake failed courses;           U - Missing Marks;           ? - Less courses;           Z - Discontinued';
        mismark: Label 'Course Categories: --- missing marks;           = Core/Required;           - Elective;           + Retake;           # Audit';
}

