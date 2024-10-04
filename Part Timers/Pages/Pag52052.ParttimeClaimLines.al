page 52052 "Parttime Claim Lines"
{
    PageType = ListPart;
    SourceTable = "Parttime Claim Lines";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester field.';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year field.';
                }
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Programme field.';
                }
                field("Programme Description"; Rec."Programme Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Programme Description field.';
                }

                field(Unit; Rec.Unit)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit field.';
                }
                field("Unit Description"; Rec."Unit Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Description field.';
                }

                field("Hours Done"; Rec."Hours Done")
                {
                    Caption = 'Teaching Hours';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Hours Done field.';
                }
                field("Invigillation Done"; Rec."Invigillation Done")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Invigillation Done field.';
                }
                field("Invigillation Hours"; Rec."Invigillation Hours")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Invigillation Hours field.';
                }

                field("Hourly Rate"; Rec."Hourly Rate")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Hourly Rate field.';
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Student Count"; Rec."Student Count")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student Count field.';
                }
            }
        }
    }
}