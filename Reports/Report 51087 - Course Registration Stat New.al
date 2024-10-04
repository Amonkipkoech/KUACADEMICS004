report 51087 "Course Registration Stat New"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Course Registration Stat New.rdl';

    dataset
    {
        dataitem("ACA-Programme"; "ACA-Programme")
        {
            DataItemTableView = SORTING(Faculty, Code)
                                ORDER(Ascending);
            RequestFilterFields = Category, Faculty, "Code", "Stage Filter", "Semester Filter", "No. Of Units Filter";
            column(Programme_Programme_Code; "ACA-Programme".Code)
            {
            }
            dataitem("ACA-Course Registration"; "ACA-Course Registration")
            {
                DataItemLink = Programmes = FIELD(Code);
                DataItemTableView = SORTING("Student No.")
                                    ORDER(Ascending);
                RequestFilterFields = Stage, Semester;
                column(studcount; studcount)
                {
                }
                column(studcount2; studcount2)
                {
                }
                column(Programme_TotalCaption; Programme_TotalCaptionLbl)
                {
                }
                column(Course_Registration_Reg__Transacton_ID; "Reg. Transacton ID")
                {
                }
                column(Course_Registration_Student_No_; "Student No.")
                {
                }
                column(Course_Registration_Programme; Programmes)
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
                dataitem("ACA-Student Units"; "ACA-Student Units")
                {
                    DataItemLink = "Student No." = FIELD("Student No.");
                    column(Course_Registration___Student_No__; "ACA-Course Registration"."Student No.")
                    {
                    }
                    column(txtcourses; txtcourses)
                    {
                    }
                    column(studcount2_Control1102760003; studcount2)
                    {
                    }
                    column(Student_Units_Programme; Programme)
                    {
                    }
                    column(Student_Units_Stage; Stage)
                    {
                    }
                    column(Student_Units_Unit; Unit)
                    {
                    }
                    column(Student_Units_Semester; Semester)
                    {
                    }
                    column(Student_Units_Reg__Transacton_ID; "Reg. Transacton ID")
                    {
                    }
                    column(Student_Units_Student_No_; "Student No.")
                    {
                    }
                    column(Student_Units_ENo; ENo)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        UnitCount := "ACA-Student Units".COUNT;
                        IF UnitCount > 0 THEN studcount2 := studcount2 + 1;
                        txtcourses := txtcourses + "ACA-Student Units".Unit;
                    end;

                    trigger OnPreDataItem()
                    begin
                        "ACA-Student Units".SETFILTER("ACA-Student Units".Stage, "ACA-Course Registration".GETFILTER("ACA-Course Registration".Stage));
                        "ACA-Student Units".SETFILTER("ACA-Student Units".Semester, "ACA-Course Registration".GETFILTER("ACA-Course Registration".Semester));
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    txtcourses := '';
                    studcount := studcount + 1;
                end;

                trigger OnPreDataItem()
                begin
                    studcount := 0;
                    studcount2 := 0;
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
        txtcourses: Text[255];
        studcount: Integer;
        studcount2: Integer;
        Programme_TotalCaptionLbl: Label 'Programme Total';
}

