report 65252 "ACA-Lecturer Evaluation Summar"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/ACA-Lecturer Evaluation Summar.rdl';

    dataset
    {
        dataitem(LectEval; "ACA-Lecturers Evaluation")
        {
            RequestFilterFields = Programme, Unit, Semester, "Lecturer No", "Department Code";
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
            column(RespValue; LectEval.Choices)
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
            column(SchoolCode; SchoolCode)
            {
            }
            column(SchoolName; SchoolName)
            {
            }
            column(DeptCode; DeptCode)
            {
            }
            column(DeptName; DeptName)
            {
            }
            column(GrouppingNos; LectEval.Programme + LectEval.Semester + LectEval."Lecturer No" + LectEval.Unit)
            {
            }
            column(i; ACALecturersEvaluationCount.Sequence)
            {
            }

            trigger OnAfterGetRecord()
            var
                i: Integer;
            begin
                CLEAR(SchoolCode);
                CLEAR(SchoolName);
                CLEAR(DeptCode);
                CLEAR(DeptName);
                ACAEvaluationQuestions.RESET;
                ACAEvaluationQuestions.SETRANGE(Semester, LectEval.Semester);
                ACAEvaluationQuestions.SETRANGE(ID, LectEval."Question No");
                IF ACAEvaluationQuestions.FIND('-') THEN;
                HRMEmployeeC.RESET;
                HRMEmployeeC.SETRANGE("No.", LectEval."Lecturer No");
                IF HRMEmployeeC.FIND('-') THEN;
                IF ((HRMEmployeeC."First Name" = '') OR (HRMEmployeeC."Middle Name" = '') OR (HRMEmployeeC."Last Name" = '')) THEN
                    CurrReport.SKIP;
                ACAProgramme.RESET;
                ACAProgramme.SETRANGE(Code, LectEval.Programme);
                IF ACAProgramme.FIND('-') THEN BEGIN
                    //Dim School
                    DimensionValue.RESET;
                    DimensionValue.SETRANGE("Dimension Code", 'SCHOOL');
                    DimensionValue.SETRANGE(Code, ACAProgramme."School Code");
                    IF DimensionValue.FIND('-') THEN BEGIN
                        SchoolCode := DimensionValue.Code;
                        SchoolName := DimensionValue.Name;
                    END;

                    //Dim School
                    DimensionValue.RESET;
                    DimensionValue.SETRANGE("Dimension Code", 'DEPARTMENT');
                    DimensionValue.SETRANGE(Code, ACAProgramme."Department Code");
                    IF DimensionValue.FIND('-') THEN BEGIN
                        DeptCode := DimensionValue.Code;
                        DeptName := DimensionValue.Name;
                    END;
                END;
                ACAUnitsSubjects.RESET;
                ACAUnitsSubjects.SETRANGE(Code, LectEval.Unit);
                ACAUnitsSubjects.SETRANGE("Programme Code", LectEval.Programme);
                IF ACAUnitsSubjects.FIND('-') THEN;
                IF ACAUnitsSubjects.Desription = '' THEN CurrReport.SKIP;
                CLEAR(i);
                ACALecturersEvaluationCount.RESET;
                ACALecturersEvaluationCount.SETRANGE("Semester Code", LectEval.Semester);
                ACALecturersEvaluationCount.SETRANGE("User ID", USERID);
                i := ACALecturersEvaluationCount.COUNT;
                i := i + 1;

                ACALecturersEvaluationCount.RESET;
                ACALecturersEvaluationCount.SETRANGE("Semester Code", LectEval.Semester);
                ACALecturersEvaluationCount.SETRANGE("User ID", USERID);
                ACALecturersEvaluationCount.SETRANGE("Lecturer No.", LectEval."Lecturer No");
                ACALecturersEvaluationCount.SETRANGE("Course Code", LectEval.Unit);
                IF NOT ACALecturersEvaluationCount.FIND('-') THEN BEGIN
                    ACALecturersEvaluationCount.INIT;
                    ACALecturersEvaluationCount."Lecturer No." := LectEval."Lecturer No";
                    ACALecturersEvaluationCount."Semester Code" := LectEval.Semester;
                    ACALecturersEvaluationCount."Course Code" := LectEval.Unit;
                    ACALecturersEvaluationCount."User ID" := USERID;
                    ACALecturersEvaluationCount.Sequence := i;
                    ACALecturersEvaluationCount.INSERT;
                END;

                ACALecturersEvaluationCount.RESET;
                ACALecturersEvaluationCount.SETRANGE("Semester Code", LectEval.Semester);
                ACALecturersEvaluationCount.SETRANGE("User ID", USERID);
                ACALecturersEvaluationCount.SETRANGE("Lecturer No.", LectEval."Lecturer No");
                ACALecturersEvaluationCount.SETRANGE("Course Code", LectEval.Unit);
                IF ACALecturersEvaluationCount.FIND('-') THEN;
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
        CompanyInformation.RESET;
        IF CompanyInformation.FIND('-') THEN BEGIN
            //  CompanyInformation.CALCFIELDS(Picture);
        END;
    end;

    trigger OnPreReport()
    begin
        IF LectEval.GETFILTER(Semester) = '' THEN ERROR('Kindly specify the Semester Filter!');
    end;

    var
        ACAEvaluationQuestions: Record 61035;
        ACAProgramme: Record 61511;
        HRMEmployeeC: Record 61188;
        ACAUnitsSubjects: Record 61517;
        CompanyInformation: Record 79;
        DimensionValue: Record 349;
        Customer: Record 18;
        SchoolCode: Code[20];
        SchoolName: Text[150];
        DeptCode: Code[20];
        DeptName: Text[150];
        ACALecturersEvaluationCount: Record 77770;
}

