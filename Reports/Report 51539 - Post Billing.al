report 51539 "Post Billing"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Post Billing.rdl';

    dataset
    {
        dataitem("CourseRegistration"; "ACA-Course Registration")
        {
            //DataItemTableView=   where("Settlement Type"=field("Settlement Type"));
            RequestFilterFields = "Student No.", "Settlement Type", Semester, Stage, "System Created", Programmes, Posted;
            column(USERID; USERID)
            {
            }
#pragma warning disable AL0667
            column(CurrReport_PAGENO; CurrReport.PAGENO)
#pragma warning restore AL0667
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Bill_StudentsCaption; Bill_StudentsCaptionLbl)
            {
            }
            column(Customer__No__Caption; Customer.FIELDCAPTION("No."))
            {
            }
            column(Customer_NameCaption; Customer.FIELDCAPTION(Name))
            {
            }
            column(Course_Registration_Reg__Transacton_ID; "Reg. Transacton ID")
            {
            }
            column(Course_Registration_Student_No_; "Student No.")
            {
            }
            column(Course_Registration_Programme; Programmes)
            {
            }
            column(Course_Registration_Semester; Semester)
            {
            }
            column(Course_Registration_Register_for; "Register for")
            {
            }
            column(Course_Registration_Stage; Stage)
            {
            }
            column(Course_Registration_Unit; Unit)
            {
            }
            column(Course_Registration_Student_Type; "Student Type")
            {
            }
            column(Course_Registration_Entry_No_; "Entry No.")
            {
            }
            dataitem(Customer; Customer)
            {
                DataItemLink = "No." = FIELD("Student No.");
                DataItemTableView = SORTING("No.")
                                    WHERE(Blocked = FILTER(' '));
                column(Customer__No__; "No.")
                {
                }
                column(Customer_Name; Name)
                {
                }
                trigger OnPreDataItem()
                begin
                    UnrecognisedAmount := 0;
                end;

                trigger OnAfterGetRecord()
                begin

                    //Billing
                    GenJnl.RESET;
                    GenJnl.SETRANGE("Journal Template Name", 'SALES');
                    GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                    GenJnl.DELETEALL;


                    //SettlementType.GET("CourseRegistration"."Settlement Type");




                    GenSetUp.GET();
                    GenSetUp.TESTFIELD(GenSetUp."Pre-Payment Account");

                    //Charge Student if not charged
                    // StudentCharges.RESET;
                    // StudentCharges.SETRANGE(StudentCharges."Student No.", "No.");
                    // StudentCharges.SETRANGE(StudentCharges.Recognized, FALSE);
                    // IF StudentCharges.FIND('-') THEN BEGIN

                    //     REPEAT

                    //         DueDate := StudentCharges.Date;
                    //         IF Sems.GET(StudentCharges.Semester) THEN BEGIN
                    //             IF Sems.From <> 0D THEN BEGIN
                    //                 IF Sems.From > DueDate THEN
                    //                     DueDate := Sems.From;
                    //             END;
                    //         END;

                    //         GenJnl.INIT;
                    //         GenJnl."Line No." := GenJnl."Line No." + 10000;
                    //         GenJnl."Posting Date" := TODAY;
                    //         GenJnl."Document No." := StudentCharges."Transacton ID";
                    //         GenJnl.VALIDATE(GenJnl."Document No.");
                    //         GenJnl."Journal Template Name" := 'SALES';
                    //         GenJnl."Journal Batch Name" := 'STUD PAY';
                    //         GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                    //         //
                    //         IF Cust.GET("No.") THEN BEGIN
                    //             IF Cust."Bill-to Customer No." <> '' THEN
                    //                 GenJnl."Account No." := Cust."Bill-to Customer No."
                    //             ELSE
                    //                 GenJnl."Account No." := "No.";
                    //         END;

                    //         GenJnl.Amount := StudentCharges.Amount;
                    //         GenJnl.VALIDATE(GenJnl."Account No.");
                    //         GenJnl.VALIDATE(GenJnl.Amount);
                    //         GenJnl.Description := StudentCharges.Description + ' ' + StudentCharges.Semester;
                    //         GenJnl."Bal. Account Type" := GenJnl."Account Type"::"G/L Account";

                    //         IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Fees") AND
                    //            (StudentCharges.Charge = FALSE) THEN BEGIN
                    //             //StudentCharges.CALCFIELDS(StudentCharges."Settlement Type");
                    //             GenJnl."Bal. Account No." := SettlementType."Tuition G/L Account";
                    //             CReg.RESET;
                    //             CReg.SETCURRENTKEY(CReg."Reg. Transacton ID");
                    //             CReg.SETRANGE(CReg."Reg. Transacton ID", StudentCharges."Reg. Transacton ID");
                    //             CReg.SETRANGE(CReg."Student No.", StudentCharges."Student No.");
                    //             IF CReg.FIND('-') THEN BEGIN
                    //                 IF CReg."Register for" = CReg."Register for"::Stage THEN BEGIN
                    //                     Stages.RESET;
                    //                     Stages.SETRANGE(Stages."Programme Code", CReg.Programmes);
                    //                     Stages.SETRANGE(Stages.Code, CReg.Stage);
                    //                     IF Stages.FIND('-') THEN BEGIN
                    //                         IF (Stages."Modules Registration" = TRUE) AND (Stages."Ignore No. Of Units" = FALSE) THEN BEGIN
                    //                             CReg.CALCFIELDS(CReg."Units Taken");
                    //                             IF CReg.Modules <> CReg."Units Taken" THEN
                    //                                 ERROR('Units Taken must be equal to the no of modules registered for.');

                    //                         END;
                    //                     END;
                    //                 END;

                    //                 CReg.Posted := TRUE;
                    //                 CReg.MODIFY;
                    //             END;


                    //         END ELSE
                    //             IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Fees") AND
                    //                (StudentCharges.Charge = FALSE) THEN BEGIN
                    //                 GenJnl."Bal. Account No." := GenSetUp."Pre-Payment Account";

                    //                 CReg.RESET;
                    //                 CReg.SETCURRENTKEY(CReg."Reg. Transacton ID");
                    //                 CReg.SETRANGE(CReg."Reg. Transacton ID", StudentCharges."Reg. Transacton ID");
                    //                 IF CReg.FIND('-') THEN BEGIN
                    //                     CReg.Posted := TRUE;
                    //                     CReg.MODIFY;
                    //                 END;

                    //             END ELSE
                    //                 IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Exam Fees" THEN BEGIN
                    //                     IF ExamsByStage.GET(StudentCharges.Programme, StudentCharges.Stage, StudentCharges.Semester, StudentCharges.Code) THEN
                    //                         GenJnl."Bal. Account No." := ExamsByStage."G/L Account";

                    //                 END ELSE
                    //                     IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Exam Fees" THEN BEGIN
                    //                         IF ExamsByUnit.GET(StudentCharges.Programme, StudentCharges.Stage, ExamsByUnit."Unit Code", StudentCharges.Semester,
                    //                         StudentCharges.Code) THEN
                    //                             GenJnl."Bal. Account No." := ExamsByUnit."G/L Account";

                    //                     END ELSE
                    //                         IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::Charges) OR
                    //                            (StudentCharges.Charge = TRUE) THEN BEGIN
                    //                             IF Charges.GET(StudentCharges.Code) THEN
                    //                                 GenJnl."Bal. Account No." := Charges."G/L Account";
                    //                         END;

                    //         GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                    //         GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                    //         GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");

                    //         GenJnl."Shortcut Dimension 2 Code" := Prog."Department Code";
                    //         GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                    //         GenJnl."Due Date" := DueDate;
                    //         GenJnl.VALIDATE(GenJnl."Due Date");
                    //         IF StudentCharges."Recovery Priority" <> 0 THEN
                    //             GenJnl."Recovery Priority" := StudentCharges."Recovery Priority"
                    //         ELSE
                    //             GenJnl."Recovery Priority" := 25;
                    //         IF GenJnl.Amount > 0 THEN
                    //             GenJnl.INSERT;

                    //         //Distribute Money
                    //         IF StudentCharges."Tuition Fee" = TRUE THEN BEGIN
                    //             IF Stages.GET(StudentCharges.Programme, StudentCharges.Stage) THEN BEGIN
                    //                 IF (Stages."Distribution Full Time (%)" > 0) OR (Stages."Distribution Part Time (%)" > 0) THEN BEGIN
                    //                     Stages.TESTFIELD(Stages."Distribution Account");
                    //                     StudentCharges.TESTFIELD(StudentCharges.Distribution);
                    //                     IF Cust.GET("No.") THEN BEGIN
                    //                         CustPostGroup.GET(Cust."Customer Posting Group");

                    //                         GenJnl.INIT;
                    //                         GenJnl."Line No." := GenJnl."Line No." + 10000;
                    //                         GenJnl."Posting Date" := TODAY;//StudentCharges.Date;
                    //                         GenJnl."Document No." := StudentCharges."Transacton ID";
                    //                         //GenJnl."Document Type":=GenJnl."Document Type"::Payment;
                    //                         GenJnl.VALIDATE(GenJnl."Document No.");
                    //                         GenJnl."Journal Template Name" := 'SALES';
                    //                         GenJnl."Journal Batch Name" := 'STUD PAY';
                    //                         GenJnl."Account Type" := GenJnl."Account Type"::"G/L Account";
                    //                         //GenSetUp.TESTFIELD(GenSetUp."Pre-Payment Account");
                    //                         //IF "Settlement Type".GET(StudentCharges."Settlement Type") THEN
                    //                         GenJnl."Account No." := SettlementType."Tuition G/L Account";

                    //                         GenJnl.Amount := StudentCharges.Amount * (StudentCharges.Distribution / 100);
                    //                         GenJnl.VALIDATE(GenJnl."Account No.");
                    //                         GenJnl.VALIDATE(GenJnl.Amount);
                    //                         GenJnl.Description := 'Fee Distribution';
                    //                         GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                    //                         GenJnl."Bal. Account No." := Stages."Distribution Account";
                    //                         GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                    //                         GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                    //                         GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
                    //                         GenJnl."Shortcut Dimension 2 Code" := Prog."Department Code";
                    //                         GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                    //                         IF GenJnl.Amount > 0 THEN
                    //                             GenJnl.INSERT;

                    //                     END;
                    //                 END;
                    //             END;
                    //         END ELSE BEGIN
                    //             //Distribute Charges
                    //             IF StudentCharges.Distribution > 0 THEN BEGIN
                    //                 StudentCharges.TESTFIELD(StudentCharges."Distribution Account");
                    //                 IF Charges.GET(StudentCharges.Code) THEN BEGIN
                    //                     Charges.TESTFIELD(Charges."G/L Account");
                    //                     GenJnl.INIT;
                    //                     GenJnl."Line No." := GenJnl."Line No." + 10000;
                    //                     GenJnl."Posting Date" := StudentCharges.Date;
                    //                     GenJnl."Document No." := StudentCharges."Transacton ID";
                    //                     GenJnl.VALIDATE(GenJnl."Document No.");
                    //                     GenJnl."Journal Template Name" := 'SALES';
                    //                     GenJnl."Journal Batch Name" := 'STUD PAY';
                    //                     GenJnl."Account Type" := GenJnl."Account Type"::"G/L Account";
                    //                     //if "Settlement Type".get()
                    //                     GenJnl."Account No." := StudentCharges."Distribution Account";
                    //                     GenJnl.Amount := StudentCharges.Amount * (StudentCharges.Distribution / 100);
                    //                     GenJnl.VALIDATE(GenJnl."Account No.");
                    //                     GenJnl.VALIDATE(GenJnl.Amount);
                    //                     GenJnl.Description := 'Fee Distribution';
                    //                     GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                    //                     GenJnl."Bal. Account No." := Charges."G/L Account";
                    //                     GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                    //                     GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                    //                     GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");

                    //                     GenJnl."Shortcut Dimension 2 Code" := Prog."Department Code";
                    //                     GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                    //                     IF GenJnl.Amount > 0 THEN
                    //                         GenJnl.INSERT;
                    //                 END;
                    //             END;
                    //         END;
                    //         //End Distribution
                    //         StudentCharges.Recognized := TRUE;
                    //         StudentCharges.MODIFY;
                    //     UNTIL StudentCharges.NEXT = 0;

                    //     //Post New
                    //     GenJnl.RESET;
                    //     GenJnl.SETRANGE("Journal Template Name", 'SALES');
                    //     GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                    //     IF GenJnl.FIND('-') THEN BEGIN
                    //         CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post B", GenJnl);
                    //     END;

                    //     //Post New


                    //     Cust.Status := Cust.Status::Current;
                    //     Cust.MODIFY;

                    // END;

                    StudentCharges.RESET;
                    StudentCharges.SetRange("Student No.", CourseRegistration."Student No.");
                    StudentCharges.SetRange(Recognized, false);
                    if StudentCharges.Find('-') then begin
                        repeat
                            UnrecognisedAmount := UnrecognisedAmount + StudentCharges.Amount;

                            DueDate := StudentCharges.Date;
                            IF Sems.GET(StudentCharges.Semester) THEN BEGIN
                                IF Sems.From <> 0D THEN BEGIN
                                    IF Sems.From > DueDate THEN
                                        DueDate := Sems.From;
                                END;
                            END;

                            GenJnl.INIT;
                            GenJnl."Line No." := GenJnl."Line No." + 10000;
                            CReg.RESET;
                            CReg.SETCURRENTKEY(CReg."Reg. Transacton ID");
                            CReg.SETRANGE(CReg."Reg. Transacton ID", StudentCharges."Reg. Transacton ID");
                            CReg.SETRANGE(CReg."Student No.", StudentCharges."Student No.");
                            IF CReg.FIND('-') THEN BEGIN
                                if CReg."Registration Date" <> 0D then
                                    GenJnl."Posting Date" := Today
                                else
                                    GenJnl."Posting Date" := Today;
                                GenJnl.Validate("Posting Date");
                            end;

                            GenJnl."Document No." := "CourseRegistration"."Reg. Transacton ID";
                            GenJnl.VALIDATE(GenJnl."Document No.");
                            GenJnl."Journal Template Name" := 'SALES';
                            GenJnl."Journal Batch Name" := 'STUD PAY';
                            GenJnl."Account Type" := GenJnl."Account Type"::"G/L Account";
                            GenJnl.Amount := -StudentCharges.Amount;
                            IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Fees") AND
                               (StudentCharges.Charge = FALSE) THEN BEGIN
                                SettlementType.Reset();
                                SettlementType.SetRange(Code, CourseRegistration."Settlement Type");
                                if SettlementType.Find('-') then begin
                                    SettlementType.TESTFIELD(SettlementType."Tuition G/L Account");
                                    GenJnl."Account No." := SettlementType."Tuition G/L Account";
                                end;

                                // Message('Tution');
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
                                    CReg."Date Posted" := Today;
                                    CReg."Posted By" := UserId;
                                    CReg.MODIFY;
                                END;


                            end ELSE
                                IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Fees") AND
                                   (StudentCharges.Charge = FALSE) THEN BEGIN
                                    GenJnl."Account No." := GenSetUp."Pre-Payment Account";

                                    CReg.RESET;
                                    CReg.SETCURRENTKEY(CReg."Reg. Transacton ID");
                                    CReg.SETRANGE(CReg."Reg. Transacton ID", StudentCharges."Reg. Transacton ID");
                                    IF CReg.FIND('-') THEN BEGIN
                                        CReg.Posted := TRUE;
                                        CReg."Date Posted" := Today;
                                        CReg."Posted By" := UserId;
                                        CReg.MODIFY;
                                    END;

                                END ELSE
                                    IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Exam Fees" THEN BEGIN
                                        IF ExamsByStage.GET(StudentCharges.Programme, StudentCharges.Stage, StudentCharges.Semester,
                                         StudentCharges."Code", CourseRegistration."Settlement Type") THEN
                                            GenJnl."Account No." := ExamsByStage."G/L Account";
                                        // Message('Exam');
                                    END ELSE
                                        IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Exam Fees" THEN BEGIN
                                            IF ExamsByUnit.GET(StudentCharges.Programme, StudentCharges.Stage, ExamsByUnit."Unit Code", StudentCharges.Semester,
                                            StudentCharges."Code", CourseRegistration."Settlement Type") THEN
                                                GenJnl."Account No." := ExamsByUnit."G/L Account";
                                            //  Message('Exam2');

                                        END ELSE
                                            IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::Charges) OR
                                               (StudentCharges.Charge = TRUE) THEN BEGIN
                                                IF Charges.GET(StudentCharges."Code", CourseRegistration."Settlement Type") THEN
                                                    GenJnl."Account No." := Charges."G/L Account";
                                                // Message('Charges');
                                            END;
                            GenJnl.VALIDATE(GenJnl."Account No.");
                            GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                            GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
                            GenJnl."Shortcut Dimension 2 Code" := Prog."Department Code";
                            GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                            GenJnl."Shortcut Dimension 3 code" := Prog.Faculty;
                            GenJnl.Validate("Shortcut Dimension 3 code");
                            GenJnl."Shortcut Dimension 4 code" := Prog."Code";
                            GenJnl.Validate("Shortcut Dimension 4 code");
                            //GenJnl.VALIDATE(GenJnl."Due Date");
                            IF StudentCharges."Recovery Priority" <> 0 THEN
                                GenJnl."Recovery Priority" := StudentCharges."Recovery Priority"
                            ELSE
                                GenJnl."Recovery Priority" := 25;
                            IF ((GenJnl.Amount <> 0) and (GenJnl."Posting Date" <> 0D)) then
                                GenJnl.INSERT;

                            StudentCharges.Recognized := TRUE;
                            StudentCharges.Posted := true;
                            StudentCharges.MODIFY;

                        until StudentCharges.Next() = 0;
                        GenJnl.INIT;
                        GenJnl."Line No." := GenJnl."Line No." + 10000;
                        CReg.RESET;
                        CReg.SETCURRENTKEY(CReg."Reg. Transacton ID");
                        CReg.SETRANGE(CReg."Reg. Transacton ID", StudentCharges."Reg. Transacton ID");
                        CReg.SETRANGE(CReg."Student No.", StudentCharges."Student No.");
                        IF CReg.FIND('-') THEN BEGIN
                            if CReg."Registration Date" <> 0D then
                                GenJnl."Posting Date" := Today
                            else
                                GenJnl."Posting Date" := Today;
                            GenJnl.Validate("Posting Date");
                            GenJnl.Description := 'FEE FOR ' + CReg.Semester + ' , ' + CReg."Academic Year";
                        end;

                        GenJnl."Document No." := "CourseRegistration"."Reg. Transacton ID";
                        GenJnl.VALIDATE(GenJnl."Document No.");
                        GenJnl."Journal Template Name" := 'SALES';
                        GenJnl."Journal Batch Name" := 'STUD PAY';
                        GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                        GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                        GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
                        GenJnl."Shortcut Dimension 2 Code" := Prog."Department Code";
                        GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                        GenJnl."Shortcut Dimension 3 code" := Prog.Faculty;
                        GenJnl.Validate("Shortcut Dimension 3 code");
                        GenJnl."Shortcut Dimension 4 code" := Prog."Code";
                        GenJnl.Validate("Shortcut Dimension 4 code");

                        GenJnl.Amount := UnrecognisedAmount;
                        //Error('%1', UnrecognisedAmount);
                        IF Cust.GET("No.") THEN BEGIN
                            IF Cust."Bill-to Customer No." <> '' THEN
                                GenJnl."Account No." := Cust."Bill-to Customer No."
                            ELSE
                                GenJnl."Account No." := "No.";

                        END;

                        IF ((GenJnl.Amount <> 0) and (GenJnl."Posting Date" <> 0D)) THEN
                            GenJnl.INSERT;

                        GenJnl.RESET;
                        GenJnl.SETRANGE("Journal Template Name", 'SALES');
                        GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                        IF GenJnl.FIND('-') THEN BEGIN
                            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post B", GenJnl);
                        END;
                        Cust.Status := Cust.Status::Current;
                        Cust.MODIFY;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF Prog.GET("CourseRegistration".Programmes) THEN
                    Prog.TESTFIELD(Prog."Department Code");
                IF Cust.GET("CourseRegistration"."Student No.") THEN
                    "CourseRegistration".VALIDATE("CourseRegistration"."Settlement Type");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(Content)
            {

            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        UnrecognisedAmount: Decimal;
        StudentPayments: Record 61536;
        StudentCharges: Record 61535;
        GenJnl: Record 81;
        Stages: Record 61516;
        Units: Record 61517;
        ExamsByStage: Record 61526;
        ExamsByUnit: Record 61527;
        Charges: Record 61515;
        Receipt: Record 61538;
        ReceiptItems: Record 61539;
        GenSetUp: Record 61534;
        StudentCharges2: Record 61535;
        CourseReg: Record 61532;
        CurrentBill: Decimal;
        GLEntry: Record 17;
        CustLed: Record 21;
        BankLedg: Record 271;
        DCustLedg: Record 379;
        PDate: Date;
        DocNo: Code[20];
        VendLedg: Record 25;
        DVendLedg: Record 380;
        VATEntry: Record 254;
        CReg: Record 61532;
        StudCharges: Record 61535;
        CustLed2: Record 21;
        Receipt2: Record 61538;
        Cont: Boolean;
        Cust: Record 18;
        CustPostGroup: Record 92;
        window: Dialog;
        GLPosting: Codeunit 12;
        Receipts: Record 61538;
        CustLedg: Record 21;
        DueDate: Date;
        Sems: Record 61692;
        SettlementType: Record 61522;
        Prog: Record 61511;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Bill_StudentsCaptionLbl: Label 'Bill Students';
        StudHost: Record 61155;
}

