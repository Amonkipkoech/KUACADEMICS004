/// <summary>
/// Report Fees By Units (ID 51648).
/// </summary>
report 51648 "Fees By Units"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Fees By Units.rdl';

    dataset
    {
        dataitem(DataItem7267; 61524)
        {
            DataItemTableView = SORTING("Programme Code", "Stage Code", "Unit Code", Semester, "Student Type", "Settlemet Type", "Seq.");
            RequestFilterFields = "Programme Code", "Stage Code";
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
            column(Fee_By_Unit__Programme_Code_; "Programme Code")
            {
            }
            column(Fee_By_Unit__Stage_Code_; "Stage Code")
            {
            }
            column(Fee_By_Unit__Programme_Code__Control1000000014; "Programme Code")
            {
            }
            column(Fee_By_Unit__Stage_Code__Control1000000017; "Stage Code")
            {
            }
            column(Fee_By_Unit__Unit_Code_; "Unit Code")
            {
            }
            column(Fee_By_Unit__Settlemet_Type_; "Settlemet Type")
            {
            }
            column(Fee_By_Unit__Seq__; "Seq.")
            {
            }
            column(Fee_By_Unit__Break_Down_; "Break Down")
            {
            }
            column(Fee_By_Unit__Student_Type_; "Student Type")
            {
            }
            column(Fee_By_UnitCaption; Fee_By_UnitCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Fee_By_Unit__Programme_Code__Control1000000014Caption; FIELDCAPTION("Programme Code"))
            {
            }
            column(Fee_By_Unit__Stage_Code__Control1000000017Caption; FIELDCAPTION("Stage Code"))
            {
            }
            column(Fee_By_Unit__Unit_Code_Caption; FIELDCAPTION("Unit Code"))
            {
            }
            column(Fee_By_Unit__Settlemet_Type_Caption; FIELDCAPTION("Settlemet Type"))
            {
            }
            column(Fee_By_Unit__Seq__Caption; FIELDCAPTION("Seq."))
            {
            }
            column(Fee_By_Unit__Break_Down_Caption; FIELDCAPTION("Break Down"))
            {
            }
            column(Fee_By_Unit__Student_Type_Caption; FIELDCAPTION("Student Type"))
            {
            }
            column(Fee_By_Unit__Programme_Code_Caption; FIELDCAPTION("Programme Code"))
            {
            }
            column(Fee_By_Unit__Stage_Code_Caption; FIELDCAPTION("Stage Code"))
            {
            }
            column(Fee_By_Unit_Semester; Semester)
            {
            }

            trigger OnAfterGetRecord()
            begin
                FeesByUnit.INIT;
                FeesByUnit."Programme Code" := 'CPS';
                FeesByUnit."Stage Code" := "Stage Code";
                FeesByUnit."Unit Code" := "Unit Code";
                FeesByUnit.Semester := Semester;
                FeesByUnit."Student Type" := "Student Type";
                FeesByUnit."Settlemet Type" := "Settlemet Type";
                FeesByUnit."Seq." := "Seq.";
                FeesByUnit."Break Down" := "Break Down";
                FeesByUnit.Remarks := Remarks;
                FeesByUnit.INSERT;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Stage Code");
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
        FeesByUnit: Record 61524;
        Fee_By_UnitCaptionLbl: Label 'Fee By Unit';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

