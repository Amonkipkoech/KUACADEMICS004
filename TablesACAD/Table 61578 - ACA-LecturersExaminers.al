table 61578 "ACA-Lecturers/Examiners"
{
    //LookupPageID = 69137;

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "First Name"; Text[80])
        {
        }
        field(3; "Middle Name"; Text[80])
        {
        }
        field(4; "Last Name"; Text[80])
        {
        }
        field(5; Initials; Text[30])
        {
        }
        field(6; Type; Option)
        {
            OptionMembers = Permanent," Contract"," Attachment";
        }
        field(7; "Postal Address"; Text[80])
        {
        }
        field(8; "Residential Address"; Text[80])
        {
        }
        field(9; City; Text[30])
        {
        }
        field(10; "Post Code"; Code[30])
        {
            TableRelation = "Post Code";
        }
        field(11; County; Text[30])
        {
        }
        field(12; "Home Phone Number"; Text[50])
        {
        }
        field(13; "Cellular Phone Number"; Text[50])
        {
        }
        field(14; "Work Phone Number"; Text[50])
        {
        }
        field(15; "Ext."; Text[30])
        {
        }
        field(16; Email; Text[50])
        {
        }
        field(17; Picture; BLOB)
        {
        }
        field(18; "ID Number"; Text[30])
        {
        }
        field(19; Gender; Option)
        {
            OptionMembers = ,Male,Female;
        }
        field(21; "Country Code"; Code[30])
        {
            TableRelation = "Country/Region";
        }
        field(22; Status; Option)
        {
            OptionMembers = Normal,Resigned,Discharged,Retrenched,Pension,Disabled;
        }
        field(23; "Department Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DEPARTMENT'));
        }
        field(24; "Fax Number"; Text[50])
        {
        }
        field(25; Title; Option)
        {
            OptionMembers = MR,MRS,MISS,MS,DR,"  ",CC;
        }
        field(26; "Known As"; Text[60])
        {
        }
        field(27; Position; Text[30])
        {
        }
        field(28; "Marital Status"; Option)
        {
            OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)",Other;
        }
        field(29; "Date of Birth"; Date)
        {

            trigger OnLookup()
            begin
                //Age := Dates.DetermineAge("Date of Birth", "Date of Birth");
                MESSAGE(Age);
            end;

            trigger OnValidate()
            begin
                //Age := Dates.DetermineAge("Date of Birth", "Date of Birth");
                MESSAGE(Age);
            end;
        }
        field(30; Age; Text[100])
        {
        }
        field(31; "Date of Join"; Date)
        {
        }
        field(32; "Length of Service"; Text[30])
        {
        }
        field(33; "Date of Leaving"; Date)
        {
        }
        field(34; "NSSF No."; Code[30])
        {
        }
        field(35; "NHIF No."; Code[30])
        {
        }
        field(36; "PayRoll No."; Code[30])
        {
        }
        field(37; "HELB No."; Text[30])
        {
        }
        field(38; Campus; Code[30])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('CAMPUS'));
        }
        field(39; "FullTime/Part Time"; Option)
        {
            OptionMembers = "Full Time"," Part Time",Contract;
        }
        field(40; PayPeriod; Option)
        {
            OptionMembers = Daily," Weekly"," FortNight"," Monthly"," Quarterly"," Annual"," Other";
        }
        field(41; AmountDue; Decimal)
        {
        }
        field(42; StatusofPayment; Option)
        {
            OptionMembers = Paid,Pending,Canceled;
        }
        field(43; DateofPayment; Date)
        {
        }
        field(44; "PayRoll No"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
    // Dates: Codeunit 50126;
}

