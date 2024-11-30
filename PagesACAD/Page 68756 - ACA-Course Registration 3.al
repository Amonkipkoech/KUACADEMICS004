page 68756 "ACA-Course Registration 3"
{
    DeleteAllowed = true;
    Editable = true;
    PageType = List;
    SourceTable = "ACA-Course Registration";

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("Reg. Transacton ID"; Rec."Reg. Transacton ID")
                {
                    Editable = false;
                    Visible = true;
                    ApplicationArea = All;
                    Caption = 'Session Creation Identifier';
                }

                field("Balance Due"; Rec."Balance Due")
                {
                    ApplicationArea = All;
                }
                field("Settlement Type"; Rec."Settlement Type")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field(ModeofStudy; Rec.ModeofStudy)
                {
                    ApplicationArea = All;
                }

                field(Modules; Rec.Modules)
                {
                    ApplicationArea = All;
                }
                field(Programme; Rec.Programmes)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field(ProgramName; Rec.ProgramName)
                {
                    ApplicationArea = All;
                }
                // field(FacultyName; Rec.FacultyName)
                // {
                //     ApplicationArea = All;
                // }
                field("Student Type"; Rec."Student Type")
                {
                    Editable = true;
                    ApplicationArea = All;
                    Caption = 'Mode of Study';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    Caption = 'Block/Session';
                    ApplicationArea = All;
                }
                field("Campus Code"; Rec."Campus Code")
                {
                    ApplicationArea = All;
                }
                field("Personal Email"; Rec."Personal Email")
                {
                    ApplicationArea = All;
                }

                field(Stage; Rec.Stage)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Class Stream"; "Class Stream")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Year Of Study"; Rec."Year Of Study")
                {
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
                field("Yearly Total Units Taken"; Rec."Yearly Total Units Taken")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    Caption = 'Reg. Date';
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
                    Caption = 'Student Exam Units';
                    ApplicationArea = All;
                }
                field("Units theory Taken"; Rec."Units theory Taken")
                {
                    Editable = true;
                    Caption = 'Student Theory Units';
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
                    trigger OnValidate()
                    var
                        usersetup: Record "User Setup";
                        AllowAccessSettings: boolean;
                        Nopermission: Label 'You Cannot Reverse Posted Transactions';
                    begin
                        AllowAccessSettings := true;
                        if usersetup.get(UserId) then
                            if (usersetup."Allow Transaction Reversal") then begin
                                AllowAccessSettings := usersetup."Allow Transaction Reversal";
                                exit
                            end;
                        Error(Nopermission);
                    end;
                    //Editable = false;
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
                field("Yearly Total Cores"; Rec."Yearly Total Cores")
                {
                    ApplicationArea = All;
                }
                field("Yearly Failed Cores"; Rec."Yearly Failed Cores")
                {
                    ApplicationArea = All;
                }
                field("Supp. Yearly Failed Cores"; Rec."Supp. Yearly Failed Cores")
                {
                    ApplicationArea = All;
                }
                field("Supp. Yearly Failed Electives"; Rec."Supp. Yearly Failed Electives")
                {
                    ApplicationArea = All;
                }
                field("Supp. Yearly Total Cores"; Rec."Supp. Yearly Total Cores")
                {
                    ApplicationArea = All;
                }
                field("Supp. Yearly Total Electives"; Rec."Supp. Yearly Total Electives")
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
                    RunObject = Page "ACA-Student Units";
                    RunPageLink = "Student No." = FIELD("Student No."),
                                  Semester = FIELD(Semester),
                                  Programme = FIELD(Programmes),
                                  Reversed = FILTER(false),
                                  Stage = FIELD(Stage),
                                  "Academic Year" = FIELD("Academic Year");
                    ApplicationArea = All;
                }
                action(SuppExams)
                {
                    Caption = 'Resit/Supplementary';
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
                    ApplicationArea = All;
                }
                action("Student Charges")
                {
                    Caption = 'Student Charges';
                    Image = ReceivableBill;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "ACA-Student Charges";
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
                    RunObject = Page "ACA-Student Charges";
                    RunPageLink = "Student No." = FIELD("Student No."),
                                  "Reg. Transacton ID" = FIELD("Reg. Transacton ID");
                    RunPageView = WHERE(Posted = FILTER(true));
                    ApplicationArea = All;
                }

            }
        }
    }

    /* trigger OnAfterGetRecord()
    begin
        SETCURRENTKEY("Student No.", Stage);
        IF Cust.GET("Student No.") THEN
        //to do;
    end;
 */
    trigger OnInit()
    begin
        Rec.SETCURRENTKEY("Student No.", Stage);
    end;

    trigger OnOpenPage()
    begin
        Rec.SETCURRENTKEY("Student No.", Stage);
    end;





}

