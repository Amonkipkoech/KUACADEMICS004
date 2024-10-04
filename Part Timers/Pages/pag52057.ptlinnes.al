page 52058 ptClaimLines
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ptClaimLines;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(lecNo; Rec.lecNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the lecNo field.';
                }
                field(lecName; Rec.lecName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the lecName field.';
                }
                field(semester; Rec.semester)
                {
                    ApplicationArea = All;
                }
                field(unitBaseCode; Rec.unitBaseCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the unitBaseCode field.';
                }
                field(associateUnit; Rec.associateUnit)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the associateUnit field.';
                }
                field(vcampus; Rec.vcampus)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the vcampus field.';
                }
                field(modeofStudy; Rec.modeofStudy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the modeofStudy field.';
                }
                // field(stream; Rec.stream)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the stream field.';
                // }
                // field(studentsNum; Rec.studentsNum)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the studentsNum field.';
                // }
                field(wlType; Rec.wlType)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the wlType field.';
                }
                field(Level; Rec.Level)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Level field.';
                }
                field(amount; Rec.amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the amount field.';
                }
                field(firstInstallment; Rec.firstInstallment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the firstInstallment field.';
                }
                field(secondInstallment; Rec.secondInstallment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the secondInstallment field.';
                }
                field(thirdInstallment; Rec.thirdInstallment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the thirdInstallment field.';
                }
                field(grandTotal; Rec.grandTotal)
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