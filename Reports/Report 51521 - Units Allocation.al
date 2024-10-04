report 51521 "Units Allocation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Units Allocation.rdl';

    dataset
    {
        dataitem("ACA-Units/Subjects"; "ACA-Units/Subjects")
        {
            DataItemTableView = SORTING("Programme Code", "Stage Code", Code);
            RequestFilterFields = "Programme Code", "Stage Code", Allocation;
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
            column(Units_Subjects__Programme_Code_; "Programme Code")
            {
            }
            column(Units_Subjects__Stage_Code_; "Stage Code")
            {
            }
            column(Units_Subjects_Code; Code)
            {
            }
            column(Units_Subjects_Desription; Desription)
            {
            }
            column(RHours; RHours)
            {
            }
            column(Units_Subjects_Allocation; Allocation)
            {
            }
            column(RHours__Credit_Hours_; RHours - "Credit Hours")
            {
            }
            column(Units_Timetable_AllocationCaption; Units_Timetable_AllocationCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Units_Subjects__Programme_Code_Caption; FIELDCAPTION("Programme Code"))
            {
            }
            column(Units_Subjects__Stage_Code_Caption; FIELDCAPTION("Stage Code"))
            {
            }
            column(Units_Subjects_CodeCaption; FIELDCAPTION(Code))
            {
            }
            column(Units_Subjects_DesriptionCaption; FIELDCAPTION(Desription))
            {
            }
            column(Required_HoursCaption; Required_HoursCaptionLbl)
            {
            }
            column(Units_Subjects_AllocationCaption; FIELDCAPTION(Allocation))
            {
            }
            column(VarianceCaption; VarianceCaptionLbl)
            {
            }
            column(Units_Subjects_Entry_No; "Entry No")
            {
            }

            trigger OnAfterGetRecord()
            begin
                RHours := 0;

                IF GSetup.GET() THEN
                    RHours := GSetup."Max Hours Weekly";

                IF "ACA-Units/Subjects"."Normal Slots" <> 0 THEN
                    RHours := "ACA-Units/Subjects"."Normal Slots" + "ACA-Units/Subjects"."Lab Slots";
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
        RHours: Decimal;
        GSetup: Record 61534;
        Units_Timetable_AllocationCaptionLbl: Label 'Units Timetable Allocation';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Required_HoursCaptionLbl: Label 'Required Hours';
        VarianceCaptionLbl: Label 'Variance';
}

