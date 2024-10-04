page 68743 "ACA-Units/Subjects"
{
    DeleteAllowed = true;
    PageType = List;
    SourceTable = 61517;

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("Stage Code"; Rec."Stage Code")
                {
                    ApplicationArea = All;
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Caption = 'Unit Base Code';
                }
                field(Desription; Rec.Desription)
                {
                    ApplicationArea = All;
                    Caption = 'Unit Name';
                    Editable = false;
                }
                field("Unit Base Code"; Rec."Unit Base Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }


                field("Unit Base Title"; Rec."Unit Base Title")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(programDuration; Rec.programDuration)
                {
                    ApplicationArea = All;
                    //Editable = false;
                }
                field("Associated Unit1"; Rec."Associated Unit1")
                {
                    ApplicationArea = All;
                }
                field("Associated Unit2"; Rec."Associated Unit2")
                {
                    ApplicationArea = All;
                }
                field("Associated Unit3"; Rec."Associated Unit3")
                {
                    ApplicationArea = All;
                }
                field("Associated Unit4"; Rec."Associated Unit4")
                {
                    ApplicationArea = All;
                }
                field("Credit Hours"; Rec."Credit Hours")
                {
                    Caption = 'Credit Hours';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Department; Rec.Department)
                {
                    Caption = 'Academic Department';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Default Exam Category"; Rec."Default Exam Category")
                {
                    ApplicationArea = All;
                    //Caption = 'Level Code';
                }

                field("Key Course"; Rec."Key Course")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit Type"; Rec."Unit Type")
                {
                    ApplicationArea = All;
                }
                field("Old Unit"; Rec."Old Unit")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("No. Units"; Rec."No. Units")
                {
                    Visible = false;
                    Caption = 'CF';
                    ApplicationArea = All;
                }
                field("Programme Option"; Rec."Programme Option")
                {
                    ApplicationArea = All;
                }

                field("Combination Count"; Rec."Combination Count")
                {
                    Editable = false;
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Time Table"; Rec."Time Table")
                {
                    ApplicationArea = All;
                }
                field("Not Allocated"; Rec."Not Allocated")
                {
                    ApplicationArea = All;
                }
                field("Common Unit"; Rec."Common Unit")
                {
                    ApplicationArea = All;
                }

                field("Academic Hours"; Rec."Academic Hours")
                {
                    ApplicationArea = All;
                }
                field(Prerequisite; Rec.Prerequisite)
                {
                    ApplicationArea = All;
                }
                field("Prerequisite 2"; Rec."Prerequisite 2")
                {
                    ApplicationArea = All;
                }
                field("Students Registered"; Rec."Students Registered")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Exam Category"; Rec."Exam Category")
                {
                    Visible = false;
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Save New Units")
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
            }
        }
    }

    var
        UnitsSubj: Record "ACA-Units/Subjects";
}

