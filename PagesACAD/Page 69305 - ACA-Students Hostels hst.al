page 69305 "ACA-Students Hostels hst"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = Document;
    SourceTable = Customer;
    SourceTableView = WHERE("Customer Type" = CONST(Student));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = true;
                field("No."; Rec."No.")
                {
                    Caption = 'No.(*)';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("ID No"; Rec."ID No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Date Registered"; Rec."Date Registered")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Hostel Black Listed"; Rec."Hostel Black Listed")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Black Listed Reason"; Rec."Black Listed Reason")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Debit Amount (LCY)"; Rec."Debit Amount (LCY)")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Credit Amount (LCY)"; Rec."Credit Amount (LCY)")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
                        CustLedgEntry: Record "Cust. Ledger Entry";
                    begin
                        DtldCustLedgEntry.SETRANGE("Customer No.", Rec."No.");
                        Rec.COPYFILTER("Global Dimension 1 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 1");
                        Rec.COPYFILTER("Global Dimension 2 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 2");
                        Rec.COPYFILTER("Currency Filter", DtldCustLedgEntry."Currency Code");
                        CustLedgEntry.DrillDownOnEntries(DtldCustLedgEntry);
                    end;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Picture; Rec.Image)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            part(AcaRoom; 69303)
            {
                SubPageLink = Student = FIELD("No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Student)
            {
                Caption = 'Student';
                action("Black List Student")
                {
                    Caption = 'Black List Student';
                    Image = Archive;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Do you really want Black List Student?') THEN BEGIN
                            Rec.TESTFIELD("Black Listed Reason");
                            Rec."Hostel Black Listed" := TRUE;
                            Rec."Black Listed By" := USERID;
                            Rec.MODIFY;
                        END;
                    end;
                }
                separator(_____________)
                {
                }
                action("Revoke Student BlackList")
                {
                    Caption = 'Revoke Student BlackList';
                    Image = ReverseLines;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Do you really want Revoke Black List Student?') THEN BEGIN
                            Rec.TESTFIELD("Hostel Black Listed", TRUE);
                            Rec."Hostel Black Listed" := FALSE;
                            Rec."Black Listed By" := USERID;
                            Rec.MODIFY;
                        END;
                    end;
                }

            }
        }
        area(processing)
        {
            action("PostCharges")
            {
                Caption = 'Post Charges';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Do You Really Want to Post The Room Charges') THEN BEGIN
                        StudentHostel.RESET;
                        StudentHostel.SETRANGE(StudentHostel.Student, Rec."No.");
                        StudentHostel.SETRANGE(StudentHostel.Billed, FALSE);
                        IF StudentHostel.FIND('-') THEN BEGIN
                            REPEAT
                                ;
                                StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                                StudentCharges.INIT;
                                StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                                StudentCharges."Student No." := Rec."No.";
                                StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::Charges;
                                StudentCharges.Description := 'Hostel Charges ' + StudentHostel."Space No";
                                StudentCharges.Amount := StudentHostel."Accomodation Fee";
                                StudentCharges.Date := StudentHostel."Allocation Date";
                                StudentCharges.INSERT(TRUE);
                                StudentHostel.Billed := TRUE;
                                StudentHostel."Billed Date" := TODAY;
                                StudentHostel.MODIFY;
                            UNTIL StudentHostel.NEXT = 0;
                        END;
                        MESSAGE('Hostel Charges Posted Successfully');
                    END;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS("Total Billed", "Total Paid");
        CurrentBill := Rec."Total Billed" - Rec."Total Paid";
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Customer Type" := Rec."Customer Type"::Student;
        Rec."Date Registered" := TODAY;
    end;

    var
        PictureExists: Boolean;
        StudentPayments: Record "ACA-Std Payments";

        GenJnlLine: Record "Gen. Journal Line";
        Stages: Record "ACA-Programme Stages";
        Units: Record "ACA-Units/Subjects";
        ExamsByStage: Record "ACA-Exams";
        ExamsByUnit: Record "ACA-Exams By Units";
        Charges: Record "ACA-Charge";
        Receipt: Record "ACA-Receipt";
        ReceiptItems: Record "ACA-Receipt Items";
        GenSetUp: Record "ACA-General Set-Up";
        StudentCharges2: Record "ACA-Std Charges";
        CourseReg: Record "ACA-Course Registration";
        CurrentBill: Decimal;
        GLEntry: Record "G/L Entry";

        CustLed: Record "Cust. Ledger Entry";

        DCustLedg: Record "Detailed Cust. Ledg. Entry";
        PDate: Date;
        DocNo: Code[20];
        VendLedg: Record "Vendor Ledger Entry";
        DVendLedg: Record "Detailed Vendor Ledg. Entry";
        VATEntry: Record "VAT Entry";
        CReg: Record "ACA-Course Registration";
        StudCharges: Record "ACA-Std Charges";
        CustLed2: Record "Cust. Ledger Entry";
        Receipt2: Record "ACA-Receipt";
        Cont: Boolean;
        Cust: Record Customer;
        CustPostGroup: Record "Customer Posting Group";

        window: Dialog;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Receipts: Record "ACA-Receipt";
        CustLedg: Record "Cust. Ledger Entry";
        DueDate: Date;
        Sems: Record "ACA-Semesters";
        ChangeLog: Record "Change Log Entry";

        StudentHostel: Record "ACA-Students Hostel Rooms";
        StudentCharges: Record "ACA-Std Charges";
        //Rooms: Record "61163";
        LineNo: Integer;
        StudentHostel2: Record "ACA-Students Hostel Rooms";

    procedure "Post Charges"()
    begin
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", 'PAYMENTS');
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", 'CHARGES');
        IF GenJnlLine.FIND('-') THEN BEGIN
            GenJnlLine.DELETEALL
        END;

        StudentHostel.RESET;
        StudentHostel.SETRANGE(StudentHostel.Student, Rec."No.");
        StudentHostel.SETRANGE(StudentHostel.Cleared, FALSE);
        IF StudentHostel.FIND('-') THEN BEGIN
            REPEAT
                StudentHostel.TESTFIELD(StudentHostel.Semester);
                StudentHostel.TESTFIELD(StudentHostel."Space No");
                IF StudentHostel.Charges > 0 THEN BEGIN
                    LineNo := LineNo + 1000;
                    GenJnlLine.INIT;
                    GenJnlLine."Journal Template Name" := 'PAYMENTS';
                    GenJnlLine."Journal Batch Name" := 'CHARGES';
                    GenJnlLine."Line No." := LineNo;
                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
                    GenJnlLine."Account No." := Rec."No.";
                    GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                    GenJnlLine."Posting Date" := TODAY;
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::Invoice;
                    GenJnlLine."Document No." := StudentHostel."Space No" + ' ' + StudentHostel."Room No";
                    //GenJnlLine."External Document No.":="Cheque No";
                    GenJnlLine.Amount := StudentHostel.Charges;
                    GenJnlLine.VALIDATE(GenJnlLine.Amount);
                    GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                    GenJnlLine."Bal. Account No." := '300007';
                    GenJnlLine.Description := Rec.Name;
                    GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                    GenJnlLine."Shortcut Dimension 1 Code" := 'ACADEMIC';
                    //GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                    //GenJnlLine."Document No.":="Doc No";
                    IF GenJnlLine.Amount <> 0 THEN
                        GenJnlLine.INSERT;
                END;
            UNTIL StudentHostel.NEXT = 0;
        END;

        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", 'PAYMENTS');
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", 'CHARGES');
        IF GenJnlLine.FIND('-') THEN BEGIN
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
        END;
    end;
}

