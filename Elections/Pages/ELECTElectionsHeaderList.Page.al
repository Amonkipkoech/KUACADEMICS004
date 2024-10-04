/// <summary>
/// Page ELECT-Elections Header List (ID 60010).
/// </summary>
page 60010 "ELECT-Elections Header List"
{
    CardPageID = "ELECT-Elections Header Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 60000;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Election Code"; Rec."Election Code")
                {
                    ApplicationArea = All;
                }
                field("Election Date"; Rec."Election Date")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Election Description"; Rec."Election Description")
                {
                    ApplicationArea = All;
                }
                field("Election Approach"; Rec."Election Approach")
                {
                    ApplicationArea = All;
                }
                field("Voting Method"; Rec."Voting Method")
                {
                    ApplicationArea = All;
                }
                field("Voter Choice"; Rec."Voter Choice")
                {
                    ApplicationArea = All;
                }
                field("Allow Abstain"; Rec."Allow Abstain")
                {
                    ApplicationArea = All;
                }
                field("Abstain Candidate"; Rec."Abstain Candidate")
                {
                    ApplicationArea = All;
                }
                field("Active Students only"; Rec."Active Students only")
                {
                    ApplicationArea = All;
                }
                field("Candidate Balance Based on"; Rec."Candidate Balance Based on")
                {
                    ApplicationArea = All;
                }
                field("Candicate Balance"; Rec."Candicate Balance")
                {
                    ApplicationArea = All;
                }
                field("Voter Balance Based on"; Rec."Voter Balance Based on")
                {
                    ApplicationArea = All;
                }
                field("Voter Balance"; Rec."Voter Balance")
                {
                    ApplicationArea = All;
                }
                field("Voter Registration Method"; Rec."Voter Registration Method")
                {
                    ApplicationArea = All;
                }
                field("Registered Voters"; Rec."Registered Voters")
                {
                    ApplicationArea = All;
                }
                field("Eligible Voters"; Rec."Eligible Voters")
                {
                    ApplicationArea = All;
                }
                field("Total Voted"; Rec."Total Voted")
                {
                    ApplicationArea = All;
                }
                field("Did not Vote"; Rec."Did not Vote")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(Setups)
            {
                Caption = 'Setup';
                Image = Setup;
                action(PositionCats)
                {
                    Caption = 'Position Categories/Groups';
                    Image = GLJournal;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page 60003;
                    RunPageLink = "Election Code" = FIELD("Election Code");
                    ApplicationArea = All;
                }
                action(ElectralDistr)
                {
                    Caption = 'Electral Districts';
                    Image = AddWatch;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page 60004;
                    RunPageLink = "Election Code" = FIELD("Election Code");
                    ApplicationArea = All;
                }
                action(VotingReg)
                {
                    Caption = 'Voter Register';
                    Image = Register;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page 60012;
                    RunPageLink = "Election Code" = FIELD("Election Code");
                    ApplicationArea = All;
                }
                action("Election Setups")
                {
                    Caption = 'Election Setups';
                    Image = Setup;
                    Promoted = true;
                    RunObject = Page 60024;
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            group(Activities)
            {
                Caption = 'Periodic Activites';
                Image = Dimensions;
                action(AllowApplic)
                {
                    Caption = 'Allow Applications';
                    Image = Allocate;
                    Promoted = false;
                    ApplicationArea = All;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;

                    trigger OnAction()
                    var
                        NoSeriesManagement: Codeunit 396;
                    begin
                        IF CONFIRM('If allow application?', TRUE) = FALSE THEN ERROR('Cancelled by user');
                        ELECTMyPositions.RESET;
                        ELECTMyPositions.SETRANGE("Election Code", Rec."Election Code");
                        IF ELECTMyPositions.FIND('-') THEN
                            ELECTMyPositions.DELETEALL; //Clear all Positions for the Voters

                        IF TODAY > Rec."Candidature Application End" THEN ERROR('Its past application deadline of ' + FORMAT(Rec."Candidature Application End"));
                        Rec."Applications Allowed" := TRUE;
                        ELECTVoterRegister.RESET;
                        ELECTVoterRegister.SETRANGE("Election Code", Rec."Election Code");
                        ELECTVoterRegister.SETFILTER(Eligible, '%1', TRUE);
                        ELECTVoterRegister.SETFILTER("Manual Eligibility to Contest", '%1', TRUE);
                        IF ELECTVoterRegister.FIND('-') THEN BEGIN
                            //Loop through all Voters Picking eligible Voters to create My Positions and My Candidates
                            REPEAT
                            BEGIN
                                IF ELECTVoterRegister."Ballot ID" = '' THEN BEGIN
                                    ELECTVoterRegister."Ballot ID" := NoSeriesManagement.GetNextNo(Rec."Ballot ID Numbers", TODAY, TRUE);
                                    ELECTVoterRegister.MODIFY;
                                END;
                                ELECTPositions.RESET;
                                ELECTPositions.SETRANGE("Election Code", Rec."Election Code");
                                ELECTPositions.SETFILTER("Position Code", '<>%1', '');
                                IF ELECTPositions.FIND('-') THEN BEGIN
                                    REPEAT
                                    BEGIN
                                        IF ELECTPositions."Position Scope" = ELECTPositions."Position Scope"::"Overal Position" THEN BEGIN
                                            //Insert for the Voter Irespective of some other parameters like Dept
                                            ELECTMyPositions.RESET;
                                            ELECTMyPositions.SETRANGE("Election Code", Rec."Election Code");
                                            ELECTMyPositions.SETRANGE("Position Code", ELECTPositions."Position Code");
                                            ELECTMyPositions.SETRANGE("Voter No.", ELECTVoterRegister."Voter No.");
                                            IF NOT ELECTMyPositions.FIND('-') THEN BEGIN
                                                ELECTMyPositions.INIT;
                                                ELECTMyPositions."Election Code" := Rec."Election Code";
                                                ELECTMyPositions."Position Code" := ELECTPositions."Position Code";
                                                ELECTMyPositions."Voter No." := ELECTVoterRegister."Voter No.";
                                                ELECTMyPositions.INSERT;
                                            END;
                                        END ELSE
                                            IF ELECTPositions."Position Scope" = ELECTPositions."Position Scope"::"School Position" THEN BEGIN
                                                IF ELECTPositions."School Code" = ELECTVoterRegister."School Code" THEN BEGIN
                                                    //Insert the Position for a Voter since its in the same school as a voter
                                                    ELECTMyPositions.RESET;
                                                    ELECTMyPositions.SETRANGE("Election Code", Rec."Election Code");
                                                    ELECTMyPositions.SETRANGE("Position Code", ELECTPositions."Position Code");
                                                    ELECTMyPositions.SETRANGE("Voter No.", ELECTVoterRegister."Voter No.");
                                                    IF NOT ELECTMyPositions.FIND('-') THEN BEGIN
                                                        ELECTMyPositions.INIT;
                                                        ELECTMyPositions."Election Code" := Rec."Election Code";
                                                        ELECTMyPositions."Position Code" := ELECTPositions."Position Code";
                                                        ELECTMyPositions."Voter No." := ELECTVoterRegister."Voter No.";
                                                        ELECTMyPositions.INSERT;
                                                    END;
                                                END;
                                            END ELSE
                                                IF ELECTPositions."Position Scope" = ELECTPositions."Position Scope"::"Campus Position" THEN BEGIN
                                                    IF ELECTPositions."Campus Code" = ELECTVoterRegister."Campus Code" THEN BEGIN
                                                        //Insert the Position for a Voter since its in the same school as a voter
                                                        ELECTMyPositions.RESET;
                                                        ELECTMyPositions.SETRANGE("Election Code", Rec."Election Code");
                                                        ELECTMyPositions.SETRANGE("Position Code", ELECTPositions."Position Code");
                                                        ELECTMyPositions.SETRANGE("Voter No.", ELECTVoterRegister."Voter No.");
                                                        IF NOT ELECTMyPositions.FIND('-') THEN BEGIN
                                                            ELECTMyPositions.INIT;
                                                            ELECTMyPositions."Election Code" := Rec."Election Code";
                                                            ELECTMyPositions."Position Code" := ELECTPositions."Position Code";
                                                            ELECTMyPositions."Voter No." := ELECTVoterRegister."Voter No.";
                                                            ELECTMyPositions.INSERT;
                                                        END;
                                                    END;
                                                END ELSE
                                                    IF ELECTPositions."Position Scope" = ELECTPositions."Position Scope"::"Departmental Position" THEN BEGIN
                                                        IF ELECTPositions."Department Code" = ELECTVoterRegister."Department Code" THEN BEGIN
                                                            //Insert the Position for a Voter since its in the same school as a voter
                                                            ELECTMyPositions.RESET;
                                                            ELECTMyPositions.SETRANGE("Election Code", Rec."Election Code");
                                                            ELECTMyPositions.SETRANGE("Position Code", ELECTPositions."Position Code");
                                                            ELECTMyPositions.SETRANGE("Voter No.", ELECTVoterRegister."Voter No.");
                                                            IF NOT ELECTMyPositions.FIND('-') THEN BEGIN
                                                                ELECTMyPositions.INIT;
                                                                ELECTMyPositions."Election Code" := Rec."Election Code";
                                                                ELECTMyPositions."Position Code" := ELECTPositions."Position Code";
                                                                ELECTMyPositions."Voter No." := ELECTVoterRegister."Voter No.";
                                                                ELECTMyPositions.INSERT;
                                                            END;
                                                        END;
                                                    END ELSE
                                                        IF ELECTPositions."Position Scope" = ELECTPositions."Position Scope"::"Electral District Position" THEN BEGIN
                                                            IF ELECTPositions."Electral District" = ELECTVoterRegister."Electral District" THEN BEGIN
                                                                //Insert the Position for a Voter since its in the same school as a voter
                                                                ELECTMyPositions.RESET;
                                                                ELECTMyPositions.SETRANGE("Election Code", Rec."Election Code");
                                                                ELECTMyPositions.SETRANGE("Position Code", ELECTPositions."Position Code");
                                                                ELECTMyPositions.SETRANGE("Voter No.", ELECTVoterRegister."Voter No.");
                                                                IF NOT ELECTMyPositions.FIND('-') THEN BEGIN
                                                                    ELECTMyPositions.INIT;
                                                                    ELECTMyPositions."Election Code" := Rec."Election Code";
                                                                    ELECTMyPositions."Position Code" := ELECTPositions."Position Code";
                                                                    ELECTMyPositions."Voter No." := ELECTVoterRegister."Voter No.";
                                                                    ELECTMyPositions.INSERT;
                                                                END;
                                                            END;
                                                        END;
                                    END;
                                    UNTIL ELECTPositions.NEXT = 0;
                                END;
                            END;
                            UNTIL ELECTVoterRegister.NEXT = 0;
                        END;
                        MESSAGE('Voter Positions update successfully!');
                    end;
                }
                action(AllowVoting)
                {
                    Caption = 'Allow Voting';
                    Image = Approvals;
                    Promoted = false;
                    ApplicationArea = All;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;

                    trigger OnAction()
                    begin
                        IF CONFIRM('If allow Voting?', TRUE) = FALSE THEN ERROR('Cancelled by user');
                        IF ((TODAY > Rec."Election Date")) THEN ERROR('The election dates are Past');
                        ELECTMyCandidates.RESET;
                        ELECTMyCandidates.SETRANGE("Election Code", Rec."Election Code");
                        IF ELECTMyCandidates.FIND('-') THEN ELECTMyCandidates.DELETEALL;
                        Rec."Voting Allowed" := TRUE;
                        ELECTMyPositions.RESET;
                        ELECTMyPositions.SETRANGE("Election Code", Rec."Election Code");
                        IF ELECTMyPositions.FIND('-') THEN BEGIN
                            REPEAT
                            BEGIN
                                ELECTCandidates.RESET;
                                ELECTCandidates.SETRANGE("Election Code", Rec."Election Code");
                                ELECTCandidates.SETRANGE("Position Code", ELECTMyPositions."Position Code");
                                IF ELECTCandidates.FIND('-') THEN BEGIN
                                    REPEAT
                                    BEGIN
                                        ELECTMyCandidates.RESET;
                                        ELECTMyCandidates.SETRANGE("Election Code", Rec."Election Code");
                                        ELECTMyCandidates.SETRANGE("Position Code", ELECTMyPositions."Position Code");
                                        ELECTMyCandidates.SETRANGE("Voter No.", ELECTMyPositions."Voter No.");
                                        ELECTMyCandidates.SETRANGE("Candidate No.", ELECTCandidates."Candidate No.");
                                        IF NOT ELECTMyCandidates.FIND('-') THEN BEGIN
                                            ELECTMyCandidates.INIT;
                                            ELECTMyCandidates."Election Code" := Rec."Election Code";
                                            ELECTMyCandidates."Position Code" := ELECTMyPositions."Position Code";
                                            ELECTMyCandidates."Voter No." := ELECTMyPositions."Voter No.";
                                            ELECTMyCandidates."Candidate No." := ELECTCandidates."Candidate No.";
                                            ELECTMyCandidates.INSERT;
                                            // // //            Customer.RESET;
                                            // // //            Customer.SETRANGE("No.",ELECTMyPositions."Candidate No.");
                                            // // //            IF Customer.FIND('-') THEN
                                            // // //            ELECTMyCandidates."Candidate Name":=Customer.Name;
                                        END;
                                    END;
                                    UNTIL ELECTCandidates.NEXT = 0;
                                END;
                            END;
                            UNTIL ELECTMyPositions.NEXT = 0;
                        END;

                        MESSAGE('Votting allowed successfully');
                    end;
                }
                action(RankCandidates)
                {
                    Caption = 'Rank Candidate';
                    Image = ExecuteAndPostBatch;
                    Promoted = false;
                    ApplicationArea = All;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;

                    trigger OnAction()
                    begin
                        ELECTPositions.RESET;
                        ELECTPositions.SETRANGE("Election Code", Rec."Election Code");
                        IF ELECTPositions.FIND('-') THEN BEGIN
                            REPORT.RUN(60010, FALSE, FALSE, ELECTPositions);
                            REPORT.RUN(60011, FALSE, FALSE, ELECTPositions);
                        END;
                    end;
                }
            }
        }
        area(reporting)
        {
            group(Reports)
            {
                Caption = 'Reports';
                action(VoterRegister)
                {
                    Caption = 'Voter Register';
                    Image = RegisteredDocs;
                    Promoted = false;
                    ApplicationArea = All;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;

                    trigger OnAction()
                    begin
                        ELECTPollingCenters.RESET;
                        ELECTPollingCenters.SETRANGE("Election Code", Rec."Election Code");
                        IF ELECTPollingCenters.FIND('-') THEN BEGIN
                            REPORT.RUN(60009, TRUE, FALSE, ELECTPollingCenters);
                        END;
                    end;
                }
                action(Agents)
                {
                    Caption = 'Agents';
                    Image = Aging;
                    Promoted = false;
                    ApplicationArea = All;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;

                    trigger OnAction()
                    begin
                        ELECTElectralDistricts.RESET;
                        ELECTElectralDistricts.SETRANGE("Election Code", Rec."Election Code");
                        IF ELECTElectralDistricts.FIND('-') THEN BEGIN
                            REPORT.RUN(60013, TRUE, FALSE, ELECTElectralDistricts);
                        END;
                    end;
                }
                action(BallotPapers)
                {
                    Caption = 'Ballot Papers';
                    Image = Documents;
                    Promoted = false;
                    ApplicationArea = All;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;

                    trigger OnAction()
                    begin
                        ELECTPositions.RESET;
                        ELECTPositions.SETRANGE("Election Code", Rec."Election Code");
                        IF ELECTPositions.FIND('-') THEN REPORT.RUN(60014, TRUE, FALSE);
                    end;
                }
                action(ResultsSummary)
                {
                    Caption = 'Results Summary';
                    Image = SuggestGrid;
                    Promoted = false;
                    ApplicationArea = All;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;

                    trigger OnAction()
                    begin
                        ELECTPositions.RESET;
                        ELECTPositions.SETRANGE("Election Code", Rec."Election Code");
                        IF ELECTPositions.FIND('-') THEN REPORT.RUN(60015, TRUE, FALSE);
                    end;
                }
                action(Winners)
                {
                    Caption = 'Election Winners';
                    Image = AddToHome;
                    Promoted = false;
                    ApplicationArea = All;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;

                    trigger OnAction()
                    begin
                        ELECTPositions.RESET;
                        ELECTPositions.SETRANGE("Election Code", Rec."Election Code");
                        IF ELECTPositions.FIND('-') THEN REPORT.RUN(60016, TRUE, FALSE);
                    end;
                }
            }
        }
    }

    var
        ELECTMyPositions: Record 60011;
        ELECTMyCandidates: Record 60012;
        ELECTVoterRegister: Record 60002;
        ELECTPositions: Record 60001;
        ELECTCandidates: Record 60006;

        ELECTElectralDistricts: Record 60004;
        ELECTPollingCenters: Record 60008;
}

