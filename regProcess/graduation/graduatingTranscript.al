report 86627 "Final Graduation Transcript2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/testReport2.rdl';

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
                    Pname := Programmes.Description



                // MESSAGE(Programmes.Name);
                ELSE
                    Pname := 'No Program';
                Programmes.SETRANGE(Code, Programme);
                IF Programmes.FIND('-') THEN
                    Faculty := Programmes.Faculty



                // MESSAGE(Programmes.Name);
                ELSE
                    Pname := 'No Program';

                //IF FinalExamResult.MeanScore = '' THEN
                //CurrReport.SKIP
                processGrades();
            end;

            trigger OnPreDataItem()
            begin
                // TESTFIELD("Final Exam Results".StudentID);
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
        unitsCounts: Decimal;
        test: Decimal;
        sumGrade: Decimal;
        avGrade: Decimal;


    procedure processGrades()
    begin

        Clear(unitsCounts);
        FinalExamResult.Reset();
        FinalExamResult.SetRange(StudentID, transcript.StudentID);
        FinalExamResult.SetFilter(FinalExamResult.MeanGrade, '%1|%2|%3|%4|%5|%6|%7|%8', 'A', 'B', 'C', 'D', 'F', 'FF', 'F*');
        if FinalExamResult.FindFirst() then begin
            unitsCounts := FinalExamResult.Count;
            test := 0;
            sumGrade := 0;
            repeat
                Evaluate(test, transcript.MeanScore);
                sumGrade += test;
            until transcript.Next() = 0;
            //trans.CalcSums(EVALUATE(test,trans.MeanScore));
            //unitsSum := trans.MeanScore;
            //Evaluate(sumDec, unitsSum);
            avGrade := (sumGrade / unitsCounts);
            // programmes.Reset();
            // programmes.SetRange(Code, transcript.ProgrammeID);
            // if programmes.Find('-') then begin
            //     examCategory := programmes."Exam Category";
            // end;
            // gradSys.Reset();
            // gradSys.SetRange(Category, examCategory);
            // gradSys.SetFilter("Lower Limit", '<=%1', avGrade);
            // gradSys.SetFilter("Upper Limit", '>=%1', avGrade);
            // if gradSys.FindFirst() then begin
            //     gradRemark := gradSys.Remarks;

            // end;
            //avGrade := (unitsSum/uni)

        end;
    end;
}

