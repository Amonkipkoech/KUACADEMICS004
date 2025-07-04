table 40010 "Clinical rotation"

{
    DataClassification = ToBeClassified;

    fields
    {
        field(111; "No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'No';
            AutoIncrement = true;
            Editable = false; // Set to false as it will be auto-generated
        }
        field(1; "Plan ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Plan ID';
            //TableRelation = "ACA-Semesters".Code;
            Editable = false; // Set to false as it will be auto-generated
        }
        field(90; "Year"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Academic Year';
            //TableRelation = "ACA-Academic Year".Code;
            Editable = false; // Set to false as it will be auto-generated
        }
        field(91; "Session"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Session';
            TableRelation = "Master Rotation Plan2".Session;
            Editable = false; // Set to false as it will be auto-generated
        }

        field(92; Department; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Department';
            //TableRelation = "Master Rotation Plan2".Department;
            Editable = false; // Set to false as it will be auto-generated
        }
        field(93; program; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'program ';
            TableRelation = "Master Rotation Plan2"."Program Code";
            Editable = false; // Set to false as it will be auto-generated
        }
        field(94; Status; Enum "Mrp Status Approval")
        {
            DataClassification = ToBeClassified;
            Caption = 'Status ';
            TableRelation = "Master Rotation Plan2".Status;
            Editable = false; // Set to false as it will be auto-generated
        }
        field(2; "No Of Students"; Integer)
        {

            FieldClass = FlowField;
            CalcFormula = count(GroupAssignments where("Groupid" = field("Group")));


        }

        field(3; Group; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = GroupAssignments.GroupId;
        }

        field(4; "Month"; Option)
        {
            OptionMembers = "January","February","March","April","May","June","July","August","September","October","November","December";
        }

        field(5; "Starting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Ending Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Week; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(22; Capacity; Integer)
        {

            Caption = 'Lab Capacity';
            FieldClass = FlowField;
            CalcFormula = Lookup(Lab.Capacity WHERE("Area cODE" = FIELD(Areas)));
            Editable = false;


        }


        field(128; Areas; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Lab."Area cODE";
            // trigger OnValidate()
            // var
            //     lab: Record Lab;
            // begin
            //     if lab.Get(Areas) then begin
            //         rec.Capacity := lab.Capacity;
            //     end;
            // end;
        }

        field(9; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Stores the number series in the database';
        }
        field(10; Block7; enum "Block Category Enum")
        {
            DataClassification = ToBeClassified;
            TableRelation = "Master Rotation Plan2".Block;
            Description = 'Block Name';
        }
        field(11; "Assessment Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Assessment Start Date';
        }
        field(12; "Assessment End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Assessment End Date';
        }
        field(13; "Assessment Score"; Text[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Assessment Score';
        }
        field(14; "Pass Mark"; Text[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Assessment Score';
        }
        field(15; Passed; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Is Assessment Passed';
        }
        field(16; "Master Plan No"; Text[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Master Plan Number';
        }
        field(17; "Lecturer No"; Text[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Lecturer Number';
        }
        field(18; "Lecturer Name"; Text[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Lecturer Name';
        }
        field(19; "Block 1"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Master Rotation Plan2";
            Description = 'Lecturer Name';
        }
        field(20; "Block 2"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Lecturer Name';
        }
        field(21; "Block 3"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Lecturer Name';
        }
        field(56; "Remaining Capacity"; Integer)
        {

            Caption = 'Remaining Capacity';
            Editable = false;
            // Calculated on the fly in the page
        }


        // Add additional fields as needed
    }

    keys
    {
        key(PK; "No.", "Plan ID", Year, Session, Department, program, Status)
        {
            Clustered = true;
        }
    }





    var
        FixedAsset: Record "Fixed Asset";
}
