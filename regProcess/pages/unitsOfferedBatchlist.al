page 86645 "Units Offered Batches"
{
    PageType = List;
    //Editable = true;
    CardPageId = "UnitsOffered Card";
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Units Offred Batches";

    layout
    {
        area(Content)
        {
            repeater("Units Offered")
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
        Nopermission: Label 'You have insufficient Rights to access Units Allocation';
    begin
        AllowAccessSetup := true;
        if usersetup.get(UserId) then
            if (usersetup."Can modify unit Alocation") then begin
                AllowAccessSetup := usersetup."Can modify unit Alocation";
                exit
            end;
        Error(Nopermission);
    end;

    var
        myInt: Integer;
        AllowAccessSetup: boolean;






}