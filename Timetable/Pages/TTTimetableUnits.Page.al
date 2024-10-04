/// <summary>
/// Page TT-Timetable Units (ID 74502).
/// </summary>
page 74502 "TT-Timetable Units"
{
    Caption = 'Timetable Units';
    PageType = List;
    SourceTable = 74517;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Programme Code"; Rec."Programme Code")
                {
                    //Editable = false;
                    ApplicationArea = All;
                }
                field("Unit Code"; Rec."Unit Code")
                {

                    ApplicationArea = All;
                }
                field("Unit Base Code";Rec."Unit Base Code")
                {
                    ApplicationArea = All;
                }
                field("Unit Name"; Rec."Unit Name")
                {
                    ApplicationArea = All;
                }
                field("Weighting Category"; Rec."Weighting Category")
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
            action("Unit Specific Campuses")
            {
                Caption = 'Unit Specific Campuses';
                Image = Dimensions;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page 74513;
                RunPageLink = "Academic Year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester),
                                "Programme Code" = FIELD("Programme Code"),
                              "Unit Code" = FIELD("Unit Code");
                ApplicationArea = All;
            }
            action("Unit Specific Rooms")
            {
                Caption = 'Unit Specific Rooms';
                Image = GiroPlus;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page 74514;
                RunPageLink = "Academic Year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester),
                                "Programme Code" = FIELD("Programme Code"),
                              "Unit Code" = FIELD("Unit Code");
                ApplicationArea = All;
            }
            action("Unit Specific Weighting")
            {
                Caption = 'Unit Specific Weighting';
                Image = Warehouse;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page 74515;
                RunPageLink = "Academic Year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester),
                                "Programme Code" = FIELD("Programme Code"),
                              "Unit Code" = FIELD("Unit Code");
                Visible = false;
                ApplicationArea = All;
            }
        }
    }
}

