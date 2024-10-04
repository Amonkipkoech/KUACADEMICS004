report 50065 "Validate Supp"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/ValidateSupp.rdl';

    dataset
    {
        dataitem(suppReg; "Aca-Special Exams Details")
        {
            RequestFilterFields = "Current Semester";
            column(AcademicYear_suppReg; "Academic Year")
            {
            }
            column(CATMarks_suppReg; "CAT Marks")
            {
            }
            column(Campus_suppReg; Campus)
            {
            }
            column(Catogory_suppReg; Catogory)
            {
            }
            column(ChargePosted_suppReg; "Charge Posted")
            {
            }
            column(CostPerExam_suppReg; "Cost Per Exam")
            {
            }
            column(CurrentAcademicYear_suppReg; "Current Academic Year")
            {
            }
            column(StudentNo_suppReg; "Student No.")
            {
            }
            column(Semester_suppReg; Semester)
            {
            }
            column(Stage_suppReg; Stage)
            {
            }
            trigger OnAfterGetRecord()
            begin
                //"ACA-Course Registration"."Registration Date" := TODAY;
                //"ACA-Course Registration".VALIDATE("ACA-Course Registration"."Registration Date");
                suppReg.Validate("Unit Code");
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
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }



    var
        myInt: Integer;
}