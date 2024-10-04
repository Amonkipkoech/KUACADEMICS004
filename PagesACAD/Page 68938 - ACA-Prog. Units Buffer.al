page 68938 "ACA-Prog. Units Buffer"
{
    Editable = true;
    PageType = List;
    SourceTable = "ACA-Programme Units Buffer";
    SourceTableView = WHERE(Posted = FILTER(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Counted; Rec.Counted)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Prog. Code"; Rec."Prog. Code")
                {
                    ApplicationArea = All;
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;
                }
                field("Unit Code"; Rec."Unit Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Credit Hours"; Rec."Credit Hours")
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                }
                field("Failure Reason"; Rec."Failure Reason")
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
            group(general)
            {
                action(Import)
                {
                    Caption = 'Import Units';
                    Image = ImportCodes;
                    Promoted = true;
                    Visible = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Import Programme Units?', TRUE) = FALSE THEN ERROR('Cancelled by user..');
                        XMLPORT.RUN(50155, FALSE, TRUE);
                        MESSAGE('Units Imported into the Programme Units Successfully');
                    end;
                }
                action(Post)
                {
                    Caption = 'Post Units';
                    Image = PostOrder;
                    Promoted = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        buff: Record "ACA-Programme Units Buffer";
                        progUnits: Record "ACA-Units/Subjects";
                    begin
                        IF CONFIRM('Post units & Subjects?', TRUE) = FALSE THEN ERROR('Canceled by user..');
                        buff.RESET;
                        buff.SETRANGE(Posted, FALSE);
                        IF buff.FIND('-') THEN BEGIN
                            REPEAT
                            BEGIN
                                progUnits.RESET;
                                progUnits.SETRANGE(progUnits.Code, buff."Unit Code");
                                progUnits.SETRANGE(progUnits."Programme Code", buff."Prog. Code");
                                progUnits.SETRANGE(progUnits."Stage Code", buff.Stage);
                                IF NOT (progUnits.FIND('-')) THEN BEGIN
                                    progUnits.INIT;
                                    progUnits.Code := buff."Unit Code";
                                    progUnits."Programme Code" := buff."Prog. Code";
                                    progUnits."Stage Code" := buff.Stage;
                                    progUnits.Desription := buff.Description;
                                    progUnits."Credit Hours" := buff."Credit Hours";
                                    progUnits."No. Units" := buff."Credit Hours";
                                    progUnits.INSERT;
                                    buff.Posted := TRUE;
                                    buff.MODIFY;
                                END ELSE BEGIN
                                    progUnits.Desription := buff.Description;
                                    progUnits."Credit Hours" := buff."Credit Hours";
                                    progUnits."No. Units" := buff."Credit Hours";
                                    progUnits.MODIFY;

                                END;
                                buff.Posted := TRUE;
                                buff.MODIFY;
                            END;
                            UNTIL buff.NEXT = 0;
                        END;
                    end;
                }
            }
        }
    }
}

