page 68420 "ACA-Grad. Charges (Unposted)"
{
    Editable = true;
    PageType = List;
    SourceTable = 61535;
    SourceTableView = WHERE(Posted = FILTER(false),
                            Recognized = FILTER(false),
                            Code = FILTER('GRADUATION DEG|GRADUATION DIP|GOWN_HIRE|ALUMNI_FEE'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
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
            Description = 'Functions';
            action(validate)
            {
                Caption = 'Validate Graduation Charges';
                Image = ValidateEmailLoggingSetup;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Create charges for all unbilled Graduation applicants?', TRUE) = FALSE THEN EXIT;
                    GetFuncs();
                    MESSAGE('Charges Captured Successfully');
                end;
            }
            action(Post)
            {
                Caption = 'Post Graduation Charges';
                Image = PostApplication;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Post unposted graduation Charges?', TRUE) = FALSE THEN ERROR('Cancelled by ' + FORMAT(USERID));
                    GetFuncs();

                    GenJnl.RESET;
                    GenJnl.SETRANGE("Journal Template Name", 'SALES');
                    GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                    GenJnl.DELETEALL;

                    GenSetUp.GET();

                    StudentCharges.RESET;
                    // Check if Unposted Graduation Charges Exists for posting
                    StudentCharges.SETRANGE(StudentCharges.Posted, FALSE);
                    StudentCharges.SETRANGE(StudentCharges.Recognized, FALSE);
                    StudentCharges.SETFILTER(StudentCharges.Code, '%1|%2|%3|%4', 'GRADUATION DEG', 'GRADUATION DIP', 'GOWN_HIRE', 'ALUMNI_FEE');
                    IF StudentCharges.FIND('-') THEN BEGIN
                        REPEAT

                            IF Cust.GET(StudentCharges."Student No.") THEN;
                            DueDate := StudentCharges.Date;

                            GenJnl.INIT;
                            GenJnl."Line No." := GenJnl."Line No." + 10000;
                            GenJnl."Posting Date" := TODAY;
                            GenJnl."Document No." := StudentCharges.Code;
                            GenJnl.VALIDATE(GenJnl."Document No.");
                            GenJnl."Journal Template Name" := 'SALES';
                            GenJnl."Journal Batch Name" := 'STUD PAY';
                            GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                            //
                            IF Cust.GET(StudentCharges."Student No.") THEN BEGIN
                                IF Cust."Bill-to Customer No." <> '' THEN
                                    GenJnl."Account No." := Cust."Bill-to Customer No."
                                ELSE
                                    GenJnl."Account No." := StudentCharges."Student No.";
                            END;

                            GenJnl.Amount := StudentCharges.Amount;
                            GenJnl.VALIDATE(GenJnl."Account No.");
                            GenJnl.VALIDATE(GenJnl.Amount);
                            GenJnl.Description := StudentCharges.Description;
                            GenJnl."Bal. Account Type" := GenJnl."Account Type"::"G/L Account";
                            IF Charges.GET(StudentCharges.Code) THEN
                                GenJnl."Bal. Account No." := Charges."G/L Account";
                            GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                            GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                            GenJnl."Shortcut Dimension 2 Code" := Cust."Global Dimension 2 Code";

                            GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
                            GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                            GenJnl."Due Date" := DueDate;
                            GenJnl.VALIDATE(GenJnl."Due Date");
                            IF StudentCharges."Recovery Priority" <> 0 THEN
                                GenJnl."Recovery Priority" := StudentCharges."Recovery Priority"
                            ELSE
                                GenJnl."Recovery Priority" := 25;
                            GenJnl.INSERT;

                            StudentCharges.Recognized := TRUE;
                            StudentCharges.Posted := TRUE;
                            StudentCharges.MODIFY;

                        UNTIL StudentCharges.NEXT = 0;
                    END;
                    //Post New
                    GenJnl.RESET;
                    GenJnl.SETRANGE("Journal Template Name", 'SALES');
                    GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                    IF GenJnl.FIND('-') THEN BEGIN
                        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Bill", GenJnl);
                    END;
                end;
            }
        }
    }

    var
        StudentPayments: Record "ACA-Std Payments";
        StudentCharges: Record "ACA-Std Charges";
        GenJnl: Record "Gen. Journal Line";
        Stages: Record "ACA-Programme Stages";
        Units: Record "ACA-Units/Subjects";
        ExamsByStage: Record "ACA-Exams";
        ExamsByUnit: Record "ACA-Exams By Units";
        Charges: Record "ACA-Charge";
        Prog: Record "ACA-Programme";

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

        Charges2: Record "ACA-Charge";
        found: Boolean;

    local procedure GetFuncs()
    begin
        Charges.RESET;
        Charges.SETFILTER(Charges.Code, '%1|%2|%3|%4', 'GRADUATION DEG', 'GRADUATION DIP', 'GOWN_HIRE', 'ALUMNI_FEE');
        IF Charges.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                Cust.RESET;
                Cust.SETRANGE(Cust."Applied for Clearance", TRUE);
                IF Cust.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        CLEAR(found);
                        Charges2.RESET;
                        Charges2.SETFILTER(Charges2.Code, '%1|%2|%3|%4', 'GRADUATION DEG', 'GRADUATION DIP', 'GOWN_HIRE', 'ALUMNI_FEE');
                        IF Charges2.FIND('-') THEN BEGIN
                            REPEAT
                            BEGIN
                                CustLed2.RESET;
                                CustLed2.SETRANGE(CustLed2."Customer No.", Cust."No.");
                                CustLed2.SETRANGE(CustLed2."Bal. Account No.", Charges2."G/L Account");
                                IF CustLed2.FIND('-') THEN found := TRUE;
                            END;
                            UNTIL Charges2.NEXT = 0;
                        END;

                        IF NOT found THEN BEGIN
                            StudentCharges.RESET;
                            StudentCharges.SETRANGE(StudentCharges."Student No.", Cust."No.");
                            StudentCharges.SETRANGE(StudentCharges.Code, Charges.Code);
                            IF NOT (StudentCharges.FIND('-')) THEN BEGIN
                                IF ((Charges.Code = 'GRADUATION DEG') OR (Charges.Code = 'GRADUATION DIP')) THEN BEGIN
                                    IF Prog.GET(Cust."Current Programme") THEN BEGIN //3
                                        IF Prog.Category = Prog.Category::Diploma THEN BEGIN//2
                                            IF Charges.Code = 'GRADUATION DIP' THEN BEGIN //1
                                                StudentCharges.INIT;
                                                StudentCharges."Transacton ID" := '';
                                                StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                                                StudentCharges."Student No." := Cust."No.";
                                                StudentCharges."Reg. Transacton ID" := '';
                                                StudentCharges.Code := Charges.Code;
                                                StudentCharges.Description := Charges.Description;
                                                StudentCharges.Amount := Charges.Amount;
                                                StudentCharges.Date := TODAY;
                                                StudentCharges.Charge := TRUE;
                                                StudentCharges.INSERT;
                                            END;//1
                                        END ELSE //2
                                            IF Prog.Category = Prog.Category::Undergraduate THEN BEGIN//2
                                                IF Charges.Code = 'GRADUATION DEG' THEN BEGIN //1
                                                    StudentCharges.INIT;
                                                    StudentCharges."Transacton ID" := '';
                                                    StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                                                    StudentCharges."Student No." := Cust."No.";
                                                    StudentCharges."Reg. Transacton ID" := '';
                                                    StudentCharges.Code := Charges.Code;
                                                    StudentCharges.Description := Charges.Description;
                                                    StudentCharges.Amount := Charges.Amount;
                                                    StudentCharges.Date := TODAY;
                                                    StudentCharges.Charge := TRUE;
                                                    StudentCharges.INSERT;
                                                END;//1
                                            END; //2
                                    END; //3
                                END ELSE
                                    IF ((Charges.Code = 'GOWN_HIRE') OR (Charges.Code = 'ALUMNI_FEE')) THEN BEGIN
                                        StudentCharges.INIT;
                                        StudentCharges."Transacton ID" := '';
                                        StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                                        StudentCharges."Student No." := Cust."No.";
                                        StudentCharges."Reg. Transacton ID" := '';
                                        StudentCharges.Code := Charges.Code;
                                        StudentCharges.Description := Charges.Description;
                                        StudentCharges.Amount := Charges.Amount;
                                        StudentCharges.Date := TODAY;
                                        StudentCharges.Charge := TRUE;
                                        StudentCharges.INSERT;
                                    END;
                            END;
                        END;
                    END;
                    UNTIL Cust.NEXT = 0;
                END;
            END;
            UNTIL Charges.NEXT = 0;
        END;
    end;
}

