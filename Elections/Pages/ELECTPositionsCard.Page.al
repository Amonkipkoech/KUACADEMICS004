/// <summary>
/// Page ELECT-Positions Card (ID 60001).
/// </summary>
page 60001 "ELECT-Positions Card"
{
    PageType = Card;
    SourceTable = 60001;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Election Code"; Rec."Election Code")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Position Category"; Rec."Position Category")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Position Code"; Rec."Position Code")
                {
                    ApplicationArea = All;
                }
                field("Position Description"; Rec."Position Description")
                {
                    ApplicationArea = All;
                }
                field("Position Notes"; Rec."Position Notes")
                {
                    ApplicationArea = All;
                }
                field("Position Scope"; Rec."Position Scope")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec."Electral District" := '';
                        Rec."Campus Code" := '';
                        Rec."Department Code" := '';
                        Rec."School Code" := '';
                        EnableElectralDist := FALSE;
                        EnableDept := FALSE;
                        EnableCampus := FALSE;
                        EnableSchool := FALSE;
                        IF Rec."Position Scope" = Rec."Position Scope"::"Campus Position" THEN BEGIN
                            EnableCampus := TRUE;
                        END ELSE
                            IF Rec."Position Scope" = Rec."Position Scope"::"School Position" THEN BEGIN
                                EnableSchool := TRUE;
                            END ELSE
                                IF Rec."Position Scope" = Rec."Position Scope"::"Departmental Position" THEN BEGIN
                                    EnableDept := TRUE;
                                END ELSE
                                    IF Rec."Position Scope" = Rec."Position Scope"::"Electral District Position" THEN BEGIN
                                        EnableElectralDist := TRUE;
                                    END;
                    end;
                }
                field("Electral District"; Rec."Electral District")
                {
                    Editable = EnableElectralDist;
                    Enabled = EnableElectralDist;
                    ApplicationArea = All;
                }
                field("Campus Code"; Rec."Campus Code")
                {
                    Editable = EnableCampus;
                    Enabled = EnableCampus;
                    ApplicationArea = All;
                }
                field("School Code"; Rec."School Code")
                {
                    Editable = EnableSchool;
                    Enabled = EnableSchool;
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    Editable = EnableDept;
                    Enabled = EnableDept;
                    ApplicationArea = All;
                }
                field("Position Approved"; Rec."Position Approved")
                {
                    ApplicationArea = All;
                }
                field("No. Of Candidates"; Rec."No. Of Candidates")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("No. of Applications"; Rec."No. of Applications")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Votes Cast"; Rec."Votes Cast")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Highest Score"; Rec."Highest Score")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("First Position"; Rec."First Position")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Count Highest Positions"; Rec."Count Highest Positions")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Tie Exists"; Rec."Tie Exists")
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
    }

    var
        EnableElectralDist: Boolean;
        EnableDept: Boolean;
        EnableSchool: Boolean;
        EnableCampus: Boolean;
}

