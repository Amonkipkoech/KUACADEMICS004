page 84535 calcStage
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = getStage;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(entry; Rec.entry)
                {
                    ApplicationArea = All;

                }
                field(stdentNo; Rec.stdentNo)
                {

                }
                field(stage; Rec.stage)
                {

                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action("Import Exam Data")
            {
                Caption = 'Import Data';
                Image = Import;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Import exam data', TRUE) = FALSE THEN EXIT;
                    XMLPORT.RUN(84536, FALSE, TRUE);
                end;

            }
             action("Import Units Data")
            {
                Caption = 'Import Data';
                Image = Import;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Import exam data', TRUE) = FALSE THEN EXIT;
                    XMLPORT.RUN(84537, FALSE, TRUE);
                end;

            }
        }
    }
}