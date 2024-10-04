report 51484 "Summary Enrollment"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Summary Enrollment.rdl';

    dataset
    {
        dataitem("ACA-Programme"; "ACA-Programme")
        {
            DataItemTableView = SORTING(Code);
            RequestFilterFields = "Code", "Semester Filter", "Stage Filter", "Date Filter", Status;
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
            column(Programme_Code; Code)
            {
            }
            column(Programme_Description; Description)
            {
            }
            column(GETFILTER__Semester_Filter__; GETFILTER("Semester Filter"))
            {
            }
            column(GETFILTER__Date_Filter__; GETFILTER("Date Filter"))
            {
            }
            column(Programme__School_Code_; "School Code")
            {
            }
            column(Summary_EnrollmentCaption; Summary_EnrollmentCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Programme_CodeCaption; FIELDCAPTION(Code))
            {
            }
            column(Programme_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Semester_FilterCaption; Semester_FilterCaptionLbl)
            {
            }
            column(FilterCaption; FilterCaptionLbl)
            {
            }
            column(Programme__School_Code_Caption; FIELDCAPTION("School Code"))
            {
            }
            column(Programme_Stages_DescriptionCaption; "ACA-Programme Stages".FIELDCAPTION(Description))
            {
            }
            column(Programme_Stages_CodeCaption; "ACA-Programme Stages".FIELDCAPTION(Code))
            {
            }
            column(Total_RegisteredCaption; Total_RegisteredCaptionLbl)
            {
            }
            column(Programme_Stages__Registered_Full_Time_Caption; "ACA-Programme Stages".FIELDCAPTION("Registered Full Time"))
            {
            }
            column(Programme_Stages__Registered_Part_Time_Caption; "ACA-Programme Stages".FIELDCAPTION("Registered Part Time"))
            {
            }
            column(Programme_Stage_Filter; "Stage Filter")
            {
            }
            dataitem("ACA-Programme Stages"; "ACA-Programme Stages")
            {
                DataItemLink = "Programme Code" = FIELD(Code),
                               Code = FIELD("Stage Filter");
                RequestFilterFields = "Date Filter";
                column(Programme_Stages_Description; Description)
                {
                }
                column(Programme_Stages__Student_Registered_; "Student Registered")
                {
                }
                column(Programme_Stages_Code; Code)
                {
                }
                column(Programme_Stages__Registered_Full_Time_; "Registered Full Time")
                {
                }
                column(Programme_Stages__Registered_Part_Time_; "Registered Part Time")
                {
                }
                column(Programme_Stages_Programme_Code; "Programme Code")
                {
                }
                dataitem("ACA-Course Registration"; "ACA-Course Registration")
                {
                    DataItemLink = Programmes = FIELD("Programme Code"),
                                   Stage = FIELD(Code);
                    DataItemTableView = WHERE(Reversed = CONST(false));
                    RequestFilterFields = "Settlement Type";
                }

                trigger OnAfterGetRecord()
                begin
                    TotalIncome := TotalIncome + "ACA-Programme Stages"."Total Income";
                    TotalReg := TotalReg + "ACA-Programme Stages"."Student Registered";
                end;

                trigger OnPreDataItem()
                begin
                    "ACA-Programme Stages".SETFILTER("ACA-Programme Stages"."Semester Filter", "ACA-Programme".GETFILTER("ACA-Programme"."Semester Filter"));
                    "ACA-Programme Stages".SETFILTER("ACA-Programme Stages"."Date Filter", "ACA-Programme".GETFILTER("ACA-Programme"."Date Filter"));
                    //"Programme Stages".SETFILTER("Programme Stages".Status,Programme.GETFILTER(Programme.Status));
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TotalIncome := 0;
                TotalReg := 0;
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
        Sem: Text[250];
        Summary_EnrollmentCaptionLbl: Label 'Summary Enrollment';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Semester_FilterCaptionLbl: Label 'Semester Filter';
        FilterCaptionLbl: Label 'Filter';
        Total_RegisteredCaptionLbl: Label 'Total Registered';
}

