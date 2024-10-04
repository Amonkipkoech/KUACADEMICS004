xmlport 84536 "examData"
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
            tableelement(exam; 61548)
            {


                fieldattribute(studno; exam."Student No.")
                {

                }
                fieldattribute(acadYr; exam."Academic Year")
                {

                }
                fieldattribute(sem; exam.Semester)
                {

                }
                fieldattribute(etype; exam.ExamType)
                {

                }
                fieldattribute(stage; exam.Stage)
                {

                }
                fieldattribute(exam; exam.Exam)
                {

                }
                fieldattribute(score; exam.Score)
                {

                }
                fieldattribute(unit; exam.Unit)
                {

                }
                fieldattribute(prog; exam.Programmes)
                {

                }
                fieldattribute(upload; exam.upload)
                {
                    
                }
            }
        }
    }
}





