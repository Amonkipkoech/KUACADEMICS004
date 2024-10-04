report 51788 "List By County & Gender"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/List By County & Gender.rdl';

    dataset
    {
        dataitem("ACA-Academics Central Setups"; "ACA-Academics Central Setups")
        {
            DataItemTableView = WHERE(Category = FILTER(Counties));
            column(pic; Info.Picture)
            {
            }
            column(Title1; 'STUDENT POPULATION BY COUNTY, STUDY MODE, AND GENDER AS AT ' + FORMAT(TODAY, 0, 4) + ', ' + Semesters)
            {
            }
            column(CountyDesc; "ACA-Academics Central Setups"."Title Code" + ': ' + "ACA-Academics Central Setups".Description)
            {
            }
            column(SSPMaleFull; PSSPMaleFull)
            {
            }
            column(SSPFemaleFull; PSSPFemaleFull)
            {
            }
            column(SSPTotalFull; PSSPTotalFull)
            {
            }
            column(SSPMalePart; PSSPMalePart)
            {
            }
            column(SSPFemalePart; PSSPFemalePart)
            {
            }
            column(SSPTotalPart; PSSPTotalPart)
            {
            }
            column(GOKMaleFull; KUCCPSMaleFull)
            {
            }
            column(GOKFemaleFull; KUCCPSFemaleFull)
            {
            }
            column(GOKTotalFull; KUCCPSTotalFull)
            {
            }
            column(GOKMalePart; KUCCPSMalePart)
            {
            }
            column(GOKFemalePart; KUCCPSFemalePart)
            {
            }
            column(GOKTotalPart; KUCCPSTotalPart)
            {
            }
            column(ProgMaleTotal; ProgMaleTotal)
            {
            }
            column(ProgFemaleTotal; ProgFemaleTotal)
            {
            }
            column(ProgGrandTotal; ProgGrandTotal)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(PSSPMaleFull);
                CLEAR(PSSPFemaleFull);
                CLEAR(PSSPTotalFull);
                CLEAR(PSSPMalePart);
                CLEAR(PSSPFemalePart);
                CLEAR(PSSPTotalPart);
                CLEAR(KUCCPSMaleFull);
                CLEAR(KUCCPSFemaleFull);
                CLEAR(KUCCPSTotalFull);
                CLEAR(KUCCPSMalePart);
                CLEAR(KUCCPSFemalePart);
                CLEAR(KUCCPSTotalPart);
                CLEAR(ProgMaleTotal);
                CLEAR(ProgFemaleTotal);
                CLEAR(ProgGrandTotal);
                CLEAR(studnumber);
                CourseReg.RESET;
                CourseReg.SETRANGE(CourseReg."County Code", "ACA-Academics Central Setups"."Title Code");
                IF acaYear <> '' THEN
                    CourseReg.SETRANGE(CourseReg."Academic Year", acaYear);
                IF Semesters <> '' THEN
                    CourseReg.SETRANGE(CourseReg.Semester, Semesters);
                IF CourseReg.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        CourseReg.CALCFIELDS(CourseReg.Gender);
                        IF ((CourseReg.Gender = CourseReg.Gender::Male) AND (CourseReg."Settlement Type" = 'PSSP') AND
                        (CourseReg."Student Type" = CourseReg."Student Type"::"Full Time")) THEN BEGIN
                            PSSPMaleFull := PSSPMaleFull + 1;
                            PSSPTotalFull := PSSPTotalFull + 1;
                            ProgMaleTotal := ProgMaleTotal + 1;
                        END;

                        IF ((CourseReg.Gender = CourseReg.Gender::Female) AND (CourseReg."Settlement Type" = 'PSSP') AND
                        (CourseReg."Student Type" = CourseReg."Student Type"::"Full Time")) THEN BEGIN
                            PSSPFemaleFull := PSSPFemaleFull + 1;
                            PSSPTotalFull := PSSPTotalFull + 1;
                            ProgFemaleTotal := ProgFemaleTotal + 1;
                        END;

                        IF ((CourseReg.Gender = CourseReg.Gender::Male) AND (CourseReg."Settlement Type" = 'PSSP') AND
                        (CourseReg."Student Type" = CourseReg."Student Type"::"School-Based")) THEN BEGIN
                            PSSPMalePart := PSSPMalePart + 1;
                            PSSPTotalPart := PSSPTotalPart + 1;
                            ProgMaleTotal := ProgMaleTotal + 1;
                        END;

                        IF ((CourseReg.Gender = CourseReg.Gender::Female) AND (CourseReg."Settlement Type" = 'PSSP') AND
                        (CourseReg."Student Type" = CourseReg."Student Type"::"School-Based")) THEN BEGIN
                            PSSPFemalePart := PSSPFemalePart + 1;
                            PSSPTotalPart := PSSPTotalPart + 1;
                            ProgFemaleTotal := ProgFemaleTotal + 1;
                        END;


                        IF ((CourseReg.Gender = CourseReg.Gender::Male) AND (CourseReg."Settlement Type" = 'KUCCPS') AND
                        (CourseReg."Student Type" = CourseReg."Student Type"::"Full Time")) THEN BEGIN
                            KUCCPSMaleFull := KUCCPSMaleFull + 1;
                            KUCCPSTotalFull := KUCCPSTotalFull + 1;
                            ProgMaleTotal := ProgMaleTotal + 1;
                        END;

                        IF ((CourseReg.Gender = CourseReg.Gender::Female) AND (CourseReg."Settlement Type" = 'KUCCPS') AND
                        (CourseReg."Student Type" = CourseReg."Student Type"::"Full Time")) THEN BEGIN
                            KUCCPSFemaleFull := KUCCPSFemaleFull + 1;
                            KUCCPSTotalFull := KUCCPSTotalFull + 1;
                            ProgFemaleTotal := ProgFemaleTotal + 1;
                        END;

                        IF ((CourseReg.Gender = CourseReg.Gender::Male) AND (CourseReg."Settlement Type" = 'KUCCPS') AND
                        (CourseReg."Student Type" = CourseReg."Student Type"::"School-Based")) THEN BEGIN
                            KUCCPSMalePart := KUCCPSMalePart + 1;
                            KUCCPSTotalPart := KUCCPSTotalPart + 1;
                            ProgMaleTotal := ProgMaleTotal + 1;
                        END;

                        IF ((CourseReg.Gender = CourseReg.Gender::Female) AND (CourseReg."Settlement Type" = 'KUCCPS') AND
                        (CourseReg."Student Type" = CourseReg."Student Type"::"School-Based")) THEN BEGIN
                            KUCCPSFemalePart := KUCCPSFemalePart + 1;
                            KUCCPSTotalPart := KUCCPSTotalPart + 1;
                            ProgFemaleTotal := ProgFemaleTotal + 1;
                        END;
                        //  studnumber:=CourseReg.COUNT;
                        ProgGrandTotal := ProgGrandTotal + 1;

                    END;
                    UNTIL CourseReg.NEXT = 0;
                END;

                //IF CourseReg.FIND('-') THEN BEGIN
                //  studnumber:=CourseReg.COUNT;
                //  ProgGrandTotal:=studnumber;
                //END;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(AcadYear; acaYear)
                {
                    Caption = 'Academic Year:';
                    TableRelation = "ACA-Academic Year".Code;
                    ApplicationArea = All;
                }
                field(Semz; Semesters)
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

    trigger OnPreReport()
    begin

        IF acaYear = '' THEN ERROR('Please Specify the Academic Year.');
        IF Semesters = '' THEN ERROR('Please Specify the Semester.');
        cou := 0;
        CLEAR(overaltotal);

        Info.RESET;
        IF Info.FIND('-') THEN BEGIN
            Info.CALCFIELDS(Picture);
        END;
    end;

    var
        overaltotal: Integer;
        studnumber: Integer;
        strgs: Code[20];
        progys: Code[20];
        intk: Code[20];
        TotalMale: Integer;
        TotalFEMale: Integer;
        campCode: Code[20];
        Genders: Option "BOTH GENDER",Male,Female;
        Names: Text[250];

        Prog: Text[250];
        Stage: Text[250];
        Unit: Text[250];
        Sem: Text[250];

        Hesabu: Integer;
        StudFilter: Code[10];
        StudType: Option " ",Boarder,Dayscholar,"Distance Learning","School Based";
        CourseReg: Record 61532;
        Info: Record 79;

        sFound: Boolean;
        GEND: Text[30];
        Display: Boolean;
        Disp: Boolean;
        cou: Integer;
        acaYear: Code[50];
        Semesters: Code[50];

        stages: Option " ","New Students","Continuing Students","All Stages";
        bal: Decimal;

        constLine: Text[250];
        Text000: Label 'Period: %1';
        Text001: Label 'NORMINAL ROLE';
        Text002: Label 'NORMINAL ROLE';
        Text003: Label 'Reg. No.';
        Text004: Label 'Phone No.';
        Text005: Label 'Company Name';
        Text006: Label 'Report No.';
        Text007: Label 'Report Name';
        Text008: Label 'User ID';
        Text009: Label 'Date';
        Text010: Label 'G/L Filter';
        Text011: Label 'Period Filter';
        Text012: Label 'Gender';
        Text013: Label 'Mode of Study';
        Text014: Label 'Total Amount';
        Text015: Label 'Name';
        Text016: Label 'Reg. Date';
        Text017: Label 'Stage';
        Text020: Label 'ACAD. YEAR';
        Text021: Label 'STAGE';
        Text022: Label 'STUD. TYPE';
        Text023: Label 'SEMESTER';
        Text024: Label '--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------';
        PSSPMaleFull: Integer;
        PSSPFemaleFull: Integer;
        PSSPTotalFull: Integer;
        PSSPMalePart: Integer;
        PSSPFemalePart: Integer;
        PSSPTotalPart: Integer;
        KUCCPSMaleFull: Integer;
        KUCCPSFemaleFull: Integer;
        KUCCPSTotalFull: Integer;
        KUCCPSMalePart: Integer;
        KUCCPSFemalePart: Integer;
        KUCCPSTotalPart: Integer;
        ProgMaleTotal: Integer;
        ProgFemaleTotal: Integer;
        ProgGrandTotal: Integer;
}

