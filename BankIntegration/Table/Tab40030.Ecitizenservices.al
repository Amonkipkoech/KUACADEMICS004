table 40030 "E-Citizen Services"
{
    LookupPageId = "E-Citizen Services";
    DrillDownPageId = "E-Citizen Services";
    fields
    {
        field(1; "Service Code"; Code[30])
        {

        }
        field(2; Services; Text[100])
        {

        }
        field(3; "Bank"; Text[100])
        {

        }
        field(4; "Branch"; Text[100])
        {

        }
        field(5; "Account Number"; Text[30])
        {

        }
        field(6; "Bank Code"; Code[30])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(7; "Currency"; Code[30])
        {

        }
        field(8; "Insitution"; Text[100])
        {

        }

    }

    // trigger OnModify()
    // begin
    //     if UserId <> 'FRANKIE' then Error('');
    // end;

    // trigger OnInsert()
    // begin
    //     if UserId <> 'FRANKIE' then Error('');
    // end;

    // trigger OnDelete()
    // begin
    //     if UserId <> 'FRANKIE' then Error('');
    // end;
}
