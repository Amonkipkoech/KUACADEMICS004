page 86642 vcClearedList2
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = VcCleraedList;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(studentNo; Rec.studentNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the studentNo field.';
                }
                field("Reason For Clerance"; Rec."Reason For Clerance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reason For Clerance field.';
                }
                field(Approved; Rec.Approved)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reason For Clerance field.';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }

            }
        }

    }


}