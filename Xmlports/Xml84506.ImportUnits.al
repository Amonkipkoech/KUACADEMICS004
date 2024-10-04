xmlport 84506 "Import Units"
{
    Caption = 'Import Units/Subjects';
    Direction = Import;
    Format = VariableText;
    FormatEvaluate = Legacy;
    DefaultFieldsValidation = false;
    UseRequestPage = false;
    schema
    {
        textelement(Root)
        {
            tableelement(units; "ACA-Units/Subjects")
            {

                fieldelement(ProgrammeCode; units."Programme Code")
                {
                }
                fieldelement(StageCode; units."Stage Code")
                {
                }
                fieldelement(Code; units."Code")
                {
                }
                fieldelement(CreditHours; units."Credit Hours")
                {
                }
                fieldelement(Amount; units.Amount)
                {
                }
                fieldelement(Department; units.Department)
                {
                }
                fieldelement(Desription; units.Desription)
                {
                }
                fieldelement(TimeTable; units."Time Table")
                {
                }
                fieldelement(UnitBaseCode; units."Unit Base Code")
                {
                }
                fieldelement(CommonUnit; units."Common Unit")
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