report 40014 "Post Batch Billing two"
{

    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Post Billing2.rdl';

    dataset
    {
        dataitem("CourseRegistration"; "ACA-Course Registration")

        {
            //DataItemTableView=   where("Settlement Type"=field("Settlement Type"));
            CalcFields = "Total Billed", "Department Code";
            RequestFilterFields = "Student No.", "Settlement Type", Semester, Stage, "System Created", Programmes, Posted;
            column(USERID; USERID)
            {
            }
            column(DinvalName; DinvalName) { }
            column(ProgrameName; ProgrameName) { }
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
            column(Student_Name; "Student Name")
            {
            }
            column(Student_No; "Student No.")
            {
            }
            column(Total_Billed; "Total Billed")
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
                COLUMN(sn; sn)
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
                    begin
                        GenJnl.DELETEALL;
                    end;




                    SettlementType.GET("CourseRegistration"."Settlement Type");
                    SettlementType.TESTFIELD(SettlementType."Tuition G/L Account");



                    GenSetUp.GET();
                    GenSetUp.TESTFIELD(GenSetUp."Pre-Payment Account");





                    StudentCharges.RESET;
                    StudentCharges.SetRange("Student No.", CourseRegistration."Student No.");
                    //StudCharges.SetCurrentKey("Reg. Transacton ID");
                    // StudentCharges.SetRange(Recognized, false);
                    StudentCharges.SetRange(Semester, CourseRegistration.Semester);
                    //StudCharges.SetRange("Reg. Transacton ID", CourseRegistration."Reg. Transacton ID");
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
                            CReg.SETRANGE(CReg.Posted, false);
                            //CReg.SetRange(CReg.Semester, StudentCharges.Semester);
                            IF CReg.FIND('-') THEN BEGIN
                                if CReg."Registration Date" <> 0D then
                                    GenJnl."Posting Date" := CReg."Registration Date"
                                else
                                    GenJnl."Posting Date" := TODAY;
                                GenJnl.Validate("Posting Date");
                            end;

                            GenJnl."Document No." := CourseRegistration."Reg. Transacton ID";
                            GenJnl.VALIDATE(GenJnl."Document No.");
                            GenJnl."Journal Template Name" := 'SALES';
                            GenJnl."Journal Batch Name" := 'STUD PAY';
                            GenJnl."Account Type" := GenJnl."Account Type"::"G/L Account";
                            GenJnl.Description := "CourseRegistration"."Student No." + ': ' + CourseRegistration."Student Name";
                            GenJnl.Amount := -StudentCharges.Amount;
                            GenJnl.Validate(Amount);
                            IF (StudentCharges.Charge = FALSE) THEN BEGIN
                                SettlementType.Reset();
                                SettlementType.SetRange(Code, CourseRegistration."Settlement Type");
                                if SettlementType.Find('-') then begin
                                    GenJnl."Account No." := SettlementType."Tuition G/L Account";
                                end;

                                // Message('Tution');
                                CReg.RESET;
                                CReg.SETCURRENTKEY(CReg."Reg. Transacton ID");
                                CReg.SETRANGE(CReg."Reg. Transacton ID", StudentCharges."Reg. Transacton ID");
                                CReg.SETRANGE(CReg."Student No.", StudentCharges."Student No.");
                                CReg.SETRANGE(CReg.Posted, false);
                                //CReg.SETRANGE(CReg.Semester, StudentCharges.Semester);
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

                                    // CReg.Posted := TRUE;
                                    // CReg."Date Posted" := Today;
                                    // CReg."Posted By" := UserId;
                                    // CReg.MODIFY;
                                END;


                            end ELSE
                                IF (StudentCharges.Charge = TRUE) THEN BEGIN
                                    Charges.Reset();
                                    Charges.SetRange(Code, StudentCharges.Code);
                                    Charges.SetRange("Settlement Type", CourseRegistration."Settlement Type");
                                    if Charges.Find('-') then begin
                                        GenJnl."Account No." := Charges."G/L Account";
                                    end;
                                    // IF Charges.GET(StudentCharges."Code", CourseRegistration."Settlement Type") THEN
                                    //     GenJnl."Account No." := Charges."G/L Account";
                                    // Message('Charges');
                                END else
                                    IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Fees") AND
                                       (StudentCharges.Charge = FALSE) THEN BEGIN
                                        GenJnl."Account No." := GenSetUp."Pre-Payment Account";

                                        CReg.RESET;
                                        CReg.SETCURRENTKEY(CReg."Reg. Transacton ID");
                                        CReg.SETRANGE(CReg."Reg. Transacton ID", StudentCharges."Reg. Transacton ID");
                                        IF CReg.FIND('-') THEN BEGIN
                                            // CReg.Posted := TRUE;
                                            // CReg."Date Posted" := Today;
                                            // CReg."Posted By" := UserId;
                                            // CReg.MODIFY;
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
                                                GenJnl.Description := "CourseRegistration"."Student No." + ': ' + "CourseRegistration"."Student Name";
                                                //  Message('Exam2');

                                            END;

                            GenJnl.VALIDATE(GenJnl."Account No.");
                            GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                            GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
                            GenJnl."Shortcut Dimension 2 Code" := Prog."Department Code";
                            GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                            IF Cust.GET("CourseRegistration"."Student No.") THEN BEGIN
                                CustName := Cust.Name;

                            END;
                            GenJnl.Description := "CourseRegistration"."Student No." + ': ' + CustName;
                            GenJnl."Shortcut Dimension 3 code" := Prog.Faculty;
                            GenJnl.Validate("Shortcut Dimension 3 code");
                            GenJnl."Shortcut Dimension 4 code" := Prog."Code";
                            GenJnl.Validate("Shortcut Dimension 4 code");
                            //GenJnl.VALIDATE(GenJnl."Due Date");
                            IF StudentCharges."Recovery Priority" <> 0 THEN
                                GenJnl."Recovery Priority" := StudentCharges."Recovery Priority"
                            ELSE
                                GenJnl."Recovery Priority" := 25;
                            IF (GenJnl.Amount <> 0) then//and (GenJnl."Posting Date" <> 0D)) then
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
                        // CReg.SETRANGE(CReg.Posted, false);
                        // CReg.SETRANGE(CReg.Semester, StudentCharges.Semester);
                        //CReg.SETRANGE(CReg.Posted, false);
                        //CReg.SetRange(Semester, "Semester Code");
                        //CReg.SetRange(Semester, 'SEP-DEC24');
                        //CReg.SETRANGE(CReg.Posted, false);
                        IF CReg.FIND('-') THEN BEGIN
                            if CReg."Registration Date" <> 0D then
                                GenJnl."Posting Date" := CReg."Registration Date"
                            else
                                GenJnl."Posting Date" := TODAY;
                            GenJnl.Validate("Posting Date");

                            GenJnl.Description := 'fee for ' + CourseRegistration.Semester;
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
                        GenJnl.validate(amount);
                        //Error('%1', UnrecognisedAmount);
                        IF Cust.GET("No.") THEN BEGIN
                            IF Cust."Bill-to Customer No." <> '' THEN
                                GenJnl."Account No." := Cust."Bill-to Customer No."
                            ELSE
                                GenJnl."Account No." := "No.";

                        END;

                        IF (GenJnl.Amount <> 0) then//and (GenJnl."Posting Date" <> 0D)) THEN
                            GenJnl.INSERT;

                        GenJnl.RESET;
                        GenJnl.SETRANGE("Journal Template Name", 'SALES');
                        GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                        IF GenJnl.FIND('-') THEN BEGIN
                            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post B", GenJnl);
                        END;
                        Cust.Status := Cust.Status::Current;
                        Cust.MODIFY;
                        CourseRegistration.Posted := true;
                        CourseRegistration.MODIFY;
                        /*CustLedger.reset;
                        CustLedger.SetRange("Customer No.", "CourseRegistration"."Student No.");
                        CustLedger.SetRange("Document No.", "CourseRegistration"."Reg. Transacton ID");
                        if CustLedger.Find('-') then begin
                            CustLedger."Semester Code" := "CourseRegistration".Semester + '-' + "CourseRegistration"."Academic Year";
                            CustLedger.Semester := "CourseRegistration".Semester;
                            CustLedger.Modify();
                        end;
                        DetailedCustLedger.reset;
                        DetailedCustLedger.SetRange("Customer No.", "CourseRegistration"."Student No.");
                        DetailedCustLedger.SetRange("Document No.", "CourseRegistration"."Reg. Transacton ID");
                        if DetailedCustLedger.Find('-') then begin
                            DetailedCustLedger."Semester Code" := "CourseRegistration".Semester + '-' + "CourseRegistration"."Academic Year";
                            DetailedCustLedger.Semester := "CourseRegistration".Semester;
                            DetailedCustLedger.Modify();
                        end;*/
                    end;


                end;
            }

            trigger OnAfterGetRecord()
            begin
                sn := sn + 1;
                IF Prog.GET("CourseRegistration".Programmes) THEN begin
                    Prog.TESTFIELD(Prog."Department Code");
                    ProgrameName := Prog.Description;

                end;

                // if Cust.GET("CourseRegistration"."Student No.") THEN
                //     "CourseRegistration".VALIDATE("CourseRegistration"."Settlement Type");
                // if DimVal.Get("CourseRegistration"."Department Code") then
                //     DinvalName := DimVal.Name;


            end;


        }
    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                field("Settlement Type"; "Settlement Type")
                {
                    TableRelation = "ACA-Settlement Type".Code;
                }
                field(Semester; Semester)
                {
                    TableRelation = "ACA-Semesters".Code;
                }

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
        CReg: Record "ACA-Course Registration";
        SettlementTypeCode: Code[20];
        // CourseRegistration1: Record "ACA-Course Registration";
        Semester: Code[20];

        StudentPayments: Record "ACA-Std Payments";
        StudentCharges: Record "ACA-Std Charges";
        ProgrameName: Text[250];
        GenJnl: Record 81;
        sn: Integer;
        DinvalName: Text[250];
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
        GLEntry: Record 17;
        CustLed: Record 21;
        BankLedg: Record 271;
        DCustLedg: Record 379;
        PDate: Date;
        DocNo: Code[20];
        CustName: Text[250];
        VendLedg: Record 25;
        DVendLedg: Record 380;
        VATEntry: Record 254;
        //CourseRegistration: Record "ACA-Course Registration";
        StudCharges: Record "ACA-Std Charges";
        CustLed2: Record 21;
        Receipt2: Record "ACA-Receipt";
        Cont: Boolean;
        Cust: Record 18;

        CustPostGroup: Record 92;
        window: Dialog;
        GLPosting: Codeunit 12;
        Receipts: Record "ACA-Receipt";
        CustLedg: Record 21;
        DueDate: Date;

        Sems: Record "ACA-Semesters";
        SettlementType: Record "ACA-Settlement Type";
        Prog: Record "ACA-Programme";
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Bill_StudentsCaptionLbl: Label 'Bill Students';
        StudHost: Record "ACA-Students Hostel Rooms";
        "Semester Code": Code[20];
        "Settlement Type": Code[20];
        "Programme Code": code[20];
}

