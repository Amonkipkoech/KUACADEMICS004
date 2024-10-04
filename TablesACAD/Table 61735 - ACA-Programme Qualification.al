table 61735 "ACA-Programme Qualification"
{
    Caption = 'Employee Qualification';
    DrillDownPageID = 5207;
    LookupPageID = 5206;

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Qualification Code"; Code[10])
        {
            Caption = 'Qualification Code';
            TableRelation = Qualification;

            trigger OnValidate()
            begin
                Qualification.GET("Qualification Code");
                Description := Qualification.Description;
            end;
        }
        field(4; "From Date"; Date)
        {
            Caption = 'From Date';
        }
        field(5; "To Date"; Date)
        {
            Caption = 'To Date';
        }
        field(6; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Internal,External,Previous Position';
            OptionMembers = " ",Internal,External,"Previous Position";
        }
        field(7; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(8; "Institution/Company"; Text[50])
        {
            Caption = 'Institution/Company';
        }
        field(9; Cost; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost';
        }
        field(10; "Course Grade"; Text[50])
        {
            Caption = 'Course Grade';
        }
        field(13; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
        }
    }

    keys
    {
        key(Key1; "Code", "Line No.")
        {
        }
        key(Key2; "Qualification Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //IF Comment THEN
        //  ERROR(Text000);
    end;

    trigger OnInsert()
    begin
        //Employee.GET("Employee No.");
        //"Employee Status" := Employee.Status;
    end;

    var
        Text000: Label 'You cannot delete employee qualification information if there are comments associated with it.';
        Qualification: Record 5202;
        Employee: Record 5200;
}

