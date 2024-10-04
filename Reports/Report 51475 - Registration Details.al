report 51475 "Registration Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Registration Details.rdl';

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
            column(Programme_Description; Description)
            {
            }
            column(Programme__Registered_Full_Time_; "Registered Full Time")
            {
            }
            column(Programme__Paid_Full_Time_; "Paid Full Time")
            {
            }
            column(Programme__Registered_Part_Time_; "Registered Part Time")
            {
            }
            column(Programme__Paid_Part_Time_; "Paid Part Time")
            {
            }
            column(Programme_Registered; Registered)
            {
            }
            column(Programme_Paid; Paid)
            {
            }
            column(Programme__Part_Time_Budget___Programme__Full_Time_Budget_; "ACA-Programme"."Part Time Budget" + "ACA-Programme"."Full Time Budget")
            {
            }
            column(Enroll; Enroll)
            {
            }
            column(Registration_DetailsCaption; Registration_DetailsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Programme_PaidCaption; FIELDCAPTION(Paid))
            {
            }
            column(RegCaption; RegCaptionLbl)
            {
            }
            column(Programme__Paid_Part_Time_Caption; FIELDCAPTION("Paid Part Time"))
            {
            }
            column(Reg_Part_TimeCaption; Reg_Part_TimeCaptionLbl)
            {
            }
            column(Programme__Paid_Full_Time_Caption; FIELDCAPTION("Paid Full Time"))
            {
            }
            column(Reg_Full_TimeCaption; Reg_Full_TimeCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(CodeCaption; CodeCaptionLbl)
            {
            }
            column(Programme_Stages__Full_Time_Budget_Caption; "ACA-Programme Stages".FIELDCAPTION("Full Time Budget"))
            {
            }
            column(Programme_Stages__Part_Time_Budget_Caption; "ACA-Programme Stages".FIELDCAPTION("Part Time Budget"))
            {
            }
            column(BudgetCaption; BudgetCaptionLbl)
            {
            }
            column(EnrollCaption; EnrollCaptionLbl)
            {
            }
            column(TotalsCaption; TotalsCaptionLbl)
            {
            }
            column(Programme_Code; Code)
            {
            }
            dataitem("ACA-Programme Stages"; "ACA-Programme Stages")
            {
                DataItemLink = "Programme Code" = FIELD(Code);
                column(Programme_Stages_Paid; Paid)
                {
                }
                column(Programme_Stages_Registered; Registered)
                {
                }
                column(Programme_Stages__Paid_Part_Time_; "Paid Part Time")
                {
                }
                column(Programme_Stages__Registered_Part_Time_; "Registered Part Time")
                {
                }
                column(Programme_Stages__Paid_Full_Time_; "Paid Full Time")
                {
                }
                column(Programme_Stages__Registered_Full_Time_; "Registered Full Time")
                {
                }
                column(Programme_Stages_Description; Description)
                {
                }
                column(Programme_Stages_Code; Code)
                {
                }
                column(Programme_Stages__Full_Time_Budget_; "Full Time Budget")
                {
                }
                column(Programme_Stages__Part_Time_Budget_; "Part Time Budget")
                {
                }
                column(Programme_Stages_Programme_Code; "Programme Code")
                {
                }

                trigger OnPreDataItem()
                begin
                    "ACA-Programme Stages".SETFILTER("ACA-Programme Stages"."Date Filter", "ACA-Programme".GETFILTER("ACA-Programme"."Date Filter"));
                end;
            }

            trigger OnAfterGetRecord()
            begin
                "ACA-Programme".CALCFIELDS("ACA-Programme"."Part Time Budget", "ACA-Programme"."Full Time Budget", "ACA-Programme".Paid);
                Enroll := 0;
                IF ("ACA-Programme".Paid > 0) AND (("ACA-Programme"."Part Time Budget" + "ACA-Programme"."Full Time Budget") > 0) THEN
                    Enroll := ("ACA-Programme".Paid / ("ACA-Programme"."Part Time Budget" + "ACA-Programme"."Full Time Budget")) * 100;
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
        Enroll: Decimal;
        Registration_DetailsCaptionLbl: Label 'Registration Details';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        RegCaptionLbl: Label 'Reg';
        Reg_Part_TimeCaptionLbl: Label 'Reg Part Time';
        Reg_Full_TimeCaptionLbl: Label 'Reg Full Time';
        DescriptionCaptionLbl: Label 'Description';
        CodeCaptionLbl: Label 'Code';
        BudgetCaptionLbl: Label 'Budget';
        EnrollCaptionLbl: Label '% Enroll';
        TotalsCaptionLbl: Label 'Totals';
}

