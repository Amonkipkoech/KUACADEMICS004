table 86523 "Project Tracking"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Academic Year"; Code[20])
        {
            TableRelation = "ACA-Academic Year".Code;

        }
        field(2; Semester; code[20])
        {
            TableRelation = "ACA-Semesters".Code;
        }
        field(3; "Student Id"; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(4; "Program ID"; code[20])
        {
            TableRelation = "ACA-Programme".Code;
        }
        field(5; "Project/Thesis Title"; Text[100])
        {

        }
        field(6; "Supervisor Staff ID"; code[20])
        {
            TableRelation = "HRM-Employee (D)";
        }
        field(7; "Secondary Supervisor Name"; text[100])
        {

        }
        field(8; "Supervisor Allocation Date"; Date)
        {

        }
        field(9; "Proposal Defense Date"; Date)
        {

        }
        field(10; "Proposal Defence Status"; Option)
        {
            OptionMembers = " ",Accepted,Rejected;
        }
        field(11; "Final Defense Date"; Date)
        {

        }
        field(12; "Final Defense Results"; option)
        {
            OptionMembers = " ",Accepted,Rejected;
        }
        field(13; "Allocated Internal Examiner 1"; Text[100])
        {

        }
        field(14; "Allocated Internal Examiner 2"; Text[100])
        {

        }
        field(15; "Allocated External Examiner"; Text[100])
        {

        }
        field(16; "Article Published"; Option)
        {
            OptionMembers = " ",Yes,No;
        }
        field(17; "Article  Title"; Text[100])
        {

        }
        field(18; "Journal Title"; Text[100])
        {

        }
        field(19; "Journal Edition"; Text[100])
        {

        }
        field(20; "Anti-Plagiarism"; Option)
        {
            OptionMembers = " ",Yes,No;
        }
        field(21; "Log book Issues to Student"; Option)
        {
            OptionMembers = " ",Yes,No;
        }
        field(22; "Log Book Issued Date"; Date)
        {

        }
        field(23; "Log Book Issued to HOD"; Option)
        {
            OptionMembers = " ",Yes,No;
        }
        field(24; "Log book submission date"; Date)
        {

        }
        field(25; "Thesis Code"; code[10])
        {

        }
    }

    keys
    {
        key(Key1; "Thesis Code", "Project/Thesis Title")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;



}