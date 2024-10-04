page 61842 "ACA-Programme Stage Semesters"
{
    PageType = List;
    SourceTable = "ACA-Programme Stage Semesters";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Semester; Rec.Semester)
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field(Current; Rec.Current)
                {
                    ApplicationArea = All;
                }
                field(Start; Rec.Start)
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Units Registration Deadline"; Rec."Units Registration Deadline")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(GetSems)
            {
                Caption = 'Get Semesters';
                Image = GetActionMessages;
                Promoted = true;
                ApplicationArea = All;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    IF CONFIRM('Get Semesters?', FALSE) = FALSE THEN ERROR('Cancelled by user!');
                    IF CONFIRM('Update all stage Semesters for' + Rec."Programme Code" + '?', FALSE) = FALSE THEN BEGIN
                        ACAProgrammeStageSemesters.RESET;
                        ACAProgrammeStageSemesters.SETRANGE("Programme Code", Rec.GETFILTER("Programme Code"));
                        ACAProgrammeStageSemesters.SETRANGE(Stage, Rec.GETFILTER(Stage));
                        IF ACAProgrammeStageSemesters.FIND('-') THEN ACAProgrammeStageSemesters.DELETEALL;

                        ACASemesters.RESET;
                        IF ACASemesters.FIND('-') THEN BEGIN
                            REPEAT
                            BEGIN
                                ACAProgrammeStageSemesters.INIT;
                                ACAProgrammeStageSemesters."Programme Code" := Rec.GETFILTER("Programme Code");
                                ACAProgrammeStageSemesters.Semester := ACASemesters.Code;
                                ACAProgrammeStageSemesters.Stage := Rec.GETFILTER(Stage);
                                ACAProgrammeStageSemesters.Current := ACASemesters."Current Semester";
                                ACAProgrammeStageSemesters.Remarks := ACASemesters.Remarks;
                                ACAProgrammeStageSemesters.Start := ACASemesters.From;
                                ACAProgrammeStageSemesters."End Date" := ACASemesters."To";
                                ACAProgrammeStageSemesters."Units Registration Deadline" := ACASemesters."Registration Deadline";
                                ACAProgrammeStageSemesters.INSERT(TRUE);
                            END;
                            UNTIL ACASemesters.NEXT = 0;
                        END;
                    END ELSE BEGIN
                        ACAProgrammeStages.RESET;
                        ACAProgrammeStages.SETRANGE("Programme Code", Rec.GETFILTER("Programme Code"));
                        IF ACAProgrammeStages.FIND('-') THEN BEGIN
                            REPEAT
                            BEGIN
                                ////////////////////////////////////////////////////
                                ACAProgrammeStageSemesters.RESET;
                                ACAProgrammeStageSemesters.SETRANGE("Programme Code", Rec.GETFILTER("Programme Code"));
                                ACAProgrammeStageSemesters.SETRANGE(Stage, ACAProgrammeStages.Code);
                                IF ACAProgrammeStageSemesters.FIND('-') THEN ACAProgrammeStageSemesters.DELETEALL;

                                ACASemesters.RESET;
                                IF ACASemesters.FIND('-') THEN BEGIN
                                    REPEAT
                                    BEGIN
                                        ACAProgrammeStageSemesters.INIT;
                                        ACAProgrammeStageSemesters."Programme Code" := ACAProgrammeStages."Programme Code";
                                        ACAProgrammeStageSemesters.Semester := ACASemesters.Code;
                                        ACAProgrammeStageSemesters.Stage := ACAProgrammeStages.Code;
                                        ACAProgrammeStageSemesters.Current := ACASemesters."Current Semester";
                                        ACAProgrammeStageSemesters.Start := ACASemesters.From;
                                        ACAProgrammeStageSemesters."End Date" := ACASemesters."To";
                                        ACAProgrammeStageSemesters."Units Registration Deadline" := ACASemesters."Registration Deadline";
                                        ACAProgrammeStageSemesters.Remarks := ACASemesters.Remarks;
                                        ACAProgrammeStageSemesters.INSERT(TRUE);
                                    END;
                                    UNTIL ACASemesters.NEXT = 0;
                                END;
                                ////////////////////////////////////////////////////
                            END;
                            UNTIL ACAProgrammeStages.NEXT = 0;
                        END;
                    END;
                end;
            }
            action("Units on Offer")
            {
                ApplicationArea = All;
                Promoted = true;
                Image = AllocatedCapacity;
                PromotedCategory = Process;
                RunObject = page "ACA-Sem Units of Offer";
                RunPageLink = Semester = field(Semester), "Stage Code" = field(Stage), "Programme Code" = field("Programme Code");
            }
        }
    }

    var
        ACASemesters: Record 61692;
        ACAProgrammeStageSemesters: Record 61842;
        ACAProgrammeStages: Record 61516;
}

