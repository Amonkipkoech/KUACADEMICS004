page 69303 "ACA-Stud. Hostel Rooms hst"
{
    PageType = ListPart;
    SourceTable = "ACA-Students Hostel Rooms";
    SourceTableView = WHERE(Cleared = CONST(true));

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("Hostel No"; Rec."Hostel No")
                {
                    ApplicationArea = All;
                }
                field("Room No"; Rec."Room No")
                {
                    ApplicationArea = All;
                }
                field("Space No"; Rec."Space No")
                {
                    ApplicationArea = All;
                }
                field(Charges; Rec.Charges)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Allocation Date"; Rec."Allocation Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Cleared; Rec.Cleared)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Allocated; Rec.Allocated)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Hostel Name"; Rec."Hostel Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Campus Code"; Rec."Campus Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Allocate)
            {
                Caption = 'Allocate Room';
                Image = "Action";
                
                
                
                Visible = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //Check the Policy
                    Rec.TESTFIELD(Allocated, FALSE);
                    IF Cust.GET(Rec.Student) THEN BEGIN
                        Cust.CALCFIELDS(Cust.Balance);
                        IF "GenSetUp.".GET() THEN BEGIN END;

                        semz.RESET;
                        semz.SETRANGE(semz."Current Semester", TRUE);
                        CReg.RESET;
                        CReg.SETRANGE(CReg."Student No.", Cust."No.");
                        IF semz.FIND('-') THEN
                            CReg.SETRANGE(CReg.Semester, semz.Code);
                        CReg.SETRANGE(CReg.Posted, TRUE);
                        IF CReg.FIND('-') THEN BEGIN  //2
                            CReg.CALCFIELDS(CReg."Total Billed");
                            IF CReg."Total Billed" <> 0 THEN BEGIN  // 1
                                                                    // IF Cust.Balance>(CReg."Total Billed"/2) THEN ERROR('Fees payment Accommodation policy error--Balance');
                                allocations.RESET;
                                allocations.SETRANGE(allocations.Student, Cust."No.");
                                allocations.SETRANGE(allocations."Hostel No", Rec."Hostel No");
                                allocations.SETRANGE(allocations."Room No", Rec."Room No");
                                allocations.SETRANGE(allocations."Space No", Rec."Space No");
                                //allocations.SETRANGE(allocations."Academic Year","Academic Year");
                                allocations.SETRANGE(allocations.Semester, CReg.Semester);
                                IF allocations.FIND('-') THEN BEGIN
                                    IF ((Cust.Balance) > ((("GenSetUp."."% of Accomodation" / 100) * Rec.Charges) +
                                      (("GenSetUp."."% of Billed Fees/Balance" / 100) * CReg."Total Billed"))) THEN BEGIN
                                        // ERROR('FAIL:\Hostel Allocation policy Fails. Less amount Paid.')
                                    END;
                                END;
                                // END ELSE BEGIN  //1
                                // ERROR('FAIL:\The Student to Visit the Finance department for more advice.');
                            END; //1
                        END ELSE BEGIN //2
                            ERROR('FAIL:\Student not registered for the current Semester.');
                        END; //2
                    END;

                    CLEAR(settlementType);
                    Cust.RESET;
                    Cust.SETRANGE(Cust."No.", Rec.Student);
                    IF Cust.FIND('-') THEN
                        IF Cust."Hostel Black Listed" = FALSE THEN BEGIN
                            IF CONFIRM('Allocate the Specified Room?', TRUE) = FALSE THEN ERROR('Cancelled by user!');
                            Creg1.RESET;
                            Creg1.SETRANGE(Creg1."Student No.", Rec.Student);
                            Creg1.SETRANGE(Creg1.Semester, Rec.Semester);
                            //  Creg1.SETRANGE(Creg1."Academic Year","Academic Year");
                            IF Creg1.FIND('-') THEN BEGIN
                                // Check if Prog is Special
                                IF prog.GET(Creg1.Programmes) THEN BEGIN
                                    IF prog."Special Programme" THEN
                                        settlementType := settlementType::"Special Programme"
                                    ELSE
                                        IF Creg1."Settlement Type" = 'KUCCPS' THEN
                                            settlementType := settlementType::JAB
                                        ELSE
                                            IF Creg1."Settlement Type" = 'PSSP' THEN settlementType := settlementType::SSP;
                                END;

                            END;

                            "Book Room"(settlementType);
                            // Assign Items
                            hostcard.RESET;
                            hostcard.SETRANGE(hostcard."Asset No", Rec."Hostel No");
                            IF hostcard.FIND('-') THEN BEGIN
                                invItems.RESET;
                                IF hostcard.Gender = hostcard.Gender::Male THEN
                                    invItems.SETFILTER(invItems."Hostel Gender", '%1|%2', 1, 2);
                                IF invItems.FIND('-') THEN BEGIN
                                    studItemInv.RESET;
                                    studItemInv.SETRANGE(studItemInv."Student No.", Rec.Student);
                                    // studItemInv.SETRANGE(studItemInv."Academic Year","Academic Year");
                                    studItemInv.SETRANGE(studItemInv.Semester, Rec.Semester);
                                    IF studItemInv.FIND('-') THEN studItemInv.DELETEALL;
                                    REPEAT
                                    BEGIN
                                        studItemInv.INIT;
                                        studItemInv."Hostel Block" := Rec."Hostel No";
                                        studItemInv."Room Code" := Rec."Room No";
                                        studItemInv."Space Code" := Rec."Space No";
                                        studItemInv."Item Code" := invItems.Item;
                                        studItemInv."Academic Year" := Rec."Academic Year";
                                        studItemInv.Semester := Rec.Semester;
                                        studItemInv.Quantity := invItems."Quantity Per Room";
                                        studItemInv."Fine Amount" := invItems."Fine Amount";
                                        studItemInv.INSERT(TRUE);
                                    END;
                                    UNTIL invItems.NEXT = 0;
                                END;
                            END;
                        END ELSE BEGIN
                            MESSAGE('The student' + ' ' + Rec.Student + ' ' + 'has been blacklisted!');
                        END;
                end;
            }
            action("Print Invoice")
            {
                Caption = 'Print Invoice';
                Image = Invoice;
                
                
                ApplicationArea = All;

                trigger OnAction()
                begin
                    /* IF Cust.GET(Student) THEN BEGIN
                     WITH Cust DO BEGIN
                       CALCFIELDS(Balance);
                     CReg.RESET;
                     CReg.SETRANGE(CReg."Student No.",Student);
                     CReg.SETRANGE(CReg.Semester,Semester);
                     CReg.SETRANGE(CReg.Posted,TRUE);
                     IF CReg.FIND('-') THEN BEGIN
                     CReg.CALCFIELDS(CReg."Total Billed");
                     IF CReg."Total Billed"<>0 THEN BEGIN
                     IF Balance>(CReg."Total Billed"/2) THEN ERROR('Fees payment Accommodation policy error--Balance');    */
                    allocations.RESET;
                    allocations.SETRANGE(allocations.Student, Rec.Student);
                    allocations.SETRANGE(allocations."Hostel No", Rec."Hostel No");
                    allocations.SETRANGE(allocations."Room No", Rec."Room No");
                    allocations.SETRANGE(allocations."Space No", Rec."Space No");
                    //  allocations.SETRANGE(allocations."Academic Year","Academic Year");
                    allocations.SETRANGE(allocations.Semester, Rec.Semester);
                    IF allocations.FIND('-') THEN
                        REPORT.RUN(51795, TRUE, FALSE, allocations);
                    /* END ELSE BEGIN
                     ERROR('Fees payment Accommodation policy error --Billing');
                     END;
                     END ELSE BEGIN
                     ERROR('Fees payment Accommodation policy error --Registration');
                     END;
                     END;
                     END;*/

                end;
            }
            action("Print Agreement")
            {
                Caption = 'Print Agreement';
                
                
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CReg.RESET;
                    CReg.SETFILTER(CReg."Student No.", Rec.Student);
                    CReg.SETFILTER(CReg.Semester, Rec.Semester);
                    IF CReg.FIND('-') THEN
                        REPORT.RUN(39005953, TRUE, TRUE, CReg);
                end;
            }
            action("Inventroy Items")
            {
                Caption = 'Inventroy Items';
                Image = InventoryJournal;
                
                
                RunObject = Page "ACA-Std Hostel Inventory Items";
                RunPageLink = "Student No." = FIELD(Student),
                             "Hostel Block" = FIELD("Hostel No"),
                              "Room Code" = FIELD("Room No"),
                              "Space Code" = FIELD("Space No"),
                              "Academic Year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester);
                ApplicationArea = All;
            }
            action("Book Batch")
            {
                Caption = 'Book Batch';
                Image = PostBatch;
                
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    studRoomBlock.RESET;
                    studRoomBlock.SETFILTER(studRoomBlock.Student, '<>%1', '');
                    studRoomBlock.SETFILTER(studRoomBlock."Hostel No", '<>%1', '');
                    studRoomBlock.SETFILTER(studRoomBlock."Room No", '<>%1', '');
                    studRoomBlock.SETFILTER(studRoomBlock."Space No", '<>%1', '');
                    studRoomBlock.SETFILTER(studRoomBlock.Semester, '<>%1', '');
                    studRoomBlock.SETFILTER(studRoomBlock."Academic Year", '<>%1', '');
                    IF studRoomBlock.FIND('-') THEN BEGIN
                        REPEAT
                            cou := cou + 1;
                            //////////////////////////////////////////////////////////////////////////////////////////////////////////
                            Cust.RESET;
                            Cust.SETRANGE(Cust."No.", studRoomBlock.Student);
                            IF Cust.FIND('-') THEN BEGIN
                            END;

                            StudentHostel.RESET;
                            NoRoom := 0;
                            StudentHostel.SETRANGE(StudentHostel.Student, Cust."No.");
                            // StudentHostel.SETRANGE(StudentHostel.Billed,FALSE);
                            StudentHostel.SETFILTER(StudentHostel."Space No", '<>%1', '');
                            IF StudentHostel.FIND('-') THEN BEGIN
                                REPEAT
                                    // Get the Hostel Name
                                    //StudentHostel.TESTFIELD(StudentHostel.Semester);
                                    // StudentHostel.TESTFIELD(StudentHostel."Academic Year");
                                    // StudentHostel.TESTFIELD(StudentHostel."Space No");
                                    NoRoom := NoRoom + 1;
                                    IF NoRoom > 1 THEN BEGIN
                                        //   ERROR('Please Note That You Can Not Select More Than One Room')
                                    END;
                                    // check if the room is still vacant
                                    Rooms_Spaces.RESET;
                                    Rooms_Spaces.SETRANGE(Rooms_Spaces."Space Code", StudentHostel."Space No");
                                    Rooms_Spaces.SETRANGE(Rooms_Spaces."Room Code", StudentHostel."Room No");
                                    Rooms_Spaces.SETRANGE(Rooms_Spaces."Hostel Code", StudentHostel."Hostel No");
                                    IF Rooms_Spaces.FIND('-') THEN
                                        IF Rooms_Spaces.Status = Rooms_Spaces.Status::Vaccant THEN BEGIN
                                            ;//ERROR('The selected room is nolonger vacant');

                                            // ----------Check If He has UnCleared Room
                                            StudentHostel.RESET;
                                            StudentHostel.SETRANGE(StudentHostel.Student, Cust."No.");
                                            StudentHostel.SETRANGE(StudentHostel.Cleared, FALSE);
                                            IF StudentHostel.FIND('-') THEN BEGIN
                                                IF StudentHostel.COUNT > 1 THEN BEGIN
                                                    // EXIT;// ERROR('Please Note That You Must First Clear Your Old Rooms Before You Allocate Another Room')
                                                END;
                                            END;
                                            //---Check if The Student Have Paid The Accomodation Fee
                                            StudentCharges.RESET;
                                            StudentCharges.SETRANGE(StudentCharges."Student No.", studRoomBlock.Student);
                                            StudentCharges.SETRANGE(StudentCharges.Semester, studRoomBlock.Semester);
                                            StudentCharges.SETRANGE(StudentCharges.Code, 'ACCOMMODATION');
                                            //StudentCharges.SETRANGE(Posted,TRUE);
                                            /* IF StudentCharges.FIND('-') THEN BEGIN
                                               ChargesRec.SETRANGE(ChargesRec.Code,StudentCharges.Code);
                                               IF ChargesRec.FIND('-') THEN BEGIN
                                                 PaidAmt:=ChargesRec.Amount
                                               END;
                                             END; */

                                            IF NOT StudentCharges.FIND('-') THEN BEGIN
                                                coReg.RESET;
                                                coReg.SETRANGE(coReg."Student No.", studRoomBlock.Student);
                                                coReg.SETRANGE(coReg.Semester, studRoomBlock.Semester);
                                                coReg.SETRANGE(coReg."Academic Year", studRoomBlock."Academic Year");
                                                IF coReg.FIND('-') THEN BEGIN
                                                    StudentCharges.INIT;
                                                    StudentCharges."Transacton ID" := '';
                                                    StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                                                    StudentCharges."Student No." := coReg."Student No.";
                                                    StudentCharges."Reg. Transacton ID" := coReg."Reg. Transacton ID";
                                                    StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::Charges;
                                                    StudentCharges.Code := 'ACCOMMODATION';
                                                    StudentCharges.Description := 'Accommodation Fees';
                                                    IF Blocks.GET(studRoomBlock."Hostel No") THEN
                                                        StudentCharges.Amount := Blocks."Cost Per Occupant"
                                                    ELSE
                                                        StudentCharges.Amount := 0;
                                                    StudentCharges.Date := TODAY;
                                                    StudentCharges.Programme := coReg.Programmes;
                                                    StudentCharges.Stage := coReg.Stage;
                                                    StudentCharges.Semester := coReg.Semester;
                                                    StudentCharges.INSERT();
                                                END;
                                            END;

                                            IF PaidAmt > StudentHostel."Accomodation Fee" THEN BEGIN
                                                StudentHostel."Over Paid" := TRUE;
                                                StudentHostel."Over Paid Amt" := PaidAmt - StudentHostel."Accomodation Fee";
                                                StudentHostel.MODIFY;
                                                /*
                                                 END ELSE BEGIN
                                                   IF PaidAmt<>StudentHostel."Accomodation Fee" THEN BEGIN

                                                    ERROR('Accomodation Fee Paid Can Not Allocate This Room The Paid Amount is '+FORMAT(PaidAmt))
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
                                                Host_Ledger.Gender := studRoomBlock.Gender;
                                                Host_Ledger."Hostel Name" := '';
                                                Host_Ledger.Campus := Cust."Global Dimension 1 Code";
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
                                        END;
                                //  IF StudentHostel."Over Paid" THEN BEGIN
                                //    PostOverPayment();
                                // END;
                                UNTIL StudentHostel.NEXT = 0;
                                // MESSAGE('Room Allocateed Successfully');
                            END;

                        //////////////////////////////////////////////////////////////////////////////////////////////////////////
                        UNTIL studRoomBlock.NEXT = 0;
                    END;

                    //MESSAGE(FORMAT(cou));

                end;
            }
            action(Rev_Allocation)
            {
                Caption = 'Reverse Allocarion';
                Image = ReverseLines;
                
                
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.TESTFIELD(Cleared, FALSE);
                    Rec.TESTFIELD(Allocated, TRUE);
                    IF CONFIRM('Reverse allocation?', FALSE) = FALSE THEN ERROR('Cancelled!');
                    // Clear Room
                    clearFromRoom_Reversal();
                    // Post charge Reversal
                    postChargeReversal();
                end;
            }
            action(trans)
            {
                Caption = 'Transfer Student';
                Image = TransferOrder;
                
                
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF ((Rec.Allocated = FALSE) OR (Rec.Cleared = TRUE)) THEN ERROR('You can only transfer posted allocations');
                    hostStus.RESET;
                    hostStus.SETRANGE(hostStus."Hostel No", Rec."Hostel No");
                    hostStus.SETRANGE(hostStus."Room No", Rec."Room No");
                    hostStus.SETRANGE(hostStus."Space No", Rec."Space No");
                    hostStus.SETRANGE(hostStus.Student, Rec.Student);
                    hostStus.SETRANGE(hostStus.Semester, Rec.Semester);
                    hostStus.SETRANGE(hostStus."Academic Year", Rec."Academic Year");
                    IF hostStus.FIND('-') THEN BEGIN
                        PAGE.RUN(69173, hostStus);
                    END;
                end;
            }
            action(Switch_Rooms)
            {
                Caption = 'Switch Rooms';
                Image = TransferReceipt;
                
                
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF ((Rec.Allocated = FALSE) OR (Rec.Cleared = TRUE)) THEN ERROR('You can only Swap/Switch posted allocations');
                    hostStus.RESET;
                    hostStus.SETRANGE(hostStus."Hostel No", Rec."Hostel No");
                    hostStus.SETRANGE(hostStus."Room No", Rec."Room No");
                    hostStus.SETRANGE(hostStus."Space No", Rec."Space No");
                    hostStus.SETRANGE(hostStus.Student, Rec.Student);
                    hostStus.SETRANGE(hostStus.Semester, Rec.Semester);
                    //hostStus.SETRANGE(hostStus."Academic Year","Academic Year");
                    IF hostStus.FIND('-') THEN BEGIN
                        PAGE.RUN(69173, hostStus);
                    END;
                end;
            }
            action("Clear Room")
            {
                Caption = 'Clear Room';
                Image = New;
                
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin


                    //IF "Student No" = '' THEN
                    // ERROR('Select a student with a room space firsts.');

                    IF CONFIRM('Are you sure you want to clear this student from the Hostels?', FALSE) = FALSE THEN
                        EXIT;

                    MESSAGE('Ensure that all the facilities in the room are in a good condition before clearing the room!');
                    clearFromRoom();

                    MESSAGE('''' + Rec."Student Name" + ''' has been successfully cleared from ' + Rec."Hostel Name");
                    CurrPage.UPDATE
                end;
            }
        }
    }

    var
        AccPayment: Boolean;
        hostStus: Record "ACA-Students Hostel Rooms";
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
        StudentCharges: Record "ACA-Std Charges";
        GenSetUp: Record "ACA-General Set-Up";
        Rooms_Spaces: Record "ACA-Room Spaces";
        Hostel_Rooms: Record "ACA-Hostel Block Rooms";
        Host_Ledger: Record "ACA-Hostel Ledger";
        counts: Integer;
        hostcard: Record "ACA-Hostel Card";
        studItemInv: Record "ACA-Std Hostel Inventory Items";
        invItems: Record "ACA-Hostel Inventory";
        Hostel_Rooms2: Record "ACA-Hostel Block Rooms";
        settlementType: Option " ",JAB,SSP,"Special Programme";
        Creg1: Record "ACA-Course Registration";
        prog: Record "ACA-Programme";
        allocations: Record "ACA-Students Hostel Rooms";
        "Settlement TypeR": Record "ACA-Settlement Type";

    procedure PostOverPayment()
    begin
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", 'PAYMENTs');
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", 'CHARGES');
        IF GenJnlLine.FIND('-') THEN BEGIN
            GenJnlLine.DELETEALL
        END;

        StudentHostel.RESET;
        StudentHostel.SETRANGE(StudentHostel.Student, Cust."No.");
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
                GenJnlLine."Account No." := Cust."No.";
                GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                GenJnlLine."Posting Date" := TODAY;
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine."Document No." := COPYSTR((StudentHostel."Space No" + ' ' + StudentHostel."Room No"), 1, 20);
                //GenJnlLine."External Document No.":="Cheque No";
                GenJnlLine.Amount := -StudentHostel."Over Paid Amt";
                GenJnlLine.VALIDATE(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '300202';
                // GenJnlLine.Description:=Name;
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

    procedure clearFromRoom()
    var
        Rooms: Record "ACA-Hostel Block Rooms";
        spaces: Record "ACA-Room Spaces";
        hostLedger: Record "ACA-Hostel Ledger";
    begin
        hostLedger.RESET;
        hostLedger.SETRANGE(hostLedger."Hostel No", Rec."Hostel No");
        hostLedger.SETRANGE(hostLedger."Room No", Rec."Room No");
        hostLedger.SETRANGE(hostLedger."Space No", Rec."Space No");
        IF hostLedger.FIND('-') THEN BEGIN
            hostLedger.DELETEALL;
        END;


        studRoomBlock.RESET;
        studRoomBlock.SETRANGE(studRoomBlock.Student, Rec.Student);
        studRoomBlock.SETRANGE(studRoomBlock."Space No", Rec."Space No");
        IF studRoomBlock.FIND('-') THEN BEGIN
            studRoomBlock.Cleared := TRUE;
            studRoomBlock."Clearance Date" := TODAY;
            studRoomBlock."Eviction Code" := 'CLEARED';
            studRoomBlock."Hostel Assigned" := FALSE;
            studRoomBlock.Allocated := FALSE;
            studRoomBlock.MODIFY;
        END;



        spaces.RESET;
        spaces.SETRANGE(spaces."Hostel Code", Rec."Hostel No");
        spaces.SETRANGE(spaces."Room Code", Rec."Room No");
        spaces.SETRANGE(spaces."Space Code", Rec."Space No");
        IF spaces.FIND('-') THEN BEGIN
            spaces.Status := spaces.Status::Vaccant;
            spaces."Student No" := '';
            spaces."Receipt No" := '';
            spaces."Black List reason" := '';
            spaces.MODIFY;
        END;

        Rooms.RESET;
        Rooms.SETRANGE(Rooms."Hostel Code", Rec."Hostel No");
        Rooms.SETRANGE(Rooms."Room Code", Rec."Room No");
        IF Rooms.FIND('-') THEN BEGIN

            Rooms.VALIDATE(Rooms.Status);

        END;
    end;

    procedure "Book Room"(var settle_m: Option " ",KUCCPS,PSSP,"Special Programme")
    var
        rooms: Record "ACA-Hostel Block Rooms";
        billAmount: Decimal;
    begin
        // --------Check If More Than One Room Has Been Selected
        CLEAR(billAmount);
        rooms.RESET;
        rooms.SETRANGE(rooms."Hostel Code", Rec."Hostel No");
        rooms.SETRANGE(rooms."Room Code", Rec."Room No");
        IF rooms.FIND('-') THEN BEGIN
            IF settle_m = settle_m::"Special Programme" THEN
                billAmount := rooms."Special Programme"
            ELSE
                IF settle_m = settle_m::KUCCPS THEN
                    billAmount := rooms."JAB Fees"
                ELSE
                    IF settle_m = settle_m::PSSP THEN
                        billAmount := rooms."SSP Fees";
            IF billAmount = 0 THEN billAmount := rooms."JAB Fees";

        END;
        Cust.RESET;
        Cust.SETRANGE(Cust."No.", Rec.Student);
        IF Cust.FIND('-') THEN BEGIN
        END;

        StudentHostel.RESET;
        NoRoom := 0;
        StudentHostel.SETRANGE(StudentHostel.Student, Cust."No.");
        StudentHostel.SETRANGE(StudentHostel.Cleared, FALSE);
        StudentHostel.SETFILTER(StudentHostel."Space No", '<>%1', '');
        IF StudentHostel.FIND('-') THEN BEGIN

            REPEAT
                // Get the Hostel Name
                StudentHostel.TESTFIELD(StudentHostel.Semester);
                // StudentHostel.TESTFIELD(StudentHostel."Academic Year");
                StudentHostel.TESTFIELD(StudentHostel."Space No");
                NoRoom := NoRoom + 1;
                IF NoRoom > 1 THEN BEGIN
                    ERROR('Please Note That You Can Not Select More Than One Room')
                END;
                // check if the room is still vacant
                IF StudentHostel."Space No" = '' THEN BEGIN
                    Rooms_Spaces.RESET;
                    Rooms_Spaces.SETRANGE(Rooms_Spaces."Space Code", StudentHostel."Space No");
                    Rooms_Spaces.SETRANGE(Rooms_Spaces."Room Code", StudentHostel."Room No");
                    Rooms_Spaces.SETRANGE(Rooms_Spaces."Hostel Code", StudentHostel."Hostel No");
                    IF Rooms_Spaces.FIND('-') THEN
                        IF Rooms_Spaces.Status <> Rooms_Spaces.Status::Vaccant THEN
                            ERROR('The selected room is nolonger vacant.' + StudentHostel."Space No" + '-' + StudentHostel."Room No" + '-'
+ StudentHostel."Hostel No");
                END;
                /*
                 // ----------Check If He has UnCleared Room
                StudentHostel.RESET;
                StudentHostel.SETRANGE(StudentHostel.Student,Cust."No.");
                StudentHostel.SETRANGE(StudentHostel.Cleared,FALSE);
                IF StudentHostel.FIND('-') THEN BEGIN
                   IF StudentHostel.COUNT>1 THEN BEGIN
                     ERROR('Please Note That You Must First Clear Your Old Rooms Before You Allocate Another Room')
                   END;
                END;
                */
                //---Check if The Student Have Paid The Accomodation Fee
                charges1.RESET;
                charges1.SETRANGE(charges1.Hostel, TRUE);
                IF charges1.FIND('-') THEN BEGIN
                END ELSE
                    ERROR('Accommodation not setup.');

                StudentCharges.RESET;
                StudentCharges.SETRANGE(StudentCharges."Student No.", Rec.Student);
                StudentCharges.SETRANGE(StudentCharges.Semester, Rec.Semester);
                StudentCharges.SETRANGE(StudentCharges.Code, charges1.Code);
                //StudentCharges.SETRANGE(Posted,TRUE);
                /* IF StudentCharges.FIND('-') THEN BEGIN
                   ChargesRec.SETRANGE(ChargesRec.Code,StudentCharges.Code);
                   IF ChargesRec.FIND('-') THEN BEGIN
                     PaidAmt:=ChargesRec.Amount
                   END;
                 END; */
                IF Blocks.GET(Rec."Hostel No") THEN BEGIN
                END;

                IF NOT StudentCharges.FIND('-') THEN BEGIN
                    coReg.RESET;
                    coReg.SETRANGE(coReg."Student No.", Rec.Student);
                    coReg.SETRANGE(coReg.Semester, Rec.Semester);
                    //coReg.SETRANGE(coReg."Academic Year","Academic Year");
                    IF coReg.FIND('-') THEN BEGIN
                        StudentCharges.INIT;
                        StudentCharges."Transacton ID" := '';
                        StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                        StudentCharges."Student No." := coReg."Student No.";
                        StudentCharges."Reg. Transacton ID" := coReg."Reg. Transacton ID";
                        StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::Charges;
                        StudentCharges.Code := charges1.Code;
                        StudentCharges.Description := 'Accommodation Fees';
                        // IF Blocks.GET("Hostel No") THEN
                        // StudentCharges.Amount:=Blocks."Cost Per Occupant"
                        // ELSE
                        StudentCharges.Amount := billAmount;
                        StudentCharges.Date := TODAY;
                        StudentCharges.Programme := coReg.Programmes;
                        StudentCharges.Stage := coReg.Stage;
                        StudentCharges.Semester := coReg.Semester;
                        StudentCharges.INSERT();
                    END;
                END;

                IF PaidAmt > StudentHostel."Accomodation Fee" THEN BEGIN
                    StudentHostel."Over Paid" := TRUE;
                    StudentHostel."Over Paid Amt" := PaidAmt - StudentHostel."Accomodation Fee";
                    StudentHostel.MODIFY;
                    /*
                     END ELSE BEGIN
                       IF PaidAmt<>StudentHostel."Accomodation Fee" THEN BEGIN

                        ERROR('Accomodation Fee Paid Can Not Allocate This Room The Paid Amount is '+FORMAT(PaidAmt))
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
                    Host_Ledger."Space No" := Rec."Space No";
                    Host_Ledger."Room No" := Rec."Room No";
                    Host_Ledger."Hostel No" := Rec."Hostel No";
                    Host_Ledger.No := counts;
                    Host_Ledger.Status := Host_Ledger.Status::"Fully Occupied";
                    Host_Ledger."Room Cost" := StudentHostel.Charges;
                    Host_Ledger."Student No" := StudentHostel.Student;
                    Host_Ledger."Receipt No" := '';
                    Host_Ledger.Semester := StudentHostel.Semester;
                    Host_Ledger.Gender := Rec.Gender;
                    Host_Ledger."Hostel Name" := '';
                    Host_Ledger.Campus := Cust."Global Dimension 1 Code";
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

            UNTIL StudentHostel.NEXT = 0;

        END;

        postCharge();
        MESSAGE('Room Allocateed Successfully');

    end;

    local procedure postCharge()
    begin
        //BILLING
        charges1.RESET;
        charges1.SETRANGE(charges1.Hostel, TRUE);
        IF NOT charges1.FIND('-') THEN BEGIN
            ERROR('The charges Setup does not have an item tagged as Hostel.');
        END;

        AccPayment := FALSE;
        StudentCharges.RESET;
        StudentCharges.SETRANGE(StudentCharges."Student No.", Rec.Student);
        StudentCharges.SETRANGE(StudentCharges.Recognized, FALSE);
        StudentCharges.SETFILTER(StudentCharges.Code, '=%1', charges1.Code);
        IF NOT StudentCharges.FIND('-') THEN BEGIN //3
                                                   // The charge does not exist. Created it, but check first if it exists as unrecognized
            StudentCharges.RESET;
            StudentCharges.SETRANGE(StudentCharges."Student No.", Rec.Student);
            //StudentCharges.SETRANGE(StudentCharges.Recognized,FALSE);
            StudentCharges.SETFILTER(StudentCharges.Code, '=%1', charges1.Code);
            IF NOT StudentCharges.FIND('-') THEN BEGIN //4
                                                       // Does not exist hence just create
                CReg.RESET;
                CReg.SETRANGE(CReg."Student No.", Rec.Student);
                CReg.SETRANGE(CReg.Semester, Rec.Semester);
                IF CReg.FIND('-') THEN BEGIN //5
                    GenSetUp.GET();
                    IF GenSetUp.FIND('-') THEN BEGIN  //6
                        NoSeries.RESET;
                        NoSeries.SETRANGE(NoSeries."Series Code", GenSetUp."Transaction Nos.");
                        IF NoSeries.FIND('-') THEN BEGIN // 7
                            LastNo := NoSeries."Last No. Used"
                        END;  // 7
                    END; // 6
                         //message(LastNo);
                    LastNo := INCSTR(LastNo);
                    NoSeries."Last No. Used" := LastNo;
                    NoSeries.MODIFY;
                    StudentCharges.INIT();
                    StudentCharges."Transacton ID" := LastNo;
                    StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                    StudentCharges."Student No." := Rec.Student;
                    StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::Charges;
                    StudentCharges."Reg. Transacton ID" := CReg."Reg. Transacton ID";
                    StudentCharges.Description := 'Hostel Charges ' + Rec."Space No";
                    StudentCharges.Amount := Rec.Charges;
                    StudentCharges.Date := TODAY;
                    StudentCharges.Code := charges1.Code;
                    StudentCharges.Charge := TRUE;
                    StudentCharges.INSERT(TRUE);
                    Rec.Billed := TRUE;
                    Rec."Billed Date" := TODAY;
                    Rec.MODIFY;
                END; //5

            END ELSE BEGIN//4
                          // Charge Exists, Delete from the charges then create a new one
                StudentCharges.DELETE;

                CReg.RESET;
                CReg.SETRANGE(CReg."Student No.", Rec.Student);
                CReg.SETRANGE(CReg.Semester, Rec.Semester);
                IF CReg.FIND('-') THEN BEGIN //5
                    GenSetUp.GET();
                    IF GenSetUp.FIND('-') THEN BEGIN  //6
                        NoSeries.RESET;
                        NoSeries.SETRANGE(NoSeries."Series Code", GenSetUp."Transaction Nos.");
                        IF NoSeries.FIND('-') THEN BEGIN // 7
                            LastNo := NoSeries."Last No. Used"
                        END;  // 7
                    END; // 6
                         //message(LastNo);
                    LastNo := INCSTR(LastNo);
                    NoSeries."Last No. Used" := LastNo;
                    NoSeries.MODIFY;
                    StudentCharges.INIT();
                    StudentCharges."Transacton ID" := LastNo;
                    StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                    StudentCharges."Student No." := Rec.Student;
                    StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::Charges;
                    StudentCharges."Reg. Transacton ID" := CReg."Reg. Transacton ID";
                    StudentCharges.Description := 'Hostel Charges ' + Rec."Space No";
                    StudentCharges.Amount := Rec.Charges;
                    StudentCharges.Date := TODAY;
                    StudentCharges.Code := charges1.Code;
                    StudentCharges.Charge := TRUE;
                    StudentCharges.INSERT(TRUE);
                    // Billed:=TRUE;
                    // "Billed Date":=TODAY;
                    // MODIFY;
                END; //5
            END;//4

        END; //3


        //SettlementType1:='';
        CReg.RESET;
        CReg.SETRANGE(CReg."Student No.", Rec.Student);
        CReg.SETRANGE(CReg.Semester, Rec.Semester);
        IF CReg.FIND('-') THEN BEGIN //10
            "Settlement TypeR".GET(CReg."Settlement Type");
            "Settlement TypeR".TESTFIELD("Settlement TypeR"."Tuition G/L Account");
        END // 10
        ELSE BEGIN // 10.1
            ERROR('The Settlement Type Does not Exists in the Course Registration for: ' + Rec.Student);
        END;//10.1



        /*
        
        // MANUAL APPLICATION OF ACCOMODATION FOR PREPAYED STUDENTS BY Wanjala.....//
        StudentCharges.RESET;
        StudentCharges.SETRANGE(StudentCharges."Student No.",student);
        StudentCharges.SETRANGE(StudentCharges.Recognized,FALSE);
        StudentCharges.SETFILTER(StudentCharges.Code,'=%1',Charges1.Code) ;
        
        IF StudentCharges.COUNT=1 THEN BEGIN
        CALCFIELDS(Balance);
        IF Balance<0 THEN BEGIN
        IF ABS(Balance)>StudentCharges.Amount THEN BEGIN
        "Application Method":="Application Method"::Manual;
        AccPayment:=TRUE;
        MODIFY;
        END;
        END;
        END; */

        //END;


        //ERROR('TESTING '+FORMAT("Application Method"));

        IF Cust.GET(Rec.Student) THEN;

        GenJnl.RESET;
        GenJnl.SETRANGE("Journal Template Name", 'SALES');
        GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
        GenJnl.DELETEALL;

        GenSetUp.GET();
        //GenSetUp.TESTFIELD(GenSetUp."Pre-Payment Account");

        // Charge Student - Accommodation- if not charged
        StudentCharges.RESET;
        StudentCharges.SETRANGE(StudentCharges."Student No.", Rec.Student);
        StudentCharges.SETRANGE(StudentCharges.Recognized, FALSE);
        StudentCharges.SETFILTER(StudentCharges.Code, '=%1', charges1.Code);
        IF StudentCharges.FIND('-') THEN BEGIN

            REPEAT

                DueDate := StudentCharges.Date;
                //IF Sems.GET(StudentCharges.Semester) THEN BEGIN
                //IF Sems.From<>0D THEN BEGIN
                //IF Sems.From > DueDate THEN
                //DueDate:=Sems.From;
                //END;
                //END;
                IF DueDate = 0D THEN DueDate := TODAY;

                GenJnl.INIT;
                GenJnl."Line No." := GenJnl."Line No." + 10000;
                GenJnl."Posting Date" := TODAY;
                GenJnl."Document No." := StudentCharges."Transacton ID";
                GenJnl.VALIDATE(GenJnl."Document No.");
                GenJnl."Journal Template Name" := 'SALES';
                GenJnl."Journal Batch Name" := 'STUD PAY';
                GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                //
                IF Cust.GET(Rec.Student) THEN BEGIN
                    IF Cust."Bill-to Customer No." <> '' THEN
                        GenJnl."Account No." := Cust."Bill-to Customer No."
                    ELSE
                        GenJnl."Account No." := Rec.Student;
                END;

                GenJnl.Amount := StudentCharges.Amount;
                GenJnl.VALIDATE(GenJnl."Account No.");
                GenJnl.VALIDATE(GenJnl.Amount);
                GenJnl.Description := StudentCharges.Description;
                GenJnl."Bal. Account Type" := GenJnl."Account Type"::"G/L Account";

                IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Fees") AND
                   (StudentCharges.Charge = FALSE) THEN BEGIN
                    GenJnl."Bal. Account No." := "Settlement TypeR"."Tuition G/L Account";

                    CReg.RESET;
                    CReg.SETCURRENTKEY(CReg."Reg. Transacton ID");
                    CReg.SETRANGE(CReg."Reg. Transacton ID", StudentCharges."Reg. Transacton ID");
                    CReg.SETRANGE(CReg."Student No.", StudentCharges."Student No.");
                    IF CReg.FIND('-') THEN BEGIN
                        IF CReg."Register for" = CReg."Register for"::Stage THEN BEGIN
                            Stages.RESET;
                            Stages.SETRANGE(Stages."Programme Code", CReg.Programmes);
                            Stages.SETRANGE(Stages.Code, CReg.Stage);
                            IF Stages.FIND('-') THEN BEGIN
                                IF (Stages."Modules Registration" = TRUE) AND (Stages."Ignore No. Of Units" = FALSE) THEN BEGIN
                                    CReg.CALCFIELDS(CReg."Units Taken");
                                    IF CReg.Modules <> CReg."Units Taken" THEN
                                        ERROR('Units Taken must be equal to the no of modules registered for.');

                                END;
                            END;
                        END;

                        CReg.Posted := TRUE;
                        CReg.MODIFY;
                    END;


                END ELSE
                    IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Fees") AND
                       (StudentCharges.Charge = FALSE) THEN BEGIN
                        //GenJnl."Bal. Account No.":=GenSetUp."Pre-Payment Account";
                        StudentCharges.CALCFIELDS(StudentCharges."Settlement Type");
                        GenJnl."Bal. Account No." := "Settlement TypeR"."Tuition G/L Account";


                        CReg.RESET;
                        CReg.SETCURRENTKEY(CReg."Reg. Transacton ID");
                        CReg.SETRANGE(CReg."Reg. Transacton ID", StudentCharges."Reg. Transacton ID");
                        IF CReg.FIND('-') THEN BEGIN
                            CReg.Posted := TRUE;
                            CReg.MODIFY;
                        END;



                    END ELSE
                        IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Exam Fees" THEN BEGIN
                            IF ExamsByStage.GET(StudentCharges.Programme, StudentCharges.Stage, StudentCharges.Semester, StudentCharges.Code) THEN
                                GenJnl."Bal. Account No." := ExamsByStage."G/L Account";

                        END ELSE
                            IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Exam Fees" THEN BEGIN
                                IF ExamsByUnit.GET(StudentCharges.Programme, StudentCharges.Stage, ExamsByUnit."Unit Code", StudentCharges.Semester,
                                StudentCharges.Code) THEN
                                    GenJnl."Bal. Account No." := ExamsByUnit."G/L Account";

                            END ELSE
                                IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::Charges) OR
                                   (StudentCharges.Charge = TRUE) THEN BEGIN
                                    IF charges1.GET(StudentCharges.Code) THEN
                                        GenJnl."Bal. Account No." := charges1."G/L Account";
                                END;


                GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                IF prog.GET(StudentCharges.Programme) THEN BEGIN
                    prog.TESTFIELD(prog."Department Code");
                    GenJnl."Shortcut Dimension 2 Code" := prog."Department Code";
                END;



                GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
                GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                GenJnl."Due Date" := DueDate;
                GenJnl.VALIDATE(GenJnl."Due Date");
                IF StudentCharges."Recovery Priority" <> 0 THEN
                    GenJnl."Recovery Priority" := StudentCharges."Recovery Priority"
                ELSE
                    GenJnl."Recovery Priority" := 25;
                IF GenJnl.Amount <> 0 THEN
                    GenJnl.INSERT;

                //Distribute Money
                IF StudentCharges."Tuition Fee" = TRUE THEN BEGIN
                    IF Stages.GET(StudentCharges.Programme, StudentCharges.Stage) THEN BEGIN
                        IF (Stages."Distribution Full Time (%)" > 0) OR (Stages."Distribution Part Time (%)" > 0) THEN BEGIN
                            Stages.TESTFIELD(Stages."Distribution Account");
                            StudentCharges.TESTFIELD(StudentCharges.Distribution);
                            IF Cust.GET(Rec.Student) THEN BEGIN
                                CustPostGroup.GET(Cust."Customer Posting Group");

                                GenJnl.INIT;
                                GenJnl."Line No." := GenJnl."Line No." + 10000;
                                GenJnl."Posting Date" := TODAY;
                                GenJnl."Document No." := StudentCharges."Transacton ID";
                                //GenJnl."Document Type":=GenJnl."Document Type"::Payment;
                                GenJnl.VALIDATE(GenJnl."Document No.");
                                GenJnl."Journal Template Name" := 'SALES';
                                GenJnl."Journal Batch Name" := 'STUD PAY';
                                GenJnl."Account Type" := GenJnl."Account Type"::"G/L Account";
                                //GenSetUp.TESTFIELD(GenSetUp."Pre-Payment Account");
                                GenJnl."Account No." := "Settlement TypeR"."Tuition G/L Account";
                                GenJnl.Amount := StudentCharges.Amount * (StudentCharges.Distribution / 100);
                                GenJnl.VALIDATE(GenJnl."Account No.");
                                GenJnl.VALIDATE(GenJnl.Amount);
                                GenJnl.Description := 'Fee Distribution';
                                GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                                //GenJnl."Bal. Account No.":=Stages."Distribution Account";

                                StudentCharges.CALCFIELDS(StudentCharges."Settlement Type");
                                "Settlement TypeR".GET(StudentCharges."Settlement Type");
                                GenJnl."Bal. Account No." := "Settlement TypeR"."Tuition G/L Account";

                                GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                                GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                                IF prog.GET(StudentCharges.Programme) THEN BEGIN
                                    prog.TESTFIELD(prog."Department Code");
                                    GenJnl."Shortcut Dimension 2 Code" := prog."Department Code";
                                END;

                                GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
                                GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                                IF GenJnl.Amount <> 0 THEN
                                    GenJnl.INSERT;

                            END;
                        END;
                    END;
                END ELSE BEGIN
                    //Distribute Charges
                    IF StudentCharges.Distribution > 0 THEN BEGIN
                        StudentCharges.TESTFIELD(StudentCharges."Distribution Account");
                        IF charges1.GET(StudentCharges.Code) THEN BEGIN
                            charges1.TESTFIELD(charges1."G/L Account");
                            GenJnl.INIT;
                            GenJnl."Line No." := GenJnl."Line No." + 10000;
                            GenJnl."Posting Date" := TODAY;
                            GenJnl."Document No." := StudentCharges."Transacton ID";
                            GenJnl.VALIDATE(GenJnl."Document No.");
                            GenJnl."Journal Template Name" := 'SALES';
                            GenJnl."Journal Batch Name" := 'STUD PAY';
                            GenJnl."Account Type" := GenJnl."Account Type"::"G/L Account";
                            GenJnl."Account No." := StudentCharges."Distribution Account";
                            GenJnl.Amount := StudentCharges.Amount * (StudentCharges.Distribution / 100);
                            GenJnl.VALIDATE(GenJnl."Account No.");
                            GenJnl.VALIDATE(GenJnl.Amount);
                            GenJnl.Description := 'Fee Distribution';
                            GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                            GenJnl."Bal. Account No." := charges1."G/L Account";
                            GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                            GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";

                            IF prog.GET(StudentCharges.Programme) THEN BEGIN
                                prog.TESTFIELD(prog."Department Code");
                                GenJnl."Shortcut Dimension 2 Code" := prog."Department Code";
                            END;
                            GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
                            GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                            IF GenJnl.Amount <> 0 THEN
                                GenJnl.INSERT;

                        END;
                    END;
                END;
                //End Distribution


                StudentCharges.Recognized := TRUE;
                //StudentCharges.MODIFY;
                //.......BY Wanjala
                StudentCharges.Posted := TRUE;
                StudentCharges.MODIFY;

            //CReg.Posted:=TRUE;
            //CReg.MODIFY;


            //.....END Wanjala

            UNTIL StudentCharges.NEXT = 0;


            /*
            GenJnl.SETRANGE("Journal Template Name",'SALES');
            GenJnl.SETRANGE("Journal Batch Name",'STUD PAY');
            IF GenJnl.FIND('-') THEN BEGIN
            REPEAT
            GLPosting.RUN(GenJnl);
            UNTIL GenJnl.NEXT = 0;
            END;


            GenJnl.RESET;
            GenJnl.SETRANGE("Journal Template Name",'SALES');
            GenJnl.SETRANGE("Journal Batch Name",'STUD PAY');
            GenJnl.DELETEALL;
            */

            //Post New
            GenJnl.RESET;
            GenJnl.SETRANGE("Journal Template Name", 'SALES');
            GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
            IF GenJnl.FIND('-') THEN BEGIN
                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Bill", GenJnl);
            END;

            //Post New


            Cust."Application Method" := Cust."Application Method"::"Apply to Oldest";
            //Cust.Status:=Cust.Status::Current;
            Cust.MODIFY;

        END;

        /*
       //BILLING

       StudentPayments.RESET;
       StudentPayments.SETRANGE(StudentPayments."Student No.",student);
       IF StudentPayments.FIND('-') THEN
       StudentPayments.DELETEALL;


       StudentPayments.RESET;
       StudentPayments.SETRANGE(StudentPayments."Student No.",student);
       IF AccPayment=TRUE THEN BEGIN
        IF Cust.GET(student) THEN
        Cust."Application Method":=Cust."Application Method"::"Apply to Oldest";
        Cust. MODIFY;
       END;*/

        //MESSAGE('The Accommodation charge was generated and posted.');

    end;

    local procedure postChargeReversal()
    begin
        //BILLING
        charges1.RESET;
        charges1.SETRANGE(charges1.Hostel, TRUE);
        IF NOT charges1.FIND('-') THEN BEGIN
            ERROR('The charges Setup does not have an item tagged as Hostel.');
        END;

        AccPayment := FALSE;
        CReg.RESET;
        CReg.SETRANGE(CReg."Student No.", Rec.Student);
        CReg.SETRANGE(CReg.Semester, Rec.Semester);
        IF CReg.FIND('-') THEN BEGIN //5
            GenSetUp.GET();
            IF GenSetUp.FIND('-') THEN BEGIN  //6
                NoSeries.RESET;
                NoSeries.SETRANGE(NoSeries."Series Code", GenSetUp."Transaction Nos.");
                IF NoSeries.FIND('-') THEN BEGIN // 7
                    LastNo := NoSeries."Last No. Used"
                END;  // 7
            END; // 6
                 //message(LastNo);
        END; //5

        CReg.RESET;
        CReg.SETRANGE(CReg."Student No.", Rec.Student);
        CReg.SETRANGE(CReg.Semester, Rec.Semester);
        IF CReg.FIND('-') THEN BEGIN //10
            "Settlement TypeR".GET(CReg."Settlement Type");
            "Settlement TypeR".TESTFIELD("Settlement TypeR"."Tuition G/L Account");
        END // 10
        ELSE BEGIN // 10.1
            ERROR('The Settlement Type Does not Exists in the Course Registration for: ' + Rec.Student);
        END;//10.1

        IF prog.GET(CReg.Programmes) THEN;

        IF Cust.GET(Rec.Student) THEN;

        GenJnl.RESET;
        GenJnl.SETRANGE("Journal Template Name", 'SALES');
        GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
        GenJnl.DELETEALL;

        GenSetUp.GET();

        // Reverse Accomodation if charged

        DueDate := TODAY;

        IF DueDate = 0D THEN DueDate := TODAY;

        GenJnl.INIT;
        GenJnl."Line No." := GenJnl."Line No." + 10000;
        GenJnl."Posting Date" := TODAY;
        GenJnl."Document No." := COPYSTR((CReg."Reg. Transacton ID" + '-' + Rec."Space No"), 1, 20);
        GenJnl.VALIDATE(GenJnl."Document No.");
        GenJnl."Journal Template Name" := 'SALES';
        GenJnl."Journal Batch Name" := 'STUD PAY';
        GenJnl."Account Type" := GenJnl."Account Type"::Customer;
        //
        IF Cust.GET(Rec.Student) THEN BEGIN
            IF Cust."Bill-to Customer No." <> '' THEN
                GenJnl."Account No." := Cust."Bill-to Customer No."
            ELSE
                GenJnl."Account No." := Rec.Student;
        END;

        GenJnl.Amount := -Rec.Charges;
        GenJnl.VALIDATE(GenJnl."Account No.");
        GenJnl.VALIDATE(GenJnl.Amount);
        GenJnl.Description := 'Accommodation Reversal ' + Rec."Space No";
        GenJnl."Bal. Account Type" := GenJnl."Account Type"::"G/L Account";
        GenJnl."Bal. Account No." := charges1."G/L Account";

        GenJnl.VALIDATE(GenJnl."Bal. Account No.");
        GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
        IF prog.GET(StudentCharges.Programme) THEN BEGIN
            prog.TESTFIELD(prog."Department Code");
            GenJnl."Shortcut Dimension 2 Code" := prog."Department Code";
        END;

        GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
        GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
        GenJnl."Due Date" := DueDate;
        GenJnl.VALIDATE(GenJnl."Due Date");
        GenJnl."Recovery Priority" := 1;
        IF GenJnl.Amount <> 0 THEN
            GenJnl.INSERT;


        //Post New
        GenJnl.RESET;
        GenJnl.SETRANGE("Journal Template Name", 'SALES');
        GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
        IF GenJnl.FIND('-') THEN BEGIN
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Bill", GenJnl);
        END;

        //Post New

        MESSAGE('The Accommodation charge was Reversed.');
    end;

    procedure clearFromRoom_Reversal()
    var
        Rooms: Record "ACA-Hostel Block Rooms";
        spaces: Record "ACA-Room Spaces";
        hostLedger: Record "ACA-Hostel Ledger";
        HostRooms: Record "ACA-Students Hostel Rooms";
    begin
        hostLedger.RESET;
        hostLedger.SETRANGE(hostLedger."Hostel No", Rec."Hostel No");
        hostLedger.SETRANGE(hostLedger."Room No", Rec."Room No");
        hostLedger.SETRANGE(hostLedger."Space No", Rec."Space No");

        IF hostLedger.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                HostRooms.RESET;
                HostRooms.SETRANGE(HostRooms.Student, hostLedger."Student No");
                //HostRooms.SETRANGE(HostRooms."Academic Year",hostLedger."Academic Year");
                HostRooms.SETRANGE(HostRooms.Semester, hostLedger.Semester);
                HostRooms.SETRANGE(HostRooms."Hostel No", hostLedger."Hostel No");
                HostRooms.SETRANGE(HostRooms."Room No", hostLedger."Room No");
                HostRooms.SETRANGE(HostRooms."Space No", hostLedger."Space No");
                HostRooms.SETFILTER(HostRooms.Cleared, '=%1', FALSE);
                IF HostRooms.FIND('-') THEN BEGIN
                    HostRooms.Cleared := TRUE;
                    HostRooms."Clearance Date" := TODAY;
                    HostRooms.MODIFY;
                END;

            END;
            UNTIL hostLedger.NEXT = 0;
        END;

        hostLedger.DELETEALL;
        spaces.RESET;
        spaces.SETRANGE(spaces."Hostel Code", Rec."Hostel No");
        spaces.SETRANGE(spaces."Room Code", Rec."Room No");
        spaces.SETRANGE(spaces."Space Code", Rec."Space No");
        IF spaces.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                spaces.Status := spaces.Status::Vaccant;
                spaces."Student No" := '';
                spaces."Receipt No" := '';
                spaces."Black List reason" := '';
                spaces.MODIFY;
            END;
            UNTIL spaces.NEXT = 0;
        END;

        Rooms.RESET;
        Rooms.SETRANGE(Rooms."Hostel Code", Rec."Hostel No");
        Rooms.SETRANGE(Rooms."Room Code", Rec."Room No");
        IF Rooms.FIND('-') THEN BEGIN
            REPEAT
                Rooms.VALIDATE(Rooms.Status);
            UNTIL Rooms.NEXT = 0;
        END;
    end;
}

