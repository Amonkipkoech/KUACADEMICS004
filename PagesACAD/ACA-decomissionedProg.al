/// <summary>
/// Page ACA-Programmes List (ID 68757).
/// </summary>
page 85539 "ACA-Programmes Decomissioned"
{
    // = "ACA-Programmes";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = 61511;
    SourceTableView = WHERE("Program Status" = FILTER(Decomissioned));

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Time Table"; Rec."Time Table")
                {
                    ApplicationArea = All;
                }
                field("Total Income"; Rec."Total Income")
                {
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field("Exam Category"; Rec."Exam Category")
                {
                    ApplicationArea = All;
                }
                field("School Code"; Rec."School Code")
                {
                    ApplicationArea = All;
                }
                field("Student Registered"; Rec."Student Registered")
                {
                    ApplicationArea = All;
                }
                field("Male Count"; Rec."Male Count")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Female Count"; Rec."Female Count")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Not Classified"; Rec."Not Classified")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Programme)
            {
                Caption = 'Programme';
                action(Semesters)
                {
                    Caption = 'Semesters';
                    Ellipsis = true;
                    Image = Worksheet;
                    Promoted = true;
                    PromotedCategory = New;
                    RunObject = Page "ACA-Programme Semesters";
                    RunPageLink = "Programme Code" = FIELD(Code);
                    ApplicationArea = All;
                }
                action(Stages)
                {
                    Caption = 'Stages';
                    Ellipsis = true;
                    Image = LedgerBook;
                    Promoted = true;
                    PromotedCategory = New;
                    PromotedIsBig = true;
                    RunObject = Page 68742;
                    RunPageLink = "Programme Code" = FIELD(Code);
                    ApplicationArea = All;
                }
                action("Defined Graduation Units")
                {
                    Caption = 'Defined Graduation Units';
                    Ellipsis = false;
                    Image = MakeDiskette;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = false;
                    RunObject = Page "ACA-Prog. Defined Units/YoS";
                    RunPageLink = Programmes = FIELD(Code);
                    ApplicationArea = All;
                }
                action(Import)
                {
                    Caption = 'Import';
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    
                    trigger OnAction()
                    begin
                        IF CONFIRM('Import Units/Subjects', TRUE) = FALSE THEN EXIT;
                        XMLPORT.RUN(84506, FALSE, TRUE);
                    end;
                }
                action("Cohort Pricing Template")
                {
                    Caption = 'Cohort Pricing Template';
                    Image = CheckJournal;
                    Promoted = true;
                    RunObject = Page "ACA-Charge";
                   
                    ApplicationArea = All;
                }
                action("New Student Charges")
                {
                    Caption = 'Program Fees Template';
                    Image = CheckJournal;
                    Promoted = true;
                    RunObject = Page 68770;
                    RunPageLink = "Programme Code" = FIELD(Code);
                    ApplicationArea = All;
                }
                action("Non-Cohort Charges")
                {
                    Caption = 'on-Cohort Charges';
                    Image = CheckJournal;
                    Promoted = true;
                    RunObject = Page "ACA-Special Exams Charge Setup";
                
                    ApplicationArea = All;
                }
                action("Prog. Graduation Groups")
                {
                    Caption = 'Prog. Graduation Groups';
                    Ellipsis = true;
                    Image = VoucherGroup;
                    Promoted = true;
                    PromotedCategory = New;
                    RunObject = Page 77801;
                    RunPageLink = "Programme Code" = FIELD(Code);
                    ApplicationArea = All;
                }

                action("Release Allocation")
                {
                    Caption = 'Release Allocation';
                    Image = Worksheet;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        TimeTable.RESET;
                        TimeTable.SETRANGE(TimeTable.Programme, Rec.Code);
                        IF TimeTable.FIND('-') THEN BEGIN
                            REPEAT
                                TimeTable.Released := TRUE;
                                TimeTable.MODIFY;
                            UNTIL TimeTable.NEXT = 0;

                        END;

                        MESSAGE('Release completed successfully.');
                    end;
                }
                action("Undo Release Allocation")
                {
                    Caption = 'Undo Release Allocation';
                    Image = Worksheet;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        TimeTable.RESET;
                        TimeTable.SETRANGE(TimeTable.Programme, Rec.Code);
                        IF TimeTable.FIND('-') THEN BEGIN
                            REPEAT
                                TimeTable.Released := FALSE;
                                TimeTable.MODIFY;
                            UNTIL TimeTable.NEXT = 0;

                        END;

                        MESSAGE('Process completed successfully.');
                    end;
                }

                action("Entry Subjects")
                {
                    Caption = 'Entry Subjects';
                    Image = Entries;
                    Promoted = true;
                    RunObject = Page "ACA-Programme Entry Subjects";
                    RunPageLink = Programme = FIELD(Code);
                    ApplicationArea = All;
                }
                action("Admission Req. Narration")
                {
                    Image = Worksheet;
                    RunObject = Page "ACA-Admission Narration";
                    RunPageLink = "Programme Code" = FIELD(Code);
                    ApplicationArea = All;
                }
                separator(____)
                {
                }
                action("Programme Options")
                {
                    Caption = 'Programme Specialization';
                    Image = Worksheet;
                    RunObject = Page 68140;
                    RunPageLink = "Programme Code" = FIELD(Code);
                    ApplicationArea = All;
                }
                action("Fee Structure")
                {
                    Caption = 'Fee Structure';
                    Image = InventoryJournal;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        prog.RESET;
                        prog.SETRANGE(prog.Programme, Rec.Code);
                        IF prog.FIND('-') THEN BEGIN
                            REPORT.RUN(51794, TRUE, TRUE, prog);
                        END;
                    end;
                }
                action("Copy Fee Structure")
                {
                    Caption = 'Copy Fee Structure';
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Copy Fee Structure?', FALSE) = FALSE THEN ERROR('Cancelled by user!');
                        PAGE.RUN(69280, Rec);
                    end;
                }
            }
        }
    }

    var
        TimeTable: Record "ACA-Time Table";
        prog: Record "ACA-Time Table";
}

