table 77723 "ACA-Std Charges Reservour"
{
    DrillDownPageID = 68772;
    LookupPageID = 68772;

    fields
    {
        field(1; "Student No."; Code[20])
        {
            TableRelation = Customer;
        }
        field(2; "Reg. Transacton ID"; Code[20])
        {
            TableRelation = "ACA-Course Registration"."Reg. Transacton ID" WHERE("Student No." = FIELD("Student No."));
        }
        field(3; "Transaction Type"; Option)
        {
            Editable = true;
            OptionCaption = 'Charges,Stage Fees,Unit Fees,Stage Exam Fees,Unit Exam Fees';
            OptionMembers = Charges,"Stage Fees","Unit Fees","Stage Exam Fees","Unit Exam Fees";
        }
        field(4; "Code"; Code[20])
        {
            Editable = true;
            TableRelation = IF ("Transaction Type" = CONST(Charges)) "ACA-Charge".Code;
        }
        field(5; Description; Text[150])
        {
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
            TableRelation = "ACA-Semesters".Code;
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
            //TableRelation = IF (Transfer = CONST(Yes)) Table39006227.Field28 WHERE(Field1 = FIELD(Student No.));
        }
        field(27; Transfered; Boolean)
        {
        }
        field(28; "Transacton ID"; Code[20])
        {
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
        }
        field(33; Charge; Boolean)
        {
        }
        field(34; Reversed; Boolean)
        {
        }
        field(35; Distribution; Decimal)
        {
        }
        field(36; Quantity; Integer)
        {
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
        field(43; Currency; Code[20])
        {
            TableRelation = Currency.Code;
        }
        field(44; "Over Charged"; Boolean)
        {
        }
        field(45; "Over Charged Amount"; Decimal)
        {
        }
        field(46; "System Created"; Boolean)
        {
        }
        field(47; "Settlement Type"; Code[20])
        {
            CalcFormula = Lookup("ACA-Course Registration"."Settlement Type" WHERE("Reg. Transacton ID" = FIELD("Reg. Transacton ID")));
            FieldClass = FlowField;
        }
        field(48; "Charge Gender"; Option)
        {
            CalcFormula = Lookup("ACA-Charge".Gender WHERE(Code = FIELD(Code)));
            FieldClass = FlowField;
            OptionMembers = " ",Male,Female;
        }
        field(49; accommodation; Boolean)
        {
        }
        field(50; "Student Name"; Text[200])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(50084; "Reg. Reversed"; Boolean)
        {
            CalcFormula = Lookup("ACA-Course Registration".Reversed WHERE(Programmes = FIELD(Programme),
                                                                           "Student No." = FIELD("Student No."),
                                                                           Semester = FIELD(Semester),
                                                                           Stage = FIELD(Stage),
                                                                           "Reg. Transacton ID" = FIELD("Reg. Transacton ID")));
            FieldClass = FlowField;
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
        key(Key10; "Student No.", "Reg. Transacton ID", Date)
        {
            SumIndexFields = Amount;
        }
        key(Key11; "Student No.", "Reg. Transacton ID", "Code", Recognized)
        {
            SumIndexFields = Amount;
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
        Cust: Record "Customer";
}

