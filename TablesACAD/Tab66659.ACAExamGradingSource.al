table 66659 "ACA-Exam Grading Source"
{
    LookupPageId = "ACA-Exam Grading Sources";
    DrillDownPageId = "ACA-Exam Grading Sources";
    fields
    {
        field(1; "Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Academic Year"."Code";
        }
        field(3; "Exam Catregory"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Exam Category"."Code";
        }
        field(7; "Total Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Grade; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Pass; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Remarks; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Results Exists Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Both Exists,CAT Only,Exam Only,None Exists';
            OptionMembers = " ","Both Exists","CAT Only","Exam Only","None Exists";
        }
        field(13; CatMarksExist; Boolean)
        {

        }
        field(14; ExamMarksExist; Boolean)
        {
            
        }
        field(12; "Consolidated Prefix"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Academic Year", "Exam Catregory", "Total Score", "Results Exists Status")
        {
        }
        key(Key2; Grade)
        {
        }
    }

    fieldgroups
    {
    }
}

