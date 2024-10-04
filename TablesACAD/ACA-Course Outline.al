table 61625 "ACA-Unit Course Outline"
{

    fields
    {
        field(1; "Programme Code"; code[30])
        {

        }
        field(2; "Semester"; code[30])
        {

        }
        field(3; "Stage Code"; code[20])
        {

        }
        field(4; "Unit Base Code"; code[20])
        {

        }
        field(5; "Stream"; Code[30])
        {

        }
        field(6; "Unit Base Title"; Text[100])
        {

        }
        field(7; "Course Outline"; code[20])
        {

        }
        field(8; "Course Description"; Text[250])
        {

        }
        field(9; "Lecture Staff ID"; Code[20])
        {

        }

        field(11; "Consultation Hours"; Decimal)
        {

        }
        field(12; "Pre-Requisites"; Text[200])
        {

        }
        field(13; "Learning Outcomes"; Text[250])
        {

        }
        field(14; "Course Topic"; Text[100])
        {

        }
        field(15; "Recommended Texts"; Text[250])
        {

        }
        field(16; "Other Remarks"; Text[250])
        {

        }
        field(17; "Date Uploaded"; date)
        {

        }


    }

    keys
    {
        key(key1; "Programme Code", Semester, "Stage Code", "Unit Base Code", Stream)
        {

        }
    }

    trigger OnInsert()
    begin
        "Date Uploaded" := Today;
    end;
}