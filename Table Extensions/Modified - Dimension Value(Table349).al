tableextension 70006 "Dimension Value" extends "Dimension Value"
{
    fields
    {
        field(13; "Senate Classification Based on"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Year of Study,Academic Year';
            OptionMembers = " ","Year of Study","Academic Year";
        }
        field(50000; Picture; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(50001; "Semester Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Semesters".Code;
        }
        field(50002; Signature; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(50003; "HOD Names"; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; Titles; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Faculty Name"; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "HOD staff Id"; Code[20])
        {
            TableRelation = "HRM-Employee (D)";
        }
        field(50007; "Faculty"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(50008; "Dean Staff ID"; code[20])
        {
            TableRelation = "HRM-Employee (D)";
        }

        field(296704; Lost; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(296705; Location; Code[20])
        {
            Caption = 'Campus Location';
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(296706; "Department  Category"; Option)
        {
            OptionMembers = "Academic Departments","Administrative Departments and Offices";
        }

    }
}