page 86613 "Units on Offer"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "ACA-Semester Units On Offer";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No";Rec."Entry No")
                {
                    ApplicationArea = All;
                }
               
                field("Programme Code";Rec."Programme Code")
                {
                    ApplicationArea = All;
                }
                
                field("Stage Code"; Rec."Stage Code")
                {
                    ApplicationArea = ALL;
                }
                field("Academic Year";Rec."Academic Year")
                {
                    ApplicationArea = ALL;
                }
                field(Semester;Rec.Semester)
                {
                    ApplicationArea = ALL;
                }
                field("Unit Code";Rec."Unit Code")
                {
                    ApplicationArea = ALL;
                }
                field(Desription;Rec.Desription)
                {
                    ApplicationArea = All;
                }
                field("Lecturer Code";Rec."Lecturer Code")
                {
                    ApplicationArea = ALL;
                }
                field("Campus Code";Rec."Campus Code")
                {
                    ApplicationArea = All;
                }
                field("Mode of Study";Rec."Mode of Study")
                {
                    ApplicationArea = ALL;
                }
                field("Students Registered";Rec."Students Registered")
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

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}