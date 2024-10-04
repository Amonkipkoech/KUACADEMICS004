xmlport 84515 "Grading Source Import"
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

            tableelement(GradingSource; "ACA-Exam Grading Source")
            {

                fieldelement(AcademicYear; GradingSource."Academic Year")
                {
                }
                fieldelement(ExamCatregory; GradingSource."Exam Catregory")
                {
                }
                fieldelement(TotalScore; GradingSource."Total Score")
                {
                }
                fieldelement(Grade; GradingSource.Grade)
                {
                }
                fieldelement(Pass; GradingSource.Pass)
                {
                }
                fieldelement(Remarks; GradingSource.Remarks)
                {
                }
                fieldelement(ResultsExistsStatus; GradingSource."Results Exists Status")
                {
                }
                fieldelement(catmarkExist; GradingSource.CatMarksExist)
                {

                }
                fieldelement(examResults; GradingSource.ExamMarksExist)
                {
                    
                }
                fieldelement(ConsolidatedPrefix; GradingSource."Consolidated Prefix")
                {
                    MinOccurs = Zero;
                }
            }
        }
    }
}