report 51511 "Exam Card Label-Plain"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Exam Card Label-Plain.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "Programme Filter", "Stage Filter", "Semester Filter", "Intake Filter", "Exam Period Filter", Status, "No.", "Balance (LCY)";
            column(Customer_No_; "No.")
            {
            }
            column(Customer_Programme_Filter; "Programme Filter")
            {
            }
            column(Customer_Stage_Filter; "Stage Filter")
            {
            }
            column(Customer_Semester_Filter; "Semester Filter")
            {
            }
            dataitem("ACA-Course Registration"; "ACA-Course Registration")
            {
                DataItemLink = "Student No." = FIELD("No."),
                               Programmes = FIELD("Programme Filter"),
                               Stage = FIELD("Stage Filter"),
                               Semester = FIELD("Semester Filter");
                DataItemTableView = SORTING("Student No.")
                                    WHERE(Reversed = CONST(false),
                                          "Units Taken" = FILTER(<> 0));
                MaxIteration = 1;
                column(Addr_1__1_; Addr[1] [1])
                {
                }
                column(Addr_1__2_; Addr[1] [2])
                {
                }
                column(Addr_1__3_; Addr[1] [3])
                {
                }
                column(Addr_1__4_; Addr[1] [4])
                {
                }
                column(Addr_1__5_; Addr[1] [5])
                {
                }
                column(Addr_1__6_; Addr[1] [6])
                {
                }
                column(Addr_1__7_; Addr[1] [7])
                {
                }
                column(Addr_2__1_; Addr[2] [1])
                {
                }
                column(Addr_2__2_; Addr[2] [2])
                {
                }
                column(Addr_2__3_; Addr[2] [3])
                {
                }
                column(Addr_2__4_; Addr[2] [4])
                {
                }
                column(Addr_2__5_; Addr[2] [5])
                {
                }
                column(Addr_2__6_; Addr[2] [6])
                {
                }
                column(Addr_2__7_; Addr[2] [7])
                {
                }
                column(StudUnits_1__1_; StudUnits[1] [1])
                {
                }
                column(StudUnits_1__2_; StudUnits[1] [2])
                {
                }
                column(StudUnits_1__3_; StudUnits[1] [3])
                {
                }
                column(StudUnits_1__5_; StudUnits[1] [5])
                {
                }
                column(StudUnits_1__7_; StudUnits[1] [7])
                {
                }
                column(StudUnits_1__4_; StudUnits[1] [4])
                {
                }
                column(StudUnits_1__6_; StudUnits[1] [6])
                {
                }
                column(StudUnits_1__8_; StudUnits[1] [8])
                {
                }
                column(StudUnits_1__10_; StudUnits[1] [10])
                {
                }
                column(StudUnits_1__9_; StudUnits[1] [9])
                {
                }
                column(StudUnits_2__10_; StudUnits[2] [10])
                {
                }
                column(StudUnits_2__9_; StudUnits[2] [9])
                {
                }
                column(StudUnits_2__8_; StudUnits[2] [8])
                {
                }
                column(StudUnits_2__7_; StudUnits[2] [7])
                {
                }
                column(StudUnits_2__6_; StudUnits[2] [6])
                {
                }
                column(StudUnits_2__5_; StudUnits[2] [5])
                {
                }
                column(StudUnits_2__4_; StudUnits[2] [4])
                {
                }
                column(StudUnits_2__3_; StudUnits[2] [3])
                {
                }
                column(StudUnits_2__2_; StudUnits[2] [2])
                {
                }
                column(StudUnits_2__1_; StudUnits[2] [1])
                {
                }
                column(StudUnits_3__10_; StudUnits[3] [10])
                {
                }
                column(StudUnits_4__10_; StudUnits[4] [10])
                {
                }
                column(StudUnits_3__9_; StudUnits[3] [9])
                {
                }
                column(StudUnits_4__9_; StudUnits[4] [9])
                {
                }
                column(StudUnits_3__8_; StudUnits[3] [8])
                {
                }
                column(StudUnits_4__8_; StudUnits[4] [8])
                {
                }
                column(StudUnits_3__7_; StudUnits[3] [7])
                {
                }
                column(StudUnits_4__7_; StudUnits[4] [7])
                {
                }
                column(StudUnits_3__6_; StudUnits[3] [6])
                {
                }
                column(StudUnits_4__6_; StudUnits[4] [6])
                {
                }
                column(StudUnits_3__5_; StudUnits[3] [5])
                {
                }
                column(StudUnits_4__5_; StudUnits[4] [5])
                {
                }
                column(StudUnits_3__4_; StudUnits[3] [4])
                {
                }
                column(StudUnits_4__4_; StudUnits[4] [4])
                {
                }
                column(StudUnits_3__3_; StudUnits[3] [3])
                {
                }
                column(StudUnits_4__3_; StudUnits[4] [3])
                {
                }
                column(StudUnits_3__2_; StudUnits[3] [2])
                {
                }
                column(StudUnits_4__2_; StudUnits[4] [2])
                {
                }
                column(StudUnits_3__1_; StudUnits[3] [1])
                {
                }
                column(StudUnits_4__1_; StudUnits[4] [1])
                {
                }
                column(Addr_3__7_; Addr[3] [7])
                {
                }
                column(Addr_4__7_; Addr[4] [7])
                {
                }
                column(Addr_3__6_; Addr[3] [6])
                {
                }
                column(Addr_4__6_; Addr[4] [6])
                {
                }
                column(Addr_3__5_; Addr[3] [5])
                {
                }
                column(Addr_4__5_; Addr[4] [5])
                {
                }
                column(Addr_3__4_; Addr[3] [4])
                {
                }
                column(Addr_4__4_; Addr[4] [4])
                {
                }
                column(Addr_3__3_; Addr[3] [3])
                {
                }
                column(Addr_4__3_; Addr[4] [3])
                {
                }
                column(Addr_3__2_; Addr[3] [2])
                {
                }
                column(Addr_4__2_; Addr[4] [2])
                {
                }
                column(Addr_3__1_; Addr[3] [1])
                {
                }
                column(Addr_4__1_; Addr[4] [1])
                {
                }
                column(Exam_PeriodCaption; Exam_PeriodCaptionLbl)
                {
                }
                column(Student_TypeCaption; Student_TypeCaptionLbl)
                {
                }
                column(LevelCaption; LevelCaptionLbl)
                {
                }
                column(ProgrammeCaption; ProgrammeCaptionLbl)
                {
                }
                column(Admission_No_Caption; Admission_No_CaptionLbl)
                {
                }
                column(Student_No_Caption; Student_No_CaptionLbl)
                {
                }
                column(NamesCaption; NamesCaptionLbl)
                {
                }
                column(Units_Taken_Caption; Units_Taken_CaptionLbl)
                {
                }
                column(Units_Taken_Caption_Control1102756023; Units_Taken_Caption_Control1102756023Lbl)
                {
                }
                column(NamesCaption_Control1102756024; NamesCaption_Control1102756024Lbl)
                {
                }
                column(Student_No_Caption_Control1102756025; Student_No_Caption_Control1102756025Lbl)
                {
                }
                column(Admission_No_Caption_Control1102756026; Admission_No_Caption_Control1102756026Lbl)
                {
                }
                column(ProgrammeCaption_Control1102756027; ProgrammeCaption_Control1102756027Lbl)
                {
                }
                column(LevelCaption_Control1102756028; LevelCaption_Control1102756028Lbl)
                {
                }
                column(Student_TypeCaption_Control1102756029; Student_TypeCaption_Control1102756029Lbl)
                {
                }
                column(Exam_PeriodCaption_Control1102756030; Exam_PeriodCaption_Control1102756030Lbl)
                {
                }
                column(SignatureCaption; SignatureCaptionLbl)
                {
                }
                column(SignatureCaption_Control1102756044; SignatureCaption_Control1102756044Lbl)
                {
                }
                column(SignatureCaption_Control1102756109; SignatureCaption_Control1102756109Lbl)
                {
                }
                column(SignatureCaption_Control1102756111; SignatureCaption_Control1102756111Lbl)
                {
                }
                column(Units_Taken_Caption_Control1102756153; Units_Taken_Caption_Control1102756153Lbl)
                {
                }
                column(Units_Taken_Caption_Control1102756154; Units_Taken_Caption_Control1102756154Lbl)
                {
                }
                column(Exam_PeriodCaption_Control1102756159; Exam_PeriodCaption_Control1102756159Lbl)
                {
                }
                column(Student_TypeCaption_Control1102756165; Student_TypeCaption_Control1102756165Lbl)
                {
                }
                column(LevelCaption_Control1102756171; LevelCaption_Control1102756171Lbl)
                {
                }
                column(ProgrammeCaption_Control1102756180; ProgrammeCaption_Control1102756180Lbl)
                {
                }
                column(Admission_No_Caption_Control1102756183; Admission_No_Caption_Control1102756183Lbl)
                {
                }
                column(Student_No_Caption_Control1102756189; Student_No_Caption_Control1102756189Lbl)
                {
                }
                column(NamesCaption_Control1102756195; NamesCaption_Control1102756195Lbl)
                {
                }
                column(Exam_PeriodCaption_Control1102756199; Exam_PeriodCaption_Control1102756199Lbl)
                {
                }
                column(Student_TypeCaption_Control1102756200; Student_TypeCaption_Control1102756200Lbl)
                {
                }
                column(LevelCaption_Control1102756201; LevelCaption_Control1102756201Lbl)
                {
                }
                column(ProgrammeCaption_Control1102756202; ProgrammeCaption_Control1102756202Lbl)
                {
                }
                column(Admission_No_Caption_Control1102756203; Admission_No_Caption_Control1102756203Lbl)
                {
                }
                column(Student_No_Caption_Control1102756204; Student_No_Caption_Control1102756204Lbl)
                {
                }
                column(NamesCaption_Control1102756205; NamesCaption_Control1102756205Lbl)
                {
                }
                column(Course_Registration_Reg__Transacton_ID; "Reg. Transacton ID")
                {
                }
                column(Course_Registration_Student_No_; "Student No.")
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
                    RecordNo := RecordNo + 1;
                    ColumnNo := ColumnNo + 1;

                    progrec.RESET;
                    Programmedesc := '';
                    progrec.SETRANGE(progrec.Code, "ACA-Course Registration".Programmes);
                    IF progrec.FIND('-') THEN BEGIN
                        Programmedesc := progrec.Description;
                    END;


                    //"Course Registration".CALCFIELDS("Course Registration".Faculty);

                    dimrec.RESET;
                    DimDesc := '';
                    //dimrec.SETRANGE(dimrec.Code,"Course Registration".Faculty);
                    IF dimrec.FIND('-') THEN BEGIN
                        DimDesc := dimrec.Name;
                    END;

                    //....

                    IF Students.GET("ACA-Course Registration"."Student No.") THEN
                        "ACA-Course Registration".CALCFIELDS("ACA-Course Registration"."Units Taken");
                    IF "ACA-Course Registration"."Units Taken" > 0 THEN BEGIN
                        Addr[ColumnNo] [1] := FORMAT(Students.Name);
                        Addr[ColumnNo] [2] := FORMAT("ACA-Course Registration"."Student No.");
                        Addr[ColumnNo] [3] := FORMAT("ACA-Course Registration"."Admission No.");
                        IF Programme.GET("ACA-Course Registration".Programmes) THEN
                            Addr[ColumnNo] [4] := FORMAT(Programme.Description);
                        IF Stages.GET("ACA-Course Registration".Programmes, "ACA-Course Registration".Stage) THEN
                            Addr[ColumnNo] [5] := FORMAT(Stages.Description);
                        Addr[ColumnNo] [6] := FORMAT("ACA-Course Registration"."Student Type");
                        Addr[ColumnNo] [7] := FORMAT(Customer.GETFILTER(Customer."Exam Period Filter"));

#pragma warning disable AL0133
                        //COMPRESSARRAY(Addr[ColumnNo] [7]);
#pragma warning restore AL0133
                        //CLEAR(StudUnits[ColumnNo][ColumnNo]);

                        FOR i := 1 TO 10 DO BEGIN
                            CLEAR(StudUnits[ColumnNo] [i]);
                        END;


                        x := 0;
                        StudentUnits.RESET;
                        StudentUnits.SETRANGE(StudentUnits.Taken, TRUE);
                        StudentUnits.SETRANGE(StudentUnits.Programme, "ACA-Course Registration".Programmes);
                        StudentUnits.SETRANGE(StudentUnits.Stage, "ACA-Course Registration".Stage);
                        StudentUnits.SETRANGE(StudentUnits.Semester, "ACA-Course Registration".Semester);
                        StudentUnits.SETRANGE(StudentUnits."Student No.", "ACA-Course Registration"."Student No.");
                        //StudentUnits.SETRANGE(StudentUnits."Reg. Transacton ID","Course Registration"."Reg. Transacton ID");
                        IF StudentUnits.FIND('-') THEN
                            REPEAT
                                x := x + 1;
                                Units.RESET;
                                Units.SETRANGE(Units."Programme Code", StudentUnits.Programme);
                                Units.SETRANGE(Units."Stage Code", StudentUnits.Stage);
                                Units.SETRANGE(Units.Code, StudentUnits.Unit);
                                IF Units.FIND('-') THEN
                                    StudUnits[ColumnNo] [x] := FORMAT(StudentUnits.Unit) + ' - ' + FORMAT(Units.Desription);
                            UNTIL StudentUnits.NEXT = 0;
                    END;
                    //....

                    //COMPRESSARRAY(StudUnits[ColumnNo] [ColumnNo]);


                    IF RecordNo = NoOfRecords THEN BEGIN

                        FOR i := ColumnNo + 1 TO NoOfColumns DO
                            CLEAR(Addr[i] [i]);

                        ColumnNo := 0;
                    END ELSE BEGIN
                        IF ColumnNo = NoOfColumns THEN
                            ColumnNo := 0;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    NoOfRecords := COUNT;
                    NoOfColumns := 4;

                    "ACA-Course Registration".SETFILTER("ACA-Course Registration".Programmes, Customer.GETFILTER(Customer."Programme Filter"));
                    "ACA-Course Registration".SETFILTER("ACA-Course Registration".Semester, Customer.GETFILTER(Customer."Semester Filter"));
                    "ACA-Course Registration".SETFILTER("ACA-Course Registration".Stage, Customer.GETFILTER(Customer."Stage Filter"));
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Customer.CALCFIELDS(Customer."Student Programme");
                //Customer."Programme Filter"
            end;

            trigger OnPostDataItem()
            begin
                /*
                FOR i :=1 + 1 TO 100 DO BEGIN
                    CLEAR(StudUnits[i][i]);
                END;
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

    var
        //Addr: array[50000, 20] of Text[250];
        Addr: array[50000, 20] of Text[250];
        NoOfRecords: Integer;
        RecordNo: Integer;
        NoOfColumns: Integer;
        ColumnNo: Integer;
        i: Integer;
        Sname: Text[150];

        dimrec: Record 349;
        DimDesc: Text[150];
        Programmedesc: Text[150];
        progrec: Record 61511;
        Students: Record 18;
        Stages: Record 61516;
        StudUnits: array[100, 100] of Text[250];
        StudentUnits: Record 61549;
        x: Integer;
        Units: Record 61517;
        y: Integer;
        EPeriod: Text[150];
        UnitArr: Integer;
        Exam_PeriodCaptionLbl: Label 'Exam Period';
        Student_TypeCaptionLbl: Label 'Student Type';
        LevelCaptionLbl: Label 'Level';
        ProgrammeCaptionLbl: Label 'Programme';
        Admission_No_CaptionLbl: Label 'Admission No.';
        Student_No_CaptionLbl: Label 'Student No.';
        NamesCaptionLbl: Label 'Names';
        Units_Taken_CaptionLbl: Label 'Units Taken:';
        Units_Taken_Caption_Control1102756023Lbl: Label 'Units Taken:';
        NamesCaption_Control1102756024Lbl: Label 'Names';
        Student_No_Caption_Control1102756025Lbl: Label 'Student No.';
        Admission_No_Caption_Control1102756026Lbl: Label 'Admission No.';
        ProgrammeCaption_Control1102756027Lbl: Label 'Programme';
        LevelCaption_Control1102756028Lbl: Label 'Level';
        Student_TypeCaption_Control1102756029Lbl: Label 'Student Type';
        Exam_PeriodCaption_Control1102756030Lbl: Label 'Exam Period';
        SignatureCaptionLbl: Label 'Signature';
        SignatureCaption_Control1102756044Lbl: Label 'Signature';
        SignatureCaption_Control1102756109Lbl: Label 'Signature';
        SignatureCaption_Control1102756111Lbl: Label 'Signature';
        Units_Taken_Caption_Control1102756153Lbl: Label 'Units Taken:';
        Units_Taken_Caption_Control1102756154Lbl: Label 'Units Taken:';
        Exam_PeriodCaption_Control1102756159Lbl: Label 'Exam Period';
        Student_TypeCaption_Control1102756165Lbl: Label 'Student Type';
        LevelCaption_Control1102756171Lbl: Label 'Level';
        ProgrammeCaption_Control1102756180Lbl: Label 'Programme';
        Admission_No_Caption_Control1102756183Lbl: Label 'Admission No.';
        Student_No_Caption_Control1102756189Lbl: Label 'Student No.';
        NamesCaption_Control1102756195Lbl: Label 'Names';
        Exam_PeriodCaption_Control1102756199Lbl: Label 'Exam Period';
        Student_TypeCaption_Control1102756200Lbl: Label 'Student Type';
        LevelCaption_Control1102756201Lbl: Label 'Level';
        ProgrammeCaption_Control1102756202Lbl: Label 'Programme';
        Admission_No_Caption_Control1102756203Lbl: Label 'Admission No.';
        Student_No_Caption_Control1102756204Lbl: Label 'Student No.';
        NamesCaption_Control1102756205Lbl: Label 'Names';
        Programme: Record "ACA-Programme";
}

