/// <summary>
/// Report Detailed Enrollments1 (ID 51688).
/// </summary>
report 51688 "Detailed Enrollments1"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Detailed Enrollments1.rdl';

    dataset
    {
        dataitem(DataItem1410; 61511)
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
            column(Programme_Code; Code)
            {
            }
            column(Programme_Description; Description)
            {
            }
            column(Programme__Semester_Filter_; "Semester Filter")
            {
            }
            column(Programme__Date_Filter_; "Date Filter")
            {
            }
            column(Programme__School_Code_; "School Code")
            {
            }
            column(ProgrammeCaption; ProgrammeCaptionLbl)
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
            column(Programme__Semester_Filter_Caption; FIELDCAPTION("Semester Filter"))
            {
            }
            column(Programme__Date_Filter_Caption; FIELDCAPTION("Date Filter"))
            {
            }
            column(Programme__School_Code_Caption; FIELDCAPTION("School Code"))
            {
            }
            dataitem(DataItem3691; 61516)
            {
                DataItemLink = "Programme Code" = FIELD(Code);
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
                column(TotalReg; TotalReg)
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
                column(Programme_Stages__Registered_Full_Time_Caption; FIELDCAPTION("Registered Full Time"))
                {
                }
                column(Programme_Stages__Registered_Part_Time_Caption; FIELDCAPTION("Registered Part Time"))
                {
                }
                column(Programme_Stages_Programme_Code; "Programme Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    TotalIncome := TotalIncome + "Total Income";
                    TotalReg := TotalReg + "Student Registered";
                end;

                trigger OnPreDataItem()
                begin
                    SETFILTER("Semester Filter", GETFILTER("Semester Filter"));
                    SETFILTER("Date Filter", GETFILTER("Date Filter"));
                    SETFILTER(Status, GETFILTER(Status));
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
        Cust: Record 18;
        SName: Text[200];
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        ProgrammeCaptionLbl: Label 'Programme';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

