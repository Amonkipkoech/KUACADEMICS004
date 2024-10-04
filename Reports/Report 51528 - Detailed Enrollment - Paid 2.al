report 51528 "Detailed Enrollment - Paid 2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Detailed Enrollment - Paid 2.rdl';

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
            column(Programme_Paid; Paid)
            {
            }
            column(Students_Course_Enrollment_and__Payment_DetailsCaption; Students_Course_Enrollment_and__Payment_DetailsCaptionLbl)
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
            column(Total_PaidCaption; Total_PaidCaptionLbl)
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
                column(Programme_Stages__Student_Registered_; "Student Registered")
                {
                }
                column(Programme_Stages__Registered_Full_Time_; "Registered Full Time")
                {
                }
                column(Programme_Stages__Registered_Part_Time_; "Registered Part Time")
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
                column(Programme_Stages__Student_Registered_Caption; FIELDCAPTION("Student Registered"))
                {
                }
                column(Programme_Stages__Registered_Full_Time_Caption; FIELDCAPTION("Registered Full Time"))
                {
                }
                column(Programme_Stages__Registered_Part_Time_Caption; FIELDCAPTION("Registered Part Time"))
                {
                }
                column(STAGE_Caption; STAGE_CaptionLbl)
                {
                }
                column(Total_PaidCaption_Control1000000056; Total_PaidCaption_Control1000000056Lbl)
                {
                }
                column(Programme_Stages__Paid_Part_Time_Caption; FIELDCAPTION("Paid Part Time"))
                {
                }
                column(Programme_Stages__Paid_Full_Time_Caption; FIELDCAPTION("Paid Full Time"))
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
                                        WHERE(Reversed = CONST(false));
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
                    column(Course_Registration__Total_Billed_; "Total Billed")
                    {
                    }
                    column(RCount; RCount)
                    {
                    }
                    column(LBalance; LBalance)
                    {
                    }
                    column(Course_Registration__Total_Paid_; "Total Paid")
                    {
                    }
                    column(Total_Billed___Total_Paid_; "Total Billed" - "Total Paid")
                    {
                    }
                    column(Course_Registration__Total_Billed__Control1102760004; "Total Billed")
                    {
                    }
                    column(Course_Registration__Total_Paid__Control1102760005; "Total Paid")
                    {
                    }
                    column(Total_Billed___Total_Paid__Control1102760006; "Total Billed" - "Total Paid")
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
                    column(Course_Registration__Total_Billed_Caption; FIELDCAPTION("Total Billed"))
                    {
                    }
                    column(No_Caption; No_CaptionLbl)
                    {
                    }
                    column(Ledger_BalanceCaption; Ledger_BalanceCaptionLbl)
                    {
                    }
                    column(Course_Registration__Total_Paid_Caption; FIELDCAPTION("Total Paid"))
                    {
                    }
                    column(BalanceCaption; BalanceCaptionLbl)
                    {
                    }
                    column(TOTAL_Caption; TOTAL_CaptionLbl)
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
                        LBalance := 0;
                        IF Cust.GET("ACA-Course Registration"."Student No.") THEN BEGIN
                            Cust.CALCFIELDS(Cust.Balance);
                            LBalance := Cust.Balance;
                            SName := Cust.Name;
                        END ELSE
                            SName := '';
                        TotPaid := TotPaid + "ACA-Course Registration"."Total Paid";
                        TotIncome := TotIncome + "ACA-Course Registration"."Total Billed";
                        TTotPaid := TTotPaid + "ACA-Course Registration"."Total Paid";
                        TTotIncome := TTotIncome + "ACA-Course Registration"."Total Billed";
                        RCount := RCount + 1;
                    end;

                    trigger OnPostDataItem()
                    begin
                        TBilled := 0;
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
                        TBilled := 0;
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
        TBilled: Decimal;
        RCount: Integer;
        LBalance: Decimal;
        Students_Course_Enrollment_and__Payment_DetailsCaptionLbl: Label 'Students Course Enrollment and  Payment Details';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Semester_FilterCaptionLbl: Label 'Semester Filter';
        DepartmentCaptionLbl: Label 'Department';
        PROGRAMME_CaptionLbl: Label 'PROGRAMME:';
        Total_RegisteredCaptionLbl: Label 'Total Registered';
        Total_PaidCaptionLbl: Label 'Total Paid';
        STAGE_CaptionLbl: Label 'STAGE:';
        Total_PaidCaption_Control1000000056Lbl: Label 'Total Paid';
        NameCaptionLbl: Label 'Name';
        No_CaptionLbl: Label 'No.';
        Ledger_BalanceCaptionLbl: Label 'Ledger Balance';
        BalanceCaptionLbl: Label 'Balance';
        TOTAL_CaptionLbl: Label 'TOTAL:';
}

