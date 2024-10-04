report 50736 "Final Graduation Transcript"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/testReport.rdl';

    dataset
    {
        dataitem(transcript; "Final Exam Result2")
        {
            RequestFilterFields = StudentID;
            column(ExamEntry; ExamEntry)
            {
            }
            column(ProgrammeID; ProgrammeID)
            {
            }
            column(programName; programName)
            {

            }
            column(AcademicYr; AcademicYr)
            {
            }
            column(Session; Session)
            {
            }
            column(StudentName; StudentName)
            {

            }
            column(StudentID; StudentID)
            {
            }
            column(UnitCode; UnitCode)
            {
            }
            column(UnitDesc; UnitDesc)
            {
            }
            column(MeanScore; MeanScore)
            {
            }
            column(MeanGrade; MeanGrade)
            {
            }
            column(Name; Name)
            {
            }
            column(Programme; Programme)
            {
            }
            column(Faculty; Faculty)
            {
            }
            column(Pname; Pname)
            {
            }
            column(CreditUnit; CreditUnit)
            {
            }
            column(Weight; Weight)
            {
            }
            column(avGrade; avGrade)
            {

            }

            trigger OnAfterGetRecord()
            begin
                CalcFields(StudentName, programName);
                Name := '';
                //studNo := transcript.StudentID;
                cust.Reset();
                Cust.SETRANGE("No.", FinalExamResult.StudentID);
                IF Cust.FIND('-')
                   THEN BEGIN

                    // Total := Cust.COUNT;
                    Name := Cust."First Name" + ' ' + Cust."Middle Name" + ' ' + cust."Last Name";
                    Programme := Cust."Current Programme";
                    //Total := Total+1;
                END
                ELSE
                    Name := 'A man has no Name';

                Programmes.SETRANGE(Code, Programme);
                IF Programmes.FIND('-') THEN
                    // MESSAGE(Programmes.Name);
                    Pname := Programmes.Description
                ELSE
                    Pname := 'No Program';

                processGrades();
                //IF FinalExamResult.MeanScore = '' THEN
                //CurrReport.SKIP
                // repeat

                // until transcript.Next() = 0;


            end;

            // trigger OnPostDataItem()
            // begin
            //     processGrades();
            // end;


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

    var
        Name: Text[250];
        Programme: Code[250];
        Faculty: Code[250];
        Cust: Record Customer;
        Programmes: Record "ACA-Programme";
        Pname: Text[250];
        TotalQP: Decimal;
        TotalCHR: Decimal;
        FinalMean: Decimal;
        Grade: Code[10];
        FinalExamResult: Record "Final Exam Result2";
        //finExam: Record "Final Exam Result2";
        unitsCounts: Decimal;
        test: Decimal;
        sumGrade: Decimal;
        avGrade: Decimal;



    procedure processGrades()
    begin

        //Clear(unitsCounts);
        FinalExamResult.Reset();
        FinalExamResult.SetRange(StudentID, transcript.StudentID);
        FinalExamResult.SetFilter(FinalExamResult.MeanGrade, '%1|%2|%3|%4|%5|%6', 'A', 'B', 'C', 'D', 'F', 'FF');
        if FinalExamResult.FindFirst() then begin
            unitsCounts := FinalExamResult.Count;
            test := 0;
            sumGrade := 0;
            repeat
                Evaluate(test, FinalExamResult.MeanScore);
                sumGrade += test;
            until FinalExamResult.Next() = 0;

            avGrade := (sumGrade / unitsCounts);


        end;
    end;
}

