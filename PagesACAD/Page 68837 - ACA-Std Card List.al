/// <summary>
/// Page ACA-Std Card List (ID 68837).
/// </summary>
page 68837 "ACA-Std Card List"
{
    Caption = 'All Students List';
    CardPageID = "ACA-Students Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Customer;
    SourceTableView = WHERE("Customer Type" = CONST(Student),
                            Blocked = CONST(" "));

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies the value of the First Name field.';
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ToolTip = 'Specifies the value of the Middle Name field.';
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field.';
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Current Programme"; Rec."Current Programme")
                {
                    ApplicationArea = All;
                }
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    Caption = 'Town';
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Tagged as Graduating"; Rec."Tagged as Graduating")
                {
                    ApplicationArea = All;
                }
                field("Graduating Academic Year"; Rec."Graduating Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Disability"; Rec."Disability Status")
                {
                    ApplicationArea = All;
                }
                field("Alien No"; Rec."Allien Number")
                {
                    ApplicationArea = All;

                }
                field("Disabilty Type"; Rec."Disability Type")
                {
                    ApplicationArea = All;
                }
                field("Date of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = All;
                }
                field("Nationalty"; Rec.Nationality)
                {
                    ApplicationArea = all;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = All;
                }
                field("County"; Rec."County of Origin")
                {
                    ApplicationArea = all;
                }
                field("Index Number"; Rec."High Sch. Index Number")
                {
                    ApplicationArea = All;
                }
                field("Ethnicity"; Rec.Ethnicity)
                {
                    ApplicationArea = All;
                }
                field("Alternative Mobile No"; Rec."Alternate Mobile")
                {

                    ApplicationArea = All;
                }
                field("Personal Email"; Rec."E-Mail")
                {
                    caption = 'Personal E-mail';
                    ApplicationArea = All;
                }
                field("Postal Adress"; Rec."Post Code")
                {
                    caption = 'Postal Adress';
                    ApplicationArea = All;
                }
                field(Religion; Rec.Religion)
                {
                    ApplicationArea = All;
                }
                field(Denomiation; Rec.Denomiation)
                {
                    ApplicationArea = All;
                }
                field(Congregation; Rec.Congregation)
                {
                    ApplicationArea = All;
                }

                field("Disability No."; Rec."Disability No.")
                {
                    ApplicationArea = All;
                }


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
                action("Semester Registration")
                {
                    Caption = 'Semester Registration';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 68756;
                    RunPageLink = "Student No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action(StoppedReg)
                {
                    Caption = 'Stopped Registrations';
                    Image = StopPayment;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 77721;
                    RunPageLink = "Student No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Student Units")
                {
                    Caption = 'Student Units';
                    Image = BOMRegisters;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 68778;
                    RunPageLink = "Student No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Print Statement")
                {
                    Caption = 'Print Statement';
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Cust.RESET;
                        Cust.SETFILTER(Cust."No.", Rec."No.");
                        IF Cust.FIND('-') THEN
                            REPORT.RUN(51072, TRUE, TRUE, Cust);
                    end;
                }
                action(Picture)
                {
                    Caption = 'Photo';
                    Ellipsis = false;
                    Image = Picture;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page 68855;
                    RunPageLink = "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action(Comments)
                {
                    Caption = 'Comments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Customer), "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Registration Details")
                {
                    Caption = 'Registration Details';
                    Image = Info;
                    RunObject = Page 68759;
                    RunPageLink = "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action(Register)
                {
                    Caption = 'Register';
                    Image = Confirm;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.CALCFIELDS("Balance (LCY)");
                        IF Rec."Balance (LCY)" > 0 THEN
                            //ERROR('You cannot register a student with a balance.');



                            CourseReg.RESET;
                        CourseReg.SETRANGE(CourseReg."Student No.", Rec."No.");
                        IF CourseReg.FIND('+') THEN BEGIN
                            CourseReg.Registered := TRUE;
                            CourseReg.MODIFY;
                        END;
                    end;
                }
                action("De-Register")
                {
                    Caption = 'De-Register';
                    Image = ChangeStatus;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CourseReg.RESET;
                        CourseReg.SETRANGE(CourseReg."Student No.", Rec."No.");
                        IF CourseReg.FIND('+') THEN BEGIN
                            CourseReg.Registered := FALSE;
                            CourseReg.MODIFY;
                        END;
                    end;
                }
                action("Mark As Alluminae")
                {
                    Caption = 'Mark As Alluminae';
                    Image = Status;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Are you sure you want to mark this students as an alluminae?', TRUE) = TRUE THEN BEGIN
                            Rec.Status := Rec.Status::Alluminae;
                            Rec.MODIFY;
                        END;
                    end;
                }
                action(Irregularities)
                {
                    Caption = 'Irregularities Register';
                    Image = Picture;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 77737;
                    RunPageLink = "Student No." = FIELD("No.");
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ACAIrregularitiesRegister: Record "ACA-Irregularities Register";
                    begin
                    end;
                }
            }
        }
        area(processing)
        {
            action("Student ID Card")
            {
                Caption = 'Student ID Card';
                Image = Picture;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //stud.RESET;
                    //stud.SETRANGE(stud."No.","No.");
                    //IF stud.FIND('+') THEN
                    //REPORT.RUN(39006250,TRUE,FALSE,stud);
                    stud.RESET;
                    stud.SETRANGE(stud."No.", Rec."No.");
                    IF stud.FIND('+') THEN
                        REPORT.RUN(51729, TRUE, FALSE, stud);
                end;
            }
            action(IDChecklist)
            {
                Caption = 'ID Checklist';
                Image = CheckList;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    // // stud.RESET;
                    // // stud.SETRANGE(stud."No.","No.");
                    // // IF stud.FIND('+') THEN
                    REPORT.RUN(77700, TRUE, FALSE);
                end;
            }
            action("Transfer Student Accounts")
            {
                Caption = 'Transfer Student Accounts';
                Image = TransferFunds;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.TESTFIELD("Transfer to No.");
                    Rec.TESTFIELD("Transfer to");
                    Rec.CALCFIELDS("Balance (LCY)");
                    IF NOT Cust.GET(Rec."Transfer to No.") THEN BEGIN
                        Cust.INIT;
                        Cust."No." := Rec."Transfer to No.";
                        Cust.Name := Rec.Name;
                        Cust.VALIDATE(Cust.Name);
                        Cust."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                        Cust."Customer Posting Group" := Rec."Customer Posting Group";
                        Cust."Application Method" := Cust."Application Method"::"Apply to Oldest";
                        Cust.Status := Cust.Status::Current;
                        Cust."Customer Type" := Cust."Customer Type"::Student;
                        Cust."Date Registered" := Rec."Date Registered";
                        Cust.INSERT(TRUE);
                    END;



                    GenJnl.RESET;
                    GenJnl.SETRANGE("Journal Template Name", 'SALES');
                    GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                    GenJnl.DELETEALL;



                    CustL.RESET;
                    CustL.SETRANGE(CustL."Customer No.", Rec."No.");
                    IF CustL.FIND('-') THEN BEGIN
                        REPEAT
                            CustL.CALCFIELDS(CustL.Amount);
                            GenJnl.INIT;
                            GenJnl."Line No." := GenJnl."Line No." + 10000;
                            GenJnl."Posting Date" := CustL."Posting Date";
                            GenJnl."Document No." := CustL."Document No.";
                            GenJnl.VALIDATE(GenJnl."Document No.");
                            GenJnl."Journal Template Name" := 'SALES';
                            GenJnl."Journal Batch Name" := 'STUD PAY';
                            GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                            GenJnl."Account No." := Rec."No.";
                            GenJnl.Amount := CustL.Amount * -1;
                            GenJnl.VALIDATE(GenJnl."Account No.");
                            GenJnl.VALIDATE(GenJnl.Amount);
                            GenJnl.Description := CustL.Description;
                            //GenJnl."Bal. Account Type":=GenJnl."Bal. Account Type"::Customer;
                            //GenJnl."Bal. Account No.":="Transfer to No.";
                            GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                            /*
                            CReg.RESET;
                            CReg.SETRANGE(CReg."Student No.","No.");
                            IF CReg.FIND('+') THEN BEGIN
                            */
                            IF GenJnl.Amount <> 0 THEN
                                GenJnl.INSERT;


                            GenJnl.INIT;
                            GenJnl."Line No." := GenJnl."Line No." + 10000;
                            GenJnl."Posting Date" := CustL."Posting Date";
                            GenJnl."Document No." := CustL."Document No.";
                            GenJnl.VALIDATE(GenJnl."Document No.");
                            GenJnl."Journal Template Name" := 'SALES';
                            GenJnl."Journal Batch Name" := 'STUD PAY';
                            GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                            GenJnl."Account No." := Rec."Transfer to No.";
                            GenJnl.Amount := CustL.Amount;
                            GenJnl.VALIDATE(GenJnl."Account No.");
                            GenJnl.VALIDATE(GenJnl.Amount);
                            GenJnl.Description := CustL.Description;
                            //GenJnl."Bal. Account Type":=GenJnl."Bal. Account Type"::Customer;
                            //GenJnl."Bal. Account No.":="Transfer to No.";
                            //GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                            //GenJnl."Shortcut Dimension 2 Code":="Transfer to";
                            //GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                            IF GenJnl.Amount <> 0 THEN
                                GenJnl.INSERT;

                        UNTIL CustL.NEXT = 0;
                    END;

                    Receipts.RESET;
                    Receipts.SETRANGE(Receipts."Student No.", Rec."No.");
                    Receipts.SETRANGE(Receipts.Reversed, FALSE);
                    IF Receipts.FIND('-') THEN BEGIN
                        REPEAT
                            Receipts."Student No." := Rec."Transfer to No.";
                            Receipts.MODIFY;
                        UNTIL Receipts.NEXT = 0;
                    END;



                    //Post
                    GenJnl.RESET;
                    GenJnl.SETRANGE("Journal Template Name", 'SALES');
                    GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                    IF GenJnl.FIND('-') THEN BEGIN
                        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJnl);
                    END;



                    Rec.Status := Rec.Status::Transferred;
                    Rec.Blocked := Rec.Blocked::All;
                    Rec.MODIFY;



                    MESSAGE('%1', 'Student transferred successfully.');

                end;
            }
            action("Student Kin")
            {
                Image = CustomerContact;
                Promoted = true;
                RunObject = Page "ACA-Student Kin";
                RunPageLink = "Student No" = FIELD("No.");
                ApplicationArea = All;
            }
            action(Sponsors)
            {
                Image = CustomerCode;
                Promoted = true;
                RunObject = Page 68754;
                RunPageLink = "Student No." = FIELD("No.");
                ApplicationArea = All;
            }
            action("Student Education History")
            {
                Image = History;
                Promoted = true;
                RunObject = Page "ACA-Student Education History";
                RunPageLink = "Student No." = FIELD("No.");
                ApplicationArea = All;
            }
            action("Student Disciplinary Details")
            {
                Image = Addresses;
                Promoted = true;
                RunObject = Page "ACA-Student Disciplinary Det.";
                RunPageLink = "Student No." = FIELD("No.");
                ApplicationArea = All;
            }

            action("Student Units Exemptions")
            {
                Image = Reserve;
                Promoted = true;
                RunObject = Page 68791;
                RunPageLink = "Student No." = FIELD("No.");
                ApplicationArea = All;
            }
            action("Catering Funds Transfer")
            {
                RunObject = Page 68110;
                RunPageLink = "Student No" = FIELD("No."),
                              Posted = FILTER(false);
                ApplicationArea = All;
            }
        }
    }

    var
        stud: Record Customer;
        EducationHistory: Record "ACA-Student Education History";
        EnrollmentEducationHistory: Record "ACA-Enquiry Education History";
        StudentGuardian: Record "ACA-Student Sponsors Details";
        EnrollmentGuardian: Record "ACA-Enquiry Guardian/Sponsor";
        StudentKin: Record "ACA-Student Kin";
        EnrollmentNextofKin: Record "ACA-Enquiry Next Of Kin";
        CourseRegistration: Record "ACA-Course Registration";
        Enrollment: Record "ACA-Enquiry Header";
        PictureExists: Boolean;
        StudentRec: Record 18;

        districtname: Text[50];
        districtrec: Record "ACA-Academics Central Setups";
        Cust: Record Customer;
        GenJnl: Record "Gen. Journal Line";
        PDate: Date;
        CReg: Record "ACA-Course Registration";
        Prog: Record "ACA-Programme";
        TransInv: Boolean;
        TransRec: Boolean;
        Receipts: Record "ACA-Receipt";
        CustL: Record "Cust. Ledger Entry";
        StudentPayments: Record "ACA-Std Payments";
        StudentCharges: Record "ACA-Std Charges";


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
        BankLedg: Record "Bank Account Ledger Entry";
        DCustLedg: Record "Detailed Cust. Ledg. Entry";
        DocNo: Code[20];
        VendLedg: Record "Vendor Ledger Entry";
        DVendLedg: Record "Detailed Vendor Ledg. Entry";
        VATEntry: Record "VAT Entry";
        StudCharges: Record "ACA-Std Charges";
        CustLed2: Record "Cust. Ledger Entry";
        Receipt2: Record "ACA-Receipt";
        Cont: Boolean;
        CustPostGroup: Record "Customer Posting Group";

        window: Dialog;

        CustLedg: Record "Cust. Ledger Entry";
        DueDate: Date;
        Sems: Record "ACA-Semesters";
        ChangeLog: Record "Change Log Entry";
        CurrentBal: Decimal;
        "Settlement Type": Record "ACA-Settlement Type";
        AccPayment: Boolean;
        SettlementType: Code[20];
        impexp: Option " ",Import,Export;
        NewstdNo: Code[20];
        StringCounts: Integer;
    // Barcodes: Record "60003";

    procedure GetSelectionFilter(): Code[80]
    var
        Cust: Record Customer;
        FirstCust: Code[30];
        LastCust: Code[30];
        SelectionFilter: Code[250];
        CustCount: Integer;
        More: Boolean;
    begin
        CurrPage.SETSELECTIONFILTER(Cust);
        CustCount := Cust.COUNT;
        IF CustCount > 0 THEN BEGIN
            Cust.FIND('-');
            WHILE CustCount > 0 DO BEGIN
                CustCount := CustCount - 1;
                Cust.MARKEDONLY(FALSE);
                FirstCust := Cust."No.";
                LastCust := FirstCust;
                More := (CustCount > 0);
                WHILE More DO
                    IF Cust.NEXT = 0 THEN
                        More := FALSE
                    ELSE
                        IF NOT Cust.MARK THEN
                            More := FALSE
                        ELSE BEGIN
                            LastCust := Cust."No.";
                            CustCount := CustCount - 1;
                            IF CustCount = 0 THEN
                                More := FALSE;
                        END;
                IF SelectionFilter <> '' THEN
                    SelectionFilter := SelectionFilter + '|';
                IF FirstCust = LastCust THEN
                    SelectionFilter := SelectionFilter + FirstCust
                ELSE
                    SelectionFilter := SelectionFilter + FirstCust + '..' + LastCust;
                IF CustCount > 0 THEN BEGIN
                    Cust.MARKEDONLY(TRUE);
                    Cust.NEXT;
                END;
            END;
        END;
        EXIT(SelectionFilter);
    end;

    /// <summary>
    /// SetSelection.
    /// </summary>
    /// <param name="Cust">VAR Record 18.</param>
    procedure SetSelection(var Cust: Record Customer)
    begin
        CurrPage.SETSELECTIONFILTER(Cust);
    end;
}

