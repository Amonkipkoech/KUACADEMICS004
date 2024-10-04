xmlport 84528 "ImportHist Marks"
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
            tableelement(hist; "Final Exam Result2")
            {

                fieldelement(hist; hist.ExamEntry)
                {
                }
                fieldelement(studentNo; hist.ProgrammeID)
                {
                }
                fieldelement(AcademicYr; hist.AcademicYr)
                {
                }
                fieldelement(Sem; hist.Session)
                {
                }
                fieldelement(unitCode; hist.StudentID)
                {
                }
                fieldelement(uniName; hist.UnitCode)
                {
                }
                fieldelement(Prog; hist.UnitDesc)
                {
                }
                fieldelement(cat; hist.Cat)
                {

                }
                fieldelement(exam; hist.ExamMark)
                {
                }
                fieldelement(mean; hist.MeanScore)
                {
                }
                fieldelement(Exam; hist.MeanGrade)
                {
                }
                fieldelement(credit; hist.CreditUnit)
                {
                }


            }
        }

    }

}