report 65251 "ACA-Lecturer Evaluation Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/ACA-Lecturer Evaluation Report.rdl';

    dataset
    {
        dataitem(LectEval; "ACA-Lecturers Evaluation")
        {
            RequestFilterFields = Semester, Programme, Stage, Unit, "Lecturer No", "Department Code";
            column(ProgCode; LectEval.Programme)
            {
            }
            column(ProgDesc; ACAProgramme.Description)
            {
            }
            column(Stage; LectEval.Stage)
            {
            }
            column(UnitCode; LectEval.Unit)
            {
            }
            column(UnitDesc; ACAUnitsSubjects.Desription)
            {
            }
            column(Sem; LectEval.Semester)
            {
            }
            column(StudNo; LectEval."Student No")
            {
            }
            column(Lectno; LectEval."Lecturer No")
            {
            }
            column(LectName; HRMEmployeeC."First Name" + ' ' + HRMEmployeeC."Middle Name" + ' ' + HRMEmployeeC."Last Name")
            {
            }
            column(QuizNo; LectEval."Question No")
            {
            }
            column(QuizDesc; ACAEvaluationQuestions.Description)
            {
            }
            column(IntValue; LectEval."Response Analysis")
            {
            }
            column(RespValue; Chosen)
            {
            }
            column(Responses; LectEval.Response)
            {
            }
            column(CompName; CompanyInformation.Name)
            {
            }
            column(Address; CompanyInformation.Address + ' ' + CompanyInformation."Address 2" + ' ' + CompanyInformation.City)
            {
            }
            column(Phone; CompanyInformation."Phone No." + ',' + CompanyInformation."Phone No. 2")
            {
            }
            column(Mails; CompanyInformation."Home Page" + '/' + CompanyInformation."E-Mail")
            {
            }
            column(Pic; CompanyInformation.Picture)
            {
            }
            column(integerOrder; OrderVal)
            {
            }
            column(DimVal; DimensionValue.Name)
            {
            }
            column(DeptCode; ACAProgramme."Department Code")
            {
            }

            trigger OnAfterGetRecord()
            begin

                CLEAR(Chosen);
                Chosen := FORMAT(LectEval.Choices);
                IF LectEval.Choices = LectEval.Choices::" " THEN Chosen := 'Numerical';
                ACAEvaluationQuestions.RESET;
                ACAEvaluationQuestions.SETRANGE(Semester, LectEval.Semester);
                ACAEvaluationQuestions.SETRANGE(ID, LectEval."Question No");
                IF ACAEvaluationQuestions.FIND('-') THEN;
                CLEAR(OrderVal);
                IF LectEval.Choices = LectEval.Choices::"Strongly Disagree" THEN BEGIN
                    OrderVal := 5
                END ELSE
                    IF LectEval.Choices = LectEval.Choices::Disagree THEN BEGIN
                        OrderVal := 4
                    END ELSE
                        IF LectEval.Choices = LectEval.Choices::"Neither Agree Nor Disagree" THEN BEGIN
                            OrderVal := 3
                        END ELSE
                            IF LectEval.Choices = LectEval.Choices::Agree THEN BEGIN
                                OrderVal := 2
                            END ELSE
                                IF LectEval.Choices = LectEval.Choices::"Strongly Agree" THEN BEGIN
                                    OrderVal := 1
                                END ELSE
                                    OrderVal := 6;
                HRMEmployeeC.RESET;
                HRMEmployeeC.SETRANGE("No.", LectEval."Lecturer No");
                IF HRMEmployeeC.FIND('-') THEN;

                ACAProgramme.RESET;
                ACAProgramme.SETRANGE(Code, LectEval.Programme);
                IF ACAProgramme.FIND('-') THEN;
                DimensionValue.RESET;
                DimensionValue.SETRANGE(DimensionValue.Code, ACAProgramme."Department Code");
                IF DimensionValue.FIND('-') THEN;
                ACAUnitsSubjects.RESET;
                ACAUnitsSubjects.SETRANGE(Code, LectEval.Unit);
                ACAUnitsSubjects.SETRANGE("Programme Code", LectEval.Programme);
                IF ACAUnitsSubjects.FIND('-') THEN;
                //ACA-Lecture Eval. Questions Li
            end;
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

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompanyInformation.GET;
        CompanyInformation.CALCFIELDS(Picture);
    end;

    var
        ACAEvaluationQuestions: Record 61035;
        ACAProgramme: Record 61511;
        HRMEmployeeC: Record 61188;
        ACAUnitsSubjects: Record 61517;
        CompanyInformation: Record 79;
        OrderVal: Integer;
        DimensionValue: Record 349;
        Chosen: Code[10];
}

