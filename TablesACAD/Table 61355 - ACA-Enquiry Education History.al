table 61355 "ACA-Enquiry Education History"
{

    fields
    {
        field(1; "Enquiry No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Enquiry Header"."Enquiry No.";
        }
        field(2; From; Date)
        {
            NotBlank = true;
        }
        field(3; "To"; Date)
        {
            NotBlank = true;
        }
        field(4; Qualifications; Text[150])
        {
            NotBlank = true;
        }
        field(5; Instituition; Text[150])
        {
        }
        field(6; Remarks; Text[200])
        {
            Editable = true;
        }
        field(7; "Aggregate Result/Award"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Enquiry No.", Qualifications)
        {
        }
    }

    fieldgroups
    {
    }
}

