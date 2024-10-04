page 68751 "ACA-Student Card"
{
    Editable = true;
    PageType = Card;
    SaveValues = true;
    SourceTable = Customer;
    SourceTableView = WHERE("Customer Type" = CONST(Student),
                            Status = FILTER(Registration | Current | Deffered | Transferred),
                            Blocked = CONST(" "));

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
                    Caption = 'Name(*)';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("ID No"; Rec."ID No")
                {
                    Caption = 'ID No(*)';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("KNEC No"; Rec."KNEC No")
                {
                    Caption = 'KCSE No';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Passport No"; Rec."Passport No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Birth Cert"; Rec."Birth Cert")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Date Registered"; Rec."Date Registered")
                {
                    Caption = 'Date Registered(*)';
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF (Rec."ID No" = '') AND (Rec."Passport No" = '') AND (Rec."KNEC No" = '') AND (Rec."Birth Cert" = '') THEN
                            MESSAGE('You must specify either ID No, Passport No, KNEC No OR Birth Cert. No');
                    end;
                }
                field("Accredited Centre no."; Rec."Accredited Centre no.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Payments By"; Rec."Payments By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("HELB No."; Rec."HELB No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Religion; Rec.Religion)
                {
                    Caption = 'Religion';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Application Method"; Rec."Application Method")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Application No."; Rec."Application No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Citizenship; Rec.Citizenship)
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
                field(District; Rec.District)
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin

                        districtname := '';
                        districtrec.SETRANGE(districtrec.Code, Rec.District);
                        IF districtrec.FIND('-') THEN
                            districtname := districtrec.Description;
                    end;
                }
                field(districtname; districtname)
                {
                    Caption = 'District Name';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    Caption = 'Posting Group(*)';
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF (Rec."ID No" = '') AND (Rec."Passport No" = '') AND (Rec."KNEC No" = '') AND (Rec."Birth Cert" = '') THEN
                            ERROR('You must specify either ID No, Passport No, KNEC No OR Birth Cert. No');

                        /*
                        IF (Address = '') THEN
                        ERROR('You must specify the student Adrress.');
                        
                        IF ("Phone No." = '') THEN
                        ERROR('You must specify the student Phone number.');
                        
                        IF  ("E-Mail" = '') THEN
                        ERROR('You must specify the student E-Mail adrress.');
                        */

                    end;
                }
                field(Blocked; Rec.Blocked)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Lib Membership"; Rec."Lib Membership")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Can Use Library"; Rec."Can Use Library")
                {
                    Caption = 'Exists in Library';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Status Change Date"; Rec."Status Change Date")
                {
                    ApplicationArea = All;
                }
                field("Deferement Period"; Rec."Deferement Period")
                {
                    ApplicationArea = All;
                }
                field(Picture; Rec.Image)
                {
                    ApplicationArea = All;
                }
                field("Confirmed Ok"; Rec."Confirmed Ok")
                {
                    Caption = 'Online Confirmed';
                    ApplicationArea = All;
                }
                field(sms_Password; Rec.sms_Password)
                {
                    ApplicationArea = All;
                }
                field(Password; Rec.Password)
                {
                    ApplicationArea = All;
                }
            }
            group("Programme Registration")
            {
                Caption = 'Programme Registration';
#pragma warning disable AL0269
                part(cR; "ACA-Course Registration New")
#pragma warning restore AL0269
                {
                    SubPageLink = "Student No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }
            group("Next Of Kin")
            {
                Caption = 'Next Of Kin';
#pragma warning disable AL0269
                part(SK; "ACA-Student Kin")
#pragma warning restore AL0269
                {
                    SubPageLink = "Student No" = FIELD("No.");
                    ApplicationArea = All;
                }
            }
            group("Sponsors Details")
            {
                Caption = 'Sponsors Details';
#pragma warning disable AL0269
                part(sD; "ACA-Student Sponsors Details")
#pragma warning restore AL0269
                {
                    SubPageLink = "Student No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }
            group("Education History")
            {
                Caption = 'Education History';
#pragma warning disable AL0269
                part(EH; "ACA-Student Education History")
#pragma warning restore AL0269
                {
                    SubPageLink = "Student No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }
            group("Disciplinary Details")
            {
                Caption = 'Disciplinary Details';
#pragma warning disable AL0269
                part(DD; "ACA-Student Disciplinary Det.")
#pragma warning restore AL0269
                {
                    SubPageLink = "Student No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }
            group("Course Registration")
            {
                Caption = 'Course Registration';
#pragma warning disable AL0269
                part(COR; "ACA-Student Units")
#pragma warning restore AL0269
                {
                    SubPageLink = "Student No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }
            group("Units Booking")
            {
                Caption = 'Units Booking';
            }
            group(Exemptions)
            {
                Caption = 'Exemptions';
#pragma warning disable AL0269
                part(EX; "ACA-Std Units Exemptions")
#pragma warning restore AL0269
                {
                    SubPageLink = "Student No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }
            group("Contact Details")
            {
                Caption = 'Contact Details';
                Editable = true;
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    Caption = 'Guardian/Sponsor Address';
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    Caption = 'Postal Code/City';
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
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
            }
            group("Graduation Details")
            {
                Caption = 'Graduation Details';
                Editable = true;
                field("Gown 1"; Rec."Gown 1")
                {
                    ApplicationArea = All;
                }
                field("Gown 2"; Rec."Gown 2")
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
                field("ID Card Expiry Year"; Rec."ID Card Expiry Year")
                {
                    ApplicationArea = All;
                }
            }
            group(Transfer)
            {
                Caption = 'Transfer';
                Editable = true;
                field("Transfer to No."; Rec."Transfer to No.")
                {
                    ApplicationArea = All;
                }
                field("Barcode Picture"; Rec."Barcode Picture")
                {
                    ApplicationArea = All;
                }
                field("Transfer to"; Rec."Transfer to")
                {
                    ApplicationArea = All;
                }
            }
            group(Barcodes)
            {
                Caption = 'Barcode';
                field(Barcode; Rec."Barcode Picture")
                {
                    Caption = 'Barcode';
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
                action(Comments)
                {
                    Caption = 'Comments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Customer),
                                  "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Registration Details")
                {
                    Caption = 'Registration Details';
                    RunObject = Page 68759;
                    RunPageLink = "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                separator(___________________________)
                {
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
                separator(_______________________________________________)
                {
                }
                action("Mark As Alluminae")
                {
                    Caption = 'Mark As Alluminae';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Are you sure you want to mark this students as an alluminae?', TRUE) = TRUE THEN BEGIN
                            Rec.Status := Rec.Status::Alluminae;
                            Rec.MODIFY;
                        END;
                    end;
                }
                separator(____________________)
                {
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
                    Stud.RESET;
                    Stud.SETRANGE(Stud."No.", Rec."No.");
                    IF Stud.FIND('+') THEN BEGIN
                        REPORT.RUN(39006250, TRUE, FALSE, Stud);
                        //REPORT.RUN(39006253,TRUE,FALSE,CourseReg);
                    END;
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
        }
    }



    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Customer Type" := Rec."Customer Type"::Student;
        Rec."Date Registered" := TODAY;
        Rec."Customer Posting Group" := 'Student';
        Rec."Global Dimension 1 Code" := 'ACADEMIC';
        Rec."Application Method" := Rec."Application Method"::"Apply to Oldest";
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF Rec.Name = '' THEN
            ERROR('You must finish entry of the record.');
    end;

    var
        EducationHistory: Record "ACA-Student Education History";
        EnrollmentEducationHistory: Record "ACA-Enquiry Education History";
        StudentGuardian: Record "ACA-Student Sponsors Details";
        EnrollmentGuardian: Record "ACA-Enquiry Guardian/Sponsor";
        StudentKin: Record "ACA-Student Kin";
        EnrollmentNextofKin: Record "ACA-Enquiry Next Of Kin";
        CourseRegistration: Record "ACA-Course Registration";
        Enrollment: Record "ACA-Enquiry Header";
        PictureExists: Boolean;
        StudentRec: Record Customer;
        CourseReg: Record "ACA-Course Registration";
        districtname: Text[50];
        districtrec: Record "ACA-Applic. Setup County";
        Cust: Record Customer;
        GenJnl: Record "Gen. Journal Line";
        PDate: Date;
        CReg: Record "ACA-Course Registration";
        Prog: Record "ACA-Programme";
        TransInv: Boolean;
        TransRec: Boolean;
        Receipts: Record "ACA-Receipt";
        CustL: Record "Cust. Ledger Entry";
        Stud: Record Customer;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        districtname := '';
        districtrec.SETRANGE(districtrec.Code, Rec.District);
        IF districtrec.FIND('-') THEN
            districtname := districtrec.Description;
    end;
}

