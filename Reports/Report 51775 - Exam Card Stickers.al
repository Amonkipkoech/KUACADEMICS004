/// <summary>
/// Report Exam Card Stickers (ID 51775).
/// </summary>
report 51775 "Exam Card Stickers"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Exam Card Stickers.rdl';

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {
            RequestFilterFields = "Student No.", Programmes, Stage, Semester;
            column(StudNo; "ACA-Course Registration"."Student No.")
            {
            }
            column(Prog; "ACA-Course Registration".Programmes)
            {
            }
            column(Sem; "ACA-Course Registration".Semester)
            {
            }
            column(Stag; "ACA-Course Registration".Stage)
            {
            }
            column(CumSc; "ACA-Course Registration"."Cumm Score")
            {
            }
            column(CurrSem; "ACA-Course Registration"."Current Cumm Score")
            {
            }
            column(sName; sName)
            {
            }
            column(pName; pName)
            {
            }
            column(Addr_1_1_; Addr[1] [1])
            {
            }
            column(Addr_1_2_; Addr[1] [2])
            {
            }
            column(Addr_1_3_; Addr[1] [3])
            {
            }
            column(Addr_2_1_; Addr[2] [1])
            {
            }
            column(Addr_2_2_; Addr[2] [2])
            {
            }
            column(Addr_2_3_; Addr[2] [3])
            {
            }
            column(Addr_3_1_; Addr[3] [1])
            {
            }
            column(Addr_3_2_; Addr[3] [2])
            {
            }
            column(Addr_3_3_; Addr[3] [3])
            {
            }
            column(YearOfStudy; YearOfStudy)
            {
            }
            column(YearOfAdmi; YearOfAdmi)
            {
            }
            column(SchoolName; SchoolName)
            {
            }
            column(acadyear; acadyear)
            {
            }
            column(Sems; Sems)
            {
            }
            column(From100Legend; 'A (70% - 100%)        - Excellent         B (60% - 69%)      - Good       C (50% - 59%)     -Satisfactory ')
            {
            }
            column(From40Legend; 'D (40% - 49%)                - Fair                 E (39% and Below)   - Fail')
            {
            }
            column(PassMarkLegend; 'NOTE:   Pass mark is 40%')
            {
            }
            column(DoubleLine; '===============================================================================')
            {
            }
            column(Recomm; 'Recommendation:')
            {
            }
            column(singleLine; '===============================================================================')
            {
            }
            column(signedSignature; 'Signed......................................................')
            {
            }
            column(codDept; '(COD, ' + SchoolName + ')')
            {
            }
            column(dateSigned; 'Date:.......................................................')
            {
            }
            column(RegAcadLabel; 'Registrar, Academic Affairs')
            {
            }
            column(Pictures; controlInfo.Picture)
            {
            }
            column(ColumnNo; ColumnNo)
            {
            }
            column(visible1; visible1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                // ExamProcess.UpdateCourseReg("Course Registration"."Student No.","Course Registration".Programme,"Course Registration".Stage,"Course Registration".Semester);
                visible1 := FALSE;
                IF "ACA-Course Registration"."Academic Year" <> acadyear THEN
                    CurrReport.SKIP;
                IF "ACA-Course Registration".Semester <> Sems THEN
                    CurrReport.SKIP;
                CLEAR(SchoolName);
                IF prog.GET("ACA-Course Registration".Programmes) THEN BEGIN
                    pName := prog.Description;
                    dimVal.RESET;
                    dimVal.SETRANGE(dimVal."Dimension Code", 'SCHOOL');
                    dimVal.SETRANGE(dimVal.Code, prog."School Code");
                    IF dimVal.FIND('-') THEN BEGIN
                        SchoolName := dimVal.Name;
                    END;
                END;

                CLEAR(YearOfStudy);
                ProgrammeStages.RESET;
                ProgrammeStages.SETRANGE(ProgrammeStages."Programme Code", "ACA-Course Registration".Programmes);
                ProgrammeStages.SETRANGE(ProgrammeStages.Code, "ACA-Course Registration".Stage);
                IF ProgrammeStages.FIND('-') THEN
                    YearOfStudy := ProgrammeStages.Description;


                CLEAR(sName);
                CLEAR(YearOfAdmi);
                cust.RESET;
                cust.SETRANGE(cust."No.", "ACA-Course Registration"."Student No.");
                IF cust.FIND('-') THEN BEGIN
                    sName := cust.Name;
                    YearOfAdmi := cust."Class Code";
                END;


                RecordNo := RecordNo + 1;
                ColumnNo := ColumnNo + 1;

                Addr[ColumnNo] [1] := FORMAT("ACA-Course Registration"."Student No.");
                IF Customer.GET("ACA-Course Registration"."Student No.") THEN Addr[ColumnNo] [2] := FORMAT(Customer.Name);
                Addr[ColumnNo] [3] := FORMAT(pName);
                Addr[ColumnNo] [4] := FORMAT("ACA-Course Registration".Stage);


                /*Addr[ColumnNo][2] := FORMAT(Name);
                Addr[ColumnNo][3] := FORMAT(Customer."Meal Card Valid From");
                Addr[ColumnNo][4] := FORMAT(Customer."Meal Card Valid To");*/



                COMPRESSARRAY(Addr[ColumnNo]);

                IF RecordNo = NoOfRecords THEN BEGIN
                    FOR i := ColumnNo + 1 TO NoOfColumns DO
                        CLEAR(Addr[i]);
                    ColumnNo := 0;
                END ELSE BEGIN
                    IF ColumnNo = NoOfColumns THEN
                        ColumnNo := 0;
                END;

                IF ((ColumnNo = 1) OR (ColumnNo = 2)) THEN CurrReport.SKIP

            end;

            trigger OnPostDataItem()
            begin
                // ExamProcess.UpdateCourseReg("Course Registration"."Student No.","Course Registration".Programme,"Course Registration".Stage,"Course Registration".Semester);
            end;

            trigger OnPreDataItem()
            begin
                NoOfRecords := COUNT;
                NoOfColumns := 3;
                visible1 := FALSE;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(acadYears; acadyear)
                {
                    Caption = 'Academic Year';
                    TableRelation = "ACA-Academic Year".Code;
                    ApplicationArea = All;
                }
                field(semsz; Sems)
                {
                    Caption = 'Semester';
                    TableRelation = "ACA-Semesters".Code;
                    ApplicationArea = All;
                }
            }
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
        IF acadyear = '' THEN ERROR('Please specify the academic year.');
        IF Sems = '' THEN ERROR('Please specify the Semester.');

        controlInfo.RESET;
        IF controlInfo.FIND('-') THEN
            controlInfo.CALCFIELDS(Picture);
    end;

    var
        ProgrammeStages: Record 61516;
        pName: Text[250];

        YearOfStudy: Code[50];
        YearOfAdmi: Code[50];
        SchoolName: Text[250];
        ExamProcess: Codeunit 60276;


        TotalCatMarks: Decimal;
        TotalCatContributions: Decimal;
        TotalMainExamContributions: Decimal;
        TotalExamMark: Decimal;
        FinalExamMark: Decimal;
        FinalCATMarks: Decimal;
        Gradez: Code[10];
        TotalMarks: Decimal;

        LastGrade: Code[20];
        LastScore: Decimal;
        ExitDo: Boolean;

        Gradeaqq2: Code[10];
        TotMarks: Decimal;
        sName: Code[250];
        cust: Record 18;
        acadyear: Code[20];
        Sems: Code[20];
        prog: Record 61511;
        dimVal: Record 349;
        Addr: array[3, 4] of Text[250];
        NoOfRecords: Integer;
        RecordNo: Integer;
        NoOfColumns: Integer;
        ColumnNo: Integer;
        i: Integer;
        controlInfo: Record 79;
        Customer: Record 18;
        visible1: Boolean;
}

