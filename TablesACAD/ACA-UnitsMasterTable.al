table 86521 "ACA-Units Master Table"
{
    DrillDownPageID = "ACA-Units Master table";
    LookupPageID = "ACA-Units Master table";
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Unit Code"; Code[20])
        {


        }
        field(8; "Unit Name"; Text[100])
        {

        }
        field(2; "Unit Base Code"; Code[20])
        {

        }

        field(3; "Department Code"; Text[200])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("ACA-Programme"."Department Name" where(Code = field("Programme Code")));
        }


        field(4; "Level Code"; Code[20])
        {
            TableRelation = "ACA-Exam Category".Code;


            // trigger OnValidate()
            // var
            //     ACAProgramme: Record 61511;
            // begin
            //     IF (("Level Code" = '') OR ("Level Code" = ' ')) THEN BEGIN
            //         ACAProgramme.RESET;
            //         ACAProgramme.SETRANGE(Code, "Programme Code");
            //         IF ACAProgramme.FIND('-') THEN BEGIN
            //             // ACAProgramme.TESTFIELD("Exam Category");
            //             ExamCategory := ACAProgramme."Exam Category";
            //         END;
            //     END ELSE BEGIN
            //         ExamCategory := "Level Code";
            //     END;
            // end;
        }
        field(5; "Credit Hours"; Decimal)
        {

        }
        field(6; "Programme Code"; Code[20])
        {
            //TableRelation = "ACA-Programme".Code;
        }
        field(7; ExamCategory; code[20])
        {

        }
        field(9; "Unit Base Title"; Text[100])
        {

        }
        field(10; "Prerequisite Unit Code 1"; code[20])
        {

        }
        field(11; "Prerequisite Unit Code 2"; code[20])
        {

        }
        field(12; "Prerequisite Unit Code 3"; code[20])
        {

        }
        field(13; Faculty; text[200])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("ACA-Programme"."Faculty Name" where(Code = field("Programme Code")));
        }

    }

    keys
    {
        key(Key1; "Unit Code", "Unit Base Code")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;



}