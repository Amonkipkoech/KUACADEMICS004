page 62200 "ACA-Raw KUCCPS Imports"
{
    PageType = List;
    SourceTable = 62200;
    SourceTableView = WHERE(Posted = FILTER(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Applicant; Rec.Applicant)
                {
                    ApplicationArea = All;
                }
                field("A.id"; Rec."A.id")
                {
                    ApplicationArea = All;
                }
                field("Fee Type"; Rec."Fee Type")
                {
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
                field(Cell; Rec.Cell)
                {
                    ApplicationArea = All;
                }
                field("P.id"; Rec."P.id")
                {
                    ApplicationArea = All;
                }
                field("Kuccps.id"; Rec."Kuccps.id")
                {
                    ApplicationArea = All;
                }
                field(Stream; Rec.Stream)
                {
                    ApplicationArea = All;
                }
                field(Faculty; Rec.Faculty)
                {
                    ApplicationArea = All;
                }
                field(Intake; Rec.Intake)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Admision No."; Rec."Admision No.")
                {
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Reporting Date"; Rec."Reporting Date")
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Failure Reason"; Rec."Failure Reason")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(process_to_Kuccps)
            {
                Caption = 'Post To KUCCPS Data';
                Image = Production;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    countedRecs: Integer;
                begin
                    IF CONFIRM('Generate KUCCPS data?', TRUE) = FALSE THEN ERROR('Cancelled by ' + USERID);

                    currrecs.RESET;
                    currrecs.SETRANGE(currrecs.Posted, FALSE);
                    IF currrecs.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            applications.RESET;
                            // applications.SETRANGE(applications."K.C.S.E Index Number",currrecs."A.id");
                            IF NOT applications.FIND('-') THEN BEGIN
                                // INSERT RECORDS HERE
                                CLEAR(countedRecs);
                                applications.RESET;
                                IF applications.FIND('-') THEN BEGIN countedRecs := applications.COUNT; END;
                                IF NOT ((getProgCode(currrecs."P.id")) = '') THEN BEGIN
                                    applications.INIT;
                                    //  applications."K.C.S.E Index Number":=currrecs."A.id";
                                    //applications."Application No.":=countedRecs+1;
                                    applications."First Degree Choice" := getProgCode(currrecs."P.id");
                                    //applications."S.No":=countedRecs+1;
                                    applications.Surname := currrecs.Applicant;
                                    applications.Gender := currrecs.Gender;
                                    applications."Admission No" := currrecs."Admision No.";
                                    applications."Telephone No. 1" := currrecs.Cell;
                                    applications."Address for Correspondence1" := currrecs.Email;
                                    applications."Date of Admission" := currrecs."Reporting Date";
                                    applications.INSERT;
                                    currrecs."Failure Reason" := '';
                                    currrecs.Posted := TRUE;
                                    currrecs.MODIFY;
                                END ELSE BEGIN
                                    currrecs."Failure Reason" := 'Missing Prog. Code';
                                    currrecs.MODIFY;
                                END;
                            END;
                        END;
                        UNTIL currrecs.NEXT = 0;
                    END;
                    REPORT.RUN(51348, TRUE, TRUE);
                end;
            }
        }
    }

    var
        currrecs: Record 62200;
        applications: Record 61358;
        prog: Record 61511;

    local procedure getProgCode(var progCode1: Code[20]) progcode2: Code[20]
    begin
        IF prog.GET(progCode1) THEN
            progcode2 := prog.Code ELSE BEGIN
            prog.RESET;
            prog.SETRANGE("Old Code", progCode1);
            IF prog.FIND('-') THEN BEGIN
                progcode2 := prog.Code;
            END ELSE
                progcode2 := '';// ELSE ERROR('The specified program is not in the list of programs. Neither as Old Nor as new code.');
        END;
    end;
}

