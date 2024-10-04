table 61538 "ACA-Receipt"
{
    // DrillDownPageID = 67057;
    // LookupPageID = 67057;

    fields
    {
        field(1; "Student No."; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(2; "Receipt No."; Code[20])
        {

            trigger OnValidate()
            begin
                IF "Receipt No." <> xRec."Receipt No." THEN BEGIN
                    GenSetup.GET;
                    //NoSeriesMgt.TestManual(GenSetup."Receipt Nos.");
                    "No. Series" := '';
                END;

                IF "Receipt No." = '' THEN BEGIN
                    GenSetup.GET;
                    GenSetup.TESTFIELD(GenSetup."Receipt Nos.");
                    //NoSeriesMgt.InitSeries(GenSetup."Receipt Nos.", xRec."No. Series", 0D, "Receipt No.", "No. Series");
                END;
            end;
        }
        field(3; Date; Date)
        {
        }
        field(4; "Payment Mode"; Option)
        {
            OptionCaption = ' ,Bank Slip,Cheque,Banker''s Cheque,Cash,Applies to Overpayment,PDQ,Unreferenced,Money Order,Direct Bank Deposit,Staff Invoice,Weiver,HELB,CDF';
            OptionMembers = " ","Bank Slip",Cheque,"Banker's Cheque",Cash,"Applies to Overpayment",PDQ,Unreferenced,"Money Order","Direct Bank Deposit","Staff Invoice",Weiver,HELB,CDF;
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; "No. Series"; Code[20])
        {
        }
        field(7; "Payment By"; Text[150])
        {
        }
        field(8; "User ID"; Code[20])
        {
        }
        field(9; "Transaction Date"; Date)
        {
        }
        field(10; "Transaction Time"; Time)
        {
        }
        field(11; "Student Name"; Text[150])
        {
        }
        field(12; "KCA Rcpt No"; Code[30])
        {

            trigger OnValidate()
            begin
                Rcpt.RESET;
                Rcpt.SETCURRENTKEY(Rcpt."KCA Rcpt No");
                Rcpt.SETRANGE(Rcpt."KCA Rcpt No", "KCA Rcpt No");
                IF Rcpt.FIND('-') THEN BEGIN
                    REPEAT
                        IF "Receipt No." <> Rcpt."Receipt No." THEN
                            ERROR('KCA Receipt No. already exists.');

                    UNTIL Rcpt.NEXT = 0;
                END;
            end;
        }
        field(13; "Amount Applied"; Decimal)
        {
            CalcFormula = Sum("ACA-Receipt Items".Amount WHERE("Receipt No" = FIELD("Receipt No.")));
            FieldClass = FlowField;
        }
        field(14; "Un Posted"; Boolean)
        {
        }
        field(15; Posted; Boolean)
        {
        }
        field(16; Reversed; Boolean)
        {
        }
        field(17; "Auto Receipt"; Boolean)
        {
        }
        field(18; "Auto  Receipt Date"; Date)
        {
        }
        field(19; "Auto  Receipted"; Boolean)
        {
        }
        field(20; Unallocated; Boolean)
        {
        }
        field(21; "Bank Slip Date"; Date)
        {
        }
        field(22; "Bank Code"; Code[20])
        {
        }
        field(23; Unreff; Boolean)
        {
        }
        field(24; "Unreff Transaction No"; Code[20])
        {
        }
        field(25; "Auto Reversed"; Boolean)
        {
            CalcFormula = Exist("Bank Account Ledger Entry" WHERE("Document No." = FIELD("Receipt No."),
                                                                   "Posting Date" = FIELD(Date),
                                                                   Reversed = CONST(true)));
            FieldClass = FlowField;
        }
        field(26; "Bank Slip/Cheque No"; Code[20])
        {

            trigger OnValidate()
            begin
                Rcpt.RESET;
                Rcpt.SETRANGE(Rcpt."Bank Slip/Cheque No", Rec."Bank Slip/Cheque No");
                IF Rcpt.FIND('-') THEN BEGIN
                    IF Rcpt.COUNT > 1 THEN ERROR('Duplicvate Document number');
                END;
            end;
        }
        field(27; "Settlement Type"; Code[20])
        {
            CalcFormula = Lookup("ACA-Course Registration"."Settlement Type" WHERE("Student No." = FIELD("Student No.")));
            FieldClass = FlowField;
            TableRelation = "ACA-Settlement Type";
        }
        field(28; "Reg ID"; Code[20])
        {
        }
        field(29; "Bank Account"; Code[20])
        {
            FieldClass = Normal;
            TableRelation = "Bank Account"."No.";
        }
        field(50000; "Room No"; Code[20])
        {
        }
        field(50001; "Entry Count"; Integer)
        {
            CalcFormula = Count("Cust. Ledger Entry" WHERE("Document No." = FIELD("Receipt No.")));
            FieldClass = FlowField;
        }
        field(50002; Stage; Code[20])
        {
            CalcFormula = Lookup(Customer."Current Semester" WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Receipt No.")
        {
        }
        key(Key2; "User ID")
        {
        }
        key(Key3; "Student Name")
        {
        }
        key(Key4; "Student No.")
        {
            SumIndexFields = Amount;
        }
        key(Key5; "Payment Mode")
        {
        }
        key(Key6; "Student No.", Date)
        {
            SumIndexFields = Amount;
        }
        key(Key7; "Student No.", "Reg ID")
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        GenSetup.GET;
        IF (Date > GenSetup."Allow Posting To") OR (Date < GenSetup."Allow Posting From") THEN
            ERROR('Modification or deletion out of the allowed range not allowed.')
    end;

    trigger OnModify()
    begin
        GenSetup.GET;
        IF (Date > GenSetup."Allow Posting To") OR (Date < GenSetup."Allow Posting From") THEN
            ERROR('Modification or deletion out of the allowed range not allowed.')
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenSetup: Record "ACA-General Set-Up";
        Rcpt: Record "ACA-Receipt";
}

