report 51497 "Student Statistics"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Student Statistics.rdl';

    dataset
    {
        dataitem("ACA-Programme"; "ACA-Programme")
        {
            RequestFilterFields = "Code";
            column(Programme_Code; Code)
            {
            }
            dataitem("ACA-Course Registration"; "ACA-Course Registration")
            {
                DataItemLink = Programmes = FIELD(Code);
                DataItemTableView = SORTING("Student No.")
                                    ORDER(Ascending);
                RequestFilterFields = Semester;
                column(Course_Registration_Programme; Programmes)
                {
                }
                column(Course_Registration_Reg__Transacton_ID; "Reg. Transacton ID")
                {
                }
                column(Course_Registration_Student_No_; "Student No.")
                {
                }
                column(Course_Registration_Semester; Semester)
                {
                }
                column(Course_Registration_Register_for; "Register for")
                {
                }
                column(Course_Registration_Stage; Stage)
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
                dataitem(Customer; 18)
                {
                    DataItemLink = "No." = FIELD("Student No.");
                    DataItemTableView = SORTING("No.")
                                        ORDER(Ascending);
                    RequestFilterFields = "Balance (LCY)";
                    column(Customer__No__; "No.")
                    {
                    }
                    column(Serial; Serial)
                    {
                    }
                    column(EmptyStringCaption; EmptyStringCaptionLbl)
                    {
                    }
                }
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
        fltProgramme: Text[30];
        fltCourseReg: Text[30];
        fltCustomer: Text[30];
        recProgramme: Record 61511;
        recCourseReg: Record 61532;
        recCustomer: Record 18;
        Serial: Integer;
        EmptyStringCaptionLbl: Label '.';
}

