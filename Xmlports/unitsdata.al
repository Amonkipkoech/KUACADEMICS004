xmlport 84537 "UnitsData"
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
            tableelement(exam; 61549)
            {
                fieldattribute(etype; exam."Reg. Transacton ID")
                {

                }
                fieldattribute(studno; exam."Student No.")
                {

                }
                fieldattribute(sem; exam.Semester)
                {

                }
                fieldattribute(exam; exam.Programme)
                {

                }
                fieldattribute(stage; exam.Stage)
                {

                }

                fieldattribute(score; exam.Unit)
                {

                }

                fieldattribute(acadYr; exam."Academic Year")
                {

                }




            }
        }
    }
}





