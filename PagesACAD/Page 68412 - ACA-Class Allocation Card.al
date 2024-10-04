page 68412 "ACA-Class Allocation Card"
{
    PageType = Card;
    SourceTable = 61212;

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
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                }
                field(Stage; Rec.Stage)
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
                field("Students Range"; Rec."Students Range")
                {
                    ApplicationArea = All;
                }
                field("Class Code"; Rec."Class Code")
                {
                    ApplicationArea = All;
                }
                field("Student Count"; Rec."Student Count")
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
            action(Allocate)
            {
                Image = Allocate;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.TESTFIELD(Programme);
                    Rec.TESTFIELD(Stage);
                    Rec.TESTFIELD(Semester);
                    Rec.TESTFIELD("Class Code");
                    Rec.CALCFIELDS("Student Count");
                    IF Rec."Student Count" < 1 THEN ERROR('Zero students found');
                    Creg.RESET;
                    Creg.SETRANGE(Creg.Programmes, Rec.Programme);
                    Creg.SETRANGE(Stage, Creg.Stage);
                    Creg.SETRANGE(Creg.Semester);
                    Creg.SETFILTER(Creg."Student No.", Rec."Students Range");
                    IF Creg.FIND('-') THEN BEGIN
                        REPEAT
                            Creg."Class Code" := Rec."Class Code";
                            Creg.MODIFY;
                        UNTIL Creg.NEXT = 0;
                    END;
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        // ERROR('Test');
    end;

    var
        Creg: Record 61532;
}

