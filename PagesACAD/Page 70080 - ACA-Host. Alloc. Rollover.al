#pragma warning disable DOC0101
/// <summary>
/// Page ACA-Host. Alloc. Rollover (ID 70080).
/// </summary>
page 70080 "ACA-Host. Alloc. Rollover"
#pragma warning restore DOC0101
{
    Caption = 'Hospel Allocation Roll-over';
    PageType = Card;
    //SourceTable = Table2000000026;
    // SourceTableView = WHERE(Number = FILTER(1));

    layout
    {
        area(content)
        {
            group(General)
            {
                field(SourceSemester; SourceSemester)
                {
                    Caption = 'Source Semester';
                    TableRelation = "ACA-Semesters".Code;
                    ApplicationArea = All;
                }
                field(ClearanceCutOff; ClearanceCutOff)
                {
                    Caption = 'Clearance Cutoff';
                    ApplicationArea = All;
                }
            }
            grid(CurrValues)
            {
                Caption = 'Current Values';
                field(CurrAcademicYear; CurrAcademicYear)
                {
                    Caption = 'Current Acad. Year';
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(CurrSemester; CurrSemester)
                {
                    Caption = 'Current Semester';
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(SourceAcademicYear; SourceAcademicYear)
                {
                    Caption = 'Source Acad. Year';
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(ImpAlloc)
            {
                Caption = 'Import Allocations';
                Image = "Action";
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF ((CurrAcademicYear = '') OR (SourceAcademicYear = '') OR (CurrSemester = '') OR (SourceSemester = '') OR (ClearanceCutOff = 0D)) THEN
                        ERROR('Specify all Parameters ');
                    IF CONFIRM('Import Allocations?', FALSE) = FALSE THEN ERROR('Cancelled!');
                    GenJnl.RESET;
                    GenJnl.SETRANGE("Journal Template Name", 'SALES');
                    GenJnl.SETRANGE("Journal Batch Name", 'ACCOM');
                    GenJnl.DELETEALL;

                    CLEAR(LineNo);
                    ACAStudentsHostelRooms.RESET;
                    //Old Value
                    //ACAStudentsHostelRooms.SETRANGE("Academic Year",SourceAcademicYear);
                    ACAStudentsHostelRooms.SETRANGE(Semester, SourceSemester);
                    ACAStudentsHostelRooms.SETRANGE(Allocated, TRUE);
                    ACAStudentsHostelRooms.SETRANGE(Cleared, FALSE);

                    //ACAStudentsHostelRooms.SETFILTER("Clearance Date",'%1..',ClearanceCutOff);
                    //     ACAStudentsHostelRooms.SETRANGE(Cleared,TRUE);
                    IF ACAStudentsHostelRooms.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            ACAStudentsHostelRooms.Cleared := TRUE;
                            ACAStudentsHostelRooms.MODIFY;
                            ACAStudentsHostelRooms2.RESET;
                            ACAStudentsHostelRooms2.SETRANGE(ACAStudentsHostelRooms2.Student, ACAStudentsHostelRooms.Student);
                            // ACAStudentsHostelRooms2.SETRANGE(ACAStudentsHostelRooms2."Space No",ACAStudentsHostelRooms."Space No");
                            // ACAStudentsHostelRooms2.SETRANGE(ACAStudentsHostelRooms2."Room No",ACAStudentsHostelRooms."Room No");
                            //  ACAStudentsHostelRooms2.SETRANGE(ACAStudentsHostelRooms2."Hostel No",ACAStudentsHostelRooms."Hostel No");
                            ACAStudentsHostelRooms2.SETRANGE(ACAStudentsHostelRooms2.Semester, CurrSemester);
                            //   ACAStudentsHostelRooms2.SETRANGE(ACAStudentsHostelRooms2."Academic Year",CurrAcademicYear);
                            ACAStudentsHostelRooms2.SETRANGE(Cleared, FALSE);
                            IF NOT ACAStudentsHostelRooms2.FIND('-') THEN BEGIN
                                ACAStudentsHostelRooms2.INIT;
                                ACAStudentsHostelRooms2.Student := ACAStudentsHostelRooms.Student;
                                ACAStudentsHostelRooms2."Space No" := ACAStudentsHostelRooms."Space No";
                                ACAStudentsHostelRooms2."Room No" := ACAStudentsHostelRooms."Room No";
                                ACAStudentsHostelRooms2."Hostel No" := ACAStudentsHostelRooms."Hostel No";
                                ACAStudentsHostelRooms2."Accomodation Fee" := ACAStudentsHostelRooms."Accomodation Fee";
                                ACAStudentsHostelRooms2.Charges := ACAStudentsHostelRooms.Charges;
                                ACAStudentsHostelRooms2.Semester := CurrSemester;
                                ACAStudentsHostelRooms2."Hostel Assigned" := ACAStudentsHostelRooms."Hostel Assigned";
                                ACAStudentsHostelRooms2."Academic Year" := CurrAcademicYear;
                                ACAStudentsHostelRooms2.Gender := ACAStudentsHostelRooms.Gender;
                                ACAStudentsHostelRooms2."Settlement Type" := ACAStudentsHostelRooms."Settlement Type";
                                ACAStudentsHostelRooms2."Campus Code" := ACAStudentsHostelRooms."Campus Code";
                                ACAStudentsHostelRooms2.INSERT;
                                BookRoom(ACAStudentsHostelRooms."Settlement Type", ACAStudentsHostelRooms."Hostel No", ACAStudentsHostelRooms."Room No",
                                ACAStudentsHostelRooms."Space No", ACAStudentsHostelRooms.Student, CurrSemester, ACAStudentsHostelRooms.Gender, CurrAcademicYear, ACAStudentsHostelRooms.Charges);
                            END ELSE BEGIN
                                //IF ACAStudentsHostelRooms2.Allocated=FALSE THEN
                                // BookRoom(ACAStudentsHostelRooms."Settlement Type",ACAStudentsHostelRooms."Hostel No",ACAStudentsHostelRooms."Room No",
                                // ACAStudentsHostelRooms."Space No",ACAStudentsHostelRooms.Student,CurrSemester,ACAStudentsHostelRooms.Gender,CurrAcademicYear,ACAStudentsHostelRooms.Charges);
                            END;
                        END;
                        UNTIL ACAStudentsHostelRooms.NEXT = 0;
                    END;


                    GenJnl.RESET;
                    GenJnl.SETRANGE("Journal Template Name", 'SALES');
                    GenJnl.SETRANGE("Journal Batch Name", 'ACCOM');
                    IF GenJnl.FIND('-') THEN BEGIN
                        //CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Bill",GenJnl);
                    END;
                    MESSAGE('Posted Successfully');
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        ACAAcademicYear.RESET;
        ACAAcademicYear.SETRANGE(Current, TRUE);
        IF ACAAcademicYear.FIND('-') THEN BEGIN
            CurrAcademicYear := ACAAcademicYear.Code;
            SourceAcademicYear := ACAAcademicYear.Code;
        END;

        ACASemesters.RESET;
        ACASemesters.SETRANGE("Current Semester", TRUE);
        IF ACASemesters.FIND('-') THEN BEGIN
            CurrSemester := ACASemesters.Code;
        END;
    end;

    var
        CurrAcademicYear: Code[20];
        SourceAcademicYear: Code[20];
        CurrSemester: Code[20];
        SourceSemester: Code[20];
        ClearanceCutOff: Date;
        ACAStudentsHostelRooms: Record "ACA-Students Hostel Rooms";
        ACAAcademicYear: Record "ACA-Academic Year";
        ACASemesters: Record "ACA-Semesters";
        ACAStudentsHostelRooms2: Record "ACA-Students Hostel Rooms";
        AccPayment: Boolean;
        hostStus: Record "ACA-Students Hostel Rooms";
        charges1: Record "ACA-Charge";
        cou: Integer;
        studRoomBlock: Record "ACA-Students Hostel Rooms";
        Blocks: Record "ACA-Hostel Card";
        /* coReg: Record "ACA-Course Registration";
        HostelLedger: Record "ACA-Hostel Ledger";
        Sem: Record "ACA-Semesters";
        Registered: Boolean;
        acadYear: Record "61382";
        semz: Record "ACA-Semesters";
        PictureExists: Boolean;
        StudentPayments: Record "61536"; */
        // StudentCharge: Record "ACA-Std Charges";
        GenJnl: Record 81;
        Stages: Record "ACA-Programme Stages";
        LineNo: Integer;
        GenJnlLine: Record "Gen. Journal Line";
        Units: Record "ACA-Units/Subjects";
        ExamsByStage: Record "ACA-Exams";
        ExamsByUnit: Record "ACA-Exams By Units";
        Charges: Record "ACA-Charge";
        ChargesRec: Record "ACA-Charge";
        PaidAmt: Decimal;
        Receipt: Record 61538;
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
        GLPosting: Codeunit 12;
        Receipts: Record "ACA-Receipt";
        CustLedg: Record "Cust. Ledger Entry";
        DueDate: Date;
        Sems: Record "ACA-Semesters";
        ChangeLog: Record "Change Log Entry";
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

    procedure BookRoom(settle_m: Code[20]; HostNos: Code[20]; RoomNo: Code[20]; SpaceNo: Code[20]; Student: Code[20]; Semester: Code[20]; Gender: Option " ",Male,Female; AcadYear: Code[20]; chg: Decimal)
    var
        rooms: Record "ACA-Hostel Block Rooms";
        billAmount: Decimal;
    begin
        // --------Check If More Than One Room Has Been Selected
        CLEAR(billAmount);
        rooms.RESET;
        rooms.SETRANGE(rooms."Hostel Code", HostNos);
        rooms.SETRANGE(rooms."Room Code", RoomNo);
        IF rooms.FIND('-') THEN BEGIN
            IF settle_m = 'Special Programme' THEN
                billAmount := rooms."Special Programme"
            ELSE
                IF settle_m = 'KUCCPS' THEN
                    billAmount := rooms."JAB Fees"
                ELSE
                    IF settle_m = 'PSSP' THEN
                        billAmount := rooms."SSP Fees";
            IF billAmount = 0 THEN billAmount := rooms."JAB Fees";

        END;
        Cust.RESET;
        Cust.SETRANGE(Cust."No.", Student);
        IF Cust.FIND('-') THEN BEGIN
        END;


        //---Check if The Student Have Paid The Accomodation Fee
        charges1.RESET;
        charges1.SETRANGE(charges1.Hostel, TRUE);
        IF charges1.FIND('-') THEN BEGIN
        END ELSE
            ERROR('Accommodation not setup.');

        IF Blocks.GET(HostNos) THEN BEGIN
        END;

        Rooms_Spaces.RESET;
        Rooms_Spaces.SETRANGE(Rooms_Spaces."Space Code", SpaceNo);
        IF Rooms_Spaces.FIND('-') THEN BEGIN
            Rooms_Spaces.Status := Rooms_Spaces.Status::"Fully Occupied";
            Rooms_Spaces.MODIFY;
            CLEAR(counts);
            // Post to  the Ledger Tables
            Host_Ledger.RESET;
            IF Host_Ledger.FIND('-') THEN counts := Host_Ledger.COUNT;
            IF NOT Host_Ledger.GET(SpaceNo, RoomNo, HostNos) THEN BEGIN
                Host_Ledger.INIT;
                Host_Ledger."Space No" := SpaceNo;
                Host_Ledger."Room No" := RoomNo;
                Host_Ledger."Hostel No" := HostNos;
                Host_Ledger.No := counts;
                Host_Ledger.Status := Host_Ledger.Status::"Fully Occupied";
                Host_Ledger."Room Cost" := chg;
                Host_Ledger."Student No" := Student;
                Host_Ledger."Receipt No" := '';
                Host_Ledger.Semester := Semester;
                Host_Ledger.Gender := Gender;
                Host_Ledger."Hostel Name" := '';
                Host_Ledger.Campus := Cust."Global Dimension 1 Code";
                Host_Ledger."Academic Year" := AcadYear;
                Host_Ledger.INSERT(TRUE);
            END;


            Hostel_Rooms.RESET;
            Hostel_Rooms.SETRANGE(Hostel_Rooms."Hostel Code", HostNos);
            Hostel_Rooms.SETRANGE(Hostel_Rooms."Room Code", RoomNo);
            IF Hostel_Rooms.FIND('-') THEN BEGIN
                Hostel_Rooms.CALCFIELDS(Hostel_Rooms."Bed Spaces", Hostel_Rooms."Occupied Spaces");
                IF Hostel_Rooms."Bed Spaces" = Hostel_Rooms."Occupied Spaces" THEN
                    Hostel_Rooms.Status := Hostel_Rooms.Status::"Fully Occupied"
                ELSE
                    IF Hostel_Rooms."Occupied Spaces" < Hostel_Rooms."Bed Spaces" THEN
                        Hostel_Rooms.Status := Hostel_Rooms.Status::"Partially Occupied";
                Hostel_Rooms.MODIFY;
            END;
            ACAStudentsHostelRooms2.RESET;
            ACAStudentsHostelRooms2.SETRANGE(ACAStudentsHostelRooms2.Student, Student);
            ACAStudentsHostelRooms2.SETRANGE(ACAStudentsHostelRooms2."Space No", SpaceNo);
            ACAStudentsHostelRooms2.SETRANGE(ACAStudentsHostelRooms2."Room No", RoomNo);
            ACAStudentsHostelRooms2.SETRANGE(ACAStudentsHostelRooms2."Hostel No", HostNos);
            ACAStudentsHostelRooms2.SETRANGE(ACAStudentsHostelRooms2.Semester, Semester);
            //   ACAStudentsHostelRooms2.SETRANGE(ACAStudentsHostelRooms2."Academic Year",AcadYear);
            IF ACAStudentsHostelRooms2.FIND('-') THEN BEGIN
                ACAStudentsHostelRooms2.Billed := TRUE;
                ACAStudentsHostelRooms2."Billed Date" := TODAY;
                ACAStudentsHostelRooms2."Allocation Date" := TODAY;
                ACAStudentsHostelRooms2."Allocated By" := USERID;
                ACAStudentsHostelRooms2."Time allocated" := TIME;
                ACAStudentsHostelRooms2.Allocated := TRUE;
                ACAStudentsHostelRooms2.MODIFY;
            END;


        END;


        postCharge(Student, Semester, SpaceNo, chg);
        // UNTIL StudentHostel.NEXT=0;

        // END;
    end;

    local procedure postCharge(Student: Code[20]; Semester: Code[20]; SpaceNo: Code[20]; charges2: Decimal)
    begin
        charges1.RESET;
        charges1.SETRANGE(charges1.Hostel, TRUE);
        IF NOT charges1.FIND('-') THEN BEGIN
            ERROR('The charges Setup does not have an item tagged as Hostel.');
        END;

        IF Cust.GET(Student) THEN;



        GenSetUp.GET();

        DueDate := StudentCharges.Date;

        IF DueDate = 0D THEN DueDate := TODAY;
        LineNo := LineNo + 10;
        GenJnl.INIT;
        GenJnl."Line No." := LineNo;
        GenJnl."Posting Date" := TODAY;
        GenJnl."Document No." := CurrSemester + ' Hostel';
        GenJnl.VALIDATE(GenJnl."Document No.");
        GenJnl."Journal Template Name" := 'SALES';
        GenJnl."Journal Batch Name" := 'ACCOM';
        GenJnl."Account Type" := GenJnl."Account Type"::Customer;
        //
        IF Cust.GET(Student) THEN BEGIN
            IF Cust."Bill-to Customer No." <> '' THEN
                GenJnl."Account No." := Cust."Bill-to Customer No."
            ELSE
                GenJnl."Account No." := Student;
        END;

        GenJnl.Amount := charges2;
        GenJnl.VALIDATE(GenJnl."Account No.");
        GenJnl.VALIDATE(GenJnl.Amount);
        GenJnl.Description := charges1.Description;
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

        GenJnl."Recovery Priority" := 25;

        IF GenJnl.Amount <> 0 THEN
            GenJnl.INSERT;
    end;
}

