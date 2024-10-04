report 51790 "Creg Validate"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; 61532)
        {
            RequestFilterFields = Programmes, Stage;
            column(FeesBilled_CourseRegistration; "Fees Billed")
            {
            }
            column(TotalBilled_CourseRegistration; "Total Billed")
            {
            }
            column(StudentNo_CourseRegistration; "Student No.")
            {
            }
            column(Semester_CourseRegistration; Semester)
            {
            }
            column(Programme_CourseRegistration; Programmes)
            {
            }
            column(Settlement_type; "Settlement Type")
            {
            }

            trigger OnAfterGetRecord()
            begin

                //"Course Registration".RESET;
                //"Course Registration".SETRANGE("Course Registration".Posted,FALSE);

                Session := 'SEPT 15';
                VALIDATE(Session);
                MODIFY;
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

