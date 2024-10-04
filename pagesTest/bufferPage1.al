page 85203 "Buffer Page2"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = finBuffer1;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(entryNo; Rec.entryNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the entryNo field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No field.';
                }
                field("gl account"; Rec."gl account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the gl account field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Campus; Rec.Campus)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Campus field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Bal Account Type"; Rec."Bal Account Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bal Account Type field.';
                }
                field("Balancing Acc"; Rec."Balancing Acc")
                {
                    ApplicationArea = All;
                }
                field("New Gl"; Rec."New Gl")
                {
                    ApplicationArea = All;
                }
                field(department; Rec.department)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the department field.';
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