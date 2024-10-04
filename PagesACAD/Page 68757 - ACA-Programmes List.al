/// <summary>
/// Page ACA-Programmes List (ID 68757).
/// </summary>
page 68757 "ACA-Programmes List"
{
    CardPageID = "ACA-Programmes";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "ACA-Programme";
    SourceTableView = WHERE("Program Status" = FILTER(Active));

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
                action("FA entries")
                {
                    // Caption = 'Semesters';
                    Ellipsis = true;
                    Image = Worksheet;
                    Promoted = true;
                    PromotedCategory = New;
                    RunObject = Page faEntries;
                    //RunPageLink = "Programme Code" = FIELD(Code);
                    ApplicationArea = All;
                }
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
                    //PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Import Units/Subjects', TRUE) = FALSE THEN EXIT;
                        XMLPORT.RUN(84506, FALSE, TRUE);
                    end;
                }
                action("Update unit base code")
                {
                    Image = Agreement;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    //RunObject = Report updateUBB;
                    trigger OnAction()
                    begin
                        updateItems();
                    end;
                }
                action("Import fin Data")
                {
                    Caption = 'Import Data';
                    Image = Import;
                    Promoted = true;
                    //PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Import finance data', TRUE) = FALSE THEN EXIT;
                        XMLPORT.RUN(84507, FALSE, TRUE);
                    end;

                }
                action("Validate Journal")
                {
                    Image = UpdateXML;
                    Promoted = true;
                    //PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    RunObject = Report "Journal Validate";


                }
                action("Validate Faculty")
                {
                    Image = FARegisters;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        Rec.ValidateFaculty();
                    end;
                }
                action("Update Unit Based")
                {
                    Image = Agreement;
                    Promoted = true;
                    // PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    //RunObject = Report updateUBB;


                    trigger OnAction()
                    begin
                        UpdateUBB();
                    end;
                }
                action("UpddateMax")
                {
                    Image = Agreement;
                    Promoted = true;
                    // PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    //RunObject = Report updateUBB;


                    trigger OnAction()
                    begin
                        updateMaxUnits();
                    end;
                }
                action("Bill")
                {
                    Image = Agreement;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    //RunObject = Report updateUBB;


                    trigger OnAction()
                    begin
                        billSupp();
                    end;
                }
                action(unitPrices)
                {
                    Image = Payables;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    RunObject = Page UnitPrices;
                }
                action("Unit Names")
                {
                    Image = UpdateXML;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    RunObject = Report "Validate Unit Name";
                }
                // action("Update Names")
                // {
                //     Image = UpdateXML;
                //     Promoted = true;
                //     PromotedCategory = Category4;
                //     PromotedIsBig = true;
                //     ApplicationArea = All;
                //     trigger OnAction()
                //     begin
                //         IF CONFIRM('Update Names', TRUE) = FALSE THEN EXIT;
                //         XMLPORT.RUN(84508, FALSE, TRUE);
                //     end;

                // }
                action("Import Cust Dta")
                {
                    Image = UpdateXML;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        IF CONFIRM('Import Data', TRUE) = FALSE THEN EXIT;
                        XMLPORT.RUN(86622, FALSE, TRUE);
                    end;

                }
                action("Export Test")
                {
                    Image = UpdateXML;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        IF CONFIRM('Export Data', TRUE) = FALSE THEN EXIT;
                        XMLPORT.RUN(84509, FALSE, TRUE);
                    end;

                }
                action("Cust Ledger")
                {
                    Image = Ledger;
                    Promoted = true;
                    //PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "Customer Ledger Entries Test";
                    ApplicationArea = All;
                }
                action("Cust leg entry")
                {
                    Image = Ledger;
                    Promoted = true;
                    //PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "Data Mine";
                    ApplicationArea = All;
                }
                action("g/l enrty")
                {
                    Image = Ledger;
                    Promoted = true;
                    //PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "Data Mine2";
                    ApplicationArea = All;
                }
                action("Bank Ledger Entry")
                {
                    Image = Ledger;
                    Promoted = true;
                    //PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page BankLegerEntry;
                    ApplicationArea = All;
                }

                action("g/l enrty Update")
                {
                    Image = Ledger;
                    Promoted = true;
                    //PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = report updateGl;
                    ApplicationArea = All;
                }
                action("Bank Entry Update")
                {
                    Image = Ledger;
                    Promoted = true;
                    //PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = report updateBankEntry;
                    ApplicationArea = All;
                }

                action("UpdateEntry2")
                {
                    Caption = 'Buffer Page 1';
                    Image = Ledger;
                    Promoted = true;
                    //PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = page "Buffer Page";
                    ApplicationArea = All;
                }
                action("UpdateEntry3")
                {
                    Caption = 'Buffer Page 2';
                    Image = Ledger;
                    Promoted = true;
                    //PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = page "Buffer Page2";
                    ApplicationArea = All;
                }
                action("Update Bank Trans")
                {
                    Image = Ledger;
                    Promoted = true;
                    //PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = report "Update bankEntry2";
                    ApplicationArea = All;
                }
                action("Update GlAccount on Entry")
                {
                    Image = Ledger;
                    Promoted = true;
                    //PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = report updateBankEntry;
                    ApplicationArea = All;
                }
                action(identifytrans)
                {
                    Image = Ledger;
                    Promoted = true;
                    //PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = report updateTrans;
                    ApplicationArea = All;
                }
                action(rename)
                {
                    Image = Ledger;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = report updateGlacc;
                    ApplicationArea = All;
                }
                action("bank enrty")
                {
                    Image = Ledger;
                    Promoted = true;
                    //PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "Data Mine3";
                    ApplicationArea = All;
                }
                action("CustTest")
                {
                    Image = Ledger;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "tEST Data";
                    ApplicationArea = All;
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

    procedure UpdateUBB()
    var
        unitBased: Record unitBasedstud;
        CourseReg: Record "ACA-Course Registration";
    begin
        CourseReg.Reset();
        CourseReg.SetRange(Semester, 'JAN-APR23');
        //CourseReg.SetRange(CourseReg."Student No.", CourseReg."Student No.");

        if CourseReg.FIND('-') Then begin
            repeat
                unitBased.Reset;
                unitBased.SetRange(StudNo, CourseReg."Student No.");
                if unitBased.Find('-') then begin
                    CourseReg."Settlement Type" := unitBased.settlementType;
                    CourseReg.RENAME(CourseReg."Reg. Transacton ID", CourseReg."Student No.", CourseReg.Programmes, CourseReg.Semester, CourseReg."Register for"::"Unit/Subject", CourseReg.Stage, CourseReg."Student Type", 0);
                    //CourseReg."Register for" := CourseReg."Register for"::"Unit/Subject";
                    CourseReg.Modify();
                end;



            until CourseReg.Next() = 0;

        end;
    end;

    procedure billSupp()
    var
        supps: Record "Aca-Special Exams Details";
    begin
        supps.Reset();
        supps.SetRange(Catogory, supps.Catogory::Supplementary);
        supps.SetRange("Charge Posted", false);
        if supps.Find('-') then begin
            repeat
                supps.Validate("Unit Code");

            until supps.Next = 0;
        end;
    end;

    procedure updateMaxUnits()
    var
        prog: Record "ACA-Programme";
    begin
        prog.Reset();
        prog.SetRange("Program Status", prog."Program Status"::Active);
        if prog.Find('-') then begin
            repeat
                prog."Maximum No of Units" := 7;
                prog.Modify();
            until prog.Next() = 0;
        end;
    end;

    procedure updateItems()
    var
        items: Record Item;
        itemledgers: Record "Item Ledger Entry";
    begin
        itemledgers.Reset();
        itemledgers.SetRange("Item No.", '9816');
        if itemledgers.find('-') then begin
            repeat
                itemledgers."Unit of Measure Code" := 'PKT';
                itemledgers.Modify();
            until itemledgers.Next() = 0;
        end;

        items.Reset();
        items.SetRange("No.", '9816');
        if items.Find('-') then begin
            items."Base Unit of Measure" := 'PKT';
            items.Modify();
        end;
    end;

}

