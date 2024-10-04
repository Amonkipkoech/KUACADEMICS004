page 85529 "ACA-LectureHalls Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "ACA-Lecturer Halls Setup";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Lecture Room Code"; Rec."Lecture Room Code")
                {
                    ApplicationArea = All;
                }
                field("Lecture Room Name"; Rec."Lecture Room Name")
                {
                    ApplicationArea = All;
                }
                field("Sitting Capacity"; Rec."Sitting Capacity")
                {
                    ApplicationArea = All;
                }
                field("Exam Sitting Capacity"; Rec."Exam Sitting Capacity")
                {
                    ApplicationArea = All;
                }
                field("Building Code"; Rec."Building Code")
                {
                    ApplicationArea = All;
                }
                field(Campus; Rec.Campus)
                {
                    ApplicationArea = All;
                    Caption = 'Campus Code';
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field(Serial; Rec.Serial)
                {
                    ApplicationArea = ALL;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {

        }
    }
    trigger OnOpenPage()
    var
        usersetup: Record "User Setup";
        Nopermission: Label 'You have insufficient Rights to access the Setup';
    begin
        AllowAccessSettings := true;
        if usersetup.get(UserId) then
            if (usersetup."Allow Open Transcript") then begin
                AllowAccessSettings := usersetup."Allow Open Transcript";
                exit
            end;
        Error(Nopermission);
    end;

    var
        myInt: Integer;
        AllowAccessSettings: boolean;
}