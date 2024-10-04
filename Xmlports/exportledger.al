xmlport 84509 "Export ledgers"
{

    //Direction = Export;
    Format = VariableText;
    FormatEvaluate = Legacy;
    DefaultFieldsValidation = false;
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement(genJournal; "Cust Ledger Test")
            {
                fieldelement(amount; genJournal.Amount)
                {
                }
                fieldelement(description; genJournal.Description)
                {
                }
                fieldelement(AccNo; genJournal."Acc No")
                {
                }
                fieldelement(Count; genJournal."Count")
                {
                }
                fieldelement(Date; genJournal."Date")
                {
                }
                fieldelement(DocumentNo; genJournal."Document No")
                {
                }
                fieldelement(cust; genJournal."customer No")
                {

                }
            }
        }
    }


    requestpage
    {
        layout
        {

        }

        actions
        {

        }
    }

    var
        myInt: Integer;
}