page 69173 "ACA-Std Rooms - Swap/Switch"
{
    PageType = Card;
    SourceTable = "ACA-Students Hostel Rooms";
    SourceTableView = WHERE(Cleared = filter(false));

    layout
    {
        area(content)
        {
            group(general)
            {
                field(Student; Rec.Student)
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        HostelLedger.RESET;
                        HostelLedger.SETRANGE(HostelLedger."Space No", Rec."Space No");
                        IF HostelLedger.FIND('-') THEN BEGIN
                            IF HostelLedger.Status <> HostelLedger.Status::Vaccant THEN ERROR('Please note that you can only select from vacant spaces');
                            Rec."Room No" := HostelLedger."Room No";
                            Rec."Hostel No" := HostelLedger."Hostel No";
                            Rec."Accomodation Fee" := HostelLedger."Room Cost";
                            Rec."Allocation Date" := TODAY;
                        END;
                        Sem.RESET;
                        Sem.SETRANGE(Sem."Current Semester", TRUE);
                        IF Sem.FIND('-') THEN
                            Rec.Semester := Sem.Code
                        ELSE
                            ERROR('Please Select the semester');

                        Registered := FALSE;
                        CReg.RESET;
                        CReg.SETRANGE(CReg."Student No.", Rec.Student);
                        CReg.SETRANGE(CReg.Semester, Sem.Code);
                        // Creg.SETRANGE(Creg.Posted,TRUE);
                        IF CReg.FIND('-') THEN
                            Registered := CReg.Registered;

                        GenSetUp.GET;
                        IF GenSetUp."Allow UnPaid Hostel Booking" = FALSE THEN BEGIN
                            // Check if he has a fee balance
                            IF Cust.GET(Rec.Student) THEN BEGIN
                                Cust.CALCFIELDS(Cust.Balance);
                                IF (Cust.Balance > 1) AND (Registered = FALSE) THEN ERROR('Please Note that you must first clear your balance');
                            END;

                            //Calculate Paid Accomodation Fee
                            PaidAmt := 0;
                            StudentCharges.RESET;
                            StudentCharges.SETRANGE(StudentCharges."Student No.", Rec.Student);
                            StudentCharges.SETRANGE(StudentCharges.Semester, Rec.Semester);
                            StudentCharges.SETRANGE(StudentCharges.Recognized, TRUE);
                            StudentCharges.SETFILTER(StudentCharges.Code, '%1', 'ACC*');
                            IF StudentCharges.FIND('-') THEN BEGIN
                                REPEAT
                                    PaidAmt := PaidAmt + StudentCharges.Amount;
                                UNTIL StudentCharges.NEXT = 0;
                            END;
                            IF PaidAmt > Rec."Accomodation Fee" THEN BEGIN
                                Rec."Over Paid" := TRUE;
                                Rec."Over Paid Amt" := PaidAmt - Rec."Accomodation Fee";
                            END ELSE BEGIN
                                IF PaidAmt < Rec."Accomodation Fee" THEN BEGIN
                                    IF ((Cust.Balance * -1) < Rec."Accomodation Fee") AND (Registered = FALSE) THEN // Checking if over paid fee can pay accomodation
                                        ERROR('Accomodation Fee Paid Can Not Book This Room The Paid Amount is ' + FORMAT((Cust.Balance * -1)))
                                END ELSE BEGIN
                                    Rec."Over Paid" := FALSE;
                                    Rec."Over Paid Amt" := 0;
                                END;
                            END;
                        END;
                    end;
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
            }
            group(CurrDetails)
            {
                Caption = 'Current Block/Room/Space';
                field("Hostel No"; Rec."Hostel No")
                {
                    Caption = 'From Hostel';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Room No"; Rec."Room No")
                {
                    Caption = 'From Room';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Space No"; Rec."Space No")
                {
                    Caption = 'From Space';
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group(CurrDetails2)
            {
                Caption = 'New Block/Room/Space';
                field("Switched to Hostel No"; Rec."Switched to Hostel No")
                {
                    Caption = 'Swap With Hostel';
                    ApplicationArea = All;
                }
                field("Switched to Room No"; Rec."Switched to Room No")
                {
                    Caption = 'Swap With Room';
                    ApplicationArea = All;
                }
                field("Switched to Space No"; Rec."Switched to Space No")
                {
                    Caption = 'Swap With Space';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Print Agreement")
            {
                Caption = 'Print Agreement';
                Promoted = true;
                PromotedCategory = Process;
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
                RunObject = Page 68936;
                RunPageLink = "Student No." = FIELD(Student),
                              "Hostel Block" = FIELD("Hostel No"),
                              "Room Code" = FIELD("Room No"),
                             "Space Code" = FIELD("Space No"),
                              "Academic Year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester);
                Visible = false;
                ApplicationArea = All;
            }
            action("Allocate Room")
            {
                Caption = 'Allocate Room';
                Image = "Action";
                Promoted = true;
                PromotedCategory = New;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CLEAR(settlementType);
                    Cust.RESET;
                    Cust.SETRANGE(Cust."No.", Rec.Student);
                    IF Cust.FIND('-') THEN
                        IF Cust."Hostel Black Listed" = FALSE THEN BEGIN
                            IF CONFIRM('Allocate the Specified Room?', TRUE) = FALSE THEN ERROR('Cancelled by user!');
                            Creg1.RESET;
                            Creg1.SETRANGE(Creg1."Student No.", Rec.Student);
                            Creg1.SETRANGE(Creg1.Semester, Rec.Semester);
                            Creg1.SETRANGE(Creg1."Academic Year", Rec."Academic Year");
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
                                    studItemInv.SETRANGE(studItemInv."Academic Year", Rec."Academic Year");
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
            action("Clear Room")
            {
                Caption = 'Clear Room';
                Image = New;
                Promoted = true;
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
            action("Book Batch")
            {
                Caption = 'Book Batch';
                Image = PostBatch;
                Promoted = true;
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
                                                    //  StudentCharges.INSERT();
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

                    MESSAGE(FORMAT(cou));

                end;
            }
            action("Print Invoice")
            {
                Caption = 'Print Invoice';
                Image = PrintReport;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    allocations.RESET;
                    allocations.SETRANGE(allocations.Student, Rec.Student);
                    allocations.SETRANGE(allocations."Hostel No", Rec."Hostel No");
                    allocations.SETRANGE(allocations."Room No", Rec."Room No");
                    allocations.SETRANGE(allocations."Space No", Rec."Space No");
                    allocations.SETRANGE(allocations."Academic Year", Rec."Academic Year");
                    allocations.SETRANGE(allocations.Semester, Rec.Semester);
                    IF allocations.FIND('-') THEN
                        REPORT.RUN(52017900, TRUE, FALSE, allocations);
                end;
            }
            action(switch_Rooms)
            {
                Caption = 'Switch Rooms';
                Image = TransferFunds;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    // TESTFIELD(Cleared,true);
                    Rec.TESTFIELD("Switched to Hostel No");
                    Rec.TESTFIELD("Switched to Room No");
                    Rec.TESTFIELD("Switched to Space No");
                    Rec.TESTFIELD("Hostel No");
                    Rec.TESTFIELD("Room No");
                    Rec.TESTFIELD("Space No");

                    IF ((Rec."Switched to Hostel No" = Rec."Hostel No") AND
                   (Rec."Switched to Room No" = Rec."Room No")
                   ) THEN
                        ERROR('The two rooms are the same');

                    CourseReg.RESET;
                    CourseReg.SETRANGE(CourseReg."Student No.", Rec.Student);
                    CourseReg.SETRANGE(CourseReg.Semester, Rec.Semester);
                    //CourseReg.SETRANGE(CourseReg."Academic Year","Academic Year");
                    IF CourseReg.FIND('-') THEN BEGIN
                        prog.RESET;
                        IF prog.GET(CourseReg.Programmes) THEN BEGIN
                        END;
                    END ELSE
                        ERROR('The Student is not registered for the current Semester.');
                    // Check if the room costs are equal
                    rooms1.RESET;
                    rooms1.SETRANGE(rooms1."Hostel Code", Rec."Hostel No");
                    rooms1.SETRANGE(rooms1."Room Code", Rec."Room No");
                    IF rooms1.FIND('-') THEN BEGIN

                        rooms2.RESET;
                        rooms2.SETRANGE(rooms2."Hostel Code", Rec."Switched to Hostel No");
                        rooms2.SETRANGE(rooms2."Room Code", Rec."Switched to Room No");
                        IF rooms2.FIND('-') THEN BEGIN
                            IF NOT (prog."Special Programme") THEN BEGIN
                                IF CourseReg."Settlement Type" = 'JAB' THEN BEGIN
                                    IF NOT (rooms1."JAB Fees" = rooms2."JAB Fees") THEN ERROR('Fees for the destination room must be equat to ' + FORMAT(rooms1."JAB Fees"));
                                END ELSE
                                    IF CourseReg."Settlement Type" = 'SSP' THEN BEGIN
                                        IF NOT (rooms1."SSP Fees" = rooms2."SSP Fees") THEN ERROR('Fees for the destination room must be equat to ' + FORMAT(rooms1."SSP Fees"));
                                    END;
                            END;// end if not special Programme
                        END;
                    END;

                    IF CONFIRM('Swap student from ' + Rec."Space No" + ' with student from ' + Rec."Switched to Space No", FALSE) = FALSE THEN ERROR('Switch cancelled');
                    // Get the student in the 2nd Room
                    IF Rec."Switched to Room No" = Rec."Room No" THEN ERROR('The students belong to the same room.');
                    CLEAR(studNo);
                    StudentHostel2.RESET;
                    StudentHostel2.SETRANGE(StudentHostel2."Hostel No", Rec."Switched to Hostel No");
                    StudentHostel2.SETRANGE(StudentHostel2."Room No", Rec."Switched to Room No");
                    StudentHostel2.SETRANGE(StudentHostel2."Space No", Rec."Switched to Space No");
                    StudentHostel2.SETRANGE(StudentHostel2.Semester, Rec.Semester);
                    StudentHostel2.SETRANGE(StudentHostel2.Cleared, FALSE);
                    IF StudentHostel2.FIND('-') THEN BEGIN
                        studNo := StudentHostel2.Student;
                        StudentHostel2."Switched to Hostel No" := Rec."Hostel No";
                        StudentHostel2."Switched to Room No" := Rec."Room No";
                        StudentHostel2."Switched to Space No" := Rec."Space No";
                        StudentHostel2."Switched from Hostel No" := StudentHostel2."Hostel No";
                        StudentHostel2."Switched from Room No" := StudentHostel2."Room No";
                        StudentHostel2."Switched from Space No" := StudentHostel2."Space No";
                        StudentHostel2.MODIFY;
                    END ELSE
                        ERROR('No student in the second room.');
                    // Clear Existing Room
                    clearFromRoom();
                    // Clear The second room too to have bothe rooms empty before allocation/swapping
                    clearFrom_2nd_Room();
                    // Allocate a new room without Posting charges
                    //******************************* 1st Room (Allocate the current student)*************************//
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
                    hostcard.SETRANGE(hostcard."Asset No", Rec."Switched to Hostel No");
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
                                studItemInv."Hostel Block" := Rec."Switched to Hostel No";
                                studItemInv."Room Code" := Rec."Switched to Room No";
                                studItemInv."Space Code" := Rec."Switched to Space No";
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



                    Rec."Switched from Hostel No" := Rec."Hostel No";
                    Rec."Switched from Room No" := Rec."Room No";
                    Rec."Switched from Space No" := Rec."Space No";
                    //"Hostel No":="Switched to Hostel No"  ;
                    //"Room No":="Switched to Room No";
                    //"Space No":="Switched to Space No";
                    //MODIFY;
                    //******************************* END of 1st Room/Student (Allocate the current student)*************************//

                    //******************************* 2nd Room (Allocate the 2nd student)*************************//
                    Creg1.RESET;
                    Creg1.SETRANGE(Creg1."Student No.", studNo);
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

                    "Book Room_2nd_Room"(settlementType);
                    // Assign Items
                    hostcard.RESET;
                    hostcard.SETRANGE(hostcard."Asset No", StudentHostel2."Hostel No");
                    IF hostcard.FIND('-') THEN BEGIN
                        invItems.RESET;
                        IF hostcard.Gender = hostcard.Gender::Male THEN
                            invItems.SETFILTER(invItems."Hostel Gender", '%1|%2', 1, 2);
                        IF invItems.FIND('-') THEN BEGIN
                            studItemInv.RESET;
                            studItemInv.SETRANGE(studItemInv."Student No.", studNo);
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



                    //"Switched from Hostel No":="Hostel No";
                    //"Switched from Room No" :="Room No";
                    //"Switched from Space No":="Space No";
                    //"Hostel No":="Switched to Hostel No"  ;
                    //"Room No":="Switched to Room No";
                    //"Space No":="Switched to Space No";
                    //MODIFY;
                    //******************************* END of 1st Room/Student (Allocate the current student)*************************//

                    MESSAGE('Students successfully Swaped');

                    Rec.Switched := TRUE;
                    Rec."Swithed By" := USERID;
                    Rec."Time Swithed" := TIME;
                    Rec."Date Switched" := TODAY;
                end;
            }
        }
    }

    var
        studNo: Code[30];
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
                GenJnlLine."Document No." := StudentHostel."Space No" + ' ' + StudentHostel."Room No";
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
        HostRooms: Record "ACA-Students Hostel Rooms";
    begin
        hostLedger.RESET;
        //hostLedger.SETRANGE(hostLedger."Hostel No","Hostel No");
        hostLedger.SETRANGE(hostLedger."Room No", Rec."Room No");
        hostLedger.SETRANGE(hostLedger."Space No", Rec."Space No");

        IF hostLedger.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                HostRooms.RESET;
                HostRooms.SETRANGE(HostRooms.Student, Rec.Student);
                //HostRooms.SETRANGE(HostRooms."Academic Year",hostLedger."Academic Year");
                HostRooms.SETRANGE(HostRooms.Semester, Rec.Semester);
                HostRooms.SETRANGE(HostRooms."Hostel No", Rec."Hostel No");
                HostRooms.SETRANGE(HostRooms."Room No", Rec."Room No");
                HostRooms.SETRANGE(HostRooms."Space No", Rec."Space No");
                HostRooms.SETFILTER(HostRooms.Cleared, '=%1', FALSE);
                IF HostRooms.FIND('-') THEN BEGIN
                    HostRooms.Cleared := TRUE;
                    HostRooms."Clearance Date" := TODAY;
                    HostRooms.MODIFY;
                END;
                hostLedger.DELETE(TRUE);
            END;
            UNTIL hostLedger.NEXT = 0;
        END;


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

    procedure "Book Room"(var settle_m: Option " ",JAB,SSP,"Special Programme")
    var
        rooms: Record "ACA-Hostel Block Rooms";
        billAmount: Decimal;
        counted: Integer;
    begin
        // -- Create a new allocation
        StudentHostel.RESET;
        IF StudentHostel.FIND('-') THEN
            counted := StudentHostel.COUNT
        ELSE
            counted := 1000;
        // --------Check If More Than One Room Has Been Selected
        counted := counted + 1;
        StudentHostel.INIT;
        StudentHostel."Line No" := counted;
        StudentHostel.Student := Rec.Student;
        StudentHostel."Space No" := Rec."Switched to Space No";
        StudentHostel."Room No" := Rec."Switched to Room No";
        StudentHostel."Hostel No" := Rec."Switched to Hostel No";
        StudentHostel."Accomodation Fee" := Rec."Accomodation Fee";
        StudentHostel."Allocation Date" := TODAY;
        StudentHostel.Charges := Rec.Charges;
        StudentHostel.Billed := Rec.Billed;
        StudentHostel."Billed Date" := Rec."Billed Date";
        StudentHostel.Semester := Rec.Semester;
        StudentHostel."Academic Year" := Rec."Academic Year";
        StudentHostel.Allocated := TRUE;
        StudentHostel."Transfed from Hostel No" := Rec."Hostel No";
        StudentHostel."Transfed from Room No" := Rec."Room No";
        StudentHostel."Transfed from Space No" := Rec."Space No";
        StudentHostel.Gender := Rec.Gender;
        StudentHostel.INSERT(TRUE);

        CLEAR(billAmount);
        rooms.RESET;
        rooms.SETRANGE(rooms."Hostel Code", Rec."Switched to Hostel No");
        rooms.SETRANGE(rooms."Room Code", Rec."Switched to Room No");
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
        // StudentHostel.SETRANGE(StudentHostel.Student,Cust."No.");
        // StudentHostel.SETFILTER(StudentHostel.Allocated,'=%1',FALSE);
        // StudentHostel.SETRANGE(StudentHostel.Billed,FALSE);
        StudentHostel.RESET;
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
                    // ERROR('Please Note That You Can Not Select More Than One Room')
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
                StudentHostel.SETRANGE(StudentHostel.Student, Cust."No.");
                StudentHostel.SETRANGE(StudentHostel.Cleared, FALSE);
                IF StudentHostel.FIND('-') THEN BEGIN
                    IF StudentHostel.COUNT > 1 THEN BEGIN
                        // ERROR('Please Note That You Must First Clear Your Old Rooms Before You Allocate Another Room')
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
                        // StudentCharges.INSERT();
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
                    Host_Ledger."Space No" := Rec."Switched to Space No";
                    Host_Ledger."Room No" := Rec."Switched to Room No";
                    Host_Ledger."Hostel No" := Rec."Switched to Hostel No";
                    Host_Ledger.No := counts;
                    Host_Ledger.Status := Host_Ledger.Status::"Fully Occupied";
                    Host_Ledger."Room Cost" := Rec.Charges;
                    Host_Ledger."Student No" := Rec.Student;
                    Host_Ledger."Receipt No" := '';
                    Host_Ledger.Semester := Rec.Semester;
                    Host_Ledger.Gender := Rec.Gender;
                    Host_Ledger."Hostel Name" := '';
                    Host_Ledger.Campus := Cust."Global Dimension 1 Code";
                    Host_Ledger."Academic Year" := Rec."Academic Year";
                    Host_Ledger.INSERT;


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
            // MESSAGE('Room Allocateed Successfully');
        END;

    end;

    procedure clearFrom_2nd_Room()
    var
        Rooms: Record "ACA-Hostel Block Rooms";
        spaces: Record "ACA-Room Spaces";
        hostLedger: Record "ACA-Hostel Ledger";
        HostRooms: Record "ACA-Students Hostel Rooms";
    begin
        hostLedger.RESET;
        // hostLedger.SETRANGE(hostLedger."Hostel No","Switched to Hostel No");
        hostLedger.SETRANGE(hostLedger."Room No", Rec."Switched to Room No");
        hostLedger.SETRANGE(hostLedger."Space No", Rec."Switched to Space No");

        IF hostLedger.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                HostRooms.RESET;
                HostRooms.SETRANGE(HostRooms.Student, hostLedger."Student No");
                //HostRooms.SETRANGE(HostRooms."Academic Year",hostLedger."Academic Year");
                HostRooms.SETRANGE(HostRooms.Semester, hostLedger.Semester);
                HostRooms.SETRANGE(HostRooms."Hostel No", Rec."Switched to Hostel No");
                HostRooms.SETRANGE(HostRooms."Room No", Rec."Switched to Room No");
                HostRooms.SETRANGE(HostRooms."Space No", Rec."Switched to Space No");
                HostRooms.SETFILTER(HostRooms.Cleared, '=%1', FALSE);
                IF HostRooms.FIND('-') THEN BEGIN
                    HostRooms.Cleared := TRUE;
                    HostRooms."Clearance Date" := TODAY;
                    HostRooms.MODIFY(TRUE);
                END;
                hostLedger.DELETE(TRUE);
            END;
            UNTIL hostLedger.NEXT = 0;
        END;


        spaces.RESET;
        spaces.SETRANGE(spaces."Hostel Code", Rec."Switched to Hostel No");
        spaces.SETRANGE(spaces."Room Code", Rec."Switched to Room No");
        spaces.SETRANGE(spaces."Space Code", Rec."Switched to Space No");
        IF spaces.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                spaces.Status := spaces.Status::Vaccant;
                spaces."Student No" := '';
                spaces."Receipt No" := '';
                spaces."Black List reason" := '';
                spaces.MODIFY(TRUE);
            END;
            UNTIL spaces.NEXT = 0;
        END;

        Rooms.RESET;
        Rooms.SETRANGE(Rooms."Hostel Code", Rec."Switched to Hostel No");
        Rooms.SETRANGE(Rooms."Room Code", Rec."Switched to Room No");
        IF Rooms.FIND('-') THEN BEGIN
            REPEAT
                Rooms.VALIDATE(Rooms.Status);
            UNTIL Rooms.NEXT = 0;
        END;
    end;

    procedure "Book Room_2nd_Room"(var settle_m: Option " ",JAB,SSP,"Special Programme")
    var
        rooms: Record "ACA-Hostel Block Rooms";
        billAmount: Decimal;
        counted: Integer;
    begin
        // -- Create a new allocation
        StudentHostel2.RESET;
        StudentHostel2.SETRANGE(StudentHostel2."Hostel No", Rec."Switched to Hostel No");
        StudentHostel2.SETRANGE(StudentHostel2."Room No", Rec."Switched to Room No");
        StudentHostel2.SETRANGE(StudentHostel2."Space No", Rec."Switched to Space No");
        StudentHostel2.SETRANGE(StudentHostel2.Semester, Rec.Semester);
        StudentHostel2.SETRANGE(StudentHostel2.Allocated, TRUE);
        StudentHostel2.SETRANGE(StudentHostel2.Cleared, TRUE);
        IF StudentHostel2.FIND('-') THEN BEGIN
            StudentHostel.RESET;
            IF StudentHostel.FIND('-') THEN
                counted := StudentHostel.COUNT
            ELSE
                counted := 1000;
            // --------Check If More Than One Room Has Been Selected
            counted := counted + 1;
            StudentHostel.INIT;
            StudentHostel."Line No" := counted;
            StudentHostel.Student := StudentHostel2.Student;
            StudentHostel."Space No" := Rec."Space No";
            StudentHostel."Room No" := Rec."Room No";
            StudentHostel."Hostel No" := Rec."Hostel No";
            StudentHostel."Accomodation Fee" := Rec."Accomodation Fee";
            StudentHostel."Allocation Date" := TODAY;
            StudentHostel.Charges := Rec.Charges;
            StudentHostel.Billed := Rec.Billed;
            StudentHostel."Billed Date" := Rec."Billed Date";
            StudentHostel.Semester := Rec.Semester;
            StudentHostel."Academic Year" := Rec."Academic Year";
            StudentHostel.Allocated := TRUE;
            StudentHostel."Switched from Hostel No" := Rec."Switched to Hostel No";
            StudentHostel."Switched from Room No" := Rec."Switched to Room No";
            StudentHostel."Switched from Space No" := Rec."Switched to Space No";
            StudentHostel."Switched to Hostel No" := Rec."Hostel No";
            StudentHostel."Switched to Room No" := Rec."Room No";
            StudentHostel."Switched to Space No" := Rec."Space No";
            StudentHostel.Gender := Rec.Gender;
            StudentHostel.INSERT;

            CLEAR(billAmount);
            rooms.RESET;
            rooms.SETRANGE(rooms."Hostel Code", Rec."Switched to Hostel No");
            rooms.SETRANGE(rooms."Room Code", Rec."Switched to Room No");
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
            Cust.SETRANGE(Cust."No.", StudentHostel2.Student);
            IF Cust.FIND('-') THEN BEGIN
            END;

            StudentHostel.RESET;
            NoRoom := 0;
            StudentHostel.SETRANGE(StudentHostel.Student, Cust."No.");
            StudentHostel.SETFILTER(StudentHostel.Allocated, '=%1', TRUE);
            StudentHostel.SETFILTER(StudentHostel.Cleared, '=%1', FALSE);
            // StudentHostel.SETRANGE(StudentHostel.Billed,FALSE);
            StudentHostel.SETFILTER(StudentHostel."Space No", '<>%1', '');
            IF StudentHostel.FIND('-') THEN BEGIN
                REPEAT
                    // Get the Hostel Name
                    StudentHostel.TESTFIELD(StudentHostel.Semester);
                    // StudentHostel.TESTFIELD(StudentHostel."Academic Year");
                    StudentHostel.TESTFIELD(StudentHostel."Space No");
                    NoRoom := NoRoom + 1;
                    IF NoRoom > 1 THEN BEGIN
                        //ERROR('Please Note That You Can Not Select More Than One Room')
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
                    StudentHostel.SETRANGE(StudentHostel.Student, Cust."No.");
                    StudentHostel.SETRANGE(StudentHostel.Cleared, FALSE);
                    IF StudentHostel.FIND('-') THEN BEGIN
                        IF StudentHostel.COUNT > 1 THEN BEGIN
                            //  ERROR('Please Note That You Must First Clear Your Old Rooms Before You Allocate Another Room')
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
                // END;
                UNTIL StudentHostel.NEXT = 0;
                // MESSAGE('Room Allocateed Successfully');
            END;
        END;// Check StudentHostel2.

    end;
}

