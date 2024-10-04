report 78030 "ACA-Course Registration"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("ACA-Semesters"; "ACA-Semesters")
        {
            dataitem("ACA-Course Registration"; "ACA-Course Registration")
            {
                DataItemLink = Semester = FIELD(Code);

                trigger OnAfterGetRecord()
                begin
                    "ACA-Course Registration".VALIDATE("ACA-Course Registration".Stage);
                    "ACA-Course Registration"."Academic Year" := "ACA-Semesters"."Academic Year";
                    "ACA-Course Registration".MODIFY;
                end;
            }
            dataitem(StudUnits; "ACA-Student Units")
            {
                DataItemLink = Semester = FIELD(Code);

                trigger OnAfterGetRecord()
                begin
                    //StudUnits."Academic Year":="ACA-Semesters"."Academic Year";
                    StudUnits.RENAME(StudUnits.Programme, StudUnits.Stage, StudUnits.Unit, StudUnits.Semester,
                    StudUnits."Reg. Transacton ID", StudUnits."Student No.", StudUnits.ENo, "ACA-Semesters"."Academic Year");
                end;
            }
            dataitem(ExamRes; "ACA-Exam Results")
            {
                DataItemLink = Semester = FIELD(Code);

                trigger OnAfterGetRecord()
                begin
                    ExamRes."Academic Year" := "ACA-Semesters"."Academic Year";
                    ExamRes.MODIFY;
                end;
            }
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
        Yos: Integer;

}

