/// <summary>
/// TableExtension Cust. Ledger Entry (ID 70004) extends Record Cust. Ledger Entry.
/// </summary>
tableextension 70004 "Cust. Ledger Entry" extends "Cust. Ledger Entry"
{
    fields
    {
        field(50000; "Form/To"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Amount Receipted"; Decimal)
        {
            CalcFormula = Sum("ACA-Receipt Items".Amount WHERE("Transaction ID" = FIELD("Document No."),
                                                                Date = FIELD("Posting Date"),
                                                                "Student No." = FIELD("Customer No."),
                                                                Upposted = CONST(true)));
            FieldClass = FlowField;
        }
        field(50002; "Apply to"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //PKK

                TotalApplied := 0;
                "Amount Applied" := 0;

                IF "Apply to" = TRUE THEN BEGIN
                    CustLedgEn.RESET;
                    CustLedgEn.SETCURRENTKEY(CustLedgEn."Customer No.", CustLedgEn.Open);
                    CustLedgEn.SETRANGE(CustLedgEn."Customer No.", "Customer No.");
                    CustLedgEn.SETRANGE(CustLedgEn.Open, TRUE);
                    IF CustLedgEn.FIND('-') THEN BEGIN
                        REPEAT
                            TotalApplied := TotalApplied + CustLedgEn."Amount Applied";
                        UNTIL CustLedgEn.NEXT = 0;

                    END;


                    CALCFIELDS("Remaining Amount");

                    StudentPayments.RESET;
                    StudentPayments.SETRANGE(StudentPayments."Student No.", "Customer No.");
                    IF StudentPayments.FIND('-') THEN BEGIN
                        APay := StudentPayments."Amount to pay";
                        IF (APay - TotalApplied) > "Remaining Amount" THEN BEGIN
                            "Amount Applied" := "Remaining Amount";
                            MODIFY;
                        END ELSE BEGIN
                            IF (APay - TotalApplied) > 0 THEN BEGIN
                                "Amount Applied" := (StudentPayments."Amount to pay" - TotalApplied);
                                MODIFY;
                            END ELSE BEGIN
                                IF xRec."Apply to" = FALSE AND "Apply to" = TRUE THEN
                                    ERROR('Total amount has been applied.');
                            END;

                        END;
                    END;
                END;


                //PKK
            end;
        }
        field(50003; "Amount Applied"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Recovery Priority"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; Remarks; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Pay Mode"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Cash,"Money Order","Banker's Cheque";
        }
        field(50007; "Settlement Type"; Code[20])
        {
            CalcFormula = Lookup("ACA-Course Registration"."Settlement Type" WHERE("Student No." = FIELD("Customer No."),
                                                                                    "Settlement Type" = FILTER(<> '')));
            FieldClass = FlowField;
            TableRelation = "ACA-Settlement Type".Code;
        }
        field(50008; "Detailed Ledger Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Exists in Detailed Cust."; Boolean)
        {
            CalcFormula = Exist("Cust. Ledger Entry" WHERE("Entry No." = FIELD("Detailed Ledger Entry No")));
            FieldClass = FlowField;
        }
        field(50010; "Repeatition Value"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Number of Occurance"; Integer)
        {
            CalcFormula = Count("Cust. Ledger Entry" WHERE("Customer No." = FIELD("Customer No."),
                                                            "Repeatition Value" = FIELD("Repeatition Value")));
            FieldClass = FlowField;
        }
        field(50012; "Existing Test"; Boolean)
        {
            CalcFormula = exist("Cust Ledger Test" where("customer No" = field("Customer No.")));
            FieldClass = FlowField;
        }
        field(50013; "Count 2"; Integer)
        {

            CalcFormula = count("Cust Ledger Test"  where("customer No" = FIELD("Customer No.")));
            fieldclass = flowfield;

        }
        field(50014; "Receiving Bank"; Code[20])
        {
            CalcFormula = lookup("Bank Account Ledger Entry"."Bank Account No." where("Document No." = field("Document No.")));
            FieldClass = FlowField;
        }
    }
    var
        Text000: Label 'must have the same sign as %1';
        Text001: Label 'must not be larger than %1';

        CustLedgEn: Record 21;
        TotalApplied: Decimal;
        StudentPayments: Record 61536;

        APay: Decimal;
}