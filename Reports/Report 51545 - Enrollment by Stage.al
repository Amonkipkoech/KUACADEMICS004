report 51545 "Enrollment by Stage"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Enrollment by Stage.rdl';

    dataset
    {
        dataitem("ACA-Programme"; "ACA-Programme")
        {
            RequestFilterFields = "Code", "Semester Filter", "School Code";
            column(Code_Programme; "ACA-Programme".Code)
            {
            }
            column(Description_Programme; "ACA-Programme".Description)
            {
            }
            dataitem("ACA-Programme Stages"; "ACA-Programme Stages")
            {
                DataItemLink = "Programme Code" = FIELD(Code);
                column(Code_ProgrammeStages; "ACA-Programme Stages".Code)
                {
                }
                column(Description_ProgrammeStages; "ACA-Programme Stages".Description)
                {
                }
                column(StudentRegistered_ProgrammeStages; "ACA-Programme Stages"."Student Registered")
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }
}

