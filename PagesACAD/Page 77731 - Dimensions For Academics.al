page 77731 "Dimensions For Academics"
{
    Caption = 'Dimensions';
    PageType = List;
    SourceTable = Dimension;
    SourceTableView = WHERE(Code = FILTER('DEPARTMENT' | 'DEPARTMENTS'));

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code for the dimension.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the name of the dimension code.';
                }
                field("Code Caption"; Rec."Code Caption")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the caption of the dimension code. This is displayed as the name of dimension code fields.';
                }
                field("Filter Caption"; Rec."Filter Caption")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the caption of the dimension code when used as a filter. This is displayed as the name of dimension filter fields.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies a description of the dimension code.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies that entries with this dimension cannot be posted.';
                }
                field("Map-to IC Dimension Code"; Rec."Map-to IC Dimension Code")
                {
                    ToolTip = 'Specifies which intercompany dimension corresponds to the dimension on the line.';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Consolidation Code"; Rec."Consolidation Code")
                {
                    ToolTip = 'Specifies the code that is used for consolidation.';
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(links; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Dimension")
            {
                Caption = '&Dimension';
                Image = Dimensions;
                action("Dimension &Values")
                {
                    ApplicationArea = Suite;
                    Caption = 'Dimension &Values';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page 537;
                    RunPageLink = "Dimension Code" = FIELD(Code);
                    ToolTip = 'View or edit the dimension values for the current dimension.';
                }
                action("Account Type De&fault Dim.")
                {
                    ApplicationArea = Suite;
                    Caption = 'Account Type De&fault Dim.';
                    Image = DefaultDimension;
                    RunObject = Page 541;
                    RunPageLink = "Dimension Code" = FIELD(Code);
                    ToolTip = 'Specify default dimension settings for the relevant account types such as customers, vendors, or items. For example, you can make a dimension required.';
                }
                action(Translations)
                {
                    ApplicationArea = Suite;
                    Caption = 'Translations';
                    Image = Translations;
                    RunObject = Page 580;
                    RunPageLink = Code = FIELD(Code);
                    ToolTip = 'View or edit translated dimensions. Translated item descriptions are automatically inserted on documents according to the language code.';
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(MapToICDimWithSameCode)
                {
                    Caption = 'Map to IC Dim. with Same Code';
                    Image = MapDimensions;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        Dimension: Record dimension;
                        ICMapping: Codeunit "IC Mapping";
                    begin
                        CurrPage.SETSELECTIONFILTER(Dimension);
                        IF Dimension.FIND('-') AND CONFIRM(Text000) THEN
                            REPEAT
                                ICMapping.MapOutgoingICDimensions(Dimension);
                            UNTIL Dimension.NEXT = 0;
                    end;
                }
            }
        }
    }

    var
        Text000: Label 'Are you sure you want to map the selected lines?';
}

