report 51716 "Double Registration"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Double Registration.rdl';

    dataset
    {
        dataitem(DataItem2901; 61532)
        {
            RequestFilterFields = Semester, "Programme Exam Category";
            column(Course_Registration__Student_No__; "Student No.")
            {
            }
            column(Course_Registration_Semester; Semester)
            {
            }
            column(Course_Registration_Stage; Stage)
            {
            }
            column(regs; regs)
            {
            }
            column(i; i)
            {
            }
            column(Course_Registration__Student_No__Caption; FIELDCAPTION("Student No."))
            {
            }
            column(Course_Registration_SemesterCaption; FIELDCAPTION(Semester))
            {
            }
            column(Course_Registration_StageCaption; FIELDCAPTION(Stage))
            {
            }
            column(RegsCaption; RegsCaptionLbl)
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
            dataitem("<Course Registration2>"; 61532)
            {
                DataItemLink = "Student No." = FIELD("Student No.");
            }

            trigger OnAfterGetRecord()
            begin
                regs := 0;
                "<Course Registration2>".RESET;
                "<Course Registration2>".SETRANGE("<Course Registration2>"."Student No.", "Student No.");
                //"<Course Registration2>".SETRANGE("<Course Registration2>".Semester,"Course Registration".GETFILTER(
                //"Course Registration".Semester));
                "<Course Registration2>".SETRANGE("<Course Registration2>".Semester, 'SEM 2 09/10');
                regs := "<Course Registration2>".COUNT;
                IF regs >= 1 THEN
                    CurrReport.SKIP ELSE
                    i := i + 1;
            end;

            trigger OnPreDataItem()
            begin
                i := 0
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
        regs: Integer;
        i: Integer;
        RegsCaptionLbl: Label 'Regs';
}

