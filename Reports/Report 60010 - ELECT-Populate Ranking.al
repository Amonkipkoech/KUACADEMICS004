report 60010 "ELECT-Populate Ranking"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Pos; 60001)
        {
            DataItemTableView = WHERE("Position Approved" = FILTER(true));
            dataitem(Cands; 60006)
            {
                DataItemLink = "Election Code" = FIELD("Election Code"),
                               "Position Code" = FIELD("Position Code"),
                               "Position Category" = FIELD("Position Category");

                trigger OnAfterGetRecord()
                begin
                    Cands.CALCFIELDS("Votes Count");
                    ELECTResultsRankings.RESET;
                    ELECTResultsRankings.SETRANGE(ELECTResultsRankings."Election Code", Cands."Election Code");
                    ELECTResultsRankings.SETRANGE(ELECTResultsRankings."Position Code", Cands."Position Code");
                    ELECTResultsRankings.SETRANGE(ELECTResultsRankings."Candidate No.", Cands."Candidate No.");
                    IF ELECTResultsRankings.FIND('-') THEN BEGIN
                        ELECTResultsRankings."Votes Count" := Cands."Votes Count";
                        ELECTResultsRankings.MODIFY;
                    END ELSE BEGIN
                        ELECTResultsRankings.INIT;
                        ELECTResultsRankings."Election Code" := Cands."Election Code";
                        ELECTResultsRankings."Position Code" := Cands."Position Code";
                        ELECTResultsRankings."Candidate No." := Cands."Candidate No.";
                        ELECTResultsRankings."Votes Count" := Cands."Votes Count";
                        ELECTResultsRankings.INSERT;
                    END;
                end;
            }
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
}

