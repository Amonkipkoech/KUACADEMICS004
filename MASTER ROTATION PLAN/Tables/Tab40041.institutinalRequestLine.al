table 40041 "Institution Request Line"
{

    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer) { AutoIncrement = true; }

        field(2; "Request Number"; Code[20])
        {
            Caption = 'Request Number';
            //TableRelation = "Institutional Request"."Request Number";
        }

        field(3; "Student Number"; Code[20]) { }
        field(4; "Student Name"; Text[100]) { }
        field(5; "Phone Number"; Text[30]) { }
        field(6; "School Email"; Text[100]) { }
        field(7; "ID/Passport"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Entry No.", "Request Number") { Clustered = true; }
    }
}
