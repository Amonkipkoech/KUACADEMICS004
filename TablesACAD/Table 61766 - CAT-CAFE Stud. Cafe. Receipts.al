table 61766 "CAT-CAFE Stud. Cafe. Receipts"
{

    fields
    {
        field(1; "Doc. No."; Code[20])
        {
        }
        field(2; "Receipt Date"; Date)
        {
        }
        field(3; "Receipt No."; Code[20])
        {
        }
        field(4; "Customer No."; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(5; "Customer Name"; Text[150])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Customer No.")));
            FieldClass = FlowField;
        }
        field(6; "Cashier Bank"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(7; "Campus Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(8; Department; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE(Code = CONST('DEPARTMENT'));
        }
        field(9; "Department Name"; Text[50])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD(Department)));
            FieldClass = FlowField;
        }
        field(10; Amount; Decimal)
        {
        }
        field(11; "Posted By"; Code[20])
        {
        }
        field(12; "Posted Date"; Date)
        {
        }
        field(13; "Posted Time"; Time)
        {
        }
        field(14; "Transaction Type"; Option)
        {
            OptionCaption = 'CASH,CREDIT,ADVANCE PAYMENT';
            OptionMembers = CASH,CREDIT,"ADVANCE PAYMENT";
        }
        field(15; "Recept Total"; Decimal)
        {
            // CalcFormula = Sum(Table52018004.Field7 WHERE (Field2=FIELD("Receipt No.")));
            // FieldClass = FlowField;
        }
        field(16; User; Code[20])
        {
        }
        field(17; "Employee No"; Code[20])
        {
        }
        field(18; "Employee Name"; Text[100])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Employee No")));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                /* IF "Transaction Type"="Transaction Type"::"ADVANCE PAYMENT" THEN BEGIN
                 vend.RESET;
                 vend.SETRANGE(vend."No.","Employee No");
                 IF vend.FIND('-') THEN BEGIN
                 vend.CALCFIELDS(vend."Balance (LCY)");
                   "Employee Name":=vend.Name;
                   IF (vend."Balance (LCY)"<0)  THEN
                     ERROR('Selected Student has no Advance Payment on His Account..');
                END ELSE
                   "Employee Name":='';
                   END;

                 IF "Transaction Type"="Transaction Type"::CREDIT THEN BEGIN
                 cust.RESET;
                 cust.SETRANGE(cust."No.","Employee No");
                 IF cust.FIND('-') THEN
                   "Employee Name":=cust.Name
                 ELSE
                   "Employee Name":='';
                   END;   */

            end;
        }
        field(19; Status; Option)
        {
            OptionMembers = New,Printed,Posted,Canceled;
        }
        field(20; Select; Boolean)
        {
        }
        field(21; Sections; Code[20])
        {
            TableRelation = "CAT-Cafe Sections"."Section Code";
        }
        field(22; "Cancel Reason"; Text[50])
        {
        }
        field(23; "Total Credit"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            FieldClass = FlowFilter;
        }
        field(24; "Verify Student"; Code[20])
        {

            trigger OnValidate()
            begin
                "Employee No" := "Verify Student";
                VALIDATE("Employee No");
            end;
        }
    }

    keys
    {
        key(Key1; "Doc. No.", "Receipt No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF Status = Status::Posted THEN ERROR('You are not Allowed to modify Posted Receipts....');
    end;

    trigger OnInsert()
    begin
        GenLedgerSetUp.GET;
        //"No. Series Line".SETRANGE("No. Series Line"."Series Code",GenLedgerSetUp."Cafeteria Stud. Receipt Nos.");
        IF "No. Series Line".FIND('-') THEN BEGIN
            "Last No" := "No. Series Line"."Last No. Used";
            "No. Series Line"."Last No. Used" := INCSTR("No. Series Line"."Last No. Used");
            "No. Series Line".MODIFY;
        END;
        "Transaction Type" := "Transaction Type"::"ADVANCE PAYMENT";
        Sections := 'CAFETERIA';
        "Doc. No." := "Last No";
        "Receipt No." := "Last No";
        Department := '17';
        "Campus Code" := 'MAIN';
        User := USERID;
        "Receipt Date" := TODAY;
        "Cashier Bank" := '6580102';
        "Customer No." := '1420604';
    end;

    trigger OnModify()
    begin
        IF Status = Status::Posted THEN ERROR('You are not Allowed to modify Posted Receipts....');
    end;

    var
        GenLedgerSetUp: Record 98;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        "No. Series Line": Record 309;
        "Last No": Code[20];
        vend: Record 23;
        cust: Record 18;
}

