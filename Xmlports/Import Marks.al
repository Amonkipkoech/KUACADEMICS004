xmlport 84516 "Import Buffer marks"
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
            tableelement(buffer; "ACA-Exam Results Buffer 2")
            {

                fieldelement(StudentNo; buffer."Student No.")
                {
                }
                fieldelement(AcademicYear; buffer."Academic Year")
                {
                }
                fieldelement(Semester; buffer.Semester)
                {
                }
                fieldelement(UnitCode; buffer."Unit Code")
                {
                }
                fieldelement(UnitName; buffer."Unit Name")
                {
                }
                fieldelement(Programme; buffer.Programme)
                {
                }
                fieldelement(CATScore; buffer."CAT Score")
                {
                }
                fieldelement(ExamScore; buffer."Exam Score")
                {
                }
                trigger OnBeforeInsertRecord()
                begin

                    buffer."User Name" := UserId;
                end;
            }
        }

    }

}