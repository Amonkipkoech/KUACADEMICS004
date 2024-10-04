/// <summary>
/// Table Provisional Transcript Comment (ID 88852).
/// </summary>
table 88852 "Provisional Transcript Comment"
{

    fields
    {
        field(1; "Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(63039; "Special Programme Class"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'General,Medicine & Nursing,Engineering';
            OptionMembers = General,"Medicine & Nursing",Engineering;

            trigger OnValidate()
            var
                ACAUnitsSubjects: Record "ACA-Units/Subjects";
            begin
            end;
        }
        field(63067; "1st Year Trans. Comments"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(63068; "2nd Year  Trans. Comments"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(63069; "3rd Year  Trans. Comments"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(63070; "4th Year  Trans. Comments"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(63071; "5th Year  Trans. Comments"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(63072; "6th Year  Trans. Comments"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(63073; "7th Year  Trans. Comments"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(63074; "Exam Category"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code", "Special Programme Class", "Exam Category")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

