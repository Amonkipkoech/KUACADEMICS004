table 69220 "Exam Sessions Management"
{

    fields
    {
        field(1; "Academic Year"; Code[20])
        {
        }
        field(2; Semester; Code[20])
        {
        }
        field(3; "Exam Session"; Code[20])
        {
        }
        field(4; Status; Option)
        {
            OptionCaption = ' Created,Pending Approval,Approved,Available';
            OptionMembers = " Created","Pending Approval",Approved,Available;
        }
        field(5; Category; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Regular Exams,Supplementary Exams,Special Exams';
            OptionMembers = "Regular Exams","Supplementary Exams","Special Exams";
        }
    }

    keys
    {
        key(Key1; "Academic Year")
        {
        }
    }

    fieldgroups
    {
    }
}

