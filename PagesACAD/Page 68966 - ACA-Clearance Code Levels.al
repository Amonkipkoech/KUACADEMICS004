page 68966 "ACA-Clearance Code Levels"
{
    Caption = 'Clearance Code Levels';
    PageType = List;
    SourceTable = "ACA-Clearance Level Codes";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Clearance Level Code"; Rec."Clearance Level Code")
                {
                    ApplicationArea = All;
                }
                field(Sequence; Rec.Sequence)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Standard; Rec.Standard)
                {
                    ApplicationArea = All;
                }
                field("Priority Level"; Rec."Priority Level")
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
            action("Clearance Templates")
            {
                Caption = 'Clearance Templates';
                Image = ApplyTemplate;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF Rec.Standard THEN ERROR('Standard should not be true on Clearance levels.');
                    templates.RESET;
                    templates.SETRANGE(templates."Clearance Level Code", Rec."Clearance Level Code");
                    IF templates.FIND('-') THEN BEGIN
                    END;

                    PAGE.RUN(68967, templates);
                end;
            }
            action("Standard Clearance Approvers")
            {
                Caption = 'Standard Clearance Approvers';
                Image = Approvals;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF NOT Rec.Standard THEN ERROR('This applies to standard Clearance approvals only.');
                    stdClearance.RESET;
                    stdClearance.SETRANGE(stdClearance."Clearance Level Code", Rec."Clearance Level Code");
                    IF stdClearance.FIND('-') THEN BEGIN
                    END;

                    PAGE.RUN(68969, stdClearance);
                end;
            }
            action("Clearance Conditions")
            {
                Caption = 'Clearance Conditions';
                Image = Components;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    clconditions.RESET;
                    clconditions.SETRANGE(clconditions."Clearance Level Code", Rec."Clearance Level Code");
                    IF clconditions.FIND('-') THEN BEGIN

                    END;// else error('No Level selected!');
                    PAGE.RUN(69072, clconditions);
                end;
            }
        }
    }

    var
        stdClearance: Record "ACA-Clearance Std Approvers";
        templates: Record "ACA-Clearance templates";
        clconditions: Record "ACA-Clearance Conditions list";
}

