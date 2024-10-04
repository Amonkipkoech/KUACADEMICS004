/// <summary>
/// Report Detailed Student Enrollment (ID 51691).
/// </summary>
report 51691 "Detailed Student Enrollment"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Detailed Student Enrollment.rdl';

    dataset
    {
        dataitem(DataItem1410; 61511)
        {
            RequestFilterFields = "Code", "Semester Filter";
            column(USERID; USERID)
            {
            }
#pragma warning disable AL0667
            column(CurrReport_PAGENO; CurrReport.PAGENO)
#pragma warning restore AL0667
            {
            }
            column(TIME; TIME)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Programme_Stages__GETFILTER__Programme_Stages___Semester_Filter__; GETFILTER("Semester Filter"))
            {
            }
            column(Programme_Description; Description)
            {
            }
            column(Programme_Code; Code)
            {
            }
            column(Programme_Registered; Registered)
            {
            }
            column(Programme_Paid; Paid)
            {
            }
            column(Programme__Registered_Part_Time_; "Registered Part Time")
            {
            }
            column(Programme__Paid_Part_Time_; "Paid Part Time")
            {
            }
            column(Programme__Registered_Full_Time_; "Registered Full Time")
            {
            }
            column(Programme__Paid_Full_Time_; "Paid Full Time")
            {
            }
            column(Programme__Full_Time_Budget_; "Full Time Budget")
            {
            }
            column(Programme__Part_Time_Budget_; "Part Time Budget")
            {
            }
            // column(ProgPerc; ProgPerc)
            // {
            // }
            // column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            // {
            // }
            // column(Summary_Enrollment___Registered_Paid_And_Budget_VarianceCaption; Summary_Enrollment___Registered_Paid_And_Budget_VarianceCaptionLbl)
            // {
            // }
            // column(Semester_Filter_Caption; Semester_Filter_CaptionLbl)
            // {
            // }
            // column(Paid__BudgetCaption; Paid__BudgetCaptionLbl)
            // {
            // }
            // column(Part_Time_BudgetCaption; Part_Time_BudgetCaptionLbl)
            // {
            // }
            // column(Full_Time_BudgetCaption; Full_Time_BudgetCaptionLbl)
            // {
            // }
            // column(Paid_Full_TimeCaption; Paid_Full_TimeCaptionLbl)
            // {
            // }
            // column(Paid_Part_TimeCaption; Paid_Part_TimeCaptionLbl)
            // {
            // }
            // column(Total_PaidCaption; Total_PaidCaptionLbl)
            // {
            // }
            // column(Registered_Full_TimeCaption; Registered_Full_TimeCaptionLbl)
            // {
            // }
            // column(Registered_Part_TimeCaption; Registered_Part_TimeCaptionLbl)
            // {
            // }
            column(Programme_Stages__Student_Registered_Caption; FIELDCAPTION("Student Registered"))
            {
            }
            column(Programme_Stages_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Programme_Stages__Programme_Code_Caption; FIELDCAPTION(code))
            {
            }
            column(Programme_Stages_CodeCaption; FIELDCAPTION(Code))
            {
            }
            // column(ProgrammeCaption; programmes)
            // {
            // }
            // column(TotalsCaption; total)
            // {
            // }
            column(Programme_Semester_Filter; "Semester Filter")
            {
            }
            dataitem(DataItem3691; 61516)
            {
                CalcFields = "Registered Part Time", "Paid Part Time", "Registered Full Time", "Paid Full Time";
                DataItemLink = "Programme Code" = FIELD(Code);
                //Semester =FIELD(filter(Semester ))
                ;
                DataItemTableView = SORTING("Programme Code", Code);
                RequestFilterFields = "Programme Code", "Semester Filter";
                column(Programme_Stages__Programme_Code_; "Programme Code")
                {
                }
                column(Programme_Stages_Code; Code)
                {
                }
                column(Programme_Stages_Description; Description)
                {
                }
                column(Programme_Stages__Student_Registered_; "Student Registered")
                {
                }
                column(Programme_Stages__Registered_Part_Time_; "Registered Part Time")
                {
                }
                column(Programme_Stages__Registered_Full_Time_; "Registered Full Time")
                {
                }
                column(Programme_Stages__Paid_Part_Time_; "Paid Part Time")
                {
                }
                column(Programme_Stages__Paid_Full_Time_; "Paid Full Time")
                {
                }
                column(Programme_Stages__Full_Time_Budget_; "Full Time Budget")
                {
                }
                column(Programme_Stages__Part_Time_Budget_; "Part Time Budget")
                {
                }
                column(percantage; percantage)
                {
                }
                column(Programme_Stages_Paid; Paid)
                {
                }
                column(Programme_Stages_Registered; Registered)
                {
                }
                column(Programme_Stages_Semester_Filter; "Semester Filter")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    TotalStuds := TotalStuds + "Student Registered";
                    StudReg := 0;
                    StudRegPT := 0;
                    PaidPT := 0;
                    PaidFT := 0;
                    StudRegFT := 0;
                    /*
                    Programme.RESET;
                    Programme.SETRANGE(Programme.Code,"Programme Stages"."Programme Code");
                    Programme.SETFILTER(Programme."Semester Filter","Programme Stages".GETFILTER("Programme Stages"."Semester Filter"));
                    IF  Programme.FIND('-') THEN BEGIN
                    Programme.CALCFIELDS(Programme."Student Registered");
                    Programme.CALCFIELDS(Programme."Registered Part Time");
                    Programme.CALCFIELDS(Programme."Paid Part Time");
                    Programme.CALCFIELDS(Programme."Registered Full Time");
                    Programme.CALCFIELDS(Programme."Paid Full Time");
                    Programme.CALCFIELDS(Programme."Full Time Budget");
                    Programme.CALCFIELDS(Programme."Part Time Budget");
                    StudReg:=Programme."Student Registered";
                    StudRegPT:=Programme."Registered Part Time";
                    PaidPT:=Programme."Paid Part Time";
                    PaidFT:=Programme."Paid Full Time";
                    StudRegFT:=Programme."Registered Full Time";
                    PartBudget:=Programme."Part Time Budget";
                    FullBudget:=Programme."Full Time Budget";
                    TPaid:=PaidPT+PaidFT;
                    TBudget:=Programme."Part Time Budget"+Programme."Full Time Budget";
                    percantage:=0;
                    IF (TPaid<>0) AND (TBudget<>0) THEN
                    percantage:=(TPaid/TBudget)/100;
                    END;
                    */
                    percantage := 0;
                    TPaid := "Paid Part Time" + "Paid Full Time";
                    TBudget := "Full Time Budget" + "Part Time Budget";
                    IF (TPaid <> 0) AND (TBudget <> 0) THEN
                        percantage := (TPaid / TBudget) * 100;

                end;

                trigger OnPreDataItem()
                begin
                    LastFieldNo := FIELDNO("Programme Code");
                    //TStudReg:=0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                ProgPerc := 0;
                TPaid := "Paid Part Time" + "Paid Full Time";
                TBudget := "Full Time Budget" + "Part Time Budget";
                IF (TPaid <> 0) AND (TBudget <> 0) THEN
                    ProgPerc := (TPaid / TBudget) * 100;
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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalStuds: Integer;
        Prog: Record 61511;
        StudReg: Integer;
        StudRegPT: Integer;
        PaidPT: Integer;
        PaidFT: Integer;
        StudRegFT: Integer;
        TStudReg: Integer;
        TStudRegPT: Integer;
        TPaidPT: Integer;
        TPaidFT: Integer;
        Programmes: Record 61511;
        TStudRegFT: Integer;
        percantage: Decimal;
        PartBudget: Decimal;
        FullBudget: Decimal;
        TBudget: Decimal;
        TPaid: Decimal;
        SFilter: Text[100];
        ProgPerc: Decimal;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Summary_Enrollment___Registered_Paid_And_Budget_VarianceCaptionLbl: Label 'Summary Enrollment - Registered,Paid And Budget Variance';
        Semester_Filter_CaptionLbl: Label 'Semester Filter:';
        Paid__BudgetCaptionLbl: Label '%Paid /Budget';
        Part_Time_BudgetCaptionLbl: Label 'Part Time Budget';
        Full_Time_BudgetCaptionLbl: Label 'Full Time Budget';
        Paid_Full_TimeCaptionLbl: Label 'Paid Full Time';
        Paid_Part_TimeCaptionLbl: Label 'Paid Part Time';
        Total_PaidCaptionLbl: Label 'Total Paid';
        Registered_Full_TimeCaptionLbl: Label 'Registered Full Time';
        Registered_Part_TimeCaptionLbl: Label 'Registered Part Time';
        ProgrammeCaptionLbl: Label 'Programme';
        TotalsCaptionLbl: Label 'Totals';
}

