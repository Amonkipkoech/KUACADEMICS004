page 69170 "ACA-Std Hostel Lists Hist"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Customer;
    SourceTableView = WHERE("Customer Type" = CONST(Student),
                            "Hostel Allocated" = filter(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Hostel No."; Rec."Hostel No.")
                {
                    ApplicationArea = All;
                }
                field("Room Code"; Rec."Room Code")
                {
                    ApplicationArea = All;
                }
                field("Space Booked"; Rec."Space Booked")
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
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Telex No."; Rec."Telex No.")
                {
                    ApplicationArea = All;
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = All;
                }
                field("Our Account No."; Rec."Our Account No.")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
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
            action("Post Charges")
            {
                Caption = 'Post Charges';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Do You Really Want to Post The Room Charges') THEN BEGIN
                        GenSetUp.GET();
                        IF GenSetUp.FIND('-') THEN BEGIN
                            NoSeries.RESET;
                            NoSeries.SETRANGE(NoSeries."Series Code", GenSetUp."Transaction Nos.");
                            IF NoSeries.FIND('-') THEN BEGIN
                                LastNo := NoSeries."Last No. Used"
                            END;
                        END;
                        StudentHostel.RESET;
                        StudentHostel.SETRANGE(StudentHostel.Student, Rec."No.");
                        StudentHostel.SETRANGE(StudentHostel.Billed, FALSE);
                        IF StudentHostel.FIND('-') THEN BEGIN
                            REPEAT
                                ;
                                //message(LastNo);
                                LastNo := INCSTR(LastNo);
                                NoSeries."Last No. Used" := LastNo;
                                NoSeries.MODIFY;
                                StudentCharges.INIT();
                                StudentCharges."Transacton ID" := LastNo;
                                StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                                StudentCharges."Student No." := Rec."No.";
                                StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::Charges;
                                StudentCharges.Description := 'Hostel Charges ' + StudentHostel."Space No";
                                StudentCharges.Amount := StudentHostel."Accomodation Fee";
                                StudentCharges.Date := StudentHostel."Allocation Date";
                                StudentCharges.Code := 'ACC';
                                StudentCharges.Charge := TRUE;
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
            action("Student Room")
            {
                Caption = 'Student Room';
                Image = List;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page 68113;
                RunPageLink = Student = FIELD("No.");
                ApplicationArea = All;
            }
            action(Post_Charge)
            {
                Caption = 'Create/Post Charges';
                Image = Post;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    studRooms: Record "ACA-Students Hostel Rooms";
                begin
                    CReg.RESET;
                    CReg.SETRANGE(CReg."Student No.", Rec."No.");
                    CReg.SETRANGE(CReg.Semester, Rec.Semester);
                    IF CReg.FIND('-') THEN BEGIN
                        studRooms.RESET;
                        studRooms.SETRANGE(studRooms.Student, Rec."No.");
                        studRooms.SETRANGE(studRooms."Space No", Rec."Space Booked");
                        studRooms.SETRANGE(studRooms."Room No", Rec."Room Code");
                        studRooms.SETRANGE(studRooms."Hostel No", Rec."Hostel No.");
                        studRooms.SETRANGE(studRooms.Semester, CReg.Semester);
                        IF studRooms.FIND('-') THEN BEGIN
                            REPEAT
                            BEGIN
                                postCharge(studRooms);
                            END;
                            UNTIL studRooms.NEXT = 0;
                        END;
                    END;
                    // Post the Journal
                end;
            }
        }
    }

    var
        prog: Record "ACA-Programme";
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
    //"Billed Date": Date;


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

    procedure "Book Room"(var settle_m: Option " ",JAB,SSP,"Special Programme")
    var
        rooms: Record "ACA-Hostel Block Rooms";
        billAmount: Decimal;
    begin
        // --------Check If More Than One Room Has Been Selected
        /*
            CLEAR(billAmount);
           rooms.RESET;
          rooms.SETRANGE(rooms."Hostel Code",);
          rooms.SETRANGE(rooms."Room Code","Room No");
          IF rooms.FIND('-') THEN BEGIN
            IF settle_m=settle_m::"Special Programme" THEN
              billAmount:=rooms."Special Programme"
            ELSE IF settle_m=settle_m::JAB THEN
              billAmount:=rooms."JAB Fees"
            ELSE IF settle_m=settle_m::SSP THEN
              billAmount:=rooms."SSP Fees"
        
          END;
          Cust.RESET;
          Cust.SETRANGE(Cust."No.",Student);
          IF Cust.FIND('-') THEN BEGIN
          END;
        
          StudentHostel.RESET;
          NoRoom:=0;
          StudentHostel.SETRANGE(StudentHostel.Student,Cust."No.");
         // StudentHostel.SETRANGE(StudentHostel.Billed,FALSE);
          StudentHostel.SETFILTER(StudentHostel."Space No",'<>%1','');
          IF StudentHostel.FIND('-') THEN BEGIN
            REPEAT
            // Get the Hostel Name
            StudentHostel.TESTFIELD(StudentHostel.Semester);
           // StudentHostel.TESTFIELD(StudentHostel."Academic Year");
            StudentHostel.TESTFIELD(StudentHostel."Space No");
            NoRoom:=NoRoom+1;
            IF NoRoom>1 THEN BEGIN
              ERROR('Please Note That You Can Not Select More Than One Room')
            END;
            // check if the room is still vacant
            Rooms_Spaces.RESET;
            Rooms_Spaces.SETRANGE(Rooms_Spaces."Space Code",StudentHostel."Space No");
            Rooms_Spaces.SETRANGE(Rooms_Spaces."Room Code",StudentHostel."Room No");
            Rooms_Spaces.SETRANGE(Rooms_Spaces."Hostel Code",StudentHostel."Hostel No");
            IF Rooms_Spaces.FIND('-') THEN
            IF Rooms_Spaces.Status<>Rooms_Spaces.Status::Vaccant THEN ERROR('The selected room is nolonger vacant');
        
            // ----------Check If He has UnCleared Room
           StudentHostel.RESET;
           StudentHostel.SETRANGE(StudentHostel.Student,Cust."No.");
           StudentHostel.SETRANGE(StudentHostel.Cleared,FALSE);
           IF StudentHostel.FIND('-') THEN BEGIN
              IF StudentHostel.COUNT>1 THEN BEGIN
                ERROR('Please Note That You Must First Clear Your Old Rooms Before You Allocate Another Room')
              END;
           END;
           //---Check if The Student Have Paid The Accomodation Fee
           charges1.RESET;
           charges1.SETRANGE(charges1.Hostel,TRUE);
           IF charges1.FIND('-') THEN BEGIN
           END ELSE ERROR('Accommodation not setup.');
        
           StudentCharges.RESET;
           StudentCharges.SETRANGE(StudentCharges."Student No.",Student);
           StudentCharges.SETRANGE(StudentCharges.Semester,Semester);
           StudentCharges.SETRANGE(StudentCharges.Code,charges1.Code);
           //StudentCharges.SETRANGE(Posted,TRUE);
          { IF StudentCharges.FIND('-') THEN BEGIN
             ChargesRec.SETRANGE(ChargesRec.Code,StudentCharges.Code);
             IF ChargesRec.FIND('-') THEN BEGIN
               PaidAmt:=ChargesRec.Amount
             END;
           END; }
           IF Blocks.GET("Hostel No") THEN BEGIN
           END;
        
           IF NOT StudentCharges.FIND('-') THEN BEGIN
        coReg.RESET;
        coReg.SETRANGE(coReg."Student No.",Student);
        coReg.SETRANGE(coReg.Semester,Semester);
        //coReg.SETRANGE(coReg."Academic Year","Academic Year");
        IF coReg.FIND('-') THEN BEGIN
            StudentCharges.INIT;
            StudentCharges."Transacton ID":='';
            StudentCharges.VALIDATE(StudentCharges."Transacton ID");
            StudentCharges."Student No.":=coReg."Student No.";
            StudentCharges."Reg. Transacton ID":=coReg."Reg. Transacton ID";
            StudentCharges."Transaction Type":=StudentCharges."Transaction Type"::Charges;
            StudentCharges.Code :=charges1.Code;
            StudentCharges.Description:='Accommodation Fees';
           // IF Blocks.GET("Hostel No") THEN
           // StudentCharges.Amount:=Blocks."Cost Per Occupant"
           // ELSE
            StudentCharges.Amount:=billAmount;
            StudentCharges.Date:=TODAY;
            StudentCharges.Programme:=coReg.Programme;
            StudentCharges.Stage:=coReg.Stage;
            StudentCharges.Semester:=coReg.Semester;
            StudentCharges.INSERT();
        END;
             END;
        
           IF PaidAmt>StudentHostel."Accomodation Fee" THEN BEGIN
               StudentHostel."Over Paid":=TRUE;
               StudentHostel."Over Paid Amt":=PaidAmt-StudentHostel."Accomodation Fee";
               StudentHostel.MODIFY;
          {
           END ELSE BEGIN
             IF PaidAmt<>StudentHostel."Accomodation Fee" THEN BEGIN
        
              ERROR('Accomodation Fee Paid Can Not Allocate This Room The Paid Amount is '+FORMAT(PaidAmt))
             END;
             }
           END;
        
        
            Rooms_Spaces.RESET;
            Rooms_Spaces.SETRANGE(Rooms_Spaces."Space Code",StudentHostel."Space No");
            IF Rooms_Spaces.FIND('-') THEN BEGIN
              Rooms_Spaces.Status:=Rooms_Spaces.Status::"Fully Occupied";
              Rooms_Spaces.MODIFY;
              CLEAR(counts);
          // Post to  the Ledger Tables
          Host_Ledger.RESET;
          IF Host_Ledger.FIND('-') THEN counts:=Host_Ledger.COUNT;
          Host_Ledger.INIT;
            Host_Ledger."Space No":=StudentHostel."Space No";
            Host_Ledger."Room No":=StudentHostel."Room No";
            Host_Ledger."Hostel No":=StudentHostel."Hostel No";
            Host_Ledger.No:=counts;
            Host_Ledger.Status:=Host_Ledger.Status::"Fully Occupied";
            Host_Ledger."Room Cost":=StudentHostel.Charges;
            Host_Ledger."Student No":=StudentHostel.Student;
            Host_Ledger."Receipt No":='';
            Host_Ledger.Semester:=StudentHostel.Semester;
            Host_Ledger.Gender:= Gender;
            Host_Ledger."Hostel Name":='';
            Host_Ledger.Campus:=Cust."Global Dimension 1 Code";
            Host_Ledger."Academic Year":=StudentHostel."Academic Year";
          Host_Ledger.INSERT(TRUE);
        
        
        Hostel_Rooms.RESET;
        Hostel_Rooms.SETRANGE(Hostel_Rooms."Hostel Code",StudentHostel."Hostel No");
        Hostel_Rooms.SETRANGE(Hostel_Rooms."Room Code",StudentHostel."Room No");
        IF Hostel_Rooms.FIND('-') THEN BEGIN
           Hostel_Rooms.CALCFIELDS(Hostel_Rooms."Bed Spaces",Hostel_Rooms."Occupied Spaces");
           IF Hostel_Rooms."Bed Spaces"=Hostel_Rooms."Occupied Spaces" THEN
            Hostel_Rooms.Status:=Hostel_Rooms.Status::"Fully Occupied"
           ELSE IF Hostel_Rooms."Occupied Spaces"<Hostel_Rooms."Bed Spaces" THEN
           Hostel_Rooms.Status:=Hostel_Rooms.Status::"Partially Occupied";
           Hostel_Rooms.MODIFY;
        END;
        
              StudentHostel.Billed:=TRUE;
              StudentHostel."Billed Date":=TODAY;
              StudentHostel."Allocation Date":=TODAY;
              StudentHostel.Allocated:=TRUE;
              StudentHostel.MODIFY;
        
        
            END;
          //  IF StudentHostel."Over Paid" THEN BEGIN
          //    PostOverPayment();
            // END;
            UNTIL StudentHostel.NEXT=0;
            MESSAGE('Room Allocateed Successfully');
          END;
            */

    end;

    local procedure postCharge(var studRooms: Record "ACA-Students Hostel Rooms")
    begin
        //BILLING
        IF studRooms.Billed = TRUE THEN
            ERROR('The Allocation is already posted.');
        charges1.RESET;
        charges1.SETRANGE(charges1.Hostel, TRUE);
        IF NOT charges1.FIND('-') THEN BEGIN
            ERROR('The charges Setup does not have an item tagged as Hostel.');
        END;

        AccPayment := FALSE;
        StudentCharges.RESET;
        StudentCharges.SETRANGE(StudentCharges."Student No.", studRooms.Student);
        StudentCharges.SETRANGE(StudentCharges.Recognized, FALSE);
        StudentCharges.SETFILTER(StudentCharges.Code, '=%1', charges1.Code);
        IF NOT StudentCharges.FIND('-') THEN BEGIN //3
                                                   // The charge does not exist. Created it, but check first if it exists as unrecognized
            StudentCharges.RESET;
            StudentCharges.SETRANGE(StudentCharges."Student No.", studRooms.Student);
            //StudentCharges.SETRANGE(StudentCharges.Recognized,FALSE);
            StudentCharges.SETFILTER(StudentCharges.Code, '=%1', charges1.Code);
            IF NOT StudentCharges.FIND('-') THEN BEGIN //4
                                                       // Does not exist hence just create
                CReg.RESET;
                CReg.SETRANGE(CReg."Student No.", studRooms.Student);
                CReg.SETRANGE(CReg.Semester, studRooms.Semester);
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
                    StudentCharges."Reg. Transacton ID" := CReg."Reg. Transacton ID";
                    StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                    StudentCharges."Student No." := studRooms.Student;
                    StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::Charges;
                    StudentCharges.Description := 'Hostel Charges ' + studRooms."Space No";
                    StudentCharges.Amount := studRooms.Charges;
                    StudentCharges.Date := TODAY;
                    StudentCharges.Code := charges1.Code;
                    StudentCharges.Charge := TRUE;
                    StudentCharges.INSERT(TRUE);
                    studRooms.Billed := TRUE;
                    studRooms."Billed Date" := TODAY;
                    studRooms.MODIFY;
                END; //5

            END ELSE BEGIN//4
                          // Charge Exists, Delete from the charges then create a new one
                StudentCharges.DELETE;

                CReg.RESET;
                CReg.SETRANGE(CReg."Student No.", studRooms.Student);
                CReg.SETRANGE(CReg.Semester, studRooms.Semester);
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
                    StudentCharges."Reg. Transacton ID" := CReg."Reg. Transacton ID";
                    StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                    StudentCharges."Student No." := studRooms.Student;
                    StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::Charges;
                    StudentCharges.Description := 'Hostel Charges ' + studRooms."Space No";
                    StudentCharges.Amount := studRooms.Charges;
                    StudentCharges.Date := TODAY;
                    StudentCharges.Code := charges1.Code;
                    StudentCharges.Charge := TRUE;
                    StudentCharges.INSERT(TRUE);
                    studRooms.Billed := TRUE;
                    studRooms."Billed Date" := TODAY;
                    studRooms.MODIFY;
                END; //5
            END;//4

        END; //3


        //SettlementType1:='';
        CReg.RESET;
        CReg.SETRANGE(CReg."Student No.", studRooms.Student);
        CReg.SETRANGE(CReg.Semester, studRooms.Semester);
        IF CReg.FIND('-') THEN BEGIN //10
                                     //"Settlement Type".GET(CReg."Settlement Type");
                                     //"Settlement Type".TESTFIELD("Settlement Type"."Tuition G/L Account");
        END // 10
        ELSE BEGIN // 10.1
            ERROR('The Settlement Type Does not Exists in the Course Registration for: ' + studRooms.Student);
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

        IF Cust.GET(studRooms.Student) THEN;

        GenJnl.RESET;
        GenJnl.SETRANGE("Journal Template Name", 'SALES');
        GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
        GenJnl.DELETEALL;

        GenSetUp.GET();
        //GenSetUp.TESTFIELD(GenSetUp."Pre-Payment Account");

        // Charge Student - Accommodation- if not charged
        StudentCharges.RESET;
        StudentCharges.SETRANGE(StudentCharges."Student No.", studRooms.Student);
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
                IF Cust.GET(studRooms.Student) THEN BEGIN
                    IF Cust."Bill-to Customer No." <> '' THEN
                        GenJnl."Account No." := Cust."Bill-to Customer No."
                    ELSE
                        GenJnl."Account No." := studRooms.Student;
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
                            IF Cust.GET(studRooms.Student) THEN BEGIN
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

