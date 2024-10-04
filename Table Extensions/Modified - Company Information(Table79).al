/// <summary>
/// TableExtension Company Information (ID 70007) extends Record Company Information.
/// </summary>
tableextension 70007 "Company Information" extends "Company Information"
{
    fields
    {
        field(10027; "Multiple Payroll"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10028; "N.H.I.F No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        /* field(10029; "Company P.I.N"; Code[20])
        {
            DataClassification = ToBeClassified;
        } */
        field(50000; "Last Settlement Type"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Last Semester Filter"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Last Used date Filter (Inv. 1)"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Last Used date Filter (Inv. 2)"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "License end Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
}