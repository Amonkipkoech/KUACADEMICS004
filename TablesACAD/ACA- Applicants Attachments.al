table 86520 "ACA-Applicants Attachments"
{

    fields
    {
        field(1; "APP No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Applic. Form Header"."Application No.";
        }
        field(2; "Document Description"; Text[200])
        {
            NotBlank = true;
        }
        field(3; "Document Link"; Text[200])
        {
        }
        field(6; "Attachment No."; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(7; "Language Code (Default)"; Code[10])
        {
            TableRelation = Language;
        }
        field(8; Attachment; Option)
        {
            Editable = false;
            OptionMembers = No,Yes;
        }
    }

    keys
    {
        key(Key1; "APP No", "Document Description")
        {
        }
    }

    fieldgroups
    {
    }

    var
        DocLink: Record "HRM-Employee Attachments";

    procedure PlaceFilter(prompt: Boolean; EmployeeNo: Code[10]): Boolean
    begin
        if prompt then begin
            SetFilter("APP No", EmployeeNo);
        end;
    end;
}

