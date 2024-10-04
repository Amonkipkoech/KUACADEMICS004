table 61535 "ACA-Std Charges"
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

            trigger OnValidate()
            begin
                StudReg.RESET;
                StudReg.SETRANGE(StudReg."Reg. Transacton ID", "Reg. Transacton ID");
                IF StudReg.FIND('-') THEN BEGIN
                    Programme := StudReg.Programmes;
                    Stage := StudReg.Stage;
                    //Unit:=StudReg.Unit;
                    Semester := StudReg.Semester;
                END;
            end;
        }
        field(3; "Transaction Type"; Option)
        {
            Editable = true;
            //OptionCaption = 'Charges,Stage Fees,Unit Fees,Stage Exam Fees,Unit Exam Fees';
            OptionMembers = Charges,"Stage Fees","Unit Fees","Stage Exam Fees","Unit Exam Fees","Special-Supp Fee";
        }
        field(4; "Code"; Code[20])
        {
            Editable = true;
            TableRelation = IF ("Transaction Type" = CONST(Charges)) "ACA-Charge".Code;

            trigger OnValidate()
            begin
                //TESTFIELD(Date);

                //TESTFIELD("Reg. Transacton ID");
                IF "Reg. Transacton ID" = '' THEN BEGIN
                    StudReg.RESET;
                    StudReg.SETRANGE(StudReg."Student No.", "Student No.");
                    IF StudReg.FIND('+') THEN BEGIN
                        "Reg. Transacton ID" := StudReg."Reg. Transacton ID";
                        Semester := StudReg.Semester;
                        Date := TODAY;
                        StudReg.TESTFIELD(StudReg."Registration Date");
                        StudReg.VALIDATE("Reg. Transacton ID");
                    END ELSE BEGIN
                        //ERROR('Registration does not exist.');
                    END;

                END;



                IF "Transaction Type" = "Transaction Type"::Charges THEN BEGIN
                    IF Charges.GET(Code) THEN BEGIN
                        IF Charges.Hostel = TRUE THEN
                            IF Cust.GET("Student No.") THEN
                                Cust.TESTFIELD(Cust."Hostel Black Listed", FALSE);
                        Description := Charges.Description;
                        Amount := Charges.Amount;
                        /*
                        Charges.SETFILTER(Charges."Semester Filter",Semester);
                        Charges.CALCFIELDS(Charges."Charged Rooms Count");
                        Charges.CALCFIELDS(Charges."Issued Rooms");
                        Charges.CALCFIELDS(Charges."Vacant Rooms Count");
                        IF Charges."Vacant Rooms Count"<=0 THEN
                        IF CONFIRM('The Vacant Rooms has been fully occupied do you wish to proceed? ')=FALSE THEN
                        ERROR('Transaction Aborted');
                         */
                    END;
                    Charge := TRUE;
                END ELSE
                    Charge := FALSE;

            end;
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
        }
        field(9; "Amount Paid"; Decimal)
        {
        }
        field(11; "Applied Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                /*
                TotalApplied:=0;
                
                StudentCharges.RESET;
                StudentCharges.SETRANGE(StudentCharges."Student No.","Student No.");
                IF StudentCharges.FIND('-') THEN BEGIN
                REPEAT
                TotalApplied:=TotalApplied+StudentCharges."Applied Amount";
                UNTIL StudentCharges.NEXT = 0;
                END;
                
                
                IF "Applied Amount" <> xRec."Applied Amount" THEN
                TotalApplied := TotalApplied + ("Applied Amount" - xRec."Applied Amount")
                ELSE
                TotalApplied := TotalApplied + "Applied Amount";
                
                
                StudentPayments.RESET;
                StudentPayments.SETRANGE(StudentPayments."Student No.","Student No.");
                IF StudentPayments.FIND('-') THEN BEGIN
                StudentPayments."Unapplied Amount":=StudentPayments."Amount to pay"-TotalApplied;
                StudentPayments.MODIFY;
                END;
                */

            end;
        }
        field(12; "Apply too"; Boolean)
        {
        }
        field(16; "Apply to"; Boolean)
        {

            trigger OnValidate()
            begin
                IF "Recovered First" = FALSE THEN BEGIN
                    StudentCharges.RESET;
                    StudentCharges.SETRANGE(StudentCharges."Student No.", "Student No.");
                    StudentCharges.SETRANGE(StudentCharges."Apply to", FALSE);
                    StudentCharges.SETRANGE(StudentCharges."Fully Paid", FALSE);
                    StudentCharges.SETRANGE(StudentCharges."Recovered First", TRUE);
                    IF StudentCharges.FIND('-') THEN
                        ERROR('Apply payment to the charges which should be recorvered first');

                END;


                TotalApplied := 0;
                "Applied Amount" := 0;

                IF "Apply to" = TRUE THEN BEGIN
                    StudentCharges.RESET;
                    StudentCharges.SETRANGE(StudentCharges."Student No.", "Student No.");
                    IF StudentCharges.FIND('-') THEN BEGIN
                        REPEAT
                            TotalApplied := TotalApplied + StudentCharges."Applied Amount";
                        UNTIL StudentCharges.NEXT = 0;

                    END;


                    StudentPayments.RESET;
                    StudentPayments.SETRANGE(StudentPayments."Student No.", "Student No.");
                    IF StudentPayments.FIND('-') THEN BEGIN
                        IF (StudentPayments."Amount to pay" - TotalApplied) > (Amount - "Amount Paid") THEN
                            "Applied Amount" := (Amount - "Amount Paid")
                        ELSE BEGIN
                            IF (StudentPayments."Amount to pay" - TotalApplied) > 0 THEN
                                "Applied Amount" := (StudentPayments."Amount to pay" - TotalApplied)
                            ELSE BEGIN
                                IF xRec."Apply to" = FALSE AND "Apply to" = TRUE THEN
                                    ERROR('Total amount has been applied.');
                            END;

                        END;
                    END;
                END;
            end;
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
       
        field(27; Transfered; Boolean)
        {
        }
        field(28; "Transacton ID"; Code[20])
        {

            trigger OnValidate()
            begin
                IF "Transacton ID" <> xRec."Transacton ID" THEN BEGIN
                    GenSetup.GET;
                    NoSeriesMgt.TestManual(GenSetup."Transaction Nos.");
                    "No. Series" := '';
                END;

                IF "Transacton ID" = '' THEN BEGIN
                    GenSetup.GET;
                    GenSetup.TESTFIELD(GenSetup."Transaction Nos.");
                    NoSeriesMgt.InitSeries(GenSetup."Transaction Nos.", xRec."No. Series", 0D, "Transacton ID", "No. Series");
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
        field(50085; "Programme 2"; Code[50])
        {
            CalcFormula = Lookup("ACA-Students Transfer"."New Programme" WHERE("Student No" = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(50086; "New Reg No"; Code[30])
        {
            CalcFormula = Lookup("ACA-Students Transfer"."New Student No" WHERE("Student No" = FIELD("Student No.")));
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

    trigger OnDelete()
    begin
        /*
        IF Recognized = TRUE THEN
        ERROR('You can not delete recognized/billed transactions.');
        GenSetup.GET;
        
        IF Date <> 0D THEN BEGIN
        IF (Date > GenSetup."Allow Posting To") OR (Date < GenSetup."Allow Posting From") THEN
        ERROR('Modification or deletion out of the allowed range not allowed.')
        END;
        */

    end;

    trigger OnInsert()
    begin
        /*
       StudReg.RESET;
       StudReg.SETRANGE(StudReg."Student No.","Student No.");
       IF StudReg.FIND('+') THEN BEGIN
       "Reg. Transacton ID":=StudReg."Reg. Transacton ID";
       Semester:=StudReg.Semester;
       Date:=TODAY;
       StudReg.TESTFIELD(StudReg."Registration Date");
       StudReg.VALIDATE("Reg. Transacton ID");
       END ELSE BEGIN
       ERROR('Registration does not exist.');
       END;
        */

    end;

    trigger OnModify()
    begin
        /*
        IF Recognized = TRUE THEN
        ERROR('You can not modify recognized/billed transactions.');
        GenSetup.GET;
        IF Date <> 0D THEN BEGIN
        IF (Date > GenSetup."Allow Posting To") OR (Date < GenSetup."Allow Posting From") THEN
        ERROR('Modification or deletion out of the allowed range not allowed.')
        END;
        */

    end;

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

