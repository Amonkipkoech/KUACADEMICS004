report 61036 "ACA-Lecturers Evaluation 2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/ACA-Lecturers Evaluation 2.rdl';

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
                RequestFilterFields = Semester;
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
}

