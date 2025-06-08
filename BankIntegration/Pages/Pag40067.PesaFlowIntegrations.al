page 40067 "PesaFlow"
{
    PageType = List;
    SourceTable = "PesaFlow Integration";
    DeleteAllowed = false;
    InsertAllowed = false;
    //ModifyAllowed = false;
    SourceTableView = where(Posted = filter(false));
    PromotedActionCategories = 'Post,Import';

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field(PaymentRefID; Rec.PaymentRefID)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Ref ID field.';
                }
                field(CustomerRefNo; Rec.CustomerRefNo)
                {
                    Editable = false;
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
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Invoice No field.';
                }
                field(InvoiceAmount; Rec.InvoiceAmount)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Invoice Amount field.';
                }
                field(PaidAmount; Rec.PaidAmount)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Paid Amount field.';
                }
                field(ServiceID; Rec.ServiceID)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Service ID field.';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(PaymentChannel; Rec.PaymentChannel)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Channel field.';
                }
                field(PaymentDate; Rec.PaymentDate)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Date field.';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field("Date Received"; Rec."Date Received")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Received field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Batch Post")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = New;
                Image = PostBatch;

                trigger OnAction()
                var
                    pint: Codeunit "PesaFlow Integration";
                begin
                    if Confirm('Post Unposted Transactions ?', true) = false then Error('Cancelled');
                    pint.PostBatchPesaFlow();
                end;
            }
            action("Fetch Trans")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = xmlport "PesaFlow Integration";
            }
        }
    }

}
