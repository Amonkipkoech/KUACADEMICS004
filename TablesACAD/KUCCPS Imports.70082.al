/// <summary>
/// Table KUCCPS Imports (ID 70082).
/// </summary>
table 70082 "KUCCPS Imports"
{

    fields
    {
        field(1; ser; Integer)
        {
            AutoIncrement = true;
        }
        field(2; Index; Code[20])
        {
        }
        field(3; Admin; Code[20])
        {
        }
        field(4; Prog; Code[20])
        {
        }
        field(5; Names; Text[100])
        {
        }
        field(6; Gender; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(7; Phone; Code[20])
        {
        }
        field(8; "Alt. Phone"; Code[20])
        {
        }
        field(9; Box; Code[50])
        {
        }
        field(10; Codes; Code[20])
        {
        }
        field(11; Town; Code[40])
        {
        }
        field(12; Email; Text[100])
        {
        }
        field(13; "Slt Mail"; Text[100])
        {
            Caption = 'Alt Mail';
        }
        field(14; Processed; Boolean)
        {
        }
        field(15; "Intake Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(16; Surname; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Campus Location"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "ID Number/Birth Certificate"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Date of Birth"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(20; County; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(21; Nationality; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Ethnic Background"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Disability Status"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Disability Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(25; Updated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(26; Generated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Spouse Phone No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Number of Children"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Full Name of Father"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Father Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Alive,Deceased';
            OptionMembers = Alive,Deceased;
        }
        field(31; "Father Occupation"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Father Date of Birth"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Name of Mother"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Mother Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Alive,Deceased';
            OptionMembers = Alive,Deceased;
        }
        field(35; "Mother Occupation"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Mother Date of Birth"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Number of brothers and sisters"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Place of Birth"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Permanent Residence"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Nearest Town"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(41; Location; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Name of Chief"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Sub-County"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(44; Constituency; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Nearest Police Station"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Emergency Name1"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Emergency Relationship1"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Emergency P.O. Box1"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Emergency Phone No1"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Emergency Email1"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Emergency Name2"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Emergency Relationship2"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Emergency P.O. Box2"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(54; "Emergency Phone No2"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Emergency Email2"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(56; "OLevel School"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(57; "OLevel Year Completed"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(58; "Primary School"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Primary Index no"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Primary Year Completed"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(61; "K.C.P.E. Results"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(62; "Any Other Institution Attended"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(63; Results; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(64; "NIIMS No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(65; "NHIF No"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(66; Religion; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Religions".Religion;
        }
        field(67; "Marital Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Single,Married,Divorced,Widowed';
            OptionMembers = Single,Married,Divorced,Widowed;
        }
        field(68; "Name of Spouse"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(69; "Occupation of Spouse"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Father Phone"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(71; "Mother Phone"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(72; "County Of Origin"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(73; Picture; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(100; "KUCCPS Batch"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(101; "Notified"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(Key1; ser)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

