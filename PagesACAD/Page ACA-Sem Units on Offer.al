page 61623 "ACA-Sem Units of Offer"
{
    //DeleteAllowed = false;
    PageType = List;
    SourceTable = "ACA-Semester Units On Offer";

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("Programme Code"; Rec."Programme Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Programme Code field.';
                    Editable = false;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester field.';
                    Editable = false;
                }
                field("Stage Code"; Rec."Stage Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Cohort';
                }
                field("Campus Code"; Rec."Campus Code")
                {
                    ApplicationArea = All;
                }
                // field("Campus Filter";Rec."Campus Filter")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Campus Code';
                // }
                field("Mode of Study"; Rec."Mode of Study")
                {
                    ApplicationArea = All;
                }
                field("Program Duration"; Rec."Program Duration")
                {
                    ApplicationArea = All;
                }
                field(Specialization; Rec.Specialization)
                {
                    ApplicationArea = All;
                }
                field(Code; Rec."Unit Code")
                {
                    ApplicationArea = All;
                }
                field(Desription; Rec.Desription)
                {
                    ApplicationArea = All;
                    Caption = 'Unit Name';
                    //Editable = false;
                }
                field("Catalogue Stage"; Rec."Catalogue Stage")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Catalogue Stage field.';
                }
                field("Allocate Lecturer"; Rec."Allocate Lecturer")
                {
                    ApplicationArea = All;
                }
                field("Unit Registered"; Rec."Unit Registered")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Registered field.';
                    Editable = false;
                }
                field("Maximum Stream Capacity"; Rec."Maximum Stream Capacity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximum Stream Capacity field.';
                }
                field("Drop Unit"; Rec."Drop Unit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Drop Unit field.';
                }

            }
        }
    }

    actions
    {
        area(processing)
        {
            /* action("Save New Units")
            {
                Caption = 'Save New Units';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    UnitsSubj.RESET;
                    UnitsSubj.SETFILTER(UnitsSubj."New Unit", '%1', TRUE);
                    IF UnitsSubj.FIND('-') THEN BEGIN
                        REPEAT
                            UnitsSubj."New Unit" := FALSE;
                            UnitsSubj.MODIFY;
                        UNTIL UnitsSubj.NEXT = 0;
                    END;
                end;
            }
            group(Unit)
            {
                Caption = 'Unit';
                action("Fees Structure")
                {
                    Caption = 'Fees Structure';
                    RunObject = Page 68749;
                    RunPageLink = "Programme Code" = FIELD("Programme Code"),
                                  "Stage Code" = FIELD("Stage Code"),
                                  "Unit Code" = FIELD(Code);
                    ApplicationArea = All;
                }
            }
            group("Multiple Combination")
            {
                Caption = 'Multiple Combination';
                action("Multiple Option Combination")
                {
                    Caption = 'Multiple Option Combination';
                    RunObject = Page 68052;
                    RunPageLink = Programme = FIELD("Programme Code"),
                                  Stage = FIELD("Stage Code"),
                                  Unit = FIELD(Code);
                    ApplicationArea = All;
                }
            } */

            action("Course Outline")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = ProductDesign;
                RunObject = Page "Course Outline Contents";
                RunPageLink = "Programme Code" = field("Programme Code"), Semester = field(Semester), "Stage Code" = field("Stage Code"), "Unit Base Code" = field("Unit Code");
            }
            action("Split Classes")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = Split;
                RunObject = report "ACA-Split Streams";

            }
        }
    }

    var
        UnitsSubj: Record "ACA-Units/Subjects";
}