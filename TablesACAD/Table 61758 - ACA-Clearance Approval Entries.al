table 61758 "ACA-Clearance Approval Entries"
{

    fields
    {
        field(1; "Clearance Level Code"; Code[50])
        {
            TableRelation = "ACA-Clearance Level Codes"."Clearance Level Code";
        }
        field(2; Department; Code[30])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER(= 'DEPARTMENT'));
        }
        field(3; "Initiated By"; Code[30])
        {
        }
        field(4; "Initiated Date"; Date)
        {
        }
        field(5; "Initiated Time"; Time)
        {
        }
        field(6; "Last Date Modified"; Date)
        {
        }
        field(7; "Last Time Modified"; Time)
        {
        }
        field(8; "Student Intake"; Code[20])
        {
        }
        field(9; "Clear By ID"; Code[30])
        {
            TableRelation = "User Setup";
        }
        field(10; Cleared; Boolean)
        {
        }
        field(11; "Priority Level"; Option)
        {
            OptionCaption = 'Normal,1st Level,Final level';
            OptionMembers = Normal,"1st Level","Final level";
        }
        field(12; "Student ID"; Code[30])
        {
            TableRelation = Customer."No." WHERE("Customer Type" = FILTER(Student));
        }
        field(13; "Academic Year"; Code[20])
        {
            TableRelation = "ACA-Academic Year".Code;
        }
        field(14; Semester; Code[20])
        {
            TableRelation = "ACA-Semesters".Code;
        }
        field(15; Status; Option)
        {
            OptionCaption = 'Created,Open,Cleared,Rejected,Cancelled';
            OptionMembers = Created,Open,Cleared,Rejected,Cancelled;
        }
        field(16; "Student Name"; Text[100])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Student ID")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Clearance Level Code", Department, "Student ID", "Clear By ID")
        {
        }
    }

    fieldgroups
    {
    }
}

