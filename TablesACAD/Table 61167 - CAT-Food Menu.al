table 61167 "CAT-Food Menu"
{
    //LookupPageID = "CAT-Menu List";

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Description; Text[30])
        {
        }
        field(3; "Items Cost"; Decimal)
        {
            CalcFormula = Sum("CAT-Food Menu Line"."Total Cost" WHERE(Menu = FIELD(Code)));
            FieldClass = FlowField;
        }
        field(4; Type; Option)
        {
            OptionCaption = ' ,Student,Staff,Meal booking';
            OptionMembers = " ",Student,Staff,"Meal booking";

            trigger OnValidate()
            begin
                Amount := "Items Cost" + "Unit Cost";
            end;
        }
        field(5; "Unit Cost"; Decimal)
        {
        }
        field(6; Amount; Decimal)
        {
        }
        field(7; Quantity; Integer)
        {
        }
        field(8; "Units Of Measure"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*
          "No. Series Line".RESET;
         MenuSetUp.FINDLAST();
         "No. Series Line".SETRANGE("No. Series Line"."Series Code",MenuSetUp."Menu No. Series");
         IF "No. Series Line".FIND('-')  THEN
         BEGIN
          "Last Code":=INCSTR("No. Series Line"."Last No. Used");
          "No. Series Line"."Last No. Used":="Last Code";
           "No. Series Line".MODIFY;
         END;
         IF "Last Code"='' THEN
         BEGIN
            "Last Code":="No. Series Line"."Starting No.";
            "No. Series Line"."Last No. Used":="Last Code";
            "No. Series Line".MODIFY;
         END;
         Code:="Last Code";
         */

    end;

    var
        "No. Series Line": Record 309;
        "Last Code": Code[10];
        MenuSetUp: Record 61171;
}

