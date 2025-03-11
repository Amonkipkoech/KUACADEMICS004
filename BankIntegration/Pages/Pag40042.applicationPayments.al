page 40042 "application Payments"
{
    Caption = 'application Payments';
    PageType = List;
    SourceTable = "PesaFlow Integration";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(CustomerRefNo; Rec.CustomerRefNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Ref No field.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
                field(InvoiceNo; Rec.InvoiceNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Invoice No field.';
                }
                field(InvoiceAmount; Rec.InvoiceAmount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Invoice Amount field.';
                }
                field(PaidAmount; Rec.PaidAmount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Paid Amount field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
            }
        }
    }
}
