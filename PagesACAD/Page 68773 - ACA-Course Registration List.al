page 68773 "ACA-Course Registration List"
{
    Editable = false;
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
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    Caption = 'Semester';
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Stage; Rec.Stage)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Session; Rec.Session)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    Caption = 'Reg. Date';
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Settlement Type"; Rec."Settlement Type")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Register for"; Rec."Register for")
                {
                    Editable = true;
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Units Taken"; Rec."Units Taken")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Student Type"; Rec."Student Type")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Total Paid"; Rec."Total Paid")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                }
                field("Total Billed"; Rec."Total Billed")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field(Unit; Rec.Unit)
                {
                    Editable = true;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Class Code"; Rec."Class Code")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field(Options; Rec.Options)
                {
                    ApplicationArea = All;
                }
                field("Exam Status"; Rec."Exam Status")
                {
                    ApplicationArea = All;
                }
                field(Registered; Rec.Registered)
                {
                    ApplicationArea = All;
                }
                field(Transfered; Rec.Transfered)
                {
                    ApplicationArea = All;
                }
                field(Reversed; Rec.Reversed)
                {
                    Caption = 'Stopped';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //Reversing := TRUE;
                    end;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
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
            action(Card)
            {
                Image = Customer;
                RunObject = Page "SWF-Student Other Incident SF";
                RunPageLink = "Student No" = FIELD("Student No.");
                ApplicationArea = All;
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

    var
        Cust: Record Customer;
}

