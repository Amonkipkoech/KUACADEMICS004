page 69167 "ACA-Std Hostel Header Clear"
{
    Editable = true;
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
                Editable = false;
                field("No."; Rec."No.")
                {
                    Caption = 'No.(*)';
                    ApplicationArea = All;
                }
                field("Old Student Code"; Rec."Old Student Code")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = All;
                }
                field("Date Registered"; Rec."Date Registered")
                {
                    ApplicationArea = All;
                }
                field("Payments By"; Rec."Payments By")
                {
                    ApplicationArea = All;
                }
                field("Membership No"; Rec."Membership No")
                {
                    ApplicationArea = All;
                }
                field(Citizenship; Rec.Citizenship)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Hostel Black Listed"; Rec."Hostel Black Listed")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = All;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;
                }
                field(Religion; Rec.Religion)
                {
                    ApplicationArea = All;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    Caption = 'Posting Group';
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
                field("Debit Amount (LCY)"; Rec."Debit Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Credit Amount (LCY)"; Rec."Credit Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
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
                field("HELB No."; Rec."HELB No.")
                {
                    ApplicationArea = All;
                }
                field(Picture; Rec.Image)
                {
                    ApplicationArea = All;
                }
            }
            group("Contact Details")
            {
                Caption = 'Contact Details';
                Editable = false;
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Telex No."; Rec."Telex No.")
                {
                    ApplicationArea = All;
                }
                field("Fax No."; Rec."Fax No.")
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
            action("Clear Student Room")
            {
                Caption = 'Clear Student Room';
                Image = "Action";
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.TESTFIELD("Hostel Black Listed", FALSE);
                    "Book Room"();
                end;
            }
            action("Student Room")
            {
                Caption = 'Student Room';
                Image = List;
                Promoted = true;
                RunObject = Page 69168;
                RunPageLink = Student = FIELD("No.");
                ApplicationArea = All;
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
        AccPayment: Boolean;
        courseReg1: Record "ACA-Course Registration";
        charges1: Record "ACA-Charge";
        cou: Integer;
        studRoomBlock: Record "ACA-Students Hostel Rooms";
        Blocks: Record "ACA-Hostel Card";
        coReg: Record "ACA-Course Registration";
        HostelLedger: Record "ACA-Hostel Ledger";
        Sem: Record "ACA-Semesters";
        Registered: Boolean;
        acadYear: Record "ACA-Academic Year";
        semz: Record "ACA-Semesters";
        PictureExists: Boolean;
        StudentPayments: Record "ACA-Std Payments";
        StudentCharge: Record "ACA-Std Charges";
        GenJnl: Record "Gen. Journal Line";
        Stages: Record "ACA-Programme Stages";
        LineNo: Integer;
        GenJnlLine: Record "Gen. Journal Line";
        Units: Record "ACA-Units/Subjects";
        ExamsByStage: Record "ACA-Exams";
        ExamsByUnit: Record "ACA-Exams By Units";

        Charges: Record "ACA-Charge";
        ChargesRec: Record "ACA-Charge";
        PaidAmt: Decimal;
        Receipt: Record "ACA-Receipt";
        NoRoom: Integer;
        ReceiptItems: Record "ACA-Receipt Items";
        "GenSetUp.": Record "ACA-General Set-Up";
        StudentCharges2: Record "ACA-Std Charges";

        CourseReg: Record "ACA-Course Registration";
        CurrentBill: Decimal;
        GLEntry: Record "G/L Entry";
        CustLed: Record "Cust. Ledger Entry";
        BankLedg: Record "Bank Account Ledger Entry";
        DCustLedg: Record "Detailed Cust. Ledg. Entry";

        PDate: Date;
        DocNo: Code[20];
        VendLedg: Record "Vendor Ledger Entry";
        DVendLedg: Record "Detailed Vendor Ledg. Entry";
        NoSeries: Record "No. Series Line";
        VATEntry: Record "VAT Entry";

        CReg: Record "ACA-Course Registration";
        StudCharges: Record "ACA-Std Charges";
        CustLed2: Record "Cust. Ledger Entry";
        Receipt2: Record "ACA-Receipt";

        Cont: Boolean;
        LastNo: Code[20];
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
        StudentHostel2: Record "ACA-Students Hostel Rooms";
        StudentCharges: Record "ACA-Std Charges";
        GenSetUp: Record "ACA-General Set-Up";
        Rooms_Spaces: Record "ACA-Room Spaces";
        Hostel_Rooms: Record "ACA-Hostel Block Rooms";
        Host_Ledger: Record "ACA-Hostel Ledger";

        counts: Integer;

    procedure "Book Room"()
    begin
        // --------Check If More Than One Room Has Been Selected


        StudentHostel.RESET;
        NoRoom := 0;
        StudentHostel.SETRANGE(StudentHostel.Student, Rec."No.");
        StudentHostel.SETRANGE(StudentHostel.Billed, FALSE);
        StudentHostel.SETFILTER(StudentHostel."Space No", '<>%1', '');
        IF StudentHostel.FIND('-') THEN BEGIN
            REPEAT
                // Get the Hostel Name
                StudentHostel.TESTFIELD(StudentHostel.Semester);
                StudentHostel.TESTFIELD(StudentHostel."Academic Year");
                StudentHostel.TESTFIELD(StudentHostel."Space No");
                NoRoom := NoRoom + 1;
                IF NoRoom > 1 THEN BEGIN
                    ERROR('Please Note That You Can Not Select More Than One Room')
                END;
                // check if the room is still vacant
                Rooms_Spaces.RESET;
                Rooms_Spaces.SETRANGE(Rooms_Spaces."Space Code", StudentHostel."Space No");
                Rooms_Spaces.SETRANGE(Rooms_Spaces."Room Code", StudentHostel."Room No");
                Rooms_Spaces.SETRANGE(Rooms_Spaces."Hostel Code", StudentHostel."Hostel No");
                IF Rooms_Spaces.FIND('-') THEN
                    IF Rooms_Spaces.Status <> Rooms_Spaces.Status::Vaccant THEN ERROR('The selected room is nolonger vacant');

                // ----------Check If He has UnCleared Room
                StudentHostel.RESET;
                StudentHostel.SETRANGE(StudentHostel.Student, Rec."No.");
                StudentHostel.SETRANGE(StudentHostel.Cleared, FALSE);
                IF StudentHostel.FIND('-') THEN BEGIN
                    IF StudentHostel.COUNT > 1 THEN BEGIN
                        ERROR('Please Note That You Must First Clear Your Old Rooms Before You Book Another Room')
                    END;
                END;
                //---Check if The Student Have Paid The Accomodation Fee
                StudentCharges.RESET;
                StudentCharges.SETRANGE(StudentCharges."Student No.", StudentHostel.Student);
                StudentCharges.SETRANGE(StudentCharges.Semester, StudentHostel.Semester);
                StudentCharges.SETRANGE(Posted, TRUE);
                IF StudentCharges.FIND('-') THEN BEGIN
                    ChargesRec.SETRANGE(ChargesRec.Code, StudentCharges.Code);
                    IF ChargesRec.FIND('-') THEN BEGIN
                        PaidAmt := ChargesRec.Amount
                    END;
                END;
                IF PaidAmt > StudentHostel."Accomodation Fee" THEN BEGIN
                    StudentHostel."Over Paid" := TRUE;
                    StudentHostel."Over Paid Amt" := PaidAmt - StudentHostel."Accomodation Fee";
                    StudentHostel.MODIFY;
                    /*
                     END ELSE BEGIN
                       IF PaidAmt<>StudentHostel."Accomodation Fee" THEN BEGIN

                        ERROR('Accomodation Fee Paid Can Not Book This Room The Paid Amount is '+FORMAT(PaidAmt))
                       END;
                       */
                END;


                Rooms_Spaces.RESET;
                Rooms_Spaces.SETRANGE(Rooms_Spaces."Space Code", StudentHostel."Space No");
                IF Rooms_Spaces.FIND('-') THEN BEGIN
                    Rooms_Spaces.Status := Rooms_Spaces.Status::"Fully Occupied";
                    Rooms_Spaces.MODIFY;
                    CLEAR(counts);
                    // Post to  the Ledger Tables
                    Host_Ledger.RESET;
                    IF Host_Ledger.FIND('-') THEN counts := Host_Ledger.COUNT;
                    Host_Ledger.INIT;
                    Host_Ledger."Space No" := StudentHostel."Space No";
                    Host_Ledger."Room No" := StudentHostel."Room No";
                    Host_Ledger."Hostel No" := StudentHostel."Hostel No";
                    Host_Ledger.No := counts;
                    Host_Ledger.Status := Host_Ledger.Status::"Fully Occupied";
                    Host_Ledger."Room Cost" := StudentHostel.Charges;
                    Host_Ledger."Student No" := StudentHostel.Student;
                    Host_Ledger."Receipt No" := '';
                    Host_Ledger.Semester := StudentHostel.Semester;
                    Host_Ledger.Gender := Rec.Gender;
                    Host_Ledger."Hostel Name" := '';
                    Host_Ledger.Campus := Rec."Global Dimension 1 Code";
                    Host_Ledger."Academic Year" := StudentHostel."Academic Year";
                    Host_Ledger.INSERT(TRUE);


                    Hostel_Rooms.RESET;
                    Hostel_Rooms.SETRANGE(Hostel_Rooms."Hostel Code", StudentHostel."Hostel No");
                    Hostel_Rooms.SETRANGE(Hostel_Rooms."Room Code", StudentHostel."Room No");
                    IF Hostel_Rooms.FIND('-') THEN BEGIN
                        Hostel_Rooms.CALCFIELDS(Hostel_Rooms."Bed Spaces", Hostel_Rooms."Occupied Spaces");
                        IF Hostel_Rooms."Bed Spaces" = Hostel_Rooms."Occupied Spaces" THEN
                            Hostel_Rooms.Status := Hostel_Rooms.Status::"Fully Occupied"
                        ELSE
                            IF Hostel_Rooms."Occupied Spaces" < Hostel_Rooms."Bed Spaces" THEN
                                Hostel_Rooms.Status := Hostel_Rooms.Status::"Partially Occupied";
                        Hostel_Rooms.MODIFY;
                    END;

                    StudentHostel.Billed := TRUE;
                    StudentHostel."Billed Date" := TODAY;
                    StudentHostel."Allocation Date" := TODAY;
                    StudentHostel.Allocated := TRUE;
                    StudentHostel.MODIFY;


                END;
            //  IF StudentHostel."Over Paid" THEN BEGIN
            //    PostOverPayment();
            // END;
            UNTIL StudentHostel.NEXT = 0;
            MESSAGE('Room Booked Successfully');
        END;

    end;

    procedure PostOverPayment()
    begin
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", 'PAYMENTs');
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
                //IF StudentHostel.Charges>0 THEN BEGIN
                LineNo := LineNo + 1000;
                GenJnlLine.INIT;
                GenJnlLine."Journal Template Name" := 'PAYMENTs';
                GenJnlLine."Journal Batch Name" := 'CHARGES';
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
                GenJnlLine."Account No." := Rec."No.";
                GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                GenJnlLine."Posting Date" := TODAY;
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine."Document No." := StudentHostel."Space No" + ' ' + StudentHostel."Room No";
                //GenJnlLine."External Document No.":="Cheque No";
                GenJnlLine.Amount := -StudentHostel."Over Paid Amt";
                GenJnlLine.VALIDATE(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '300202';
                GenJnlLine.Description := Rec.Name;
                GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := 'ACADEMIC';
                //GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                //GenJnlLine."Document No.":="Doc No";
                IF GenJnlLine.Amount <> 0 THEN
                    GenJnlLine.INSERT;
            //END;
            UNTIL StudentHostel.NEXT = 0;
        END;
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", 'PAYMENTs');
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", 'CHARGES');
        IF GenJnlLine.FIND('-') THEN BEGIN
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
        END;
    end;

    procedure CheckClearence()
    begin
    end;

    procedure GetCurrentYear() currYear: Code[20]
    begin
        acadYear.RESET;
        acadYear.SETRANGE(acadYear.Current, TRUE);
        IF acadYear.FIND('-') THEN BEGIN
            currYear := acadYear.Code;
        END;
    end;

    procedure GetCurrsEM() currsem: Code[20]
    begin
        semz.RESET;
        semz.SETRANGE(semz."Current Semester", TRUE);
        IF semz.FIND('-') THEN BEGIN
            currsem := semz.Code;
        END;
    end;
}

