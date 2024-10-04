page 86620 "ACA-Associated Units"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = acaAssosiateUnits;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field(entry; Rec.entry)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the entry field.';
                }
                field("Program"; Rec."Program")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Program field.';
                }
                field(UnitBaseCode; Rec.UnitBaseCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the UnitBaseCode field.';
                }
                field("Associated Unit"; Rec."Associated Unit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Associated Unit field.';
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department field.';
                }
                // field(coStreams; Rec.coStreams)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the CoStream field.';
                // }
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
            action(importCust)
            {
                ApplicationArea = All;
                RunObject = xmlport "Import Cust";
                Image = Import;


            }
        }
    }
}