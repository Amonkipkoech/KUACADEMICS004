/// <summary>
/// Report Detailed Student Enrollment1 (ID 51695).
/// </summary>
report 51695 "Detailed Student Enrollment1"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Detailed Student Enrollment1.rdl';

    dataset
    {
        dataitem(DataItem3691; 61516)
        {
            CalcFields = "Registered Part Time", "Paid Part Time", "Registered Full Time", "Paid Full Time";
            DataItemTableView = SORTING("Programme Code", Code);
            RequestFilterFields = "Programme Code", "Semester Filter";
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
            column(TIME; TIME)
            {
            }
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
            column(Programme_Stages__Programme_Code__Control1000000008; "Programme Code")
            {
            }
            column(StudReg; StudReg)
            {
            }
            column(StudRegPT; StudRegPT)
            {
            }
            column(StudRegFT; StudRegFT)
            {
            }
            column(PaidPT; PaidPT)
            {
            }
            column(PaidFT; PaidFT)
            {
            }
            column(FullBudget; FullBudget)
            {
            }
            column(PartBudget; PartBudget)
            {
            }
            column(PaidT; PaidT)
            {
            }
            column(Tbudget; Tbudget)
            {
            }
            column(percantage; percantage)
            {
            }
            column(Pdescription; Pdescription)
            {
            }
            column(TStudReg; TStudReg)
            {
            }
            column(TStudRegPT; TStudRegPT)
            {
            }
            column(TStudRegFT; TStudRegFT)
            {
            }
            column(TPaidPT; TPaidPT)
            {
            }
            column(TPaidFT; TPaidFT)
            {
            }
            column(GPaidT; GPaidT)
            {
            }
            column(GTbudget; GTbudget)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(MASENOUNIVERSITY1Caption; MASENOUNIVERSITY1CaptionLbl)
            {
            }
            column(CLASS_REGISTRATION_SUMMARY___AS_AT_Caption; CLASS_REGISTRATION_SUMMARY___AS_AT_CaptionLbl)
            {
            }
            column(TIMECaption; TIMECaptionLbl)
            {
            }
            column(Programme_Stages__Programme_Code_Caption; FIELDCAPTION("Programme Code"))
            {
            }
            column(Programme_Stages_CodeCaption; FIELDCAPTION(Code))
            {
            }
            column(Programme_Stages_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Programme_Stages__Student_Registered_Caption; FIELDCAPTION("Student Registered"))
            {
            }
            column(Registered_Part_TimeCaption; Registered_Part_TimeCaptionLbl)
            {
            }
            column(Registered_Full_TimeCaption; Registered_Full_TimeCaptionLbl)
            {
            }
            column(Paid_Part_TimeCaption; Paid_Part_TimeCaptionLbl)
            {
            }
            column(Paid_Full_TimeCaption; Paid_Full_TimeCaptionLbl)
            {
            }
            column(Part_Time_BudgetCaption; Part_Time_BudgetCaptionLbl)
            {
            }
            column(varianceCaption; varianceCaptionLbl)
            {
            }
            column(Full_Time_BudgetCaption; Full_Time_BudgetCaptionLbl)
            {
            }
            column(Total_PaidCaption; Total_PaidCaptionLbl)
            {
            }
            column(Total_BudgetCaption; Total_BudgetCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(SUBTOTALCaption; SUBTOTALCaptionLbl)
            {
            }
            column(Total_StudentsCaption; Total_StudentsCaptionLbl)
            {
            }
            column(Programme_Stages_Registered; Registered)
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
                Programme.RESET;
                Programme.SETRANGE(Programme.Code, "Programme Code");
                Programme.SETFILTER(Programme."Semester Filter", GETFILTER("Semester Filter"));
                //////////////////////////////////////////////////////////////
                IF Programme.FIND('-') THEN BEGIN
                    Programme.CALCFIELDS(Programme."Student Registered");
                    Programme.CALCFIELDS(Programme."Registered Part Time");
                    Programme.CALCFIELDS(Programme."Paid Part Time");
                    Programme.CALCFIELDS(Programme."Registered Full Time");
                    Programme.CALCFIELDS(Programme."Paid Full Time");
                    Programme.CALCFIELDS(Programme."Full Time Budget");
                    Programme.CALCFIELDS(Programme."Part Time Budget");
                    StudReg := Programme."Student Registered";
                    StudRegPT := Programme."Registered Part Time";
                    PaidPT := Programme."Paid Part Time";
                    PaidFT := Programme."Paid Full Time";
                    StudRegFT := Programme."Registered Full Time";
                    PartBudget := Programme."Part Time Budget";
                    FullBudget := Programme."Full Time Budget";
                    PaidT := PaidPT + PaidFT;
                    Tbudget := PartBudget + FullBudget;
                    //percantage:=((PaidPT+PaidFT)/(Programme."Part Time Budget"+Programme."Full Time Budget"))/100;
                END;
                //"Programme Stages".CALCFIELDS("Programme Stages"."Student Registered");
                //TStudReg:="Programme Stages"."Student Registered";
                //TStudReg:=TStudReg+StudReg;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Programme Code");
                //TStudReg:=0;
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
        Programme: Record 61511;
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
        PaidT: Decimal;
        Tbudget: Decimal;
        GTbudget: Decimal;
        GPaidT: Decimal;
        Pdescription: Text[70];
        Progr: Record 61511;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        MASENOUNIVERSITY1CaptionLbl: Label 'MASENO UNIVERSITY';
        CLASS_REGISTRATION_SUMMARY___AS_AT_CaptionLbl: Label 'CLASS REGISTRATION SUMMARY - AS AT ';
        TIMECaptionLbl: Label 'TIME';
        Registered_Part_TimeCaptionLbl: Label 'Registered Part Time';
        Registered_Full_TimeCaptionLbl: Label 'Registered Full Time';
        Paid_Part_TimeCaptionLbl: Label 'Paid Part Time';
        Paid_Full_TimeCaptionLbl: Label 'Paid Full Time';
        Part_Time_BudgetCaptionLbl: Label 'Part Time Budget';
        varianceCaptionLbl: Label '%variance';
        Full_Time_BudgetCaptionLbl: Label 'Full Time Budget';
        Total_PaidCaptionLbl: Label 'Total Paid';
        Total_BudgetCaptionLbl: Label 'Total Budget';
        TotalCaptionLbl: Label 'Total';
        SUBTOTALCaptionLbl: Label 'SUBTOTAL';
        Total_StudentsCaptionLbl: Label 'Total Students';
}

