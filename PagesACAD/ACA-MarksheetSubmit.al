page  85525 "Marksheet Submission Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "ACA-MarkSheet Submission";
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                
                field("Submission Code"; Rec."Submission Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Submission Code field.';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year field.';
                }
                field(Campus; Rec.Campus)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Campus field.';
                }
                field("Date Marksheet Received"; Rec."Date Marksheet Received")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Marksheet Received field.';
                }
                field("Lecturer Staff ID"; Rec."Lecturer Staff ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lecturer Staff ID field.';
                }
                field("Mode Of Study"; Rec."Mode Of Study")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mode Of Study field.';
                }
                field("Registry Receiving Staff ID"; Rec."Registry Receiving Staff ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Registry Receiving Staff ID field.';
                }
                field(Stream; Rec.Stream)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stream field.';
                }
                field("Submitting Officer Staff ID"; Rec."Submitting Officer Staff ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Submitting Officer Staff ID field.';
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