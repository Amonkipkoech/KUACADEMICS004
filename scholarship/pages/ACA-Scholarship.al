page 78030 "ACA-Scholarships"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "ACA-Scholarships";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Scholarship Code field.';
                    ApplicationArea = All;
                }
                field("Scholarship Name"; Rec."Scholarship Name")
                {
                    ToolTip = 'Specifies the value of the Scholarship Name field.';
                    ApplicationArea = All;
                }
                field("Scholarship Category"; Rec."Scholarship Category")
                {
                    ToolTip = 'Specifies the value of the Scholarship Category field.';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                }
                field("SPonsor Name"; Rec."Sponsor Name")
                {
                    ToolTip = 'Specifies the value of the SPonsor Name field.';
                    ApplicationArea = All;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ToolTip = 'Specifies the value of the G/L Account field.';
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