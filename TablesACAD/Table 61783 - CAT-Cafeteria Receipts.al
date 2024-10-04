table 61783 "CAT-Cafeteria Receipts"
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
            TableRelation = "Bank Account"."No." WHERE("Bank Acc. Posting Group" = CONST('CASH'));
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
            OptionMembers = CASH,CREDIT,"ADVANCE PAYMENT";
        }
        field(15; "Recept Total"; Decimal)
        {
            CalcFormula = Sum("CAT-Cafeteria Receipts Line"."Total Amount" WHERE("Receipt No." = FIELD("Receipt No.")));
            FieldClass = FlowField;
        }
        field(16; User; Code[20])
        {
        }
        field(17; "Employee No"; Code[20])
        {
            TableRelation = "HRM-Employee (D)"."No." WHERE(Status = FILTER(Active));

            trigger OnValidate()
            begin
                empl.RESET;
                empl.SETRANGE(empl."No.", "Employee No");
                IF empl.FIND('-') THEN
                    "Employee Name" := empl."First Name" + ' ' + empl."Middle Name" + ' ' + empl."Last Name"
                ELSE
                    "Employee Name" := '';
            end;
        }
        field(18; "Employee Name"; Text[100])
        {
            CalcFormula = Lookup("HRM-Employee (D)"."First Name" WHERE("No." = FIELD("Employee No")));
            FieldClass = FlowField;
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
        field(50000; "Verify Student"; Code[20])
        {
            TableRelation = Customer."No." WHERE("Customer Posting Group" = FILTER('STUDENT'),
                                                "Customer Type" = FILTER(Student));
        }
        field(50001; "Cafeteria Section"; Option)
        {
            OptionCaption = ' ,Students,Staff';
            OptionMembers = " ",Students,Staff;
        }
    }

    keys
    {
        key(Key1; "Doc. No.", "Receipt No.")
        {
            SumIndexFields = Amount;
        }
        key(Key2; "Receipt No.", "Employee No", "Posted Date")
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF Status <> Status::New THEN
            ERROR('A Printed Receipt can not be Deleted. Consult the HOD to have it Reversed.') ELSE
            recLines.RESET;
        recLines.SETRANGE(recLines."Receipt No.", "Doc. No.");
        IF recLines.FIND('-') THEN BEGIN
            recLines.DELETEALL;
        END;
        MESSAGE('The receipt has been deleted.');
    end;

    trigger OnInsert()
    begin
        GenLedgerSetUp.GET;

        /* "User Setup".RESET;
         "User Setup".SETRANGE("User Setup"."User ID",USERID);
         IF "User Setup".FIND('-') THEN BEGIN
         IF "User Setup"."Global Dimension 1 Code"='' THEN ERROR('The User has no Institute Assigned to him/her') ELSE
             "Campus Code":="User Setup"."Global Dimension 1 Code";
              END;
              */

        //"No. Series Line".SETRANGE("No. Series Line"."Series Code",GenLedgerSetUp."Cash Sale");
        IF "No. Series Line".FIND('-') THEN BEGIN
            "Last No" := "No. Series Line"."Last No. Used";
            "No. Series Line"."Last No. Used" := INCSTR("No. Series Line"."Last No. Used");
            "No. Series Line".MODIFY;
        END;
        Sections := 'STUDENTS';
        "Cafeteria Section" := "Cafeteria Section"::Students;
        "Doc. No." := "Last No";
        "Receipt No." := "Last No";
        Department := 'CATERING';
        User := USERID;
        "Receipt Date" := TODAY;
        "Customer No." := 'C00280';
        "Cashier Bank" := 'PETTY';

    end;

    var
        empl: Record "HRM-Employee (D)";
        GenLedgerSetUp: Record 98;
        NoSeriesMgt: Codeunit 396;
        "No. Series Line": Record 309;
        "Last No": Code[20];
        "User Setup": Record 91;
        recLines: Record 61775;
}

