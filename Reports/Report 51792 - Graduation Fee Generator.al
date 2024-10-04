/// <summary>
/// Report Graduation Fee Generator (ID 51792).
/// </summary>
report 51792 "Graduation Fee Generator"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1; 18)
        {

            trigger OnPreDataItem()
            begin
                SETFILTER("No.", '=%1');

                Charges.RESET;
                Charges.SETFILTER(Code, '%1|%2|%3|%4', 'GRADUATION DEG', 'GRADUATION DIP', 'GOWN_HIRE', 'ALUMNI_FEE');
                IF Charges.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        IF Cust.GET("No.") THEN BEGIN
                            // REPEAT
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
                                        IF CustLed2.FIND('-') THEN BEGIN
                                            found := TRUE;
                                        END;
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
                            //  UNTIL Cust.NEXT=0;
                        END;
                    END;
                    UNTIL Charges.NEXT = 0;
                END;

                postCharges(studNo);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Stdno; studNo)
                {
                    Caption = 'Student No.';
                    TableRelation = Customer."No." WHERE("Customer Type" = FILTER(Student));
                    ApplicationArea = All;
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

    trigger OnPreReport()
    begin
        IF studNo = '' THEN ERROR('Please specify a student number!');
    end;

    var
        StudentPayments: Record 61536;
        StudentCharges: Record 61535;
        GenJnl: Record 81;
        Charges: Record 61515;
        GenSetUp: Record 61534;
        StudentCharges2: Record 61535;
        GLEntry: Record 17;
        CustLed: Record 21;
        BankLedg: Record 271;
        DCustLedg: Record 379;
        PDate: Date;
        DocNo: Code[20];
        StudCharges: Record 61535;
        CustLed2: Record 21;
        Cont: Boolean;
        Cust: Record 18;
        CustPostGroup: Record 92;
        //GLPosting: Codeunit 12;
        CustLedg: Record 21;
        CurrentBal: Decimal;
        Prog: Record 61511;
        DueDate: Date;
        Charges2: Record 61515;
        found: Boolean;
        studNo: Code[30];

    local procedure postCharges(var studnumber: Code[30])
    begin
        GenJnl.RESET;
        GenJnl.SETRANGE("Journal Template Name", 'SALES');
        GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
        GenJnl.DELETEALL;

        GenSetUp.GET();

        StudentCharges.RESET;
        // Check if Unposted Graduation Charges Exists for posting
        StudentCharges.SETRANGE(StudentCharges.Posted, FALSE);
        StudentCharges.SETRANGE(StudentCharges.Recognized, FALSE);
        StudentCharges.SETRANGE(StudentCharges."Student No.", studnumber);
        StudentCharges.SETFILTER(StudentCharges.Code, '%1|%2|%3|%4', 'GRADUATION DEG', 'GRADUATION DIP', 'GOWN_HIRE', 'ALUMNI_FEE');
        IF StudentCharges.FIND('-') THEN BEGIN
            REPEAT

                IF Cust.GET(studnumber) THEN;
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
            //RUN(CODEUNIT,"Gen. Jnl.-Post Bill",GenJnl);
        END;
    end;
}

