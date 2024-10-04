xmlport 84518 "Import Buffer marks2"
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
            tableelement(buffer; "Import Marks Buffer")
            {

                fieldelement(examEntry; buffer.examEntry)
                {
                }
                fieldelement(studentNo; buffer.studentNo)
                {
                }
                fieldelement(AcademicYr; buffer.AcademicYr)
                {
                }
                fieldelement(Sem; buffer.Sem)
                {
                }
                fieldelement(unitCode; buffer.unitCode)
                {
                }
                fieldelement(uniName; buffer.uniName)
                {
                }
                fieldelement(Prog; buffer.Prog)
                {
                }
                fieldelement(cat; buffer.cat)
                {
                }
                fieldelement(Exam; buffer.Exam)
                {
                }
                
                
            }
        }

    }

}