report 61035 "ACA-Lecturers Evaluation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/ACA-Lecturers Evaluation.rdl';

    dataset
    {
        dataitem("ACA-Evaluation Questions"; "ACA-Evaluation Questions")
        {
            column(QID; "ACA-Evaluation Questions".ID)
            {
            }
            column(QDes; "ACA-Evaluation Questions".Description)
            {
            }
            column(QType; "ACA-Evaluation Questions".Type)
            {
            }
            column(QCategory; "ACA-Evaluation Questions".Category)
            {
            }
            column(QClass; "ACA-Evaluation Questions".Class)
            {
            }
            dataitem("ACA-Lecturers Evaluation"; "ACA-Lecturers Evaluation")
            {
                DataItemLink = "Question No" = FIELD(ID);
                RequestFilterFields = Semester, "Lecturer No", Unit, Programme;
                column(Prog; "ACA-Lecturers Evaluation".Programme)
                {
                }
                column(Stage; "ACA-Lecturers Evaluation".Stage)
                {
                }
                column(Unit; "ACA-Lecturers Evaluation".Unit)
                {
                }
                column(Sem; "ACA-Lecturers Evaluation".Semester)
                {
                }
                column(StudNo; "ACA-Lecturers Evaluation"."Student No")
                {
                }
                column(LecNo; "ACA-Lecturers Evaluation"."Lecturer No")
                {
                }
                column(Quiz; "ACA-Lecturers Evaluation"."Question No")
                {
                }
                column(Resp; "ACA-Lecturers Evaluation".Response)
                {
                }
                column(DTime; "ACA-Lecturers Evaluation"."Date Time")
                {
                }
                column(ResAnaly; "ACA-Lecturers Evaluation"."Response Analysis")
                {
                }
                column(sampleCount; sampleCount)
                {
                }
                dataitem("HRM-Employee C"; "HRM-Employee (D)")
                {
                    DataItemLink = "No." = FIELD("Lecturer No");
                    column(LNo; "HRM-Employee C"."No.")
                    {
                    }
                    column(FName; "HRM-Employee C"."First Name")
                    {
                    }
                    column(MName; "HRM-Employee C"."Middle Name")
                    {
                    }
                    column(LName; "HRM-Employee C"."Last Name")
                    {
                    }
                    column(Name; "HRM-Employee C"."First Name" + ' ' + "HRM-Employee C"."Middle Name" + ' ' + "HRM-Employee C"."Last Name")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    sampleCount := 0;
                    "ACA-Lecturers Evaluation".RESET;
                    AcaUnits.RESET;
                    "ACA-Lecturers Evaluation".SETRANGE(Semester, AcaUnits.Semester);
                    "ACA-Lecturers Evaluation".SETRANGE(Unit, AcaUnits.Unit);
                    //"ACA-Lecturers Evaluation".SETRANGE(Programme,AcaUnits.Programme);
                    //"ACA-Lecturers Evaluation".SETRANGE("Student No",AcaUnits."Student No.");
                    IF "ACA-Lecturers Evaluation".FIND('-') THEN BEGIN
                        REPEAT
                            sampleCount := sampleCount + 1;
                        UNTIL "ACA-Lecturers Evaluation".NEXT = 0;
                    END;
                end;
            }

            trigger OnPreDataItem()
            begin
                /*IF "Staff Arreas".GETFILTER("Staff Arreas"."PF No")='' THEN ERROR('You must specify the Employee number');
                */

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
        sampleCount: Decimal;
        AcaUnits: Record 61549;
        QuizCount: Decimal;
}

