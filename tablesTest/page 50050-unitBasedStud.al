page 50050 "UnitBased"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = unitBasedstud;

    layout
    {
        area(Content)
        {
            repeater(unitbased)
            {

                field(StudNo; Rec.StudNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the StudNo field.';
                }
                field(settlementType; Rec.settlementType)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the settlementType field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ChangeSettlement)
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
        //courseReg: Record "ACA-Course Registration";

}