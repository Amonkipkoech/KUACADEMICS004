table 61534 "ACA-General Set-Up"
{

    fields
    {
        field(1; "Student Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(2; "Registration Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(3; "Primary Key"; Code[10])
        {
        }
        field(4; "Receipt Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(5; "Defered Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(6; "Transaction Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(7; "Over Payment Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(8; "Pre-Payment Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(9; "Allow Posting From"; Date)
        {
        }
        field(10; "Allow Posting To"; Date)
        {
        }
        field(11; "Unallocated Rcpts Account"; Code[20])
        {
            TableRelation = Customer;
        }
        field(12; "Further Info Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(13; "Medical Condition Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(14; "Attachment Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(15; "Enquiry Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(16; "Application Fee"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(17; "Clearance Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(18; "Proforma Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(19; "Base Date"; Date)
        {
        }
        field(20; "Max Hours Continiously"; Decimal)
        {
        }
        field(21; "Max Hours Weekly"; Decimal)
        {
        }
        field(22; "Max Days Per Week"; Integer)
        {
        }
        field(23; "Max Lecturer Hours Daily"; Decimal)
        {
        }
        field(24; "Max Lecturer Days Per Week"; Decimal)
        {
        }
        field(25; "Applications Date Line"; Date)
        {
        }
        field(26; "Allow UnPaid Hostel Booking"; Boolean)
        {
        }
        field(27; "Default Year"; Code[20])
        {
            TableRelation = "ACA-Programme Stages"."Programme Code";
        }
        field(28; "Impt. Unit"; Code[20])
        {
        }
        field(29; "Impt. Staff"; Code[20])
        {
        }
        field(30; "Impt. Semester"; Code[20])
        {
        }
        field(31; "Impt. Stage"; Code[20])
        {
        }
        field(32; "Impt. RegID"; Code[20])
        {
        }
        field(33; "Impt. Category"; Code[20])
        {
        }
        field(34; "Impt. Programme"; Code[20])
        {
        }
        field(35; "Pass List Label"; Text[250])
        {
        }
        field(36; "Fail List Label"; Text[250])
        {
        }
        field(37; "Supp List Label"; Text[250])
        {
        }
        field(38; "Allow Units Add. in Posted Sem"; Boolean)
        {
        }
        field(39; "Cons. Marksheet Key1"; Text[250])
        {
        }
        field(40; "Cons. Marksheet Key2"; Text[250])
        {
        }
        field(41; "Bill Supplimentary Fee"; Boolean)
        {
        }
        field(42; "Supplimentary Fee Code"; Code[20])
        {
            TableRelation = "ACA-Charge".Code;
        }
        field(43; "CDF Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(44; "Helb Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(120; lost; Integer)
        {
        }
        field(50000; "Allowed Reg. Fees Perc."; Decimal)
        {
        }
        field(50001; "Allow Online Results Access"; Boolean)
        {
        }
        field(50002; "Current TT Code"; Code[20])
        {
        }
        field(50050; "Time Table Semester"; Code[20])
        {
            FieldClass = Normal;
            TableRelation = "ACA-Semesters".Code;
        }
        field(50051; "Time Table Campus"; Code[20])
        {
            FieldClass = Normal;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50052; Picture; BLOB)
        {
            SubType = Bitmap;
        }
        field(50053; "Library Fines"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50054; "Default Semester"; Code[20])
        {
            TableRelation = "ACA-Semesters";
        }
        field(50055; "Default Intake"; Code[20])
        {
            TableRelation = "ACA-Intake".Code;
        }
        field(50056; "Default Academic Year"; Code[20])
        {
            TableRelation = "ACA-Academic Year".Code;
        }
        field(50057; "Class Allocation Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50058; "Bar Code"; BLOB)
        {
            SubType = Bitmap;
        }
        field(50059; "Hostel Incidents"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50060; "% of Accomodation"; Decimal)
        {
        }
        field(50061; "% of Billed Fees/Balance"; Decimal)
        {
        }
        field(50062; "Lecturers Expense Account"; Code[10])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50063; "Supplimentary Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50064; "Special Exam Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50065; "Supplimentary Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Charge".Code;
        }
        field(50066; "Special Exam Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Charge".Code;
        }
        field(50067; "Scholarship Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50069; "Deferral Nos."; code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50070; "Student Portal Message"; Text[250])
        {

        }
        field(50071; "Release Proforma Invoice"; Boolean)
        {

        }
        field(50072; "Receipt Buffer Nos"; code[20])
        {

            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
       
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

