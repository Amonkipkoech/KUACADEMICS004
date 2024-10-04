table 78004 "Aca-Special Exams Parameters"
{

    fields
    {
        field(1; "Exam Type Code"; Code[20])
        {
        }
        field(2; "Exam Type Description"; Text[200])
        {
        }
        field(3; "Allowable Attempts"; Integer)
        {
        }
        field(4; "Default Status"; Option)
        {
            Description = 'Defines the status that the student defaults to after the Maximum Allowable Attempts are Exceeded';
            OptionCaption = 'Registration,Current,Alluminae,Dropped Out,Deffered,Suspended,Expulsion,Discontinued,Deferred,Deceased,Transferred,Disciplinary,Unknown,Completed not graduated,Graduated no Certificates,Graduated with Certificate';
            OptionMembers = Registration,Current,Alluminae,"Dropped Out",Deffered,Suspended,Expulsion,Discontinued,Deferred,Deceased,Transferred,Disciplinary,Unknown,"Completed not graduated","Graduated no Certificates","Graduated with Certificate";
        }
        field(5; "Maximum Score"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Exam Type Code")
        {
        }
    }

    fieldgroups
    {
    }
}

