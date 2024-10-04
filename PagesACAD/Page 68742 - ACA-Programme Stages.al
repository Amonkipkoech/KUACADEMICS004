page 68742 "ACA-Programme Stages"
{
    PageType = List;
    SourceTable = 61516;
    //Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Period (M)"; Rec."Period (M)")
                {
                    ApplicationArea = All;
                }
                field("Final Stage"; Rec."Final Stage")
                {
                    ApplicationArea = All;
                }
                field(extraStage; Rec.extraStage)
                {
                    ApplicationArea = All;
                }
                field("Include in Time Table"; Rec."Include in Time Table")
                {
                    ApplicationArea = All;
                }
                field("Next Stage Attachment"; Rec."Next Stage Attachment")
                {
                    ApplicationArea = All;
                }
                field("Allow Programme Options"; Rec."Allow Programme Options")
                {
                    ApplicationArea = All;
                }
                field("Campus Code"; Rec."Campus Code")
                {
                    ApplicationArea = All;
                }
                field("Modules Registration"; Rec."Modules Registration")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ignore No. Of Units"; Rec."Ignore No. Of Units")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ApplicationArea = All;
                }
                field(Order; Rec.Order)
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
            group(Stage)
            {
                Caption = 'Stage';
                action("StgSem")
                {
                    Caption = 'Stage semesters';
                    Image = Timesheet;
                    Promoted = true;
                    RunObject = Page "ACA-Programme Stage Semesters";
                    RunPageLink = "Programme Code" = FIELD("Programme Code"), Stage = FIELD("Code");
                    ApplicationArea = All;
                    PromotedCategory = Process;
                }
                action("Units/Courses")
                {
                    Caption = 'Units/Courses';
                    Image = Timesheet;
                    Promoted = true;
                    RunObject = Page 68743;
                    RunPageLink = "Programme Code" = FIELD("Programme Code"),
                                  "Stage Code" = FIELD(Code);
                    ApplicationArea = All;
                    PromotedCategory = Process;
                }

                action("Fees Structure")
                {
                    Caption = 'Fees Structure';
                    Image = Forecast;
                    Promoted = true;
                    RunObject = Page 68748;
                    RunPageLink = "Programme Code" = FIELD("Programme Code"),
                                  "Stage Code" = FIELD(Code);
                    ApplicationArea = All;
                    PromotedCategory = Process;
                }
                action("Charge Items")
                {
                    Caption = 'Charge Items';
                    Image = Forecast;
                    Promoted = true;
                    RunObject = Page "ACA-Stage Charges";
                    RunPageLink = "Programme Code" = FIELD("Programme Code"),
                                  "Stage Code" = FIELD(Code);
                    ApplicationArea = All;
                    PromotedCategory = Process;
                }
                action("New Students Charges")
                {
                    Caption = 'New Students Charges';
                    Image = Forecast;
                    Promoted = true;
                    RunObject = Page 68770;
                    RunPageLink = "Programme Code" = FIELD("Programme Code");
                    ApplicationArea = All;
                    PromotedCategory = Process;
                }
                action(Prerequisite)
                {
                    Caption = 'Prerequisite';
                    Image = Planning;
                    Promoted = true;
                    RunObject = Page "ACA-Course Prerequisite";
                    RunPageLink = Programmes = FIELD("Programme Code"), Stage = FIELD("Code");
                    ApplicationArea = All;
                    PromotedCategory = Process;
                }
                action("Additional Info")
                {
                    Caption = 'Additional Info';
                    Image = Comment;
                    Promoted = true;
                    RunObject = Page "Comment Sheet";
#pragma warning disable AL0603
                    RunPageLink = "Table Name" = CONST(14), "No." = FIELD(Code);
                    ApplicationArea = All;
                    PromotedCategory = Process;
#pragma warning restore AL0603
                }
                action("Fee Structure Report")
                {
                    Caption = 'Fee Structure Report';
                    Promoted = true;
                    RunObject = Report 51794;
                    ApplicationArea = All;
                    PromotedCategory = Process;
                }
            }
        }
    }
}

