report 60016 "ELECT-Election Winners"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/ELECT-Election Winners.rdl';

    dataset
    {
        dataitem(ElectPositions; 60001)
        {
            DataItemTableView = SORTING("Election Code", "Position Code", "Position Category", "Electral District", "School Code", "Department Code", "Campus Code")
                                ORDER(Ascending);
            PrintOnlyIfDetail = true;
            column(ElectHeader; ELECTElectionsHeader."Election Description")
            {
            }
            column(CompNames; CompanyInformation.Name)
            {
            }
            column(CompAddress; CompanyInformation.Address + ' ' + CompanyInformation."Address 2" + ' ' + CompanyInformation.City)
            {
            }
            column(COmpPhone; CompanyInformation."Phone No." + ' ' + CompanyInformation."Phone No. 2")
            {
            }
            column(Pic; CompanyInformation.Picture)
            {
            }
            column(CompMail; CompanyInformation."Home Page" + ', ' + CompanyInformation."E-Mail")
            {
            }
            column(ElectralCode; "Election Code")
            {
            }
            column(ElectralDistrict; "Electral District")
            {
            }
            column(ElectPositionCategory; "Position Category")
            {
            }
            column(ElectPositionCode; "Position Code")
            {
            }
            column(ElectSchool; Schls)
            {
            }
            column(ElectDepartment; Deps)
            {
            }
            column(ElectCampus; Camps)
            {
            }
            column(WinnerNames; WinnerNames)
            {
            }
            column(WinnerVotes; WinnerVotes)
            {
            }
            column(WinnerPercentage; WinnerPercentage)
            {
            }
            column(WinnerPosition; WinnerPosition)
            {
            }
            column("Order"; ELECTPositionCategories.Order)
            {
            }
            dataitem(ElectCandidates; 60006)
            {
                DataItemLink = "Position Code" = FIELD("Position Code"),
                               "Position Category" = FIELD("Position Category"),
                               "Election Code" = FIELD("Election Code");
                DataItemTableView = SORTING("Election Code", "Candidate No.")
                                    ORDER(Ascending);
                PrintOnlyIfDetail = true;
                column(CandidateNo; "Candidate No.")
                {
                }
                column(CandidateNames; "Candidate Names")
                {
                }
                column(CandPic; "Photo/Potrait")
                {
                }
                dataitem(ElectResRankings; 60010)
                {
                    DataItemLink = "Election Code" = FIELD("Election Code"),
                                   "Position Code" = FIELD("Position Code"),
                                   "Candidate No." = FIELD("Candidate No.");
                    DataItemTableView = WHERE(Winner = FILTER(true));
                    column(Votesotten; "Votes Count")
                    {
                    }
                    column(Ranking; Ranking)
                    {
                    }
                    column(CandIsWinner; Winner)
                    {
                    }
                    column(PercentageVotes; "% Votes")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(seq);
                    CALCFIELDS("Photo/Potrait");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                ELECTPositionCategories.RESET;
                ELECTPositionCategories.SETRANGE("Election Code", "Election Code");
                ELECTPositionCategories.SETRANGE("Category Code", "Position Category");
                IF ELECTPositionCategories.FIND('-') THEN BEGIN
                END;

                CLEAR(WinnerNames);
                CLEAR(WinnerPercentage);
                CLEAR(WinnerPosition);
                CLEAR(WinnerVotes);
                ElectResRankings2.RESET;
                ElectResRankings2.SETRANGE("Election Code", "Election Code");
                ElectResRankings2.SETRANGE("Position Code", "Position Code");
                ElectResRankings2.SETRANGE(Winner, TRUE);
                IF ElectResRankings2.FIND('-') THEN BEGIN
                    ELECTCandidates2.RESET;
                    ELECTCandidates2.SETRANGE("Election Code", "Election Code");
                    ELECTCandidates2.SETRANGE("Candidate No.", ElectResRankings2."Candidate No.");
                    ELECTCandidates2.SETRANGE("Position Code", "Position Code");
                    IF ELECTCandidates2.FIND('-') THEN BEGIN
                        ELECTCandidates2.CALCFIELDS("Candidate Names");
                        WinnerNames := ELECTCandidates2."Candidate Names";
                        WinnerPercentage := ElectResRankings2."% Votes";
                        WinnerPosition := ElectResRankings2."Position Code";
                        WinnerVotes := ElectResRankings2."Votes Count";
                    END;
                END;
                CLEAR(Schls);
                CLEAR(Deps);
                CLEAR(Camps);
                RESET;
                SETRANGE("Election Code", "Election Code");



                IF "Election Code" = '' THEN "Election Code" := '- - -';
                IF "Electral District" = '' THEN "Electral District" := '- - -';
                IF "Position Category" = '' THEN "Position Category" := '- - -';
                IF "School Code" = '' THEN "School Code" := '- - -';
                IF "Department Code" = '' THEN "Department Code" := '- - -';
                IF "Campus Code" = '' THEN "Campus Code" := '- - -';

                DimensionValue.RESET;
                DimensionValue.SETRANGE(Code, "School Code");
                IF DimensionValue.FIND('-') THEN
                    Schls := DimensionValue.Name
                ELSE
                    Schls := "School Code";


                DimensionValue.RESET;
                DimensionValue.SETRANGE(Code, "Department Code");
                IF DimensionValue.FIND('-') THEN
                    Deps := DimensionValue.Name
                ELSE
                    Deps := "Department Code";


                DimensionValue.RESET;
                DimensionValue.SETRANGE(Code, "Campus Code");
                IF DimensionValue.FIND('-') THEN
                    Camps := DimensionValue.Name
                ELSE
                    Camps := "Campus Code";
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

    trigger OnInitReport()
    begin
        CompanyInformation.RESET;
        IF CompanyInformation.FIND('-') THEN BEGIN
            CompanyInformation.CALCFIELDS(Picture);
        END;
    end;

    var
        CompanyInformation: Record 79;
        ELECTElectionsHeader: Record 60000;
        seq: Integer;
        DimensionValue: Record 349;
        Schls: Text[200];
        Deps: Text[200];
        Camps: Text[200];
        WinnerNames: Code[200];
        WinnerVotes: Integer;
        WinnerPercentage: Decimal;
        WinnerPosition: Code[20];
        ElectResRankings2: Record 60010;
        ELECTCandidates2: Record 60006;
        ELECTPositionCategories: Record 60003;
}

