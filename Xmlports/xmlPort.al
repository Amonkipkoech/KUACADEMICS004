xmlport 84507 "xmlPort"
{
    Caption = 'Import Data';
    Direction = Import;
    Format = VariableText;
    FormatEvaluate = Legacy;
    DefaultFieldsValidation = false;
    UseRequestPage = false;


    schema
    {
        textelement(Root)
        {
            tableelement(genJournal; 81)
            {


                fieldattribute(templateName; genJournal."Journal Template Name")
                {

                }
                fieldattribute(batchname; genJournal."Journal Batch Name")
                {
                }
                fieldattribute(LineNo; genJournal."Line No.")
                {
                }
                fieldattribute(postingDate; genJournal."Posting Date")
                {
                }
                fieldattribute(documentType; genJournal."Document Type")
                {
                }
                fieldattribute(documentno; genJournal."Document No.")
                {
                }
                fieldattribute(accounttype; genJournal."Account Type")
                {
                }
                fieldattribute(accountNo; genJournal."Account No.")
                {

                }
                fieldattribute(bal; genJournal."Bal. Account Type")
                {

                }

                fieldattribute(balaccountNo; genJournal."Bal. Account No.")
                {

                }
                fieldattribute(amount; genJournal.Amount)
                {
                }

                fieldattribute(campus; genJournal."Shortcut Dimension 1 Code")
                {
                    Occurrence = Optional;
                }
                fieldattribute(departmemt; genJournal."Shortcut Dimension 2 Code")
                {

                    Occurrence = Optional;
                }
                fieldattribute(externalDoc; genJournal."External Document No.")
                {
                    
                }
                fieldattribute(description; genJournal.Description)
                {
                }


            }
        }
    }
}





