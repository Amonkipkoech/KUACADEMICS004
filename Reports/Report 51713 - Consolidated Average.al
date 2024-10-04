report 51713 "Consolidated Average"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Consolidated Average.rdl';

    dataset
    {
        dataitem(DataItem2901; 61532)
        {
            DataItemTableView = SORTING("Student No.")
                                ORDER(Ascending);
            RequestFilterFields = Programmes, Stage, Semester, "Student No.", "Cummulative Year Filter";
            column(Course_Registration__Student_No__; "Student No.")
            {
            }
            column(Course_Registration_Stage; Stage)
            {
            }
            column(Course_Registration_Semester; Semester)
            {
            }
            column(unitcount; unitcount)
            {
            }
            column(totalmarks; totalmarks)
            {
            }
            column(avg; avg)
            {
            }
            column(Course_Registration__Student_No__Caption; FIELDCAPTION("Student No."))
            {
            }
            column(Course_Registration_StageCaption; FIELDCAPTION(Stage))
            {
            }
            column(Course_Registration_SemesterCaption; FIELDCAPTION(Semester))
            {
            }
            column(Course_Registration_Reg__Transacton_ID; "Reg. Transacton ID")
            {
            }
            column(Course_Registration_Programme; Programmes)
            {
            }
            column(Course_Registration_Register_for; "Register for")
            {
            }
            column(Course_Registration_Unit; Unit)
            {
            }
            column(Course_Registration_Student_Type; "Student Type")
            {
            }
            column(Course_Registration_Entry_No_; "Entry No.")
            {
            }

            trigger OnAfterGetRecord()
            begin

                IF "Student No." = regno THEN CurrReport.SKIP;

                regno := "Student No.";

                studunitrec.SETFILTER(studunitrec."Student No.", "Student No.");

                unitcount := studunitrec.COUNT;

                totalmarks := 0;
                avg := 0;

                IF studunitrec.FIND('-') THEN
                    REPEAT
                        studunitrec.CALCFIELDS(studunitrec."Total Score");
                        totalmarks := totalmarks + studunitrec."Total Score";
                    UNTIL studunitrec.NEXT = 0;

                IF unitcount > 0 THEN avg := ROUND((totalmarks / unitcount), 1);
            end;

            trigger OnPreDataItem()
            begin

                studunitrec.SETFILTER(studunitrec.Stage, GETFILTER(Stage));
                studunitrec.SETFILTER(studunitrec.Semester, GETFILTER(Semester));

                regno := '';
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
        examrec: Record 61548;
        studunitrec: Record 61549;
        totalmarks: Decimal;
        unitcount: Integer;
        avg: Decimal;
        regno: Text[30];
}

