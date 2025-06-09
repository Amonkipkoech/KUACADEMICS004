xmlport 40068 "PesaFlow Integration"
{
    Direction = Import;
    Format = VariableText;
    FormatEvaluate = Legacy;
    DefaultFieldsValidation = false;
    UseRequestPage = false;

    schema
    {
        textelement(root)
        {
            tableelement(pfow; "PesaFlow Integration")
            {
                fieldattribute(PaymentRefID; pfow.PaymentRefID)
                {
                }
                fieldattribute(CustomerRefNo; pfow.CustomerRefNo)
                {
                }

                fieldattribute(InvoiceNo; pfow.InvoiceNo)
                {
                }
                fieldattribute(InvoiceAmount; pfow.InvoiceAmount)
                {
                }
                fieldattribute(PaidAmount; pfow.PaidAmount)
                {
                }
                fieldattribute(ServiceID; pfow.ServiceID)
                {
                }
                fieldattribute(Description; pfow.Description)
                {
                }
                fieldattribute(PaymentChannel; pfow.PaymentChannel)
                {
                }
                fieldattribute(PaymentDate; pfow.PaymentDate)
                {
                }
                fieldattribute(DateReceived; pfow."Date Received")
                {
                }
                fieldattribute(Status; pfow.Status)
                {
                }

                trigger OnBeforeInsertRecord()
                var
                    cust: Record Customer;
                begin
                    cust.Reset();
                    cust.SetRange("No.", pfow.CustomerRefNo);
                    if cust.Find('-') then begin
                        pfow."Customer Name" := cust.Name;
                        //pfow.Modify();
                    end;

                end;
            }


        }
    }
}
