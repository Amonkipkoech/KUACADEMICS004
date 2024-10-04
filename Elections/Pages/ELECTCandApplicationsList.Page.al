page 60015 "ELECT-Cand. Applications List"
{
    CardPageID = "ELECT-Cand. Applications Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 60005;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Candidate No."; Rec."Candidate No.")
                {
                    ApplicationArea = All;
                }
                field("Candidate Names"; Rec."Candidate Names")
                {
                    ApplicationArea = All;
                }
                field("Position Code"; Rec."Position Code")
                {
                    ApplicationArea = All;
                }
                field("Position Category"; Rec."Position Category")
                {
                    ApplicationArea = All;
                }
                field("Electraol District Code"; Rec."Electraol District Code")
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                field("School Code"; Rec."School Code")
                {
                    ApplicationArea = All;
                }
                field("Campus Code"; Rec."Campus Code")
                {
                    ApplicationArea = All;
                }
                field("Campaign Slogan"; Rec."Campaign Slogan")
                {
                    ApplicationArea = All;
                }
                field("Campaign Statement"; Rec."Campaign Statement")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Approved; Rec.Approved)
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Qualifies; Rec.Qualifies)
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Approv)
            {
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ELECTCandidates: Record 60006;
                begin
                    Rec.CALCFIELDS(Qualifies);
                    IF Rec.Approved THEN ERROR('Applicant already cleared');
                    IF NOT Rec.Qualifies THEN ERROR('Applicant does not qualify');
                    IF CONFIRM('Clear Applicant?', TRUE) = TRUE THEN BEGIN
                        Rec.Approved := TRUE;
                        // Move Applicant to applications
                        ELECTCandidates.RESET;
                        ELECTCandidates.SETRANGE("Election Code", Rec."Election Code");
                        ELECTCandidates.SETRANGE("Candidate No.", Rec."Candidate No.");
                        IF NOT ELECTCandidates.FIND('-') THEN BEGIN
                            ELECTCandidates.INIT;
                            ELECTCandidates."Election Code" := Rec."Election Code";
                            ELECTCandidates."Candidate No." := Rec."Candidate No.";
                            ELECTCandidates."Position Code" := Rec."Position Code";
                            ELECTCandidates."Position Category" := Rec."Position Category";
                            ELECTCandidates."Electral District Code" := Rec."Electraol District Code";
                            ELECTCandidates."Department Code" := Rec."Department Code";
                            ELECTCandidates."School Code" := Rec."School Code";
                            ELECTCandidates."Campus Code" := Rec."Campus Code";
                            ELECTCandidates."Campaign Slogan" := Rec."Campaign Slogan";
                            ELECTCandidates."Campaign Statement" := Rec."Campaign Statement";
                            ELECTCandidates."Candidate Names" := Rec."Candidate Names";
                            ELECTCandidates.INSERT;
                        END;
                        MESSAGE('Applicant Cleared');
                    END ELSE
                        ERROR('Cancelled');
                end;
            }
        }
    }
}

