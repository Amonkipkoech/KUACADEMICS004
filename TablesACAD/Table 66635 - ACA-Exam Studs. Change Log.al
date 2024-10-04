table 66635 "ACA-Exam Studs. Change Log"
{

    fields
    {
        field(1; "Serial No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "Student No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Semester; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Registration,Current,Alluminae,Dropped Out,Deffered,Suspended,Expulsion,Discontinued,Deferred,Deceased,Transferred,Disciplinary,Unknown,Completed not graduated,Graduated no Certificates,Graduated with Certificate,Did Not Report,Absconded,Transferred from MSN,Transferred to MSN,Resit';
            OptionMembers = Registration,Current,Alluminae,"Dropped Out",Deffered,Suspended,Expulsion,Discontinued,Deferred,Deceased,Transferred,Disciplinary,Unknown,"Completed not graduated","Graduated no Certificates","Graduated with Certificate","Did Not Report",Absconded,"Transferred from MSN","Transferred to MSN",Resit;
        }
        field(6; "Change Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Change Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "User ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Show in Senate Reports"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Serial No.", "Student No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "User ID" := USERID;
        "Change Date" := TODAY;
        "Change Time" := TIME;
    end;
}

