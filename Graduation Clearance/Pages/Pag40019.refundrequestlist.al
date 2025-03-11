page 40019 "Refund Request List"

{
    PageType = List;
    SourceTable = "Refund Request";


    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("ID No."; "ID No.") { }
                field("Full Name"; "Full Name") { }
                field("Request Amount"; "Request Amount") { }
                field("Refund Mode"; "Refund Mode") { }
                field("Net Due for Refund"; "Net Due for Refund") { }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("New Refund Request")
            {
                RunObject = page "Refund Request Card";
                ApplicationArea = All;
            }
        }
    }
}

