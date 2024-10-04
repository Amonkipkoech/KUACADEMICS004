page 77722 "ACA-Student Units Reservour"
{
    PageType = List;
    SourceTable = "ACA-Student Units Reservour";
    SourceTableView = SORTING(Stage)
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(general)
            {
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
                field(Unit; Rec.Unit)
                {
                    ApplicationArea = All;
                }
                field(Desc; Desc)
                {
                    Caption = 'Description';
                    Editable = false;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field("Special Exam"; Rec."Special Exam")
                {
                    ApplicationArea = All;
                }
                field("Reason for Special Exam"; Rec."Reason for Special Exam")
                {
                    ApplicationArea = All;
                }
                field("Reg. Transacton ID"; Rec."Reg. Transacton ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Register for"; Rec."Register for")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit Type"; Rec."Unit Type")
                {
                    ApplicationArea = All;
                }
                field(Taken; Rec.Taken)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //IF xRec.Taken=FALSE THEN
                        //ERROR('The Course must be marked Taken!');
                        IF Rec.Taken = TRUE THEN BEGIN
                            UnitsS.RESET;
                            //UnitsS.SETRANGE(UnitsS."Programme Code",Programme);
                            //UnitsS.SETRANGE(UnitsS."Stage Code",Stage);
                            UnitsS.SETRANGE(UnitsS.Code, Rec.Unit);
                            IF UnitsS.FIND('-') THEN BEGIN
                                Desc := UnitsS.Desription;
                                UnitStage := UnitsS."Stage Code";
                            END ELSE
                                Desc := '';
                        END;
                    end;
                }
                field("Repeat Unit"; Rec."Repeat Unit")
                {
                    Caption = 'Re-sit';
                    ApplicationArea = All;
                }
                field("Re-Take"; Rec."Re-Take")
                {
                    ApplicationArea = All;
                }
                field("Student Class"; Rec."Student Class")
                {
                    ApplicationArea = All;
                }
                field(UnitStage; UnitStage)
                {
                    Caption = 'Unit Stage';
                    ApplicationArea = All;
                }
                field(Audit; Rec.Audit)
                {
                    ApplicationArea = All;
                }
                field(Exempted; Rec.Exempted)
                {
                    ApplicationArea = All;
                }
                field("Final Score"; Rec."Final Score")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Attendance; Rec.Attendance)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Total Score"; Rec."Total Score")
                {
                    ApplicationArea = All;
                }
                field("Allow Supplementary"; Rec."Allow Supplementary")
                {
                    ApplicationArea = All;
                }
                field("Sat Supplementary"; Rec."Sat Supplementary")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field(Units; Rec.Units)
                {
                    ApplicationArea = All;
                }
                field("Reg Reversed"; Rec."Reg Reversed")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        UnitStage := '';

        UnitsS.RESET;
        UnitsS.SETRANGE(UnitsS."Programme Code", Rec.Programme);
        //UnitsS.SETRANGE(UnitsS."Stage Code",Stage);
        UnitsS.SETRANGE(UnitsS.Code, Rec.Unit);
        IF UnitsS.FIND('-') THEN BEGIN
            Desc := UnitsS.Desription;
            UnitStage := UnitsS."Stage Code";
        END ELSE
            Desc := '';
    end;

    var
        UnitsS: Record "ACA-Units/Subjects";
        Desc: Text[250];
        UnitStage: Code[20];
        Prog: Record "ACA-Programme";
        ProgDesc: Text[200];
        CReg: Record "ACA-Course Registration";
        StudUnits: Record "ACA-Student Units";

    local procedure UnitOnActivate()
    begin
        IF Rec."Reg. Transacton ID" = '' THEN BEGIN
            CReg.RESET;
            CReg.SETRANGE(CReg."Student No.", Rec."Student No.");
            IF CReg.FIND('-') THEN BEGIN
                Rec."Reg. Transacton ID" := CReg."Reg. Transacton ID";
                Rec.Programme := CReg.Programmes;
                Rec.Stage := CReg.Stage;
                Rec.Semester := CReg.Semester;
            END;
        END;

        UnitsS.RESET;
        //UnitsS.SETRANGE(UnitsS."Programme Code",Programme);
        //UnitsS.SETRANGE(UnitsS."Stage Code",Stage);
        UnitsS.SETRANGE(UnitsS.Code, Rec.Unit);
        IF UnitsS.FIND('-') THEN BEGIN
            Desc := UnitsS.Desription;
            UnitStage := UnitsS."Stage Code";
        END ELSE
            Desc := '';
    end;
}

