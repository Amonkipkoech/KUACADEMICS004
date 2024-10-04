report 60011 "ELECT-Get Candidate Ranks"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Pos; 60001)
        {
            DataItemTableView = WHERE("Position Approved" = FILTER(true));
            dataitem(ResRanks; 60010)
            {
                DataItemLink = "Election Code" = FIELD("Election Code"),
                               "Position Code" = FIELD("Position Code");
                DataItemTableView = SORTING("Election Code", "Position Code", "Votes Count")
                                    ORDER(Descending);

                trigger OnAfterGetRecord()
                begin

                    IF Scorez = ResRanks."Votes Count" THEN BEGIN
                        IF PositionRank = 0 THEN BEGIN
                            PositionRank := 1;
                        END ELSE BEGIN
                            PositionRank := PositionRank;

                        END;
                    END ELSE BEGIN
                        IF PositionRank = 0 THEN BEGIN
                            PositionRank := 1;
                            Scorez := ResRanks."Votes Count"
                        END ELSE BEGIN
                            PositionRank := PositionRank + 1;
                            Scorez := ResRanks."Votes Count"
                        END;
                    END;

                    ResRanks.Ranking := PositionRank;
                    IF PositionRank = 1 THEN BEGIN
                        ResRanks.Winner := TRUE;
                    END ELSE BEGIN
                        ResRanks.Winner := FALSE;
                    END;

                    ELECTPositions.RESET;
                    ELECTPositions.SETRANGE("Election Code", ResRanks."Election Code");
                    ELECTPositions.SETRANGE("Position Code", ResRanks."Position Code");
                    IF ELECTPositions.FIND('-') THEN BEGIN
                        ELECTPositions.CALCFIELDS("Votes Cast");
                        IF ELECTPositions."Votes Cast" <> 0 THEN
                            ResRanks."% Votes" := (Scorez / ELECTPositions."Votes Cast") * 100
                        ELSE
                            ResRanks."% Votes" := 0;
                    END;

                    ResRanks.MODIFY;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(PositionRank);
                CLEAR(Scorez);
                //PositionRank:=1;
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
        ELECTResultsRankings: Record 60010;
        PositionRank: Integer;
        Scorez: Integer;
        ELECTPositions: Record 60001;
}

