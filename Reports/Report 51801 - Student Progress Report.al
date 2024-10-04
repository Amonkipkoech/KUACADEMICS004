report 51801 "Student Progress Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Student Progress Report.rdl';

    dataset
    {
        dataitem(DataItem1; 61549)
        {
            CalcFields = "CATs Marks Exists", "EXAMs Marks Exists";
            DataItemTableView = SORTING(Stage)
                                ORDER(Ascending)
                                WHERE(Reversed = FILTER('No'));
            RequestFilterFields = Programme, Stage, Semester, Unit, "Student No.";
            column(No; "Student No.")
            {
            }
            column(Prog; Programme)
            {
            }
            column(Stage; Stage)
            {
            }
            column(Unit; Unit)
            {
            }
            column(Sem; Semester)
            {
            }
            column(Year; "Academic Year")
            {
            }
            column(Category; "exam category")
            {

            }
            column(Grade; Grade)
            {
            }
            column(Fin_Score; "Final Score")
            {
            }
            column(Total_Score; "Total Score")
            {
            }
            column(TotScore; "Total Score")
            {
            }
            column(Cat; "CATs Marks")
            {
            }
            column(exam; "EXAMs Marks")
            {
            }
            column(ProgCode; programme)
            {
            }
            column(ProgDesc; Description)
            {
            }
            column(UnitName; "Unit Name")
            {
            }
            column(UnitDesc; "Unit Description")
            {
            }
            column(StudName; Customer.Name)
            {
            }
            column(seq; seq)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CALCFIELDS("Total Score", "Unit Description",
                "EXAMs Marks Exists", "CATs Marks Exists");
                ACAUnitsSubjects.RESET;
                ACAUnitsSubjects.SETRANGE("Programme Code", Programme);
                ACAUnitsSubjects.SETRANGE("Unit Filter", "Unit Name");
                IF ACAUnitsSubjects.FIND('-') THEN;
                ACAProgramme.RESET;
                ACAProgramme.SETRANGE("Unit Filter", Programme);
                IF ACAProgramme.FIND('-') THEN BEGIN

                END;
                IF ACAUnitsSubjects."Exam Category" = '' THEN BEGIN
                    IF ACAUnitsSubjects."Default Exam Category" <> '' THEN
                        ACAUnitsSubjects."Exam Category" := ACAUnitsSubjects."Default Exam Category"
                    ELSE
                        ACAUnitsSubjects."Exam Category" := ACAProgramme."Exam Category";
                END;
                Customer.RESET;
                Customer.SETRANGE("No.", "Student No.");
                IF Customer.FIND('-') THEN BEGIN
                END;
                CLEAR(MarkStatuses);
                IF ("EXAMs Marks Exists" = FALSE) THEN BEGIN
                    MarkStatuses := MarkStatuses::"CAT Only";
                END ELSE
                    IF ("CATs Marks Exists" = FALSE) THEN BEGIN
                        MarkStatuses := MarkStatuses::"CAT Only";
                    END;
                IF (("EXAMs Marks Exists" = FALSE) AND ("CATs Marks Exists" = FALSE)) THEN BEGIN
                    MarkStatuses := MarkStatuses::"None Exists";
                END;
                IF (("EXAMs Marks Exists" = TRUE) AND ("CATs Marks Exists" = TRUE)) THEN BEGIN
                    MarkStatuses := MarkStatuses::"Both Exists";
                END;

                CALCFIELDS("Total Score");
                ACAExamGradingSource.RESET;
                ACAExamGradingSource.SETRANGE("Academic Year", "Academic Year");
                ACAExamGradingSource.SETRANGE("Exam Catregory", Category);
                ACAExamGradingSource.SETRANGE("Total Score", "Total Score");
                ACAExamGradingSource.SETRANGE("Results Exists Status", MarkStatuses);
                IF ACAExamGradingSource.FIND('-') THEN;

                seq += 1;
                Grade := ACAExamGradingSource.Grade;
                IF ACAExamGradingSource.Pass THEN
                    Failed := FALSE ELSE
                    Failed := TRUE;
            end;

            trigger OnPreDataItem()
            begin
                seq := 0;
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
        ACAProgramme: Record 61511;
        ACAUnitsSubjects: Record 61517;
        Customer: Record 18;
        seq: Integer;
        MarkStatuses: Option " ","Both Exists","CAT Only","Exam Only","None Exists";
        ACAExamGradingSource: Record 66659;
}

