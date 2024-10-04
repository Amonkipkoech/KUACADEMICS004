report 51634 "Student Card Listing"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Student Card Listing.rdl';

    dataset
    {
        dataitem("ACA-Programme"; "ACA-Programme")
        {
            DataItemTableView = SORTING(Code);
            RequestFilterFields = "Code", "Semester Filter", "Date Filter";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
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
            column(TIME; TIME)
            {
            }
            column(Programme_Description; Description)
            {
            }
            column(SemFilter; SemFilter)
            {
            }
            column(Programme__Date_Filter_; "Date Filter")
            {
            }
            column(Programme_Description_Control1000000008; Description)
            {
            }
            column(Programme_Registered; Registered)
            {
            }
            column(Students_Course_Enrollment_and__PaymentsCaption; Students_Course_Enrollment_and__PaymentsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Semester_FilterCaption; Semester_FilterCaptionLbl)
            {
            }
            column(Programme__Date_Filter_Caption; FIELDCAPTION("Date Filter"))
            {
            }
            column(DepartmentCaption; DepartmentCaptionLbl)
            {
            }
            column(PROGRAMME_Caption; PROGRAMME_CaptionLbl)
            {
            }
            column(Total_RegisteredCaption; Total_RegisteredCaptionLbl)
            {
            }
            column(Programme_Code; Code)
            {
            }
            dataitem("ACA-Programme Stages"; "ACA-Programme Stages")
            {
                DataItemLink = "Programme Code" = FIELD(Code);
                column(Programme_Stages_Description; Description)
                {
                }
                column(Programme_Description_Control1000000010; "ACA-Programme".Description)
                {
                }
                column(Programme_Stages_Paid; Paid)
                {
                }
                column(Programme_Stages__Paid_Part_Time_; "Paid Part Time")
                {
                }
                column(Programme_Stages__Paid_Full_Time_; "Paid Full Time")
                {
                }
                column(TotalReg; TotalReg)
                {
                }
                column(STAGE_Caption; STAGE_CaptionLbl)
                {
                }
                column(Total_PaidCaption; Total_PaidCaptionLbl)
                {
                }
                column(Programme_Stages__Paid_Part_Time_Caption; FIELDCAPTION("Paid Part Time"))
                {
                }
                column(Programme_Stages__Paid_Full_Time_Caption; FIELDCAPTION("Paid Full Time"))
                {
                }
                column(Total_Students_RegisteredCaption; Total_Students_RegisteredCaptionLbl)
                {
                }
                column(Programme_Stages_Programme_Code; "Programme Code")
                {
                }
                column(Programme_Stages_Code; Code)
                {
                }
                dataitem("ACA-Course Registration"; "ACA-Course Registration")
                {
                    DataItemLink = Programmes = FIELD("Programme Code"),
                                   Stage = FIELD(Code);
                    DataItemTableView = SORTING("Student Type")
                                        WHERE("Total Paid" = FILTER(>= 1700));
                    RequestFilterFields = "Student Type";
                    column(Course_Registration__Student_Type_; "Student Type")
                    {
                    }
                    column(Course_Registration__Student_No__; "Student No.")
                    {
                    }
                    column(SName; SName)
                    {
                    }
                    column(Course_Registration__Student_Type_Caption; FIELDCAPTION("Student Type"))
                    {
                    }
                    column(Course_Registration__Student_No__Caption; FIELDCAPTION("Student No."))
                    {
                    }
                    column(NameCaption; NameCaptionLbl)
                    {
                    }
                    column(Course_Registration_Reg__Transacton_ID; "Reg. Transacton ID")
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
                    column(Course_Registration_Entry_No_; "Entry No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin

                        IF Cust.GET("ACA-Course Registration"."Student No.") THEN
                            SName := Cust.Name
                        ELSE
                            SName := '';
                        TotPaid := TotPaid + "ACA-Course Registration"."Total Paid";
                        TotIncome := TotIncome + "ACA-Course Registration"."Total Billed";
                        TTotPaid := TTotPaid + "ACA-Course Registration"."Total Paid";
                        TTotIncome := TTotIncome + "ACA-Course Registration"."Total Billed";
                    end;

                    trigger OnPreDataItem()
                    begin
                        LastFieldNo := FIELDNO("Student Type");

                        "ACA-Course Registration".SETFILTER("ACA-Course Registration".Semester, "ACA-Programme Stages".GETFILTER("ACA-Programme Stages"."Semester Filter"))
                        ;
                        "ACA-Course Registration".SETFILTER("ACA-Course Registration"."Registration Date",
                        "ACA-Programme Stages".GETFILTER("ACA-Programme Stages"."Date Filter"));
                        "ACA-Course Registration".SETFILTER("ACA-Course Registration".Status, "ACA-Programme Stages".GETFILTER("ACA-Programme Stages".Status));
                        "ACA-Course Registration".SETFILTER("ACA-Course Registration".Reversed, 'no');
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    "ACA-Programme Stages".CALCFIELDS("ACA-Programme Stages"."Total Income1");
                    TotalIncome := TotalIncome + "ACA-Programme Stages"."Total Income1";
                    TotalReg := TotalReg + "ACA-Programme Stages"."Student Registered";
                end;

                trigger OnPreDataItem()
                begin
                    "ACA-Programme Stages".SETFILTER("ACA-Programme Stages"."Semester Filter", "ACA-Programme".GETFILTER("ACA-Programme"."Semester Filter"));
                    "ACA-Programme Stages".SETFILTER("ACA-Programme Stages"."Date Filter", "ACA-Programme".GETFILTER("ACA-Programme"."Date Filter"));
                    "ACA-Programme Stages".SETFILTER("ACA-Programme Stages".Status, "ACA-Programme".GETFILTER("ACA-Programme".Status));
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TotalIncome := 0;
                TotalReg := 0;
                SemFilter := "ACA-Programme".GETFILTER("ACA-Programme"."Semester Filter");
                TotPaid := 0;
                TotIncome := 0;
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
        TotalIncome: Decimal;
        TotalReg: Integer;
        Cust: Record 18;
        SName: Text[200];
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        SemFilter: Text[150];
        TotPaid: Decimal;
        TotIncome: Decimal;
        TTotPaid: Decimal;
        TTotIncome: Decimal;
        Students_Course_Enrollment_and__PaymentsCaptionLbl: Label 'Students Course Enrollment and  Payments';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Semester_FilterCaptionLbl: Label 'Semester Filter';
        DepartmentCaptionLbl: Label 'Department';
        PROGRAMME_CaptionLbl: Label 'PROGRAMME:';
        Total_RegisteredCaptionLbl: Label 'Total Registered';
        STAGE_CaptionLbl: Label 'STAGE:';
        Total_PaidCaptionLbl: Label 'Total Paid';
        Total_Students_RegisteredCaptionLbl: Label 'Total Students Registered';
        NameCaptionLbl: Label 'Name';
}

