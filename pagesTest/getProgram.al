page 84519 findProgram
{
    PageType = List;
    Caption = 'apiPageName';
    SourceTable = getProgram;


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(entry; Rec.entry)
                {
                    ApplicationArea = All;
                }
                field(UnitCode; Rec.UnitCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the UnitCode field.';
                }
                field(programCode;Rec.programCode)
                {
                    ApplicationArea = All;
                }
                field(Stage;Rec.Stage)
                {
                    ApplicationArea = All;
                }
                field(unitBase; Rec.unitBase)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the unitBase field.';
                }
                field(unitTitle; Rec.unitTitle)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the unitTitle field.';
                }
                field(Campus; Rec.Campus)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Campus field.';
                }
            }
        }
    }
}