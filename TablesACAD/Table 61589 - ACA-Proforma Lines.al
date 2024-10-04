table 61589 "ACA-Proforma Lines"
{
    //DrillDownPageID = 67098;
    LookupPageID = 68772;

    fields
    {
        field(1; "Student No."; Code[20])
        {
            TableRelation = Customer;
        }
        field(2; "Reg. Transacton ID"; Code[20])
        {
            Editable = false;
            NotBlank = true;
            TableRelation = "ACA-Course Registration"."Reg. Transacton ID" WHERE("Student No." = FIELD("Student No."));
        }
        field(3; "Transaction Type"; Option)
        {
            Editable = false;
            OptionCaption = 'Charges,Stage Fees,Unit Fees,Stage Exam Fees,Unit Exam Fees';
            OptionMembers = Charges,"Stage Fees","Unit Fees","Stage Exam Fees","Unit Exam Fees";
        }
        field(4; "Code"; Code[20])
        {
            Editable = true;
            TableRelation = IF ("Transaction Type" = CONST(Charges)) "ACA-Charge".Code;

            trigger OnValidate()
            begin
                TESTFIELD(Date);
                TESTFIELD("Reg. Transacton ID");
                IF "Transaction Type" = "Transaction Type"::Charges THEN BEGIN
                    IF Charges.GET(Code) THEN BEGIN
                        Description := Charges.Description;
                        Amount := Charges.Amount;
                    END;
                    Charge := TRUE;
                END ELSE
                    Charge := FALSE;
            end;
        }
        field(5; Description; Text[150])
        {
            Editable = false;
        }
        field(6; Amount; Decimal)
        {
        }
        field(7; Remarks; Text[200])
        {
        }
        field(8; Date; Date)
        {
            NotBlank = true;
        }
        field(9; "Amount Paid"; Decimal)
        {
        }
        field(11; "Applied Amount"; Decimal)
        {
        }
        field(12; "Apply too"; Boolean)
        {
        }
        field(16; "Apply to"; Boolean)
        {
        }
        field(17; Recognized; Boolean)
        {
        }
        field(18; Posted; Boolean)
        {
        }
        field(19; Programme; Code[20])
        {
        }
        field(20; Stage; Code[20])
        {
        }
        field(21; Unit; Code[20])
        {
        }
        field(22; Semester; Code[20])
        {
        }
        field(23; "Recovered First"; Boolean)
        {
        }
        field(24; Transfer; Boolean)
        {
        }
        field(25; "Transfer Amount"; Decimal)
        {
        }
        field(26; "Reg. Transaction ID"; Code[20])
        {
            TableRelation = IF (Transfer = CONST(true)) "ACA-Std Charges"."Transacton ID" WHERE("Student No." = FIELD("Student No."));
        }
        field(27; Transfered; Boolean)
        {
        }
        field(28; "Transacton ID"; Code[20])
        {

            trigger OnValidate()
            begin
                IF "Transacton ID" <> xRec."Transacton ID" THEN BEGIN
                    GenSetup.GET;
                    //NoSeriesMgt.TestManual(GenSetup."Transaction Nos.");
                    "No. Series" := '';
                END;

                IF "Transacton ID" = '' THEN BEGIN
                    GenSetup.GET;
                    GenSetup.TESTFIELD(GenSetup."Transaction Nos.");
                    //NoSeriesMgt.InitSeries(GenSetup."Transaction Nos.", xRec."No. Series", 0D, "Transacton ID", "No. Series");
                END;
            end;
        }
        field(29; "No. Series"; Code[20])
        {
        }
        field(30; "Fully Paid"; Boolean)
        {
        }
        field(31; "Tuition Fee"; Boolean)
        {
        }
        field(32; "Room Allocation"; Code[20])
        {
            Editable = true;
            Enabled = true;
            TableRelation = "ACA-Hostel Rooms".Code;

            trigger OnValidate()
            begin
                HRooms.RESET;
                HRooms.SETRANGE(HRooms.Code, "Room Allocation");
                IF HRooms.FIND('-') THEN BEGIN
                    HRooms.CALCFIELDS(HRooms.Occupied);
                    IF (HRooms.Occupied > HRooms.Capacity) OR (HRooms.Occupied = HRooms.Capacity) THEN
                        ERROR('Room fully Occupied.');
                END;
            end;
        }
        field(33; Charge; Boolean)
        {
        }
        field(34; Reversed; Boolean)
        {

            trigger OnValidate()
            begin
                IF CONFIRM('Are you sure you want to mark the transaction as reversed?', TRUE) = FALSE THEN
                    Reversed := FALSE;
            end;
        }
        field(35; Distribution; Decimal)
        {
        }
        field(36; Quantity; Integer)
        {

            trigger OnValidate()
            begin
                TESTFIELD(Quantity);
                IF "Transaction Type" = "Transaction Type"::Charges THEN BEGIN
                    IF Charges.GET(Code) THEN
                        Amount := Charges.Amount * Quantity;
                END;
            end;
        }
        field(37; Course; Code[20])
        {
            NotBlank = true;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('COURSE'));
        }
        field(38; "Total Paid"; Decimal)
        {
            CalcFormula = Sum("ACA-Receipt Items".Amount WHERE("Transaction ID" = FIELD("Transacton ID"),
                                                                "Student No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(39; "Applied Payment"; Decimal)
        {
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Document No." = FIELD("Transacton ID"),
                                                                         "Entry Type" = CONST(Application)));
            FieldClass = FlowField;
        }
        field(40; "Recovery Priority"; Integer)
        {
        }
        field(41; "Full Tuition Fee"; Decimal)
        {
        }
        field(42; "Distribution Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
    }

    keys
    {
        key(Key1; "Transacton ID", "Student No.")
        {
            SumIndexFields = Amount;
        }
        key(Key2; Programme, Stage, Unit, Semester, Date)
        {
            SumIndexFields = "Amount Paid", Amount;
        }
        key(Key3; "Room Allocation")
        {
        }
        key(Key4; "Reg. Transacton ID", "Tuition Fee")
        {
            SumIndexFields = "Amount Paid", Amount;
        }
        key(Key5; "Student No.", "Code", "Tuition Fee", Date)
        {
            SumIndexFields = Amount;
        }
        key(Key6; "Student No.", "Code", Recognized)
        {
        }
        key(Key7; "Reg. Transacton ID")
        {
        }
        key(Key8; "Student No.", Recognized, "Recovery Priority")
        {
        }
        key(Key9; "Student No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Charges: Record "ACA-Charge";
        StudentPayments: Record "ACA-Std Payments";
        TotalApplied: Decimal;
        StudentCharges: Record "ACA-Std Charges";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenSetup: Record "ACA-General Set-Up";
        StudReg: Record "ACA-Course Registration";
        HRooms: Record "ACA-Hostel Rooms";
}

