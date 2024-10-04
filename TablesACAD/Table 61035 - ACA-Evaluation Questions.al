table 61035 "ACA-Evaluation Questions"
{
    // DrillDownPageID = 39004556;
    // LookupPageID = 39004556;

    fields
    {
        field(1; ID; Code[10])
        {
        }
        field(2; Description; Text[250])
        {
        }
        field(3; Type; Option)
        {
            OptionMembers = ,"EVALUATION OF LECTURER ON TEACHING BY STUDENTS","LECTURERS ATTENDANCE EVALUATION FORM";
        }
        field(4; Category; Option)
        {
            OptionCaption = ',COURSE OUTLINE,CONTENT PRESENTATION,PERSONAL ATTRIBUTES,Numeric,COMMON AREAS OF ASSESMENT,CLASS MANAGEMENT AND LECTURE ASSESMENT,COURSES WITH PRACTICALS ONLY';
            OptionMembers = ,"COURSE OUTLINE","CONTENT PRESENTATION","PERSONAL ATTRIBUTES",Numeric,"COMMON AREAS OF ASSESMENT","CLASS MANAGEMENT AND LECTURE ASSESMENT","COURSES WITH PRACTICALS ONLY";
        }
        field(5; Class; Option)
        {
            OptionMembers = Options,Description,Numeric;
        }
        field(7; Semester; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Semesters";
        }
        field(8; "Evaluation Category"; Option)
        {
            OptionMembers = Placement,"Thesis/Projects","Taught Units";
        }
    }

    keys
    {
        key(Key1; ID, Semester)
        {
        }
    }

    fieldgroups
    {
    }
}

