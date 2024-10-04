table 61518 "ACA-Semester"
{
    DrillDownPageID = 68744;
    LookupPageID = 68744;

    fields
    {
        field(1; "Code"; Code[50])
        {
            NotBlank = true;
        }
        field(2; Description; Text[150])
        {
        }
        field(3; From; Date)
        {
        }
        field(4; "To"; Date)
        {
        }
        field(5; Remarks; Text[150])
        {
        }
        field(6; "Current Semester"; Boolean)
        {
        }
        field(7; "Academic Year"; Text[9])
        {
        }
        field(8; "SMS Results Semester"; Boolean)
        {
        }
        field(9; "Closure Approval Status"; Option)
        {
            OptionCaption = 'Open,Pending Approval,Cancelled,Rejected,Approved';
            OptionMembers = Open,"Pending Approval",Cancelled,Rejected,Approved;
        }
        field(10; "BackLog Marks"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
        key(Key2; "Academic Year")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        CReg.RESET;
        CReg.SETRANGE(CReg.Semester, Code);
        IF CReg.FIND('-') THEN ERROR('Please note that you can not edit used Semester');
    end;

    trigger OnRename()
    begin
        IF xRec.Code <> Code THEN BEGIN
            CReg.RESET;
            CReg.SETRANGE(CReg.Semester, xRec.Code);
            IF CReg.FIND('-') THEN ERROR('Please note that you can not edit used Semester');
        END;
    end;

    var
        CReg: Record 61532;
}

