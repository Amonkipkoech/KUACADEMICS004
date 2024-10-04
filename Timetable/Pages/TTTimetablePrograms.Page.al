page 74501 "TT-Timetable Programs"
{
    Caption = 'Timetable Programs';
    PageType = List;
    SourceTable = "TT-Programmes";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year field.';
                    Editable = false;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester field.';
                    Editable = false;
                }
                field("Programme Code"; Rec."Programme Code")
                {

                    ApplicationArea = All;
                }
                field("Timetable Color"; Rec."Timetable Color")
                {
                    ApplicationArea = All;
                }
                field("Prog. Name"; Rec."Prog. Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Timetable Units")
            {
                Caption = 'Timetable Units';
                Image = Default;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 74502;
                RunPageLink = "Academic Year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester),
                              "Programme Code" = FIELD("Programme Code");
                ApplicationArea = All;
            }
            action("Prog. Campuses")
            {
                Caption = 'Prog. Campuses';
                Image = Delivery;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 74507;
                RunPageLink = "Academic Year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester),
                              "Programme Code" = FIELD("Programme Code");
                ApplicationArea = All;
            }
            action("Prog. Specific Days")
            {
                Caption = 'Prog. Specific Days';
                Image = CreateBins;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 74508;
                RunPageLink = "Academic Year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester),
                              "Programme Code" = FIELD("Programme Code");
                ApplicationArea = All;
            }
            action("Prog. Specific Rooms")
            {
                Caption = 'Prog. Specific Rooms';
                Image = CreatePutAway;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 74509;
                RunPageLink = "Academic Year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester),
                              "Programme Code" = FIELD("Programme Code");
                ApplicationArea = All;
            }
            /*  action("Get Programmes")
             {
                 Image = CreateForm;
                 Promoted = true;
                 PromotedCategory = Process;
                 RunObject = report "Aca- TT Programmes";
                 ApplicationArea = All;
             } */
        }
    }

    var
        acaProgrammes: Record "ACA-Programme";
        TTprogrammes: Record "TT-Programmes";
}

