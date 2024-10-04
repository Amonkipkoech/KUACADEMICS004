report 51779 "Population By Prog. Category"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Population By Prog. Category.rdl';

    dataset
    {
        dataitem("Dimension Value"; "Dimension Value")
        {
            DataItemTableView = WHERE("Dimension Code" = FILTER(''));
            column(Title2; 'University Population Analysis by Programme Category')
            {
            }
            column(Title1; 'STUDENT POPULATION PER CAMPUS & CATEGORY AS AT ' + FORMAT(TODAY, 0, 4) + ', ' + Semes)
            {
            }
            column(pic; info.Picture)
            {
            }
            column(SchoolName; Name)
            {
            }
            dataitem("ACA-Programme"; "ACA-Programme")
            {
                DataItemLink = "Department Code" = FIELD(Code);
                column(ProgCode; Code + ': ' + Description)
                {
                }
                column(Bridging; Bridging1)
                {
                }
                column(Certificate; Certificate1)
                {
                }
                column(Diploma; Diploma1)
                {
                }
                column(Degree; Degree1)
                {
                }
                column(MASTERS; MASTERS1)
                {
                }
                column(CourseTotals; CourseTotals1)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    CLEAR(Bridging1);
                    CLEAR(Certificate1);
                    CLEAR(Diploma1);
                    CLEAR(Degree1);
                    CLEAR(MASTERS);
                    CLEAR(MASTERS1);
                    CLEAR(CourseTotals1);

                    CLEAR(Bridging);
                    CLEAR(Certificate);
                    CLEAR(Diploma);
                    CLEAR(Degree);
                    CLEAR(CourseTotals);



                    student.RESET;
                    //student.SETRANGE(student."Customer Type",student."Customer Type"::Student);
                    student.SETRANGE(student.Programmes, "ACA-Programme".Code);
                    student.SETRANGE(student.Semester, FORMAT(Semes));
                    //student.SETRANGE(student."Academic Year",FORMAT(acadyear));
                    IF "Student Category" = "Student Category"::Continuing THEN
                        student.SETFILTER(student.Stage, '<>%1', 'Y1S1');
                    IF "Student Category" = "Student Category"::New THEN
                        student.SETFILTER(student.Stage, '=%1', 'Y1S1');

                    IF student.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            IF "ACA-Programme"."Exam Category" = 'PROFFESSIONAL' THEN BEGIN
                                Bridging1 := Bridging1 + 1;
                                schBridgTotal1 := schBridgTotal1 + 1;
                                BridgGrandTotal1 := BridgGrandTotal1 + 1;
                                GrandTotals1 := GrandTotals1 + 1;
                                schTotals1 := schTotals1 + 1;
                                CourseTotals1 := CourseTotals1 + 1;
                            END;
                            IF "ACA-Programme"."Exam Category" = 'CERTIFICATE' THEN BEGIN
                                Certificate1 := Certificate1 + 1;
                                schCertTotal1 := schCertTotal1 + 1;
                                CertGrandTotal1 := CertGrandTotal1 + 1;
                                GrandTotals1 := GrandTotals1 + 1;
                                schTotals1 := schTotals1 + 1;
                                CourseTotals1 := CourseTotals1 + 1;
                            END;
                            IF "ACA-Programme"."Exam Category" = 'UNDERGRADUATE' THEN BEGIN
                                Degree1 := Degree1 + 1;
                                schDegTotal1 := schDegTotal1 + 1;
                                DegGrandTotal1 := DegGrandTotal1 + 1;
                                GrandTotals1 := GrandTotals1 + 1;
                                schTotals1 := schTotals1 + 1;
                                CourseTotals1 := CourseTotals1 + 1;
                            END;
                            IF "ACA-Programme"."Exam Category" = 'DIPLOMA' THEN BEGIN
                                Diploma1 := Diploma1 + 1;
                                schDipTotal1 := schDipTotal1 + 1;
                                DipGrandTotal1 := DipGrandTotal1 + 1;
                                GrandTotals1 := GrandTotals1 + 1;
                                schTotals1 := schTotals1 + 1;
                                CourseTotals1 := CourseTotals1 + 1;
                            END;
                            IF "ACA-Programme"."Exam Category" = 'MASTERS' THEN BEGIN
                                MASTERS1 := MASTERS1 + 1;
                                schMASTERSTotal1 := schMASTERSTotal1 + 1;
                                MASTERSGrandTotal1 := MASTERSGrandTotal1 + 1;
                                GrandTotals1 := GrandTotals1 + 1;
                                schTotals1 := schTotals1 + 1;
                                CourseTotals1 := CourseTotals1 + 1;
                            END;

                        END;
                        UNTIL student.NEXT = 0;
                    END;

                    IF schBridgTotal1 <> 0 THEN schBridgTotal := FORMAT(schBridgTotal1);
                    IF schCertTotal1 <> 0 THEN schCertTotal := FORMAT(schCertTotal1);
                    IF schDegTotal1 <> 0 THEN schDegTotal := FORMAT(schDegTotal1);
                    IF schDipTotal1 <> 0 THEN schDipTotal := FORMAT(schDipTotal1);
                    IF schMASTERSTotal1 <> 0 THEN schMASTERSTotal := FORMAT(schMASTERSTotal1);

                    IF BridgGrandTotal1 <> 0 THEN BridgGrandTotal := FORMAT(BridgGrandTotal1);
                    IF CertGrandTotal1 <> 0 THEN CertGrandTotal := FORMAT(CertGrandTotal1);
                    IF DipGrandTotal1 <> 0 THEN DipGrandTotal := FORMAT(DipGrandTotal1);
                    IF DegGrandTotal1 <> 0 THEN DegGrandTotal := FORMAT(DegGrandTotal1);
                    IF MASTERSGrandTotal1 <> 0 THEN MASTERSGrandTotal := FORMAT(MASTERSGrandTotal1);
                    /////
                    IF schTotals1 <> 0 THEN schTotals := FORMAT(schTotals1);
                    IF GrandTotals1 <> 0 THEN GrandTotals := FORMAT(GrandTotals1);

                    IF Degree1 <> 0 THEN Degree := FORMAT(Degree1);
                    IF Diploma1 <> 0 THEN Diploma := FORMAT(Diploma1);
                    IF Certificate1 <> 0 THEN Certificate := FORMAT(Certificate1);
                    IF Bridging1 <> 0 THEN Bridging := FORMAT(Bridging1);
                    IF MASTERS1 <> 0 THEN MASTERS := FORMAT(MASTERS1);

                    IF CourseTotals1 <> 0 THEN CourseTotals := FORMAT(CourseTotals1);
                end;
            }

            trigger OnAfterGetRecord()
            begin

                CLEAR(schBridgTotal1);
                CLEAR(schMASTERSTotal1);
                CLEAR(schCertTotal1);
                CLEAR(schDipTotal1);
                CLEAR(schDegTotal1);
                CLEAR(schTotals1);

                CLEAR(schBridgTotal);
                CLEAR(schMASTERSTotal);
                CLEAR(schCertTotal);
                CLEAR(schDipTotal);
                CLEAR(schDegTotal);
                CLEAR(schTotals);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Semz; Semes)
                {
                    Caption = 'Semester:';
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

    trigger OnInitReport()
    begin
        IF info.GET() THEN Semes := info."Last Semester Filter";
    end;

    trigger OnPreReport()
    begin

        //IF acadyear = '' THEN ERROR('Specify the Academic year..');
        IF Semes = '' THEN ERROR('Specify the semester..');

        CLEAR(BridgGrandTotal1);
        CLEAR(MASTERSGrandTotal1);
        CLEAR(CertGrandTotal1);
        CLEAR(DipGrandTotal1);
        CLEAR(DegGrandTotal1);
        CLEAR(GrandTotals1);

        CLEAR(BridgGrandTotal);
        CLEAR(CertGrandTotal);
        CLEAR(MASTERSGrandTotal);
        CLEAR(DipGrandTotal);
        CLEAR(DegGrandTotal);
        CLEAR(GrandTotals);

        info.RESET;
        IF info.FIND('-') THEN info.CALCFIELDS(Picture);

        //IF ((acadyear<>'') AND (Semes<>'')) THEN acayrNsem:=', ACA YEAR: '+acadyear+','+Sems
        //ELSE acayrNsem:='';
    end;

    var
        "academic Year": Record 61382;
        campus: Record 349;
        info: Record 79;
        student: Record 61532;
        "Student Category": Option Continuing,New,All;
        Bridging1: Integer;
        MASTERS1: Integer;
        Certificate1: Integer;
        Diploma1: Integer;
        Degree1: Integer;
        CourseTotals1: Integer;
        schBridgTotal1: Integer;
        schMASTERSTotal1: Integer;
        schCertTotal1: Integer;
        schDipTotal1: Integer;
        schDegTotal1: Integer;
        schTotals1: Integer;
        BridgGrandTotal1: Integer;
        MASTERSGrandTotal1: Integer;
        CertGrandTotal1: Integer;
        DipGrandTotal1: Integer;
        DegGrandTotal1: Integer;
        Bridging: Code[50];
        MASTERS: Code[50];
        Certificate: Code[50];
        Diploma: Code[50];
        Degree: Code[50];
        CourseTotals: Code[50];
        schBridgTotal: Code[50];
        schMASTERSTotal: Code[50];
        schCertTotal: Code[50];
        schDipTotal: Code[50];
        schDegTotal: Code[50];
        schTotals: Code[50];
        BridgGrandTotal: Code[50];
        MASTERSGrandTotal: Code[50];
        CertGrandTotal: Code[50];
        DipGrandTotal: Code[50];
        DegGrandTotal: Code[50];
        GrandTotals: Code[50];
        GrandTotals1: Integer;
        Semes: Code[50];
        courseRegst: Record 61532;
        stages: Option " ","New Students","Continuing Students","All Stages";
        bal: Decimal;
        stud: Record 18;
        constLine: Text[250];
        Text000: Label 'Period: %1';
        Text001: Label 'NORMINAL ROLE';
        Text002: Label 'NORMINAL ROLE';
        Text003: Label 'POG. CODE';
        Text004: Label 'DIPLOMA';
        Text005: Label 'Company Name';
        Text006: Label 'Report No.';
        Text007: Label 'Report Name';
        Text008: Label 'User ID';
        Text009: Label 'Date';
        Text010: Label 'G/L Filter';
        Text011: Label 'Period Filter';
        Text012: Label 'BRIDGING';
        Text013: Label 'CERTIFICATE';
        Text014: Label 'Total Amount';
        Text015: Label 'PROG. DESCRITION';
        Text016: Label 'COURSE TOTALS';
        Text017: Label 'DEGREE';
        Text020: Label 'ACAD. YEAR';
        Text021: Label 'STAGE';
        Text022: Label 'STUD. TYPE';
        Text023: Label 'SEMESTER';
        Text024: Label '--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------';
}

