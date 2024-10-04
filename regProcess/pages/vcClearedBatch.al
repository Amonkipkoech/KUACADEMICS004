page 86638 "Vc Cleared Batch"
{
    PageType = List;
    CardPageId = "VC Cleared Card";
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "VC cleared Batches";

    layout
    {
        area(Content)
        {
            repeater("VC cleraed")
            {
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year field.';
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created Date field.';
                }
                field("Created Time"; Rec."Created Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created Time field.';
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
    trigger OnOpenPage()
    var
        usersetup: Record "User Setup";
        Nopermission: Label 'You have insufficient Rights to acess this List';
    begin
        AllowAccessSetup := true;
        if usersetup.get(UserId) then
            if (usersetup."Allow Transaction Reversal") then begin
                AllowAccessSetup := usersetup."Allow Transaction Reversal";
                exit
            end;
        Error(Nopermission);
    end;

    var
        myInt: Integer;
        AllowAccessSetup: boolean;






}