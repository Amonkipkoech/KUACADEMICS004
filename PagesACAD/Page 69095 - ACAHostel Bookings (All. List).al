page 69095 "ACAHostel Bookings (All. List)"
{
    Editable = false;
    PageType = List;
    SourceTable = "ACA-Students Hostel Rooms";
    SourceTableView = WHERE(Allocated = FILTER(true),
                            Cleared = FILTER(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Student; Rec.Student)
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
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
                    ApplicationArea = All;
                }
                field("Allocation Date"; Rec."Allocation Date")
                {
                    Caption = 'Start Date';
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Allocated By"; Rec."Allocated By")
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
            action("Inventroy Items")
            {
                Caption = 'Inventroy Items';
                Image = InventoryJournal;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page 68936;
                RunPageLink = "Student No." = FIELD(Student),
                              "Hostel Block" = FIELD("Hostel No"),
                              "Room Code" = FIELD("Room No"),
                              "Space Code" = FIELD("Space No"),
                              "Academic Year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester);
                ApplicationArea = All;
            }
            action(Allocate)
            {
                Caption = 'Allocate Room';
                Image = "Action";
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                Visible = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //Check the Policy
                    Rec.TESTFIELD(Allocated, FALSE);
                    IF Cust.GET(Rec.Student) THEN BEGIN
                        Cust.CALCFIELDS(Cust.Balance);

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
                                IF Cust.Balance > (CReg."Total Billed" / 2) THEN ERROR('Fees payment Accommodation policy error--Balance');
                                allocations.RESET;
                                allocations.SETRANGE(allocations.Student, Cust."No.");
                                allocations.SETRANGE(allocations."Hostel No", Cust."Hostel No.");
                                allocations.SETRANGE(allocations."Room No", Cust."Room Code");
                                allocations.SETRANGE(allocations."Space No", Cust."Space Booked");
                                //allocations.SETRANGE(allocations."Academic Year","Academic Year");
                                allocations.SETRANGE(allocations.Semester, Cust.Semester);
                                // IF Allocations.FIND('-') THEN
                                // REPORT.RUN(52017900,TRUE,FALSE,Allocations);
                            END ELSE BEGIN  //1
                                ERROR('Fees payment Accommodation policy error --Billing');
                            END; //1
                        END ELSE BEGIN //2
                            ERROR('Fees payment Accommodation policy error --Registration');
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
                                        IF Creg1."Settlement Type" = 'JAB' THEN
                                            settlementType := settlementType::JAB
                                        ELSE
                                            IF Creg1."Settlement Type" = 'SSP' THEN settlementType := settlementType::SSP;
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
        }
    }

    var
        userst: Record "User Setup";
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
        StudentHostel2: Record "ACA-Students Hostel Rooms";
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
        rooms1: Record "ACA-Hostel Block Rooms";
        rooms2: Record "ACA-Hostel Block Rooms";
        prog2: Record "ACA-Programme";
        "Settlement Type": Record "ACA-Settlement Type";

    procedure "Book Room"(var settle_m: Option " ",JAB,SSP,"Special Programme")
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
                IF settle_m = settle_m::JAB THEN
                    billAmount := rooms."JAB Fees"
                ELSE
                    IF settle_m = settle_m::SSP THEN
                        billAmount := rooms."SSP Fees"

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
                Rooms_Spaces.RESET;
                Rooms_Spaces.SETRANGE(Rooms_Spaces."Space Code", StudentHostel."Space No");
                Rooms_Spaces.SETRANGE(Rooms_Spaces."Room Code", StudentHostel."Room No");
                Rooms_Spaces.SETRANGE(Rooms_Spaces."Hostel Code", StudentHostel."Hostel No");
                IF Rooms_Spaces.FIND('-') THEN BEGIN
                    IF Rooms_Spaces.Status <> Rooms_Spaces.Status::Vaccant THEN ERROR('The selected room is nolonger vacant');
                END;
                // ----------Check If He has UnCleared Room
                StudentHostel.RESET;
                StudentHostel.SETRANGE(StudentHostel.Student, Cust."No.");
                StudentHostel.SETRANGE(StudentHostel.Cleared, FALSE);
                IF StudentHostel.FIND('-') THEN BEGIN
                    IF StudentHostel.COUNT > 1 THEN BEGIN
                        ERROR('Please Note That You Must First Clear Your Old Rooms Before You Allocate Another Room')
                    END;
                END;
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
                    StudentHostel."Allocated By" := USERID;
                    StudentHostel."Time allocated" := TIME;
                    StudentHostel.MODIFY;


                END;
            //  IF StudentHostel."Over Paid" THEN BEGIN
            //    PostOverPayment();
            // END;
            UNTIL StudentHostel.NEXT = 0;
            MESSAGE('Room Allocated Successfully');
        END;

        postCharge();

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
                                     //"Settlement Type".GET(CReg."Settlement Type");
                                     //"Settlement Type".TESTFIELD("Settlement Type"."Tuition G/L Account");
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
                    //GenJnl."Bal. Account No.":="Settlement Type"."Tuition G/L Account";

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
                        //GenJnl."Bal. Account No.":="Settlement Type"."Tuition G/L Account";


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
                                //GenJnl."Account No.":="Settlement Type"."Tuition G/L Account";
                                GenJnl.Amount := StudentCharges.Amount * (StudentCharges.Distribution / 100);
                                GenJnl.VALIDATE(GenJnl."Account No.");
                                GenJnl.VALIDATE(GenJnl.Amount);
                                GenJnl.Description := 'Fee Distribution';
                                GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                                //GenJnl."Bal. Account No.":=Stages."Distribution Account";

                                StudentCharges.CALCFIELDS(StudentCharges."Settlement Type");
                                //"Settlement Type".GET(StudentCharges."Settlement Type");
                                //GenJnl."Bal. Account No.":="Settlement Type"."Tuition G/L Account";

                                GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                                GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                                IF prog.GET(StudentCharges.Programme) THEN BEGIN
                                    prog.TESTFIELD(prog."Department Code");
                                    GenJnl."Shortcut Dimension 2 Code" := prog."Department Code";
                                END;

                                GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
                                GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");

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

        MESSAGE('The Accommodation charge was generated and posted.');

    end;
}

