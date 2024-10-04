page 68129 "ACA-Auto_Time Table"
{
    DeleteAllowed = true;
    InsertAllowed = true;
    PageType = Card;
    SourceTable = "ACA-Time Table Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Campus; Rec.Campus)
                {
                    ApplicationArea = All;
                }
                field("Max Hours Continiously"; Rec."Max Hours Continiously")
                {
                    ApplicationArea = All;
                }
                field("Max Hours Weekly"; Rec."Max Hours Weekly")
                {
                    ApplicationArea = All;
                }
                field("Max Days Per Week"; Rec."Max Days Per Week")
                {
                    ApplicationArea = All;
                }
                field("Max Lecturer Hours Daily"; Rec."Max Lecturer Hours Daily")
                {
                    ApplicationArea = All;
                }
                field("Max Lecturer Days Per Week"; Rec."Max Lecturer Days Per Week")
                {
                    ApplicationArea = All;
                }
                field("Max Class Capacity"; Rec."Max Class Capacity")
                {
                    ApplicationArea = All;
                }
                field("Max Class Weekly"; Rec."Max Class Weekly")
                {
                    ApplicationArea = All;
                }
                field(Released; Rec.Released)
                {
                    ApplicationArea = All;
                }
                field("Released By"; Rec."Released By")
                {
                    ApplicationArea = All;
                }
                field("Released On"; Rec."Released On")
                {
                    ApplicationArea = All;
                }
                field("Last Opened By"; Rec."Last Opened By")
                {
                    ApplicationArea = All;
                }
                field("Last Opened On"; Rec."Last Opened On")
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
            action("Generate Teaching Time Table")
            {
                Image = "Action";
                ApplicationArea = All;

                trigger OnAction()
                begin

                    Rec.TESTFIELD(Released, FALSE);
                    TTRandom.GenerateClass(Rec.Semester, Rec."Max Class Capacity");
                    TTRandom.GenerateTT(Rec."Max Class Weekly", Rec.Semester);
                    MESSAGE('Done');
                end;
            }
            separator(_______)
            {
            }
            action("Generate Exams Time Table")
            {
                ApplicationArea = All;
            }
            separator(______________________)
            {
            }
            action("Clear Time Table")
            {
                Image = ClearLog;
                ApplicationArea = All;

                trigger OnAction()
                begin

                    Rec.TESTFIELD(Released, FALSE);
                    TTRandom.ClearCurrentTimeTable(Rec.Semester, Rec.Campus);
                end;
            }

            separator(__)
            {
            }
            action("Re Open")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                    Rec.TESTFIELD(Released, TRUE);
                    IF CONFIRM('Do you really want to re-open the time table?') = TRUE THEN BEGIN
                        TT.RESET;
                        TT.SETRANGE(TT.Semester, Rec.Semester);
                        TT.SETRANGE(TT."Campus Code", Rec.Campus);
                        IF TT.FIND('-') THEN BEGIN
                            REPEAT
                                TT.Released := FALSE;
                                TT.MODIFY;
                            UNTIL TT.NEXT = 0;
                        END;
                        Rec.Released := FALSE;
                        Rec."Last Opened By" := USERID;
                        Rec."Last Opened On" := TODAY;
                        Rec.MODIFY;

                    END;
                end;
            }
            separator(____)
            {
            }
            action("Set Active Stages")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    REPORT.RUN(39006202, TRUE, TRUE);
                end;
            }
        }
    }

    var
        TTRandom: Codeunit 50120;
        TT: Record 61540;
}

