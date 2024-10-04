report 51259 "Student By Department/Course"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Student By DepartmentCourse.rdl';

    dataset
    {
        dataitem(DataItem1410; 61511)
        {
            DataItemTableView = SORTING(Code)
                                ORDER(Ascending);
            PrintOnlyIfDetail = true;
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            /* column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            } */
            column(USERID; USERID)
            {
            }
            column(Programme_Description; Description)
            {
            }
            column(Class_ListCaption; Class_ListCaptionLbl)
            {
            }
            column(MASENO_UNIVERSITYCaption; MASENO_UNIVERSITYCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Student_NameCaption; Student_NameCaptionLbl)
            {
            }
            column(Registration_No_Caption; Registration_No_CaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(YearCaption; YearCaptionLbl)
            {
            }
            column(Programme_Code; Code)
            {
            }
            column(Programme_Stage_Filter; "Stage Filter")
            {
            }
            dataitem("ACA-Course Registration"; "ACA-Course Registration")
            {
                DataItemLink = Programmes = FIELD(Code),
                               Stage = FIELD("Stage Filter");
                DataItemTableView = SORTING(Stage)
                                    ORDER(Ascending);
                PrintOnlyIfDetail = true;
                RequestFilterFields = Programmes, Semester, Stage, "Student No.";
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
                dataitem(Student; 18)
                {
                    DataItemLink = "No." = FIELD("Student No.");
                    DataItemTableView = WHERE(Status = FILTER(Registration | Current));
                    PrintOnlyIfDetail = false;
                    RequestFilterFields = "No.", Status, "Balance (LCY)";
                    column(Student_Name; Name)
                    {
                    }
                    column(Student__No__; "No.")
                    {
                    }
                    column(No; No)
                    {
                    }
                    column(Course_Registration__Stage; "ACA-Course Registration".Stage)
                    {
                    }

                    trigger OnPreDataItem()
                    begin
                        //Student.SETFILTER(Student.Status,Programme.GETFILTER(Programme."Status Filter"));
                    end;
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
        No: Integer;
        "Total Count": Integer;
        Class_ListCaptionLbl: Label 'Class List';
        MASENO_UNIVERSITYCaptionLbl: Label 'MASENO UNIVERSITY';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Student_NameCaptionLbl: Label 'Student Name';
        Registration_No_CaptionLbl: Label 'Registration No.';
        No_CaptionLbl: Label 'No.';
        YearCaptionLbl: Label 'Year';
}

