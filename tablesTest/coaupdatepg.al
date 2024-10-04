page 86616 coaUpdate
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = coaUpdate;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field(erpCode; Rec.erpCode)
                {
                    ApplicationArea = All;
                }
                field(desc; Rec.desc)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(updateCoa)
            {
                ApplicationArea = All;
                
                trigger OnAction()
                var 
                coaNew : Record coaUpdate;
                coa: Record "G/L Account";
                begin
                    coaNew.Reset();
                end;
            }
        }
    }
}