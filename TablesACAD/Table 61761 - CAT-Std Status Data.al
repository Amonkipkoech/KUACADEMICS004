table 61761 "CAT-Std Status Data"
{

    fields
    {
        field(1; "Student No."; Code[40])
        {
        }
        field(2; "ID No."; Code[30])
        {
        }
        field(3; "First Name"; Text[50])
        {
        }
        field(4; "Middle Name"; Text[50])
        {
        }
        field(5; "Last Name"; Text[50])
        {
        }
        field(6; Title; Code[50])
        {
        }
        field(7; Gender; Option)
        {
            OptionCaption = ',Male,Female';
            OptionMembers = ,Male,Female;
        }
        field(8; "Sponsor Ref."; Code[50])
        {
        }
        field(9; "Sponsor Id"; Code[50])
        {
        }
        field(10; "Sponsor Dep. Name"; Text[138])
        {
        }
        field(11; "NOK Relation"; Code[66])
        {
        }
        field(12; "NOK Address"; Code[67])
        {
        }
        field(13; "NOK Email"; Code[68])
        {
        }
        field(14; "NOK Town"; Code[69])
        {
        }
        field(15; "NOK Phone"; Code[70])
        {
        }
        field(16; "NOK Ext"; Code[71])
        {
        }
        field(17; "NOK Mobile"; Code[72])
        {
        }
        field(18; "Withdrawal Reason"; Code[73])
        {
        }
        field(19; "Withdrawal Naration"; Code[120])
        {
        }
        field(20; "Withdrawal Date"; Code[50])
        {
        }
        field(21; "Withdrawal User"; Code[50])
        {
        }
        field(22; "Reg. Type"; Code[50])
        {
        }
        field(23; "Reinstate Note"; Code[50])
        {
        }
        field(24; Cleared; Boolean)
        {
        }
        field(25; "Discipline Status"; Code[111])
        {
        }
        field(26; "Index No."; Code[50])
        {
        }
        field(27; Reg_Stud_COF1; Code[50])
        {
        }
        field(28; RegStudent_CourseID; Code[50])
        {
        }
        field(29; RegStud_DeptID; Code[115])
        {
        }
        field(30; RegStud_Class; Code[116])
        {
        }
        field(31; RegCtudent_Cleared; Code[50])
        {
        }
        field(32; RegCtudent_Cleared_Date; Code[50])
        {
        }
        field(33; RegStudent_Spons_Name; Code[119])
        {
        }
        field(34; Sponsor_Address; Code[120])
        {
        }
        field(35; Sponsor_Town; Code[121])
        {
        }
        field(36; Sponsor_Email; Text[122])
        {
        }
        field(37; Course_Start_Date; Code[50])
        {
        }
        field(38; Course_End_Date; Code[50])
        {
        }
        field(39; Reinstatement_Date; Code[50])
        {
        }
        field(40; RegStud_RegStatus; Code[126])
        {
        }
        field(41; RegStud_RegDate; Code[50])
        {
        }
        field(42; Origin; Code[128])
        {
        }
        field(43; "NOK Name"; Text[129])
        {
        }
    }

    keys
    {
        key(Key1; "Student No.")
        {
        }
    }

    fieldgroups
    {
    }
}

