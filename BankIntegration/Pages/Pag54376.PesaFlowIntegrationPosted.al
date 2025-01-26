page 54376 "PesaFlow Integration Posted"
{
    PageType = List;
    SourceTable = "PesaFlow Integration";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTableView = where(Posted = filter(true));

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field(PaymentRefID; Rec.PaymentRefID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Ref ID field.';
                }
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
                field(ServiceID; Rec.ServiceID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Service ID field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(PaymentChannel; Rec.PaymentChannel)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Channel field.';
                }
                field(PaymentDate; Rec.PaymentDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Date field.';
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
                field("Date Received"; Rec."Date Received")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Received field.';
                }
            }
        }
    }
}