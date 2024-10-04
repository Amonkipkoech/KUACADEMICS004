table 85523 "ACA-MarkSheet Submission"
{


    fields
    {
        field(1; "Submission Code"; Code[20])
        {

        }
        field(2; Campus; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(3; "Academic Year"; Code[20])
        {
            TableRelation = "ACA-Academic Year".Code;
        }
        field(4; "Unit Base Code"; Code[20])
        {
            TableRelation = "ACA-Units Master Table"."Unit Base Code";
        }
        field(5; "Mode Of Study"; code[20])
        {
            TableRelation = "ACA-Student Types".Code;
        }
        field(6; Stream; Text[100])
        {

        }
        field(7; "Lecturer Staff ID"; Code[20])
        {
            TableRelation = "HRM-Employee (D)";
        }
        field(8; "Submitting Officer Staff ID"; code[20])
        {
            TableRelation = "HRM-Employee (D)";
        }
        field(9; "Registry Receiving Staff ID"; code[20])
        {
            TableRelation = "HRM-Employee (D)";
        }
        field(10; "Date Marksheet Received"; Date)
        {

        }
    }

    keys
    {
        key(Key1; "Submission Code")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;


}