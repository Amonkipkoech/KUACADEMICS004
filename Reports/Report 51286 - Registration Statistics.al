report 51286 "Registration Statistics"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Registration Statistics.rdl';

    dataset
    {
        dataitem("ACA-Programme"; 61511)
        {
            RequestFilterFields = "Stage Filter", "Settlement Type Filter";
            column(Description; "ACA-Programme".Description)
            {
            }
            column(JabMale; "ACA-Programme"."Total JAB Male")
            {
            }
            column(JabFemale; "ACA-Programme"."Total JAB Female")
            {
            }
            column(ProgJabTotal; ProgJabTotal)
            {
            }
            column(SSPMale; "ACA-Programme"."Total SSP Male")
            {
            }
            column(SSPFemale; "ACA-Programme"."Total SSP Female")
            {
            }
            column(ProgSSPTotal; ProgSSPTotal)
            {
            }
            column(ProgTotal; progTotal)
            {
            }
            column(JabGrandTotal; jabGrangTotal)
            {
            }
            column(SSPGrandTotal; SspGrandTotal)
            {
            }
            column(OverallTotal; OveralTotal)
            {
            }
            column(SchoolCode; "ACA-Programme"."School Code")
            {
            }
            column(SchoolName; SchoolName)
            {
            }
            column(JMale; JabMale)
            {
            }
            column(JFemale; JabFemale)
            {
            }
            column(SMale; SSPMale)
            {
            }
            column(SFemale; SSPFemale)
            {
            }

            trigger OnAfterGetRecord()
            begin
                DimVal.RESET;
                DimVal.SETRANGE(DimVal.Code, "ACA-Programme"."School Code");
                IF DimVal.FIND('-') THEN BEGIN
                    SchoolName := DimVal.Name;
                END;

                JabMale := 0;
                JabFemale := 0;
                SSPMale := 0;
                SSPFemale := 0;

                CourseReg.RESET;
                CourseReg.SETRANGE(CourseReg.Programmes, "ACA-Programme".Code);
                CourseReg.SETRANGE(CourseReg."Settlement Type", 'JAB');
                CourseReg.SETRANGE(CourseReg.Gender, CourseReg.Gender::Male);
                CourseReg.SETRANGE(CourseReg.Reversed, FALSE);
                CourseReg.SETRANGE(CourseReg."Current Sem", TRUE);
                IF CourseReg.FIND('-') THEN BEGIN
                    CourseReg.SETFILTER(CourseReg.Stage, "ACA-Programme".GETFILTER("ACA-Programme"."Stage Filter"));
                    CourseReg.LOCKTABLE;
                    JabMale := CourseReg.COUNT;
                END;

                CourseReg.RESET;
                CourseReg.SETRANGE(CourseReg.Programmes, "ACA-Programme".Code);
                CourseReg.SETRANGE(CourseReg."Settlement Type", 'JAB');
                CourseReg.SETRANGE(CourseReg.Gender, CourseReg.Gender::Female);
                CourseReg.SETRANGE(CourseReg.Reversed, FALSE);
                CourseReg.SETRANGE(CourseReg."Current Sem", TRUE);
                IF CourseReg.FIND('-') THEN BEGIN
                    CourseReg.SETFILTER(CourseReg.Stage, "ACA-Programme".GETFILTER("ACA-Programme"."Stage Filter"));
                    CourseReg.LOCKTABLE;
                    JabFemale := CourseReg.COUNT;
                END;

                CourseReg.RESET;
                CourseReg.SETRANGE(CourseReg.Programmes, "ACA-Programme".Code);
                CourseReg.SETRANGE(CourseReg."Settlement Type", 'SSP');
                CourseReg.SETRANGE(CourseReg.Gender, CourseReg.Gender::Male);
                CourseReg.SETRANGE(CourseReg.Reversed, FALSE);
                CourseReg.SETRANGE(CourseReg."Current Sem", TRUE);
                IF CourseReg.FIND('-') THEN BEGIN
                    CourseReg.SETFILTER(CourseReg.Stage, "ACA-Programme".GETFILTER("ACA-Programme"."Stage Filter"));
                    CourseReg.LOCKTABLE;
                    SSPMale := CourseReg.COUNT;
                END;

                CourseReg.RESET;
                CourseReg.SETRANGE(CourseReg.Programmes, "ACA-Programme".Code);
                CourseReg.SETRANGE(CourseReg."Settlement Type", 'SSP');
                CourseReg.SETRANGE(CourseReg.Gender, CourseReg.Gender::Female);
                CourseReg.SETRANGE(CourseReg.Reversed, FALSE);
                CourseReg.SETRANGE(CourseReg."Current Sem", TRUE);
                IF CourseReg.FIND('-') THEN BEGIN
                    CourseReg.SETFILTER(CourseReg.Stage, "ACA-Programme".GETFILTER("ACA-Programme"."Stage Filter"));
                    CourseReg.LOCKTABLE;
                    SSPFemale := CourseReg.COUNT;
                END;

                CLEAR(progTotal);
                CLEAR(ProgSSPTotal);
                CLEAR(ProgJabTotal);
                ProgJabTotal := JabMale + JabFemale;
                ProgSSPTotal := SSPMale + SSPFemale;
                progTotal := ProgSSPTotal + ProgJabTotal;

                IF (JabMale = 0) AND (JabFemale = 0) AND (SSPMale = 0) AND (JabFemale = 0) THEN
                    CurrReport.SKIP;
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
        ProgJabTotal: Decimal;
        SchlJabTotal: Decimal;
        ProgSSPTotal: Decimal;
        SchlSSPTotal: Decimal;
        progTotal: Decimal;
        jabGrangTotal: Decimal;
        SspGrandTotal: Decimal;
        OveralTotal: Decimal;
        SchoolName: Text[150];
        DimVal: Record 349;
        CourseReg: Record 61532;
        JabMale: Integer;
        JabFemale: Integer;
        SSPMale: Integer;
        SSPFemale: Integer;
}

