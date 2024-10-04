table 78011 "ACA-Class/Grad. Rubrics"
{
    DrillDownPageID = 78012;
    LookupPageID = 78012;

    fields
    {
        field(1; "Code"; Code[50])
        {
        }
        field(2; Description; Text[100])
        {
        }
        field(7; "Classification Msg1"; Text[250])
        {
        }
        field(8; "Classification Msg2"; Text[250])
        {
        }
        field(9; "Classification Msg3"; Text[250])
        {
        }
        field(10; "Classification Msg4"; Text[250])
        {
        }
        field(11; "Classification Msg5"; Text[250])
        {
        }
        field(12; "Order No"; Integer)
        {
        }
        field(50005; "Classification Msg6"; Text[250])
        {
        }
        field(50006; "Include Class Variable 1"; Boolean)
        {
        }
        field(50007; "Include Class Variable 2"; Boolean)
        {
        }
        field(50008; "Include Class Variable 3"; Boolean)
        {
        }
        field(50009; "Include Class Variable 4"; Boolean)
        {
        }
        field(50010; "Include Class Variable 5"; Boolean)
        {
        }
        field(50011; "Include Class Variable 6"; Boolean)
        {
        }
        field(63021; "Summary Page Caption"; Text[250])
        {
        }
        field(63022; "Include Failed Units Headers"; Boolean)
        {
        }
        field(63024; "Final Transcript Remarks"; Code[150])
        {
        }
        field(63025; "Final Year Comment"; Text[150])
        {
        }
        field(63026; "Graduation Status Msg1"; Text[150])
        {
        }
        field(63027; "Graduation Status Msg2"; Text[150])
        {
        }
        field(63028; "Graduation Status Msg3"; Text[150])
        {
        }
        field(63029; "Graduation Status Msg4"; Text[150])
        {
        }
        field(63030; "Graduation Status Msg5"; Text[150])
        {
        }
        field(63031; "Graduation Status Msg6"; Text[150])
        {
        }
        field(63032; "Graduation IncludeVariable 1"; Boolean)
        {
        }
        field(63033; "Graduation IncludeVariable 2"; Boolean)
        {
        }
        field(63034; "Graduation IncludeVariable 3"; Boolean)
        {
        }
        field(63035; "Graduation IncludeVariable 4"; Boolean)
        {
        }
        field(63036; "Graduation IncludeVariable 5"; Boolean)
        {
        }
        field(63037; "Graduation IncludeVariable 6"; Boolean)
        {
        }
        field(63038; "Graduation Rubric Caption"; Text[150])
        {
        }
        field(63039; "Alternate Rubric"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Class/Grad. Rubrics".Code;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
        key(Key2; "Order No")
        {
        }
    }

    fieldgroups
    {
    }

    //trigger OnDelete()
    //begin
    //     IF ((USERID <> 'COSMAS.MUTHAMIA') AND (USERID <> 'WANJALA') AND (USERID <> 'OOKOTH') AND (USERID <> 'JODERO')) THEN ERROR('Accecc Denied!');
    // end;

    // trigger OnInsert()
    // begin
    //     IF ((USERID <> 'COSMAS.MUTHAMIA') AND (USERID <> 'WANJALA') AND (USERID <> 'OOKOTH') AND (USERID <> 'JODERO')) THEN ERROR('Accecc Denied!');
    // end;

    // trigger OnModify()
    // begin
    //     IF ((USERID <> 'COSMAS.MUTHAMIA') AND (USERID <> 'WANJALA') AND (USERID <> 'OOKOTH') AND (USERID <> 'JODERO')) THEN ERROR('Accecc Denied!');
    // end;

    // trigger OnRename()
    // begin
    //     IF ((USERID <> 'COSMAS.MUTHAMIA') AND (USERID <> 'WANJALA') AND (USERID <> 'OOKOTH') AND (USERID <> 'JODERO')) THEN ERROR('Accecc Denied!');
    // end;
}

