page 52051 "PT Rates"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ptRates;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(ProgrammeLevel; Rec.ProgrammeLevel)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ProgrammeLevel field.';
                }
                field(modeofStudy; Rec.modeofStudy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the modeofStudy field.';
                }
                field(designation; Rec.designation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the designation field.';
                }
                field(quorum; Rec.quorum)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the quorum field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}