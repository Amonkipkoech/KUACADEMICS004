page 68768 "ACA-Students Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = Customer;
    SourceTableView = WHERE("Customer Posting Group" = FILTER('STUDENT'),
                            Blocked = FILTER(' '));

    layout
    {
        area(content)
        {
            group("General Information")
            {
                Caption = 'General Information';
                field("No."; Rec."No.")
                {
                    Editable = true;
                    ApplicationArea = All;
                    caption = 'Registration No.';
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Caption = 'Full  Names';

                    //Visible = false;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = All;
                }
                field(Nationality; Rec.Nationality)
                {
                    ApplicationArea = All;
                }
                field(countryName; Rec.countryName)
                {
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                }
                field(Department;rec.Department)
                {
                    ApplicationArea = all;
                }

                field("County of Origin"; Rec."County of Origin")
                {
                    ApplicationArea = All;
                }
                field("ID No"; Rec."ID No")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Passport No"; Rec."Passport No")
                {
                    ApplicationArea = All;
                }

                field("High Sch. Index Number"; "High Sch. Index Number")
                {
                    ApplicationArea = All;
                }
                // field(Tribe; Rec.Tribe)
                // {
                //     ApplicationArea = All;
                //     Caption = 'Ethnicity';
                // }
                field("Disability Status"; Rec."Disability Status")
                {
                    ApplicationArea = All;
                }
                field("Disability Type"; Rec."Disability Type")
                {
                    ApplicationArea = All;
                }

                field("Disability Description"; Rec."Disability Description")
                {
                    ApplicationArea = All;
                }
                field("Disability No."; Rec."Disability No.")
                {
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
                field("Allien Number"; Rec."Allien Number")
                {
                    ApplicationArea = All;
                }
                field(bioDataVerified; Rec.bioDataVerified)
                {
                    ApplicationArea = All;
                }
                field(stubioDatVER; Rec.stubioDatVER)
                {
                    ApplicationArea = All;
                }
            }
            group("Contact Information")
            {
                Caption = 'Contact Information';
                // field("Primary Contact No."; Rec."Primary Contact No.")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Primary Mobile No';
                // }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }


                field("Alternate Mobile"; Rec."Alternate Mobile")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    Caption = 'Personal Email';
                }
                field("College Mail"; Rec."University Email")
                {
                    Caption = 'College Mail';
                    ApplicationArea = All;
                }
                field("Email Password"; Rec."Email Password")
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    Caption = 'Postal Address';
                    ApplicationArea = All;
                }
                field("Barcode Picture"; Rec."Barcode Picture")
                {

                    ApplicationArea = All;

                }
            }


            // field("Address 2"; Rec."Address 2")
            // {
            //     ApplicationArea = All;
            // }


            group("Other Information")
            {
                Caption = 'Other Information';
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                }
                // field("Phone No."; Rec."Phone No.")
                // {
                //     ApplicationArea = All;
                // }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Department Code';
                    ApplicationArea = All;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ApplicationArea = All;
                }


                field("Customer Type"; Rec."Customer Type")
                {
                    ApplicationArea = All;
                }
                field("Date Registered"; Rec."Date Registered")
                {
                    ApplicationArea = All;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ApplicationArea = All;
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ApplicationArea = All;
                }
                // field(Blocked; Rec.Blocked)
                // {
                //     ApplicationArea = All;
                // }
                field(Status; Rec.Status)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Status Change Date"; Rec."Status Change Date")
                {
                    ApplicationArea = All;
                }
                field("Confirmed Remarks"; Rec."Confirmed Remarks")
                {
                    Caption = 'Status Remarks';
                    ApplicationArea = All;
                }
                field("ID Card Expiry Year"; Rec."ID Card Expiry Year")
                {
                    ApplicationArea = All;
                }
                field(Password; Rec.Password)
                {
                    ApplicationArea = All;
                }
                field("Gown 3"; Rec."Gown 3")
                {
                    ApplicationArea = All;
                }
                field("Gown Status"; Rec."Gown Status")
                {
                    ApplicationArea = All;
                }
                field("Date Issued"; Rec."Date Issued")
                {
                    ApplicationArea = All;
                }
                field("Date Returned"; Rec."Date Returned")
                {
                    ApplicationArea = All;
                }
                field("Certificate Status"; Rec."Certificate Status")
                {
                    ApplicationArea = All;
                }
                field("Date Collected"; Rec."Date Collected")
                {
                    ApplicationArea = All;
                }
                field("Certificate No."; Rec."Certificate No.")
                {
                    ApplicationArea = All;
                }
                field("Transfer to No."; Rec."Transfer to No.")
                {
                    ApplicationArea = All;
                }
                field("Transfer to"; Rec."Transfer to")
                {
                    ApplicationArea = All;
                }
                field("Changed Password"; Rec."Changed Password")
                {
                    ApplicationArea = All;
                }
                field("Exempt"; Rec."Fee Cleared")
                {
                    Caption = 'Exempt';
                    ApplicationArea = All;
                }

                // field("Library Category"; Rec."Library Category")
                // {
                //     ApplicationArea = All;
                // }
                // field("Can Use Library"; Rec."Can Use Library")
                // {
                //     ApplicationArea = All;
                // }
                // field("Library Expiry Date"; Rec."Library Expiry Date")
                // {
                //     ApplicationArea = All;
                // }
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
                action("Tremester registration")
                {
                    Caption = 'Tremester registration';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 68756;
                    RunPageLink = "Student No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Student exam Units")
                {
                    Caption = 'Student Exam Units';
                    Image = BOMRegisters;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 68778;
                    RunPageLink = "Student No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Student  theory Units")
                {
                    Caption = 'Student theory units Units';
                    Image = BOMRegisters;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "ACA-Student Theory Units";
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
                action("Proforma Invoice")
                {
                    Caption = 'Proforma Invoice';
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = true;
                    ApplicationArea = All;
                    RunObject = report "Student Proforma Invoice2";


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
                            REPORT.RUN(77122, TRUE, TRUE, Cust);
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
                    RunPageLink = "No." = field("No.");
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
                action(units)
                {
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        changeStatus()
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
                    Rec."Old Student Code" := Rec."No.";
                    Rec.MODIFY;
                    IF Rec.RENAME(Rec."Transfer to No.") THEN BEGIN
                    END;
                    /*
                    IF NOT Cust.GET("Transfer to No.") THEN BEGIN
                    Cust.INIT;
                    Cust."No.":="Transfer to No.";
                    Cust.Name:=Name;
                    Cust.VALIDATE(Cust.Name);
                    Cust."Global Dimension 1 Code":="Global Dimension 1 Code";
                    Cust."Customer Posting Group":="Customer Posting Group";
                    Cust."Application Method":=Cust."Application Method"::"Apply to Oldest";
                    Cust.Status:=Cust.Status::Current;
                    Cust."Customer Type":=Cust."Customer Type"::Student;
                    Cust."Date Registered":="Date Registered";
                    Cust.INSERT(TRUE);
                    END;
                    
                    
                    GenJnl.RESET;
                    GenJnl.SETRANGE("Journal Template Name",'SALES');
                    GenJnl.SETRANGE("Journal Batch Name",'STUD PAY');
                    GenJnl.DELETEALL;
                    
                    
                    
                    CustL.RESET;
                    CustL.SETRANGE(CustL."Customer No.","No.");
                    IF CustL.FIND('-') THEN BEGIN
                    REPEAT
                    CustL.CALCFIELDS(CustL.Amount);
                    GenJnl.INIT;
                    GenJnl."Line No." := GenJnl."Line No." + 10000;
                    GenJnl."Posting Date":=CustL."Posting Date";
                    GenJnl."Document No.":=CustL."Document No.";
                    GenJnl.VALIDATE(GenJnl."Document No.");
                    GenJnl."Journal Template Name":='SALES';
                    GenJnl."Journal Batch Name":='STUD PAY';
                    GenJnl."Account Type":=GenJnl."Account Type"::Customer;
                    GenJnl."Account No.":="No.";
                    GenJnl.Amount:=CustL.Amount*-1;
                    GenJnl.VALIDATE(GenJnl."Account No.");
                    GenJnl.VALIDATE(GenJnl.Amount);
                    GenJnl.Description:=CustL.Description;
                    //GenJnl."Bal. Account Type":=GenJnl."Bal. Account Type"::Customer;
                    //GenJnl."Bal. Account No.":="Transfer to No.";
                    GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                    {
                    CReg.RESET;
                    CReg.SETRANGE(CReg."Student No.","No.");
                    IF CReg.FIND('+') THEN BEGIN
                    }
                    IF GenJnl.Amount<>0 THEN
                    GenJnl.INSERT;
                    
                    
                    GenJnl.INIT;
                    GenJnl."Line No." := GenJnl."Line No." + 10000;
                    GenJnl."Posting Date":=CustL."Posting Date";
                    GenJnl."Document No.":=CustL."Document No.";
                    GenJnl.VALIDATE(GenJnl."Document No.");
                    GenJnl."Journal Template Name":='SALES';
                    GenJnl."Journal Batch Name":='STUD PAY';
                    GenJnl."Account Type":=GenJnl."Account Type"::Customer;
                    GenJnl."Account No.":="Transfer to No.";
                    GenJnl.Amount:=CustL.Amount;
                    GenJnl.VALIDATE(GenJnl."Account No.");
                    GenJnl.VALIDATE(GenJnl.Amount);
                    GenJnl.Description:=CustL.Description;
                    //GenJnl."Bal. Account Type":=GenJnl."Bal. Account Type"::Customer;
                    //GenJnl."Bal. Account No.":="Transfer to No.";
                    //GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                    //GenJnl."Shortcut Dimension 2 Code":="Transfer to";
                    //GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                    IF GenJnl.Amount<>0 THEN
                    GenJnl.INSERT;
                    CustL.DELETE;
                    UNTIL CustL.NEXT=0;
                    END;
                    
                    Receipts.RESET;
                    Receipts.SETRANGE(Receipts."Student No.","No.");
                    Receipts.SETRANGE(Receipts.Reversed,FALSE);
                    IF Receipts.FIND('-') THEN BEGIN
                    REPEAT
                    Receipts."Student No.":="Transfer to No.";
                    Receipts.MODIFY;
                    UNTIL Receipts.NEXT=0;
                    END;
                    
                    
                    
                    //Post
                    GenJnl.RESET;
                    GenJnl.SETRANGE("Journal Template Name",'SALES');
                    GenJnl.SETRANGE("Journal Batch Name",'STUD PAY');
                    IF GenJnl.FIND('-') THEN BEGIN
                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",GenJnl);
                    END;
                    
                    
                    
                    Status:=Status::Transferred;
                    Blocked:=Blocked::All;
                    MODIFY;
                    
                    */

                    MESSAGE('%1', 'Student transferred successfully.');

                end;
            }
            action("Student Kin")
            {
                Image = CustomerContact;
                Promoted = true;
                RunObject = Page 68752;
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
                RunObject = Page 68753;
                RunPageLink = "Student No." = FIELD("No.");
                ApplicationArea = All;
            }
            action("Student Disciplinary Details")
            {
                Image = Addresses;
                Promoted = true;
                RunObject = Page 68755;
                RunPageLink = "Student No." = FIELD("No.");
                ApplicationArea = All;
            }
            action("Students Units Booking")
            {
                Image = ReceivableBill;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;
                // RunObject = Page 68818;
                // RunPageLink = Cleared = FIELD("No.");
            }
            action("Student Units Exemptions")
            {
                Image = Reserve;
                Promoted = true;
                RunObject = Page 68791;
                RunPageLink = "Student No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Customer Price Group" := 'Student';
        Rec."Customer Type" := Rec."Customer Type"::Student;
    end;

    procedure changeStatus() nos: integer

    begin
        nos := 0;
        customer.RESET;
        IF Customer.FIND('-') THEN begin
            REPEAT
                if Customer.Status = Customer.Status::Halt then begin
                    Customer.Status := Customer.Status::Current;
                    Customer.Modify();
                    nos += 1;
                end;


            UNTIL Customer.Next = 0;
        end;
    end;

    var
        PictureExists: Boolean;
        StudentPayments: Record "ACA-Std Payments";
        StudentCharges: Record "ACA-Std Charges";
        GenJnl: Record "Gen. Journal Line";
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
        CurrentBal: Decimal;
        Prog: Record "ACA-Programme";
        "Settlement Type": Record "ACA-Settlement Type";
        AccPayment: Boolean;
        SettlementType: Code[20];
        CustL: Record "Cust. Ledger Entry";
        Stages3: Record "ACA-Programme Stages";
        Units3: Record "ACA-Units/Subjects";
        ExamsByStage3: Record "ACA-Exams";
        ExamsByUnit3: Record "ACA-Exams By Units";
        Charges3: Record "ACA-Charge";
        Receipt3: Record "ACA-Receipt";

        stud: Record Customer;
        Customer: Record Customer;

}

