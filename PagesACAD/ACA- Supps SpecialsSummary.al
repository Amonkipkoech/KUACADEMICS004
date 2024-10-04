page 84522 "Supplimentary/Specials"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Aca-Special Exams Details";
    SourceTableView = where("Current Semester" = const('MAY-AUG23'));
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field(Campus; Rec.Campus)
                {

                }

                field("Unit Code"; Rec."Unit Code")
                {
                    //MultiLine = true;
                    ApplicationArea = All;
                }
                field("Unit Description"; Rec."Unit Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Academic Year"; Rec."Academic Year")
                {
                    Caption = 'Unit Academic Year';
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Exam Session"; Rec."Exam Session")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                // field("CAT Marks"; Rec."CAT Marks")
                // {
                //     
                //     ApplicationArea = All;
                // }
                // field("Exam Marks"; Rec."Exam Marks")
                // {
                //     Editable = false;
                //     ApplicationArea = All;
                // }
                field("Total Marks2"; Rec."Total Marks2")
                {
                    Caption = 'Total Mark';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Grade; Rec.Grade)
                {
                    Editable = false;
                    ApplicationArea = All;
                }

                field(Catogory; Rec.Catogory)
                {
                    //Editable = false;
                    ApplicationArea = All;
                }
                field("Current Academic Year"; Rec."Current Academic Year")
                {
                    Editable = true;
                    ApplicationArea = All;
                }

                field("Current Semester"; Rec."Current Semester")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    Caption = 'Unit Semester';
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Programme; Rec.Programme)
                {
                    Caption = 'Unit Programme';
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Stage; Rec.Stage)
                {
                    Caption = 'Unit Stage';
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Charge Posted"; Rec."Charge Posted")
                {
                    ApplicationArea = All;
                }

            }
        }
        area(Factboxes)
        {

        }
    }

    trigger OnOpenPage()
    var
        usersetup: Record "User Setup";
        Nopermission: Label 'You have insufficient Rights to access this List';
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
        AllowAccessSettings: boolean;
}