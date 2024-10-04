table 61599 "ACA-Exam Gradding Setup"
{

    fields
    {
        field(1; Category; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Exams Setup".Category;
        }
        field(2; Grade; Code[20])
        {
            NotBlank = true;
        }
        field(3; Description; Text[150])
        {
        }
        field(4; "Up to"; Decimal)
        {
        }
        field(5; Remarks; Code[150])
        {
        }
        field(6; Failed; Boolean)
        {
        }
        field(7; Range; Text[150])
        {
        }
        field(11; "Results Exists Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Both Exists,CAT Only,Exam Only,None Exists';
            OptionMembers = " ","Both Exists","CAT Only","Exam Only","None Exists";
        }
        field(12; "Consolidated Prefix"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Lower Limit"; Decimal)
        {
        }
        field(50002; "Upper Limit"; Decimal)
        {
        }
        field(50003; Award; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; Category, "Up to")
        {
        }
        key(Key2; Grade)
        {
        }
    }

    fieldgroups
    {
    }

    // trigger OnDelete()
    // begin
    //     IF ((USERID <> 'WANJALA') AND (USERID <> 'COSMAS.MUTHAMIA')) THEN ERROR('ACCESS DENIED');
    // end;

    // trigger OnInsert()
    // begin
    //     IF ((USERID <> 'WANJALA') AND (USERID <> 'COSMAS.MUTHAMIA')) THEN ERROR('ACCESS DENIED');
    // end;

    // trigger OnModify()
    // begin
    //     IF ((USERID <> 'WANJALA') AND (USERID <> 'COSMAS.MUTHAMIA')) THEN ERROR('ACCESS DENIED');
    // // end;

    // trigger OnRename()
    // begin
    //     IF ((USERID <> 'WANJALA') AND (USERID <> 'COSMAS.MUTHAMIA')) THEN ERROR('ACCESS DENIED');
    //end;
}

