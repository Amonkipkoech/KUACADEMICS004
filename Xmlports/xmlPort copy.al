xmlport 84508 "updateNames"
{
    Caption = 'Update Names';

    Direction = Import;
    Format = VariableText;
    FormatEvaluate = Legacy;
    DefaultFieldsValidation = false;
    UseRequestPage = false;


    schema
    {
        textelement(Root)
        {
            tableelement(cust; 18)
            {
                AutoUpdate = true;
                fieldelement(No; cust."No.")
                {

                }
                fieldelement(name; cust.Name)
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