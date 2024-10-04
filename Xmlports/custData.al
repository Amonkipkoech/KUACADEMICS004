xmlport 86622 "Import Cust"
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
            tableelement(cust; Customer)
            {
                fieldelement(cust; cust."No.")
                {

                }
                fieldelement(Name; cust.Name)
                {
                }
                fieldelement(GenBusPostingGroup; cust."Gen. Bus. Posting Group")
                {
                }
                fieldelement(CustomerPostingGroup; cust."Customer Posting Group")
                {
                }



            }
        }

    }

}