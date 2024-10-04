page 68228 "ACA-Academic Activities"
{
    Caption = 'Activities';
    PageType = CardPart;
    SourceTable = 9054;

    layout
    {
        area(content)
        {
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.RESET;
        IF NOT Rec.GET THEN BEGIN
            Rec.INIT;
            Rec.INSERT;
        END;

        Rec.SETFILTER("Due Date Filter", '<=%1', WORKDATE);
        Rec.SETFILTER("Overdue Date Filter", '<%1', WORKDATE);
    end;
}

