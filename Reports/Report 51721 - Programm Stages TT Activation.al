report 81803 "Programm Stages TT Activation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Programm Stages TT Activation.rdl';

    dataset
    {
        dataitem(DataItem1; 61516)
        {
            RequestFilterFields = "Programme Code", "Code";
            column(ProgrammeCode_ProgrammeStages; "Programme Code")
            {
            }
            column(Code_ProgrammeStages; Code)
            {
            }
            column(Description_ProgrammeStages; Description)
            {
            }
            column(Department_ProgrammeStages; Department)
            {
            }

            trigger OnAfterGetRecord()
            begin

                IF ActionX = ActionX::Include THEN
                    "Include in Time Table" := TRUE
                ELSE
                    "Include in Time Table" := FALSE;
                MODIFY;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(ActionX; ActionX)
                {
                    Caption = 'Action Type';
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ActionX: Option Include,Clear;
}

