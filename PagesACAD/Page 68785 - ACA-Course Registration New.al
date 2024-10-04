page 68785 "ACA-Course Registration New"
{
    AutoSplitKey = true;
    Editable = true;
    PageType = List;
    SourceTable = 61532;

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("Reg. Transacton ID"; Rec."Reg. Transacton ID")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Programme; Rec.Programmes)
                {
                    ApplicationArea = All;
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // BKK
                        CReg.RESET;
                        CReg.SETRANGE(CReg."Student No.", Rec."Student No.");
                        CReg.SETRANGE(CReg.Programmes, Rec.Programmes);
                        CReg.SETRANGE(CReg.Stage, Rec.Stage);
                        IF CReg.FIND('-') THEN BEGIN
                            ERROR('Stage ' + CReg.Stage + ' Already Exist For This Student')
                        END;
                    end;
                }
                field(Semester; Rec.Semester)
                {
                    Caption = 'Semester';
                    ApplicationArea = All;
                }
                field(ProgDesc; ProgDesc)
                {
                    Caption = 'Description';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Options; Rec.Options)
                {
                    ApplicationArea = All;
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    Caption = 'Reg. Date';
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Register for"; Rec."Register for")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Settlement Type"; Rec."Settlement Type")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Registered; Rec.Registered)
                {
                    ApplicationArea = All;
                }
                field(Session; Rec.Session)
                {
                    ApplicationArea = All;
                }
                field(Unit; Rec.Unit)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Student Type"; Rec."Student Type")
                {
                    OptionCaption = '<Full Time,Evening,Sandwich>';
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                }
                field("Units Taken"; Rec."Units Taken")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Re-sits"; Rec."Re-sits")
                {
                    ApplicationArea = All;
                }
                field(Transfered; Rec.Transfered)
                {
                    ApplicationArea = All;
                }
                field("Units Passed"; Rec."Units Passed")
                {
                    ApplicationArea = All;
                }
                field("Units Failed"; Rec."Units Failed")
                {
                    ApplicationArea = All;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = All;
                }
                field("Exam Grade"; Rec."Exam Grade")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Exam Status"; Rec."Exam Status")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Attending Classes"; Rec."Attending Classes")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Print Registered Courses")
            {
                Caption = 'Print Registered Courses';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CReg.RESET;
                    CReg.SETFILTER(CReg.Semester, Rec.Semester);
                    CReg.SETFILTER(CReg."Student No.", Rec."Student No.");
                    CReg.SETFILTER(CReg."Reg. Transacton ID", Rec."Reg. Transacton ID");
                    IF CReg.FIND('-') THEN
                        REPORT.RUN(39005951, TRUE, TRUE, CReg);
                end;
            }
            action(SuppExams)
            {
                Caption = 'Supplementary Examinations';
                Image = RegisteredDocs;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 78006;
                RunPageLink = "Student No." = FIELD("Student No.");
                RunPageView = WHERE(Catogory = FILTER(Supplementary));
                ApplicationArea = All;
            }
            action(SpecialExamsReg)
            {
                Caption = 'Special Examination Reg.';
                Image = RegisterPick;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 78002;
                RunPageLink = "Student No." = FIELD("Student No.");
                RunPageView = WHERE("Total Marks" = FILTER(1));
                ApplicationArea = All;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ProgDesc := '';
        IF Prog.GET(Rec.Programmes) THEN
            ProgDesc := Prog.Description;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        IF Rec."Attending Classes" = TRUE THEN
            ERROR('Transaction once posted cannot be modified.');

        IF Rec.Posted = TRUE THEN
            ERROR('Transaction once posted cannot be modified.');
    end;

    trigger OnInit()
    begin
        ProgDesc := '';
    end;

    trigger OnModifyRecord(): Boolean
    begin
        IF Rec."Attending Classes" = TRUE THEN
            ERROR('Transaction once posted cannot be modified.');

        IF Rec.Posted = TRUE THEN
            ERROR('Transaction once posted cannot be modified.');
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        ProgDesc := '';
    end;

    var
        Prog: Record "ACA-Programme";
        ProgDesc: Text[200];
        CReg: Record "ACA-Course Registration";

    local procedure OnBeforePutRecord()
    begin
        ProgDesc := '';
    end;
}

