page 51870 "Program Intake Fee"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "ACA-ProgramIntakeFee";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field(ProgCode; Rec.ProgCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ProgCode field.';
                }
                field(progName; Rec.progName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the progName field.';
                }
                field(intakeFee; Rec.intakeFee)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the intakeFee field.';
                }
                field(ModeOfstudy;Rec.ModeOfstudy)
                {
                    ApplicationArea = All;
                }
                field(Campus;Rec.Campus)
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