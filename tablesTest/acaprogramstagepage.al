page 86605 "progStagesTest"
{
    PageType = list;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Find Stages";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(entry;Rec.entry)
                {
                    ApplicationArea = All;
                }

                
                field(Program;Rec.Program)
                {
                    ApplicationArea = All;
                }
                field(Unit;Rec.Unit)
                {
                    ApplicationArea = All;
                }
                field("Stage FiLTER";Rec."Stage FiLTER")
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

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}