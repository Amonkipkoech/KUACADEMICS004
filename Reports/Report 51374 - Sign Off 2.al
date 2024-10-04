report 51374 "Sign Off 2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Sign Off 2.rdl';

    dataset
    {
        dataitem("ACA-Programme"; "ACA-Programme")
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Code", "Stage Filter", "Semester Filter";
            column(Programme_Description; Description)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
#pragma warning disable AL0667
            column(CurrReport_PAGENO; CurrReport.PAGENO)
#pragma warning restore AL0667
            {
            }
            column(USERID; USERID)
            {
            }
            column(Programme_Description_Control1102760005; Description)
            {
            }
            column(Programme_Code; Code)
            {
            }
            column(Course_Check_ListCaption; Course_Check_ListCaptionLbl)
            {
            }
            column(MASENO_UNIVERSITYCaption; MASENO_UNIVERSITYCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(SignatureCaption; SignatureCaptionLbl)
            {
            }
            column(Units_RegisteredCaption; Units_RegisteredCaptionLbl)
            {
            }
            column(Student_NoCaption; Student_NoCaptionLbl)
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
                    PrintOnlyIfDetail = false;
                    RequestFilterFields = "No.", Status, "Balance (LCY)";
                    column(StudentU; StudentU)
                    {
                    }
                    column(Sname; Sname)
                    {
                    }
                    column(No; No)
                    {
                    }
                    column(Student__No__; "No.")
                    {
                    }

                    trigger OnPreDataItem()
                    begin
                        //Student.SETFILTER(Student.Status,Programme.GETFILTER(Programme."Status Filter"));
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    coursereg.SETRANGE(coursereg."Student No.", cust."No.");
                    IF coursereg.FIND('+') THEN BEGIN
                        regtid := coursereg."Reg. Transacton ID";
                    END;

                    studentunitrec.SETRANGE(studentunitrec."Student No.", "ACA-Course Registration"."Student No.");
                    //studentunitrec.SETRANGE(studentunitrec."Reg. Transacton ID",regtid);
                    studentunitrec.SETRANGE(studentunitrec.Stage, coursereg.Stage);

                    StudentU := '';
                    IF studentunitrec.FIND('-') THEN BEGIN
                        REPEAT
                            StudentU := StudentU + '  ' + studentunitrec.Unit;
                        UNTIL studentunitrec.NEXT = 0;
                    END;

                    cust.RESET;
                    cust.SETRANGE(cust."No.", "ACA-Course Registration"."Student No.");
                    IF cust.FIND('-') THEN BEGIN
                        Sname := cust.Name;
                    END;
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
        No: Integer;
        "Total Count": Integer;
        StudentU: Text[300];
        studentunitrec: Record 61549;
        cust: Record 18;
        Sname: Text[150];
        coursereg: Record 61532;
        regtid: Code[20];
        Yearfilter: Text[30];
        HS: Integer;
        Course_Check_ListCaptionLbl: Label 'Course Check List';
        MASENO_UNIVERSITYCaptionLbl: Label 'MASENO UNIVERSITY';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        SignatureCaptionLbl: Label 'Signature';
        Units_RegisteredCaptionLbl: Label 'Units Registered';
        Student_NoCaptionLbl: Label 'Student No';
}

