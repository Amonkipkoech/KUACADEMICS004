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
            action("Post Payment")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    PaymentProcessor: Codeunit "KU Payment Processor";
                    EmailMessage: Codeunit "Email Message";
                    Email: Codeunit Email;
                    Recipients: List of [Text];
                    StudentRec: Record Customer; // Replace with 'Student' if you use a custom table
                begin
                    // Replace '18770' with your actual Bank Account Code
                    PaymentProcessor.ProcessPayment(
                        Rec.PaymentRefID,
                        Rec.CustomerRefNo,
                        Rec.PaidAmount,
                        Rec."Customer Name",
                        'BNK002' // ← Bank Account No.
                    );
                    // Get student email using CustomerRefNo (assumed as Customer No.)
                    if StudentRec.Get(Rec.CustomerRefNo) then begin
                        if StudentRec."E-Mail" <> '' then begin
                            Recipients.Add(StudentRec."E-Mail");
                            EmailMessage.Create(
                                Recipients,
                                'Payment Received',
                                StrSubstNo('Dear %1, we have received your payment of %2. Kindly check your clearance status.', StudentRec.Name, Format(Rec.PaidAmount)),
                                true
                            );
                            if not Email.Send(EmailMessage, Enum::"Email Scenario"::Default) then
                                Message('Failed to send email to %1', StudentRec."E-Mail");
                        end;
                    end;

                    // Mark as posted
                    Rec.Posted := true;
                end;
            }
        }
    }

}
