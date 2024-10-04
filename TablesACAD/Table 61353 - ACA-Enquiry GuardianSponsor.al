table 61353 "ACA-Enquiry Guardian/Sponsor"
{

    fields
    {
        field(1; "Enquiry No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Enquiry Header"."Enquiry No.";
        }
        field(2; Relationship; Code[20])
        {
            NotBlank = true;
            TableRelation = Relative.Code;
        }
        field(3; SurName; Text[50])
        {
            NotBlank = true;
        }
        field(4; "Other Names"; Text[100])
        {
            NotBlank = true;
        }
        field(5; "ID No/Passport No"; Text[50])
        {
        }
        field(6; "Date Of Birth"; Date)
        {
        }
        field(7; Occupation; Text[100])
        {
        }
        field(8; Address; Text[250])
        {
        }
        field(9; "Office Tel No"; Text[100])
        {
        }
        field(10; "Home Tel No"; Text[50])
        {
        }
        field(11; Remarks; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Enquiry No.", Relationship, SurName)
        {
        }
    }

    fieldgroups
    {
    }
}

