page 77721 "ACA-Course Reg. Reservour"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "ACA-Course Reg. Reservour";

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
                field("Special Exam Exists"; Rec."Special Exam Exists")
                {
                    Caption = 'Special Exams';
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Semester Total Units Taken"; Rec."Semester Total Units Taken")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Semester Passed Units"; Rec."Semester Passed Units")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Semester Failed Units"; Rec."Semester Failed Units")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Yearly Total Units Taken"; Rec."Yearly Total Units Taken")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Yearly Passed Units"; Rec."Yearly Passed Units")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Yearly Failed Units"; Rec."Yearly Failed Units")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Yearly Remarks"; Rec."Yearly Remarks")
                {
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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Exam Grade"; Rec."Exam Grade")
                {
                    ApplicationArea = All;
                }
                field("Result Status"; Rec."Result Status")
                {
                    ApplicationArea = All;
                }
                field("Cum Units Passed"; Rec."Cum Units Passed")
                {
                    ApplicationArea = All;
                }
                field("Cum Units Failed"; Rec."Cum Units Failed")
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
            group("Trimester Activities")
            {
                Caption = 'Trimester Activities';
                Description = 'Activities in a Trimester';
                Image = LotInfo;
                action("Student Units")
                {
                    Caption = 'Student Units';
                    Image = BOMRegisters;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 77722;
                    RunPageLink = "Student No." = FIELD("Student No."),
                                  Semester = FIELD(Semester),
                                  Programme = FIELD(Programmes),
                                  Reversed = FILTER(false);
                    ApplicationArea = All;
                }
                action("Student Charges")
                {
                    Caption = 'Student Charges';
                    Image = ReceivableBill;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 77723;
                    RunPageLink = "Student No." = FIELD("Student No."),
                                  "Reg. Transacton ID" = FIELD("Reg. Transacton ID");
                    RunPageView = WHERE(Posted = FILTER(false));
                    ApplicationArea = All;
                }
                action("Posted Charges")
                {
                    Caption = 'Posted Charges';
                    Image = PostedVendorBill;
                    Promoted = true;
                    PromotedIsBig = false;
                    RunObject = Page 77723;
                    RunPageLink = "Student No." = FIELD("Student No."),
                                  "Reg. Transacton ID" = FIELD("Reg. Transacton ID");
                    RunPageView = WHERE(Posted = FILTER(true));
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
                action(RevStopped)
                {
                    Caption = 'Reverse Stopped';
                    Image = AllocatedCapacity;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ACACourseRegReservour.RESET;
                        ACACourseRegReservour.SETRANGE("Student No.", Rec."Student No.");
                        IF ACACourseRegReservour.FIND('-') THEN BEGIN
                            REPEAT
                            BEGIN
                                ACACourseRegistration.RESET;
                                ACACourseRegistration.SETRANGE("Reg. Transacton ID", ACACourseRegReservour."Reg. Transacton ID");
                                ACACourseRegistration.SETRANGE("Student No.", ACACourseRegReservour."Student No.");
                                ACACourseRegistration.SETRANGE(Programmes, ACACourseRegReservour.Programmes);
                                ACACourseRegistration.SETRANGE(Semester, ACACourseRegReservour.Semester);
                                ACACourseRegistration.SETRANGE(Stage, ACACourseRegReservour.Stage);
                                IF NOT ACACourseRegistration.FIND('-') THEN BEGIN
                                    ACACourseRegistration.INIT;
                                    ACACourseRegistration."Reg. Transacton ID" := ACACourseRegReservour."Reg. Transacton ID";
                                    ACACourseRegistration."Student No." := ACACourseRegReservour."Student No.";
                                    ACACourseRegistration.Programmes := ACACourseRegReservour.Programmes;
                                    ACACourseRegistration.Semester := ACACourseRegReservour.Semester;
                                    ACACourseRegistration."Register for" := ACACourseRegReservour."Register for";
                                    ACACourseRegistration.Stage := ACACourseRegReservour.Stage;
                                    ACACourseRegistration."Student Type" := ACACourseRegReservour."Student Type";
                                    ACACourseRegistration."Entry No." := ACACourseRegReservour."Entry No.";
                                    ACACourseRegistration."Settlement Type" := ACACourseRegReservour."Settlement Type";
                                    ACACourseRegistration."Registration Date" := ACACourseRegReservour."Registration Date";
                                    ACACourseRegistration.Remarks := ACACourseRegReservour.Remarks;
                                    ACACourseRegistration."Attending Classes" := ACACourseRegReservour."Attending Classes";
                                    ACACourseRegistration.Posted := ACACourseRegReservour.Posted;
                                    ACACourseRegistration."User ID" := ACACourseRegReservour."User ID";
                                    ACACourseRegistration.Reversed := ACACourseRegReservour.Reversed;
                                    ACACourseRegistration."Admission No." := ACACourseRegReservour."Admission No.";
                                    ACACourseRegistration."Academic Year" := ACACourseRegReservour."Academic Year";
                                    ACACourseRegistration."Admission Type" := ACACourseRegReservour."Admission Type";
                                    ACACourseRegistration.Options := ACACourseRegReservour.Options;
                                    ACACourseRegistration."Registration Status" := ACACourseRegReservour."Registration Status";
                                    ACACourseRegistration."Intake Code" := ACACourseRegReservour."Intake Code";
                                    ACACourseRegistration."Exam Status" := ACACourseRegReservour."Exam Status";
                                    ACACourseRegistration."Semester Average" := ACACourseRegReservour."Semester Average";
                                    ACACourseRegistration."Cummulative Average" := ACACourseRegReservour."Cummulative Average";
                                    ACACourseRegistration."Year Of Study" := ACACourseRegReservour."Year Of Study";

                                    ACACourseRegistration.INSERT;
                                END;
                            END;
                            UNTIL ACACourseRegReservour.NEXT = 0;
                        END;
                    end;
                }
            }
        }
    }



    trigger OnInit()
    begin
        Rec.SETCURRENTKEY("Student No.", Stage);
    end;

    trigger OnOpenPage()
    begin
        Rec.SETCURRENTKEY("Student No.", Stage);
    end;

    var
        Cust: Record Customer;
        ACACourseRegistration: Record "ACA-Course Registration";
        ACACourseRegReservour: Record "ACA-Course Reg. Reservour";
}

